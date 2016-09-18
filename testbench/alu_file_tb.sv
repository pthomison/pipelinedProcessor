/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "alu_file_if.vh"
`include "cpu_types_pkg.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns



module alu_file_tb;

  
  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  alu_file_if aluif ();
  // test program
  test PROG (nRST, aluif);
  // DUT
`ifndef MAPPED
  alu_file DUT(aluif);
`else
  alu_file DUT(
    .\aluif.porta (aluif.porta),
    .\aluif.portb (aluif.portb),
    .\aluif.aluop (aluif.aluop),
    .\aluif.outport (aluif.outport),
    .\aluif.neg_f (aluif.neg_f),
    .\aluif.over_f (aluif.over_f),
    .\aluif.zero_f (aluif.zero_f),
  );
`endif




endmodule

/*
	Emily Fredette
	efredett@purdue.edu

	register file tb
	lab 1
*/


program test (
	output logic nRST,
	alu_file_if.tb alutb
	//integer i
);

parameter PERIOD = 10;
initial begin
	import cpu_types_pkg::*;
	#(PERIOD*2);
	nRST = 0;
	#(PERIOD*2);
	nRST = 1;

	//
	//SLL
	//

	alutb.porta = 100;
	alutb.portb = 5;
	alutb.aluop = ALU_SLL;
	#(PERIOD);

	alutb.porta = 200;
	alutb.portb = 5;
	alutb.aluop = ALU_SLL;
	#(PERIOD);

	alutb.porta = 1;
	alutb.portb = 30;
	alutb.aluop = ALU_SLL;
	#(PERIOD);

	alutb.porta = 1;
	alutb.portb = 31;
	alutb.aluop = ALU_SLL;
	#(PERIOD);

	alutb.porta = 1;
	alutb.portb = 32;
	alutb.aluop = ALU_SLL;
	#(PERIOD);

	alutb.porta = 2147483647;
	alutb.portb = 5;
	alutb.aluop = ALU_SLL;
	#(PERIOD);

	alutb.porta = 2147483647;
	alutb.portb = 0;
	alutb.aluop = ALU_SLL;
	#(PERIOD);

	alutb.porta = -2147483647;
	alutb.portb = 1;
	alutb.aluop = ALU_SLL;
	#(PERIOD);


	//
	//SRL
	//

	alutb.porta = 100;
	alutb.portb = 5;
	alutb.aluop = ALU_SRL;
	#(PERIOD);

	alutb.porta = 200;
	alutb.portb = 5;
	alutb.aluop = ALU_SRL;
	#(PERIOD);

	alutb.porta = 1;
	alutb.portb = 30;
	alutb.aluop = ALU_SRL;
	#(PERIOD);

	alutb.porta = 1;
	alutb.portb = 31;
	alutb.aluop = ALU_SRL;
	#(PERIOD);

	alutb.porta = 1;
	alutb.portb = 32;
	alutb.aluop = ALU_SRL;
	#(PERIOD);

	alutb.porta = 2147483648;
	alutb.portb = 5;
	alutb.aluop = ALU_SRL;
	#(PERIOD);

	alutb.porta = 2147483648;
	alutb.portb = 0;
	alutb.aluop = ALU_SRL;
	#(PERIOD);

	alutb.porta = -2147483648;
	alutb.portb = 1;
	alutb.aluop = ALU_SRL;
	#(PERIOD);

	//
	//ADD
	//


	alutb.porta = 2;
	alutb.portb = -2;
	alutb.aluop = ALU_ADD;
	#(PERIOD);

	alutb.porta = 100;
	alutb.portb = -98;
	alutb.aluop = ALU_ADD;
	#(PERIOD);

	alutb.porta = 2147483647;
	alutb.portb = 2147483647;
	alutb.aluop = ALU_ADD;
	#(PERIOD);



	alutb.porta = 2;
	alutb.portb = -1;
	alutb.aluop = ALU_ADD;
	#(PERIOD);

	alutb.porta = 100;
	alutb.portb = 200;
	alutb.aluop = ALU_ADD;
	#(PERIOD);


	alutb.porta = 100;
	alutb.portb = -98;
	alutb.aluop = ALU_ADD;
	#(PERIOD);

	alutb.porta = -2147483647;
	alutb.portb = 2147483647;
	alutb.aluop = ALU_ADD;
	#(PERIOD);

	alutb.porta = 100;
	alutb.portb = 200;
	alutb.aluop = ALU_ADD;
	#(PERIOD);

	alutb.porta = 2147483647;
	alutb.portb = 2147483647;
	alutb.aluop = ALU_ADD;
	#(PERIOD);

	alutb.porta = 2147483647;
	alutb.portb = -2147483647;
	alutb.aluop = ALU_ADD;
	#(PERIOD);

	alutb.porta = 100;
	alutb.portb = 200;
	alutb.aluop = ALU_ADD;
	#(PERIOD);


	//
	//SUB
	//

	alutb.porta = 2;
	alutb.portb = -1;
	alutb.aluop = ALU_SUB;
	#(PERIOD);

	alutb.porta = 100;
	alutb.portb = 200;
	alutb.aluop = ALU_SUB;
	#(PERIOD);


	alutb.porta = 100;
	alutb.portb = -98;
	alutb.aluop = ALU_SUB;
	#(PERIOD);

	alutb.porta = -2147483647;
	alutb.portb = 2147483647;
	alutb.aluop = ALU_SUB;
	#(PERIOD);

	alutb.porta = 100;
	alutb.portb = 200;
	alutb.aluop = ALU_SUB;
	#(PERIOD);

	alutb.porta = 2147483647;
	alutb.portb = 2147483647;
	alutb.aluop = ALU_SUB;
	#(PERIOD);

	alutb.porta = 2147483647;
	alutb.portb = -2147483647;
	alutb.aluop = ALU_SUB;
	#(PERIOD);

	alutb.porta = 100;
	alutb.portb = 200;
	alutb.aluop = ALU_SUB;
	#(PERIOD);

	//
	//AND
	//

	alutb.porta = 100;
	alutb.portb = 200;
	alutb.aluop = ALU_AND;
	#(PERIOD);

	alutb.porta = 200;
	alutb.portb = 100;
	alutb.aluop = ALU_AND;
	#(PERIOD);

	alutb.porta = 1;
	alutb.portb = 2147483647;
	alutb.aluop = ALU_AND;
	#(PERIOD);

	alutb.porta = 2147483647;
	alutb.portb = 2147483647;
	alutb.aluop = ALU_AND;
	#(PERIOD);

	alutb.porta = 2147483647;
	alutb.portb = 0;
	alutb.aluop = ALU_AND;
	#(PERIOD);

	alutb.porta = -2147483647;
	alutb.portb = 2147483647;
	alutb.aluop = ALU_AND;
	#(PERIOD);

	//
	//OR
	//

	alutb.porta = 100;
	alutb.portb = 200;
	alutb.aluop = ALU_OR;
	#(PERIOD);

	alutb.porta = 200;
	alutb.portb = 100;
	alutb.aluop = ALU_OR;
	#(PERIOD);

	alutb.porta = 1;
	alutb.portb = 2147483647;
	alutb.aluop = ALU_OR;
	#(PERIOD);

	alutb.porta = 2147483647;
	alutb.portb = 2147483647;
	alutb.aluop = ALU_OR;
	#(PERIOD);

	alutb.porta = 2147483647;
	alutb.portb = 0;
	alutb.aluop = ALU_OR;
	#(PERIOD);

	alutb.porta = -2147483647;
	alutb.portb = 2147483647;
	alutb.aluop = ALU_OR;
	#(PERIOD);



	//
	//XOR
	//

	alutb.porta = 100;
	alutb.portb = 200;
	alutb.aluop = ALU_XOR;
	#(PERIOD);

	alutb.porta = 200;
	alutb.portb = 100;
	alutb.aluop = ALU_XOR;
	#(PERIOD);

	alutb.porta = 1;
	alutb.portb = 2147483647;
	alutb.aluop = ALU_XOR;
	#(PERIOD);

	alutb.porta = 2147483647;
	alutb.portb = 2147483647;
	alutb.aluop = ALU_XOR;
	#(PERIOD);

	alutb.porta = 2147483647;
	alutb.portb = 0;
	alutb.aluop = ALU_XOR;
	#(PERIOD);

	alutb.porta = -2147483647;
	alutb.portb = 2147483647;
	alutb.aluop = ALU_XOR;
	#(PERIOD);


	//
	//NOR
	//

	alutb.porta = 100;
	alutb.portb = 200;
	alutb.aluop = ALU_NOR;
	#(PERIOD);

	alutb.porta = 200;
	alutb.portb = 100;
	alutb.aluop = ALU_NOR;
	#(PERIOD);

	alutb.porta = 1;
	alutb.portb = 2147483647;
	alutb.aluop = ALU_NOR;
	#(PERIOD);

	alutb.porta = 2147483647;
	alutb.portb = 2147483647;
	alutb.aluop = ALU_NOR;
	#(PERIOD);

	alutb.porta = 2147483647;
	alutb.portb = 0;
	alutb.aluop = ALU_NOR;
	#(PERIOD);

	alutb.porta = -2147483647;
	alutb.portb = 2147483647;
	alutb.aluop = ALU_NOR;
	#(PERIOD);

