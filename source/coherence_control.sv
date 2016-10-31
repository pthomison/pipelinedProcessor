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
  cache_control_if.cc ccif
);
  	// type import
  	import cpu_types_pkg::*;

  	// number of cpus for cc
  	parameter CPUS = 2;

	// Module Enums
	// ----------------------------------------- //
	typedef enum logic [3:0] {
	IDLE         = 4'h0,
	ARBITRATE    = 4'h1,
	SNOOP	     = 4'h2,
	R1           = 4'h3,
	R2           = 4'h4,
	DATAREADY	 = 4'h5,
	W1           = 4'h6,
	W2           = 4'h7
	} controllerState;

	//CACHE inputs - 2 Bits each
	//iREN, dREN, dWEN, dstore (data), iaddr, daddr,
	//RAM inputs
	//ramload, ramstate,
	//COHERENCE inputs from cache
	//ccwrite, cctrans

	//CACHE outputs - 2 Bits each
	//iwait, dwait - always high unless in ACCESS, iload, dload,
	//RAM outputs
	//ramstore, ramaddr, ramWEN, ramREN,
	//COHERENCE outputs to cache
	//ccwait, ccinv, ccsnoopaddr


	controllerState currState;
	controllerState nextState;

	//want to break ccsnoopaddr into parts
	//ccsnoopaddr is word_t  [CPUS-1:0] 
	dcachef_t snoopaddr0, snoopaddr1;
	assign snoopaddr0 = dcachef_t'(dcif.ccsnoopaddr[0]);
	assign snoopaddr1 = dcachef_t'(dcif.ccsnoopaddr[1]);

	//1 if data exists in other cache, 0 if not
	logic snoophit;

	assign ccif.iload = ccif.ramload;
	assign ccif.dload = ccif.ramload;



// Snoop Logic
// ----------------------------------------- //

	always_comb begin
		if(!nRST) begin
			currState <= IDLE;
		end else begin
			currState <= nextState;
		end
	end





// Coherence Controller Flip Flop
// ----------------------------------------- //
	always_ff @(posedge CLK, negedge nRST) begin
		if(nRST == 0) begin
			snoophit <= 0;
		end else begin
			//obviously not done yet
			snoophit <= 1;
		end
	end




// Coherence Controller Next State Logic
// ----------------------------------------- //
	always_comb begin
		nextState = IDLE;

		if (!nRST) begin
			nextState = IDLE;

		end else if (currState == IDLE) begin
			if (ccif.dREN == 0) begin
				nextState = IDLE;
			end else begin
				nextState = ARBITRATE;
			end 

		end else if (currState == ARBITRATE) begin
			nextState = SNOOP;

		end else if (currState == SNOOP) begin
			if (snoophit == 1) begin
				//Hit
				//Data is in other cache
				//Modified state
				nextState = W1;
			end else if (snoophit == 0) begin
				//Miss
				//Data is NOT in other cache
				//Shared or Invalid state
				nextState = R1;
			end 

		end else if (currState == W1) begin
			if (cif.dwait == 0) begin
				// Memory Ops are done
				nextState = W2;
			end else if (cif.dwait == 1) begin
				// Waiting for Memory Ops
				nextState = W1;
			end


		end else if (currState == W2) begin
			if (cif.dwait == 0) begin
				// Memory Ops are done
				nextState = DATAREADY;
			end else if (cif.dwait == 1) begin
				// Waiting for Memory Ops
				nextState = W2;
			end



		end else if (currState == R1) begin
			if (cif.dwait == 0) begin
				// Memory Ops are done
				nextState = R2;
			end else if (cif.dwait == 1) begin
				// Waiting for Memory Ops
				nextState = R1;
			end


		end else if (currState == R2) begin
			if (cif.dwait == 0) begin
				// Memory Ops are done
				nextState = DATAREADY;
			end else if (cif.dwait == 1) begin
				// Waiting for Memory Ops
				nextState = R2;
			end

		end else if (currState == DATAREADY) begin
			nextState = IDLE;
		end 
	end



// Coherence Controller Control Signals
// ----------------------------------------- //
	always_comb begin

		// Defaults Here




		

		if (currState == IDLE) begin

		end else if (currState == ARBITRATE) begin


		end else if (currState == SNOOP) begin	


		end else if (currState == W1) begin


		end else if (currState == W2) begin


		end else if (currState == R1) begin


		end else if (currState == R2) begin


		end else if (currState == DATAREADY) begin


		end 
	end























//from first memory controller

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
