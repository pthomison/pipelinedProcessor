/*
	Emily Fredette
	efredett@purdue.edu
*/
`ifndef PC_IF_VH
`define PC_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface pc_if;
	// import types
	import cpu_types_pkg::*;

	logic	pcenable, branch, BEQ, zero_f;
  logic [1:0] pcsrc;
  logic [15:0] immed;
	word_t  pcout, immedEXT, rdat1, branch_pc4;

  // file ports
  modport pc (
    input   pcenable, pcsrc, branch, BEQ, zero_f, immedEXT, rdat1, immed, branch_pc4,
    output  pcout
  );
  // testbench ports 
  modport tb (
    input  pcout,
    output   pcenable, pcsrc, branch, BEQ, zero_f, immedEXT, rdat1, immed, branch_pc4
  );
endinterface

`endif //PC_IF_VH
