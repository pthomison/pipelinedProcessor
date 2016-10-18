/*
  Patrick Thomison
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module dcache (
  input CLK, nRST,
  datapath_cache_if.cache dcif, 
  caches_if.caches cif
);

import cpu_types_pkg::*;

typedef struct packed {
	word_t wordA; 
	word_t wordB;
} block;

dcachef_t cacheOneAddr    [15:0];
block     cacheOneData    [15:0];
logic     cacheOneValid   [15:0];
logic     cacheOneDirty   [15:0];
logic     cacheOneRecUsed [15:0];

dcachef_t cacheTwoAddr    [15:0];
block     cacheTwoData    [15:0];
logic     cacheTwoValid   [15:0];
logic     cacheTwoDirty   [15:0];
logic     cacheTwoRecUsed [15:0];

dcachef_t reqAddr;
word_t mdata, cdata;

block dataBlockOne, dataBlockTwo;

logic updateRead, updateWrite;

logic destination; // 0 for A, 1 for B

logic recordDirty;

typedef enum logic [:0] {
IDLE            = 2'b00,
READHIT         = 2'b01,
WRITEHIT        = 2'b10,
MISSCHECK       = 2'b11,
DIRTYCLEAN
} controllerState;

controllerState currState;
controllerState nextState;

// Type Casting To ICache Address
assign reqAddr = icachef_t'(dcif.imemaddr);

// Connecting mem data
assign mload   = cif.iload;
assign mstore  = dcif.dmemstore;

// Cache One Data Reg
// Handles nRST and writing in new values
always_ff @(posedge CLK, negedge nRST) begin
	if(nRST == 0) begin
		cacheOneAddr    <= '{default:'0};
		cacheOneData    <= '{default:'0};
		cacheOneValid   <= '{default:'0};
		cacheOneDirty   <= '{default:'0};
		cacheOneRecUsed <= '{default:'0};
	end else begin
		if (destination == 0) begin
			if (updateRead == 1) begin
				cacheOneAddr[reqAddr.idx].tag <= reqAddr.tag;
				cacheOneAddr[reqAddr.idx].idx <= reqAddr.idx;
				cacheOneAddr[reqAddr.idx].bytoff <= reqAddr.bytoff;
				cacheOneData[reqAddr.idx] <= mload;
				cacheOneValid[reqAddr.idx] <= 1;
				cacheOneDirty[reqAddr.idx] <= 0;
				cacheOneRecUsed[reqAddr.idx] <= 1;
			end

			if (updateWrite == 1) begin
				cacheOneAddr[reqAddr.idx].tag <= reqAddr.tag;
				cacheOneAddr[reqAddr.idx].idx <= reqAddr.idx;
				cacheOneAddr[reqAddr.idx].bytoff <= reqAddr.bytoff;
				cacheOneData[reqAddr.idx] <= mstore;
				cacheOneValid[reqAddr.idx] <= 1;
				cacheOneDirty[reqAddr.idx] <= 0;
				cacheOneRecUsed[reqAddr.idx] <= 0;
			end
		end
	end
end

// Cache Two Data Reg
// Handles nRST and writing in new values
always_ff @(posedge CLK, negedge nRST) begin
	if(nRST == 0) begin
		cacheTwoAddr    <= '{default:'0};
		cacheTwoData    <= '{default:'0};
		cacheTwoValid   <= '{default:'0};
		cacheTwoDirty   <= '{default:'0};
		cacheTwoRecUsed <= '{default:'0};
	end else begin
		if (destination == 1) begin
			if (updateTwoRead == 1) begin
				cacheTwoAddr[reqAddr.idx].tag <= reqAddr.tag;
				cacheTwoAddr[reqAddr.idx].idx <= reqAddr.idx;
				cacheTwoAddr[reqAddr.idx].bytoff <= reqAddr.bytoff;
				cacheTwoData[reqAddr.idx] <= mload;
				cacheTwoValid[reqAddr.idx] <= 1;
				cacheTwoDirty[reqAddr.idx] <= 0;
				cacheTwoRecUsed[reqAddr.idx] <= 1;
			end

			if (updateTwoWrite == 1) begin
				cacheTwoAddr[reqAddr.idx].tag <= reqAddr.tag;
				cacheTwoAddr[reqAddr.idx].idx <= reqAddr.idx;
				cacheTwoAddr[reqAddr.idx].bytoff <= reqAddr.bytoff;
				cacheTwoData[reqAddr.idx] <= mstore;
				cacheTwoValid[reqAddr.idx] <= 1;
				cacheTwoDirty[reqAddr.idx] <= 0;
				cacheTwoRecUsed[reqAddr.idx] <= 0;
			end
		end
	end
end

// ----------------------------------------- //

// Cache One Data Comb
// Handles pulling the data and testing it
always_comb begin
	if (reqAddr.tag == cacheOneAddr[reqAddr.idx].tag) begin
		tagEqualOne = 1;
	end else begin
		tagEqualOne = 0;
	end

	if (cacheOneValid[reqAddr.idx] == 1) begin
		validOne = 1;
	end else begin
		validOne = 0;
	end

	dataBlockOne = cacheOneData[reqAddr.idx];
	recentUsedOne = cacheOneRecUsed[reqAddr.idx];
end

// Cache Two Data Comb
// Handles pulling the data and testing it
always_comb begin
	if (cacheTwoAddr[reqAddr.idx].tag == reqAddr.tag) begin
		tagEqualTwo = 1;
	end else begin
		tagEqualTwo = 0;
	end

	if (cacheTwoValid[reqAddr.idx] == 1) begin
		validTwo = 1;
	end else begin
		validTwo = 0;
	end

	dataBlockTwo = cacheTwoData[reqAddr.idx];
	recentUsedTwo = cacheTwoRecUsed[reqAddr.idx];
end

// ----------------------------------------- //

assign prehitOne = tagEqualOne && validOne;
assign prehitTwo = tagEqualTwo && validTwo;
assign prehit = prehitOne || prehitTwo;

// ----------------------------------------- //

cdataOne = (reqAddr.blkoff == 0) ? dataBlockOne.wordA : dataBlockOne.wordB;
cdataTwo = (reqAddr.blkoff == 0) ? dataBlockTwo.wordA : dataBlockTwo.wordB;
cdata    = (prehitOne == 1) ? cdataOne : cdataTwo; // JANKY BAD TERRIBLE CODE; PLEASE FIX

// ----------------------------------------- //

// desination selector block
always_comb begin
	casez({validOne, validTwo})
		0: desination = 0;
		1: desination = 0;
		2: desination = 1;
		3: desination = (recentUsedOne == 1) 0 : 1;
		default: desination = 0;
	endcase
end

// ----------------------------------------- //

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
// Datapath Control Signals: dcif.dhit, dcif.dmemload, dcif.flushed
// RAM Control Signals: cif.dREN, cif.dWEN, cif.daddr, cif.dstore,
// Internal Control Signals: updateRead, updateWrite
always_comb begin
	if (currState == IDLE) begin
		dcif.dhit     = 0;
		dcif.dmemload = 0;
		dcif.flushed  = 0;

		cif.dREN      = 0;
		cif.dWEN      = 0;
		cif.daddr     = 0;
		cif.dstore    = 0;

		updateRead    = 0;
		updateWrite   = 0;

		if (dcif.dmemREN == 1) begin
			if (prehit == 1) begin
				nextState = READHIT;
			end else begin
				nextState = MISSCHECK;
			end
		end else if (dcif.dmemWEN == 1) begin
			if (prehit == 1) begin
				nextState = WRITEHIT;
			end else begin
				nextState = MISSCHECK;
			end
		end else begin
			nextState = IDLE;
		end

	end else if (currState == READHIT) begin
		dcif.dhit     = 1;
		dcif.dmemload = cdata;
		dcif.flushed  = 0;

		cif.dREN      = 0;
		cif.dWEN      = 0;
		cif.daddr     = 0;
		cif.dstore    = 0;

		updateRead    = 0;
		updateWrite   = 0;

		nextState = IDLE;

	end else if (currState == MISSCHECK) begin
		// Checks the dirty bit of the soon to be overwritten spot
		dcif.dhit     = 0;
		dcif.dmemload = 0;
		dcif.flushed  = 0;

		cif.dREN      = 0;
		cif.dWEN      = 0;
		cif.daddr     = 0;
		cif.dstore    = 0;

		updateRead    = 0;
		updateWrite   = 0;

		if (desination == 0 && cacheOneDirty[reqAddr.idx] == 1) || (desination == 1 && cacheTwoDirty[reqAddr.idx] == 1) begin 
			nextState = DIRTYCLEAN;
		end else
			nextState = REQDATA;
		end

	end else if (currState == DIRTYCLEAN) begin
		// Writes Dirty Data Back To Memory

		dcif.dhit     = 0;
		dcif.dmemload = 0;
		dcif.flushed  = 0;

		cif.dREN      = 0;
		cif.dWEN      = 1;
		cif.daddr     = 0;
		cif.dstore    = 0;

		updateRead    = 0;
		updateWrite   = 0;

	end else if (currState == REQDATA) begin

	end
end