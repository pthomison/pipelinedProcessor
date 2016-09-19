/*
Patrick Thomison
00256-74870

Emily Fredette
00257-26474

Interface for pipeline registers
*/

`ifndef PL_IF_VH
`define PL_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface  pl_if;
	// import types
	import cpu_types_pkg::*;

	logic flush, enable;

	word_t shamt_in, instruction_in, rdat1_in, rdat2_in, PCplus4_in, outport_in, dmemload_in;
	regbits_t wsel_in;
	logic [4:0] rs_in, rt_in, rd_in;
	logic [15:0] immed_in;
	aluop_t ALUop_in;
	logic [1:0] ALUsrc_in, pcSrc_in, RegDest_in;
	logic branch_in, MemtoReg_in, WEN_in, jal_in, extop_in, dWEN_in, dREN_in, LUI_in, BEQ_in, halt_in, zero_f_in;

	word_t shamt_out, instruction_out, rdat1_out, rdat2_out, PCplus4_out, outport_out, dmemload_out;
	regbits_t wsel_out;
	logic [4:0] rs_out, rt_out, rd_out;
	logic [15:0] immed_out;
	aluop_t ALUop_out;
	logic [1:0] ALUsrc_out, pcSrc_out, RegDest_out;
	logic branch_out, MemtoReg_out, WEN_out, jal_out, extop_out, dWEN_out, dREN_out, LUI_out, BEQ_out, halt_out, zero_f_out;


	modport plr (
		input shamt_in, instruction_in, rdat1_in, rdat2_in, PCplus4_in, outport_in, dmemload_in, wsel_in
		rs_in, rt_in, rd_in, immed_in, ALUop_in, ALUsrc_in, pcSrc_in, RegDest_in, branch_in, MemtoReg_in,
		WEN_in, jal_in, extop_in, dWEN_in, dREN_in, LUI_in, BEQ_in, halt_in, zero_f_in, flush,
		output shamt_out, instruction_out, rdat1_out, rdat2_out, PCplus4_out, outport_out, dmemload_out,
		wsel_out, rs_out, rt_out, rd_out, immed_out, ALUop_out, ALUsrc_out, pcSrc_out, RegDest_out,
		branch_out, MemtoReg_out, WEN_out, jal_out, extop_out, dWEN_out, dREN_out, LUI_out, BEQ_out, halt_out, zero_f_out;
	);

	modport tb (
		output shamt_in, instruction_in, rdat1_in, rdat2_in, PCplus4_in, outport_in, dmemload_in, wsel_in
		rs_in, rt_in, rd_in, immed_in, ALUop_in, ALUsrc_in, pcSrc_in, RegDest_in, branch_in, MemtoReg_in,
		WEN_in, jal_in, extop_in, dWEN_in, dREN_in, LUI_in, BEQ_in, halt_in, zero_f_in, flush,
		input shamt_out, instruction_out, rdat1_out, rdat2_out, PCplus4_out, outport_out, dmemload_out,
		wsel_out, rs_out, rt_out, rd_out, immed_out, ALUop_out, ALUsrc_out, pcSrc_out, RegDest_out,
		branch_out, MemtoReg_out, WEN_out, jal_out, extop_out, dWEN_out, dREN_out, LUI_out, BEQ_out, halt_out, zero_f_out;
	);

endinterface

