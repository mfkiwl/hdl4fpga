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

architecture ulx4mls_graphics of testbench is

	constant bank_bits  : natural := 2;
	constant addr_bits  : natural := 13;
	constant cols_bits  : natural := 9;
	constant data_bytes : natural := 2;
	constant byte_bits  : natural := 8;
	constant data_bits  : natural := byte_bits*data_bytes;

	signal rst         : std_logic;
	signal xtal        : std_logic := '0';

	signal sdram_dq    : std_logic_vector (data_bits - 1 downto 0) := (others => 'Z');
	signal sdram_addr  : std_logic_vector (addr_bits - 1 downto 0);
	signal sdram_ba    : std_logic_vector (1 downto 0);
	signal sdram_clk   : std_logic := '0';
	signal sdram_cke   : std_logic := '1';
	signal sdram_cs_n  : std_logic := '1';
	signal sdram_ras_n : std_logic;
	signal sdram_cas_n : std_logic;
	signal sdram_we_n  : std_logic;
	signal sdram_dqm   : std_logic_vector(1 downto 0);


	signal mii_refclk  : std_logic;

	signal mii_clk     : std_logic;
	signal mii_txen    : std_logic;
	signal mii_txd     : std_logic_vector(0 to 2-1);
	signal mii_rxdv    : std_logic;
	signal mii_rxd     : std_logic_vector(0 to 2-1);

	signal ftdi_txd    : std_logic;
	signal ftdi_rxd    : std_logic;

	signal fire1       : std_logic;
	signal fire2       : std_logic;


	component ulx4m_ls is
		generic (
			debug  : boolean := true);
    	port (

    		clk_25mhz       : in  std_logic := 'Z';
    		btn             : in  std_logic_vector(0 to 7-1) := (others => '-');
    		led             : out std_logic_vector(8-1 downto 0) := (others => 'Z');

    		sd_clk          : out  std_logic := '-';
    		sd_cmd          : out std_logic; -- sd_cmd=MOSI (out)
    		sd_d            : inout std_logic_vector(4-1 downto 0) := (others => 'U'); -- sd_d(0)=MISO (in), sd_d(3)=CSn (out)
    		sd_wp           : in  std_logic := '-';
    		sd_cdn          : in  std_logic := '-'; -- card detect not connected

    		usb_fpga_d      : inout std_logic := 'Z';
    		usb_fpga_bd_dp  : inout std_logic := 'Z';
    		usb_fpga_bd_dn  : inout std_logic := 'Z';
    		usb_fpga_pu_dp  : inout std_logic := 'Z';
    		usb_fpga_pu_dn  : inout std_logic := 'Z';
    		usb_fpga_otg_dp : inout std_logic := 'Z';
    		usb_fpga_otg_dn : inout std_logic := 'Z';
    		n_extrst        : inout std_logic := 'Z';

    		eth_nreset      : out std_logic;
    		eth_mdio        : inout std_logic := '-';
    		eth_mdc         : out std_logic;

			rmii_refclk    : out std_logic;
			rmii_nintclk   : in std_logic := '-';
			rmii_txen      : buffer std_logic;
			rmii_txd       : buffer std_logic_vector(0 to 2-1) := (others => 'Z');
			rmii_rxdv      : in  std_logic := '0';
			rmii_rxd       : in  std_logic_vector(0 to 2-1) := (others => '-');

    		sdram_clk      : inout std_logic;  
    		sdram_cke      : out   std_logic;
    		sdram_csn      : out   std_logic;
    		sdram_wen      : out   std_logic;
    		sdram_rasn     : out   std_logic;
    		sdram_casn     : out   std_logic;
    		sdram_a        : out   std_logic_vector(13-1 downto 0);
    		sdram_ba       : out   std_logic_vector(2-1 downto 0);
    		sdram_dqm      : inout std_logic_vector(2-1 downto 0) := (others => 'U');
    		sdram_d        : inout std_logic_vector(16-1 downto 0) := (others => 'U');

            gpdi_d          : out std_logic_Vector(4-1 downto 0);
            gpdi_cec        : out std_logic;
    		gpio_scl        : out std_logic;

    		gpio            : inout std_logic_vector(0 to 28-1) := (others => 'Z');

    		user_programn   : out std_logic := '1'; -- '0' loads next bitstream from SPI FLASH (e.g. bootloader)
    		shutdown        : out std_logic := '0'); -- '1' power off the board, 10uA sleep

	end component;

	component mt48lc32m16a2 is
		port (
			clk   : in std_logic;
			cke   : in std_logic;
			cs_n  : in std_logic;
			ras_n : in std_logic;
			cas_n : in std_logic;
			we_n  : in std_logic;
			ba    : in std_logic_vector(1 downto 0);
			addr  : in std_logic_vector(addr_bits - 1 downto 0);
			dqm   : in std_logic_vector(data_bytes - 1 downto 0);
			dq    : inout std_logic_vector(data_bits - 1 downto 0));
	end component;

	function gen_natural(
		constant start : natural := 0;
		constant stop  : natural;
		constant step  : natural := 1;
		constant size  : natural)
		return std_logic_vector is
		variable retval : std_logic_vector(start*size to size*(stop+1)-1);
	begin
		if start < stop then
			for i in start to stop loop
				retval(size*i to size*(i+1)-1) := std_logic_vector(to_unsigned(i, size));
			end loop;
		else
			for i in start downto stop loop
				retval(size*i to size*(i+1)-1) := std_logic_vector(to_unsigned(i, size));
			end loop;
		end if;
		return retval;
	end;

	constant snd_data  : std_logic_vector :=
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

		x"1702_0000ff_1603_0000_0000";
	constant req_data  : std_logic_vector :=
		x"010008_1702_0000ff_1603_8000_0000";

	signal nrst : std_logic;
	signal uart_clk : std_logic := '0';

	constant debug : boolean := true;
