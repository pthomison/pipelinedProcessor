onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/DUT/CPU/DP/CU/opcode
add wave -noupdate /system_tb/DUT/CPU/DP/CU/funct
add wave -noupdate -expand -group CU /system_tb/DUT/CPU/DP/CU/opcode
add wave -noupdate -expand -group CU /system_tb/DUT/CPU/DP/CU/funct
add wave -noupdate -expand -group CU /system_tb/DUT/CPU/DP/CU/cuif/branch
add wave -noupdate -expand -group CU /system_tb/DUT/CPU/DP/CU/cuif/MemtoReg
add wave -noupdate -expand -group CU /system_tb/DUT/CPU/DP/CU/cuif/WEN
add wave -noupdate -expand -group CU /system_tb/DUT/CPU/DP/CU/cuif/jal
add wave -noupdate -expand -group CU /system_tb/DUT/CPU/DP/CU/cuif/extop
add wave -noupdate -expand -group CU /system_tb/DUT/CPU/DP/CU/cuif/dWEN
add wave -noupdate -expand -group CU /system_tb/DUT/CPU/DP/CU/cuif/dREN
add wave -noupdate -expand -group CU /system_tb/DUT/CPU/DP/CU/cuif/LUI
add wave -noupdate -expand -group CU /system_tb/DUT/CPU/DP/CU/cuif/imemREN
add wave -noupdate -expand -group CU /system_tb/DUT/CPU/DP/CU/cuif/BEQ
add wave -noupdate -expand -group CU -radix unsigned /system_tb/DUT/CPU/DP/CU/cuif/rs
add wave -noupdate -expand -group CU -radix unsigned /system_tb/DUT/CPU/DP/CU/cuif/rt
add wave -noupdate -expand -group CU -radix unsigned /system_tb/DUT/CPU/DP/CU/cuif/rd
add wave -noupdate -expand -group CU /system_tb/DUT/CPU/DP/CU/cuif/immed
add wave -noupdate -expand -group CU /system_tb/DUT/CPU/DP/immedEXT
add wave -noupdate -expand -group CU /system_tb/DUT/CPU/DP/CU/cuif/ALUop
add wave -noupdate -expand -group CU /system_tb/DUT/CPU/DP/CU/cuif/ALUsrc
add wave -noupdate -expand -group CU -radix binary /system_tb/DUT/CPU/DP/CU/cuif/jump
add wave -noupdate -expand -group CU -radix binary /system_tb/DUT/CPU/DP/CU/cuif/RegDest
add wave -noupdate -expand -group CU /system_tb/DUT/CPU/DP/CU/cuif/instruction
add wave -noupdate -expand -group CU /system_tb/DUT/CPU/DP/CU/cuif/shamt
add wave -noupdate -expand -group RF /system_tb/DUT/CPU/DP/RF/rfif/WEN
add wave -noupdate -expand -group RF -radix unsigned /system_tb/DUT/CPU/DP/RF/rfif/wsel
add wave -noupdate -expand -group RF /system_tb/DUT/CPU/DP/RF/rfif/rsel1
add wave -noupdate -expand -group RF -radix unsigned /system_tb/DUT/CPU/DP/RF/rfif/rsel2
add wave -noupdate -expand -group RF /system_tb/DUT/CPU/DP/RF/rfif/wdat
add wave -noupdate -expand -group RF /system_tb/DUT/CPU/DP/RF/rfif/rdat1
add wave -noupdate -expand -group RF /system_tb/DUT/CPU/DP/RF/rfif/rdat2
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/neg_f
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/over_f
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/zero_f
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/porta
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/portb
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/outport
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/aluop
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/immedEXT
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/dpif/halt
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/dpif/datomic
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/dpif/flushed
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/dpif/dmemaddr
add wave -noupdate -group SCIF /system_tb/DUT/CPU/scif/ramREN
add wave -noupdate -group SCIF /system_tb/DUT/CPU/scif/ramWEN
add wave -noupdate -group SCIF /system_tb/DUT/CPU/scif/ramaddr
add wave -noupdate -group SCIF /system_tb/DUT/CPU/scif/ramstore
add wave -noupdate -group SCIF /system_tb/DUT/CPU/scif/ramload
add wave -noupdate -group SCIF /system_tb/DUT/CPU/scif/ramstate
add wave -noupdate -group SCIF /system_tb/DUT/CPU/scif/memREN
add wave -noupdate -group SCIF /system_tb/DUT/CPU/scif/memWEN
add wave -noupdate -group SCIF /system_tb/DUT/CPU/scif/memaddr
add wave -noupdate -group SCIF /system_tb/DUT/CPU/scif/memstore
add wave -noupdate -group CCIF /system_tb/DUT/CPU/ccif/iwait
add wave -noupdate -group CCIF /system_tb/DUT/CPU/ccif/dwait
add wave -noupdate -group CCIF /system_tb/DUT/CPU/ccif/iREN
add wave -noupdate -group CCIF /system_tb/DUT/CPU/ccif/dREN
add wave -noupdate -group CCIF /system_tb/DUT/CPU/ccif/dWEN
add wave -noupdate -group CCIF /system_tb/DUT/CPU/ccif/iload
add wave -noupdate -group CCIF /system_tb/DUT/CPU/ccif/dload
add wave -noupdate -group CCIF /system_tb/DUT/CPU/ccif/dstore
add wave -noupdate -group CCIF /system_tb/DUT/CPU/ccif/iaddr
add wave -noupdate -group CCIF /system_tb/DUT/CPU/ccif/daddr
add wave -noupdate -group CCIF /system_tb/DUT/CPU/ccif/ccwait
add wave -noupdate -group CCIF /system_tb/DUT/CPU/ccif/ccinv
add wave -noupdate -group CCIF /system_tb/DUT/CPU/ccif/ccwrite
add wave -noupdate -group CCIF /system_tb/DUT/CPU/ccif/cctrans
add wave -noupdate -group CCIF /system_tb/DUT/CPU/ccif/ccsnoopaddr
add wave -noupdate -group CCIF /system_tb/DUT/CPU/ccif/ramWEN
add wave -noupdate -group CCIF /system_tb/DUT/CPU/ccif/ramREN
add wave -noupdate -group CCIF /system_tb/DUT/CPU/ccif/ramstate
add wave -noupdate -group CCIF /system_tb/DUT/CPU/ccif/ramaddr
add wave -noupdate -group CCIF /system_tb/DUT/CPU/ccif/ramstore
add wave -noupdate -group CCIF /system_tb/DUT/CPU/ccif/ramload
add wave -noupdate -expand -group PC /system_tb/DUT/CPU/DP/PC/pcif/pcenable
add wave -noupdate -expand -group PC /system_tb/DUT/CPU/DP/PC/pcif/pcnext
add wave -noupdate -expand -group PC /system_tb/DUT/CPU/DP/PC/pcif/pcout
add wave -noupdate -group RAMIF /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -group RAMIF /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -group RAMIF /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -group RAMIF /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -group RAMIF /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -group RAMIF /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -group RAMIF /system_tb/DUT/RAM/ramif/memREN
add wave -noupdate -group RAMIF /system_tb/DUT/RAM/ramif/memWEN
add wave -noupdate -group RAMIF /system_tb/DUT/RAM/ramif/memaddr
add wave -noupdate -group RAMIF /system_tb/DUT/RAM/ramif/memstore
add wave -noupdate -group RU /system_tb/DUT/CPU/DP/RU/ruif/ihit
add wave -noupdate -group RU /system_tb/DUT/CPU/DP/RU/ruif/dhit
add wave -noupdate -group RU /system_tb/DUT/CPU/DP/RU/ruif/dwen
add wave -noupdate -group RU /system_tb/DUT/CPU/DP/RU/ruif/dren
add wave -noupdate -group RU /system_tb/DUT/CPU/DP/RU/ruif/dmemren
add wave -noupdate -group RU /system_tb/DUT/CPU/DP/RU/ruif/dmemwen
add wave -noupdate -group RU /system_tb/DUT/CPU/DP/RU/ruif/pcenable
add wave -noupdate -expand /system_tb/DUT/CPU/DP/RF/register
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1186744 ps} 0}
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
WaveRestoreZoom {1017347 ps} {1355038 ps}
