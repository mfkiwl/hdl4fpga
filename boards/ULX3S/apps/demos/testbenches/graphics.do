onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group uart /testbench/du_e/ftdi_txd
add wave -noupdate -expand -group uart /testbench/du_e/ftdi_rxd
add wave -noupdate -expand -group sdram /testbench/du_e/sdram_clk
add wave -noupdate -expand -group sdram /testbench/du_e/sdram_cke
add wave -noupdate -expand -group sdram /testbench/du_e/sdram_csn
add wave -noupdate -expand -group sdram /testbench/du_e/sdram_rasn
add wave -noupdate -expand -group sdram /testbench/du_e/sdram_casn
add wave -noupdate -expand -group sdram /testbench/du_e/sdram_wen
add wave -noupdate -expand -group sdram -radix hexadecimal /testbench/du_e/sdram_a
add wave -noupdate -expand -group sdram /testbench/du_e/sdram_ba
add wave -noupdate -expand -group sdram /testbench/du_e/sdram_dqm
add wave -noupdate -expand -group sdram -radix hexadecimal /testbench/du_e/sdram_d
add wave -noupdate /testbench/du_e/graphics_e/dmactlr_b/dmactlr_e/dmatrans_e/dmatrans_clk
add wave -noupdate -divider {New Divider}
add wave -noupdate -radix hexadecimal /testbench/du_e/graphics_e/dmactlr_b/dmactlr_e/dmatrans_e/ddrdma_row
add wave -noupdate -radix hexadecimal /testbench/du_e/graphics_e/dmactlr_b/dmactlr_e/dmatrans_e/ddrdma_col
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/dmacfg_clk
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/dmacfg_req
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/dmacfg_rdy
add wave -noupdate -radix hexadecimal /testbench/du_e/graphics_e/adapter_b/graphics_e/dma_len
add wave -noupdate -radix hexadecimal /testbench/du_e/graphics_e/adapter_b/graphics_e/dma_addr
add wave -noupdate -divider {New Divider}
add wave -noupdate -divider {New Divider}
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/dma_b/vrdy
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/dma_b/vreq
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/dma_b/treq
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/dma_req
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/dma_rdy
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/dma_b/trdy
add wave -noupdate /testbench/du_e/graphics_e/dmactlr_b/dmactlr_e/dmatrans_e/dmatrans_req
add wave -noupdate /testbench/du_e/graphics_e/dmactlr_b/dmactlr_e/dmatrans_e/dmatrans_rdy
add wave -noupdate /testbench/du_e/graphics_e/dmactlr_b/dmactlr_e/dmatrans_e/state_pre
add wave -noupdate /testbench/du_e/graphics_e/dmactlr_b/dmactlr_e/dmatrans_e/restart
add wave -noupdate -divider {New Divider}
add wave -noupdate /testbench/du_e/graphics_e/dmactlr_b/dmactlr_e/ctlr_refreq
add wave -noupdate -divider {New Divider}
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/dma_req
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/dma_rdy
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/ctlr_di_dv
add wave -noupdate /testbench/du_e/ctlr_clk
add wave -noupdate /testbench/du_e/graphics_e/dmactlr_b/dmactlr_e/dmatrans_e/ctlr_trdy
add wave -noupdate -divider {New Divider}
add wave -noupdate -radix hexadecimal /testbench/du_e/graphics_e/adapter_b/graphics_e/ctlr_di_dv
add wave -noupdate -radix hexadecimal /testbench/du_e/graphics_e/adapter_b/graphics_e/ctlr_di
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/vram_e/src_frm
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/vram_e/src_irdy
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/vram_e/src_trdy
add wave -noupdate -divider {New Divider}
add wave -noupdate -radix hexadecimal /testbench/du_e/graphics_e/adapter_b/graphics_e/vram_e/wr_cntr
add wave -noupdate -radix hexadecimal /testbench/du_e/graphics_e/adapter_b/graphics_e/vram_e/wr_ptr
add wave -noupdate -radix hexadecimal /testbench/du_e/graphics_e/adapter_b/graphics_e/vram_e/rd_cmp
add wave -noupdate -divider {New Divider}
add wave -noupdate -radix hexadecimal /testbench/du_e/graphics_e/adapter_b/graphics_e/vram_e/max_depthgt1_g/mem_e/wr_addr
add wave -noupdate -radix hexadecimal /testbench/du_e/graphics_e/adapter_b/graphics_e/vram_e/max_depthgt1_g/mem_e/rd_addr
add wave -noupdate -divider {New Divider}
add wave -noupdate -radix hexadecimal /testbench/du_e/graphics_e/adapter_b/graphics_e/vram_e/wr_cmp
add wave -noupdate -radix hexadecimal /testbench/du_e/graphics_e/adapter_b/graphics_e/vram_e/rd_cntr
add wave -noupdate -divider {New Divider}
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/vram_e/dst_clk
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/vram_e/dst_frm
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/vram_e/dst_irdy
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/vram_e/dst_trdy
add wave -noupdate -radix hexadecimal /testbench/du_e/graphics_e/adapter_b/graphics_e/vram_e/dst_data
add wave -noupdate -divider {New Divider}
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/ppage_size
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/pslice_size
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/pwater_mark
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/video_width
add wave -noupdate -divider {New Divider}
add wave -noupdate -radix unsigned /testbench/du_e/graphics_e/adapter_b/graphics_e/video_b/level
add wave -noupdate -divider {New Divider}
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/video_hzon
add wave -noupdate -divider {New Divider}
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/video_clk
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/video_vton
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/video_frm
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/video_hzon
add wave -noupdate /testbench/du_e/graphics_e/adapter_b/graphics_e/video_on
add wave -noupdate -radix hexadecimal -childformat {{/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(0) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(1) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(2) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(3) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(4) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(5) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(6) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(7) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(8) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(9) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(10) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(11) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(12) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(13) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(14) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(15) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(16) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(17) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(18) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(19) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(20) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(21) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(22) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(23) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(24) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(25) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(26) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(27) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(28) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(29) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(30) -radix hexadecimal} {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(31) -radix hexadecimal}} -subitemconfig {/testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(0) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(1) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(2) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(3) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(4) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(5) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(6) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(7) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(8) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(9) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(10) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(11) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(12) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(13) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(14) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(15) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(16) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(17) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(18) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(19) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(20) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(21) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(22) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(23) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(24) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(25) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(26) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(27) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(28) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(29) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(30) {-height 29 -radix hexadecimal} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel(31) {-height 29 -radix hexadecimal}} /testbench/du_e/graphics_e/adapter_b/graphics_e/video_pixel
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {302637264840 fs} 0} {{Cursor 2} {302752793840 fs} 0} {{Cursor 3} {398108387990 fs} 0}
quietly wave cursor active 2
configure wave -namecolwidth 199
configure wave -valuecolwidth 87
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
WaveRestoreZoom {0 fs} {1106616 ns}
