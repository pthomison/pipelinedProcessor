/*
  Eric Villasenor
  evillase@gmail.com

  register file interface
*/
/*
	Emily Fredette
	efredett@purdue.edu

	register file
	lab 1
*/
`ifndef ALU_FILE_IF_VH
`define ALU_FILE_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface alu_file_if;
	// import types
	import cpu_types_pkg::*;

	logic	neg_f, over_f, zero_f, extop;
	word_t	porta, portb, outport, rdat2;
	aluop_t	aluop;
  logic [15:0] immed;
  logic [4:0] shamt;
  logic [1:0] ALUsrc;

  // alu file ports
  modport af (
    input   porta, portb, aluop, ALUsrc, shamt, extop, immed, rdat2,
    output  outport, neg_f, over_f, zero_f
  );
  // alu file tb
  modport tb (
    input  outport, neg_f, over_f, zero_f,
    output  porta, portb, aluop
  );
endinterface

`endif //ALU_FILE_IF_VH
