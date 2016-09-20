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
  	register_file RF(!CLK, nRST, rfif.rf);
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

	//
	// Instruction Fetch: PC Block
	//
	// inputs
	assign pcif.pcenable = dpif.ihit;
	assign pcif.pcsrc    = 0; // UPDATE FOR PC_CHG INSTR
	
	assign pcif.rdat1    = 0; // dc, UPDATE FOR PC_CHG INSTR
	assign pcif.immed    = 0; // dc, UPDATE FOR PC_CHG INSTR
	// assign pcif.branch   = 0; // dc, UPDATE FOR PC_CHG INSTR
	// assign pcif.BEQ      = 0; // dc, UPDATE FOR PC_CHG INSTR
	// assign pcif.zero_f   = 0; // dc, UPDATE FOR PC_CHG INSTR
	assign pcif.immedEXT = 0; // dc, UPDATE FOR PC_CHG INSTR

	assign dpif.imemREN = cuif.imemREN;
	
	// outputs
	assign dpif.imemaddr = pcif.pcout;

	//
	//IFID Pipeline Register Assignments
	//

	// Control Signals
	assign ifid_plif.enable = (exm_plif.dREN_out || exm_plif.dWEN_out)  ? dpif.dhit: dpif.ihit;//1; // UPDATE FOR PC_CHG INSTR
	assign ifid_plif.flush  = 0; // UPDATE FOR PC_CHG INSTR

	// Input Assignments
	assign ifid_plif.instruction_in = dpif.imemload;
	assign ifid_plif.pcout_in       = pcif.pcout;

	//
	// Instruction Decode: Control Unit, Register File
	//

	assign cuif.instruction = ifid_plif.instruction_out;

	assign rfif.rsel1 = cuif.rs;
	assign rfif.rsel2 = cuif.rt;

	assign rfif.WEN   = mwb_plif.WEN_out; //mwb_plif.MemtoReg_out ? mwb_plif.WEN_out && dpif.dhit: mwb_plif.WEN_out;// && (dpif.ihit || dpif.dhit);

	//assign rfif.wdat  = mwb_plif.MemtoReg_out ? mwb_plif.dmemload_out : mwb_plif.outport_out;
	assign rfif.wsel  = mwb_plif.wsel_out;

	//wdat
	//LUI, MemtoReg, JAL MUX
	always_comb begin
		// rfif.wdat = {mwb_plif.immed, 16'h0000};
		if (mwb_plif.LUI_out) begin
			rfif.wdat = {mwb_plif.immed_out, 16'h0000};
		end
		else if (mwb_plif.MemtoReg_out) begin
			rfif.wdat = mwb_plif.dmemload_out;
		end
		// else if (cuif.jal) begin
		// 	rfif.wdat = PCplus4;
		// end
		else begin
			rfif.wdat = mwb_plif.outport_out;
		end
	end

	//
	//IDEX Pipeline Register Assignments
	//

	// Control Signals
	assign idex_plif.enable = (exm_plif.dREN_out || exm_plif.dWEN_out)  ? dpif.dhit: dpif.ihit;//1; // UPDATE FOR PC_CHG INSTR
	assign idex_plif.flush  = 0; // UPDATE FOR PC_CHG INSTR

	// Input Assignments
	// assign idex_plif.PCplus4_in  = ifid_plif.PCplus4_out;
	assign idex_plif.rdat1_in    = rfif.rdat1;
	assign idex_plif.rdat2_in    = rfif.rdat2;
	assign idex_plif.halt_in     = cuif.halt;

	// Execute Control Signals
	assign idex_plif.immed_in    = cuif.immed;
	assign idex_plif.extop_in    = cuif.extop;
	assign idex_plif.shamt_in    = cuif.shamt;
	assign idex_plif.ALUsrc_in   = cuif.ALUsrc;
	assign idex_plif.RegDest_in  = cuif.RegDest;
	assign idex_plif.ALUop_in    = cuif.ALUop;
	assign idex_plif.rd_in       = cuif.rd;
	assign idex_plif.rt_in       = cuif.rt;
	// Memory Control Signals
	assign idex_plif.dWEN_in     = cuif.dWEN;
	assign idex_plif.dREN_in     = cuif.dREN;
	assign idex_plif.BEQ_in      = cuif.BEQ;
	assign idex_plif.branch_in   = cuif.branch;
	// Write Back Control Signals
	assign idex_plif.WEN_in      = cuif.WEN;
	assign idex_plif.MemtoReg_in = cuif.MemtoReg;
	assign idex_plif.jal_in      = cuif.jal;
	assign idex_plif.LUI_in      = cuif.LUI;
	assign idex_plif.pcsrc_in    = cuif.pcsrc;

	// Output Assignments

	//
	// Execute: WSEL Block & ALU
	//

	//wsel MUX
	regbits_t wsel_temp;
	always_comb 
	begin
		casez(idex_plif.RegDest_out)
			0: wsel_temp = idex_plif.rd_out; // if RD
			1: wsel_temp = idex_plif.rt_out; // if RT
			2:wsel_temp = 31;                // if REG31 
		default: wsel_temp = idex_plif.rd_out;
	endcase
	end

	// ALU
	assign aluif.porta           = idex_plif.rdat1_out;
	assign aluif.rdat2           = idex_plif.rdat2_out;
	assign aluif.aluop           = idex_plif.ALUop_out;
	assign aluif.extop           = idex_plif.extop_out;
	assign aluif.immed           = idex_plif.immed_out;
	assign aluif.shamt           = idex_plif.shamt_out;
	assign aluif.ALUsrc          = idex_plif.ALUsrc_out;

	//
	//EXM Pipeline Register Assignments
	//
	
	// Control Signals
	assign exm_plif.enable = (exm_plif.dREN_out || exm_plif.dWEN_out)  ? dpif.dhit: dpif.ihit;//1; // UPDATE FOR PC_CHG INSTR
	assign exm_plif.flush  = 0; // UPDATE FOR PC_CHG INSTR

	// Input Assignments
	assign exm_plif.immed_in    = idex_plif.immed_out;
	assign exm_plif.zero_f_in   = aluif.zero_f;
	assign exm_plif.outport_in  = aluif.outport;
	assign exm_plif.wsel_in     = wsel_temp;
	assign exm_plif.rdat2_in    = idex_plif.rdat2_out;
	assign exm_plif.halt_in     = idex_plif.halt_out;
 
	// Memory Control Signals
	assign exm_plif.dWEN_in     = idex_plif.dWEN_out;
	assign exm_plif.dREN_in     = idex_plif.dREN_out;
	assign exm_plif.BEQ_in      = idex_plif.BEQ_out;
	assign exm_plif.branch_in   = idex_plif.branch_out;
	// Write Back Control Signals
	assign exm_plif.WEN_in      = idex_plif.WEN_out;
	assign exm_plif.MemtoReg_in = idex_plif.MemtoReg_out;
	assign exm_plif.jal_in      = idex_plif.jal_out;
	assign exm_plif.LUI_in      = idex_plif.LUI_out;
	assign exm_plif.pcsrc_in    = idex_plif.pcsrc_out;

	// Outputs
	assign ruif.dren            = exm_plif.dREN_out;
	assign ruif.dwen            = exm_plif.dWEN_out;
	assign pcif.BEQ             = exm_plif.BEQ_out;
	assign pcif.branch          = exm_plif.branch_out;
	assign pcif.zero_f          = exm_plif.zero_f_out; 

	//
	// Memory: Request Interactions
	//

	assign dpif.dmemstore = exm_plif.rdat2_out; 
	assign dpif.dmemaddr = exm_plif.outport_out; 


	//
	//MWB Pipeline Register Assignments
	//
	// Control Signals
	assign mwb_plif.enable = (exm_plif.dREN_out || exm_plif.dWEN_out)  ? dpif.dhit: dpif.ihit;//1; // UPDATE FOR PC_CHG INSTR
	assign mwb_plif.flush  = 0;
	assign mwb_plif.immed_in    = exm_plif.immed_out;
	// Input Assignments
	assign mwb_plif.outport_in  = exm_plif.outport_out;
	assign mwb_plif.wsel_in     = exm_plif.wsel_out;
	assign mwb_plif.dmemload_in = dpif.dmemload; 
	assign mwb_plif.halt_in     = exm_plif.halt_out;
	// Write Back Control Signals
	assign mwb_plif.WEN_in      = exm_plif.WEN_out;
	assign mwb_plif.MemtoReg_in = exm_plif.MemtoReg_out;
	assign mwb_plif.jal_in      = exm_plif.jal_out;
	assign mwb_plif.LUI_in      = exm_plif.LUI_out;
	assign mwb_plif.pcsrc_in    = exm_plif.pcsrc_out;



	//
	// Request Unit
	//
	assign dpif.dmemREN = ruif.dmemren; 
	assign dpif.dmemWEN = ruif.dmemwen;
	assign ruif.ihit = dpif.ihit;
	assign ruif.dhit = dpif.dhit;


	//HALT latch
	always_ff @(posedge CLK, negedge nRST) begin
		if (!nRST) begin
			temphalt = 0;
		end
		else begin
			temphalt = mwb_plif.halt_out;
		end
	end
	assign dpif.halt = temphalt;

endmodule




		// always_comb begin
	// 	wsel_temp = idex_plif.rd_out;
	// 	if (idex_plif.RegDest_out == 2'b00) begin
	// 		wsel_temp = idex_plif.rd_out;
	// 	end
	// 	else if (idex_plif.RegDest_out == 2'b01) begin
	// 		wsel_temp = idex_plif.rt_out;
	// 	end
	// 	else if (idex_plif.RegDest_out == 2'b10) begin
	// 		wsel_temp = 31;
	// 	end
	// end

	//assign rfif.wsel = wsel_temp;