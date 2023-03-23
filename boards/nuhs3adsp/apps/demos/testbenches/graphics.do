onerror {resume}
quietly virtual signal -install /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e { (context /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e )( tag_data(7) & tag_data(6) & tag_data(5) & tag_data(4) & tag_data(3) & tag_data(2) & tag_data(1) & tag_data(0) )} tag_rdata
quietly virtual signal -install /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e { (context /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e )( plrx_data(7) & plrx_data(6) & plrx_data(5) & plrx_data(4) & plrx_data(3) & plrx_data(2) & plrx_data(1) & plrx_data(0) )} plrx_rdata
quietly virtual signal -install /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e { (context /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e )( so_data(7) & so_data(6) & so_data(5) & so_data(4) & so_data(3) & so_data(2) & so_data(1) & so_data(0) )} so_rdata
quietly virtual signal -install /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/fifo_e { (context /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/fifo_e )( src_data(7) & src_data(6) & src_data(5) & src_data(4) & src_data(3) & src_data(2) & src_data(1) & src_data(0) )} src_rdata
quietly virtual signal -install /testbench/ethrx_e {/testbench/ethrx_e/mii_data  } mii_rdata
quietly virtual signal -install /testbench/ethrx_e {/testbench/ethrx_e/mii_rdata  } mii_rdata001
quietly virtual signal -install /testbench/ethrx_e { (context /testbench/ethrx_e )( mii_data(3) & mii_data(2) & mii_data(1) & mii_data(0) )} mii_rdata002
quietly virtual signal -install /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e { (context /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e )( mii_data(7) & mii_data(6) & mii_data(5) & mii_data(4) & mii_data(3) & mii_data(2) & mii_data(1) & mii_data(0) )} mii_rdata
quietly virtual signal -install /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/fifo_e { /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/fifo_e/tx_data(0 to 11)} tx_rdata
quietly virtual signal -install /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/fifo_e { (context /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/fifo_e )( tx_data(11) & tx_data(10) & tx_data(9) & tx_data(8) & tx_data(7) & tx_data(6) & tx_data(5) & tx_data(4) & tx_data(3) & tx_data(2) & tx_data(1) & tx_data(0) )} tx_rdata001
quietly WaveActivateNextPane {} 0
add wave -noupdate -group ethrx_e /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_frm
add wave -noupdate -group ethrx_e /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_end
add wave -noupdate -group ethrx_e -label mii_data -radix hexadecimal -childformat {{/testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_rdata(7) -radix hexadecimal} {/testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_rdata(6) -radix hexadecimal} {/testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_rdata(5) -radix hexadecimal} {/testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_rdata(4) -radix hexadecimal} {/testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_rdata(3) -radix hexadecimal} {/testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_rdata(2) -radix hexadecimal} {/testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_rdata(1) -radix hexadecimal} {/testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_rdata(0) -radix hexadecimal}} -subitemconfig {/testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_data(7) {-radix hexadecimal} /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_data(6) {-radix hexadecimal} /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_data(5) {-radix hexadecimal} /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_data(4) {-radix hexadecimal} /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_data(3) {-radix hexadecimal} /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_data(2) {-radix hexadecimal} /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_data(1) {-radix hexadecimal} /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_data(0) {-radix hexadecimal}} /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_rdata
add wave -noupdate -group ethrx_e /testbench/ethrx_e/mii_clk
add wave -noupdate -group ethrx_e -label mii_data -radix hexadecimal -childformat {{/testbench/ethrx_e/mii_rdata002(3) -radix hexadecimal} {/testbench/ethrx_e/mii_rdata002(2) -radix hexadecimal} {/testbench/ethrx_e/mii_rdata002(1) -radix hexadecimal} {/testbench/ethrx_e/mii_rdata002(0) -radix hexadecimal}} -subitemconfig {/testbench/ethrx_e/mii_data(3) {-radix hexadecimal} /testbench/ethrx_e/mii_data(2) {-radix hexadecimal} /testbench/ethrx_e/mii_data(1) {-radix hexadecimal} /testbench/ethrx_e/mii_data(0) {-radix hexadecimal}} /testbench/ethrx_e/mii_rdata002
add wave -noupdate -group ethrx_e /testbench/ethrx_e/fcs_sb
add wave -noupdate -group ethrx_e /testbench/ethrx_e/fcs_vld
add wave -noupdate -group ethrx_e -radix hexadecimal /testbench/ethrx_e/fcs_rem
add wave -noupdate -group ethrx_e /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/miirx_frm
add wave -noupdate -group ethrx_e /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/miirx_irdy
add wave -noupdate -group ethrx_e /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/miirx_trdy
add wave -noupdate -group ethrx_e /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_frm
add wave -noupdate -group ethrx_e /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_end
add wave -noupdate -group ethrx_e -label mii_data -radix hexadecimal -childformat {{/testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_rdata(7) -radix hexadecimal} {/testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_rdata(6) -radix hexadecimal} {/testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_rdata(5) -radix hexadecimal} {/testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_rdata(4) -radix hexadecimal} {/testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_rdata(3) -radix hexadecimal} {/testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_rdata(2) -radix hexadecimal} {/testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_rdata(1) -radix hexadecimal} {/testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_rdata(0) -radix hexadecimal}} -subitemconfig {/testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_data(7) {-radix hexadecimal} /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_data(6) {-radix hexadecimal} /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_data(5) {-radix hexadecimal} /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_data(4) {-radix hexadecimal} /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_data(3) {-radix hexadecimal} /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_data(2) {-radix hexadecimal} /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_data(1) {-radix hexadecimal} /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_data(0) {-radix hexadecimal}} /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/ethtx_e/mii_rdata
add wave -noupdate -group ethrx_e /testbench/ethrx_e/mii_clk
add wave -noupdate -group ethrx_e -label mii_data -radix hexadecimal -childformat {{/testbench/ethrx_e/mii_rdata002(3) -radix hexadecimal} {/testbench/ethrx_e/mii_rdata002(2) -radix hexadecimal} {/testbench/ethrx_e/mii_rdata002(1) -radix hexadecimal} {/testbench/ethrx_e/mii_rdata002(0) -radix hexadecimal}} -subitemconfig {/testbench/ethrx_e/mii_data(3) {-radix hexadecimal} /testbench/ethrx_e/mii_data(2) {-radix hexadecimal} /testbench/ethrx_e/mii_data(1) {-radix hexadecimal} /testbench/ethrx_e/mii_data(0) {-radix hexadecimal}} /testbench/ethrx_e/mii_rdata002
add wave -noupdate -group ethrx_e /testbench/ethrx_e/fcs_sb
add wave -noupdate -group ethrx_e /testbench/ethrx_e/fcs_vld
add wave -noupdate -group ethrx_e -radix hexadecimal /testbench/ethrx_e/fcs_rem
add wave -noupdate -group ethrx_e /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/miirx_frm
add wave -noupdate -group ethrx_e /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/miirx_irdy
add wave -noupdate -group ethrx_e /testbench/du_e/ipoe_b/udpdaisy_e/sio_udp_e/mii_ipoe_e/miirx_trdy
add wave -noupdate -divider {New Divider}
add wave -noupdate -expand -group mii_rx /testbench/du_e/mii_rxc
add wave -noupdate -expand -group mii_rx /testbench/du_e/mii_rxdv
add wave -noupdate -expand -group mii_rx -radix hexadecimal /testbench/du_e/mii_rxd
add wave -noupdate -expand -group mii_rx -divider {New Divider}
add wave -noupdate -expand -group mii_rx /testbench/du_e/mii_rxc
add wave -noupdate -expand -group mii_rx /testbench/du_e/mii_rxdv
add wave -noupdate -expand -group mii_rx -radix hexadecimal /testbench/du_e/mii_rxd
add wave -noupdate -expand -group mii_rx -divider {New Divider}
add wave -noupdate -group mii_tx /testbench/du_e/mii_txc
add wave -noupdate -group mii_tx /testbench/du_e/mii_txen
add wave -noupdate -group mii_tx -radix hexadecimal -childformat {{/testbench/du_e/mii_txd(0) -radix hexadecimal} {/testbench/du_e/mii_txd(1) -radix hexadecimal} {/testbench/du_e/mii_txd(2) -radix hexadecimal} {/testbench/du_e/mii_txd(3) -radix hexadecimal}} -subitemconfig {/testbench/du_e/mii_txd(0) {-height 29 -radix hexadecimal} /testbench/du_e/mii_txd(1) {-height 29 -radix hexadecimal} /testbench/du_e/mii_txd(2) {-height 29 -radix hexadecimal} /testbench/du_e/mii_txd(3) {-height 29 -radix hexadecimal}} /testbench/du_e/mii_txd
add wave -noupdate -group mii_tx /testbench/du_e/mii_txc
add wave -noupdate -group mii_tx /testbench/du_e/mii_txen
add wave -noupdate -group mii_tx -radix hexadecimal /testbench/du_e/mii_txd
add wave -noupdate -expand -group ddr /testbench/du_e/ddr_ckp
add wave -noupdate -expand -group ddr /testbench/du_e/ddr_cs
add wave -noupdate -expand -group ddr /testbench/du_e/ddr_cke
add wave -noupdate -expand -group ddr /testbench/du_e/ddr_ras
add wave -noupdate -expand -group ddr /testbench/du_e/ddr_cas
add wave -noupdate -expand -group ddr /testbench/du_e/ddr_we
add wave -noupdate -expand -group ddr -radix hexadecimal /testbench/du_e/ddr_ba
add wave -noupdate -expand -group ddr -radix hexadecimal -childformat {{/testbench/du_e/ddr_a(12) -radix hexadecimal} {/testbench/du_e/ddr_a(11) -radix hexadecimal} {/testbench/du_e/ddr_a(10) -radix hexadecimal} {/testbench/du_e/ddr_a(9) -radix hexadecimal} {/testbench/du_e/ddr_a(8) -radix hexadecimal} {/testbench/du_e/ddr_a(7) -radix hexadecimal} {/testbench/du_e/ddr_a(6) -radix hexadecimal} {/testbench/du_e/ddr_a(5) -radix hexadecimal} {/testbench/du_e/ddr_a(4) -radix hexadecimal} {/testbench/du_e/ddr_a(3) -radix hexadecimal} {/testbench/du_e/ddr_a(2) -radix hexadecimal} {/testbench/du_e/ddr_a(1) -radix hexadecimal} {/testbench/du_e/ddr_a(0) -radix hexadecimal}} -subitemconfig {/testbench/du_e/ddr_a(12) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_a(11) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_a(10) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_a(9) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_a(8) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_a(7) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_a(6) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_a(5) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_a(4) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_a(3) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_a(2) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_a(1) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_a(0) {-height 29 -radix hexadecimal}} /testbench/du_e/ddr_a
add wave -noupdate -expand -group ddr /testbench/du_e/ddr_dqs
add wave -noupdate -expand -group ddr -radix hexadecimal -childformat {{/testbench/du_e/ddr_dq(15) -radix hexadecimal} {/testbench/du_e/ddr_dq(14) -radix hexadecimal} {/testbench/du_e/ddr_dq(13) -radix hexadecimal} {/testbench/du_e/ddr_dq(12) -radix hexadecimal} {/testbench/du_e/ddr_dq(11) -radix hexadecimal} {/testbench/du_e/ddr_dq(10) -radix hexadecimal} {/testbench/du_e/ddr_dq(9) -radix hexadecimal} {/testbench/du_e/ddr_dq(8) -radix hexadecimal} {/testbench/du_e/ddr_dq(7) -radix hexadecimal} {/testbench/du_e/ddr_dq(6) -radix hexadecimal} {/testbench/du_e/ddr_dq(5) -radix hexadecimal} {/testbench/du_e/ddr_dq(4) -radix hexadecimal} {/testbench/du_e/ddr_dq(3) -radix hexadecimal} {/testbench/du_e/ddr_dq(2) -radix hexadecimal} {/testbench/du_e/ddr_dq(1) -radix hexadecimal} {/testbench/du_e/ddr_dq(0) -radix hexadecimal}} -subitemconfig {/testbench/du_e/ddr_dq(15) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_dq(14) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_dq(13) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_dq(12) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_dq(11) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_dq(10) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_dq(9) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_dq(8) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_dq(7) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_dq(6) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_dq(5) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_dq(4) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_dq(3) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_dq(2) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_dq(1) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_dq(0) {-height 29 -radix hexadecimal}} /testbench/du_e/ddr_dq
add wave -noupdate -expand -group ddr -expand /testbench/du_e/ddr_dm
add wave -noupdate -expand -group ddr /testbench/du_e/ddr_st_dqs
add wave -noupdate -expand -group ddr /testbench/du_e/ddr_st_lp_dqs
add wave -noupdate -expand -group ddr /testbench/du_e/ddr_ckp
add wave -noupdate -expand -group ddr /testbench/du_e/ddr_cs
add wave -noupdate -expand -group ddr /testbench/du_e/ddr_cke
add wave -noupdate -expand -group ddr /testbench/du_e/ddr_ras
add wave -noupdate -expand -group ddr /testbench/du_e/ddr_cas
add wave -noupdate -expand -group ddr /testbench/du_e/ddr_we
add wave -noupdate -expand -group ddr -radix hexadecimal /testbench/du_e/ddr_ba
add wave -noupdate -expand -group ddr -radix hexadecimal -childformat {{/testbench/du_e/ddr_a(12) -radix hexadecimal} {/testbench/du_e/ddr_a(11) -radix hexadecimal} {/testbench/du_e/ddr_a(10) -radix hexadecimal} {/testbench/du_e/ddr_a(9) -radix hexadecimal} {/testbench/du_e/ddr_a(8) -radix hexadecimal} {/testbench/du_e/ddr_a(7) -radix hexadecimal} {/testbench/du_e/ddr_a(6) -radix hexadecimal} {/testbench/du_e/ddr_a(5) -radix hexadecimal} {/testbench/du_e/ddr_a(4) -radix hexadecimal} {/testbench/du_e/ddr_a(3) -radix hexadecimal} {/testbench/du_e/ddr_a(2) -radix hexadecimal} {/testbench/du_e/ddr_a(1) -radix hexadecimal} {/testbench/du_e/ddr_a(0) -radix hexadecimal}} -subitemconfig {/testbench/du_e/ddr_a(12) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_a(11) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_a(10) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_a(9) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_a(8) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_a(7) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_a(6) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_a(5) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_a(4) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_a(3) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_a(2) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_a(1) {-height 29 -radix hexadecimal} /testbench/du_e/ddr_a(0) {-height 29 -radix hexadecimal}} /testbench/du_e/ddr_a
add wave -noupdate -expand -group ddr -expand /testbench/du_e/ddr_dqs
add wave -noupdate -expand -group ddr -radix hexadecimal /testbench/du_e/ddr_dq
add wave -noupdate -expand -group ddr /testbench/du_e/ddr_st_dqs
add wave -noupdate -expand -group ddr /testbench/du_e/ddr_st_lp_dqs
add wave -noupdate -divider {New Divider}
add wave -noupdate /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/datao_b/fifo_g/gear_g(1)/fifo_i/line__46/cntr
add wave -noupdate -divider {New Divider}
add wave -noupdate -radix unsigned /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/datao_b/fifo_g/gear_g(1)/fifo_i/line__46/cntr
add wave -noupdate -radix unsigned /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/datao_b/fifo_g/gear_g(1)/fifo_i/line__57/cntr
add wave -noupdate -divider {New Divider}
add wave -noupdate -divider {New Divider}
add wave -noupdate -divider {New Divider}
add wave -noupdate -expand /testbench/du_e/sdrphy_e/sys_dmi
add wave -noupdate -divider {New Divider}
add wave -noupdate /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/clk
add wave -noupdate -divider {New Divider}
add wave -noupdate /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqv(1)
add wave -noupdate /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqv(0)
add wave -noupdate -divider {New Divider}
add wave -noupdate /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqe(1)
add wave -noupdate /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqe(0)
add wave -noupdate -divider {New Divider}
add wave -noupdate -radix hexadecimal /testbench/du_e/sdrphy_e/sys_dqi
add wave -noupdate /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/clk_shift
add wave -noupdate -radix hexadecimal -childformat {{/testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(15) -radix hexadecimal} {/testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(14) -radix hexadecimal} {/testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(13) -radix hexadecimal} {/testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(12) -radix hexadecimal} {/testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(11) -radix hexadecimal} {/testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(10) -radix hexadecimal} {/testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(9) -radix hexadecimal} {/testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(8) -radix hexadecimal} {/testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(7) -radix hexadecimal} {/testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(6) -radix hexadecimal} {/testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(5) -radix hexadecimal} {/testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(4) -radix hexadecimal} {/testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(3) -radix hexadecimal} {/testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(2) -radix hexadecimal} {/testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(1) -radix hexadecimal} {/testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(0) -radix hexadecimal}} -subitemconfig {/testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(15) {-height 29 -radix hexadecimal} /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(14) {-height 29 -radix hexadecimal} /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(13) {-height 29 -radix hexadecimal} /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(12) {-height 29 -radix hexadecimal} /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(11) {-height 29 -radix hexadecimal} /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(10) {-height 29 -radix hexadecimal} /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(9) {-height 29 -radix hexadecimal} /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(8) {-height 29 -radix hexadecimal} /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(7) {-height 29 -radix hexadecimal} /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(6) {-height 29 -radix hexadecimal} /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(5) {-height 29 -radix hexadecimal} /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(4) {-height 29 -radix hexadecimal} /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(3) {-height 29 -radix hexadecimal} /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(2) {-height 29 -radix hexadecimal} /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(1) {-height 29 -radix hexadecimal} /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi(0) {-height 29 -radix hexadecimal}} /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dqi
add wave -noupdate -radix hexadecimal /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sdram_dqo
add wave -noupdate -divider {New Divider}
add wave -noupdate -radix unsigned /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/gear2_g/phdata_e/cntr
add wave -noupdate -radix unsigned /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/gear2_g/phdata_e/cntr0
add wave -noupdate -radix unsigned /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/gear2_g/phdata_e/cntr90
add wave -noupdate -radix unsigned /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/gear2_g/phdata_e/cntr180
add wave -noupdate -radix unsigned /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/gear2_g/phdata_e/cntr270
add wave -noupdate -expand /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sdqt
add wave -noupdate -divider {New Divider}
add wave -noupdate -expand /testbench/du_e/sdrphy_e/sys_dqt
add wave -noupdate -divider {New Divider}
add wave -noupdate /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_dmi
add wave -noupdate -expand /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/sys_sti
add wave -noupdate /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/clk_shift
add wave -noupdate -expand /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/datao_b/sto_g/d
add wave -noupdate /testbench/du_e/sdrphy_e/sdram_sto(0)
add wave -noupdate -expand /testbench/du_e/sdrphy_e/sys_dmi
add wave -noupdate -divider {New Divider}
add wave -noupdate /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/datao_b/dmo_g/ogbx_i/reg_g(0)/gear2_g/xc3s_g/oddr_i/C0
add wave -noupdate /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/datao_b/dmo_g/ogbx_i/reg_g(0)/gear2_g/xc3s_g/oddr_i/D0
add wave -noupdate /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/datao_b/dmo_g/ogbx_i/reg_g(0)/gear2_g/xc3s_g/oddr_i/C1
add wave -noupdate /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/datao_b/dmo_g/ogbx_i/reg_g(0)/gear2_g/xc3s_g/oddr_i/D1
add wave -noupdate -divider {New Divider}
add wave -noupdate /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/datao_b/oddr_g(2)/ogbx_i/reg_g(0)/gear2_g/xc3s_g/oddr_i/C0
add wave -noupdate /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/datao_b/oddr_g(2)/ogbx_i/reg_g(0)/gear2_g/xc3s_g/oddr_i/D0
add wave -noupdate /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/datao_b/oddr_g(2)/ogbx_i/reg_g(0)/gear2_g/xc3s_g/oddr_i/C1
add wave -noupdate /testbench/du_e/sdrphy_e/byte_g(0)/sdrdqphy_i/datao_b/oddr_g(2)/ogbx_i/reg_g(0)/gear2_g/xc3s_g/oddr_i/D1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {69203315 ps} 0} {{Cursor 2} {94751461 ps} 0} {{Cursor 3} {94823469 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 316
configure wave -valuecolwidth 219
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {69022133 ps} {69230415 ps}
