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
use hdl4fpga.base.all;
use hdl4fpga.videopkg.all;
use hdl4fpga.cgafonts.all;

library unisim;
use unisim.vcomponents.all;

architecture miiipoe_debug of arty is

	constant sys_freq : real := 100.0e6;

	type video_params is record
		timing_id : videotiming_ids;
		dcm_mul   : natural;
		dcm_div   : natural;
	end record;

	type video_modes is (
		mode480p,
		mode600p,
		mode1080p);

	type videoparams_vector is array (video_modes) of video_params;
	constant video_tab : videoparams_vector := (
		mode480p  => (timing_id => pclk25_00m640x480at60,    dcm_mul =>  6, dcm_div => 24),
		mode600p  => (timing_id => pclk40_00m800x600at60,    dcm_mul =>  6, dcm_div => 15),
		mode1080p => (timing_id => pclk140_00m1920x1080at60, dcm_mul => 12, dcm_div => 8));

	constant video_mode    : video_modes := mode600p;
	constant videodot_freq : natural := (video_tab(video_mode).dcm_mul*natural(sys_freq))/(video_tab(video_mode).dcm_div);

	alias  sys_clk        : std_logic is gclk100;
	signal video_clk      : std_logic;
	signal video_lckd     : std_logic;
	signal video_hs       : std_logic;
	signal video_vs       : std_logic;
	signal video_pixel    : std_logic_vector(3-1 downto 0);

	signal miirx_frm      : std_ulogic;
	signal miirx_irdy     : std_logic;
	signal miirx_trdy     : std_logic;
	signal miirx_data     : std_logic_vector(0 to 8-1);

	signal miitx_frm      : std_logic;
	signal miitx_irdy     : std_logic;
	signal miitx_trdy     : std_logic;
	signal miitx_end      : std_logic;
	signal miitx_data     : std_logic_vector(miirx_data'range);

	signal sin_clk        : std_logic;
	signal sin_frm        : std_logic;
	signal sin_irdy       : std_logic;
	signal sin_data       : std_logic_vector(miitx_data'range);
--	signal sin_data       : std_logic_vector(eth_rxd'range);
	signal sout_frm       : std_logic;
	signal sout_irdy      : std_logic;
	signal sout_trdy      : std_logic;
	signal sout_data      : std_logic_vector(0 to 8-1);

	signal tp  : std_logic_vector(1 to 32);
	signal tp1  : std_logic_vector(1 to 32);
	alias data : std_logic_vector(0 to 8-1) is tp(3 to 3+8-1);

	signal vbtn2 : std_logic_vector(2-1 downto 0);
	signal vbtn3 : std_logic_vector(2-1 downto 0);
	signal myhwa_vld : std_logic;
	-----------------
	-- Select link --
	-----------------

	constant io_hdlc : natural := 0;
	constant io_ipoe : natural := 1;

	constant io_link : natural := io_hdlc;

	constant mem_size  : natural := 8*(1024*8);

begin

	process (sys_clk)
		variable div : unsigned(0 to 1) := (others => '0');
	begin
		if rising_edge(sys_clk) then
			div := div + 1;
			eth_ref_clk <= div(0);
		end if;
	end process;

	dcm_b : block
		signal video_clkfb : std_logic;
	begin
		video_dcm_i : mmcme2_base
		generic map (
			clkin1_period    => 10.0,
			clkfbout_mult_f  => real(video_tab(video_mode).dcm_mul),
			clkout0_divide_f => real(video_tab(video_mode).dcm_div),
			bandwidth        => "LOW")
		port map (
			pwrdwn   => '0',
			rst      => '0',
			clkin1   => sys_clk,
			clkfbin  => video_clkfb,
			clkfbout => video_clkfb,
			locked   => video_lckd,
			clkout0  => video_clk);
	end block;

	ipoe_b : block
		alias  mii_rxc    : std_logic is eth_rx_clk;
		alias  mii_txc    : std_logic is eth_tx_clk;
		signal mii_txen   : std_logic;
		signal mii_rxd    : std_logic_vector(eth_rxd'range);
		signal mii_txd    : std_logic_vector(eth_rxd'range);

		signal mii_frm    : std_ulogic;
		signal plrx_frm   : std_logic := '0';
		signal plrx_irdy  : std_logic := '0';
		signal plrx_trdy  : std_logic := '0';
		signal plrx_data  : std_logic_vector(miirx_data'range);

		signal so_frm     : std_logic;
		signal so_irdy    : std_logic;
		signal so_trdy    : std_logic := '1';
		signal so_data    : std_logic_vector(miirx_data'range);

		signal pltx_frm   : std_logic;
		signal pltx_irdy  : std_logic;
		signal pltx_trdy  : std_ulogic;
		signal pltx_end   : std_logic;
		signal pltx_data  : std_logic_vector(miirx_data'range);

		signal si_frm     : std_logic;
		signal si_irdy    : std_logic;
		signal si_trdy    : std_logic;
		signal si_end     : std_logic;
		signal si_data    : std_logic_vector(miirx_data'range);

		signal dhcpcd_req : std_logic;
		signal dhcpcd_rdy : std_logic;

		signal si_req : bit;
		signal si_rdy : bit;
		constant txpkt  : std_logic_vector := reverse(
			x"ff_ff_ff_ff_ff_ff" &  -- Destination MAC address
			x"ff_ff_ff_ff"       &  -- Destination IP address
			x"dea9"              &  -- UDP source port
			x"de00"              &  -- UDP destination port
			reverse(x"0001")     &  -- Payload length
			x"77",8);

		signal hxdv   : std_logic;
		signal hxd    : std_logic_vector(eth_rxd'range);

	begin

		htb_e : entity hdl4fpga.eth_tb
		port map (
			mii_frm1 => '0',
			mii_frm2 => '0',
			mii_frm3 => '0',
			mii_frm4 => vbtn2(1),

			mii_txc  => mii_rxc,
			mii_txen => hxdv,
			mii_txd  => hxd);

		with sw(2) select
		vbtn2 <=
			btn(2) & "0"    when '1',
			"0"    & btn(2) when others;

		with sw(2) select
		vbtn3 <=
			btn(3) & "0"    when '1',
			"0"    & btn(3) when others;

		process(mii_txc)
		begin
			if rising_edge(mii_txc) then
				if si_frm='0' then
					si_req <= si_rdy xor ((to_bit(vbtn3(0)) and si_rdy) or (to_bit(vbtn2(0)) and not si_rdy));
				elsif (si_trdy and si_end)='1' then
					si_rdy <= si_req;
				end if;
			end if;
		end process;
		si_frm <= to_stdulogic(si_req xor si_rdy);

		eth2_e: entity hdl4fpga.sio_mux
		port map (
			mux_data => txpkt,
			sio_clk  => mii_txc,
			sio_frm  => si_frm,
			sio_irdy => si_trdy,
			sio_trdy => si_irdy,
			so_end   => si_end,
			so_data  => si_data);

		sync_b : block
			signal rxc_rxbus : std_logic_vector(0 to mii_rxd'length);
			signal txc_rxbus : std_logic_vector(0 to mii_rxd'length);
			signal dst_irdy  : std_logic;
			signal dst_trdy  : std_logic;
		begin

			process (sw(0), hxdv, hxd, mii_rxc)
				variable q : std_logic_vector(rxc_rxbus'range);
			begin
				if rising_edge(mii_rxc) then
					q := eth_rx_dv & eth_rxd;
				end if;
				case sw(0) is
				when '1' =>
					rxc_rxbus <= hxdv & hxd;
				when others =>
					rxc_rxbus <= q;
				end case;
			end process;

			rxc2txc_e : entity hdl4fpga.fifo
			generic map (
				max_depth => 4,
				latency   => 0,
				dst_offset => 0,
				src_offset => 2,
				check_sov => false,
				check_dov => true,
				gray_code => false)
			port map (
				src_clk  => mii_rxc,
				src_data => rxc_rxbus,
				dst_clk  => mii_txc,
				dst_irdy => dst_irdy,
				dst_trdy => dst_trdy,
				dst_data => txc_rxbus);

			process (mii_txc)
			begin
				if rising_edge(mii_txc) then
					dst_trdy <= to_stdulogic(to_bit(dst_irdy));
				end if;
			end process;
			mii_frm <= txc_rxbus(0);
			mii_rxd <= txc_rxbus(1 to mii_rxd'length);

		end block;

		serdes_e : entity hdl4fpga.serdes
		port map (
			serdes_clk => mii_txc,
			serdes_frm => mii_frm,
			ser_irdy   => '1',
			ser_trdy   => open,
			ser_data   => mii_rxd,

			des_frm    => miirx_frm,
			des_irdy   => miirx_irdy,
			des_trdy   => miirx_trdy,
			des_data   => miirx_data);

		process(mii_txc)
		begin
			if rising_edge(mii_txc) then
				if to_bit(dhcpcd_req xor dhcpcd_rdy)='0' then
					dhcpcd_req <= dhcpcd_rdy xor ((btn(1) and dhcpcd_rdy) or (btn(0) and not dhcpcd_rdy));
				end if;
			end if;
		end process;

		du_e : entity hdl4fpga.mii_ipoe
		generic map (
    		my_mac        => x"00_40_00_01_02_03",
			default_ipv4a => x"c0_a8_00_0e")
		port map (
			tp => tp,
			mii_clk    => mii_txc,
			dhcpcd_req => dhcpcd_req,
			dhcpcd_rdy => dhcpcd_rdy,
			miirx_frm  => miirx_frm,
			miirx_irdy => miirx_irdy,
			miirx_trdy => miirx_trdy,
			miirx_data => miirx_data,
			myhwa_vld  => myhwa_vld,

			plrx_frm   => plrx_frm,
			plrx_irdy  => plrx_irdy,
			plrx_trdy  => plrx_trdy,
			plrx_data  => plrx_data,

			pltx_frm   => pltx_frm,
			pltx_irdy  => pltx_irdy,
			pltx_trdy  => pltx_trdy,
			pltx_end   => pltx_end,
			pltx_data  => pltx_data,

			miitx_frm  => miitx_frm,
			miitx_irdy => miitx_irdy,
			miitx_trdy => miitx_trdy,
			miitx_end  => miitx_end,
			miitx_data => miitx_data);

		sioflow_e : entity hdl4fpga.sio_flow
		port map (
			tp => tp1,
			sio_clk => mii_txc,

			rx_frm  => plrx_frm,
			rx_irdy => plrx_irdy,
			rx_trdy => plrx_trdy,
			rx_data => plrx_data,

			so_frm  => so_frm,
			so_irdy => so_irdy,
			so_trdy => so_trdy,
			so_data => so_data,

			si_frm  => si_frm,
			si_irdy => si_irdy,
			si_trdy => si_trdy,
			si_end  => si_end,
			si_data => si_data,

			tx_frm  => pltx_frm,
			tx_irdy => pltx_irdy,
			tx_trdy => pltx_trdy,
			tx_end  => pltx_end,
			tx_data => pltx_data);

		desser_e: entity hdl4fpga.desser
		port map (
			desser_clk => mii_txc,

			des_frm    => miitx_frm,
			des_irdy   => miitx_irdy,
			des_trdy   => miitx_trdy,
			des_data   => miitx_data,

			ser_irdy   => open,
			ser_data   => mii_txd);

		mii_txen  <= miitx_frm and not miitx_end;

		process(mii_txc)
			variable en : std_logic;
			variable d  : std_logic_vector(mii_txd'range);
		begin
			if rising_edge(mii_txc) then
				eth_tx_en <= en;
				eth_txd   <= d;
				en := mii_txen;
				d  := mii_txd;
			end if;
		end process;

		sin_clk   <= mii_txc;
--		sin_irdy  <= '1';
--		sin_frm   <= mii_txen when sw(1)='0' else tp(1)   when vbtn3(1)='0' else miirx_frm;
--		sin_data  <= mii_txd  when sw(1)='0' else mii_rxd when vbtn3(1)='0' else mii_rxd;;

		sin_frm   <=
--			plrx_frm  when sw(3)='1'    else
			so_frm    when sw(3)='1'    else
			miitx_frm when sw(1)='0'    else
			myhwa_vld when vbtn3(1)='0' else
			miirx_frm;

		sin_irdy  <=
--			plrx_irdy  and plrx_trdy  when sw(3)='1' else
			so_irdy    and so_trdy  when sw(3)='1' else
			miitx_irdy and miitx_trdy when sw(1)='0' else
			miirx_irdy and miirx_trdy;

		sin_data  <=
--			plrx_data  when sw(3)='1' else
			so_data    when sw(3)='1' else
			miitx_data when sw(1)='0' else
			miirx_data;

	end block;

	led(3) <= tp1(4);
	led(2) <= tp1(3);
	led(0) <= tp1(1);
	led(1) <= tp1(2);
	ser_debug_e : entity hdl4fpga.ser_debug
	generic map (
		timing_id    => video_tab(video_mode).timing_id,
		red_length   => 1,
		green_length => 1,
		blue_length  => 1)
	port map (
		ser_clk      => sin_clk,
		ser_frm      => sin_frm,
		ser_irdy     => sin_irdy,
		ser_data     => sin_data,

		video_clk    => video_clk,
		video_hzsync => video_hs,
		video_vtsync => video_vs,
		video_pixel  => video_pixel);

	process (video_clk)
	begin
		if rising_edge(video_clk) then
			ja(1)  <= video_pixel(2);
			ja(2)  <= video_pixel(1);
			ja(3)  <= video_pixel(0);
			ja(4)  <= video_hs;
			ja(10) <= video_vs;
		end if;
	end process;

	ddr3_clk_obufds : obufds
	generic map (
		iostandard => "DIFF_SSTL135")
	port map (
		i  => '0',
		o  => ddr3_clk_p,
		ob => ddr3_clk_n);

	eth_rstn <= video_lckd;
	eth_mdc  <= '0';
	eth_mdio <= '0';

end;
