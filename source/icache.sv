/*
  Patrick Thomison
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module icache (
  input CLK, nRST,
  datapath_cache_if.cache dcif, 
  caches_if.caches cif
);

import cpu_types_pkg::*;

icachef_t datasource [15:0];
icachef_t iaddr;
logic enable;

assign reqAddr = dcif.iaddr;
assign enable  = 

always_ff @(posedge CLK, negedge nRST) begin
	if(nRST == 0) begin
		datasource <= '0;
	end else begin
		 <= ;
	end
end


endmodule