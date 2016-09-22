/*
Patrick Thomison
00256-74870

Emily Fredette
00257-26474

Interface for FORWARD
*/

`ifndef FORWARD_UNIT_IF_VH
`define FORWARD_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface  forward_unit_if;
	// import types
	import cpu_types_pkg::*;

	regbits_t idex_rt_out, idex_rs_out, exm_wsel_out, mwb_wsel_out;
	logic mwb_WEN, exm_WEN;
	logic exm_itype_out, mwb_itype_out;
	logic[1:0] ForwardB, ForwardA;


	modport fu (
		input exm_WEN, idex_rt_out, idex_rs_out, mwb_WEN, exm_itype_out, mwb_itype_out, exm_wsel_out, mwb_wsel_out,
		output ForwardB, ForwardA
	);

	modport tb (
		output ForwardB, ForwardA,
		input exm_WEN, idex_rt_out, idex_rs_out, mwb_WEN, exm_itype_out, mwb_itype_out, exm_wsel_out, mwb_wsel_out
	);

endinterface

`endif 


  //exm_rt_out
  //exm_itype_out
  //mwb_rt_out
