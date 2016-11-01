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
  caches_if cache2();
  caches_if cache3();

  cache_control_if #(.CPUS(2)) ccif (cache0, cache1);
  cache_control_if #(.CPUS(1)) mcif (cache2, cache3);

  // test program
  test PROG (CLK, nRST, mcif, cache0, cache1);
  // DUT
`ifndef MAPPED
  coherence_control DUT(CLK, nRST, ccif, mcif);
  //memory_control DUTM(CLK, nRST, mcif);
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
  //       .\caches_ifcif.cctrans (cif.cctrans),
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
  cache_control_if.cc mcif,
  caches_if.tb cache0,
  caches_if.tb cache1
);

import cpu_types_pkg::*;

int testcase; 


parameter PERIOD = 10;
initial begin

// ----------------------------------------- // testcase 0 - reset

  testcase = 0;

  //Intial Conditions
  cache0.dWEN    = 0;
  cache1.dWEN    = 0;
  cache0.dREN    = 0;
  cache1.dREN    = 0;
  cache0.dstore  = 0;
  cache1.dstore  = 0;
  cache0.daddr   = 0;
  cache1.daddr   = 0;
  cache0.ccwrite = 0;
  cache1.ccwrite = 0;
  cache0.cctrans = 0;
  cache1.cctrans = 0;

  // Reseting
  #(PERIOD*2);
  nRST = 0;
  #(PERIOD*2);
  nRST = 1;
  #(PERIOD);

  // // Check outputs
  // if (currState == IDLE) 
  // ramstore
  // ramaddr
  // ramWEN
  // ramREN
  // ccsnoopaddr
  // ccinv
  // dwait
  // dload


// ----------------------------------------- // testcase 1

  // testcase 1: Snoop Hit, Cache 0 requestor, cache 1 requestee
  testcase = 1;

  // testcase inputs
  cache0.cctrans = 1;
  cache0.dREN    = 1;
  cache1.ccwrite = 1;
  mcif.dwait     = 1;
  #(PERIOD*3);
  mcif.dwait      = 0;
  #(PERIOD)
  mcif.dwait  = 1;
  #(PERIOD*3);
  mcif.dwait   = 0;  

// ----------------------------------------- // testcase 1

  // testcase 1: Snoop Hit, Cache 0 requestor, cache 1 requestee
  testcase = 1;



end
endprogram

