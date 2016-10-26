/*
Patrick Thomison
Emily Fredette
generic pipeline register
*/
`include "cpu_types_pkg.vh"


module pipeline_register (
	input logic CLK, nRST,
	pipeline_register_if prif
);

	import cpu_types_pkg::*;

always_ff @(posedge CLK, negedge nRST)
begin
	if (nRST == 0) begin 
		prif.shamt_out <= 0;
		prif.instruction_out <= 0;
		prif.rdat1_out <= 0;
		prif.rdat2_out <= 0;
		prif.pcout_out <= 0;
		prif.outport_out <= 0;
		prif.dmemload_out <= 0;
		prif.wsel_out <= 0;
		prif.rs_out <= 0;
		prif.rt_out <= 0;
		prif.rd_out <= 0;
		prif.immed_out <= 0;
		prif.ALUop_out <= aluop_t'(0000);
		prif.ALUsrc_out <= 0;
		prif.pcsrc_out <= 0;
		prif.RegDest_out <= 0;
		prif.branch_out <= 0;
		prif.MemtoReg_out <= 0;
		prif.WEN_out <= 0;
		prif.jal_out <= 0;
		prif.extop_out <= 0;
		prif.dWEN_out <= 0;
		prif.dREN_out <= 0;
		prif.LUI_out <= 0;
		prif.BEQ_out <= 0;
		prif.halt_out <= 0;
		prif.zero_f_out <= 0;
		prif.itype_out <= 0;

	end else if (prif.flush == 1) begin
		prif.shamt_out <= 0;
		prif.instruction_out <= 0;
		prif.rdat1_out <= 0;
		prif.rdat2_out <= 0;
		prif.pcout_out <= 0;
		prif.outport_out <= 0;
		prif.dmemload_out <= 0;
		prif.wsel_out <= 0;
		prif.rs_out <= 0;
		prif.rt_out <= 0;
		prif.rd_out <= 0;
		prif.immed_out <= 0;
		prif.ALUop_out <= aluop_t'(0000);
		prif.ALUsrc_out <= 0;
		prif.pcsrc_out <= 0;
		prif.RegDest_out <= 0;
		prif.branch_out <= 0;
		prif.MemtoReg_out <= 0;
		prif.WEN_out <= 0;
		prif.jal_out <= 0;
		prif.extop_out <= 0;
		prif.dWEN_out <= 0;
		prif.dREN_out <= 0;
		prif.LUI_out <= 0;
		prif.BEQ_out <= 0;
		prif.halt_out <= 0;
		prif.zero_f_out <= 0;
		prif.itype_out <= 0;
	end else begin
		if (prif.enable) begin
			prif.shamt_out <= prif.shamt_in;
			prif.instruction_out <= prif.instruction_in;
			prif.rdat1_out <= prif.rdat1_in;
			prif.rdat2_out <= prif.rdat2_in;
			prif.pcout_out <= prif.pcout_in;
			prif.outport_out <= prif.outport_in;
			prif.dmemload_out <= prif.dmemload_in;
			prif.wsel_out <= prif.wsel_in;
			prif.rs_out <= prif.rs_in;
			prif.rt_out <= prif.rt_in;
			prif.rd_out <= prif.rd_in;
			prif.immed_out <= prif.immed_in;
			prif.ALUop_out <= prif.ALUop_in;
			prif.ALUsrc_out <= prif.ALUsrc_in;
			prif.pcsrc_out <= prif.pcsrc_in;
			prif.RegDest_out <= prif.RegDest_in;
			prif.branch_out <= prif.branch_in;
			prif.MemtoReg_out <= prif.MemtoReg_in;
			prif.WEN_out <= prif.WEN_in;
			prif.jal_out <= prif.jal_in;
			prif.extop_out <= prif.extop_in;
			prif.dWEN_out <= prif.dWEN_in;
			prif.dREN_out <= prif.dREN_in;
			prif.LUI_out <= prif.LUI_in;
			prif.BEQ_out <= prif.BEQ_in;
			prif.halt_out <= prif.halt_in;
			prif.zero_f_out <= prif.zero_f_in;
			prif.itype_out <= prif.itype_in;
		end else if (prif.clearMemReq == 1) begin
			prif.dWEN_out <= 0;
			prif.dREN_out <= 0;
			prif.dmemload_out <= prif.memData;
		end
	end 
end

endmodule