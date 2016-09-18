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

	logic	pcenable;
	word_t  pcnext, pcout;

  // file ports
  modport pc (
    input   pcenable, pcnext,
    output  pcout
  );
  // testbench ports 
  modport tb (
    input  pcout,
    output  pcenable, pcnext
  );
endinterface

`endif //PC_IF_VH
