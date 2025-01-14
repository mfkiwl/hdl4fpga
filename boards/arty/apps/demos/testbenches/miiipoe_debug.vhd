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

use std.textio.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

library hdl4fpga;
use hdl4fpga.base.all;

architecture arty_miiipoedebug of testbench is

	signal rst   : std_logic := '1';
	signal clk   : std_logic := '1';
	signal ref_clk : std_logic;
	signal ref_clk1 : std_logic;
	signal eth_rx_dv : std_logic;
	signal eth_rxd : std_logic_vector(0 to 4-1);
	signal eth_tx_en : std_logic;
	signal eth_txd : std_logic_vector(0 to 4-1);

	signal btn0   : std_logic := '0';
	signal btn1   : std_logic := '0';
	signal ping_req   : std_logic := '0';
	signal datarx_null :  std_logic_vector(eth_txd'range);

begin

	clk  <= not clk after 5 ns;
	rst  <= '1', '0' after 1000 ns;
--	btn0 <= '0', '1' after 2000 ns;
	process
		variable n : natural := 0;
		variable s : natural range 0 to 3;
		variable b : boolean;
	begin
		if rst='0' then
			case s is
			when 0 =>
				btn1 <= '1' after 0.050 us;
				s := 1;
			when 1 =>
				btn1 <= '0' after 7.950 us;
				n := n + 1;
				if b=false then
					s := 2;
				else
					s := 0;
				end if;
				wait;
				s := 0;
			when 2 =>
				b := true;
				btn0 <= '1' after 0.050 us;
				s := 3;
			when 3 =>
				btn0 <= '0' after 6.550 us;
				s := 0;
				n := n + 1;
			end case;

			if n > 5 then
				wait;
			end if;
		else
			b := false;
		end if;
		wait on rst, btn1, btn0;
	end process;

	ping_req <= not rst;
	htb_e : entity hdl4fpga.eth_tb
	generic map (
		debug =>false)
	port map (
		mii_data4 => x"01007e_1702_00004f_1603_80ff_fff0",
		mii_frm1 => '0',
		mii_frm2 => ping_req,
		mii_frm3 => '0',
		mii_frm4 => '0',

		mii_txc  => ref_clk,
		mii_txen => eth_rx_dv,
		mii_txd  => eth_rxd);

	du_e : entity work.arty(miiipoe_debug)
	port map (
		resetn => rst,
		eth_tx_clk  => ref_clk ,
		eth_rx_clk  => ref_clk ,
		eth_ref_clk => ref_clk ,
		gclk100 => clk,
		eth_rx_dv => eth_rx_dv,
		eth_rxd => eth_rxd,
		eth_tx_en => eth_tx_en,
		eth_txd => eth_txd,
		sw => "0010",
		btn(0) => '0',
		btn(1) => '0', --btn1,
		btn(2) => btn1,
		btn(3) => '0'); --btn1);

	ref_clk1 <= ref_clk;
	ethrx_e : entity hdl4fpga.eth_rx
	port map (
		dll_data   => datarx_null,
		mii_clk    => ref_clk1,
		mii_frm    => eth_tx_en,
		mii_irdy   => eth_tx_en,
		mii_data   => eth_txd);


end;
