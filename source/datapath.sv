/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"
    //input   ihit, imemload, dhit, dmemload,
    //output  halt, imemREN, imemaddr, dmemREN, dmemWEN, datomic, dmemstore, dmemaddr

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

`include "pc_if.vh"
`include "register_file_if.vh"
`include "control_unit_if.vh"
`include "request_unit_if.vh"
`include "alu_file_if.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
  import cpu_types_pkg::*;

  // pc init
  parameter PC_INIT = 0;


	//Other Signals
	word_t immedEXT;
	word_t PCplus4;
	logic temphalt;
	//logic temp_



	//5 interfaces
  	pc_if pcif();
  	request_unit_if ruif();
  	control_unit_if cuif();
  	register_file_if rfif();
  	alu_file_if aluif();

	//Function Blocks
  	pc PC(CLK, nRST, pcif.pc);
  	request_unit RU(CLK, nRST, ruif.ru);
  	control_unit CU(cuif.cu);
  	register_file RF(CLK, nRST, rfif.rf);
	alu_file ALU(aluif.af);

	assign PCplus4 = pcif.pcout + 4;



	//Immediate Extend
	always_comb begin
		immedEXT = {16'h0000, cuif.immed};
		if (cuif.extop == 0) begin
			//zero extend
			immedEXT = {16'h0000, cuif.immed};
		end
		else begin
			//signed extend
			immedEXT = $signed(cuif.immed);
		end
	end




	//
	//DATAPATH 
	//


	assign dpif.imemREN = cuif.imemREN;

	//assign dpif.halt = cuif.halt;


	assign dpif.dmemREN = ruif.dmemren;
	assign dpif.imemaddr = pcif.pcout; //pcout
	assign dpif.dmemWEN = ruif.dmemwen;
	assign dpif.dmemstore = rfif.rdat2; //rdat2
	assign dpif.dmemaddr = aluif.outport; //output of ALU


	always_ff @(posedge CLK, negedge nRST) begin
		if (!nRST) begin
			temphalt = 0;
		end
		else begin
			temphalt = cuif.halt;

		end
	end
	assign dpif.halt = temphalt;


	//
	//PC BLOCK
	//
	//inputs pcenable, pcnext,
	//output pcout

	assign pcif.pcenable = ruif.pcenable;
	
	//PC 4 way mux
	always_comb begin
		pcif.pcnext = PCplus4;
		if (cuif.jump == 00) begin
			pcif.pcnext = PCplus4;
		end
		else if (cuif.jump == 01) begin
			pcif.pcnext = rfif.rdat1;
		end
		else if (cuif.jump == 2'b10) begin
			if (cuif.BEQ) begin
				if (cuif.branch && aluif.zero_f) begin
					pcif.pcnext = (immedEXT << 2) + PCplus4;
				end
				else begin
					pcif.pcnext = PCplus4;
				end
			end
			else begin
				if (cuif.branch && aluif.zero_f) begin
					pcif.pcnext = PCplus4;
				end
				else begin
					pcif.pcnext = (immedEXT << 2) + PCplus4;
				end
			end
		

		end
		else if (cuif.jump == 2'b11) begin
			pcif.pcnext = {PCplus4[31:28], cuif.immed[15:0], 2'b00};
		end
	end






	//
	//REQUEST UNIT BLOCK
	//
	//inputs ihit, dhit, dwen, dren
	//outputs dmemren, dmemwen, pcenable
	assign ruif.ihit = dpif.ihit;
	assign ruif.dhit = dpif.dhit;
	assign ruif.dwen = cuif.dWEN;
	assign ruif.dren = cuif.dREN;

		
	//
	//CONTROL UNIT BLOCK
	//
	//inputs instruction
	//outputs
	assign cuif.instruction = dpif.imemload;







	//
	//REGISTER FILE BLOCK
	//

	//RF inputs: WEN, wsel, rsel1, rsel2, wdat
	//output  rdat1, rdat2

	assign rfif.WEN = cuif.WEN && (dpif.ihit || dpif.dhit);
	assign rfif.rsel1 = cuif.rs;
	assign rfif.rsel2 = cuif.rt;
	//assign rfif.wdat = aluif.outport;

	//LUI case
	always_comb begin
		rfif.wdat = {cuif.immed, 16'h0000};
		if (cuif.LUI) begin
			rfif.wdat = {cuif.immed, 16'h0000};
		end
		else if (cuif.MemtoReg) begin
			rfif.wdat = dpif.dmemload;
		end
		else if (cuif.jal) begin
			rfif.wdat = PCplus4;
		end
		else begin
			rfif.wdat = aluif.outport;
		end
	end

	//Register File WSEL Mux
	always_comb begin
		rfif.wsel = cuif.rd;
		if (cuif.RegDest == 00) begin
			rfif.wsel = cuif.rd;
		end
		else if (cuif.RegDest == 01) begin
			rfif.wsel = cuif.rt;
		end
		else if (cuif.RegDest == 2'b10) begin
			rfif.wsel = 31;
		end
	end
















	//
	//ALU UNIT BLOCK
	//

	assign aluif.porta = rfif.rdat1;
	assign aluif.aluop = cuif.ALUop;
	
	
	//ALU 3 way mux
	always_comb begin
		aluif.portb = rfif.rdat2;
		if (cuif.ALUsrc == 00) begin
			aluif.portb = rfif.rdat2;
		end
		else if (cuif.ALUsrc == 01) begin
			aluif.portb = immedEXT;
		end
		else begin
			aluif.portb = cuif.shamt;
		end
	end















endmodule


