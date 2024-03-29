/*
  Emily Fredette

  request unit test bench
*/

// mapped needs this
`include "request_unit_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module request_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface

  request_unit_if ruif ();

  // test program
  test PROG (CLK, nRST, ruif);

  // DUT
`ifndef MAPPED
  request_unit DUT(CLK, nRST, ruif);
`else
  request_unit DUT(
    .\ruif.ihit (ruif.ihit),
    .\ruif.dhit (ruif.dhit),
    .\ruif.dwen (ruif.dwen),
    .\ruif.dren (ruif.dren),
    .\ruif.dmemren (ruif.dmemren),
    .\ruif.dmemwen (ruif.dmemwen),
    .\ruif.pcenable (ruif.pcenable),

    .\nRST (nRST),
    .\CLK (CLK)
  );

`endif

endmodule

program test(
	input logic CLK,
	output logic nRST,
	request_unit_if.tb tbif

);
parameter PERIOD = 10;
initial begin

	#(PERIOD*2);
	nRST = 0;
	#(PERIOD*2);
	nRST = 1;

	tbif.dhit = 1;
	tbif.ihit = 0;
	tbif.dwen = 0;
	tbif.dren = 0;

	#(PERIOD);

	tbif.dhit = 1;
	tbif.ihit = 0;
	tbif.dwen = 0;
	tbif.dren = 1;

	#(PERIOD);

	tbif.dhit = 1;
	tbif.ihit = 0;
	tbif.dwen = 1;
	tbif.dren = 0;

	#(PERIOD);

	tbif.dhit = 0;
	tbif.ihit = 1;
	tbif.dwen = 0;
	tbif.dren = 0;

	#(PERIOD);

	tbif.dhit = 0;
	tbif.ihit = 0;
	tbif.dwen = 1;
	tbif.dren = 0;

	#(PERIOD);

	tbif.dhit = 0;
	tbif.ihit = 0;
	tbif.dwen = 0;
	tbif.dren = 1;

	#(PERIOD);
end


endprogram
