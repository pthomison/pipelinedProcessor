/*
  Emily Fredette
*/

// mapped needs this
`include "cache_control_if.vh"
`include "cpu_types_pkg.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module coherence_control_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  caches_if cache0();
  caches_if cache1();

  cache_control_if #(.CPUS(2)) ccif (cache0, cache1);
  cache_control_if #(.CPUS(1)) mcif (cache0, cache1);

  // test program
  test PROG (CLK, nRST, ccif, mcif);
  // DUT
`ifndef MAPPED
  coherence_control DUT(CLK, nRST, ccif);
  memory_control DUTM(CLK, nRST, mcif);
`else
  // dcache DUT(
  //       .\cif.dwait (cif.dwait),
  //       .\cif.dload (cif.dload),
  //       .\cif.ccwait (cif.ccwait),
  //       .\cif.ccinv (cif.ccinv),
  //       .\cif.ccsnoopaddr (cif.ccsnoopaddr),
  //       .\cif.iwait (cif.iwait),
  //       .\cif.iload (cif.iload),
  //       .\cif.dREN (cif.dREN),
  //       .\cif.dWEN (cif.dWEN),
  //       .\cif.daddr (cif.daddr),
  //       .\cif.dstore (cif.dstore),
  //       .\cif.ccwrite (cif.ccwrite),
  //       .\cif.cctrans (cif.cctrans),
  //       .\cif.iREN (cif.iREN),
  //       .\cif.iaddr (cif.iaddr),
  //       .\dcif.dmemstore (dcif.dmemstore),
  //       .\nRST (nRST),
  //       .\CLK (CLK)
  // );

  // memory_control DUTMEM(
  //   .\ccif.iREN (ccif.iREN),
  //   .\ccif.dREN (ccif.dREN),
  //   .\ccif.dWEN (ccif.dWEN),
  //   .\ccif.dstore (ccif.dstore),
  //   .\ccif.iaddr (ccif.iaddr),
  //   .\ccif.daddr (ccif.daddr),
  //   .\ccif.ramload (ccif.ramload),
  //   .\ccif.ramstate (ccif.ramstate),
  //   .\ccif.ccwrite (ccif.ccwrite),
  //   .\ccif.cctrans (ccif.cctrans),
  //   .\ccif.iwait (ccif.iwait),
  //   .\ccif.dwait (ccif.dwait),
  //   .\ccif.iload (ccif.iload),
  //   .\ccif.dload (ccif.dload),
  //   .\ccif.ramstore (ccif.ramstore),
  //   .\ccif.ramaddr (ccif.ramaddr),
  //   .\ccif.ramWEN (ccif.ramWEN),
  //   .\ccif.ramREN (ccif.ramREN),
  //   .\ccif.ccwait (ccif.ccwait),
  //   .\ccif.ccinv (ccif.ccinv),
  //   .\ccif.ccsnoopaddr (ccif.ccsnoopaddr),

  //   .\nRST (nRST),
  //   .\CLK (CLK)
  // );
`endif

endmodule

program test(
  input logic CLK, 
  output logic nRST,
  cache_control_if.cc ccif,
  cache_control_if.cc mcif
);

import cpu_types_pkg::*;

int testcase; 


parameter PERIOD = 10;
initial begin

// ----------------------------------------- // testcase 0 - reset

  testcase = 0;

  //Intial Conditions


  // Reseting
  #(PERIOD*2);
  nRST = 0;
  #(PERIOD*2);
  nRST = 1;
  #(PERIOD);

// ----------------------------------------- // testcase 1

  // testcase 1: read miss - cache 0, index 0
  testcase = 1;

  // testcase inputs



  // // testcase trigger point
  // @(dcif.dhit);

  // // testcase tests
  // $display("testcase 1:");

  // // testing output
  // if (expected_dmemload == dcif.dmemload) begin
  //   $display("Design correctly delivered requested memory on a read miss");
  // end else begin
  //   $display("Design INCORRECTLY delivered requested memory on a read miss");
  // end

  // // testing cache load
  // if (expected_cacheData1 == DUT.cacheOne[0].data.wordA) begin
  //   $display("Design correctly loaded first word of requested memory on a read miss");
  // end else begin
  //   $display("Design INCORRECTLY loaded first word of requested memory on a read miss");
  // end

  // if (expected_cacheData2 == DUT.cacheOne[0].data.wordB) begin
  //   $display("Design correctly loaded second word of requested memory on a read miss");
  // end else begin
  //   $display("Design INCORRECTLY loaded second word of requested memory on a read miss");
  // end

// ----------------------------------------- // reset

  // Reseting inputs & expected values



end
endprogram

