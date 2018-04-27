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

library unisim;
use unisim.vcomponents.all;

architecture miitx_dhcp of arty is
	signal sys_clk        : std_logic;
	signal mii_treq       : std_logic;
	signal eth_txclk_bufg : std_logic;

	signal video_clk      : std_logic;
	signal video_hs         : std_logic;
	signal video_vs         : std_logic;
	signal video_frm        : std_logic;
	signal video_hon        : std_logic;
	signal video_nhl        : std_logic;
	signal video_vld        : std_logic;
	signal video_vcntr      : std_logic_vector(11-1 downto 0);
	signal video_hcntr      : std_logic_vector(11-1 downto 0);
begin

	clkin_ibufg : ibufg
	port map (
		I => gclk100,
		O => sys_clk);

	video_dcm_e : entity hdl4fpga.dfs
	generic map (
		dcm_per => 10.0;
		dfs_div => 2;
		dfs_mul => 3)
	port map (
		dcm_rst => '0',
		dcm_clk => sys_clk,
		dfs_clk => video_clk,
		dcm_lck => open);

	video_e : entity hdl4fpga.video_vga
	generic map (
		mode => 7,
		n    => 11)
	port map (
		clk   => video_clk,
		hsync => video_hs,
		vsync => video_vs,
		hcntr => video_hcntr,
		vcntr => video_vcntr,
		don   => video_hon,
		frm   => video_frm,
		nhl   => video_nhl);

	vram : entity hdl4fpga.dpram
	port map (
		wr_clk  => eth_rxclk_bufg,
		wr_ena  => eth_rx_en,
		wr_addr => 
		wr_data => eth_rxd,
		rd_addr =>
		rd_data => cga_code);

	font_addr <= cga_code & video_vcntr();
	cgarom : entity hdl4fpga.rom
	generic map (
		synchronous => 2,
		bitrom => psf1hex8x16)
	port map (
		clk  => video_clk,
		addr => font_addr,
		data => font_line);
	video_dot <= word2byte (font_line, video_hcntr());


	process (sys_clk)
		variable div : unsigned(0 to 1) := (others => '0');
	begin
		if rising_edge(sys_clk) then
			div := div + 1;
			eth_ref_clk <= div(0);
		end if;
	end process;

	eth_tx_clk_ibufg : ibufg
	port map (
		I => eth_tx_clk,
		O => eth_txclk_bufg);

	process (btn(0), eth_txclk_bufg)
	begin
		if btn(0)='1' then
			mii_treq <= '0';
		elsif rising_edge(eth_txclk_bufg) then
			mii_treq <= '1';
		end if;
	end process;

	du : entity hdl4fpga.miitx_dhcp
	port map (
        mii_txc  => eth_txclk_bufg,
		mii_treq => mii_treq,
		mii_trdy => led(0),
		mii_txdv => eth_tx_en,
		mii_txd  => eth_txd);

	eth_rstn <= '1';
	eth_mdc  <= '0';
	eth_mdio <= '0';
end;
