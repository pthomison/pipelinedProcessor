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

  //caches_if cache0();
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

  // assign ccif.iREN = cif.iREN;
  // assign ccif.dREN = cif.dREN;
  // assign ccif.dstore = cif.dstore;
  // assign ccif.iaddr = cif.iaddr;
  // assign ccif.daddr = cif.daddr;

  // //inputs to CACHE
  // assign cif.iwait = ccif.iwait;
  // assign cif.dwait = ccif.dwait;
  // assign cif.iload = ccif.iload;
  // assign cif.dload = ccif.dload;



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

    //datapath signals
    // input  ihit, dhit, imemload, dmemload, flushed,
    // output halt, imemREN, dmemREN, dmemWEN, datomic,
    //        dmemstore, dmemaddr, imemaddr

import cpu_types_pkg::*;

word_t expected_dmemload1, expected_dmemload2;
int expected_cache;
int testcase; 

parameter PERIOD = 10;
initial begin

  testcase = 0;

  dcif.dmemWEN = 0;
  dcif.dmemREN = 0;
  // Reseting
  #(PERIOD*2);
  nRST = 0;
  #(PERIOD*2);
  nRST = 1;
  #(PERIOD);
  expected_dmemload1 = 32'h00000000;
  expected_dmemload2 = 32'h00000000;

  dcif.halt = 0;
  dcif.dmemWEN = 0;
  dcif.dmemREN = 0;
  dcif.dmemstore = 32'h00000000; 
  dcif.dmemaddr = 32'h00000000;

  #(PERIOD);


  //
  // read miss
  // cache1
  //
  testcase = 1;
  dcif.halt = 0;
  dcif.dmemWEN = 0;
  dcif.dmemREN = 1;
  dcif.dmemstore = 32'h000000DC; //dc
  dcif.dmemaddr = 32'h00000100;

  expected_cache = 1;
  expected_dmemload1 = 32'h00000050;
  expected_dmemload2 = 32'h000000A0;

  @(dcif.dhit);

  if (expected_dmemload1 == dcif.dmemload) begin
    $display("Design correctly requested memory on a read miss");
  end else begin
    $display("Design INCORRECTLY requested memory on a read miss");
  end

  #(PERIOD)

  // Reseting Ghost Values
  dcif.dmemWEN = 0;
  expected_cache = 0;
  expected_dmemload1 = 32'h00000000; //cache 1
  expected_dmemload2 = 32'h00000000;

  //
  // read miss - fill cache 2 instead - same index
  // cache2
  //
  testcase = 2;
  dcif.halt = 0;
  dcif.dmemWEN = 0;
  dcif.dmemREN = 1;
  dcif.dmemstore = 32'h000000DC; //dc
  dcif.dmemaddr = 32'h0000A004;

  expected_cache = 2;
  expected_dmemload1 = 32'h00000002; //cache 2
  expected_dmemload2 = 32'h00000001;

  @(dcif.dhit);

  if (expected_dmemload1 == dcif.dmemload) begin
    $display("Design correctly requested memory on a read miss");
  end else begin
    $display("Design INCORRECTLY requested memory on a read miss");
  end

  #(PERIOD)

  // Restesting Ghost Values
  dcif.dmemWEN = 0;
  expected_cache = 0;
  expected_dmemload1 = 32'h00000000;
  expected_dmemload2 = 32'h00000000;

  //
  // read hit - cache 1
  //
  testcase = 3;
  dcif.halt = 0;
  dcif.dmemWEN = 0;
  dcif.dmemREN = 1;
  dcif.dmemstore = 32'h000000DC; //dc
  dcif.dmemaddr = 32'h00000104;

  expected_cache = 1;
  expected_dmemload1 = 32'h000000A0;
  expected_dmemload2 = 32'h00000050;


  @(dcif.dhit);

  if (expected_dmemload1 == dcif.dmemload) begin
    $display("Design correctly requested memory on a read hit");
  end else begin
    $display("Design INCORRECTLY requested memory on a read hit");
  end

  #(PERIOD)

  // Reseting Ghost Values
  dcif.dmemWEN = 0;
  expected_cache = 0;
  expected_dmemload1 = 32'h00000000;
  expected_dmemload2 = 32'h00000000;

  //
  // read hit - cache 2
  //
  testcase = 4;
  dcif.halt = 0;
  dcif.dmemWEN = 0;
  dcif.dmemREN = 1;
  dcif.dmemstore = 32'h000000DC; //dc
  dcif.dmemaddr = 32'h0000A000;

  expected_cache = 2;
  expected_dmemload1 = 32'h00000001;
  expected_dmemload2 = 32'h00000002;

  @(dcif.dhit);

  dcif.dmemWEN = 0;

  if (expected_dmemload1 == dcif.dmemload) begin
    $display("Design correctly requested memory on a read hit");
  end else begin
    $display("Design INCORRECTLY requested memory on a read hit");
  end
 
  #(PERIOD)

  expected_cache = 0;
  expected_dmemload1 = 32'h00000000;
  expected_dmemload2 = 32'h00000000;


  //
  // write miss
  // cache1
  //
  testcase = 5;
  dcif.halt = 0;
  dcif.dmemWEN = 1;
  dcif.dmemREN = 0;
  dcif.dmemstore = 32'h00BEEF00;
  dcif.dmemaddr = 32'h0000B000;

  expected_cache = 1;
  expected_dmemload1 = 32'h00BEEF00;
  expected_dmemload2 = 32'h0000000B;
  
  @(dcif.dhit);
  dcif.dmemWEN = 0;

  if (expected_dmemload1 == dcif.dmemload) begin
    $display("Design correctly requested memory on a write miss");
  end else begin
    $display("Design INCORRECTLY requested memory on a write miss");
  end

  #(PERIOD)

  expected_cache = 0;
  expected_dmemload1 = 32'h00000000;
  expected_dmemload2 = 32'h00000000;



  //
  // write hit
  // cache1
  // make dirty
  //
  testcase = 6;
  dcif.halt = 0;
  dcif.dmemWEN = 1;
  dcif.dmemREN = 0;
  dcif.dmemstore = 32'h00DEAD00;
  dcif.dmemaddr = 32'h0000B000;
  expected_cache = 1;
  expected_dmemload1 = 32'h00DEAD00;

  @(dcif.dhit);

  dcif.dmemWEN = 0;

  if (expected_dmemload1 == dcif.dmemload) begin
    $display("Design correctly requested memory on a write hit");
  end else begin
    $display("Design INCORRECTLY requested memory on a write hit");
  end

  #(PERIOD)

  expected_cache = 0;
  expected_dmemload1 = 32'h00000000;


  //
  // read miss
  // at this point, recUsed is 0, means cache 1 used recently
  // want to load data into cache 2 = destination is 1
  // which is DIRTY
  //
  testcase = 7;
  dcif.halt = 0;
  dcif.dmemWEN = 0;
  dcif.dmemREN = 1;
  dcif.dmemstore = 32'h000000DC; //dc
  dcif.dmemaddr = 32'h0000C000;
  expected_cache = 2;
  expected_dmemload1 = 32'h0000000C;

  @(dcif.dhit);

  if (expected_dmemload1 == dcif.dmemload) begin
    $display("Design correctly requested memory on a read miss");
  end else begin
    $display("Design INCORRECTLY requested memory on a read miss");
  end

  #(PERIOD)

  dcif.dmemWEN = 0;
  expected_cache = 0;
  expected_dmemload1 = 32'h00000000;








  //
  // halt
  //
  testcase = 9999999;
  dcif.halt = 1;
  dcif.dmemWEN = 0;
  dcif.dmemREN = 0;
  dcif.dmemstore = 32'h000000DC; //dc
  dcif.dmemaddr = 32'h0000C000; //dc

  expected_dmemload1 = 32'h00000000;

    #(PERIOD)

  dcif.dmemWEN = 0;

  expected_dmemload1 = 32'h00000000;








  
  #(PERIOD);

  #(PERIOD);

  #(PERIOD*10);

  //dump_memory();

