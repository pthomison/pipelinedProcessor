/*
	Emily Fredette
	efredett@purdue.edu
*/
`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH

// all types
//`include "cpu_types_pkg.vh"

interface request_unit_if;
	// import types
	//import cpu_types_pkg::*;

	logic	ihit, dhit, dwen, dren, dmemren, dmemwen;

  // file ports
  modport ru (
    input   ihit, dhit, dwen, dren,
    output  dmemren, dmemwen
  );
  // testbench ports 
  modport tb (
    input  dmemren, dmemwen,
    output  ihit, dhit, dwen, dren
  );
endinterface

`endif //REQUEST_UNIT_IF_VH
