/*
  Patrick Thomison
*/

// mapped needs this
`include "cache_control_if.vh"
`include "cpu_types_pkg.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module dcache_tb;

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
  dcache DUT(CLK, nRST, dcif, cif);
  memory_control DUTMEM(CLK, nRST, ccif);
  ram DUTRAM(CLK, nRST, ramif);
`else
  dcache DUT(
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

program test(
  input logic CLK, 
  output logic nRST,
  datapath_cache_if.tb dcif,
  caches_if.tb cif
);

import cpu_types_pkg::*;

word_t expected_cacheData1, expected_cacheData2, expected_dmemload;
int expected_cache;
int testcase; 
logic [25:0] tag;
logic [2:0]  idx;
logic        blkoff;
logic [1:0]  bytoff;

assign dcif.dmemaddr = {tag, idx, blkoff, bytoff};

parameter PERIOD = 10;
initial begin

// ----------------------------------------- // testcase 0

  testcase = 0;

  //Intial Conditions
  dcif.halt = 0;
  dcif.dmemWEN = 0;
  dcif.dmemREN = 0;
  dcif.dmemstore = 32'h000000DC;
  tag = 0;
  idx = 0;
  blkoff = 0;
  bytoff = 0;
  //dcif.dmemaddr  = 32'h000000DC;

  // Reseting
  #(PERIOD*2);
  nRST = 0;
  #(PERIOD*2);
  nRST = 1;
  #(PERIOD);

// ----------------------------------------- // testcase 1

  // testcase 1: read miss - cache 1, index 0
  testcase = 1;

  // testcase inputs
  dcif.halt = 0;
  dcif.dmemWEN = 0;
  dcif.dmemREN = 1;
  dcif.dmemstore = 32'h000000DC; //dc
  //address = 32'h00000100;
  tag    = 26'b00000000000000000000000100;
  idx    =  3'b000;
  blkoff =  1'b0;
  bytoff =  2'b00;

  // testcase expected
  expected_cache = 0;
  expected_cacheData1 = 32'h00000050;
  expected_cacheData2 = 32'h000000A0;
  expected_dmemload   = 32'h00000050;

  // testcase trigger point
  @(dcif.dhit);

  // testcase tests

  // testing output
  if (expected_dmemload == dcif.dmemload) begin
    $display("Design correctly delivered requested memory on a read miss");
  end else begin
    $display("Design INCORRECTLY delivered requested memory on a read miss");
  end

  // testing cache load
  if (expected_cacheData1 == DUT.cacheOne[0].data.wordA) begin
    $display("Design correctly loaded first word of requested memory on a read miss");
  end else begin
    $display("Design INCORRECTLY loaded first word of requested memory on a read miss");
  end

  if (expected_cacheData2 == DUT.cacheOne[0].data.wordB) begin
    $display("Design correctly loaded second word of requested memory on a read miss");
  end else begin
    $display("Design INCORRECTLY loaded second word of requested memory on a read miss");
  end

// ----------------------------------------- // reset

  #(PERIOD);

  // Reseting inputs & expected values
  dcif.halt      = 0;
  dcif.dmemWEN   = 0;
  dcif.dmemREN   = 0;
  dcif.dmemstore = 32'h000000DC; //dc
  tag    = 0;
  idx    = 0;
  blkoff = 0;
  bytoff = 0;
  expected_cache      = 0;
  expected_cacheData1 = 0;
  expected_cacheData2 = 0;
  expected_dmemload   = 0;

  #(PERIOD)

// ----------------------------------------- // testcase 2

  // //
  // // read miss - fill cache 2 instead - same index
  // // cache2
  // //
  // testcase = 2;
  // dcif.halt = 0;
  // dcif.dmemWEN = 0;
  // dcif.dmemREN = 1;
  // dcif.dmemstore = 32'h000000DC; //dc
  // dcif.dmemaddr = 32'h0000A004;

  // expected_cache = 2;
  // expected_dmemload1 = 32'h00000002; //cache 2
  // expected_dmemload2 = 32'h00000001;

  // @(dcif.dhit);

  // if (expected_dmemload1 == dcif.dmemload) begin
  //   $display("Design correctly requested memory on a read miss");
  // end else begin
  //   $display("Design INCORRECTLY requested memory on a read miss");
  // end

  // #(PERIOD)

  // // Restesting Ghost Values
  // dcif.dmemWEN = 0;
  // expected_cache = 0;
  // expected_dmemload1 = 32'h00000000;
  // expected_dmemload2 = 32'h00000000;

  // //
  // // read hit - cache 1
  // //
  // testcase = 3;
  // dcif.halt = 0;
  // dcif.dmemWEN = 0;
  // dcif.dmemREN = 1;
  // dcif.dmemstore = 32'h000000DC; //dc
  // dcif.dmemaddr = 32'h00000104;

  // expected_cache = 1;
  // expected_dmemload1 = 32'h000000A0;
  // expected_dmemload2 = 32'h00000050;


  // @(dcif.dhit);

  // if (expected_dmemload1 == dcif.dmemload) begin
  //   $display("Design correctly requested memory on a read hit");
  // end else begin
  //   $display("Design INCORRECTLY requested memory on a read hit");
  // end

  // #(PERIOD)

  // // Reseting Ghost Values
  // dcif.dmemWEN = 0;
  // expected_cache = 0;
  // expected_dmemload1 = 32'h00000000;
  // expected_dmemload2 = 32'h00000000;

  // //
  // // read hit - cache 2
  // //
  // testcase = 4;
  // dcif.halt = 0;
  // dcif.dmemWEN = 0;
  // dcif.dmemREN = 1;
  // dcif.dmemstore = 32'h000000DC; //dc
  // dcif.dmemaddr = 32'h0000A000;

  // expected_cache = 2;
  // expected_dmemload1 = 32'h00000001;
  // expected_dmemload2 = 32'h00000002;

  // @(dcif.dhit);

  // dcif.dmemWEN = 0;

  // if (expected_dmemload1 == dcif.dmemload) begin
  //   $display("Design correctly requested memory on a read hit");
  // end else begin
  //   $display("Design INCORRECTLY requested memory on a read hit");
  // end
 
  // #(PERIOD)

  // expected_cache = 0;
  // expected_dmemload1 = 32'h00000000;
  // expected_dmemload2 = 32'h00000000;


  // //
  // // write miss
  // // cache1
  // //
  // testcase = 5;
  // dcif.halt = 0;
  // dcif.dmemWEN = 1;
  // dcif.dmemREN = 0;
  // dcif.dmemstore = 32'h00BEEF00;
  // dcif.dmemaddr = 32'h0000B000;

  // expected_cache = 1;
  // expected_dmemload1 = 32'h00BEEF00;
  // expected_dmemload2 = 32'h0000000B;
  
  // @(dcif.dhit);
  // dcif.dmemWEN = 0;

  // if (expected_dmemload1 == dcif.dmemload) begin
  //   $display("Design correctly requested memory on a write miss");
  // end else begin
  //   $display("Design INCORRECTLY requested memory on a write miss");
  // end

  // #(PERIOD)

  // expected_cache = 0;
  // expected_dmemload1 = 32'h00000000;
  // expected_dmemload2 = 32'h00000000;



  // //
  // // write hit
  // // cache1
  // // make dirty
  // //
  // testcase = 6;
  // dcif.halt = 0;
  // dcif.dmemWEN = 1;
  // dcif.dmemREN = 0;
  // dcif.dmemstore = 32'h00DEAD00;
  // dcif.dmemaddr = 32'h0000B000;
  // expected_cache = 1;
  // expected_dmemload1 = 32'h00DEAD00;

  // @(dcif.dhit);

  // dcif.dmemWEN = 0;

  // if (expected_dmemload1 == dcif.dmemload) begin
  //   $display("Design correctly requested memory on a write hit");
  // end else begin
  //   $display("Design INCORRECTLY requested memory on a write hit");
  // end

  // #(PERIOD)

  // expected_cache = 0;
  // expected_dmemload1 = 32'h00000000;


  // //
  // // read miss
  // // at this point, recUsed is 0, means cache 1 used recently
  // // want to load data into cache 2 = destination is 1
  // // which is DIRTY
  // //
  // testcase = 7;
  // dcif.halt = 0;
  // dcif.dmemWEN = 0;
  // dcif.dmemREN = 1;
  // dcif.dmemstore = 32'h000000DC; //dc
  // dcif.dmemaddr = 32'h0000C000;
  // expected_cache = 2;
  // expected_dmemload1 = 32'h0000000C;

  // @(dcif.dhit);

  // if (expected_dmemload1 == dcif.dmemload) begin
  //   $display("Design correctly requested memory on a read miss");
  // end else begin
  //   $display("Design INCORRECTLY requested memory on a read miss");
  // end

  // #(PERIOD)

  // dcif.dmemWEN = 0;
  // expected_cache = 0;
  // expected_dmemload1 = 32'h00000000;












  // // Getting ready for halt
  // // Making 4 dirty
  // $display("  Pre-Halt testcases");

  // //
  // // write miss
  // // cache 1 (I think)
  // // 1
  // testcase = 8;
  // dcif.halt = 0;
  // dcif.dmemWEN = 1;
  // dcif.dmemREN = 0;
  // dcif.dmemstore = 32'hABCD0000;
  // dcif.dmemaddr = 32'h0000FA54;

  // expected_cache = 1;
  // expected_dmemload1 = 32'hABCD0000;
  // expected_dmemload2 = 32'h00000002;
  
  // @(dcif.dhit);
  // dcif.dmemWEN = 0;

  // if (expected_dmemload1 == dcif.dmemload) begin
  //   $display("Design correctly requested memory on a write miss");
  // end else begin
  //   $display("Design INCORRECTLY requested memory on a write miss");
  // end

  // #(PERIOD)

  // expected_cache = 0;
  // expected_dmemload1 = 32'h00000000;
  // expected_dmemload2 = 32'h00000000;

  // //
  // // write miss
  // // cache 2
  // // 2
  // testcase = 9;
  // dcif.halt = 0;
  // dcif.dmemWEN = 1;
  // dcif.dmemREN = 0;
  // dcif.dmemstore = 32'hABCD0000;
  // dcif.dmemaddr = 32'h0000EA56;

  // expected_cache = 2;
  // expected_dmemload1 = 32'hABCD0000;
  // expected_dmemload2 = 32'h00000001;
  
  // @(dcif.dhit);
  // dcif.dmemWEN = 0;

  // if (expected_dmemload1 == dcif.dmemload) begin
  //   $display("Design correctly requested memory on a write miss");
  // end else begin
  //   $display("Design INCORRECTLY requested memory on a write miss");
  // end

  // #(PERIOD)

  // expected_cache = 0;
  // expected_dmemload1 = 32'h00000000;
  // expected_dmemload2 = 32'h00000000;

  // //
  // // write miss
  // // cache 1
  // // 3
  // testcase = 10;
  // dcif.halt = 0;
  // dcif.dmemWEN = 1;
  // dcif.dmemREN = 0;
  // dcif.dmemstore = 32'hABCD0000;
  // dcif.dmemaddr = 32'h0000FA58;

  // expected_cache = 1;
  // expected_dmemload1 = 32'hABCD0000;
  // expected_dmemload2 = 32'h00000004;
  
  // @(dcif.dhit);
  // dcif.dmemWEN = 0;

  // if (expected_dmemload1 == dcif.dmemload) begin
  //   $display("Design correctly requested memory on a write miss");
  // end else begin
  //   $display("Design INCORRECTLY requested memory on a write miss");
  // end

  // #(PERIOD)

  // expected_cache = 0;
  // expected_dmemload1 = 32'h00000000;
  // expected_dmemload2 = 32'h00000000;

  // //
  // // write miss
  // // cache 2
  // // 4
  // testcase = 11;
  // dcif.halt = 0;
  // dcif.dmemWEN = 1;
  // dcif.dmemREN = 0;
  // dcif.dmemstore = 32'hABCD0000;
  // dcif.dmemaddr = 32'h0000EA5A;

  // expected_cache = 2;
  // expected_dmemload1 = 32'hABCD0000;
  // expected_dmemload2 = 32'h00000003;
  
  // @(dcif.dhit);
  // dcif.dmemWEN = 0;

  // if (expected_dmemload1 == dcif.dmemload) begin
  //   $display("Design correctly requested memory on a write miss");
  // end else begin
  //   $display("Design INCORRECTLY requested memory on a write miss");
  // end

  // #(PERIOD)

  // expected_cache = 0;
  // expected_dmemload1 = 32'h00000000;
  // expected_dmemload2 = 32'h00000000;

  // //
  // // write miss
  // // cache 1
  // // 5
  // testcase = 12;
  // dcif.halt = 0;
  // dcif.dmemWEN = 1;
  // dcif.dmemREN = 0;
  // dcif.dmemstore = 32'hABCD0000;
  // dcif.dmemaddr = 32'h0000FA5C;

  // expected_cache = 1;
  // expected_dmemload1 = 32'hABCD0000;
  // expected_dmemload2 = 32'h00000006;
  
  // @(dcif.dhit);
  // dcif.dmemWEN = 0;

  // if (expected_dmemload1 == dcif.dmemload) begin
  //   $display("Design correctly requested memory on a write miss");
  // end else begin
  //   $display("Design INCORRECTLY requested memory on a write miss");
  // end

  // #(PERIOD)

  // expected_cache = 0;
  // expected_dmemload1 = 32'h00000000;
  // expected_dmemload2 = 32'h00000000;

  // //
  // // write miss
  // // cache 2
  // // 6
  // testcase = 12;
  // dcif.halt = 0;
  // dcif.dmemWEN = 1;
  // dcif.dmemREN = 0;
  // dcif.dmemstore = 32'hABCD0000;
  // dcif.dmemaddr = 32'h0000EA5D;

  // expected_cache = 2;
  // expected_dmemload1 = 32'hABCD0000;
  // expected_dmemload2 = 32'h00000005;
  
  // @(dcif.dhit);
  // dcif.dmemWEN = 0;

  // if (expected_dmemload1 == dcif.dmemload) begin
  //   $display("Design correctly requested memory on a write miss");
  // end else begin
  //   $display("Design INCORRECTLY requested memory on a write miss");
  // end

  // #(PERIOD)

  // expected_cache = 0;
  // expected_dmemload1 = 32'h00000000;
  // expected_dmemload2 = 32'h00000000;

  // //
  // // write miss
  // // cache 1
  // // 7
  // testcase = 12;
  // dcif.halt = 0;
  // dcif.dmemWEN = 1;
  // dcif.dmemREN = 0;
  // dcif.dmemstore = 32'hABCD0000;
  // dcif.dmemaddr = 32'h0000FA5E;

  // expected_cache = 1;
  // expected_dmemload1 = 32'hABCD0000;
  // expected_dmemload2 = 32'h00000008;
  
  // @(dcif.dhit);
  // dcif.dmemWEN = 0;

  // if (expected_dmemload1 == dcif.dmemload) begin
  //   $display("Design correctly requested memory on a write miss");
  // end else begin
  //   $display("Design INCORRECTLY requested memory on a write miss");
  // end

  // #(PERIOD)

  // expected_cache = 0;
  // expected_dmemload1 = 32'h00000000;
  // expected_dmemload2 = 32'h00000000;

  // //
  // // write miss
  // // cache 2
  // // 8
  // testcase = 12;
  // dcif.halt = 0;
  // dcif.dmemWEN = 1;
  // dcif.dmemREN = 0;
  // dcif.dmemstore = 32'hABCD0000;
  // dcif.dmemaddr = 32'h0000EA5F;

  // expected_cache = 2;
  // expected_dmemload1 = 32'hABCD0000;
  // expected_dmemload2 = 32'h00000007;
  
  // @(dcif.dhit);
  // dcif.dmemWEN = 0;

  // if (expected_dmemload1 == dcif.dmemload) begin
  //   $display("Design correctly requested memory on a write miss");
  // end else begin
  //   $display("Design INCORRECTLY requested memory on a write miss");
  // end

  // #(PERIOD)

  // expected_cache = 0;
  // expected_dmemload1 = 32'h00000000;
  // expected_dmemload2 = 32'h00000000;





  $display("  Halt - Flush Begins");
  //
  // halt
  //
  testcase = 9999999;
  dcif.halt = 1;
  dcif.dmemWEN = 0;
  dcif.dmemREN = 0;
  dcif.dmemstore = 32'h000000DC; //dc
  //dcif.dmemaddr = 32'h000000DC; //dc


  #(PERIOD)

  dcif.dmemWEN = 0;

  #(PERIOD*100);

end
endprogram