end

// task automatic dump_memory();
//     string filename = "memcpu.hex";
//     int memfd;

//     cache0.dWEN = 1;
//     cache0.dREN = 0;
//     cache0.iREN = 0;
//     cache0.daddr = 0;

//     memfd = $fopen(filename,"w");
//     if (memfd)
//       $display("Starting memory dump.");
//     else
//       begin $display("Failed to open %s.",filename); $finish; end

//     for (int unsigned i = 0; memfd && i < 16384; i++)
//     begin
//       int chksum = 0;
//       bit [7:0][7:0] values;
//       string ihex;

//       cache0.daddr = i << 2;
//       cache0.dREN  = 1;
//       repeat (4) @(posedge CLK);
//       if (cache0.dload === 0)
//         continue;
//       values = {8'h04,16'(i),8'h00,cache0.dload};
//       foreach (values[j])
//         chksum += values[j];
//       chksum = 16'h100 - chksum;
//       ihex = $sformatf(":04%h00%h%h",16'(i),cache0.dload,8'(chksum));
//       $fdisplay(memfd,"%s",ihex.toupper());
//     end //for
//     if (memfd)
//     begin
//       //syif.tbCTRL = 0;
//       cache0.dREN = 0;
//       $fdisplay(memfd,":00000001FF");
//       $fclose(memfd);
//       $display("Finished memory dump.");
//     end
//   endtask
endprogram
