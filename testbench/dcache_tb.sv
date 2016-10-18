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
word_t expected_dmemload;

parameter PERIOD = 10;
initial begin

  // Reseting
  #(PERIOD*2);
  nRST = 0;
  #(PERIOD*2);
  nRST = 1;
  #(PERIOD);
  expected_dmemload = 32'h00000000;



  // dcif.halt = 0;
  // dcif.dmemWEN = 1;
  // dcif.dmemREN = 0;
  // dcif.dmemstore = 32'h0000DEAD; //dc
  // dcif.dmemaddr = 32'h00001000;
  // #(PERIOD);
  // dcif.dmemWEN = 0;
  // #(PERIOD*4);

  // dcif.halt = 0;
  // dcif.dmemWEN = 1;
  // dcif.dmemREN = 0;
  // dcif.dmemstore = 32'h0000BEEF; //dc
  // dcif.dmemaddr = 32'h00001010;
  // #(PERIOD);
  // dcif.dmemWEN = 0;
  // #(PERIOD*4);





  //
  // read miss
  //
  dcif.halt = 0;
  dcif.dmemWEN = 0;
  dcif.dmemREN = 1;
  dcif.dmemstore = 32'h00BEEF00; //dc
  dcif.dmemaddr = 32'h00000100;

  expected_dmemload = 32'h000050;

  @(dcif.dhit);
  #(PERIOD*5)

  dcif.dmemWEN = 0;

  expected_dmemload = 32'h00000000;







  //
  // write miss
  //
  dcif.halt = 0;
  dcif.dmemWEN = 1;
  dcif.dmemREN = 0;
  dcif.dmemstore = 32'h00BEEF00; //dc
  dcif.dmemaddr = 32'h00001000;

  expected_dmemload = 32'h00BEEF00;



  @(dcif.dhit);

  dcif.dmemWEN = 0;




  expected_dmemload = 32'h00000000;












  //
  // halt
  //






  
  #(PERIOD);

  #(PERIOD);

  #(PERIOD*10);

end
endprogram
