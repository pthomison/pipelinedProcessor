/*
  Emily Fredette

  request unit test bench
*/

// mapped needs this
`include "pc_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module pc_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface

  pc_if pcif ();

  // test program
  test PROG (CLK, nRST, pcif);

  // DUT
`ifndef MAPPED
  pc DUT(CLK, nRST, pcif);
`else
  pc DUT(
    .\pcif.pcenable (pcif.pcenable),
    .\pcif.pcnext (pcif.pcnext),
    .\pcif.pcout (pcif.pcout),

    .\nRST (nRST),
    .\CLK (CLK)
  );

`endif

endmodule

program test(
	input logic CLK, nRST,
	pc_if.tb tbif

);
parameter PERIOD = 10;
initial begin


	tbif.pcenable = 0;
	tbif.pcnext = 0;

	#(PERIOD);

	tbif.pcenable = 0;
	tbif.pcnext = 1;

	#(PERIOD);

	tbif.pcenable = 0;
	tbif.pcnext = 2;

	#(PERIOD);

	tbif.pcenable = 0;
	tbif.pcnext = 3;

	#(PERIOD);

	tbif.pcenable = 1;
	tbif.pcnext = 4;

	#(PERIOD);

	tbif.pcenable = 1;
	tbif.pcnext = 5;

	#(PERIOD);

	tbif.pcenable = 1;
	tbif.pcnext = 6;

	#(PERIOD);

	tbif.pcenable = 1;
	tbif.pcnext = 7;

	#(PERIOD);

	tbif.pcenable = 0;
	tbif.pcnext = 8;

	#(PERIOD);

	tbif.pcenable = 0;
	tbif.pcnext = 9;

	#(PERIOD);
end


endprogram
