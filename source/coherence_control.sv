/*
  Emily Fredette
  Patrick Thomison
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module coherence_control (
  input CLK, nRST,
  cache_control_if.cc cif,
  cache_control_if.cc mcif
);
  	// type import
  	import cpu_types_pkg::*;

	// Module Enums
	// ----------------------------------------- //
	typedef enum logic [3:0] {
	IDLE         = 4'h0,
	INV          = 4'h1,
	SNOOP	     = 4'h2,
	R1           = 4'h3,
	R2           = 4'h4,
	DATAREADY1   = 4'h5,
	DATAREADY2   = 4'h6,
	W1MOD        = 4'h7,
	W2MOD        = 4'h8,
	W1WEN        = 4'h9,
	W2WEN        = 4'hA
	} controllerState;

	//inputs from CACHE  - 2 Bits each
	//iREN, dREN, dWEN, dstore (data), iaddr, daddr,
	//COHERENCE inputs from cache
	//ccwrite, cctrans

	//outputs to cache - 2 Bits each
	//iwait, dwait - always high unless in ACCESS, iload, dload,
	//COHERENCE outputs to cache
	//ccwait, ccinv, ccsnoopaddr


	controllerState currState;
	controllerState nextState;

	logic currReq, nextReq;
	word_t rdata1, rdata2; 
	word_t newRData1, newRData2;


// Coherence Controller Flip Flop
// ----------------------------------------- //

	always_ff @(posedge CLK, negedge nRST) begin
		if(!nRST) begin
			currState <= IDLE;
		end else begin
			currState <= nextState;
		end
	end


// Snoop Flip Flop
// ----------------------------------------- //
	always_ff @(posedge CLK, negedge nRST) begin
		if(nRST == 0) begin
			currReq  <= 0;
		end else begin
			currReq  <= nextReq;
		end
	end

// Read Data Flip Flop
// ----------------------------------------- //
	always_ff @(posedge CLK, negedge nRST) begin
		if(nRST == 0) begin
			rdata1  <= 0;
			rdata2  <= 0;
		end else begin
			rdata1 <= newRData1;
			rdata2 <= newRData2;
		end
	end

// Coherence Controller Next State Logic
// ----------------------------------------- //
	always_comb begin
		nextState = currState;


		if (!nRST) begin
			//nextState = IDLE;


		end else if (currState == IDLE) begin
			if ((cif.dREN[0] == 1 && cif.cctrans[0] == 1) || (cif.dREN[1] == 1 && cif.cctrans[1] == 1)) begin
				nextState = SNOOP;
			end else if ((cif.ccwrite[0] == 1 && cif.cctrans[0] == 1) || (cif.ccwrite[1] == 1 && cif.cctrans[1] == 1)) begin
				nextState = INV;
			end else begin
				nextState = IDLE;
			end 

		end else if (currState == SNOOP) begin
			nextState = R1;

			if (currReq == 0) begin
				if (cif.ccwrite[1] == 1) begin
					nextState = W1MOD;
				end else begin 
					nextState = R1;
				end
			end else if (currReq == 1) begin
				if (cif.ccwrite[0] == 1) begin
					nextState = W1MOD;
				end else begin
					nextState = R1;
				end
			end

		end else if (currState == W1MOD) begin
			nextState = W1MOD;
			if (mcif.dwait == 0) begin
				nextState = W2MOD;
			end

		end else if (currState == W2MOD) begin
			nextState = DATAREADY1;
			if (mcif.dwait == 0) begin
				nextState = W2MOD;
			end

		end else if (currState == R1) begin
			nextState = R1;
			if (cif.dwait == 0) begin
				nextState = R2;
			end 

		end else if (currState == R2) begin
			nextState = R2;
			if (cif.dwait == 0) begin
				nextState = DATAREADY1;
			end 

		end else if (currState == DATAREADY1) begin
			nextState = DATAREADY2;
			//

		end else if (currState == DATAREADY2) begin
			nextState = IDLE;
			//

		end else if (currState == W1WEN) begin
			nextState = W1WEN;
			if (mcif.dwait == 0) begin
				nextState = W2WEN;
			end

		end else if (currState == W2WEN) begin
			nextState = W2WEN;
			if (mcif.dwait == 0) begin
				nextState = IDLE;
			end

		end else if (currState == INV) begin
			nextState = IDLE;
			//

		end
	end



// Coherence Controller Control Signals
// ----------------------------------------- //
	always_comb begin

		// Defaults Here
		nextReq     = 0;
		mcif.ramaddr  = 0;
		mcif.ramstore = 0;

		// Keeping Junk Data Out of the FF's
		nextReq   = currReq;
		newRData1 = rdata1;
		newRData2 = rdata2;

		

		if (currState == IDLE) begin
			if (cif.dREN[0] == 1 && cif.cctrans[0] == 1) begin
				nextReq   = 0;
			end else if (cif.dREN[1] == 1 && cif.cctrans[1] == 1) begin
				nextReq   = 1;
			end

		end else if (currState == SNOOP) begin	
			if (currReq == 0) begin
				cif.ccsnoopaddr[1] = cif.daddr[0]; 
			end else if (currReq == 1) begin
				cif.ccsnoopaddr[0] = cif.daddr[1]; 
			end

		// Writing Requestee Data Word One
		end else if (currState == W1MOD) begin
			mcif.ramWEN = 1;
			if (currReq == 0) begin
				mcif.ramaddr  = cif.daddr[1];
				mcif.ramstore = cif.dstore[1];
			end else if (currReq == 1) begin
				mcif.ramaddr  = cif.daddr[0];
				mcif.ramstore = cif.dstore[0];
			end

		// Writing Requestee Data Word Two
		end else if (currState == W2MOD) begin
			mcif.ramWEN = 1;
			if (currReq == 0) begin
				mcif.ramaddr  = cif.daddr[1];
				mcif.ramstore = cif.dstore[1];
			end else if (currReq == 1) begin
				mcif.ramaddr  = cif.daddr[0];
				mcif.ramstore = cif.dstore[0];
			end

		// Reading Memory Data Word one
		end else if (currState == R1) begin
			mcif.ramREN = 1;
			newRData1 = mcif.ramload;
			if (currReq == 0) begin
				mcif.ramaddr  = cif.daddr[0];
			end else if (currReq == 1) begin
				mcif.ramaddr  = cif.daddr[1];
			end

		// Reading Memory Data Word Two
		end else if (currState == R2) begin
			mcif.ramREN = 1;
			newRData2 = mcif.ramload;
			if (currReq == 0) begin
				mcif.ramaddr  = cif.daddr[0];
			end else if (currReq == 1) begin
				mcif.ramaddr  = cif.daddr[1];
			end

		// Sending Read Data To Cache
		end else if (currState == DATAREADY1) begin
			if (currReq == 0) begin
				cif.dwait[0] = 0;
				cif.dload[0] = rdata1;
			end else if (currReq == 1) begin
				cif.dwait[1] = 0;
				cif.dload[1] = rdata1;
			end

		// Sending Read Data To Cache
		end else if (currState == DATAREADY2) begin
			if (currReq == 0) begin
				cif.dwait[0] = 0;
				cif.dload[0] = rdata2;
			end else if (currReq == 1) begin
				cif.dwait[1] = 0;
				cif.dload[1] = rdata2;
			end

		// Strictly Writing Data To Memory
		end else if (currState == W1WEN) begin
			mcif.ramWEN = 1;
			if (currReq == 0) begin
				cif.dwait[0] = 0;
				cif.dload[0] = rdata2;
			end else if (currReq == 1) begin
				cif.dwait[1] = 0;
				cif.dload[1] = rdata2;
			end

		// Strictly Writing Data To Memory
		end else if (currState == W2WEN) begin

		// Invalidating other data
		end else if (currState == INV) begin

		end
	end


endmodule
