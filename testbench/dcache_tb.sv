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

  // test program
  test PROG (CLK, nRST, dcif, cif);
  // DUT
`ifndef MAPPED
  dcache DUT(CLK, nRST, dcif, cif);
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
word_t reqAddr;
word_t expected_imemload;

parameter PERIOD = 10;
initial begin

  // Reseting
  #(PERIOD*2);
  nRST = 0;
  #(PERIOD*2);
  nRST = 1;
  #(PERIOD);


  #(PERIOD);
  
  #(PERIOD);

  #(PERIOD);

  #(PERIOD*10);

end
endprogram