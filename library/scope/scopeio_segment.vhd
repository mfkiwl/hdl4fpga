library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

library hdl4fpga;
use hdl4fpga.std.all;

entity scopeio_segment is
	generic(
		lat           : natural := 4;
		inputs        : natural);
	port (
		video_clk     : in  std_logic;
		video_hzl     : in  std_logic;
		win_frm       : in  std_logic_vector;
		win_on        : in  std_logic_vector;
		win_x         : in  std_logic_vector;
		win_y         : in  std_logic_vector;
		trigger_level : in  std_logic_vector;
		samples       : in  std_logic_vector;
		grid_dot      : out std_logic;
		trigger_dot   : out std_logic;
		traces_dots   : out std_logic_vector);
end;

architecture def of scopeio_segment is


	signal tracer_on  : std_logic;
	signal grid_on    : std_logic;

begin

	dondly_e : entity hdl4fpga.align
	generic map (
		n => 2,
		d => (0 => 0, 1 => 2+lat, 2 to 3 => 0))
	port map (
		clk   => video_clk,
		di(0) => win_on(0),
		di(1) => grid_on,
		do(0) => grid_on,
		do(1) => tracer_on);

	grid_e : entity hdl4fpga.scopeio_grid
	generic map (
		lat => lat)
	port map (
		clk  => video_clk,
		ena  => grid_on,
		x    => win_x,
		y    => win_y,
		dot  => grid_dot);

	trigger_e : entity hdl4fpga.scopeio_hline
	generic map (
		lat   => lat)
	port map (
		row => trigger_level,
		clk => video_clk,
		ena => grid_on,
		x   => win_x,
		y   => win_y,
		dot => trigger_dot);

	tracer_e : entity hdl4fpga.scopeio_tracer
	generic map (
		inputs  => inputs)
	port map (
		clk     => video_clk,
		ena     => tracer_on,
		y       => win_y,
		samples => samples,
		dots    => traces_dots);

end;
