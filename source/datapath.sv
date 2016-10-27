/*
Patrick Thomison
00256-74870

Emily Fredette
00257-26474

datapath for pipeline
*/

// Imports
// ----------------------------------------- //
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
	`include "hazard_unit_if.vh"

// Module Declaration
// ----------------------------------------- //
	module datapath (
	  input logic CLK, nRST,
	  datapath_cache_if.dp dpif
	);
	  // import types
	  import cpu_types_pkg::*;

// Module Init
// ----------------------------------------- //
  // pc init
  parameter PC_INIT = 0;

// Child Module Instantiation
// ----------------------------------------- //
	// Program Counter
  	pc_if pcif();
	pc PC(CLK, nRST, pcif.pc);

	// Control Unit
  	control_unit_if cuif();
  	control_unit CU(cuif.cu);

  	// Register File
  	register_file_if rfif();
  	register_file RF(!CLK, nRST, rfif.rf);

  	// Hazard Unit
  	hazard_unit_if huif();
  	hazard_unit HU(CLK, huif.hu);

  	// Forwarding Unit
  	forward_unit_if fuif();
  	forward_unit FU(fuif.fu);

  	// ALU 
  	alu_file_if aluif();
	alu_file ALU(aluif.af);

	// Pipeline Registers
	pipeline_register_if ifid_plif ();
	pipeline_register IFID(CLK, nRST, ifid_plif.pr);

	pipeline_register_if idex_plif ();
	pipeline_register IDEX(CLK, nRST, idex_plif.pr);

	pipeline_register_if exm_plif ();
	pipeline_register EXM(CLK, nRST, exm_plif.pr);

	pipeline_register_if mwb_plif ();
	pipeline_register MWB(CLK, nRST, mwb_plif.pr);

// Module Variables
// ----------------------------------------- //
	// unknown, please sort
	word_t immedEXT;
	word_t PCplus4;
	logic temphalt;
	logic ifid_temp_flush_enable;
	logic pcif_enable_temp;
	logic ifid_enable_temp;
	logic [1:0] pcsrcFF;
	word_t outport_temp;
	word_t wdat_temp;
	logic idex_temp_flush_enable;
	logic dwen_temp, rwen_temp;
	word_t inst_temp;
	regbits_t wsel_temp;
	word_t temp_rdat2;
	logic stall;

// Module Outputs
// ----------------------------------------- //
	assign dpif.imemREN   = cuif.imemREN;
	assign dpif.imemaddr  = pcif.pcout;
	assign dpif.dmemstore = exm_plif.rdat2_out; 
	assign dpif.dmemaddr  = exm_plif.outport_out; 
	assign dpif.dmemREN   = exm_plif.dREN_out;
	assign dpif.dmemWEN   = exm_plif.dWEN_out;

	// Halt Latch
	// ----------------------------------------- //	

	always_ff @(posedge CLK, negedge nRST) begin
		if (!nRST) begin
			temphalt <= 0;
		end
		else begin
			temphalt <= exm_plif.halt_out || dpif.halt;
		end
	end
	assign dpif.halt = temphalt;


// Instruction Fetch Stage
// ----------------------------------------- //	

	// Program Counter Inputs
	// ----------------------------------------- //
	assign pcif_enable_temp = dpif.ihit && !stall;
	assign pcif.pcenable    = pcif_enable_temp && !huif.lw_nop;

	assign pcif.pcsrc       = idex_plif.pcsrc_out; 
	assign pcif.branch_pc4  = idex_plif.pcout_out + 4;
	assign pcif.rdat1       = idex_plif.rdat1_out; 
	assign pcif.immed       = idex_plif.immed_out; 
	assign pcif.immedEXT    = idex_plif.extop_out ? {{16{idex_plif.immed_out[15]}}, idex_plif.immed_out}: {16'h0000, idex_plif.immed_out}; 
	assign pcif.BEQ         = idex_plif.BEQ_out;
	assign pcif.branch      = idex_plif.branch_out;
	assign pcif.zero_f      = aluif.zero_f; 

// Instruction Decode Stage
// ----------------------------------------- //

	// Control Unit Inputs
	// ----------------------------------------- //
	assign cuif.instruction = ifid_plif.instruction_out;


	// Register File Inputs
	// ----------------------------------------- //
	assign rfif.WEN   = mwb_plif.WEN_out;
	assign rfif.wsel  = mwb_plif.wsel_out;
	assign rfif.rsel1 = cuif.rs;
	assign rfif.rsel2 = cuif.rt;

	// Register File Write Data Selection
	always_comb begin
		if (mwb_plif.LUI_out) begin
			wdat_temp = {mwb_plif.immed_out, 16'h0000};
		end
		else if (mwb_plif.MemtoReg_out) begin
			wdat_temp = mwb_plif.dmemload_out;
		end
		else if (mwb_plif.jal_out) begin
			wdat_temp = mwb_plif.pcout_out + 4;
		end
		else begin
			wdat_temp = mwb_plif.outport_out;
		end
	end
	assign rfif.wdat = wdat_temp;

// Execute Stage
// ----------------------------------------- //

	// ALU Inputs
	// ----------------------------------------- //
	assign aluif.aluop  = idex_plif.ALUop_out;
	assign aluif.extop  = idex_plif.extop_out;
	assign aluif.immed  = idex_plif.immed_out;
	assign aluif.shamt  = idex_plif.shamt_out;
	assign aluif.ALUsrc = idex_plif.ALUsrc_out;

	always_comb begin
		casez(fuif.ForwardA)
			0: aluif.porta = idex_plif.rdat1_out;
			1: aluif.porta = wdat_temp;
			2: aluif.porta = exm_plif.outport_out;
			default: aluif.porta = idex_plif.rdat1_out;
		endcase

		// Changed from piping into ALU directly so SW can use the forward
		casez(fuif.ForwardB)
			0: temp_rdat2 = idex_plif.rdat2_out;
			1: temp_rdat2 = wdat_temp;
			2: temp_rdat2 = exm_plif.outport_out;
			default: temp_rdat2 = idex_plif.rdat2_out;
		endcase

	end

	assign aluif.rdat2 = temp_rdat2;

// Memory Stage
// ----------------------------------------- //

// Write Back Stage
// ----------------------------------------- //


// Stall Block
// ----------------------------------------- //

	always_comb begin
		stall = 0;
		exm_plif.clearMemReq = 0;
		exm_plif.memData = 0;

		if (dpif.dhit) begin
			exm_plif.clearMemReq = 1;
			exm_plif.memData = dpif.dmemload;
		end else begin
			if (exm_plif.dREN_out || exm_plif.dWEN_out) begin
				stall = 1;
			end 
		end
	end


// Forwarding Unit Inputs
// ----------------------------------------- //
	assign fuif.exm_WEN       = exm_plif.WEN_out;
	assign fuif.idex_rt_out   = idex_plif.rt_out;
	assign fuif.idex_rs_out   = idex_plif.rs_out;
	assign fuif.mwb_WEN       = mwb_plif.WEN_out;
	assign fuif.exm_itype_out = exm_plif.itype_out;
	assign fuif.mwb_itype_out = mwb_plif.itype_out;

	assign fuif.mwb_wsel_out  = mwb_plif.wsel_out;
	assign fuif.exm_wsel_out  = exm_plif.wsel_out;

// Hazard Unit Inputs
// ----------------------------------------- //
	assign huif.idex_dren_out  = idex_plif.dREN_out;
	assign huif.idex_rt_out    = idex_plif.rt_out;
	assign huif.ifid_rs_out    = ifid_plif.rs_out;
	assign huif.ifid_rt_out    = ifid_plif.rt_out;
	assign huif.idex_pcsrc_out = idex_plif.pcsrc_out;
	assign huif.idex_BEQ       = idex_plif.BEQ_out;
	assign huif.idex_branch    = idex_plif.branch_out;
	assign huif.alu_zero_f     = aluif.zero_f; 

// Pipeline Registers Input Assignments
// ----------------------------------------- //	

	// IFID
	// ----------------------------------------- //	
	assign ifid_plif.instruction_in = dpif.imemload;
	assign ifid_plif.pcout_in       = pcif.pcout;
	assign ifid_plif.rs_in          = dpif.imemload[25:21];
	assign ifid_plif.rt_in          = dpif.imemload[20:16];


	// IDEX
	// ----------------------------------------- //
	always_comb begin
		if (huif.lw_nop == 1) begin
			dwen_temp = 0;
			//dren_temp = 0;
			rwen_temp = 0;
			inst_temp = 32'h00000000;
		end else begin
			dwen_temp = cuif.dWEN;
			rwen_temp = cuif.WEN;
			//dren_temp = cuif.dren;
			inst_temp = ifid_plif.instruction_out;
		end
	end

	assign idex_plif.instruction_in = inst_temp;

	// Execute Control Signals
	assign idex_plif.immed_in    = cuif.immed;
	assign idex_plif.extop_in    = cuif.extop;
	assign idex_plif.shamt_in    = cuif.shamt;
	assign idex_plif.ALUsrc_in   = cuif.ALUsrc;
	assign idex_plif.RegDest_in  = cuif.RegDest;
	assign idex_plif.ALUop_in    = cuif.ALUop;
	assign idex_plif.rd_in       = cuif.rd;
	assign idex_plif.rt_in       = cuif.rt;
	assign idex_plif.rs_in       = cuif.rs;
	// Memory Control Signals
	assign idex_plif.dWEN_in     = dwen_temp;
	assign idex_plif.dREN_in     = cuif.dREN;
	assign idex_plif.BEQ_in      = cuif.BEQ;
	assign idex_plif.branch_in   = cuif.branch;
	// Write Back Control Signals
	assign idex_plif.WEN_in      = rwen_temp;
	assign idex_plif.MemtoReg_in = cuif.MemtoReg;
	assign idex_plif.jal_in      = cuif.jal;
	assign idex_plif.LUI_in      = cuif.LUI;
	assign idex_plif.pcsrc_in    = cuif.pcsrc;
	assign idex_plif.rdat1_in    = rfif.rdat1;
	assign idex_plif.rdat2_in    = rfif.rdat2;
	assign idex_plif.halt_in     = cuif.halt;
	assign idex_plif.itype_in    = cuif.itype;
	assign idex_plif.pcout_in    = ifid_plif.pcout_out;

	// EXM
	// ----------------------------------------- //
	assign exm_plif.instruction_in = idex_plif.instruction_out;
	assign exm_plif.immed_in    = idex_plif.immed_out;
	assign exm_plif.zero_f_in   = aluif.zero_f;



	always_comb begin
		if (idex_plif.LUI_out) begin
			outport_temp = {idex_plif.immed_out,16'h0000};
		end else begin
			outport_temp = aluif.outport;
		end
	end

	always_comb 
	begin
		casez(idex_plif.RegDest_out)
			0: wsel_temp = idex_plif.rd_out; // if RD
			1: wsel_temp = idex_plif.rt_out; // if RT
			2: wsel_temp = 31;                // if REG31 
			default: wsel_temp = idex_plif.rd_out;
	endcase
	end

	assign exm_plif.outport_in  = outport_temp;


	assign exm_plif.wsel_in     = wsel_temp;
	assign exm_plif.rdat2_in    = temp_rdat2; //idex_plif.rdat2_out;
	assign exm_plif.halt_in     = idex_plif.halt_out;
	assign exm_plif.rd_in       = idex_plif.rd_out;
	assign exm_plif.rt_in       = idex_plif.rt_out;
	assign exm_plif.itype_in    = idex_plif.itype_out;
	assign exm_plif.pcout_in    = idex_plif.pcout_out;	
 
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

	// MWB
	// ----------------------------------------- //
	assign mwb_plif.immed_in    = exm_plif.immed_out;
	assign mwb_plif.rd_in      = exm_plif.rd_out;
	// Input Assignments
	assign mwb_plif.instruction_in = exm_plif.instruction_out;
	assign mwb_plif.outport_in  = exm_plif.outport_out;
	assign mwb_plif.wsel_in     = exm_plif.wsel_out;
	assign mwb_plif.dmemload_in = exm_plif.dmemload_out;
	assign mwb_plif.halt_in     = exm_plif.halt_out;
	assign mwb_plif.itype_in    = exm_plif.itype_out;
	assign mwb_plif.rt_in      = exm_plif.rt_out;

	// Write Back Control Signals
	assign mwb_plif.WEN_in      = exm_plif.WEN_out;
	assign mwb_plif.MemtoReg_in = exm_plif.MemtoReg_out;
	assign mwb_plif.jal_in      = exm_plif.jal_out;
	assign mwb_plif.LUI_in      = exm_plif.LUI_out;
	assign mwb_plif.pcsrc_in    = exm_plif.pcsrc_out;
	assign mwb_plif.pcout_in    = exm_plif.pcout_out;

// Pipeline Registers Control Signals
// ----------------------------------------- //
	// IFID
	// ----------------------------------------- //
	assign ifid_plif.enable = dpif.ihit && !stall && !huif.lw_nop;
	assign ifid_temp_flush_enable = dpif.ihit && !stall && !huif.lw_nop;//(exm_plif.dREN_out || exm_plif.dWEN_out)  ? dpif.dhit:  dpif.ihit;
	assign ifid_plif.flush  = ( huif.jmp_flush || huif.brch_flush ) && ifid_temp_flush_enable; // UPDATE FOR PC_CHG INSTR

	// IDEX
	// ----------------------------------------- //

	assign idex_plif.enable  = dpif.ihit && !stall;
	assign idex_temp_flush_enable = dpif.ihit && !stall && !huif.lw_nop;//(exm_plif.dREN_out || exm_plif.dWEN_out)  ? dpif.dhit:  dpif.ihit;
	assign idex_plif.flush   = (huif.jmp_flush || huif.brch_flush ) && idex_temp_flush_enable; // UPDATE FOR PC_CHG INSTR

	// EXM
	// ----------------------------------------- //
	assign exm_plif.enable = dpif.ihit && !stall;
	assign exm_plif.flush  = 0; // UPDATE FOR PC_CHG INSTR

	// MWB
	// ----------------------------------------- //
	assign mwb_plif.enable = dpif.ihit && !stall;
	assign mwb_plif.flush  = 0;

endmodule