/*
	Emily Fredette
	PC unit
*/

// interface
`include "pc_if.vh"

module pc (
  input CLK, nRST,
  pc_if.pc pcif
);
	// type import
	import cpu_types_pkg::*;

	word_t PCplus4, pcnext;

	always_ff @(posedge CLK, negedge nRST) begin
		if (!nRST) begin
			pcif.pcout = '0;
		end

		else if (pcif.pcenable) begin
			pcif.pcout = pcnext;
		end
	end



	//PC 4 way mux
	//00 if PC+4 -
	//01 if JR
	//10 if BEQ or BNE 
	//11 if J or JAL
	always_comb begin
		PCplus4 = pcif.pcout + 4;
		pcnext = PCplus4;

		if (pcif.pcsrc == 2'b00) begin
			pcnext = PCplus4;
		end

		else if (pcif.pcsrc == 2'b01) begin
			pcnext = pcif.rdat1;
		end

		else if (pcif.pcsrc == 2'b10) begin
			if (pcif.BEQ) begin
				if (pcif.branch && pcif.zero_f) begin
					pcnext = (pcif.immedEXT << 2) + pcif.branch_pc4-4;
				end
				else begin
					pcnext = PCplus4;
				end
			end
			else begin
				if (pcif.branch && !pcif.zero_f) begin
					pcnext = (pcif.immedEXT << 2) + pcif.branch_pc4; //CRAZY CRAZY CRAZY this is so broken 
				end
				else begin
					pcnext = PCplus4;
				end
			end
		end

		else if (pcif.pcsrc == 2'b11) begin
			pcnext = {PCplus4[31:28], pcif.immed[15:0], 2'b00};
		end

	end
endmodule
