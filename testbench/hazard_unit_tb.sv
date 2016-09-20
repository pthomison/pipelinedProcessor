/*
Patrick Thomison
00256-74870

Emily Fredette
00257-26474

*/

// mapped needs this
`include "hazard_unit_if.vh"
`include "cpu_types_pkg.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module hazard_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  hazard_unit_if huif ();
  // test program
  test PROG ();
  // DUT
`ifndef MAPPED
  hazard_unit DUT(huif);
`else
  hazard_unit DUT(
    .\huif.exm_WEN (huif.exm_WEN),

    .\huif.shamt_in (huif.shamt_in),
    .\huif.exm_rd_out (huif.exm_rd_out),
    .\huif.idex_rt_out (huif.idex_rt_out),
    .\huif.idex_rs_out (huif.idex_rs_out),
    .\huif.mwb_WEN (huif.mwb_WEN),
    .\huif.mwb_rd_out (huif.mwb_rd_out),
    .\huif.hazard (huif.hazard),



  );
`endif

endmodule

program test;
endprogram
