/*
Patrick Thomison
Emily Fredette
hazard unit
*/
`include "cpu_types_pkg.vh"


module hazard_unit (
  hazard_unit_if huif
);

  import cpu_types_pkg::*;

always_comb begin 
	huif.lw_nop = 0;
	if ((huif.idex_dren_out == 1) && 
		((huif.idex_rt_out == huif.ifid_rs_out) || 
			(huif.idex_rt_out == huif.idif_rt_out)))
	begin
		huif.lw_nop = 1;
	end
end

//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
always_comb 
begin
	huif.jmp_flush = 0;
	huif.brch_flush = 0;

	if (huif.idex_pcsrc_out == 3) begin
		huif.jmp_flush = 1;
	end else if (huif.idex_pcsrc_out == 2) begin
		huif.brch_flush = 1;
	end
end

endmodule