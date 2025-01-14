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

library hdl4fpga;
use hdl4fpga.base.all;
use hdl4fpga.ipoepkg.all;

architecture ecp3versa_graphics of testbench is

	constant debug      : boolean := true;

	constant bank_bits  : natural := 3;
	constant addr_bits  : natural := 16;
	constant cols_bits  : natural := 9;
	constant data_bytes : natural := 2;
	constant byte_bits  : natural := 8;
	constant data_bits  : natural := byte_bits*data_bytes;

	signal reset        : std_logic;
	signal fpga_gsrn    : std_logic;
	signal xtal         : std_logic := '0';

	component ecp3versa
		generic (
			debug : boolean := false);
		port (
			clk         : in std_logic := 'Z';
	
			led         : out std_logic_vector(7 downto 0) := (others => 'Z');
			seg         : out std_logic_vector(0 to 14) := (others => 'Z');
			
			ddr3_clk    : out std_logic := '0';
			ddr3_rst    : out std_logic := '0';
			ddr3_cke    : out std_logic := '0';
			ddr3_cs     : out std_logic := '1';
			ddr3_ras    : out std_logic := '1';
			ddr3_cas    : out std_logic := '1';
			ddr3_we     : out std_logic := '1';
			ddr3_b      : out std_logic_vector( 2 downto 0) := (others => '1');
			ddr3_a      : out std_logic_vector(12 downto 0) := (others => '1');
			ddr3_dm     : inout std_logic_vector(2-1 downto 0) := (others => 'Z');
			ddr3_dqs    : inout std_logic_vector(2-1 downto 0) := (others => 'Z');
			ddr3_dq     : inout std_logic_vector(16-1 downto 0) := (others => 'Z');
			ddr3_odt    : out std_logic := '1';
	
	
			phy1_125clk : in  std_logic := '-';
			phy1_rst    : out std_logic;
			phy1_coma   : out std_logic := 'Z';
			phy1_mdio   : inout std_logic;
			phy1_mdc    : out std_logic;
			phy1_gtxclk : buffer std_logic;
			phy1_crs    : out std_logic;
			phy1_col    : out std_logic;
			phy1_txc    : out std_logic := '-';
			phy1_tx_d   : out std_logic_vector(0 to 8-1);
			phy1_tx_en  : out std_logic;
			phy1_rxc    : in  std_logic := '-';
			phy1_rx_er  : in  std_logic := '-';
			phy1_rx_dv  : in  std_logic := '-';
			phy1_rx_d   : in  std_logic_vector(0 to 8-1) := (others => '-');
	--
	--		phy2_125clk : in std_logic;
	--		phy2_rst    : out std_logic;
	--		phy2_coma   : out std_logic;
	--		phy2_mdio   : inout std_logic;
	--		phy2_mdc    : out std_logic;
	--		phy2_gtxclk : out std_logic;
	--		phy2_crs    : out std_logic;
	--		phy2_col    : out std_logic;
	--		phy2_txc    : out std_logic;
	--		phy2_tx_d   : out std_logic_vector(0 to 8-1);
	--		phy2_tx_en  : out std_logic;
	--		phy2_rxc    : in std_logic;
	--		phy2_rx_er  : in std_logic;
	--		phy2_rx_dv  : in std_logic;
	--		phy2_rx_d   : in std_logic_vector(0 to 8-1);
	
			expansionx4 : inout std_logic_vector(3 to 7);
			expansionx3 : inout std_logic_vector(4 to 8);
			fpga_gsrn   : in std_logic := '-');
	end component;

	constant snd_data : std_logic_vector := 
		x"01007e" &
		x"18ff"   &
		x"000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f" &
		x"202122232425262728292a2b2c2d2e2f303132333435363738393a3b3c3d3e3f" &
		x"404142434445464748494a4b4c4d4e4f505152535455565758595a5b5c5d5e5f" &
		x"606162636465666768696a6b6c6d6e6f707172737475767778797a7b7c7d7e7f" &
		x"808182838485868788898a8b8c8d8e8f909192939495969798999a9b9c9d9e9f" &
		x"a0a1a2a3a4a5a6a7a8a9aaabacadaeafb0b1b2b3b4b5b6b7b8b9babbbcbdbebf" &
		x"c0c1c2c3c4c5c6c7c8c9cacbcccdcecfd0d1d2d3d4d5d6d7d8d9dadbdcdddedf" &
		x"e0e1e2e3e4e5e6e7e8e9eaebecedeeeff0f1f2f3f4f5f6f7f8f9fafbfcfdfeff" &
		x"1702_0000ff_1603_0007_3000";
	constant req_data : std_logic_vector := x"010000_1702_00001f_1603_8007_3000";

	signal rst_n     : std_logic;
	signal cke       : std_logic;
	signal ddr_clk   : std_logic;
	signal ddr_clk_p : std_logic;
	signal ddr_clk_n : std_logic;
	signal cs_n      : std_logic;
	signal ras_n     : std_logic;
	signal cas_n     : std_logic;
	signal we_n      : std_logic;
	signal ba        : std_logic_vector(bank_bits-1 downto 0);
	signal addr      : std_logic_vector(addr_bits-1 downto 0) := (others => '0');
	signal dq        : std_logic_vector(data_bytes*byte_bits-1 downto 0) := (others => 'Z');
	signal dqs       : std_logic_vector(data_bytes-1 downto 0) := (others => 'Z');
	signal dqs_n     : std_logic_vector(dqs'range) := (others => 'Z');
	signal dm        : std_logic_vector(data_bytes-1 downto 0);
	signal odt       : std_logic;
	signal scl       : std_logic;
	signal sda       : std_logic;
	signal tdqs_n    : std_logic_vector(dqs'range);

	component ddr3_model is
		port (
			rst_n   : in    std_logic;
			ck      : in    std_logic;
			ck_n    : in    std_logic;
			cke     : in    std_logic;
			cs_n    : in    std_logic;
			ras_n   : in    std_logic;
			cas_n   : in    std_logic;
			we_n    : in    std_logic;
			ba      : in    std_logic_vector(3-1 downto 0);
			addr    : in    std_logic_vector(16-1 downto 0);
			dm_tdqs : in    std_logic_vector(2-1 downto 0);
			dq      : inout std_logic_vector(16-1 downto 0);
			dqs     : inout std_logic_vector(2-1 downto 0);
			dqs_n   : inout std_logic_vector(2-1 downto 0);
			tdqs_n  : inout std_logic_vector(2-1 downto 0);
			odt     : in std_logic);
	end component;

	signal phy1_125clk : std_logic := '0';

   	alias  mii_rxc  : std_logic is phy1_125clk;
   	signal mii_rxd  : std_logic_vector(0 to 8-1);
   	signal mii_rxdv : std_logic;

   	signal mii_txc  : std_logic;
   	signal mii_txd  : std_logic_vector(0 to 8-1);
   	signal mii_txen : std_logic;


	signal uart_clk : std_logic := '0';


begin

	reset       <= '1', '0' after 17 us when debug else '1', '0' after 4 us;
	xtal        <= not xtal after 5 ns;
	uart_clk    <= not uart_clk after 0.1 ns /2 when debug else not uart_clk after 12.5 ns;
	phy1_125clk <= not phy1_125clk after 4 ns;

	ipoe_b : block

		signal mii_req    : std_logic := '0';
    	signal ping_req   : std_logic := '0';
		signal mii_req1   : std_logic := '0';
		signal req         : std_logic;
		signal datarx_null :  std_logic_vector(mii_rxd'range);
		signal x : natural := 0;


	begin

    	process
    	begin
    		req <= '0';
    		wait for 10 us;
    		loop
    			if req='1' then
    				wait on mii_rxdv;
    				if falling_edge(mii_rxdv) then
    					req <= '0';
    					x <= x + 1;
    					wait for 12 us;
    				end if;
    			else
    				if x > 1 then
    					wait;
    				end if;
    				req <= '1';
    				wait on req;
    			end if;
    		end loop;
    	end process;
    	mii_req  <= req when x=0 else '0';
    	mii_req1 <= req when x=1 else '0';

		htb_e : entity hdl4fpga.eth_tb
		generic map (
			debug => false)
		port map (
			mii_data4 => snd_data,
			mii_data5 => req_data,
			mii_frm1  => '0', 
			mii_frm2  => '0', --mii_req1, -- ping
			mii_frm3  => '0', -- mii_req, -- arp'0',
			mii_frm4  => '0', --mii_req, -- write
			mii_frm5  => '0', --mii_req1, -- read
	
			mii_txc   => mii_rxc,
			mii_txen  => mii_rxdv,
			mii_txd   => mii_rxd);

		ethrx_e : entity hdl4fpga.eth_rx
		port map (
			dll_data   => datarx_null,
			mii_clk    => mii_txc,
			mii_frm    => mii_txen,
			mii_irdy   => mii_txen,
			mii_data   => mii_txd);

	end block;

	fpga_gsrn <= '1', '0' after 10 us;
	du_e : ecp3versa
	generic map (
		debug => debug)
	port map (
		clk         => xtal,
		fpga_gsrn   => fpga_gsrn,

		phy1_125clk => phy1_125clk,
		phy1_rxc    => mii_rxc,
		phy1_rx_dv  => mii_rxdv,
		phy1_rx_d   => mii_rxd,

		phy1_txc    => mii_txc,
		phy1_tx_en  => mii_txen,
		phy1_tx_d   => mii_txd,

		--         --
		-- DDR RAM --
		--         --

		ddr3_rst => rst_n,
		ddr3_clk => ddr_clk,
		ddr3_cs  => cs_n,
		ddr3_cke => cke,
		ddr3_ras => ras_n,
		ddr3_cas => cas_n,
		ddr3_we  => we_n,
		ddr3_b   => ba,
		ddr3_a   => addr(13-1 downto 0),
		ddr3_dqs => dqs,
		ddr3_dq  => dq,
		ddr3_dm  => dm,
		ddr3_odt => odt);

	ddr_clk_p <= ddr_clk;
	ddr_clk_n <= not ddr_clk;
	dqs_n <= not dqs;

	mt_u : ddr3_model
	port map (
		rst_n => rst_n,
		Ck    => ddr_clk_p,
		Ck_n  => ddr_clk_n,
		Cke   => cke,
		Cs_n  => cs_n,
		Ras_n => ras_n,
		Cas_n => cas_n,
		We_n  => we_n,
		Ba    => ba,
		Addr  => addr,
		Dm_tdqs => dm,
		Dq    => dq,
		Dqs   => dqs,
		Dqs_n => dqs_n,
		tdqs_n => tdqs_n,
		Odt   => odt);

end;

library micron;

configuration ecp3versa_graphic_structure_md of testbench is
	for ecp3versa_graphics
		for all : ecp3versa
			use entity work.ecp3versa(structure);
		end for;
		for all: ddr3_model
			use entity micron.ddr3
			port map (
				rst_n => rst_n,
				Ck    => ck,
				Ck_n  => ck_n,
				Cke   => cke,
				Cs_n  => cs_n,
				Ras_n => ras_n,
				Cas_n => cas_n,
				We_n  => we_n,
				Ba    => ba,
				Addr  => addr,
				Dm_tdqs  => dm,
				Dq    => dq,
				Dqs   => dqs,
				Dqs_n => dqs_n,
				tdqs_n => tdqs_n,
				Odt   => odt);
		end for;
	end for;
end;

library micron;

configuration ecp3versa_graphic_md of testbench is
	for ecp3versa_graphics
		for all : ecp3versa
			use entity work.ecp3versa(graphics);
		end for;
		for all: ddr3_model
			use entity micron.ddr3
			port map (
				rst_n => rst_n,
				Ck    => ck,
				Ck_n  => ck_n,
				Cke   => cke,
				Cs_n  => cs_n,
				Ras_n => ras_n,
				Cas_n => cas_n,
				We_n  => we_n,
				Ba    => ba,
				Addr  => addr,
				Dm_tdqs  => dm,
				Dq    => dq,
				Dqs   => dqs,
				Dqs_n => dqs_n,
				tdqs_n => tdqs_n,
				Odt   => odt);
		end for;
	end for;
end;
