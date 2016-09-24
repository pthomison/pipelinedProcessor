/*
	Emily Fredette
	efredett@purdue.edu

	register file
	lab 1
*/

`include "cpu_types_pkg.vh"
`include "alu_file_if.vh"

module alu_file(
	alu_file_if.af aluif
);

import cpu_types_pkg::*;
//aluop_t aluopcodes;

word_t portb_temp;

always_comb begin
//aluif.over_f = 0;

		portb_temp = aluif.rdat2;
		if (aluif.ALUsrc == 00) begin
			portb_temp = aluif.rdat2;
		end
		else if (aluif.ALUsrc == 01) begin
			case (aluif.extop) 
				0: portb_temp = {16'h0000, aluif.immed};
				1: portb_temp = $signed(aluif.immed);
			endcase
		end
		else begin
			portb_temp = {16'h0000, aluif.shamt};
		end





casez(aluif.aluop)
	ALU_SLL	: begin
		aluif.zero_f = 0;
		aluif.over_f = 0;
		aluif.neg_f = 0;
		aluif.outport = aluif.porta << portb_temp;

		if (aluif.outport == 32'b0) 
			aluif.zero_f = 1;
		if (aluif.outport[31] == 1) 
			aluif.neg_f = 1;
		
		end



	ALU_SRL	: begin
		aluif.zero_f = 0;
		aluif.over_f = 0;
		aluif.neg_f = 0;

		aluif.outport = aluif.porta >> portb_temp;

		if (aluif.outport == 32'b0) 
			aluif.zero_f = 1;
		if (aluif.outport[31] == 1) 
			aluif.neg_f = 1;

		end

	ALU_ADD : begin
		aluif.zero_f = 0;
		aluif.over_f = 0;
		aluif.neg_f = 0;

		aluif.outport = $signed(aluif.porta) + $signed(portb_temp);

		if ( aluif.porta[31] == 1 && portb_temp[31] == 1 ) begin
			if ( aluif.outport[31] == 0) 
				aluif.over_f = 1;
		end

		if ( aluif.porta[31] == 0 && portb_temp[31] == 0 ) begin
			if (aluif.outport[31] == 1)
				aluif.over_f = 1;
		end

		if (aluif.outport == 32'b0) 
			aluif.zero_f = 1;
		if (aluif.outport[31] == 1) 
			aluif.neg_f = 1;
		
		

		end


	ALU_SUB : begin
		aluif.zero_f = 0;
		aluif.over_f = 0;
		aluif.neg_f = 0;

		aluif.outport = $signed(aluif.porta) - $signed(portb_temp);

		if ( ( aluif.porta[31] == 1 && portb_temp[31] == 0 ) && aluif.outport[31] == 0)
			aluif.over_f = 1;

		if ( aluif.porta[31] == 0 && portb_temp[31] == 1 )begin
			if (aluif.outport[31] == 1) 
				aluif.over_f = 1;
		end
		
		if (aluif.outport == 32'b0000000000000000000000000000000) 
			aluif.zero_f = 1;
		if (aluif.outport[31] == 1) 
			aluif.neg_f = 1;


	end

	ALU_AND : begin
		aluif.outport = aluif.porta & portb_temp;

		aluif.zero_f = 0;
		aluif.over_f = 0;
		aluif.neg_f = 0;

		if (aluif.outport == 32'b0) 
			aluif.zero_f = 1;
		if (aluif.outport[31] == 1) 
			aluif.neg_f = 1;
	end
	ALU_OR	: begin
		aluif.outport = aluif.porta | portb_temp;

		aluif.zero_f = 0;
		aluif.over_f = 0;
		aluif.neg_f = 0;

		if (aluif.outport == 32'b0) 
			aluif.zero_f = 1;
		if (aluif.outport[31] == 1) 
			aluif.neg_f = 1;
	end

	ALU_XOR	: begin

		aluif.outport = aluif.porta ^ portb_temp;

		aluif.zero_f = 0;
		aluif.over_f = 0;
		aluif.neg_f = 0;

		if (aluif.outport == 32'b0) 
			aluif.zero_f = 1;
		if (aluif.outport[31] == 1) 
			aluif.neg_f = 1;
	end


	ALU_NOR	: begin

		aluif.outport = ~ (aluif.porta | portb_temp);

		aluif.zero_f = 0;
		aluif.over_f = 0;
		aluif.neg_f = 0;

		if (aluif.outport == 32'b0) 
			aluif.zero_f = 1;
		if (aluif.outport[31] == 1) 
			aluif.neg_f = 1;
	end


	ALU_SLT	: begin

		if ( $signed(aluif.porta) < $signed(portb_temp) )
			aluif.outport = 1;
		else
			aluif.outport = 0;

		aluif.zero_f = 0;
		aluif.over_f = 0;
		aluif.neg_f = 0;

		if (aluif.outport == 32'b0) 
			aluif.zero_f = 1;
		if (aluif.outport[31] == 1) 
			aluif.neg_f = 1;

	end


	ALU_SLTU	: begin

		if ( aluif.porta < portb_temp )
			aluif.outport = 1;
		else
			aluif.outport = 0;

		aluif.zero_f = 0;
		aluif.over_f = 0;
		aluif.neg_f = 0;

		if (aluif.outport == 32'b0) 
			aluif.zero_f = 1;
		if (aluif.outport[31] == 1) 
			aluif.neg_f = 1;

	end
	
endcase
end

endmodule
