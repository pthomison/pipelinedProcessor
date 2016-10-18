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

typedef struct packed {
	dcachef_t addr;
	block     data;
	logic     valid;
	logic     dirty;
} frame;

frame cacheOne [15:0];
frame cacheTwo [15:0];

logic recUsed [15:0];

dcachef_t reqAddr, destCurrAddr;
word_t mload, mstore;

logic updateRead, updateWrite;

word_t loadAddrA, loadAddrB;

logic destination; // 0 for A, 1 for B

logic destinationDirty;

logic prehitOne, prehitTwo, prehit;
logic validOne, validTwo;
logic worddest;

word_t cdataOne, cdataTwo, cdata;

word_t hitcounter;

block dirtyData;
word_t dirtyAddr;

typedef enum logic [3:0] {
IDLE         = 4'h0,
READHIT      = 4'h1,
MISSCHECK    = 4'h2,
WRITEHIT     = 4'h3,
DIRTYCLEANA  = 4'h4,
DIRTYCLEANB  = 4'h5,
DATAREQA     = 4'h6,
DATAREQB     = 4'h7,
XXX    = 4'h8, 
XXXX    = 4'h9,
FLUSH        = 4'hA,
STOP         = 4'hB
} controllerState;

controllerState currState;
controllerState nextState;

// Type Casting To ICache Address
assign reqAddr = icachef_t'(dcif.dmemaddr);

// Connecting mem data
assign mload   = cif.dload;
assign mstore  = dcif.dmemstore;

// Cache One Data Reg
// Handles nRST and writing in new values
always_ff @(posedge CLK, negedge nRST) begin
	if(nRST == 0) begin
		cacheOne    <= '{default:'0};
	end else begin
		if (destination == 0) begin
			if (updateRead == 1) begin
				cacheOne[reqAddr.idx].addr.tag    <= reqAddr.tag;
				cacheOne[reqAddr.idx].addr.idx    <= reqAddr.idx;
				cacheOne[reqAddr.idx].addr.bytoff <= reqAddr.bytoff;
				//cacheOne[reqAddr.idx].data        <= mload;
				cacheOne[reqAddr.idx].valid       <= 1;
				cacheOne[reqAddr.idx].dirty       <= 0;
				recUsed[reqAddr.idx]              <= 0;

				if (worddest == 0) begin
					cacheOne[reqAddr.idx].data.wordA <= mload;
				end else begin
					cacheOne[reqAddr.idx].data.wordB <= mload;
				end
			end

			if (updateWrite == 1) begin
				cacheOne[reqAddr.idx].addr.tag    <= reqAddr.tag;
				cacheOne[reqAddr.idx].addr.idx    <= reqAddr.idx;
				cacheOne[reqAddr.idx].addr.bytoff <= reqAddr.bytoff;
				//cacheOne[reqAddr.idx].data        <= mstore;
				cacheOne[reqAddr.idx].valid       <= 1;
				cacheOne[reqAddr.idx].dirty       <= 1;

				if (worddest == 0) begin
					cacheOne[reqAddr.idx].data.wordA <= mstore;
				end else begin
					cacheOne[reqAddr.idx].data.wordB <= mstore;
				end
			end
		end
	end
end

// Cache Two Data Reg
// Handles nRST and writing in new values
always_ff @(posedge CLK, negedge nRST) begin
	if(nRST == 0) begin
		cacheTwo    <= '{default:'0};
	end else begin
		if (destination == 1) begin
			if (updateRead == 1) begin
				cacheTwo[reqAddr.idx].addr.tag    <= reqAddr.tag;
				cacheTwo[reqAddr.idx].addr.idx    <= reqAddr.idx;
				cacheTwo[reqAddr.idx].addr.bytoff <= reqAddr.bytoff;
				//cacheTwo[reqAddr.idx].data        <= mload;
				cacheTwo[reqAddr.idx].valid       <= 1;
				cacheTwo[reqAddr.idx].dirty       <= 0;
				recUsed[reqAddr.idx]              <= 1;

				if (worddest == 0) begin
					cacheTwo[reqAddr.idx].data.wordA <= mload;
				end else begin
					cacheTwo[reqAddr.idx].data.wordB <= mload;
				end
			end

			if (updateWrite == 1) begin
				cacheTwo[reqAddr.idx].addr.tag    <= reqAddr.tag;
				cacheTwo[reqAddr.idx].addr.idx    <= reqAddr.idx;
				cacheTwo[reqAddr.idx].addr.bytoff <= reqAddr.bytoff;
				//cacheTwo[reqAddr.idx].data        <= mstore;
				cacheTwo[reqAddr.idx].valid       <= 1;
				cacheTwo[reqAddr.idx].dirty       <= 1;

				if (worddest == 0) begin
					cacheTwo[reqAddr.idx].data.wordA <= mstore;
				end else begin
					cacheTwo[reqAddr.idx].data.wordB <= mstore;
				end
			end
		end
	end
