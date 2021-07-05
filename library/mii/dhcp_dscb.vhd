--                                                                            --
-- Author(s):                                                                 --
--   Miguel Angel Sagreras                                                    --
--                                                                            --
-- Copyright (C) 2015                                                         --
--    Miguel Angel Sagreras                                                   --
--                                                                            --
-- This source file may be used and distributed without restriction provided  --
-- that this copyright statement is not removed from the file and that any    --
-- derivative work contains  the original copyright notice and the associated --
-- disclaimer.                                                                --
--                                                                            --
-- This source file is free software; you can redistribute it and/or modify   --
-- it under the terms of the GNU General Public License as published by the   --
-- Free Software Foundation, either version 3 of the License, or (at your     --
-- option) any later version.                                                 --
--                                                                            --
-- This source is distributed in the hope that it will be useful, but WITHOUT --
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or      --
-- FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for   --
-- more details at http://www.gnu.org/licenses/.                              --
--                                                                            --

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library hdl4fpga;
use hdl4fpga.std.all;
use hdl4fpga.ethpkg.all;
use hdl4fpga.ipoepkg.all;

entity dhcpc_dscb is
	generic (
		dhcp_sp   : std_logic_vector(0 to 16-1)  := x"0044";
		dhcp_dp   : std_logic_vector(0 to 16-1)  := x"0043";
		dhcp_mac  : std_logic_vector(0 to 6*8-1) := x"00_40_00_01_02_03");
	port (
		mii_clk       : in  std_logic;
		dhcpdscb_frm  : in  std_logic;
		dlltx_full    : in  std_logic;
		nettx_full    : in  std_logic;

		dhcpdscb_irdy : in  std_logic;
		dhcpdscb_trdy : out std_logic;
		dhcpdscb_end  : out std_logic;
		dhcpdscb_data : out std_logic_vector);
end;

architecture def of dhcpc_dscb is

	constant payload_size : natural := 250;

	constant vendor_data : std_logic_vector := 
		x"350101"       &    -- DHCPDISCOVER
		x"320400000000" &    -- IP REQUEST
		x"FF";               -- END

	constant dhcp_pkt : std_logic_vector :=
		udp_checksummed (
			x"00000000",
			x"ffffffff",
			dhcp_sp      &    -- UDP Source port
			dhcp_dp      &    -- UDP Destination port
			std_logic_vector(to_unsigned(payload_size+8,16)) & -- UDP Length,
			x"0000"      &	  -- UDP CHECKSUM
			x"01010600"  &    -- OP, HTYPE, HLEN,  HOPS
			x"3903f326"  &    -- XID
			dhcp_mac     &    -- CHADDR  
			x"63825363"  &    -- MAGIC COOKIE
			vendor_data);

	signal dhcppkt_irdy : std_logic;
	signal dhcppkt_trdy : std_logic;
	signal dhcppkt_end  : std_logic;
	signal dhcppkt_data : std_logic_vector(dhcpdscb_data'range);

	constant dhcp_vendor : natural := dhcp4hdr_frame'right+1;
	constant dscb_frame  : natural_vector(udp4hdr_frame'left to dhcp_vendor) := udp4hdr_frame & dhcp4hdr_frame & (
		dhcp_vendor => vendor_data'length);

	signal dhcpdscb_ptr  : std_logic_vector(0 to unsigned_num_bits((payload_size+8)*8/dhcpdscb_data'length-1));

	signal udplentx_irdy : std_logic;
	signal udplentx_trdy : std_logic;
	signal udplentx_end  : std_logic;
	signal udplentx_data : std_logic_vector(dhcpdscb_data'range);

begin

	process (mii_clk)
		variable cntr : unsigned(dhcpdscb_ptr'range);
	begin
		if rising_edge(mii_clk) then
			if dhcpdscb_frm='0' then
				cntr := (others => '0');
				dhcpdscb_end <= '0';
			elsif dhcpdscb_irdy='1' and nettx_full='1' then
				if cntr < (payload_size+8) then
					cntr := cntr + 1;
					dhcpdscb_end <= '0';
				else
					dhcpdscb_end <= '1';
				end if;
			end if;
			dhcpdscb_ptr <= std_logic_vector(cntr);
		end if;
	end process;

	udplentx_irdy <= 
		'0' when dlltx_full='0' else
		'1' when nettx_full='0' else
		'0';

	dhcpudplen_e : entity hdl4fpga.sio_mux
	port map (
		mux_data => std_logic_vector(to_unsigned(payload_size+8, 16)),
		sio_clk  => mii_clk,
		sio_frm  => dhcpdscb_frm,
		sio_irdy => udplentx_irdy,
		sio_trdy => udplentx_trdy,
		so_end   => udplentx_end,
		so_data  => udplentx_data);

	dhcppkt_irdy <= '0' when nettx_full='1' else dhcpdscb_frm and dhcpdscb_irdy and frame_decode(dhcpdscb_ptr, dscb_frame, dhcpdscb_data'length, (
		udp4_sp, udp4_dp, udp4_len, udp4_cksm, 
		dhcp4_op, dhcp4_htype, dhcp4_hlen, dhcp4_hops, 
		dhcp4_xid, 
		dhcp4_chaddr6,
		dhcp4_cookie,
		dhcp_vendor));

	dhcppkt_e : entity hdl4fpga.sio_mux
	port map (
		mux_data => reverse(dhcp_pkt,8),
        sio_clk  => mii_clk,
		sio_frm  => dhcpdscb_frm,
		sio_irdy => dhcppkt_irdy,
        sio_trdy => dhcpdscb_trdy,
        so_end   => dhcppkt_end,
        so_data  => dhcppkt_data);

	dhcpdscb_data <= 
		(dhcpdscb_data'range => '1') when dlltx_full='0' else
		udplentx_data                when udplentx_end='0' else
		(dhcpdscb_data'range => '1') when nettx_full='0' else
		dhcppkt_data;

end;
