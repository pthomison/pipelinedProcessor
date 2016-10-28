/*
  Patrick Thomison
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module icache (
  input CLK, nRST,
  datapath_cache_if.icache dcif, 
  caches_if.icache cif
);

import cpu_types_pkg::*;

// Module Structs
// ----------------------------------------- //
	typedef struct packed {
		icachef_t  addr;
		word_t     data;
		logic     valid;
	} frame;

// Module Enums
// ----------------------------------------- //
	typedef enum logic [1:0] {
	IDLE         = 2'b00,
	IHIT         = 2'b01,
	MISSREQ      = 2'b10,
	MISSLOAD     = 2'b11
	} controllerState;

// Module Variables
// ----------------------------------------- //

	frame cache [15:0];

	icachef_t reqAddr;

	word_t cdata;

	logic prehit, update;

	controllerState currState, nextState;

// Type Casting To ICache Address
assign reqAddr = icachef_t'(dcif.imemaddr);

// Cache Data
// Handles nRST and writing in new values
always_ff @(posedge CLK, negedge nRST) begin
	if(nRST == 0) begin
		cache <= '{default:'0};
	end else begin
		if (update == 1) begin
			cache[reqAddr.idx].addr  <= reqAddr;
			cache[reqAddr.idx].data  <= cif.iload;
			cache[reqAddr.idx].valid <= 1;
		end
	end
end

// Cache Data
// Handles pulling the data and testing it
assign prehit = (reqAddr.tag == cache[reqAddr.idx].addr.tag) && (cache[reqAddr.idx].valid == 1);
assign cdata = cache[reqAddr.idx].data;

// Cache Controller
// Handles nRST and advancing state
always_ff @(posedge CLK, negedge nRST) begin
	if(nRST == 0) begin
		currState <= IDLE;
	end else begin
		currState <= nextState;
	end
end

// Cache Controller
// Handles nextState
always_comb begin
	nextState = IDLE;
	
	if (currState == IDLE) begin

		if ((prehit == 1) && (dcif.imemREN == 1)) begin
			nextState = IHIT;
		end else if ((prehit == 0) && (dcif.imemREN == 1)) begin
			nextState = MISSREQ;
		end else begin
			nextState = IDLE;
		end

	end else if (currState == IHIT) begin
		nextState = IDLE;

	end else if (currState == MISSREQ) begin
		if (cif.iwait == 1) begin
			nextState = MISSREQ;
		end else begin
			nextState = IDLE;
		end
	end 
end

// control signals
always_comb begin
	dcif.ihit = 0;
	cif.iaddr = 0;
	cif.iREN  = 0;
	update    = 0;
	dcif.imemload = 0;

	if (currState == IDLE) begin
	end 

	else if (currState == IHIT) begin
		dcif.ihit = 1;
		dcif.imemload = cdata;

	end 

	else if (currState == MISSREQ) begin
		cif.iaddr = dcif.imemaddr;
		cif.iREN  = 1;
		update    = 1;
	end 

end

endmodule