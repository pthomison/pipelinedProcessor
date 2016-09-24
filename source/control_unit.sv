/*
	Emily Fredette
	request unit
*/

// interface
`include "control_unit_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module control_unit (
  control_unit_if.cu cuif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  //parameter CPUS = 1;


	opcode_t opcode;
	assign opcode = opcode_t'(cuif.instruction[31:26]);

	funct_t funct;
	assign funct = funct_t'(cuif.instruction[5:0]);

	assign cuif.rs = cuif.instruction[25:21];
	assign cuif.rt = cuif.instruction[20:16];
	assign cuif.immed = cuif.instruction[15:0];
	assign cuif.rd = cuif.instruction[15:11];
	assign cuif.shamt = cuif.instruction[10:6];


	//cuif.ALUop = ALU_SLL;
	//cuif.PCsrc = 
	//cuif.MemtoReg = 1 for ALU data - 0 for data from cache
	//cuif.WEN = 
	//cuif.jal = 1 for JAL instruction
	//cuif.extop = 1 for signed - 0 for zero
	//cuif.dWEN = 1 if writing data to memory
	//cuif.dREN = 1 if reading data from memory
	//cuif.LUI = 1 for LUI instruction
	//cuif.imemREN = 
	//cuif.BEQ = 1 if BEQ - 0 if 
	//cuif.ALUsrc = 00 if rdat2 - 01 if extended Immediate - 10 if shamt
	//cuif.pcsrc = 
	//cuif.RegDest = 



always_comb begin

	//defaults
	cuif.ALUop = ALU_SLL;
	cuif.branch = 0; 	//1 if branching
	cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
	cuif.WEN = 0;		//1 if writing to a register - all RTYPE are 1 (except JR)
	cuif.jal = 0; 		//1 for JAL instruction
	cuif.extop = 0;		//1 for signed - 0 for zero
	cuif.dWEN = 0;		//1 if writing data to memory
	cuif.dREN = 0;		//1 if reading data from memory
	cuif.LUI = 0;		//1 for LUI instruction
	cuif.imemREN = 1;	//1 unless HALT
	cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
	cuif.ALUsrc = 00; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
	cuif.pcsrc = 00;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
	cuif.RegDest = 00;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
	cuif.halt = 0;
	cuif.itype = 0;		//1 if I Type

casez (opcode) 

	RTYPE: begin
   	 //SLL,	SRL, JR, ADD, ADDU, SUB, SUBU, AND, OR, XOR, NOR, SLT, SLTU
		casez (funct)
			SLL: begin
				cuif.ALUop = ALU_SLL;
				cuif.branch = 0; 	//1 if branching
				cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
				cuif.WEN = 1;		//1 if writing to a register - all RTYPE are 1 (except JR)
				cuif.jal = 0; 		//1 for JAL instruction
				cuif.extop = 0;		//1 for signed - 0 for zero
				cuif.dWEN = 0;		//1 if writing data to memory
				cuif.dREN = 0;		//1 if reading data from memory
				cuif.LUI = 0;		//1 for LUI instruction
				cuif.imemREN = 1;	//1 unless HALT
				cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
				cuif.ALUsrc = 10; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
				cuif.pcsrc = 00;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
				cuif.RegDest = 00;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
				cuif.halt = 0;
				cuif.itype = 0;
			end
			
			SRL: begin
				cuif.ALUop = ALU_SRL;
				cuif.branch = 0; 	//1 if branching
				cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
				cuif.WEN = 1;		//1 if writing to a register - all RTYPE are 1 (except JR)
				cuif.jal = 0; 		//1 for JAL instruction
				cuif.extop = 0;		//1 for signed - 0 for zero
				cuif.dWEN = 0;		//1 if writing data to memory
				cuif.dREN = 0;		//1 if reading data from memory
				cuif.LUI = 0;		//1 for LUI instruction
				cuif.imemREN = 1;	//1 unless HALT
				cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
				cuif.ALUsrc = 10; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
				cuif.pcsrc = 00;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
				cuif.RegDest = 00;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
				cuif.halt = 0;
				cuif.itype = 0;
			end

			JR: begin
				cuif.ALUop = ALU_SLL;	//DC
				cuif.branch = 0; 	//1 if branching
				cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
				cuif.WEN = 1;		//1 if writing to a register - all RTYPE are 1 (except JR)
				cuif.jal = 0; 		//1 for JAL instruction
				cuif.extop = 0;		//1 for signed - 0 for zero
				cuif.dWEN = 0;		//1 if writing data to memory
				cuif.dREN = 0;		//1 if reading data from memory
				cuif.LUI = 0;		//1 for LUI instruction
				cuif.imemREN = 1;	//1 unless HALT
				cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
				cuif.ALUsrc = 00; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
				cuif.pcsrc = 01;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
				cuif.RegDest = 00;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
				cuif.halt = 0;
				cuif.itype = 0;
			end

			ADD: begin
				cuif.ALUop = ALU_ADD;
				cuif.branch = 0; 	//1 if branching
				cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
				cuif.WEN = 1;		//1 if writing to a register - all RTYPE are 1 (except JR)
				cuif.jal = 0; 		//1 for JAL instruction
				cuif.extop = 0;		//1 for signed - 0 for zero
				cuif.dWEN = 0;		//1 if writing data to memory
				cuif.dREN = 0;		//1 if reading data from memory
				cuif.LUI = 0;		//1 for LUI instruction
				cuif.imemREN = 1;	//1 unless HALT
				cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
				cuif.ALUsrc = 00; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
				cuif.pcsrc = 00;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
				cuif.RegDest = 00;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
				cuif.halt = 0;
				cuif.itype = 0;
			end

			ADDU: begin
				cuif.ALUop = ALU_ADD;
				cuif.branch = 0; 	//1 if branching
				cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
				cuif.WEN = 1;		//1 if writing to a register - all RTYPE are 1 (except JR)
				cuif.jal = 0; 		//1 for JAL instruction
				cuif.extop = 0;		//1 for signed - 0 for zero
				cuif.dWEN = 0;		//1 if writing data to memory
				cuif.dREN = 0;		//1 if reading data from memory
				cuif.LUI = 0;		//1 for LUI instruction
				cuif.imemREN = 1;	//1 unless HALT
				cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
				cuif.ALUsrc = 00; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
				cuif.pcsrc = 00;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
				cuif.RegDest = 00;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
				cuif.halt = 0;
				cuif.itype = 0;
			end

			SUB: begin
				cuif.ALUop = ALU_SUB;
				cuif.branch = 0; 	//1 if branching
				cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
				cuif.WEN = 1;		//1 if writing to a register - all RTYPE are 1 (except JR)
				cuif.jal = 0; 		//1 for JAL instruction
				cuif.extop = 0;		//1 for signed - 0 for zero
				cuif.dWEN = 0;		//1 if writing data to memory
				cuif.dREN = 0;		//1 if reading data from memory
				cuif.LUI = 0;		//1 for LUI instruction
				cuif.imemREN = 1;	//1 unless HALT
				cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
				cuif.ALUsrc = 00; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
				cuif.pcsrc = 00;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
				cuif.RegDest = 00;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
				cuif.halt = 0;
				cuif.itype = 0;
			end

			SUBU: begin
				cuif.ALUop = ALU_SUB;
				cuif.branch = 0; 	//1 if branching
				cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
				cuif.WEN = 1;		//1 if writing to a register - all RTYPE are 1 (except JR)
				cuif.jal = 0; 		//1 for JAL instruction
				cuif.extop = 0;		//1 for signed - 0 for zero
				cuif.dWEN = 0;		//1 if writing data to memory
				cuif.dREN = 0;		//1 if reading data from memory
				cuif.LUI = 0;		//1 for LUI instruction
				cuif.imemREN = 1;	//1 unless HALT
				cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
				cuif.ALUsrc = 00; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
				cuif.pcsrc = 00;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
				cuif.RegDest = 00;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
				cuif.halt = 0;
				cuif.itype = 0;
			end

			AND: begin
				cuif.ALUop = ALU_AND;
				cuif.branch = 0; 	//1 if branching
				cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
				cuif.WEN = 1;		//1 if writing to a register - all RTYPE are 1 (except JR)
				cuif.jal = 0; 		//1 for JAL instruction
				cuif.extop = 0;		//1 for signed - 0 for zero
				cuif.dWEN = 0;		//1 if writing data to memory
				cuif.dREN = 0;		//1 if reading data from memory
				cuif.LUI = 0;		//1 for LUI instruction
				cuif.imemREN = 1;	//1 unless HALT
				cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
				cuif.ALUsrc = 00; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
				cuif.pcsrc = 00;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
				cuif.RegDest = 00;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
				cuif.halt = 0;
				cuif.itype = 0;
			end

			OR: begin
				cuif.ALUop = ALU_OR;
				cuif.branch = 0; 	//1 if branching
				cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
				cuif.WEN = 1;		//1 if writing to a register - all RTYPE are 1 (except JR)
				cuif.jal = 0; 		//1 for JAL instruction
				cuif.extop = 0;		//1 for signed - 0 for zero
				cuif.dWEN = 0;		//1 if writing data to memory
				cuif.dREN = 0;		//1 if reading data from memory
				cuif.LUI = 0;		//1 for LUI instruction
				cuif.imemREN = 1;	//1 unless HALT
				cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
				cuif.ALUsrc = 00; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
				cuif.pcsrc = 00;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
				cuif.RegDest = 00;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
				cuif.halt = 0;
				cuif.itype = 0;
			end

			XOR: begin
				cuif.ALUop = ALU_XOR;
				cuif.branch = 0; 	//1 if branching
				cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
				cuif.WEN = 1;		//1 if writing to a register - all RTYPE are 1 (except JR)
				cuif.jal = 0; 		//1 for JAL instruction
				cuif.extop = 0;		//1 for signed - 0 for zero
				cuif.dWEN = 0;		//1 if writing data to memory
				cuif.dREN = 0;		//1 if reading data from memory
				cuif.LUI = 0;		//1 for LUI instruction
				cuif.imemREN = 1;	//1 unless HALT
				cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
				cuif.ALUsrc = 00; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
				cuif.pcsrc = 00;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
				cuif.RegDest = 00;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
				cuif.halt = 0;
				cuif.itype = 0;
			end

			NOR: begin
				cuif.ALUop = ALU_NOR;
				cuif.branch = 0; 	//1 if branching
				cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
				cuif.WEN = 1;		//1 if writing to a register - all RTYPE are 1 (except JR)
				cuif.jal = 0; 		//1 for JAL instruction
				cuif.extop = 0;		//1 for signed - 0 for zero
				cuif.dWEN = 0;		//1 if writing data to memory
				cuif.dREN = 0;		//1 if reading data from memory
				cuif.LUI = 0;		//1 for LUI instruction
				cuif.imemREN = 1;	//1 unless HALT
				cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
				cuif.ALUsrc = 00; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
				cuif.pcsrc = 00;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
				cuif.RegDest = 00;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
				cuif.halt = 0;
				cuif.itype = 0;
			end

			SLT: begin
				cuif.ALUop = ALU_SLT;
				cuif.branch = 0; 	//1 if branching
				cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
				cuif.WEN = 1;		//1 if writing to a register - all RTYPE are 1 (except JR)
				cuif.jal = 0; 		//1 for JAL instruction
				cuif.extop = 0;		//1 for signed - 0 for zero
				cuif.dWEN = 0;		//1 if writing data to memory
				cuif.dREN = 0;		//1 if reading data from memory
				cuif.LUI = 0;		//1 for LUI instruction
				cuif.imemREN = 1;	//1 unless HALT
				cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
				cuif.ALUsrc = 00; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
				cuif.pcsrc = 00;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
				cuif.RegDest = 00;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
				cuif.halt = 0;
				cuif.itype = 0;
			end
			
			SLTU: begin
				cuif.ALUop = ALU_SLTU;
				cuif.branch = 0; 	//1 if branching
				cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
				cuif.WEN = 1;		//1 if writing to a register - all RTYPE are 1 (except JR)
				cuif.jal = 0; 		//1 for JAL instruction
				cuif.extop = 0;		//1 for signed - 0 for zero
				cuif.dWEN = 0;		//1 if writing data to memory
				cuif.dREN = 0;		//1 if reading data from memory
				cuif.LUI = 0;		//1 for LUI instruction
				cuif.imemREN = 1;	//1 unless HALT
				cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
				cuif.ALUsrc = 00; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
				cuif.pcsrc = 00;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
				cuif.RegDest = 00;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
				cuif.halt = 0;
				cuif.itype = 0;
			end

			default: begin
				cuif.halt = 0;
				cuif.imemREN = 1;
			end

		endcase

	end

	ADDIU: begin
		cuif.ALUop = ALU_ADD;
		cuif.branch = 0; 	//1 if branching
		cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
		cuif.WEN = 1;		//1 if writing to a register - all RTYPE are 1 (except JR)
		cuif.jal = 0; 		//1 for JAL instruction
		cuif.extop = 1;		//1 for signed - 0 for zero
		cuif.dWEN = 0;		//1 if writing data to memory
		cuif.dREN = 0;		//1 if reading data from memory
		cuif.LUI = 0;		//1 for LUI instruction
		cuif.imemREN = 1;	//1 unless HALT
		cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
		cuif.ALUsrc = 01; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
		cuif.pcsrc = 00;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
		cuif.RegDest = 01;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
		cuif.halt = 0;
		cuif.itype = 1;

	end

	ADDI: begin
		cuif.ALUop = ALU_ADD;
		cuif.branch = 0; 	//1 if branching
		cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
		cuif.WEN = 1;		//1 if writing to a register - all RTYPE are 1 (except JR)
		cuif.jal = 0; 		//1 for JAL instruction
		cuif.extop = 1;		//1 for signed - 0 for zero
		cuif.dWEN = 0;		//1 if writing data to memory
		cuif.dREN = 0;		//1 if reading data from memory
		cuif.LUI = 0;		//1 for LUI instruction
		cuif.imemREN = 1;	//1 unless HALT
		cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
		cuif.ALUsrc = 01; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
		cuif.pcsrc = 00;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
		cuif.RegDest = 01;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
		cuif.halt = 0;
		cuif.itype = 1;

	end

	ANDI: begin
		cuif.ALUop = ALU_AND;
		cuif.branch = 0; 	//1 if branching
		cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
		cuif.WEN = 1;		//1 if writing to a register - all RTYPE are 1 (except JR)
		cuif.jal = 0; 		//1 for JAL instruction
		cuif.extop = 0;		//1 for signed - 0 for zero
		cuif.dWEN = 0;		//1 if writing data to memory
		cuif.dREN = 0;		//1 if reading data from memory
		cuif.LUI = 0;		//1 for LUI instruction
		cuif.imemREN = 1;	//1 unless HALT
		cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
		cuif.ALUsrc = 01; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
		cuif.pcsrc = 00;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
		cuif.RegDest = 01;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
		cuif.halt = 0;
		cuif.itype = 1;

	end

	BEQ: begin
		cuif.ALUop = ALU_SUB;
		cuif.branch = 1; 	//1 if branching
		cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
		cuif.WEN = 0;		//1 if writing to a register - all RTYPE are 1 (except JR)
		cuif.jal = 0; 		//1 for JAL instruction
		cuif.extop = 1;		//1 for signed - 0 for zero
		cuif.dWEN = 0;		//1 if writing data to memory
		cuif.dREN = 0;		//1 if reading data from memory
		cuif.LUI = 0;		//1 for LUI instruction
		cuif.imemREN = 1;	//1 unless HALT
		cuif.BEQ = 1; 		//1 if BEQ - 0 if BNE
		cuif.ALUsrc = 00; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
		cuif.pcsrc = 10;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
		cuif.RegDest = 00;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
		cuif.halt = 0;
		cuif.itype = 0;
	end

	BNE: begin
		cuif.ALUop = ALU_SUB;
		cuif.branch = 1; 	//1 if branching
		cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
		cuif.WEN = 0;		//1 if writing to a register - all RTYPE are 1 (except JR)
		cuif.jal = 0; 		//1 for JAL instruction
		cuif.extop = 1;		//1 for signed - 0 for zero
		cuif.dWEN = 0;		//1 if writing data to memory
		cuif.dREN = 0;		//1 if reading data from memory
		cuif.LUI = 0;		//1 for LUI instruction
		cuif.imemREN = 1;	//1 unless HALT
		cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
		cuif.ALUsrc = 00; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
		cuif.pcsrc = 10;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
		cuif.RegDest = 00;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
		cuif.halt = 0;
		cuif.itype = 0;
	end

	LUI: begin
		cuif.ALUop = ALU_ADD;	
		cuif.branch = 0; 	//1 if branching
		cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
		cuif.WEN = 1;		//1 if writing to a register - all RTYPE are 1 (except JR)
		cuif.jal = 0; 		//1 for JAL instruction
		cuif.extop = 1;		//1 for signed - 0 for zero
		cuif.dWEN = 0;		//1 if writing data to memory
		cuif.dREN = 0;		//1 if reading data from memory
		cuif.LUI = 1;		//1 for LUI instruction
		cuif.imemREN = 1;	//1 unless HALT
		cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
		cuif.ALUsrc = 00; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
		cuif.pcsrc = 00;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
		cuif.RegDest = 01;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
		cuif.halt = 0;
		cuif.itype = 1;
	end

	LW: begin
		cuif.ALUop = ALU_ADD;	
		cuif.branch = 0; 	//1 if branching
		cuif.MemtoReg = 1;	//1 for ALU data - 0 for data from cache
		cuif.WEN = 1;		//1 if writing to a register - all RTYPE are 1 (except JR)
		cuif.jal = 0; 		//1 for JAL instruction
		cuif.extop = 1;		//1 for signed - 0 for zero
		cuif.dWEN = 0;		//1 if writing data to memory
		cuif.dREN = 1;		//1 if reading data from memory
		cuif.LUI = 0;		//1 for LUI instruction
		cuif.imemREN = 1;	//1 unless HALT
		cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
		cuif.ALUsrc = 01; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
		cuif.pcsrc = 00;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
		cuif.RegDest = 01;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
		cuif.halt = 0;
		cuif.itype = 0;
	end

	ORI: begin
		cuif.ALUop = ALU_OR;	
		cuif.branch = 0; 	//1 if branching
		cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
		cuif.WEN = 1;		//1 if writing to a register - all RTYPE are 1 (except JR)
		cuif.jal = 0; 		//1 for JAL instruction
		cuif.extop = 0;		//1 for signed - 0 for zero
		cuif.dWEN = 0;		//1 if writing data to memory
		cuif.dREN = 0;		//1 if reading data from memory
		cuif.LUI = 0;		//1 for LUI instruction
		cuif.imemREN = 1;	//1 unless HALT
		cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
		cuif.ALUsrc = 01; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
		cuif.pcsrc = 00;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
		cuif.RegDest = 01;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
		cuif.halt = 0;
		cuif.itype = 1;

	end

	SLTI: begin
		cuif.ALUop = ALU_SLT;
		cuif.branch = 0; 	//1 if branching
		cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
		cuif.WEN = 1;		//1 if writing to a register - all RTYPE are 1 (except JR)
		cuif.jal = 0; 		//1 for JAL instruction
		cuif.extop = 1;		//1 for signed - 0 for zero
		cuif.dWEN = 0;		//1 if writing data to memory
		cuif.dREN = 0;		//1 if reading data from memory
		cuif.LUI = 0;		//1 for LUI instruction
		cuif.imemREN = 1;	//1 unless HALT
		cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
		cuif.ALUsrc = 01; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
		cuif.pcsrc = 00;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
		cuif.RegDest = 01;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
		cuif.halt = 0;
		cuif.itype = 1;
	end

	SLTIU: begin
		cuif.ALUop = ALU_SLTU;
		cuif.branch = 0; 	//1 if branching
		cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
		cuif.WEN = 1;		//1 if writing to a register - all RTYPE are 1 (except JR)
		cuif.jal = 0; 		//1 for JAL instruction
		cuif.extop = 1;		//1 for signed - 0 for zero
		cuif.dWEN = 0;		//1 if writing data to memory
		cuif.dREN = 0;		//1 if reading data from memory
		cuif.LUI = 0;		//1 for LUI instruction
		cuif.imemREN = 1;	//1 unless HALT
		cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
		cuif.ALUsrc = 01; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
		cuif.pcsrc = 00;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
		cuif.RegDest = 01;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
		cuif.halt = 0;
		cuif.itype = 1;
	end

	SW: begin
		cuif.ALUop = ALU_ADD;	
		cuif.branch = 0; 	//1 if branching
		cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
		cuif.WEN = 0;		//1 if writing to a register - all RTYPE are 1 (except JR)
		cuif.jal = 0; 		//1 for JAL instruction
		cuif.extop = 1;		//1 for signed - 0 for zero
		cuif.dWEN = 1;		//1 if writing data to memory
		cuif.dREN = 0;		//1 if reading data from memory
		cuif.LUI = 0;		//1 for LUI instruction
		cuif.imemREN = 1;	//1 unless HALT
		cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
		cuif.ALUsrc = 01; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
		cuif.pcsrc = 00;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
		cuif.RegDest = 01;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
		cuif.halt = 0;
		cuif.itype = 0;

	end

	JAL: begin
		cuif.ALUop = ALU_SLL;
		cuif.branch = 0; 	//1 if branching
		cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
		cuif.WEN = 1;		//1 if writing to a register - all RTYPE are 1 (except JR)
		cuif.jal = 1; 		//1 for JAL instruction
		cuif.extop = 0;		//1 for signed - 0 for zero
		cuif.dWEN = 0;		//1 if writing data to memory
		cuif.dREN = 0;		//1 if reading data from memory
		cuif.LUI = 0;		//1 for LUI instruction
		cuif.imemREN = 1;	//1 unless HALT
		cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
		cuif.ALUsrc = 00; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
		cuif.pcsrc = 11;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
		cuif.RegDest = 10;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
		cuif.halt = 0;
	end

	J: begin
		cuif.ALUop = ALU_SLL;
		cuif.branch = 0; 	//1 if branching
		cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
		cuif.WEN = 0;		//1 if writing to a register - all RTYPE are 1 (except JR)
		cuif.jal = 0; 		//1 for JAL instruction
		cuif.extop = 0;		//1 for signed - 0 for zero
		cuif.dWEN = 0;		//1 if writing data to memory
		cuif.dREN = 0;		//1 if reading data from memory
		cuif.LUI = 0;		//1 for LUI instruction
		cuif.imemREN = 1;	//1 unless HALT
		cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
		cuif.ALUsrc = 00; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
		cuif.pcsrc = 11;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
		cuif.RegDest = 10;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
		cuif.halt = 0;
		cuif.itype = 0;
	end

	XORI: begin
		cuif.ALUop = ALU_XOR;
		cuif.branch = 0; 	//1 if branching
		cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
		cuif.WEN = 1;		//1 if writing to a register - all RTYPE are 1 (except JR)
		cuif.jal = 0; 		//1 for JAL instruction
		cuif.extop = 0;		//1 for signed - 0 for zero
		cuif.dWEN = 0;		//1 if writing data to memory
		cuif.dREN = 0;		//1 if reading data from memory
		cuif.LUI = 0;		//1 for LUI instruction
		cuif.imemREN = 1;	//1 unless HALT
		cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
		cuif.ALUsrc = 01; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
		cuif.pcsrc = 00;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
		cuif.RegDest = 01;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
		cuif.halt = 0;
		cuif.itype = 1;
	end

	HALT: begin
		cuif.ALUop = ALU_SLL;	//DC
		cuif.branch = 0; 	//1 if branching
		cuif.MemtoReg = 0;	//1 for ALU data - 0 for data from cache
		cuif.WEN = 0;		//1 if writing to a register - all RTYPE are 1 (except JR)
		cuif.jal = 0; 		//1 for JAL instruction
		cuif.extop = 0;		//1 for signed - 0 for zero
		cuif.dWEN = 0;		//1 if writing data to memory
		cuif.dREN = 0;		//1 if reading data from memory
		cuif.LUI = 0;		//1 for LUI instruction
		cuif.imemREN = 1;	//1 unless HALT
		cuif.BEQ = 0; 		//1 if BEQ - 0 if BNE
		cuif.ALUsrc = 00; 	//00 if rdat2 - 01 if extended Immediate - 10 if shamt
		cuif.pcsrc = 00;		//00 if PC+4 - 01 if JR - 10 if BEQ or BNE  - 11 if J or JAL
		cuif.RegDest = 00;	//00 if RD - 01 if RT - 10 if REG#31 - IF RTYPE then 00
		cuif.halt = 1;
		cuif.itype = 0;
	end

	default: begin
		cuif.halt = 0;
		cuif.imemREN = 1;
	end



endcase

end

endmodule
