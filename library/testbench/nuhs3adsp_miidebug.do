onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/du_e/mii_debug_e/mii_txc
add wave -noupdate /testbench/du_e/mii_debug_e/mii_txen
add wave -noupdate -radix hexadecimal -childformat {{/testbench/du_e/mii_txd(0) -radix hexadecimal} {/testbench/du_e/mii_txd(1) -radix hexadecimal} {/testbench/du_e/mii_txd(2) -radix hexadecimal} {/testbench/du_e/mii_txd(3) -radix hexadecimal}} -subitemconfig {/testbench/du_e/mii_txd(0) {-height 15 -radix hexadecimal} /testbench/du_e/mii_txd(1) {-height 15 -radix hexadecimal} /testbench/du_e/mii_txd(2) {-height 15 -radix hexadecimal} /testbench/du_e/mii_txd(3) {-height 15 -radix hexadecimal}} /testbench/du_e/mii_txd
add wave -noupdate /testbench/du_e/mii_debug_e/mii_treq
add wave -noupdate -expand /testbench/du_e/mii_debug_e/mii_gnt
add wave -noupdate /testbench/du_e/mii_debug_e/mii_treq
add wave -noupdate /testbench/du_e/mii_debug_e/mii_trdy
add wave -noupdate /testbench/du_e/mii_debug_e/mii_req
add wave -noupdate /testbench/du_e/mii_debug_e/mii_rdy
add wave -noupdate -radix unsigned /testbench/du_e/mii_debug_e/udp4tx_e/udp4_txen
add wave -noupdate -radix unsigned -childformat {{/testbench/du_e/mii_debug_e/udp4tx_e/udp4_txd(0) -radix unsigned} {/testbench/du_e/mii_debug_e/udp4tx_e/udp4_txd(1) -radix unsigned} {/testbench/du_e/mii_debug_e/udp4tx_e/udp4_txd(2) -radix unsigned} {/testbench/du_e/mii_debug_e/udp4tx_e/udp4_txd(3) -radix unsigned}} -subitemconfig {/testbench/du_e/mii_debug_e/udp4tx_e/udp4_txd(0) {-height 15 -radix unsigned} /testbench/du_e/mii_debug_e/udp4tx_e/udp4_txd(1) {-height 15 -radix unsigned} /testbench/du_e/mii_debug_e/udp4tx_e/udp4_txd(2) {-height 15 -radix unsigned} /testbench/du_e/mii_debug_e/udp4tx_e/udp4_txd(3) {-height 15 -radix unsigned}} /testbench/du_e/mii_debug_e/udp4tx_e/udp4_txd
add wave -noupdate /testbench/du_e/mii_debug_e/arptx_e/ipsa_treq
add wave -noupdate /testbench/du_e/mii_debug_e/arptx_e/ipsa_trdy
add wave -noupdate /testbench/du_e/mii_debug_e/arptx_e/ipsa_txen
add wave -noupdate -radix hexadecimal /testbench/du_e/mii_debug_e/arptx_e/ipsa_txd
add wave -noupdate /testbench/du_e/mii_debug_e/arptx_e/arp_treq
add wave -noupdate /testbench/du_e/mii_debug_e/arptx_e/arp_trdy
add wave -noupdate /testbench/du_e/mii_debug_e/arptx_e/arp_txen
add wave -noupdate -radix hexadecimal /testbench/du_e/mii_debug_e/arptx_e/arp_txd
add wave -noupdate /testbench/du_e/mii_debug_e/arptx_e/tha_txen
add wave -noupdate /testbench/du_e/mii_debug_e/arptx_e/pfx_txen
add wave -noupdate /testbench/du_e/mii_debug_e/arptx_e/ipsa_txen
add wave -noupdate /testbench/du_e/mii_debug_e/arptx_e/arp_treq
add wave -noupdate /testbench/du_e/mii_debug_e/ethtx_e/eth_txen
add wave -noupdate -radix hexadecimal /testbench/du_e/mii_debug_e/ethtx_e/eth_txd
add wave -noupdate /testbench/du_e/mii_debug_e/ethtx_e/dll_e/pre_txen
add wave -noupdate /testbench/du_e/mii_debug_e/ethtx_e/dll_e/crc32_txen
add wave -noupdate -radix hexadecimal /testbench/du_e/mii_debug_e/ethtx_e/dll_e/crc32_txd
add wave -noupdate -radix hexadecimal /testbench/du_e/mii_debug_e/ethtx_e/pl_txd
add wave -noupdate /testbench/du_e/mii_debug_e/ethtx_e/lat_txen
add wave -noupdate -radix hexadecimal /testbench/du_e/mii_debug_e/ethtx_e/lat_txd
add wave -noupdate /testbench/du_e/mii_debug_e/ethtx_e/dll_txen
add wave -noupdate -radix hexadecimal -childformat {{/testbench/du_e/mii_debug_e/ethtx_e/dll_txd(0) -radix hexadecimal} {/testbench/du_e/mii_debug_e/ethtx_e/dll_txd(1) -radix hexadecimal} {/testbench/du_e/mii_debug_e/ethtx_e/dll_txd(2) -radix hexadecimal} {/testbench/du_e/mii_debug_e/ethtx_e/dll_txd(3) -radix hexadecimal}} -subitemconfig {/testbench/du_e/mii_debug_e/ethtx_e/dll_txd(0) {-height 29 -radix hexadecimal} /testbench/du_e/mii_debug_e/ethtx_e/dll_txd(1) {-height 29 -radix hexadecimal} /testbench/du_e/mii_debug_e/ethtx_e/dll_txd(2) {-height 29 -radix hexadecimal} /testbench/du_e/mii_debug_e/ethtx_e/dll_txd(3) {-height 29 -radix hexadecimal}} /testbench/du_e/mii_debug_e/ethtx_e/dll_txd
add wave -noupdate /testbench/du_e/mii_debug_e/ethtx_e/hwda_txen
add wave -noupdate -radix hexadecimal /testbench/du_e/mii_debug_e/ethtx_e/hwda_txd
add wave -noupdate /testbench/du_e/mii_debug_e/ethtx_e/pl_txen
add wave -noupdate /testbench/du_e/mii_debug_e/ethtx_e/padd_txen
add wave -noupdate -radix hexadecimal /testbench/du_e/mii_debug_e/ethtx_e/padd_txd
add wave -noupdate -divider {New Divider}
add wave -noupdate -radix hexadecimal /testbench/du_e/mii_debug_e/iptx_e/mii1checksum_e/cksm_init
add wave -noupdate -radix hexadecimal /testbench/du_e/mii_debug_e/iptx_e/mii1checksum_e/mii_txd
add wave -noupdate /testbench/du_e/mii_debug_e/iptx_e/pl_txen
add wave -noupdate /testbench/du_e/mii_debug_e/iptx_e/pl_txd
add wave -noupdate /testbench/du_e/mii_debug_e/iptx_e/ip4len_treq
add wave -noupdate /testbench/du_e/mii_debug_e/iptx_e/ip4len_trdy
add wave -noupdate /testbench/du_e/mii_debug_e/iptx_e/ip4len_txen
add wave -noupdate /testbench/du_e/mii_debug_e/iptx_e/ip4len_txd
add wave -noupdate /testbench/du_e/mii_debug_e/iptx_e/ip4sa_treq
add wave -noupdate /testbench/du_e/mii_debug_e/iptx_e/ip4sa_trdy
add wave -noupdate /testbench/du_e/mii_debug_e/iptx_e/ip4sa_txen
add wave -noupdate /testbench/du_e/mii_debug_e/iptx_e/ip4sa_txd
add wave -noupdate /testbench/du_e/mii_debug_e/iptx_e/ip4da_treq
add wave -noupdate /testbench/du_e/mii_debug_e/iptx_e/ip4da_trdy
add wave -noupdate /testbench/du_e/mii_debug_e/iptx_e/ip4da_txen
add wave -noupdate /testbench/du_e/mii_debug_e/iptx_e/ip4da_txd
add wave -noupdate /testbench/du_e/mii_debug_e/iptx_e/cksm_txen
add wave -noupdate -radix hexadecimal /testbench/du_e/mii_debug_e/iptx_e/cksm_txd
add wave -noupdate -radix hexadecimal -childformat {{/testbench/du_e/mii_debug_e/iptx_e/ip4_ptr(0) -radix hexadecimal} {/testbench/du_e/mii_debug_e/iptx_e/ip4_ptr(1) -radix hexadecimal} {/testbench/du_e/mii_debug_e/iptx_e/ip4_ptr(2) -radix hexadecimal} {/testbench/du_e/mii_debug_e/iptx_e/ip4_ptr(3) -radix hexadecimal} {/testbench/du_e/mii_debug_e/iptx_e/ip4_ptr(4) -radix hexadecimal} {/testbench/du_e/mii_debug_e/iptx_e/ip4_ptr(5) -radix hexadecimal} {/testbench/du_e/mii_debug_e/iptx_e/ip4_ptr(6) -radix hexadecimal}} -subitemconfig {/testbench/du_e/mii_debug_e/iptx_e/ip4_ptr(0) {-height 29 -radix hexadecimal} /testbench/du_e/mii_debug_e/iptx_e/ip4_ptr(1) {-height 29 -radix hexadecimal} /testbench/du_e/mii_debug_e/iptx_e/ip4_ptr(2) {-height 29 -radix hexadecimal} /testbench/du_e/mii_debug_e/iptx_e/ip4_ptr(3) {-height 29 -radix hexadecimal} /testbench/du_e/mii_debug_e/iptx_e/ip4_ptr(4) {-height 29 -radix hexadecimal} /testbench/du_e/mii_debug_e/iptx_e/ip4_ptr(5) {-height 29 -radix hexadecimal} /testbench/du_e/mii_debug_e/iptx_e/ip4_ptr(6) {-height 29 -radix hexadecimal}} /testbench/du_e/mii_debug_e/iptx_e/ip4_ptr
add wave -noupdate /testbench/du_e/mii_debug_e/iptx_e/pllat_txen
add wave -noupdate /testbench/du_e/mii_debug_e/iptx_e/mii1checksum_e/slr(0)
add wave -noupdate /testbench/du_e/mii_debug_e/iptx_e/mii1checksum_e/slr
add wave -noupdate /testbench/du_e/mii_debug_e/iptx_e/mii1checksum_e/mii_tena
add wave -noupdate -radix hexadecimal /testbench/du_e/mii_debug_e/iptx_e/mii1checksum_e/mii_txd
add wave -noupdate /testbench/du_e/mii_debug_e/iptx_e/mii1checksum_e/mii_txen
add wave -noupdate /testbench/du_e/mii_debug_e/iptx_e/cksm_tena
add wave -noupdate /testbench/du_e/mii_debug_e/iptx_e/mii1checksum_e/cksm_txen
add wave -noupdate /testbench/du_e/mii_debug_e/iptx_e/shdr_txen
add wave -noupdate /testbench/du_e/mii_debug_e/iptx_e/lenlat_txen
add wave -noupdate /testbench/du_e/mii_debug_e/iptx_e/cksmd_txen
add wave -noupdate /testbench/du_e/mii_debug_e/iptx_e/mii_txc
add wave -noupdate /testbench/du_e/mii_debug_e/iptx_e/ip4_txen
add wave -noupdate -radix hexadecimal -childformat {{/testbench/du_e/mii_debug_e/iptx_e/ip4_txd(0) -radix hexadecimal} {/testbench/du_e/mii_debug_e/iptx_e/ip4_txd(1) -radix hexadecimal} {/testbench/du_e/mii_debug_e/iptx_e/ip4_txd(2) -radix hexadecimal} {/testbench/du_e/mii_debug_e/iptx_e/ip4_txd(3) -radix hexadecimal}} -subitemconfig {/testbench/du_e/mii_debug_e/iptx_e/ip4_txd(0) {-height 29 -radix hexadecimal} /testbench/du_e/mii_debug_e/iptx_e/ip4_txd(1) {-height 29 -radix hexadecimal} /testbench/du_e/mii_debug_e/iptx_e/ip4_txd(2) {-height 29 -radix hexadecimal} /testbench/du_e/mii_debug_e/iptx_e/ip4_txd(3) {-height 29 -radix hexadecimal}} /testbench/du_e/mii_debug_e/iptx_e/ip4_txd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1357955 ps} 0} {{Cursor 2} {25460306 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 219
configure wave -valuecolwidth 100
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
WaveRestoreZoom {25124074 ps} {25780324 ps}
