onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /control_unit_tb/CLK
add wave -noupdate /control_unit_tb/nRST
add wave -noupdate /control_unit_tb/v1
add wave -noupdate /control_unit_tb/v2
add wave -noupdate /control_unit_tb/v3
add wave -noupdate /control_unit_tb/cuif/PCsrc
add wave -noupdate /control_unit_tb/cuif/MemtoReg
add wave -noupdate /control_unit_tb/cuif/WEN
add wave -noupdate /control_unit_tb/cuif/jal
add wave -noupdate /control_unit_tb/cuif/extop
add wave -noupdate /control_unit_tb/cuif/dWEN
add wave -noupdate /control_unit_tb/cuif/dREN
add wave -noupdate /control_unit_tb/cuif/LUI
add wave -noupdate /control_unit_tb/cuif/imemREN
add wave -noupdate /control_unit_tb/cuif/BEQ
add wave -noupdate -radix binary /control_unit_tb/cuif/rs
add wave -noupdate /control_unit_tb/cuif/rt
add wave -noupdate /control_unit_tb/cuif/rd
add wave -noupdate /control_unit_tb/cuif/immed
add wave -noupdate /control_unit_tb/cuif/ALUop
add wave -noupdate /control_unit_tb/cuif/ALUsrc
add wave -noupdate /control_unit_tb/cuif/jump
add wave -noupdate /control_unit_tb/cuif/RegDest
add wave -noupdate -radix binary /control_unit_tb/cuif/instruction
add wave -noupdate /control_unit_tb/cuif/shamt
add wave -noupdate /control_unit_tb/DUT/op
add wave -noupdate /control_unit_tb/DUT/funct
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {12 ns} 0}
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
WaveRestoreZoom {0 ns} {32 ns}
