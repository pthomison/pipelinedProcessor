/*
Patrick Thomison
00256-74870

Emily Fredette
00257-26474

*/

// mapped needs this
`include "pipeline_register_if.vh"
`include "cpu_types_pkg.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module pipeline_register_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  pipeline_register_if prif ();
  // test program
  test PROG ();
  // DUT
`ifndef MAPPED
  pipeline_register DUT(CLK, nRST, prif);
`else
  pipeline_register DUT(
    .\prif.flush (prif.flush),

    .\prif.shamt_in (prif.shamt_in),
    .\prif.instruction_in (prif.instruction_in),
    .\prif.rdat2_in (prif.rdat2_in),
    .\prif.rdat1_in (prif.rdat1_in),
    .\prif.PCplus4_in (prif.PCplus4_in),
    .\prif.outport_in (prif.outport_in),
    .\prif.dmemload_in (prif.dmemload_in),
    .\prif.wsel_in (prif.wsel_in),
    .\prif.rs_in (prif.rs_in),
    .\prif.immed_in (prif.immed_in),
    .\prif.rt_in (prif.rt_in),
    .\prif.rd_in (prif.rd_in),
    .\prif.ALUop_in (prif.ALUop_in),
    .\prif.ALUsrc_in (prif.ALUsrc_in),
    .\prif.pcsrc_in (prif.pcsrc_in),
    .\prif.RegDest_in (prif.RegDest_in),
    .\prif.MemtoReg_in (prif.MemtoReg_in),
    .\prif.branch_in (prif.branch_in),
    .\prif.WEN_in (prif.WEN_in),
    .\prif.extop_in (prif.extop_in),
    .\prif.jal_in (prif.jal_in),
    .\prif.dWEN_in (prif.dWEN_in),
    .\prif.dREN_in (prif.dREN_in),
    .\prif.LUI_in (prif.LUI_in),
    .\prif.BEQ_in (prif.BEQ_in),
    .\prif.halt_in (prif.halt_in),
    .\prif.zero_f_in (prif.zero_f_in),

    .\prif.shamt_out (prif.shamt_out),
    .\prif.instruction_out (prif.instruction_out),
    .\prif.rdat1_out (prif.rdat1_out),
    .\prif.rdat2_out (prif.rdat2_out),
    .\prif.PCplus4_out (prif.PCplus4_out),
    .\prif.outport_out (prif.outport_out),
    .\prif.dmemload_out (prif.dmemload_out),
    .\prif.wsel_out (prif.wsel_out),
    .\prif.rs_out (prif.rs_out),
    .\prif.immed_out (prif.immed_out),
    .\prif.rt_out (prif.rt_out),
    .\prif.rd_out (prif.rd_out),
    .\prif.ALUop_out (prif.ALUop_out),
    .\prif.ALUsrc_out (prif.ALUsrc_out),
    .\prif.pcsrc_out (prif.pcsrc_out),
    .\prif.RegDest_out (prif.RegDest_out),
    .\prif.MemtoReg_out (prif.MemtoReg_out),
    .\prif.branch_out (prif.branch_out),
    .\prif.WEN_out (prif.WEN_out),
    .\prif.extop_out (prif.extop_out),
    .\prif.jal_out (prif.jal_out),
    .\prif.dWEN_out (prif.dWEN_out),
    .\prif.dREN_out (prif.dREN_out),
    .\prif.LUI_out (prif.LUI_out),
    .\prif.BEQ_out (prif.BEQ_out),
    .\prif.halt_out (prif.halt_out),
    .\prif.zero_f_out (prif.zero_f_out),



    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

endmodule

program test;
endprogram