begin

	rst <= '1', '0' after 10 us; --, '1' after 30 us, '0' after 31 us;
	nrst <= not rst;
	xtal <= not xtal after 20 ns;
	uart_clk <= not uart_clk after 0.1 ns /2 when debug and false else not uart_clk after 12.5 ns;

	hdlc_b : block

		generic (
			baudrate  : natural := 3_000_000;
			uart_xtal : real := 40.0e6;
			xxx : natural_vector;
			payload   : std_logic_vector);
		generic map (
			xxx => (0 => snd_data'length, 1 => req_data'length),
			payload   => snd_data & req_data);

		port (
			rst       : in  std_logic;
			uart_clk  : in  std_logic;
			uart_sout : out std_logic);
		port map (
			rst       => rst,
			uart_clk  => uart_clk,
			uart_sout => ftdi_txd);

		signal uart_trdy   : std_logic;
		signal uart_irdy   : std_logic;
		signal uart_txd    : std_logic_vector(0 to 8-1);

		signal uartrx_trdy : std_logic;
		signal uartrx_irdy : std_logic;
		signal uartrx_data : std_logic_vector(0 to 8-1);

		signal hdlctx_frm  : std_logic;
		signal hdlctx_end  : std_logic;
		signal hdlctx_trdy : std_logic;
		signal hdlctx_data : std_logic_vector(0 to 8-1);

		signal hdlcrx_frm  : std_logic;
		signal hdlcrx_end  : std_logic;
		signal hdlcrx_trdy : std_logic;
		signal hdlcrx_irdy : std_logic;
		signal hdlcrx_data : std_logic_vector(0 to 8-1);
		signal hdlcfcsrx_sb : std_logic;
		signal hdlcfcsrx_vld : std_logic;

	begin

		nrst <= not rst;
		process 
			variable i     : natural;
			variable total : natural;
			variable addr  : natural;
		begin
			if rst='1' then
				hdlctx_frm <= '0';
				hdlctx_end <= '0';
				addr       := 0;
				total      := 0;
				i          := 0;
			elsif rising_edge(uart_clk) then
				if addr < total then
					hdlctx_data <= reverse(payload(addr to addr+8-1));
					if hdlctx_trdy='1' then
						addr := addr + 8;
					end if;
					if addr < total then
						hdlctx_frm <= '1';
						hdlctx_end <= '0';
					else
						hdlctx_frm <= '1';
						hdlctx_end <= '1';
					end if;
				elsif i < xxx'length-1 then
					if i > 0 then
						if debug then
							wait for 5 us;
						else
							wait for 100 us;
						end if;
						hdlctx_frm <= '0';
						hdlctx_end <= '0';
					end if;
					total := total + xxx(i);
					i     := i + 1;
				else
					hdlctx_data <= (others => '-');
				end if;

			end if;
			wait on rst, uart_clk;
		end process;

		hdlcdll_tx_e : entity hdl4fpga.hdlcdll_tx
		port map (
			hdlctx_frm  => hdlctx_frm,
			hdlctx_irdy => '1',
			hdlctx_trdy => hdlctx_trdy,
			hdlctx_end  => hdlctx_end,
			hdlctx_data => hdlctx_data,

			uart_clk    => uart_clk,
			uart_irdy   => uart_irdy,
			uart_trdy   => uart_trdy,
			uart_data   => uart_txd);

		uarttx_e : entity hdl4fpga.uart_tx
		generic map (
			baudrate  => baudrate,
			clk_rate  => uart_xtal)
		port map (
			uart_frm  => nrst,
			uart_txc  => uart_clk,
			uart_sout => uart_sout,
			uart_trdy => uart_trdy,
			uart_irdy => uart_irdy,
			uart_data => uart_txd);

		uartrx_e : entity hdl4fpga.uart_rx
		generic map (
			baudrate  => baudrate,
			clk_rate  => uart_xtal)
		port map (
			uart_rxc  => uart_clk,
			uart_sin  => ftdi_rxd,
			uart_irdy => uartrx_irdy,
			uart_data => uartrx_data);

		hdlcdll_rx_e : entity hdl4fpga.hdlcdll_rx
		port map (
			uart_clk    => uart_clk,
			uartrx_irdy => uartrx_irdy,
			uartrx_data => uartrx_data,

			hdlcrx_frm  => hdlcrx_frm,
			hdlcrx_irdy => hdlcrx_irdy,
			hdlcrx_data => hdlcrx_data,
			hdlcrx_end  => hdlcrx_end,
			fcs_sb      => hdlcfcsrx_sb,
			fcs_vld     => hdlcfcsrx_vld);

	end block;

	ipoe_b : block
		generic (
			payload   : std_logic_vector);
		generic map (
			payload   => snd_data);

		port (
			rst       : in  std_logic;
			mii_rxc   : in  std_logic;
			mii_rxdv  : in  std_logic;
			mii_rxd   : in  std_logic_vector(0 to 2-1);

			mii_txc   : in  std_logic;
			mii_txen  : buffer std_logic;
			mii_txd   : out std_logic_vector(0 to 2-1));
		port map (
			rst      => rst,
			mii_txc  => mii_clk,
			mii_txen => mii_txen,
			mii_txd  => mii_txd,

			mii_rxc  => mii_clk,
			mii_rxdv => mii_rxdv,
			mii_rxd  => mii_rxd);

		signal eth_txen  : std_logic;
		signal eth_txd   : std_logic_vector(mii_txd'range);

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
    		wait for 36 us;
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
			mii_frm1 => '0', --mii_req, -- arp
			mii_frm2 => '0', --mii_req, -- ping
			mii_frm3 => '0',
			mii_frm4 =>  mii_req, -- write
			mii_frm5 =>  mii_req1, -- read
	
			mii_txc  => mii_txc,
			mii_txen => mii_txen,
			mii_txd  => mii_txd);

		ethrx_e : entity hdl4fpga.eth_rx
		port map (
			dll_data   => datarx_null,
			mii_clk    => mii_rxc,
			mii_frm    => mii_rxdv,
			mii_irdy   => mii_rxdv,
			mii_data   => mii_rxd);

	end block;

	fire1 <= '0', '1' after 6 us;
	fire2 <= '0';

	mii_clk <= not to_stdulogic(to_bit(mii_clk)) after (1000 ns)/50/2;
	du_e : ulx4m_ls
	generic map (
		debug => debug)
	port map (
		clk_25mhz => xtal,
		gpio(0 to 22) => (others => 'Z'),
		gpio(23)  => ftdi_txd,
		gpio(24)  => ftdi_rxd,
		gpio(25 to 28-1) => (others => 'Z'),
		btn(0)    => fire1,
		btn(1 to 7-1) => (others => 'Z'),

		rmii_refclk => mii_refclk,
		rmii_nintclk => mii_clk,
		rmii_txen   => mii_rxdv,
		rmii_txd    => mii_rxd,
		rmii_rxdv   => mii_txen,
		rmii_rxd    => mii_txd, 

		sdram_clk  => sdram_clk,
		sdram_cke  => sdram_cke,
		sdram_csn  => sdram_cs_n,
		sdram_rasn => sdram_ras_n,
		sdram_casn => sdram_cas_n,
		sdram_wen  => sdram_we_n,
		sdram_ba   => sdram_ba,
		sdram_a    => sdram_addr,
		sdram_dqm  => sdram_dqm,
		sdram_d    => sdram_dq);

	sdr_model_g: mt48lc32m16a2
	port map (
		clk   => sdram_clk,
		cke   => sdram_cke,
		cs_n  => sdram_cs_n,
		ras_n => sdram_ras_n,
		cas_n => sdram_cas_n,
		we_n  => sdram_we_n,
		ba    => sdram_ba,
		addr  => sdram_addr,
		dqm   => sdram_dqm,
		dq    => sdram_dq);
