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

	regbits_t exm_WEN, exm_rd_out, idex_rt_out, idex_rs_out;
	regbits_t mwb_WEN, mwb_rd_out;

	logic[1:0] ForwardB, ForwardA;


	modport fu (
		input exm_WEN, exm_rd_out, idex_rt_out, idex_rs_out, mwb_WEN, mwb_rd_out,
		output ForwardB, ForwardA
	);

	modport tb (
		output ForwardB, ForwardA,
		input exm_WEN, exm_rd_out, idex_rt_out, idex_rs_out, mwb_WEN, mwb_rd_out
	);

endinterface

`endif 