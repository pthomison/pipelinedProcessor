onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /icache_tb/CLK
add wave -noupdate /icache_tb/nRST
add wave -noupdate -group Inputs /icache_tb/dcif/imemREN
add wave -noupdate -group Inputs /icache_tb/dcif/imemaddr
add wave -noupdate -group Inputs /icache_tb/cif/iwait
add wave -noupdate -group Inputs /icache_tb/cif/iload
add wave -noupdate -group Outputs /icache_tb/dcif/ihit
add wave -noupdate -group Outputs /icache_tb/cif/iaddr
add wave -noupdate -group Outputs /icache_tb/cif/iREN
add wave -noupdate -group Outputs /icache_tb/dcif/imemload
add wave -noupdate -group Outputs /icache_tb/PROG/expected_imemload
add wave -noupdate -group Internal /icache_tb/DUT/cacheAddr
add wave -noupdate -group Internal /icache_tb/DUT/cacheData
add wave -noupdate -group Internal /icache_tb/DUT/cacheValid
add wave -noupdate -group Internal /icache_tb/DUT/reqAddr
add wave -noupdate -group Internal /icache_tb/DUT/mdata
add wave -noupdate -group Internal /icache_tb/DUT/cdata
add wave -noupdate -group Internal /icache_tb/DUT/update
add wave -noupdate -group Internal /icache_tb/DUT/valid
add wave -noupdate -group Internal /icache_tb/DUT/tagEqual
add wave -noupdate -group Internal /icache_tb/DUT/prehit
add wave -noupdate -group Internal /icache_tb/DUT/currState
add wave -noupdate -group Internal /icache_tb/DUT/nextState
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {75 ns} 0}
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
WaveRestoreZoom {0 ns} {1134 ns}
