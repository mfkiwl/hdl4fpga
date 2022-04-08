library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adjsto is
	generic (
		GEAR     : natural);
	port (
		tp       : out std_logic_vector(1 to 3);
		ddr_clk  : in std_logic;
		sys_req  : in std_logic;
		sys_rdy  : buffer std_logic;
		ddr_smp  : in std_logic_vector(0 to GEAR-1);
		ddr_sti  : in std_logic;
		ddr_sto  : buffer std_logic);
end;

library hdl4fpga;
use hdl4fpga.std.all;

architecture def of adjsto is

	constant bl     : natural := 8/2;
	signal sync     : std_logic;
	signal sel      : unsigned(0 to unsigned_num_bits(bl-1));

	signal step_req : std_logic;
	signal step_rdy : std_logic;

begin

	tp(1 to 3) <= std_logic_vector(sel);
	process (ddr_sti, sel, ddr_clk)
		variable delay : unsigned(0 to bl-1);
	begin
		if rising_edge(ddr_clk) then
			delay(0) := ddr_sti;
			delay    := rotate_left(delay,1);
		end if;
		ddr_sto <= word2byte(reverse(std_logic_vector(delay)), std_logic_vector(resize(sel,sel'length-1)));
	end process;

	 process (ddr_clk)
		variable start : std_logic;
		variable cntr  : unsigned(0 to unsigned_num_bits(GEAR/2-1));
		variable sto   : std_logic;
	begin
		if rising_edge(ddr_clk) then
			if to_bit(step_req xor step_rdy)='1' then
				if start='0' then
					sync   <= '1';
					cntr := to_unsigned(GEAR/2-1, cntr'length);
					if ddr_sto='0' then
						start := '1';
					end if;
				else
					if cntr(0)='1' then
						start    := '0';
						step_rdy <= step_req;
					elsif ddr_sto='1' then
						if ddr_smp/="0101" then
							sync  <= '0';
						end if;
					elsif sto='1' then
						cntr := cntr - 1;
					end if;
				end if;
			else
				start    := '0';
				step_rdy <= to_stdulogic(to_bit(step_req));
			end if;
			sto := ddr_sto;
		end if;
	end process;

	process (ddr_clk)
		variable start : std_logic;
	begin
		if rising_edge(ddr_clk) then
			if to_bit(sys_req xor sys_rdy)='1' then
				if start='0' then
					sel      <= (others => '0');
					start    := '1';
					step_req <= not to_stdulogic(to_bit(step_rdy));
				elsif start='1' then
					if sel(0)='0' then
						if to_bit(step_req xor step_rdy)='0' then
							if sync ='0' then
								sel      <= sel + 1;
								step_req <= not step_rdy;
							else
								sys_rdy <= to_stdulogic(to_bit(sys_req));
							end if;
						end if;
					else
						step_req <= to_stdulogic(to_bit(step_rdy));
						sys_rdy  <= to_stdulogic(to_bit(sys_req));
					end if;
				end if;
			else
				start   := '0';
				step_req <= to_stdulogic(to_bit(step_rdy));
				sys_rdy  <= to_stdulogic(to_bit(sys_req));
			end if;
		end if;
	end process;
end;
