onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/DUT/CPU/DP/CLK
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/finalHitCounter
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/hitcounter
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/hitcount
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/thitcount
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/misscount
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/tmisscount
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/DUT/CPU/DP/stall
add wave -noupdate -expand -group instr /system_tb/DUT/CPU/dcif/imemload
add wave -noupdate -expand -group instr /system_tb/DUT/CPU/DP/ifid_plif/instruction_out
add wave -noupdate -expand -group instr /system_tb/DUT/CPU/DP/idex_plif/instruction_out
add wave -noupdate -expand -group instr /system_tb/DUT/CPU/DP/exm_plif/instruction_out
add wave -noupdate -expand -group instr /system_tb/DUT/CPU/DP/mwb_plif/instruction_out
add wave -noupdate -group cif /system_tb/DUT/CPU/CM/cif/iwait
add wave -noupdate -group cif /system_tb/DUT/CPU/CM/cif/dwait
add wave -noupdate -group cif /system_tb/DUT/CPU/CM/cif/iREN
add wave -noupdate -group cif /system_tb/DUT/CPU/CM/cif/dREN
add wave -noupdate -group cif /system_tb/DUT/CPU/CM/cif/dWEN
add wave -noupdate -group cif /system_tb/DUT/CPU/CM/cif/iload
add wave -noupdate -group cif /system_tb/DUT/CPU/CM/cif/dload
add wave -noupdate -group cif /system_tb/DUT/CPU/CM/cif/dstore
add wave -noupdate -group cif /system_tb/DUT/CPU/CM/cif/iaddr
add wave -noupdate -group cif /system_tb/DUT/CPU/CM/cif/daddr
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/halt
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/flushed
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/dmemaddr
add wave -noupdate -group ICACHE -expand -subitemconfig {{/system_tb/DUT/CPU/CM/ICACHE/cache[7]} -expand {/system_tb/DUT/CPU/CM/ICACHE/cache[7].addr} -expand} /system_tb/DUT/CPU/CM/ICACHE/cache
add wave -noupdate -group ICACHE -radix hexadecimal -childformat {{/system_tb/DUT/CPU/CM/ICACHE/reqAddr.tag -radix hexadecimal} {/system_tb/DUT/CPU/CM/ICACHE/reqAddr.idx -radix hexadecimal} {/system_tb/DUT/CPU/CM/ICACHE/reqAddr.bytoff -radix hexadecimal}} -expand -subitemconfig {/system_tb/DUT/CPU/CM/ICACHE/reqAddr.tag {-height 17 -radix hexadecimal} /system_tb/DUT/CPU/CM/ICACHE/reqAddr.idx {-height 17 -radix hexadecimal} /system_tb/DUT/CPU/CM/ICACHE/reqAddr.bytoff {-height 17 -radix hexadecimal}} /system_tb/DUT/CPU/CM/ICACHE/reqAddr
add wave -noupdate -group ICACHE /system_tb/DUT/CPU/CM/ICACHE/cdata
add wave -noupdate -group ICACHE /system_tb/DUT/CPU/CM/ICACHE/update
add wave -noupdate -group ICACHE /system_tb/DUT/CPU/CM/ICACHE/prehit
add wave -noupdate -group ICACHE /system_tb/DUT/CPU/CM/ICACHE/currState
add wave -noupdate -group ICACHE /system_tb/DUT/CPU/CM/ICACHE/nextState
add wave -noupdate -group DCACHE -expand /system_tb/DUT/CPU/CM/DCACHE/reqAddr
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/mload
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/mstore
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/updateRead
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/updateWrite
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/updateRecentUsed
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/updateClean
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/loadAddrA
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/loadAddrB
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/avaliableCache
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/destinationDirty
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/prehitOne
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/prehitTwo
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/prehit
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/validOne
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/validTwo
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/wordDestRead
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/wordDestWrite
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/flushCacheSelect
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/flushIdxSelect
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/hitCache
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/cdataOne
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/cdataTwo
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/cdata
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/hitcounter
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/dirtyData
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/dirtyAddr
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/currState
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/nextState
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/cacheTwo
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/cacheOne
add wave -noupdate -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/pcout_out
add wave -noupdate -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/pcout_in
add wave -noupdate -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/flush
add wave -noupdate -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/enable
add wave -noupdate -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/instruction_in
add wave -noupdate -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/rs_in
add wave -noupdate -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/rt_in
add wave -noupdate -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/ALUop_in
add wave -noupdate -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/instruction_out
add wave -noupdate -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/rs_out
add wave -noupdate -group IFID_reg /system_tb/DUT/CPU/DP/ifid_plif/rt_out
add wave -noupdate -group IFID_reg /system_tb/DUT/CPU/dcif/imemload
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/flush
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/enable
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/IDEX/prif/pcout_out
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/IDEX/prif/pcout_in
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/instruction_in
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/rdat1_in
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/rdat2_in
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/rs_in
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/rt_in
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/rd_in
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/shamt_in
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/immed_in
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/ALUop_in
add wave -noupdate -group IDEX_reg -radix binary /system_tb/DUT/CPU/DP/idex_plif/ALUsrc_in
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/pcsrc_in
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/RegDest_in
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/branch_in
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/MemtoReg_in
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/WEN_in
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/jal_in
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/extop_in
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/dWEN_in
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/dREN_in
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/LUI_in
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/BEQ_in
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/instruction_out
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/rdat1_out
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/rdat2_out
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/rs_out
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/rt_out
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/rd_out
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/shamt_out
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/immed_out
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/ALUop_out
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/ALUsrc_out
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/pcsrc_out
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/RegDest_out
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/branch_out
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/MemtoReg_out
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/WEN_out
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/jal_out
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/extop_out
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/dWEN_out
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/dREN_out
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/LUI_out
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/BEQ_out
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/halt_out
add wave -noupdate -group IDEX_reg /system_tb/DUT/CPU/DP/idex_plif/halt_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/flush
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/enable
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/instruction_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/rdat1_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/rdat2_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/pcout_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/outport_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/dmemload_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/wsel_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/rs_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/rt_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/rd_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/shamt_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/immed_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/ALUop_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/ALUsrc_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/pcsrc_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/RegDest_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/branch_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/MemtoReg_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/WEN_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/jal_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/extop_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/dWEN_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/dREN_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/LUI_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/BEQ_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/halt_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/zero_f_in
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/instruction_out
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/rdat1_out
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/rdat2_out
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/pcout_out
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/outport_out
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/dmemload_out
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/wsel_out
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/rs_out
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/rt_out
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/rd_out
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/shamt_out
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/immed_out
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/ALUop_out
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/ALUsrc_out
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/pcsrc_out
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/RegDest_out
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/branch_out
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/MemtoReg_out
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/WEN_out
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/jal_out
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/extop_out
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/dWEN_out
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/dREN_out
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/LUI_out
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/BEQ_out
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/halt_out
add wave -noupdate -group EXM_reg /system_tb/DUT/CPU/DP/exm_plif/zero_f_out
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/flush
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/enable
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/instruction_in
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/rdat1_in
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/rdat2_in
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/pcout_in
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/outport_in
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/dmemload_in
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/wsel_in
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/rs_in
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/rt_in
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/rd_in
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/shamt_in
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/immed_in
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/ALUop_in
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/ALUsrc_in
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/pcsrc_in
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/RegDest_in
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/branch_in
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/MemtoReg_in
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/WEN_in
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/jal_in
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/extop_in
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/dWEN_in
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/dREN_in
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/LUI_in
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/BEQ_in
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/halt_in
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/zero_f_in
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/instruction_out
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/rdat1_out
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/rdat2_out
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/pcout_out
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/outport_out
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/dmemload_out
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/wsel_out
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/rs_out
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/rt_out
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/rd_out
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/shamt_out
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/immed_out
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/ALUop_out
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/ALUsrc_out
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/pcsrc_out
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/RegDest_out
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/branch_out
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/MemtoReg_out
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/WEN_out
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/jal_out
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/extop_out
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/dWEN_out
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/dREN_out
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/LUI_out
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/BEQ_out
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/halt_out
add wave -noupdate -group MWB_reg /system_tb/DUT/CPU/DP/mwb_plif/zero_f_out
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
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/zero_f
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/shamt
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/rdat2
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/portb
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/porta
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/over_f
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/outport
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/neg_f
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/immed
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/extop
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/aluop
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/aluif/ALUsrc
add wave -noupdate -group FU /system_tb/DUT/CPU/DP/fuif/exm_WEN
add wave -noupdate -group FU /system_tb/DUT/CPU/DP/fuif/mwb_wsel_out
add wave -noupdate -group FU /system_tb/DUT/CPU/DP/fuif/exm_wsel_out
add wave -noupdate -group FU /system_tb/DUT/CPU/DP/fuif/idex_rt_out
add wave -noupdate -group FU /system_tb/DUT/CPU/DP/fuif/idex_rs_out
add wave -noupdate -group FU /system_tb/DUT/CPU/DP/fuif/mwb_WEN
add wave -noupdate -group FU /system_tb/DUT/CPU/DP/fuif/ForwardB
add wave -noupdate -group FU /system_tb/DUT/CPU/DP/fuif/ForwardA
add wave -noupdate -group HU /system_tb/DUT/CPU/DP/huif/jmp_flush
add wave -noupdate -group HU /system_tb/DUT/CPU/DP/huif/brch_flush
add wave -noupdate -group HU /system_tb/DUT/CPU/DP/huif/idex_pcsrc_out
add wave -noupdate -group HU /system_tb/DUT/CPU/DP/huif/idex_rt_out
add wave -noupdate -group HU /system_tb/DUT/CPU/DP/huif/ifid_rs_out
add wave -noupdate -group HU /system_tb/DUT/CPU/DP/huif/idex_dren_out
add wave -noupdate -group HU /system_tb/DUT/CPU/DP/huif/lw_nop
add wave -noupdate -group HU /system_tb/DUT/CPU/DP/huif/idex_branch
add wave -noupdate -group HU /system_tb/DUT/CPU/DP/huif/idex_BEQ
add wave -noupdate -group HU /system_tb/DUT/CPU/DP/huif/alu_zero_f
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/dwen_temp
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/rwen_temp
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/immedEXT
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/wdat_temp
add wave -noupdate -group DP /system_tb/DUT/CPU/DP/wsel_temp
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
add wave -noupdate -group PC /system_tb/DUT/CPU/DP/PC/CLK
add wave -noupdate -group PC /system_tb/DUT/CPU/DP/pcif/branch
add wave -noupdate -group PC /system_tb/DUT/CPU/DP/pcif/BEQ
add wave -noupdate -group PC /system_tb/DUT/CPU/DP/pcif/zero_f
add wave -noupdate -group PC /system_tb/DUT/CPU/DP/pcif/pcsrc
add wave -noupdate -group PC /system_tb/DUT/CPU/DP/pcif/immed
add wave -noupdate -group PC /system_tb/DUT/CPU/DP/pcif/immedEXT
add wave -noupdate -group PC /system_tb/DUT/CPU/DP/pcif/rdat1
add wave -noupdate -group PC /system_tb/DUT/CPU/DP/PC/pcif/pcenable
add wave -noupdate -group PC /system_tb/DUT/CPU/DP/PC/PCplus4
add wave -noupdate -group PC /system_tb/DUT/CPU/DP/PC/pcnext
add wave -noupdate -group PC /system_tb/DUT/CPU/DP/PC/pcif/pcout
add wave -noupdate -group PC /system_tb/DUT/CPU/DP/pcif/branch_pc4
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
add wave -noupdate -expand /system_tb/DUT/CPU/DP/RF/register
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {663715955 ps} 0} {{Cursor 2} {4495826 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 226
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
WaveRestoreZoom {663742070 ps} {664045155 ps}
