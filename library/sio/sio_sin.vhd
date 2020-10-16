library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library hdl4fpga;
use hdl4fpga.std.all;

entity sio_sin is
	port (
		sin_clk   : in  std_logic;
		sin_frm   : in  std_logic;
		sin_irdy  : in  std_logic := '1';
		sin_data  : in  std_logic_vector;
		
		data_frm  : out std_logic;
		data_irdy : out std_logic;
		data_ptr  : out std_logic_vector(8-1 downto 0);

		rgtr_id   : out std_logic_vector;
		rgtr_dv   : out std_logic;
		rgtr_data : out std_logic_vector);
end;

architecture beh of sio_sin is
	subtype octect is std_logic_vector(8-1 downto 0);

	signal ser_data  : std_logic_vector(sin_data'range);
	signal des8_irdy : std_logic;
	signal des8_data : octect;

	type states is (s_id, s_size, s_data);
	signal state : states;

begin

	byte_e : entity hdl4fpga.serdes
	port map (
		serdes_clk => sin_clk,
		serdes_frm => sin_frm,
		ser_irdy   => sin_irdy,
		ser_data   => sin_data,

		des_irdy   => des8_irdy,
		des_data   => des8_data);

	process (sin_clk)
		variable rid   : octect;
		variable len   : unsigned(0 to octect'length);
		variable data  : unsigned(rgtr_data'length-1 downto 0);
		variable ptr   : unsigned(octect'range);
	begin
		if rising_edge(sin_clk) then
			if sin_frm='0' then
				ptr   := (others => '0');
				rid   := (others => '-');
				len   := (others => '0');
				state <= s_id;
			elsif des8_irdy='1' then
				case state is
				when s_id =>
					ptr   := (others => '0');
					rid   := des8_data;
					len   := (others => '0');
					state <= s_size;
				when s_size =>
					ptr   := (others => '0');
					len   := resize(unsigned(des8_data), len'length);
					state <= s_data;
				when s_data =>
					ptr  := ptr + 1;
					len  := len - 1;
					data := data sll des8_data'length;
					data(des8_data'range) := unsigned(des8_data);
					if len(0)='1' then
						state <= s_id;
					else
						state <= s_data;
					end if;
				end case;
			end if;
			rgtr_id   <= rid(rgtr_id'length-1 downto 0);
			rgtr_dv   <= len(0) and des8_irdy;
			rgtr_data <= std_logic_vector(data);

			data_frm  <= setif(state=s_data);
			data_irdy <= des8_irdy and setif(state=s_data);
			data_ptr  <= std_logic_vector(ptr);
		end if;
	end process;

end;