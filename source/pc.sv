/*
	Emily Fredette
	PC unit
*/

// interface
`include "pc_if.vh"

module pc (
  input CLK, nRST,
  pc_if.pc pcif
);
// type import
  import cpu_types_pkg::*;

always_ff @(posedge CLK, negedge nRST) begin
	if (!nRST) begin
		pcif.pcout = '0;
	end

	else if (pcif.pcenable) begin
		pcif.pcout = pcif.pcnext;
	end
end

endmodule
