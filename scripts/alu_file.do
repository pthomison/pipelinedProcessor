onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /alu_file_tb/CLK
add wave -noupdate /alu_file_tb/nRST
add wave -noupdate /alu_file_tb/v1
add wave -noupdate /alu_file_tb/v2
add wave -noupdate /alu_file_tb/v3
add wave -noupdate /alu_file_tb/aluif/neg_f
add wave -noupdate /alu_file_tb/aluif/over_f
add wave -noupdate /alu_file_tb/aluif/zero_f
add wave -noupdate -radix decimal /alu_file_tb/aluif/porta
add wave -noupdate -radix decimal /alu_file_tb/aluif/portb
add wave -noupdate -radix decimal /alu_file_tb/aluif/outport
add wave -noupdate /alu_file_tb/aluif/aluop
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {676 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 92
configure wave -valuecolwidth 264
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
WaveRestoreZoom {617 ns} {723 ns}