end;

library micron;

configuration ulx4mls_graphics_structure_md of testbench is
	for ulx4mls_graphics
		for all : ulx4m_ls
			use entity work.ulx4m_ls(structure);
		end for;
		for all: mt48lc32m16a2
			use entity micron.mt48lc32m16a2
			port map (
				clk   => sdram_clk,
				cke   => sdram_cke,
				cs_n  => sdram_cs_n,
				ras_n => sdram_ras_n,
				cas_n => sdram_cas_n,
				we_n  => sdram_we_n,
				ba    => sdram_ba,
				addr  => sdram_addr,
				dqm   => sdram_dqm,
				dq    => sdram_dq);
		end for;
	end for;
end;

library micron;

configuration ulx4mls_graphics_md of testbench is
	for ulx4mls_graphics
		for all : ulx4m_ls
			use entity work.ulx4m_ls(graphics);
		end for;
			for all : mt48lc32m16a2
			use entity micron.mt48lc32m16a2
			port map (
				clk   => sdram_clk,
				cke   => sdram_cke,
				cs_n  => sdram_cs_n,
				ras_n => sdram_ras_n,
				cas_n => sdram_cas_n,
				we_n  => sdram_we_n,
				ba    => sdram_ba,
				addr  => sdram_addr,
				dqm   => sdram_dqm,
				dq    => sdram_dq);
		end for;
	end for;
end;
