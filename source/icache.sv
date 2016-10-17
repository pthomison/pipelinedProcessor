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


icachef_t cacheAddr  [15:0];
word_t    cacheData  [15:0];
logic     cacheValid [15:0];

icachef_t reqAddr;

word_t mdata, cdata;

logic update;

logic valid, tagEqual, prehit;

typedef enum logic [1:0] {
IDLE         = 2'b00,
IHIT         = 2'b01,
MISSREQ      = 2'b10,
MISSLOAD     = 2'b11
} controllerState;

controllerState currState;
controllerState nextState;

// Type Casting To ICache Address
assign reqAddr = icachef_t'(dcif.imemaddr);
assign mdata   = cif.iload;

// Cache Data
// Handles nRST and writing in new values
always_ff @(posedge CLK, negedge nRST) begin
	if(nRST == 0) begin
		cacheAddr  <= '{default:'0};
		cacheData  <= '{default:'0};
		cacheValid <= '{default:'0};
	end else begin
		if (update == 1) begin
			cacheAddr[reqAddr.idx].tag <= reqAddr.tag;
			cacheAddr[reqAddr.idx].idx <= reqAddr.idx;
			cacheAddr[reqAddr.idx].bytoff <= reqAddr.bytoff;
			cacheData[reqAddr.idx] <= mdata;
			cacheValid[reqAddr.idx] <= 1;
		end
	end
end

// Cache Data
// Handles pulling the data and testing it
always_comb begin
	if (reqAddr.tag == cacheAddr[reqAddr.idx].tag) begin
		tagEqual = 1;
	end else begin
		tagEqual = 0;
	end

	if (cacheValid[reqAddr.idx] == 1) begin
		valid = 1;
	end else begin
		valid = 0;
	end

	cdata = cacheData[reqAddr.idx];
end

assign prehit = tagEqual && valid;

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
// Handles nextState and control signals
// Datapath Control Signals: dcif.ihit
// RAM Control Signals: cif.iaddr, cif.iREN
// Internal Control Signals: update
always_comb begin
	if (currState == IDLE) begin
		dcif.ihit = 0;
		cif.iaddr = 0;
		cif.iREN  = 0;
		update    = 0;

		if ((prehit == 1) && (dcif.imemREN == 1)) begin
			nextState = IHIT;
		end else if ((prehit == 0) && (dcif.imemREN == 1)) begin
			nextState = MISSREQ;
		end else begin
			nextState = IDLE;
		end

	end else if (currState == IHIT) begin
		dcif.ihit = 1;
		cif.iaddr = 0;
		cif.iREN  = 0;
		update    = 0;
		nextState = IDLE;

	end else if (currState == MISSREQ) begin
		dcif.ihit = 0;
		cif.iaddr = dcif.imemaddr;
		cif.iREN  = 1;
		update    = 0;

		if (cif.iwait == 1) begin
			nextState = MISSREQ;
		end else begin
			nextState = MISSLOAD;
		end

	end else if (currState == MISSLOAD) begin
		dcif.ihit = 1;
		cif.iaddr = 0;
		cif.iREN  = 0;
		update    = 1;
		nextState = IDLE;
	end
end

assign dcif.imemload = (prehit == 1) ? cdata: mdata;


endmodule