/*
  Emily Fredette
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 1;



            //cache inputs
    //input   iREN, dREN, dWEN, dstore (data), iaddr, daddr,

            //ram inputs
            //ramload, ramstate,

            // XXX coherence inputs from cache
            //ccwrite, cctrans,

            //cache outputs
    //output  iwait, dwait - always high unless in ACCESS
	    //iload, dload,

            //ram outputs
            //ramstore, ramaddr, ramWEN, ramREN,

            // XXX coherence outputs to cache
            //ccwait, ccinv, ccsnoopaddr


assign ccif.iload = ccif.ramload;
assign ccif.dload = ccif.ramload;

always_comb begin

	//defaults
	ccif.ramaddr = ccif.daddr;
	ccif.ramREN = 0;
	ccif.ramWEN = 0;
	ccif.dwait = 1;
	ccif.iwait = 1;
	ccif.ramstore = ccif.dstore;

	if (ccif.dREN) begin
		ccif.ramaddr = ccif.daddr;
		ccif.ramREN = 1;
		ccif.ramWEN = 0;

		if (ccif.ramstate == ACCESS) begin
			ccif.dwait = 0;
			ccif.iwait = 1;
		end
		else begin
			ccif.dwait = 1;
			ccif.iwait = 1;
		end


	end
	else if (ccif.dWEN) begin
		ccif.ramstore = ccif.dstore;
		ccif.ramaddr = ccif.daddr;
		ccif.ramREN = 0;
		ccif.ramWEN = 1;

		if (ccif.ramstate == ACCESS) begin
			ccif.dwait = 0;
			ccif.iwait = 1;
		end
		else begin
			ccif.dwait = 1;
			ccif.iwait = 1;
		end


	end
	else if (ccif.iREN) begin
		ccif.ramaddr = ccif.iaddr;
		ccif.ramREN = 1;
		ccif.ramWEN = 0;

		if (ccif.ramstate == ACCESS) begin
			ccif.dwait = 1;
			ccif.iwait = 0;
		end
		else begin
			ccif.dwait = 1;
			ccif.iwait = 1;
		end
	end






end

endmodule
