/*
Patrick Thomison
00256-74870

Emily Fredette
00257-26474

Interface for hazard
*/

`ifndef HAZARD_UNIT_IF_VH
`define HAZARD_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface  hazard_unit_if;
	// import types
	import cpu_types_pkg::*;

	regbits_t idex_rt_out, ifid_rs_out, ifid_rt_out;
	logic idex_dren_out, lw_nop, jmp_flush, brch_flush, idex_BEQ, idex_branch, alu_zero_f;

	logic[1:0] idex_pcsrc_out;


	modport hu (
		input idex_rt_out, ifid_rs_out, ifid_rt_out, idex_dren_out, idex_pcsrc_out, idex_BEQ, idex_branch, alu_zero_f, 
		output lw_nop, jmp_flush, brch_flush
	);

	modport tb (
		input lw_nop, jmp_flush, brch_flush,
		output idex_rt_out, ifid_rs_out, ifid_rt_out, idex_dren_out, idex_pcsrc_out, idex_BEQ, idex_branch, alu_zero_f
	);

endinterface

`endif 