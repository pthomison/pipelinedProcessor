/*
Patrick Thomison
00256-74870

Emily Fredette
00257-26474

datapath for pipeline
*/

// data path interface
`include "datapath_cache_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

`include "pc_if.vh"
`include "register_file_if.vh"
`include "control_unit_if.vh"
`include "request_unit_if.vh"
`include "alu_file_if.vh"
`include "pipeline_register_if.vh"


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

	//interfaces
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

	// Pipeline Registers
	pipeline_register_if ifid_plif ();
	pipeline_register_if idex_plif ();
	pipeline_register_if exm_plif ();
	pipeline_register_if mwb_plif ();

	pipeline_register IFID(CLK, nRST, ifid_plif);
	pipeline_register IDEX(CLK, nRST, idex_plif);
	pipeline_register EXM(CLK, nRST, exm_plif);
	pipeline_register MWB(CLK, nRST, mwb_plif);

	assign PCplus4 = pcif.pcout + 4;





	//
	//IFID Pipeline Register Assignments
	//
	assign ifid_plif.enable = 1;
	assign ifid_plif.instruction_in = dpif.imemload;
	assign ifid_plif.PCplus4_in = PCplus4;
	assign cuif.instruction = ifid_plif.instruction_out;








	//
	//Immediate Extend
	//
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
	//input   ihit, imemload, dhit, dmemload,
    //output  halt, imemREN, imemaddr, dmemREN, dmemWEN, datomic, dmemstore, dmemaddr

	assign dpif.imemREN = cuif.imemREN;
	assign dpif.dmemREN = ruif.dmemren;
	assign dpif.imemaddr = pcif.pcout; 
	assign dpif.dmemWEN = ruif.dmemwen;
	assign dpif.dmemstore = rfif.rdat2; 
	assign dpif.dmemaddr = aluif.outport; 

	//HALT latch
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

	assign pcif.branch = cuif.branch;
	assign pcif.BEQ = cuif.BEQ;
	assign pcif.zero_f = aluif.zero_f;
	assign pcif.pcsrc = cuif.pcsrc;
	assign pcif.immedEXT = immedEXT;
	assign pcif.pcenable = dpif.ihit;
	assign pcif.rdat1 = rfif.rdat1;
	assign pcif.immed = cuif.immed;










	//
	//REQUEST UNIT BLOCK
	//
	//inputs ihit, dhit, dwen, dren
	//outputs dmemren, dmemwen
	assign ruif.ihit = dpif.ihit;
	assign ruif.dhit = dpif.dhit;
	assign ruif.dwen = cuif.dWEN;
	assign ruif.dren = cuif.dREN;











		
	//
	//CONTROL UNIT BLOCK
	//
	//inputs instruction
	//outputs
	//assign cuif.instruction = dpif.imemload;















	//
	//REGISTER FILE BLOCK
	//

	//inputs: WEN, wsel, rsel1, rsel2, wdat
	//output  rdat1, rdat2

	assign rfif.WEN = cuif.WEN && (dpif.ihit || dpif.dhit);
	assign rfif.rsel1 = cuif.rs;
	assign rfif.rsel2 = cuif.rt;

	//wdat
	//LUI, MemtoReg, JAL MUX
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

	//wsel MUX
	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
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

	//ALU src mux
	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
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


