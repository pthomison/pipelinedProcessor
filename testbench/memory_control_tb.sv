/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "cache_control_if.vh"
`include "cpu_ram_if.vh"
`include "caches_if.vh"
// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module memory_control_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  caches_if cache0();
  caches_if cache1();
  cache_control_if #(.CPUS(1)) ccif (cache0, cache1);
  cpu_ram_if ramif ();

	//assigns
	assign ramif.ramREN = ccif.ramREN;
	assign ramif.ramWEN = ccif.ramWEN;
	assign ramif.ramstore = ccif.ramstore;
	assign ramif.ramaddr = ccif.ramaddr;

	assign ccif.ramstate = ramif.ramstate;
	assign ccif.ramload = ramif.ramload;

  // test program
  test PROG (CLK, nRST, cache0);
  // DUT
`ifndef MAPPED
  memory_control DUT(CLK, nRST, ccif);
  ram DUTRAM(CLK, nRST, ramif);
`else
  memory_control DUT(
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

  memory_control DUTRAM(
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
	caches_if.caches cache0

);
parameter PERIOD = 10;
initial begin




            // cache inputs
    //input   iREN, dREN, dWEN, dstore (data), iaddr, daddr,

            // ram inputs
            //ramload, ramstate,

            // XXX coherence inputs from cache
            //ccwrite, cctrans,

            // cache outputs
    //output  iwait, dwait - always high unless in ACCESS
	    //iload, dload,

            // ram outputs
            //ramstore, ramaddr, ramWEN, ramREN,

            // XXX coherence outputs to cache
            //ccwait, ccinv, ccsnoopaddr

	#(PERIOD*2);
	nRST = 0;
	#(PERIOD*2);
	nRST = 1;

	cache0.iREN = 0;
	cache0.dREN = 0;
	cache0.dWEN = 1;
	cache0.daddr = 1;
	cache0.dstore = 32'hBEEFCAFF;
	#(PERIOD*2);



	dump_memory();
end

task automatic dump_memory();
    string filename = "memcpu.hex";
    int memfd;

    cache0.dWEN = 1;
    cache0.dREN = 0;
    cache0.iREN = 0;
    cache0.daddr = 0;

    memfd = $fopen(filename,"w");
    if (memfd)
      $display("Starting memory dump.");
    else
      begin $display("Failed to open %s.",filename); $finish; end

    for (int unsigned i = 0; memfd && i < 16384; i++)
    begin
      int chksum = 0;
      bit [7:0][7:0] values;
      string ihex;

      cache0.daddr = i << 2;
      cache0.dREN  = 1;
      repeat (4) @(posedge CLK);
      if (cache0.dload === 0)
        continue;
      values = {8'h04,16'(i),8'h00,cache0.dload};
      foreach (values[j])
        chksum += values[j];
      chksum = 16'h100 - chksum;
      ihex = $sformatf(":04%h00%h%h",16'(i),cache0.dload,8'(chksum));
      $fdisplay(memfd,"%s",ihex.toupper());
    end //for
    if (memfd)
    begin
      //syif.tbCTRL = 0;
      cache0.dREN = 0;
      $fdisplay(memfd,":00000001FF");
      $fclose(memfd);
      $display("Finished memory dump.");
    end
  endtask




endprogram