//
	//SLTU
	//
	alutb.porta = -100;
	alutb.portb = 200;
	alutb.aluop = ALU_SLTU;
	#(PERIOD);

	alutb.porta = 100;
	alutb.portb = 200;
	alutb.aluop = ALU_SLTU;
	#(PERIOD);

	alutb.porta = 200;
	alutb.portb = 100;
	alutb.aluop = ALU_SLTU;
	#(PERIOD);

	alutb.porta = 1;
	alutb.portb = 2147483647;
	alutb.aluop = ALU_SLTU;
	#(PERIOD);

	alutb.porta = 2147483647;
	alutb.portb = 2147483647;
	alutb.aluop = ALU_SLTU;
	#(PERIOD);

	alutb.porta = 2147483647;
	alutb.portb = 0;
	alutb.aluop = ALU_SLTU;
	#(PERIOD);

	alutb.porta = -2147483647;
	alutb.portb = 2147483647;
	alutb.aluop = ALU_SLTU;
	#(PERIOD);

	//
	//SLT
	//
	alutb.porta = -100;
	alutb.portb = 200;
	alutb.aluop = ALU_SLTU;
	#(PERIOD);

	alutb.porta = 100;
	alutb.portb = 200;
	alutb.aluop = ALU_SLT;
	#(PERIOD);

	alutb.porta = 200;
	alutb.portb = 100;
	alutb.aluop = ALU_SLT;
	#(PERIOD);

	alutb.porta = 1;
	alutb.portb = 2147483647;
	alutb.aluop = ALU_SLT;
	#(PERIOD);

	alutb.porta = 2147483647;
	alutb.portb = 2147483647;
	alutb.aluop = ALU_SLT;
	#(PERIOD);

	alutb.porta = 2147483647;
	alutb.portb = 0;
	alutb.aluop = ALU_SLT;
	#(PERIOD);

	alutb.porta = -2147483647;
	alutb.portb = 2147483647;
	alutb.aluop = ALU_SLT;
	#(PERIOD);


 	//for (i = 1; i < 32; i = i +1) begin

   	//end
	//#(PERIOD*2);

	#(PERIOD*2);


end
endprogram