end

// ----------------------------------------- //

assign prehitOne = (cacheOne[reqAddr.idx].addr.tag == reqAddr.tag) && (cacheOne[reqAddr.idx].valid == 1);
assign prehitTwo = (cacheTwo[reqAddr.idx].addr.tag == reqAddr.tag) && (cacheTwo[reqAddr.idx].valid == 1);
assign prehit = prehitOne || prehitTwo;

// ----------------------------------------- //

assign cdataOne = (reqAddr.blkoff == 0) ? cacheOne[reqAddr.idx].data.wordA : cacheOne[reqAddr.idx].data.wordB;
assign cdataTwo = (reqAddr.blkoff == 0) ? cacheTwo[reqAddr.idx].data.wordA : cacheTwo[reqAddr.idx].data.wordB;
assign cdata    = (prehitOne == 1) ? cdataOne : cdataTwo; // JANKY BAD TERRIBLE CODE; PLEASE FIX

// ----------------------------------------- //

// assign validOne = cacheOne[reqAddr.idx].valid;
// assign validTwo = cacheTwo[reqAddr.idx].valid;

// ----------------------------------------- //

// destination selector block
always_comb begin
	casez({validOne, validTwo})
		0: destination = 0;
		1: destination = 0;
		2: destination = 1;
		3: destination = (recUsed[reqAddr.idx] == 1) ? 0 : 1;
		default: destination = 0;
	endcase

	if (destination == 0) begin
		dirtyAddr = cacheOne[reqAddr.idx].addr;
		dirtyData = cacheOne[reqAddr.idx].data;
	end else begin
		dirtyAddr = cacheTwo[reqAddr.idx].addr;
		dirtyData = cacheTwo[reqAddr.idx].data;
	end

	if (destination == 0 && cacheOne[reqAddr.idx].dirty == 1) begin
		destinationDirty = 1;
	end else if (destination == 1 && cacheTwo[reqAddr.idx].dirty == 1) begin
		destinationDirty = 1;
	end else begin
		destinationDirty = 0;
	end

end

// ----------------------------------------- //

