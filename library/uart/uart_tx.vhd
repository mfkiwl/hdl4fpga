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

entity uart_tx is
	generic (
		baudrate : natural := 115200;
		clk_rate : natural);
	port (
		uart_txc  : in  std_logic;
		uart_ena  : in  std_logic := '1';
		uart_sout : out std_logic;
		uart_trdy : out std_logic;
		uart_txdv : in  std_logic;
		uart_txd  : in  std_logic_vector(8-1 downto 0));
end uart_tx;
 
 
architecture def of uart_tx is
 
	type uart_states is (idle_s, start_s, data_s, stop_s);
	signal uart_state : uart_states;
 
	signal sample_rxd : std_logic;
	signal init_cntr  : std_logic;
	signal half_count : std_logic;
	signal full_count : std_logic;

begin
 
	cntr_p : process (uart_txc)
		constant max_count  : natural := (clk_rate+baudrate/2)/baudrate;
		variable tcntr      : unsigned(0 to unsigned_num_bits(max_count)-1);
		constant tcntr_init : unsigned := to_unsigned(1, tcntr'length);
	begin
		if rising_edge(uart_txc) then
			if uart_ena='1' then
				if init_cntr='1' then
					tcntr := tcntr_init;
					half_count <= '0';
					full_count <= '0';
				else
					tcntr := tcntr + 1;
					if ispower2(max_count) then
						half_count <= tcntr(1);
						full_count <= tcntr(0);
					else
						if tcntr >= max_count/2 then
							half_count <= '1';
						end if;
						if tcntr >= max_count then
							full_count <= '1';
						end if;
					end if;
				end if;
			end if;
		end if;
	end process;

	init_cntr <= 
		'1' when uart_state=idle_s  else
		'1' when uart_state=start_s and full_count='1' else
		'1' when uart_state=data_s  and full_count='1' else
		'1' when uart_state=stop_s  and full_count='1' else
		'0';

	state_p : process (uart_txc)

		variable dcntr      : unsigned(0 to 4-1);
		constant dcntr_init : unsigned := to_unsigned(1, dcntr'length);
		variable data       : unsigned(8-1 downto 0);

	begin
		if rising_edge(uart_txc) then
			if uart_ena='1' then
				case uart_state is
				when idle_s =>
					uart_sout <= '1';
					dcntr := (others => '-');
					data  := unsigned(uart_txd);
					if uart_txdv='1' then
						uart_sout  <= '0';
						uart_state <= start_s;
					end if;
				when start_s =>
					uart_sout <= '0';
					dcntr := dcntr_init;
					if full_count='1' then
						uart_state <= data_s;
						uart_sout  <= data(0);
						data := data ror 1;
					end if;
				when data_s =>
					if full_count='1' then
						uart_sout <= data(0);
						data := data ror 1;
						if dcntr(0)='1' then
							uart_state <= stop_s;
							dcntr := (others => '-');
						else
							dcntr := dcntr + 1;
						end if;
					end if;
				when stop_s =>
					uart_sout <= '1';
					data  := unsigned(uart_txd);
					dcntr := (others => '-');
					if full_count='1' then
						if uart_txdv='1' then
							uart_state <= start_s;
						else
							uart_state <= idle_s;
						end if;
					end if;
				end case;
			end if;
		end if;
	end process;

	uart_trdy <= 
		'1' when uart_state=idle_s else
		'1' when uart_state=stop_s and full_count='1' else
		'0';

end;