onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /memory_control_tb/CLK
add wave -noupdate /memory_control_tb/nRST
add wave -noupdate /memory_control_tb/v1
add wave -noupdate /memory_control_tb/v2
add wave -noupdate /memory_control_tb/v3
add wave -noupdate /memory_control_tb/cache0/iwait
add wave -noupdate /memory_control_tb/cache0/dwait
add wave -noupdate /memory_control_tb/cache0/iREN
add wave -noupdate /memory_control_tb/cache0/dREN
add wave -noupdate /memory_control_tb/cache0/dWEN
add wave -noupdate /memory_control_tb/cache0/iload
add wave -noupdate /memory_control_tb/cache0/dload
add wave -noupdate /memory_control_tb/cache0/dstore
add wave -noupdate /memory_control_tb/cache0/iaddr
add wave -noupdate /memory_control_tb/cache0/daddr
add wave -noupdate /memory_control_tb/cache0/ccwait
add wave -noupdate /memory_control_tb/cache0/ccinv
add wave -noupdate /memory_control_tb/cache0/ccwrite
add wave -noupdate /memory_control_tb/cache0/cctrans
add wave -noupdate /memory_control_tb/cache0/ccsnoopaddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {13233 ps} 0}
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
WaveRestoreZoom {0 ps} {63 ns}