// Determines correct address to request
always_comb begin
	if (dcif.dmemWEN) begin
		//if dmemWEN high, then dont overwrite the other loadAddr
		if (reqAddr.blkoff == 0) begin
			loadAddrA = reqAddr;
			loadAddrB = reqAddr;
		end else begin
			loadAddrA = reqAddr - 4;
			loadAddrB = reqAddr - 4;
		end
	end else begin
		if (reqAddr.blkoff == 0) begin
			loadAddrA = reqAddr;
			loadAddrB = reqAddr + 4;
		end else begin
			loadAddrA = reqAddr - 4;
			loadAddrB = reqAddr;
		end
	end
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
	if (!nRST) begin
		hitcounter = 0;
	end

	if (currState == IDLE) begin
		dcif.dhit     = 0;
		dcif.dmemload = 0;
		dcif.flushed  = 0;
		worddest = 0;

		//It helps to actually assign validOne and Two to something PATRICK
		//Only want to update valids in IDLE state
		validOne = cacheOne[reqAddr.idx].valid;
		validTwo = cacheTwo[reqAddr.idx].valid;

		cif.dREN      = 0;
		cif.dWEN      = 0;
		cif.daddr     = 0;
		cif.dstore    = 0;

		updateRead    = 0;
		updateWrite   = 0;

		if (dcif.halt == 1) begin
			nextState = FLUSH;

		end else if (dcif.dmemREN == 0 && dcif.dmemWEN == 0) begin
			nextState = IDLE;

		end else if (dcif.dmemREN == 1 && prehit == 1) begin
			// Read Hit;
			nextState = READHIT;

		end else if (dcif.dmemWEN == 1 && prehit == 1) begin
			// Write Hit;
			nextState = WRITEHIT;

		end else if (destinationDirty == 0) begin
			// Read Miss; Destination is NOT dirty
			nextState = DATAREQA;

		end else if (destinationDirty == 1) begin
			// Read Miss; Destination IS dirty
			nextState = DIRTYCLEANA;
		end

	end else if (currState == DIRTYCLEANA) begin
	// Writes Dirty Data (first word) Back To Memory

		dcif.dhit     = 0;
		dcif.dmemload = 0;
		dcif.flushed  = 0;
		worddest = 0;

		cif.dREN      = 0;
		cif.dWEN      = 1;
		cif.daddr     = dirtyAddr;
		cif.dstore    = dirtyData.wordA;

		updateRead    = 0;
		updateWrite   = 0;

		if (cif.dwait == 1) begin
			nextState = DIRTYCLEANA;
		end else begin
			nextState = DIRTYCLEANB;
		end

	end else if (currState == DIRTYCLEANB) begin
	// Writes Dirty Data (second word) Back To Memory

		dcif.dhit     = 0;
		dcif.dmemload = 0;
		dcif.flushed  = 0;
		worddest      = 0;

		cif.dREN      = 0;
		cif.dWEN      = 1;
		cif.daddr     = dirtyAddr + 4;
		cif.dstore    = dirtyData.wordB;

		updateRead    = 0;
		updateWrite   = 0;

		if (cif.dwait == 1) begin
			nextState = DIRTYCLEANB;
		end else begin
			nextState = DATAREQA;
		end

	end else if (currState == DATAREQA) begin
	// Requests First Block of Data

		dcif.dhit     = 0;
		dcif.dmemload = 0;
		dcif.flushed  = 0;
		worddest      = 0;

		cif.dREN      = 1;
		cif.dWEN      = 0;
		cif.daddr     = loadAddrA;
		cif.dstore    = 0;

		updateRead    = 1;
		updateWrite   = 0;

		if (cif.dwait == 1) begin
			nextState = DATAREQA;
		end else begin
			nextState = DATAREQB;
		end

	end else if (currState == DATAREQB) begin
	// Requests Second Block of Data

		dcif.dhit     = 0;
		dcif.dmemload = 0;
		dcif.flushed  = 0;
		worddest      = 1;

		cif.dREN      = 1;
		cif.dWEN      = 0;
		cif.daddr     = loadAddrB;
		cif.dstore    = 0;

		updateRead    = 1;
		updateWrite   = 0;

		if (cif.dwait == 1) begin
			nextState = DATAREQB;
		end else begin
			nextState = IDLE;
		end

	end else if (currState == READHIT) begin
	// Returns cached data to user

		dcif.dhit     = 1;
		dcif.dmemload = cdata;
		dcif.flushed  = 0;
		worddest      = 0;

		cif.dREN      = 0;
		cif.dWEN      = 0;
		cif.daddr     = 0;
		cif.dstore    = 0;

		updateRead    = 0;
		updateWrite   = 0;

		nextState = IDLE;

		hitcounter = hitcounter + 1;

	end else if (currState == WRITEHIT) begin
	// Write user data to cache

		dcif.dhit     = 1;
		dcif.dmemload = mstore;
		dcif.flushed  = 0;
		worddest      = 0;

		cif.dREN      = 0;
		cif.dWEN      = 0;
		cif.daddr     = 0;
		cif.dstore    = 0;

		updateRead    = 0;
		updateWrite   = 1;

		nextState = IDLE;

		hitcounter = hitcounter + 1;

	end else if (currState == FLUSH) begin
	// Write any data to memory if dirty

		dcif.dhit     = 0;
		dcif.dmemload = 0;
		dcif.flushed  = 0;
		worddest      = 0;

		cif.dREN      = 0;
		cif.dWEN      = 0;
		cif.daddr     = 0;
		cif.dstore    = 0;

		updateRead    = 0;
		updateWrite   = 0;

		nextState = STOP;

	end else if (currState == STOP) begin
	// Stop

		dcif.dhit     = 0;
		dcif.dmemload = 0;
		dcif.flushed  = 1;
		worddest      = 0;

		cif.dREN      = 0;
		cif.dWEN      = 0;
		cif.daddr     = 0;
		cif.dstore    = 0;

		updateRead    = 0;
		updateWrite   = 0;

		nextState = STOP;

		// if (hitcounter == 0) begin
		// 	dcif.dhit     = 0;
		// 	dcif.dmemload = 0;
		// 	dcif.flushed  = 1;
		// 	worddest      = 0;

		// 	cif.dREN      = 0;
		// 	cif.dWEN      = 0;
		// 	cif.daddr     = 0;
		// 	cif.dstore    = 0;

		// 	updateRead    = 0;
		// 	updateWrite   = 0;

		// 	nextState = STOP;

		// end else begin

		// 	dcif.dhit     = 0;
		// 	dcif.dmemload = 0;
		// 	dcif.flushed  = 0;
		// 	worddest      = 0;

		// 	cif.dREN      = 0;
		// 	cif.dWEN      = 1;
		// 	cif.daddr     = 32'h00003100;
		// 	cif.dstore    = hitcounter;

		// 	updateRead    = 0;
		// 	updateWrite   = 0;

		// 	nextState = STOP;
		// 	hitcounter == 0;
		// end

	end 
end

endmodule