library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

library hdl4fpga;
use hdl4fpga.std.all;

entity meter_display is
	generic (
		frac  : natural;
		dec   : natural;
		int   : natural);
	port (
		scale : in  std_logic_vector;
		value : in  std_logic_vector;
		fmtds : out std_logic_vector);
end;

architecture def of meter_display is
	signal bcd_sign : std_logic_vector(0 to 4-1);
	signal bcd_frac : std_logic_vector(0 to 4*dec-1);
	signal bcd_int  : std_logic_vector(0 to 4*int-1);
	signal fix      : std_logic_vector(signed_num_bits(5*2**(value'length-1))-1 downto 0);
begin

	fix2bcd : entity hdl4fpga.fix2bcd 
	generic map (
		frac => frac,
		spce => false)
	port map (
		fix      => fix,
		bcd_sign => bcd_sign,
		bcd_frac => bcd_frac,
		bcd_int  => bcd_int);

	scale_p : process (scale, value)
		variable aux : signed(fix'range);
	begin
		aux := resize(signed(value), aux'length);
		for i in 0 to 2**scale'length-1 loop
			if i=to_integer(unsigned(scale)) then
				case i mod 3 is
				when 1 => 
					aux := aux sll 1;
				when 2 =>
					aux := (aux sll 2) + (aux sll 0);
				when others => 
				end case;
			end if;
		end loop;
		fix <= std_logic_vector(aux);
	end process;

	fmt_p : process (scale, bcd_int, bcd_frac, bcd_sign)
		variable auxi : unsigned(0 to bcd_int'length+4*((9-1)/3)-1);
		variable auxf : unsigned(0 to bcd_frac'length-1);
		variable auxs : unsigned(fmtds'length-1 downto 0);
		constant i : natural := 2;
	begin
		fmtds <= (fmtds'range => '-');
		for i in 0 to 2**scale'length-1 loop
			auxs := (others => '0');
			auxi := resize(unsigned(bcd_int), auxi'length);
			auxf := unsigned(bcd_frac);

			for j in 0 to auxi'length/4-1 loop
				auxs := auxs sll 4;
				auxs(4-1 downto 0) := auxi(0 to 4-1);
				auxi := auxi sll 4;
			end loop;

			for j in 1 to ((i mod 9)/3) loop
				auxs := auxs sll 4;
				auxs(4-1 downto 0) := auxf(0 to 4-1);
				auxf := auxf sll 4;
			end loop;

			for j in 1 to auxs'length/4 loop
				if j /= auxs'length/4 then
					auxs := auxs rol 4;
					if auxs(4-1 downto 0)="0000" then
						auxs(4-1 downto 0) := "1111";
					else
						auxs := auxs ror 4;
						auxs(4-1 downto 0) := unsigned(bcd_sign);
						auxs := auxs rol (auxs'length-4*(j-1));
						exit;
					end if;
				else
					auxs(4-1 downto 0) := unsigned(bcd_sign);
					auxs := auxs rol 4;
				end if;
			end loop;

			if dec > ((i mod 9)/3) then
				auxs := auxs sll 4;
				auxs(4-1 downto 0) := unsigned'("1010");
			end if;

			for j in 0 to auxf'length/4-((i mod 9)/3)-1 loop
				auxs := auxs sll 4;
				auxs(4-1 downto 0) := auxf(0 to 4-1);
				auxf := auxf sll 4;
			end loop;

--			auxs := auxs rol 4;
--			auxs(4-1 downto 0) := unsigned(bcd_sign);
--			auxs := auxs ror 4;

			if i=to_integer(unsigned(scale)) then
				fmtds <= std_logic_vector(auxs);
			end if;
		end loop;
	end process;

end;
