/*
Emily Fredette
*/

// mapped needs this
`include "cache_control_if.vh"
`include "cpu_types_pkg.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module icache_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  datapath_cache_if dcif ();
  caches_if cif ();

  caches_if cache1();

  cache_control_if #(.CPUS(1)) ccif (cif, cache1);
  cpu_ram_if ramif ();

  //inputs to RAM
  assign ramif.ramREN = ccif.ramREN;
  assign ramif.ramWEN = ccif.ramWEN;
  assign ramif.ramstore = ccif.ramstore;
  assign ramif.ramaddr = ccif.ramaddr;

  //inputs to MEM
  assign ccif.ramstate = ramif.ramstate;
  assign ccif.ramload = ramif.ramload;

  // test program
  test PROG (CLK, nRST, dcif, cif);
  // DUT
`ifndef MAPPED
  icache DUT(CLK, nRST, dcif, cif);
  memory_control DUTMEM(CLK, nRST, ccif);
  ram DUTRAM(CLK, nRST, ramif);
`else
  icache DUT(
        .\cif.dwait (cif.dwait),
        .\cif.dload (cif.dload),
        .\cif.ccwait (cif.ccwait),
        .\cif.ccinv (cif.ccinv),
        .\cif.ccsnoopaddr (cif.ccsnoopaddr),
        .\cif.iwait (cif.iwait),
        .\cif.iload (cif.iload),
        .\cif.dREN (cif.dREN),
        .\cif.dWEN (cif.dWEN),
        .\cif.daddr (cif.daddr),
        .\cif.dstore (cif.dstore),
        .\cif.ccwrite (cif.ccwrite),
        .\cif.cctrans (cif.cctrans),
        .\cif.iREN (cif.iREN),
        .\cif.iaddr (cif.iaddr),
        .\dcif.dmemstore (dcif.dmemstore),
        .\nRST (nRST),
        .\CLK (CLK)
  );

  memory_control DUTMEM(
    .\ccif.iREN (ccif.iREN),
    .\ccif.dREN (ccif.dREN),
    .\ccif.dWEN (ccif.dWEN),
    .\ccif.dstore (ccif.dstore),
    .\ccif.iaddr (ccif.iaddr),
    .\ccif.daddr (ccif.daddr),
    .\ccif.ramload (ccif.ramload),
    .\ccif.ramstate (ccif.ramstate),
    .\ccif.ccwrite (ccif.ccwrite),
    .\ccif.cctrans (ccif.cctrans),
    .\ccif.iwait (ccif.iwait),
    .\ccif.dwait (ccif.dwait),
    .\ccif.iload (ccif.iload),
    .\ccif.dload (ccif.dload),
    .\ccif.ramstore (ccif.ramstore),
    .\ccif.ramaddr (ccif.ramaddr),
    .\ccif.ramWEN (ccif.ramWEN),
    .\ccif.ramREN (ccif.ramREN),
    .\ccif.ccwait (ccif.ccwait),
    .\ccif.ccinv (ccif.ccinv),
    .\ccif.ccsnoopaddr (ccif.ccsnoopaddr),

    .\nRST (nRST),
    .\CLK (CLK)
  );

  ram DUTRAM(
    .\ramif.ramaddr (ramif.ramaddr),
    .\ramif.ramstore (ramif.ramstore),
    .\ramif.ramREN (ramif.ramREN),
    .\ramif.ramWEN (ramif.ramWEN),
    .\ramif.ramstate (ramif.ramstate),
    .\ramif.ramload (ramif.ramload),

    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

endmodule



// Signals Going Into The DUT
// Datapath: imemREN, imemaddr

program test(
  input logic CLK, 
  output logic nRST,
  datapath_cache_if.tb dcif,
  caches_if.tb cif
);

import cpu_types_pkg::*;
word_t reqAddr;
word_t expected_imemload;
int testcase;

parameter PERIOD = 10;
initial begin

// ----------------------------------------- // testcase 0 - reset
  testcase = 0;

  dcif.imemREN = 0;
  dcif.imemaddr = 0;

  #(PERIOD*2);
  nRST = 0;
  #(PERIOD*2);
  nRST = 1;
  #(PERIOD * 10);

// ----------------------------------------- // testcase 1 - miss
  testcase = 1;

  reqAddr = 32'h0000C000;

  // testcase inputs
  dcif.imemREN = 1;
  dcif.imemaddr = reqAddr;

  // testcase expected
  expected_imemload = 32'h00000050;

  // testcase trigger point
  @(dcif.ihit);

  // input reset
  dcif.imemREN = 0;
  dcif.imemaddr = 0;

  // testcase tests
  $display("testcase 1:");
  if (expected_imemload == dcif.imemload) begin
    $display("Design correctly delivered requested memory on a read miss");
  end else begin
    $display("Design INCORRECTLY delivered requested memory on a read miss");
  end

  #(PERIOD);

// ----------------------------------------- // testcase 2 - miss
  testcase = 2;

  // testcase inputs
  dcif.imemREN = 1;
  dcif.imemaddr = reqAddr + 4;

  // testcase expected
  expected_imemload = 32'h00000100;

  // testcase trigger point
  @(dcif.ihit);

  // input reset
  dcif.imemREN = 0;
  dcif.imemaddr = 0;

  // testcase tests
  $display("testcase 2:");
  if (expected_imemload == dcif.imemload) begin
    $display("Design correctly delivered requested memory on a read miss");
  end else begin
    $display("Design INCORRECTLY delivered requested memory on a read miss");
  end

  #(PERIOD);

// ----------------------------------------- // testcase 3 - hit
  testcase = 3;

  // testcase inputs
  dcif.imemREN = 1;
  dcif.imemaddr = reqAddr;

  // testcase expected
  expected_imemload = 32'h00000050;

  // testcase trigger point
  @(dcif.ihit);

  // input reset
  dcif.imemREN = 0;
  dcif.imemaddr = 0;

  // testcase tests
  $display("testcase 3:");
  if (expected_imemload == dcif.imemload) begin
    $display("Design correctly delivered requested memory on a read hit");
  end else begin
    $display("Design INCORRECTLY delivered requested memory on a read hit");
  end

  #(PERIOD);

// ----------------------------------------- // testcase 4 - hit
  testcase = 4;

  // testcase inputs
  dcif.imemREN = 1;
  dcif.imemaddr = reqAddr + 4;

  // testcase expected
  expected_imemload = 32'h00000100;

  // testcase trigger point
  @(dcif.ihit);

  // input reset
  dcif.imemREN = 0;
  dcif.imemaddr = 0;

  // testcase tests
  $display("testcase 4:");
  if (expected_imemload == dcif.imemload) begin
    $display("Design correctly delivered requested memory on a read hit");
  end else begin
    $display("Design INCORRECTLY delivered requested memory on a read hit");
  end

  #(PERIOD);

// ---------------------------------------------- //
  // // Reading, MISS, OVERWRITE previous data
  // // Many clk cycles until iload ready
  // #(PERIOD)
  // #(PERIOD)
  // cif.iwait = 0;
  // cif.iload = 0;
  
  // reqAddr = 32'h00011000;
  // dcif.imemREN = 1;
  // dcif.imemaddr = reqAddr;

  // #(PERIOD);

  // if (cif.iREN) begin
  //   cif.iwait = 1;
  //   #(PERIOD);
  //   #(PERIOD);
  //   #(PERIOD);
  //   #(PERIOD);
  //   #(PERIOD);
  //   cif.iload = 32'h00BEEF00;
  //   expected_imemload = 32'h00BEEF00;
  //   #1;
  //   cif.iwait = 0;
  //   dcif.imemREN = 0;
  // end
  // #(PERIOD)
  // expected_imemload = 32'h00000000;

  // // Reading, MISS
  // // Many clk cycles until iload ready
  // #(PERIOD)
  // #(PERIOD)
  // cif.iwait = 0;
  // cif.iload = 0;
  
  // reqAddr = 32'h00011010;
  // dcif.imemREN = 1;
  // dcif.imemaddr = reqAddr;

  // #(PERIOD);

  // if (cif.iREN) begin
  //   cif.iwait = 1;
  //   #(PERIOD);
  //   #(PERIOD);
  //   #(PERIOD);
  //   #(PERIOD);
  //   #(PERIOD);
  //   cif.iload = 32'h00DEED00;
  //   expected_imemload = 32'h00DEED00;
  //   #1;
  //   cif.iwait = 0;
  //   dcif.imemREN = 0;
  // end
  // #(PERIOD)
  // expected_imemload = 32'h00000000;

  // // Reading, HIT, output is BEEF
  // // Many clk cycles until iload ready
  // #(PERIOD)
  // #(PERIOD)
  // cif.iwait = 0;
  // cif.iload = 0;
  
  // reqAddr = 32'h00011000;
  // dcif.imemREN = 1;
  // dcif.imemaddr = reqAddr;

  // #(PERIOD);
  // expected_imemload = 32'h00BEEF00;
  // if (cif.iREN) begin
  //   cif.iwait = 1;
  //   #(PERIOD);
  //   #(PERIOD);
  //   #(PERIOD);
  //   #(PERIOD);
  //   #(PERIOD);
  //   cif.iload = 32'h00FEEF00; //dont care b/c hit
  //   #1;
  //   cif.iwait = 0;
  //   dcif.imemREN = 0;
  // end
  // #(PERIOD)
  // expected_imemload = 32'h00000000;

  // // Reading, MISS
  // // Many clk cycles until iload ready
  // #(PERIOD)
  // #(PERIOD)
  // cif.iwait = 0;
  // cif.iload = 0;
  
  // reqAddr = 32'h00011110;
  // dcif.imemREN = 1;
  // dcif.imemaddr = reqAddr;

  // #(PERIOD);

  // if (cif.iREN) begin
  //   cif.iwait = 1;
  //   #(PERIOD);
  //   #(PERIOD);
  //   #(PERIOD);
  //   #(PERIOD);
  //   #(PERIOD);
  //   #(PERIOD);
  //   #(PERIOD);
  //   #(PERIOD);
  //   #(PERIOD);
  //   #(PERIOD);
  //   cif.iload = 32'h00FFFF00;
  //   expected_imemload = 32'h00FFFF00;
  //   #1;
  //   cif.iwait = 0;
  //   dcif.imemREN = 0;
  // end
  // #(PERIOD)
  // expected_imemload = 32'h00000000;

  // // HIT, output is BEEF
  // // Many clk cycles until iload ready
  // #(PERIOD)
  // #(PERIOD)
  // cif.iwait = 0;
  // cif.iload = 0;
  
  // reqAddr = 32'h00011000;
  // dcif.imemREN = 1;
  // dcif.imemaddr = reqAddr;

  // #(PERIOD);
  // expected_imemload = 32'h00BEEF00;
  // if (cif.iREN) begin
  //   cif.iwait = 1;
  //   #(PERIOD);
  //   #(PERIOD);
  //   #(PERIOD);
  //   #(PERIOD);
  //   #(PERIOD);
  //   cif.iload = 32'h00FEEF00; //dont care b/c hit
  //   #1;
  //   cif.iwait = 0;
  //   dcif.imemREN = 0;
  // end
  // #(PERIOD)
  // expected_imemload = 32'h00000000;

  // #(PERIOD);
  
  // #(PERIOD);

  // #(PERIOD);

  #(PERIOD*10);

end
endprogram
