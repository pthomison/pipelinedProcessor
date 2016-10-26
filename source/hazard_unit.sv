/*
Patrick Thomison
Emily Fredette
hazard unit
*/
`include "cpu_types_pkg.vh"


module hazard_unit (
  input CLK, 
  hazard_unit_if huif
);

  import cpu_types_pkg::*;

always_comb begin 
	huif.lw_nop = 0;

	// if 
	if ((huif.idex_dren_out == 1) && ((huif.idex_rt_out == huif.ifid_rs_out) || (huif.idex_rt_out == huif.ifid_rt_out))) begin
		huif.lw_nop = 1;
	end
end

//00 if PC+4
//01 if JR
//10 if BEQ/BNE
//11 if J/JAL
always_comb begin


 casez(huif.idex_pcsrc_out) 
 	1:	begin
 			huif.jmp_flush = 1;
 			huif.brch_flush = 0;
 		end
 	2:	begin
 			if (huif.idex_BEQ && huif.idex_branch && huif.alu_zero_f) begin
 				huif.brch_flush = 1;
 				huif.jmp_flush = 0;
 			end
 			else if (!huif.idex_BEQ && huif.idex_branch && !huif.alu_zero_f) begin
 				huif.brch_flush = 1;
 				huif.jmp_flush = 0;
 			end
 			else begin
 				huif.brch_flush = 0;
 				huif.jmp_flush = 0;
 			end
 		end
 	3:	begin
 			huif.jmp_flush = 1;
 			huif.brch_flush = 0;
 		end
 	default:	begin
 			huif.jmp_flush = 0;
 			huif.brch_flush = 0;
 	end 
 endcase

end
endmodule