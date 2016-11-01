onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /coherence_control_tb/CLK
add wave -noupdate /coherence_control_tb/nRST
add wave -noupdate /coherence_control_tb/DUT/currState
add wave -noupdate /coherence_control_tb/DUT/nextState
add wave -noupdate /coherence_control_tb/PROG/testcase
add wave -noupdate /coherence_control_tb/PROG/issue
add wave -noupdate -group DUT /coherence_control_tb/DUT/rdata2
add wave -noupdate -group DUT /coherence_control_tb/DUT/rdata1
add wave -noupdate -group DUT /coherence_control_tb/DUT/nextState
add wave -noupdate -group DUT /coherence_control_tb/DUT/nextReq
add wave -noupdate -group DUT /coherence_control_tb/DUT/newRData2
add wave -noupdate -group DUT /coherence_control_tb/DUT/newRData1
add wave -noupdate -group DUT /coherence_control_tb/DUT/nRST
add wave -noupdate -group DUT /coherence_control_tb/DUT/currState
add wave -noupdate -group DUT /coherence_control_tb/DUT/currReq
add wave -noupdate -group DUT /coherence_control_tb/DUT/CLK
add wave -noupdate -group MCIF /coherence_control_tb/DUT/mcif/ramstore
add wave -noupdate -group MCIF /coherence_control_tb/DUT/mcif/ramstate
add wave -noupdate -group MCIF /coherence_control_tb/DUT/mcif/ramload
add wave -noupdate -group MCIF /coherence_control_tb/DUT/mcif/ramaddr
add wave -noupdate -group MCIF /coherence_control_tb/DUT/mcif/ramWEN
add wave -noupdate -group MCIF /coherence_control_tb/DUT/mcif/ramREN
add wave -noupdate -group MCIF /coherence_control_tb/DUT/mcif/iwait
add wave -noupdate -group MCIF /coherence_control_tb/DUT/mcif/iload
add wave -noupdate -group MCIF /coherence_control_tb/DUT/mcif/iaddr
add wave -noupdate -group MCIF /coherence_control_tb/DUT/mcif/iREN
add wave -noupdate -group MCIF /coherence_control_tb/DUT/mcif/dwait
add wave -noupdate -group MCIF /coherence_control_tb/DUT/mcif/dstore
add wave -noupdate -group MCIF /coherence_control_tb/DUT/mcif/dload
add wave -noupdate -group MCIF /coherence_control_tb/DUT/mcif/daddr
add wave -noupdate -group MCIF /coherence_control_tb/DUT/mcif/dWEN
add wave -noupdate -group MCIF /coherence_control_tb/DUT/mcif/dREN
add wave -noupdate -group MCIF /coherence_control_tb/DUT/mcif/ccwrite
add wave -noupdate -group MCIF /coherence_control_tb/DUT/mcif/ccwait
add wave -noupdate -group MCIF /coherence_control_tb/DUT/mcif/cctrans
add wave -noupdate -group MCIF /coherence_control_tb/DUT/mcif/ccsnoopaddr
add wave -noupdate -group MCIF /coherence_control_tb/DUT/mcif/ccinv
add wave -noupdate -group MCIF /coherence_control_tb/DUT/mcif/CPUS
add wave -noupdate -group CIF /coherence_control_tb/DUT/cif/ramstore
add wave -noupdate -group CIF /coherence_control_tb/DUT/cif/ramstate
add wave -noupdate -group CIF /coherence_control_tb/DUT/cif/ramload
add wave -noupdate -group CIF /coherence_control_tb/DUT/cif/ramaddr
add wave -noupdate -group CIF /coherence_control_tb/DUT/cif/ramWEN
add wave -noupdate -group CIF /coherence_control_tb/DUT/cif/ramREN
add wave -noupdate -group CIF /coherence_control_tb/DUT/cif/iwait
add wave -noupdate -group CIF /coherence_control_tb/DUT/cif/iload
add wave -noupdate -group CIF /coherence_control_tb/DUT/cif/iaddr
add wave -noupdate -group CIF /coherence_control_tb/DUT/cif/iREN
add wave -noupdate -group CIF -radix binary /coherence_control_tb/DUT/cif/dwait
add wave -noupdate -group CIF /coherence_control_tb/DUT/cif/dstore
add wave -noupdate -group CIF /coherence_control_tb/DUT/cif/dload
add wave -noupdate -group CIF /coherence_control_tb/DUT/cif/daddr
add wave -noupdate -group CIF -radix binary /coherence_control_tb/DUT/cif/dWEN
add wave -noupdate -group CIF -radix binary /coherence_control_tb/DUT/cif/dREN
add wave -noupdate -group CIF -radix binary /coherence_control_tb/DUT/cif/ccwrite
add wave -noupdate -group CIF -radix binary /coherence_control_tb/DUT/cif/ccwait
add wave -noupdate -group CIF -radix binary /coherence_control_tb/DUT/cif/cctrans
add wave -noupdate -group CIF -expand /coherence_control_tb/DUT/cif/ccsnoopaddr
add wave -noupdate -group CIF /coherence_control_tb/DUT/cif/ccinv
add wave -noupdate -group CIF /coherence_control_tb/DUT/cif/CPUS
add wave -noupdate -group cache0 /coherence_control_tb/cache0/iwait
add wave -noupdate -group cache0 /coherence_control_tb/cache0/dwait
add wave -noupdate -group cache0 /coherence_control_tb/cache0/iREN
add wave -noupdate -group cache0 /coherence_control_tb/cache0/dREN
add wave -noupdate -group cache0 /coherence_control_tb/cache0/dWEN
add wave -noupdate -group cache0 /coherence_control_tb/cache0/iload
add wave -noupdate -group cache0 /coherence_control_tb/cache0/dload
add wave -noupdate -group cache0 /coherence_control_tb/cache0/dstore
add wave -noupdate -group cache0 /coherence_control_tb/cache0/iaddr
add wave -noupdate -group cache0 /coherence_control_tb/cache0/daddr
add wave -noupdate -group cache0 /coherence_control_tb/cache0/ccwait
add wave -noupdate -group cache0 /coherence_control_tb/cache0/ccinv
add wave -noupdate -group cache0 /coherence_control_tb/cache0/ccwrite
add wave -noupdate -group cache0 /coherence_control_tb/cache0/cctrans
add wave -noupdate -group cache0 /coherence_control_tb/cache0/ccsnoopaddr
add wave -noupdate -group cache1 /coherence_control_tb/cache1/ccinv
add wave -noupdate -group cache1 /coherence_control_tb/cache1/ccsnoopaddr
add wave -noupdate -group cache1 /coherence_control_tb/cache1/cctrans
add wave -noupdate -group cache1 /coherence_control_tb/cache1/ccwait
add wave -noupdate -group cache1 /coherence_control_tb/cache1/ccwrite
add wave -noupdate -group cache1 /coherence_control_tb/cache1/dREN
add wave -noupdate -group cache1 /coherence_control_tb/cache1/dWEN
add wave -noupdate -group cache1 /coherence_control_tb/cache1/daddr
add wave -noupdate -group cache1 /coherence_control_tb/cache1/dload
add wave -noupdate -group cache1 /coherence_control_tb/cache1/dstore
add wave -noupdate -group cache1 /coherence_control_tb/cache1/dwait
add wave -noupdate -group cache1 /coherence_control_tb/cache1/iREN
add wave -noupdate -group cache1 /coherence_control_tb/cache1/iaddr
add wave -noupdate -group cache1 /coherence_control_tb/cache1/iload
add wave -noupdate -group cache1 /coherence_control_tb/cache1/iwait
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {26 ns} 0}
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
WaveRestoreZoom {0 ns} {263 ns}
