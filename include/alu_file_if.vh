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

	logic	neg_f, over_f, zero_f;
	word_t	porta, portb, outport;
	aluop_t	aluop;

  // alu file ports
  modport af (
    input   porta, portb, aluop,
    output  outport, neg_f, over_f, zero_f
  );
  // alu file tb
  modport tb (
    input  outport, neg_f, over_f, zero_f,
    output  porta, portb, aluop
  );
endinterface

`endif //ALU_FILE_IF_VH
