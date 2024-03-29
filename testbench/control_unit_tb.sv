/*
  Emily Fredette

  request unit test bench
*/

// mapped needs this
`include "request_unit_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module control_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface

  control_unit_if cuif ();

  // test program
  test PROG (cuif);

  // DUT
`ifndef MAPPED
  control_unit DUT(cuif);
`else
  control_unit DUT(
    .\cuif.instruction (cuif.instruction),
    .\cuif.ALUop (cuif.ALUop),
    .\cuif.ALUsrc (cuif.ALUsrc),
    .\cuif.PCsrc (cuif.PCsrc),
    .\cuif.MemtoReg (cuif.MemtoReg),
    .\cuif.WEN (cuif.WEN),
    .\cuif.RegDest (cuif.RegDest),
    .\cuif.jump (cuif.jump),
    .\cuif.jal (cuif.jal),
    .\cuif.extop (cuif.extop),
    .\cuif.dWEN (cuif.dWEN),
    .\cuif.dREN (cuif.dREN),
    .\cuif.rs (cuif.rs),
    .\cuif.rt (cuif.rt),
    .\cuif.rd (cuif.rd),
    .\cuif.immed (cuif.immed),
    .\cuif.LUI (cuif.LUI),
    .\cuif.imemREN (cuif.imemREN),
    .\cuif.shamt (cuif.shamt),
    .\cuif.BEQ (cuif.BEQ),

  );

`endif


endmodule

program test(
	control_unit_if.tb tbif

);
parameter PERIOD = 10;
initial begin


	tbif.instruction = 32'b00000010001100100100000000100000;
	//op = 000000
	//rs = 10001
	//rt = 10010
	//rd = 01000
	//shamt = 00000
	//funct = 10000
	//add $t0, $s1, $s2

	#(PERIOD);

	tbif.instruction = 32'b00010110001100100100000000100000;
	//op = 000000
	//rs = 10001
	//rt = 10010
	//rd = 01000
	//shamt = 00000
	//funct = 10000
	//add $t0, $s1, $s2

	#(PERIOD);

	tbif.instruction = 32'b11111110001100100100000000100000;
	//op = 000000
	//rs = 10001
	//rt = 10010
	//rd = 01000
	//shamt = 00000
	//funct = 10000
	//add $t0, $s1, $s2

	#(PERIOD);


end


endprogram
