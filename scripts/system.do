onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/DUT/CPU/DP/CU/opcode
add wave -noupdate /system_tb/DUT/CPU/DP/CU/funct
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/flush
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/enable
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/shamt_in
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/instruction_in
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/rdat1_in
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/rdat2_in
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/PCplus4_in
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/outport_in
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/dmemload_in
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/wsel_in
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/rs_in
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/rt_in
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/rd_in
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/immed_in
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/ALUop_in
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/ALUsrc_in
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/pcsrc_in
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/RegDest_in
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/branch_in
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/MemtoReg_in
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/WEN_in
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/jal_in
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/extop_in
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/dWEN_in
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/dREN_in
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/LUI_in
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/BEQ_in
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/halt_in
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/zero_f_in
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/shamt_out
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/instruction_out
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/rdat1_out
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/rdat2_out
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/PCplus4_out
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/outport_out
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/dmemload_out
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/wsel_out
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/rs_out
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/rt_out
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/rd_out
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/immed_out
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/ALUop_out
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/ALUsrc_out
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/pcsrc_out
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/RegDest_out
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/branch_out
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/MemtoReg_out
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/WEN_out
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/jal_out
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/extop_out
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/dWEN_out
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/dREN_out
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/LUI_out
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/BEQ_out
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/halt_out
add wave -noupdate -expand -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/zero_f_out
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/CU/opcode
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/CU/funct
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/CU/cuif/branch
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/CU/cuif/MemtoReg
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/CU/cuif/WEN
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/CU/cuif/jal
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/CU/cuif/extop
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/CU/cuif/dWEN
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/CU/cuif/dREN
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/CU/cuif/LUI
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/CU/cuif/imemREN
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/CU/cuif/BEQ
add wave -noupdate -group CU -radix unsigned /system_tb/DUT/CPU/DP/CU/cuif/rs
add wave -noupdate -group CU -radix unsigned /system_tb/DUT/CPU/DP/CU/cuif/rt
add wave -noupdate -group CU -radix unsigned /system_tb/DUT/CPU/DP/CU/cuif/rd
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/CU/cuif/immed
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/immedEXT
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/CU/cuif/ALUop
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/CU/cuif/ALUsrc
add wave -noupdate -group CU -radix binary /system_tb/DUT/CPU/DP/CU/cuif/RegDest
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/CU/cuif/instruction
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/CU/cuif/shamt
add wave -noupdate -group RF /system_tb/DUT/CPU/DP/RF/rfif/WEN
add wave -noupdate -group RF -radix unsigned /system_tb/DUT/CPU/DP/RF/rfif/wsel
add wave -noupdate -group RF /system_tb/DUT/CPU/DP/RF/rfif/rsel1
add wave -noupdate -group RF -radix unsigned /system_tb/DUT/CPU/DP/RF/rfif/rsel2
add wave -noupdate -group RF /system_tb/DUT/CPU/DP/RF/rfif/wdat
add wave -noupdate -group RF /system_tb/DUT/CPU/DP/RF/rfif/rdat1
add wave -noupdate -group RF /system_tb/DUT/CPU/DP/RF/rfif/rdat2
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/neg_f
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/over_f
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/zero_f
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/porta
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/portb
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/outport
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/aluop
add wave -noupdate -expand -group DP /system_tb/DUT/CPU/DP/immedEXT
add wave -noupdate -expand -group DP /system_tb/DUT/CPU/DP/dpif/halt
add wave -noupdate -expand -group DP /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate -expand -group DP /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate -expand -group DP /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -expand -group DP /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate -expand -group DP /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate -expand -group DP /system_tb/DUT/CPU/DP/dpif/datomic
add wave -noupdate -expand -group DP /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate -expand -group DP /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate -expand -group DP /system_tb/DUT/CPU/DP/dpif/flushed
add wave -noupdate -expand -group DP /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate -expand -group DP /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate -expand -group DP /system_tb/DUT/CPU/DP/dpif/dmemaddr
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
add wave -noupdate -group PC /system_tb/DUT/CPU/DP/PC/pcif/pcenable
add wave -noupdate -group PC /system_tb/DUT/CPU/DP/PC/pcif/pcout
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
add wave -noupdate -expand /system_tb/DUT/CPU/DP/RF/register
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {109822 ps} 0}
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
WaveRestoreZoom {0 ps} {231306 ps}
