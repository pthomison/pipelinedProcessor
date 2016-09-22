/*
	Emily Fredette
	efredett@purdue.edu
*/
`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface control_unit_if;
	// import types
	import cpu_types_pkg::*;

	logic branch, MemtoReg, WEN, jal, extop, dWEN, dREN, LUI, imemREN, BEQ, halt, itype;
	logic [4:0] rs, rt, rd, shamt;
	logic [15:0] immed;
	aluop_t ALUop;
	logic [1:0] ALUsrc, pcsrc, RegDest;
	word_t  instruction;

  // file ports
  modport cu (
    input   instruction,
    output  ALUop, ALUsrc, branch, MemtoReg, WEN, RegDest, pcsrc, jal, extop, dWEN, dREN, rs, rt, rd, immed, LUI, imemREN, shamt, BEQ, halt, itype
  );
  // testbench ports 
  modport tb (
    input  ALUop, ALUsrc, branch, MemtoReg, WEN, RegDest, pcsrc, jal, extop, dWEN, dREN, rs, rt, rd, immed, LUI, imemREN, shamt, BEQ, halt, itype,
    output  instruction
  );
endinterface

`endif //CONTROL_UNIT_IF_VH
