/*
  Patrick Thomison
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

// Module Declaration
module dcache (
  input CLK, nRST,
  datapath_cache_if.cache dcif, 
  caches_if.caches cif
);

import cpu_types_pkg::*;

// ----------------------------------------- //

// Module Structs
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

// ----------------------------------------- //

// Module Enums
typedef enum logic [3:0] {
IDLE         = 4'h0,
READHIT      = 4'h1,
MISSCHECK    = 4'h2,
WRITEHIT     = 4'h3,
DIRTYCLEANA  = 4'h4,
DIRTYCLEANB  = 4'h5,
DATAREQA     = 4'h6,
DATAREQB     = 4'h7,
OVERWRITE    = 4'h8, 
XXXX         = 4'h9,
FLUSH        = 4'hA,
STOP         = 4'hB
} controllerState;

// ----------------------------------------- //

// Module Variables
frame cacheOne [15:0];
frame cacheTwo [15:0];

logic recUsed [15:0];

dcachef_t reqAddr;
word_t mload, mstore;

logic updateRead, updateWrite;

word_t loadAddrA, loadAddrB;

logic destination; // 0 for A, 1 for B

logic destinationDirty;

logic prehitOne, prehitTwo, prehit;
logic validOne, validTwo;
logic wordDestRead, wordDestWrite;
logic flushCacheSelect;
logic [3:0] flushIdxSelect;

word_t cdataOne, cdataTwo, cdata;

word_t hitcounter;

block dirtyData;
word_t dirtyAddr;

controllerState currState;
controllerState nextState;

// ----------------------------------------- //

// Request Address Selection
always_comb begin
	if (dcif.halt == 0) begin
		// Use the Address From Datapath
		reqAddr        = dcachef_t'(dcif.dmemaddr);
	end else begin
		// Independently Set Index for Flushing
		reqAddr.idx    = flushIdxSelect; 
		reqAddr.tag    = 0;
		reqAddr.blkoff = 0;
		reqAddr.bytoff = 0;
	end
end

// ----------------------------------------- //

// Connecting Memory Data
assign mload   = cif.dload;
assign mstore  = dcif.dmemstore;

// ----------------------------------------- //

// Cache Flip Flops
// Handles nRST and writing in new values

// Cache One
always_ff @(posedge CLK, negedge nRST) begin
	if(nRST == 0) begin
		cacheOne    <= '{default:'0};
	end else begin
		if (destination == 0) begin
			if (updateRead == 1) begin
				cacheOne[reqAddr.idx].addr.tag    <= reqAddr.tag;
				cacheOne[reqAddr.idx].addr.idx    <= reqAddr.idx;
				cacheOne[reqAddr.idx].addr.bytoff <= reqAddr.bytoff;
				cacheOne[reqAddr.idx].valid       <= 1;
				cacheOne[reqAddr.idx].dirty       <= 0;
				recUsed[reqAddr.idx]              <= 0;

				if (wordDestRead == 0) begin
					cacheOne[reqAddr.idx].data.wordA <= mload;
				end else begin
					cacheOne[reqAddr.idx].data.wordB <= mload;
				end
			end

			if (updateWrite == 1) begin
				cacheOne[reqAddr.idx].addr.tag    <= reqAddr.tag;
				cacheOne[reqAddr.idx].addr.idx    <= reqAddr.idx;
				cacheOne[reqAddr.idx].addr.bytoff <= reqAddr.bytoff;
				cacheOne[reqAddr.idx].valid       <= 1;
				cacheOne[reqAddr.idx].dirty       <= 1;

				if (wordDestWrite == 0) begin
					cacheOne[reqAddr.idx].data.wordA <= mstore;
				end else begin
					cacheOne[reqAddr.idx].data.wordB <= mstore;
				end
			end
		end
	end
end

// Cache Two
always_ff @(posedge CLK, negedge nRST) begin
	if(nRST == 0) begin
		cacheTwo    <= '{default:'0};
	end else begin
		if (destination == 1) begin
			if (updateRead == 1) begin
				cacheTwo[reqAddr.idx].addr.tag    <= reqAddr.tag;
				cacheTwo[reqAddr.idx].addr.idx    <= reqAddr.idx;
				cacheTwo[reqAddr.idx].addr.bytoff <= reqAddr.bytoff;
				cacheTwo[reqAddr.idx].valid       <= 1;
				cacheTwo[reqAddr.idx].dirty       <= 0;
				recUsed[reqAddr.idx]              <= 1;

				if (wordDestRead == 0) begin
					cacheTwo[reqAddr.idx].data.wordA <= mload;
				end else begin
					cacheTwo[reqAddr.idx].data.wordB <= mload;
				end
			end

			if (updateWrite == 1) begin
				cacheTwo[reqAddr.idx].addr.tag    <= reqAddr.tag;
				cacheTwo[reqAddr.idx].addr.idx    <= reqAddr.idx;
				cacheTwo[reqAddr.idx].addr.bytoff <= reqAddr.bytoff;
				cacheTwo[reqAddr.idx].valid       <= 1;
				cacheTwo[reqAddr.idx].dirty       <= 1;

				if (wordDestWrite == 0) begin
					cacheTwo[reqAddr.idx].data.wordA <= mstore;
				end else begin
					cacheTwo[reqAddr.idx].data.wordB <= mstore;
				end
			end
		end
	end
end

// ----------------------------------------- //

// Prehit Gates
assign prehitOne = (cacheOne[reqAddr.idx].addr.tag == reqAddr.tag) && (cacheOne[reqAddr.idx].valid == 1);
assign prehitTwo = (cacheTwo[reqAddr.idx].addr.tag == reqAddr.tag) && (cacheTwo[reqAddr.idx].valid == 1);
assign prehit = prehitOne || prehitTwo;

// ----------------------------------------- //

// Cache Data Gates
assign cdataOne = (reqAddr.blkoff == 0) ? cacheOne[reqAddr.idx].data.wordA : cacheOne[reqAddr.idx].data.wordB;
assign cdataTwo = (reqAddr.blkoff == 0) ? cacheTwo[reqAddr.idx].data.wordA : cacheTwo[reqAddr.idx].data.wordB;
assign cdata    = (prehitOne == 1) ? cdataOne : cdataTwo; // JANKY BAD TERRIBLE CODE; PLEASE FIX

// ----------------------------------------- //

// Destination Selector -- only update on idle
always_comb begin
	if (dcif.halt == 1) begin
		destination = flushCacheSelect;
	end else begin 
		casez({validOne, validTwo})
			0: destination = 0;
			1: destination = 0;
			2: destination = 1;
			3: destination = (recUsed[reqAddr.idx] == 1) ? 0 : 1;
			default: destination = 0;
		endcase
	end
end

// ----------------------------------------- //

// Dirty Flags
always_comb begin
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

// Load Address Determination
always_comb begin

	if (reqAddr.blkoff == 0) begin
		loadAddrA = reqAddr;
		loadAddrB = reqAddr + 4;
		wordDestWrite = 0;
	end else begin
		loadAddrA = reqAddr - 4;
		loadAddrB = reqAddr;
		wordDestWrite = 1;
	end
end

// ----------------------------------------- //

// Cache Controller Flip Flop
// Handles nRST and advancing state
always_ff @(posedge CLK, negedge nRST) begin
	if(nRST == 0) begin
		currState <= IDLE;
	end else begin
		currState <= nextState;
	end
end

// ----------------------------------------- //

// Cache Controller Next State Logic
always_comb begin
	if (!nRST) begin
		// On Reset
		nextState = IDLE;
		hitcounter = 0;
	end else if (currState == IDLE) begin
		if (dcif.halt == 1) begin
			// Flushing
			nextState = FLUSH;

		end else if (dcif.dmemREN == 0 && dcif.dmemWEN == 0) begin
			// Idling
			nextState = IDLE;

		end else if (dcif.dmemREN == 1 && prehit == 1) begin
			// Read Hit
			nextState = READHIT;
			// Logging Hit
			hitcounter = hitcounter + 1;

		end else if (dcif.dmemWEN == 1 && prehit == 1) begin
			// Write Hit
			nextState = OVERWRITE;
			// Logging Hit
			hitcounter = hitcounter + 1;

		end else if (destinationDirty == 0) begin
			// Any Miss; Destination is NOT dirty
			nextState = DATAREQA;

		end else if (destinationDirty == 1) begin
			// Any Miss; Destination IS dirty
			nextState = DIRTYCLEANA;

		end
	end else if (currState == DIRTYCLEANA) begin
		if (cif.dwait == 1) begin
			// Waiting for Memory Ops
			nextState = DIRTYCLEANA;
		end else begin
			// Memory Ops are done
			nextState = DIRTYCLEANB;
		end
	end else if (currState == DIRTYCLEANB) begin
		if (cif.dwait == 1) begin
			// Waiting for Memory Ops
			nextState = DIRTYCLEANB;
		end else if (dcif.halt == 1) begin
			// Flushing && Memory Ops are done
			nextState = FLUSH;
		end else begin
			// Memory Ops are done
			nextState = DATAREQA;
		end
	end else if (currState == DATAREQA) begin
		if (cif.dwait == 1) begin
			// Waiting for Memory Ops
			nextState = DATAREQA;
		end else begin
			// Memory Ops are done
			nextState = DATAREQB;
		end
	end else if (currState == DATAREQB) begin
		if (cif.dwait == 1) begin
			// Waiting for Memory Ops
			nextState = DATAREQB;
		end else if (dcif.dmemWEN == 1) begin
			// Memory Ops are done && Writing
			nextState = OVERWRITE;
		end else begin
			// Memory Ops are done && Reading
			nextState = IDLE;
		end
	end else if (currState == OVERWRITE) begin
		// Signal the system
		nextState = WRITEHIT;
	end else if (currState == READHIT) begin
		// Wait for next signal
		nextState = IDLE;
	end else if (currState == FLUSH) begin
		// todo
		nextState = STOP;
		if (cacheOne[0].dirty == 1) begin
			flushCacheSelect = 0;
		end
	end else if (currState == STOP) begin
		// Stops the system
		nextState = STOP;
	end 
end

// ----------------------------------------- //

// Cache Controller Control Signals
always_comb begin

	// DCIF Defaults
	dcif.dhit     = 0;
	dcif.dmemload = 0;
	dcif.flushed  = 0;

	// CIF Defaults
	cif.dREN      = 0;
	cif.dWEN      = 0;
	cif.daddr     = 0;
	cif.dstore    = 0;

	// Internal Defaults
	wordDestRead  = 0;
	updateRead    = 0;
	updateWrite   = 0;

	if (currState == IDLE) begin
		// Only update valid bits in Idle
		validOne = cacheOne[reqAddr.idx].valid;
		validTwo = cacheTwo[reqAddr.idx].valid;

	end else if (currState == DIRTYCLEANA) begin
		// Writes Dirty Data (first word) Back To Memory
		cif.dWEN      = 1;
		cif.daddr     = dirtyAddr;
		cif.dstore    = dirtyData.wordA;

	end else if (currState == DIRTYCLEANB) begin
		// Writes Dirty Data (second word) Back To Memory
		cif.dWEN      = 1;
		cif.daddr     = dirtyAddr + 4;
		cif.dstore    = dirtyData.wordB;

	end else if (currState == DATAREQA) begin
		// Requests First Block of Data
		cif.dREN      = 1;
		cif.daddr     = loadAddrA;
		updateRead    = 1;
		wordDestRead  = 0;

	end else if (currState == DATAREQB) begin
		// Requests Second Block of Data
		cif.dREN      = 1;
		cif.daddr     = loadAddrB;
		updateRead    = 1;
		wordDestRead  = 1;

	end else if (currState == OVERWRITE) begin	
		// Writes in new write data, makes dirty
		updateWrite   = 1;

	end else if (currState == READHIT) begin
		// Returns cached data to system && notifys system
		dcif.dhit     = 1;
		dcif.dmemload = cdata;

	end else if (currState == WRITEHIT) begin
		// Write user data to cache && notifys system
		dcif.dhit     = 1;

	end else if (currState == FLUSH) begin
		// Write any data to memory if dirty

	end else if (currState == STOP) begin
	// Stop
		dcif.flushed  = 1;

	end 
end

endmodule