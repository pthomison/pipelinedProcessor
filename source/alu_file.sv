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

always_comb begin
//aluif.over_f = 0;


casez(aluif.aluop)
	ALU_SLL	: begin
		aluif.zero_f = 0;
		aluif.over_f = 0;
		aluif.neg_f = 0;
		aluif.outport = aluif.porta << aluif.portb;

		if (aluif.outport == 32'b0) 
			aluif.zero_f = 1;
		if (aluif.outport[31] == 1) 
			aluif.neg_f = 1;
		
		end



	ALU_SRL	: begin
		aluif.zero_f = 0;
		aluif.over_f = 0;
		aluif.neg_f = 0;

		aluif.outport = aluif.porta >> aluif.portb;

		if (aluif.outport == 32'b0) 
			aluif.zero_f = 1;
		if (aluif.outport[31] == 1) 
			aluif.neg_f = 1;

		end

	ALU_ADD : begin
		aluif.zero_f = 0;
		aluif.over_f = 0;
		aluif.neg_f = 0;

		aluif.outport = $signed(aluif.porta) + $signed(aluif.portb);

		if ( aluif.porta[31] == 1 && aluif.portb[31] == 1 ) begin
			if ( aluif.outport[31] == 0) 
				aluif.over_f = 1;
		end

		if ( aluif.porta[31] == 0 && aluif.portb[31] == 0 ) begin
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

		aluif.outport = $signed(aluif.porta) - $signed(aluif.portb);

		if ( ( aluif.porta[31] == 1 && aluif.portb[31] == 0 ) && aluif.outport[31] == 0)
			aluif.over_f = 1;

		if ( aluif.porta[31] == 0 && aluif.portb[31] == 1 )begin
			if (aluif.outport[31] == 1) 
				aluif.over_f = 1;
		end
		
		if (aluif.outport == 32'b0000000000000000000000000000000) 
			aluif.zero_f = 1;
		if (aluif.outport[31] == 1) 
			aluif.neg_f = 1;


	end

	ALU_AND : begin
		aluif.outport = aluif.porta & aluif.portb;

		aluif.zero_f = 0;
		aluif.over_f = 0;
		aluif.neg_f = 0;

		if (aluif.outport == 32'b0) 
			aluif.zero_f = 1;
		if (aluif.outport[31] == 1) 
			aluif.neg_f = 1;
	end
	ALU_OR	: begin
		aluif.outport = aluif.porta | aluif.portb;

		aluif.zero_f = 0;
		aluif.over_f = 0;
		aluif.neg_f = 0;

		if (aluif.outport == 32'b0) 
			aluif.zero_f = 1;
		if (aluif.outport[31] == 1) 
			aluif.neg_f = 1;
	end

	ALU_XOR	: begin

		aluif.outport = aluif.porta ^ aluif.portb;

		aluif.zero_f = 0;
		aluif.over_f = 0;
		aluif.neg_f = 0;

		if (aluif.outport == 32'b0) 
			aluif.zero_f = 1;
		if (aluif.outport[31] == 1) 
			aluif.neg_f = 1;
	end


	ALU_NOR	: begin

		aluif.outport = ~ (aluif.porta | aluif.portb);

		aluif.zero_f = 0;
		aluif.over_f = 0;
		aluif.neg_f = 0;

		if (aluif.outport == 32'b0) 
			aluif.zero_f = 1;
		if (aluif.outport[31] == 1) 
			aluif.neg_f = 1;
	end


	ALU_SLT	: begin

		if ( $signed(aluif.porta) < $signed(aluif.portb) )
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

		if ( aluif.porta < aluif.portb )
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
