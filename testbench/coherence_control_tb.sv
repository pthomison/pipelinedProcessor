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
logic issue;


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
  issue = 0;
  mcif.ramload = 32'H00000000;

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
  $display("testcase 1:");
  // testcase inputs
  cache0.cctrans = 1;
  cache0.dREN    = 1;
  cache1.ccwrite = 1;
  mcif.dwait     = 1;
  cache0.daddr   = 31'H0000000A;
  #(PERIOD);
   if (cache0.daddr != cache1.ccsnoopaddr) begin
     $display("Issue With SnoopAddr");
     issue = 1;
   end 
  #(PERIOD);
  cache0.cctrans = 0;
  cache0.dREN    = 0;
  cache1.ccwrite = 0;
  mcif.dwait     = 0;
  cache0.daddr   = 0;
  #(PERIOD*3)
  mcif.dwait  = 1;
  #(PERIOD*3);
  mcif.dwait   = 0;  
  #(PERIOD);
// ----------------------------------------- // testcase 2

  // testcase 2: Snoop Hit, Cache 1 requestor, cache 0 requestee
  testcase = 2;
  $display("testcase 2:");
  // testcase inputs
  cache1.cctrans = 1;
  cache1.dREN    = 1;
  cache0.ccwrite = 1;
  mcif.dwait     = 1;
  cache1.daddr   = 31'H0000000B;
  #(PERIOD);
   if (cache1.daddr != cache0.ccsnoopaddr) begin
     $display("Issue With SnoopAddr");
     issue = 1;
   end 
  #(PERIOD);
  cache1.cctrans = 0;
  cache1.dREN    = 0;
  cache0.ccwrite = 0;
  mcif.dwait     = 0;
  cache0.daddr   = 0;
  #(PERIOD*3)
  mcif.dwait  = 1;
  #(PERIOD*3);
  mcif.dwait   = 0;  
  #(PERIOD);


// ----------------------------------------- // testcase 3

  // testcase 3: Snoop Miss, Cache 1 requestor, cache 0 requestee
  testcase = 3;
  $display("testcase 3:");
  // testcase inputs
  cache1.cctrans = 1;
  cache1.dREN    = 1;
  cache0.ccwrite = 0;
  mcif.dwait     = 1;
  cache1.daddr   = 31'H0000000C;
  #(PERIOD);
  #(PERIOD);
  cache1.cctrans = 0;
  cache1.dREN    = 0;
  cache0.ccwrite = 0;
  mcif.dwait     = 0;
  mcif.ramload = 32'H00DEAD00;
  cache0.daddr   = 0;
  #(PERIOD)
  mcif.ramload = 32'H00000000;
  mcif.dwait  = 1;
  #(PERIOD*3);
  mcif.dwait   = 0;  
  mcif.ramload = 32'H00BEEF00;
  #(PERIOD);
  mcif.ramload = 32'H00000000;
   if (cache1.dload != 32'H00DEAD00) begin
     $display("Issue With DATAREADY1");
     issue = 1;
   end 
  #(PERIOD);
   if (cache1.dload != 32'H00BEEF00) begin
     $display("Issue With DATAREADY2");
     issue = 1;
   end 
  #(PERIOD);

// ----------------------------------------- // testcase 4

  // testcase 4: Snoop Miss, Cache 0 requestor, cache 1 requestee
  testcase = 4;
  $display("testcase 4:");
  // testcase inputs
  cache0.cctrans = 1;
  cache0.dREN    = 1;
  cache1.ccwrite = 0;
  mcif.dwait     = 1;
  cache0.daddr   = 31'H0000000D;
  #(PERIOD);
  #(PERIOD);
  cache0.cctrans = 0;
  cache0.dREN    = 0;
  cache1.ccwrite = 0;
  mcif.dwait     = 0;
  mcif.ramload = 32'H00ABCD00;
  cache0.daddr   = 0;
  #(PERIOD)
  mcif.ramload = 32'H00000000;
  mcif.dwait  = 1;
  #(PERIOD*3);
  mcif.dwait   = 0;  
  mcif.ramload = 32'H00DCBA00;
  #(PERIOD);
  mcif.ramload = 32'H00000000;
   if (cache0.dload != 32'H00ABCD00) begin
     $display("Issue With DATAREADY1");
     issue = 1;
   end 
  #(PERIOD);
   if (cache0.dload != 32'H00DCBA00) begin
     $display("Issue With DATAREADY2");
     issue = 1;
   end 
  #(PERIOD);

// ----------------------------------------- // testcase 5

  // testcase 5: Invalid, Cache 0
  testcase = 5;
  $display("testcase 5:");
  // testcase inputs
  cache0.cctrans = 1;
  cache0.ccwrite = 1;
  cache0.daddr   = 31'H0000000E;
  #(PERIOD);
  cache0.cctrans = 0;
  cache0.ccwrite = 0;
  #(PERIOD*3);


// ----------------------------------------- // testcase 6

  // testcase 6: Invalid, Cache 1
  testcase = 6;
  $display("testcase 6:");
  // testcase inputs
  cache1.cctrans = 1;
  cache1.ccwrite = 1;
  cache1.daddr   = 31'H0000000F;
  #(PERIOD);
  cache1.cctrans = 0;
  cache1.ccwrite = 0;
  #(PERIOD*3);


// ----------------------------------------- // testcase 7

  // testcase 7: Straight to W1WEN, Cache 1
  testcase = 7;
  $display("testcase 7:");
  // testcase inputs
  cache1.cctrans = 1;
  cache1.dWEN    = 1;
  cache1.daddr   = 31'H0000001A;
  mcif.dwait     = 1;
  #(PERIOD*7);
  cache1.cctrans = 0;
  cache1.ccwrite = 0;
  mcif.dwait     = 0;
  #(PERIOD);
  mcif.dwait     = 1;
  #(PERIOD*5);
  mcif.dwait     = 0;
  #(PERIOD);
  mcif.dwait     = 1;

  cache1.dWEN    = 0;
  #(PERIOD*3);


// ----------------------------------------- // testcase 8

  // testcase 8: Straight to W1WEN, Cache 0
  testcase = 8;
  $display("testcase 8:");
  // testcase inputs
  cache0.cctrans = 1;
  cache0.dWEN    = 1;
  cache0.daddr   = 31'H0000001A;
  mcif.dwait     = 1;
  #(PERIOD*7);
  cache0.cctrans = 0;
  cache0.ccwrite = 0;
  mcif.dwait     = 0;
  #(PERIOD);
  mcif.dwait     = 1;
  #(PERIOD*5);
  mcif.dwait     = 0;
  #(PERIOD);
  mcif.dwait     = 1;

  cache1.dWEN    = 0;
  #(PERIOD*3);

  #(PERIOD*10);

end
endprogram

