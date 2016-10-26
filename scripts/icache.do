onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /icache_tb/PROG/testcase
add wave -noupdate /icache_tb/CLK
add wave -noupdate /icache_tb/nRST
add wave -noupdate -expand -group Inputs /icache_tb/dcif/imemREN
add wave -noupdate -expand -group Inputs /icache_tb/dcif/imemaddr
add wave -noupdate -expand -group Outputs /icache_tb/PROG/expected_imemload
add wave -noupdate -expand -group Outputs /icache_tb/DUT/dcif/ihit
add wave -noupdate -expand -group Outputs /icache_tb/DUT/dcif/imemload
add wave -noupdate -expand -group Internal /icache_tb/DUT/cache
add wave -noupdate -expand -group Internal -radix hexadecimal -childformat {{/icache_tb/DUT/reqAddr.tag -radix hexadecimal -childformat {{{[25]} -radix hexadecimal} {{[24]} -radix hexadecimal} {{[23]} -radix hexadecimal} {{[22]} -radix hexadecimal} {{[21]} -radix hexadecimal} {{[20]} -radix hexadecimal} {{[19]} -radix hexadecimal} {{[18]} -radix hexadecimal} {{[17]} -radix hexadecimal} {{[16]} -radix hexadecimal} {{[15]} -radix hexadecimal} {{[14]} -radix hexadecimal} {{[13]} -radix hexadecimal} {{[12]} -radix hexadecimal} {{[11]} -radix hexadecimal} {{[10]} -radix hexadecimal} {{[9]} -radix hexadecimal} {{[8]} -radix hexadecimal} {{[7]} -radix hexadecimal} {{[6]} -radix hexadecimal} {{[5]} -radix hexadecimal} {{[4]} -radix hexadecimal} {{[3]} -radix hexadecimal} {{[2]} -radix hexadecimal} {{[1]} -radix hexadecimal} {{[0]} -radix hexadecimal}}} {/icache_tb/DUT/reqAddr.idx -radix hexadecimal -childformat {{{[3]} -radix hexadecimal} {{[2]} -radix hexadecimal} {{[1]} -radix hexadecimal} {{[0]} -radix hexadecimal}}} {/icache_tb/DUT/reqAddr.bytoff -radix hexadecimal -childformat {{{[1]} -radix hexadecimal} {{[0]} -radix hexadecimal}}}} -subitemconfig {/icache_tb/DUT/reqAddr.tag {-height 17 -radix hexadecimal -childformat {{{[25]} -radix hexadecimal} {{[24]} -radix hexadecimal} {{[23]} -radix hexadecimal} {{[22]} -radix hexadecimal} {{[21]} -radix hexadecimal} {{[20]} -radix hexadecimal} {{[19]} -radix hexadecimal} {{[18]} -radix hexadecimal} {{[17]} -radix hexadecimal} {{[16]} -radix hexadecimal} {{[15]} -radix hexadecimal} {{[14]} -radix hexadecimal} {{[13]} -radix hexadecimal} {{[12]} -radix hexadecimal} {{[11]} -radix hexadecimal} {{[10]} -radix hexadecimal} {{[9]} -radix hexadecimal} {{[8]} -radix hexadecimal} {{[7]} -radix hexadecimal} {{[6]} -radix hexadecimal} {{[5]} -radix hexadecimal} {{[4]} -radix hexadecimal} {{[3]} -radix hexadecimal} {{[2]} -radix hexadecimal} {{[1]} -radix hexadecimal} {{[0]} -radix hexadecimal}}} {/icache_tb/DUT/reqAddr.tag[25]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.tag[24]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.tag[23]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.tag[22]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.tag[21]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.tag[20]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.tag[19]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.tag[18]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.tag[17]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.tag[16]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.tag[15]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.tag[14]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.tag[13]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.tag[12]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.tag[11]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.tag[10]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.tag[9]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.tag[8]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.tag[7]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.tag[6]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.tag[5]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.tag[4]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.tag[3]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.tag[2]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.tag[1]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.tag[0]} {-radix hexadecimal} /icache_tb/DUT/reqAddr.idx {-height 17 -radix hexadecimal -childformat {{{[3]} -radix hexadecimal} {{[2]} -radix hexadecimal} {{[1]} -radix hexadecimal} {{[0]} -radix hexadecimal}}} {/icache_tb/DUT/reqAddr.idx[3]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.idx[2]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.idx[1]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.idx[0]} {-radix hexadecimal} /icache_tb/DUT/reqAddr.bytoff {-height 17 -radix hexadecimal -childformat {{{[1]} -radix hexadecimal} {{[0]} -radix hexadecimal}}} {/icache_tb/DUT/reqAddr.bytoff[1]} {-radix hexadecimal} {/icache_tb/DUT/reqAddr.bytoff[0]} {-radix hexadecimal}} /icache_tb/DUT/reqAddr
add wave -noupdate -expand -group Internal /icache_tb/DUT/mdata
add wave -noupdate -expand -group Internal /icache_tb/DUT/cdata
add wave -noupdate -expand -group Internal /icache_tb/DUT/prehit
add wave -noupdate -expand -group Internal /icache_tb/DUT/currState
add wave -noupdate -expand -group Internal /icache_tb/DUT/nextState
add wave -noupdate -group dcif /icache_tb/DUT/dcif/halt
add wave -noupdate -group dcif /icache_tb/DUT/dcif/ihit
add wave -noupdate -group dcif /icache_tb/DUT/dcif/imemREN
add wave -noupdate -group dcif /icache_tb/DUT/dcif/imemload
add wave -noupdate -group dcif /icache_tb/DUT/dcif/imemaddr
add wave -noupdate -group dcif /icache_tb/DUT/dcif/dhit
add wave -noupdate -group dcif /icache_tb/DUT/dcif/datomic
add wave -noupdate -group dcif /icache_tb/DUT/dcif/dmemREN
add wave -noupdate -group dcif /icache_tb/DUT/dcif/dmemWEN
add wave -noupdate -group dcif /icache_tb/DUT/dcif/flushed
add wave -noupdate -group dcif /icache_tb/DUT/dcif/dmemload
add wave -noupdate -group dcif /icache_tb/DUT/dcif/dmemstore
add wave -noupdate -group dcif /icache_tb/DUT/dcif/dmemaddr
add wave -noupdate -group cif /icache_tb/DUT/cif/iwait
add wave -noupdate -group cif /icache_tb/DUT/cif/dwait
add wave -noupdate -group cif /icache_tb/DUT/cif/iREN
add wave -noupdate -group cif /icache_tb/DUT/cif/dREN
add wave -noupdate -group cif /icache_tb/DUT/cif/dWEN
add wave -noupdate -group cif /icache_tb/DUT/cif/iload
add wave -noupdate -group cif /icache_tb/DUT/cif/dload
add wave -noupdate -group cif /icache_tb/DUT/cif/dstore
add wave -noupdate -group cif /icache_tb/DUT/cif/iaddr
add wave -noupdate -group cif /icache_tb/DUT/cif/daddr
add wave -noupdate -group cif /icache_tb/DUT/cif/ccwait
add wave -noupdate -group cif /icache_tb/DUT/cif/ccinv
add wave -noupdate -group cif /icache_tb/DUT/cif/ccwrite
add wave -noupdate -group cif /icache_tb/DUT/cif/cctrans
add wave -noupdate -group cif /icache_tb/DUT/cif/ccsnoopaddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {55366 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
configure wave -timelineunits ns
update
WaveRestoreZoom {20463 ps} {214713 ps}
