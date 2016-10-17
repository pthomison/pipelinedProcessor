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

  // test program
  test PROG (CLK, nRST, dcif, cif);
  // DUT
`ifndef MAPPED
  icache DUT(CLK, nRST, dcif, cif);
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


    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

endmodule



// Signals Going Into The DUT
// Datapath: imemREN, imemaddr
// Cache: iwait, iload

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
  expected_imemload = 32'h00000000;

  // Requesting First Piece of Data, miss
  // Many clk cycles until iload ready

  cif.iwait = 0;
  cif.iload = 0;
  
  reqAddr = 32'h00001000;
  dcif.imemREN = 1;
  dcif.imemaddr = reqAddr;

  #(PERIOD);

  if (cif.iREN) begin
    cif.iwait = 1;
    #(PERIOD);
    #(PERIOD);
    #(PERIOD);
    cif.iload = 32'h00DEAD00;
    expected_imemload = 32'h00DEAD00;
    #1;
    cif.iwait = 0;
    dcif.imemREN = 0;
  end
  #(PERIOD)
  expected_imemload = 32'h00000000;

  // Reading, MISS, OVERWRITE previous data
  // Many clk cycles until iload ready
  #(PERIOD)
  #(PERIOD)
  cif.iwait = 0;
  cif.iload = 0;
  
  reqAddr = 32'h00011000;
  dcif.imemREN = 1;
  dcif.imemaddr = reqAddr;

  #(PERIOD);

  if (cif.iREN) begin
    cif.iwait = 1;
    #(PERIOD);
    #(PERIOD);
    #(PERIOD);
    #(PERIOD);
    #(PERIOD);
    cif.iload = 32'h00BEEF00;
    expected_imemload = 32'h00BEEF00;
    #1;
    cif.iwait = 0;
    dcif.imemREN = 0;
  end
  #(PERIOD)
  expected_imemload = 32'h00000000;

  // Reading, MISS
  // Many clk cycles until iload ready
  #(PERIOD)
  #(PERIOD)
  cif.iwait = 0;
  cif.iload = 0;
  
  reqAddr = 32'h00011010;
  dcif.imemREN = 1;
  dcif.imemaddr = reqAddr;

  #(PERIOD);

  if (cif.iREN) begin
    cif.iwait = 1;
    #(PERIOD);
    #(PERIOD);
    #(PERIOD);
    #(PERIOD);
    #(PERIOD);
    cif.iload = 32'h00DEED00;
    expected_imemload = 32'h00DEED00;
    #1;
    cif.iwait = 0;
    dcif.imemREN = 0;
  end
  #(PERIOD)
  expected_imemload = 32'h00000000;

  // Reading, HIT, output is BEEF
  // Many clk cycles until iload ready
  #(PERIOD)
  #(PERIOD)
  cif.iwait = 0;
  cif.iload = 0;
  
  reqAddr = 32'h00011000;
  dcif.imemREN = 1;
  dcif.imemaddr = reqAddr;

  #(PERIOD);
  expected_imemload = 32'h00BEEF00;
  if (cif.iREN) begin
    cif.iwait = 1;
    #(PERIOD);
    #(PERIOD);
    #(PERIOD);
    #(PERIOD);
    #(PERIOD);
    cif.iload = 32'h00FEEF00; //dont care b/c hit
    #1;
    cif.iwait = 0;
    dcif.imemREN = 0;
  end
  #(PERIOD)
  expected_imemload = 32'h00000000;

  // Reading, MISS
  // Many clk cycles until iload ready
  #(PERIOD)
  #(PERIOD)
  cif.iwait = 0;
  cif.iload = 0;
  
  reqAddr = 32'h00011110;
  dcif.imemREN = 1;
  dcif.imemaddr = reqAddr;

  #(PERIOD);

  if (cif.iREN) begin
    cif.iwait = 1;
    #(PERIOD);
    #(PERIOD);
    #(PERIOD);
    #(PERIOD);
    #(PERIOD);
    #(PERIOD);
    #(PERIOD);
    #(PERIOD);
    #(PERIOD);
    #(PERIOD);
    cif.iload = 32'h00FFFF00;
    expected_imemload = 32'h00FFFF00;
    #1;
    cif.iwait = 0;
    dcif.imemREN = 0;
  end
  #(PERIOD)
  expected_imemload = 32'h00000000;

  // HIT, output is BEEF
  // Many clk cycles until iload ready
  #(PERIOD)
  #(PERIOD)
  cif.iwait = 0;
  cif.iload = 0;
  
  reqAddr = 32'h00011000;
  dcif.imemREN = 1;
  dcif.imemaddr = reqAddr;

  #(PERIOD);
  expected_imemload = 32'h00BEEF00;
  if (cif.iREN) begin
    cif.iwait = 1;
    #(PERIOD);
    #(PERIOD);
    #(PERIOD);
    #(PERIOD);
    #(PERIOD);
    cif.iload = 32'h00FEEF00; //dont care b/c hit
    #1;
    cif.iwait = 0;
    dcif.imemREN = 0;
  end
  #(PERIOD)
  expected_imemload = 32'h00000000;

  #(PERIOD);
  
  #(PERIOD);

  #(PERIOD);

  #(PERIOD*10);

end
endprogram
