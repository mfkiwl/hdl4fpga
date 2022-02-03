onerror {resume}
quietly virtual signal -install /testbench/du_e/grahics_e/dmactlr_b/dmactlr_e/dmatrans_e/dma_b/col_e { /testbench/du_e/grahics_e/dmactlr_b/dmactlr_e/dmatrans_e/dma_b/col_e/wr_cntr(1 to 3)} wr
quietly virtual signal -install /testbench/du_e/grahics_e/dmactlr_b/dmactlr_e/dmatrans_e/dma_b/col_e { /testbench/du_e/grahics_e/dmactlr_b/dmactlr_e/dmatrans_e/dma_b/col_e/rd_cntr(1 to 3)} rd
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/du_e/btn(0)
add wave -noupdate -expand -group eth_rx /testbench/du_e/eth_rx_clk
add wave -noupdate -expand -group eth_rx /testbench/du_e/eth_rx_dv
add wave -noupdate -expand -group eth_rx -radix hexadecimal /testbench/du_e/eth_rxd
add wave -noupdate -expand -group eth_tx /testbench/du_e/eth_tx_clk
add wave -noupdate -expand -group eth_tx /testbench/du_e/eth_tx_en
add wave -noupdate -expand -group eth_tx /testbench/du_e/eth_txd
add wave -noupdate -expand -group ddr3 -radix hexadecimal /testbench/du_e/ddr3_clk_p
add wave -noupdate -expand -group ddr3 -radix hexadecimal /testbench/du_e/ddr3_reset
add wave -noupdate -expand -group ddr3 -radix hexadecimal /testbench/du_e/ddr3_cs
add wave -noupdate -expand -group ddr3 -radix hexadecimal /testbench/du_e/ddr3_cke
add wave -noupdate -expand -group ddr3 /testbench/du_e/ddr3_odt
add wave -noupdate -expand -group ddr3 -radix hexadecimal /testbench/du_e/ddr3_ras
add wave -noupdate -expand -group ddr3 -radix hexadecimal /testbench/du_e/ddr3_cas
add wave -noupdate -expand -group ddr3 -radix hexadecimal /testbench/du_e/ddr3_we
add wave -noupdate -expand -group ddr3 -divider {New Divider}
add wave -noupdate -expand -group ddr3 -radix symbolic -childformat {{/testbench/du_e/ddr3_ba(2) -radix hexadecimal} {/testbench/du_e/ddr3_ba(1) -radix hexadecimal} {/testbench/du_e/ddr3_ba(0) -radix hexadecimal}} -subitemconfig {/testbench/du_e/ddr3_ba(2) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_ba(1) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_ba(0) {-height 29 -radix hexadecimal}} /testbench/du_e/ddr3_ba
add wave -noupdate -expand -group ddr3 -radix hexadecimal -childformat {{/testbench/du_e/ddr3_dq(15) -radix hexadecimal} {/testbench/du_e/ddr3_dq(14) -radix hexadecimal} {/testbench/du_e/ddr3_dq(13) -radix hexadecimal} {/testbench/du_e/ddr3_dq(12) -radix hexadecimal} {/testbench/du_e/ddr3_dq(11) -radix hexadecimal} {/testbench/du_e/ddr3_dq(10) -radix hexadecimal} {/testbench/du_e/ddr3_dq(9) -radix hexadecimal} {/testbench/du_e/ddr3_dq(8) -radix hexadecimal} {/testbench/du_e/ddr3_dq(7) -radix hexadecimal} {/testbench/du_e/ddr3_dq(6) -radix hexadecimal} {/testbench/du_e/ddr3_dq(5) -radix hexadecimal} {/testbench/du_e/ddr3_dq(4) -radix hexadecimal} {/testbench/du_e/ddr3_dq(3) -radix hexadecimal} {/testbench/du_e/ddr3_dq(2) -radix hexadecimal} {/testbench/du_e/ddr3_dq(1) -radix hexadecimal} {/testbench/du_e/ddr3_dq(0) -radix hexadecimal}} -subitemconfig {/testbench/du_e/ddr3_dq(15) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_dq(14) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_dq(13) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_dq(12) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_dq(11) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_dq(10) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_dq(9) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_dq(8) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_dq(7) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_dq(6) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_dq(5) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_dq(4) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_dq(3) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_dq(2) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_dq(1) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_dq(0) {-height 29 -radix hexadecimal}} /testbench/du_e/ddr3_dq
add wave -noupdate -expand -group ddr3 -radix hexadecimal -childformat {{/testbench/du_e/ddr3_a(13) -radix hexadecimal} {/testbench/du_e/ddr3_a(12) -radix hexadecimal} {/testbench/du_e/ddr3_a(11) -radix hexadecimal} {/testbench/du_e/ddr3_a(10) -radix hexadecimal} {/testbench/du_e/ddr3_a(9) -radix hexadecimal} {/testbench/du_e/ddr3_a(8) -radix hexadecimal} {/testbench/du_e/ddr3_a(7) -radix hexadecimal} {/testbench/du_e/ddr3_a(6) -radix hexadecimal} {/testbench/du_e/ddr3_a(5) -radix hexadecimal} {/testbench/du_e/ddr3_a(4) -radix hexadecimal} {/testbench/du_e/ddr3_a(3) -radix hexadecimal} {/testbench/du_e/ddr3_a(2) -radix hexadecimal} {/testbench/du_e/ddr3_a(1) -radix hexadecimal} {/testbench/du_e/ddr3_a(0) -radix hexadecimal}} -subitemconfig {/testbench/du_e/ddr3_a(13) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_a(12) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_a(11) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_a(10) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_a(9) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_a(8) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_a(7) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_a(6) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_a(5) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_a(4) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_a(3) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_a(2) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_a(1) {-height 29 -radix hexadecimal} /testbench/du_e/ddr3_a(0) {-height 29 -radix hexadecimal}} /testbench/du_e/ddr3_a
add wave -noupdate -expand -group ddr3 /testbench/du_e/ddr3_dqs_p(1)
add wave -noupdate -expand -group ddr3 /testbench/du_e/ddr3_dqs_p(0)
add wave -noupdate -divider {New Divider}
add wave -noupdate -divider {New Divider}
add wave -noupdate /testbench/du_e/grahics_e/sio_b/tx_b/sodata_b/dmaso_irdy
add wave -noupdate -radix hexadecimal /testbench/du_e/grahics_e/sio_b/tx_b/sodata_b/dmaso_data
add wave -noupdate -divider {New Divider}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {169901177 ps} 0} {{Cursor 2} {169970691 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 221
configure wave -valuecolwidth 288
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
WaveRestoreZoom {169968429 ps} {170001662 ps}
