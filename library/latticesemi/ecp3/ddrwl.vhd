library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ddrwl is
	port (
		clk : in  std_logic;
		req : in  std_logic;
		rdy : out std_logic;
		nxt : out std_logic;
		dg  : out std_logic_vector);
end;

library hdl4fpga;

architecture beh of ddrwl is
	signal aph_dg  : unsigned(0 to dg'length);
begin

	process (clk)
		variable cntr : unsigned(0 to 4-1);
	begin
		if rising_edge(clk) then
			if req='0' then
				aph_dg <= (0 => '1', others => '0');
				cntr   := (others => '0');
				nxt <= '0';
			elsif aph_dg(aph_dg'right)='0' then
				if cntr(0)='1' then
					aph_dg <= aph_dg srl 1;
					cntr := (others => '0');
				else
					cntr := cntr + 1;
				end if;
			end if;
			nxt <= cntr(0) and not aph_dg(aph_dg'right);
		end if;
	end process;

	dg  <= std_logic_vector(aph_dg(0 to dg'length-1));
	rdy <= aph_dg(aph_dg'right);

end;
