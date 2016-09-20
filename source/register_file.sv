/*
	Emily Fredette
	efredett@purdue.edu

	register file
	lab 1
*/

`include "cpu_types_pkg.vh"
`include "register_file_if.vh"

module register_file(
	input logic CLK, nRST,
	register_file_if.rf rfif
);

import cpu_types_pkg::*;
word_t register [31:0];


always_ff @(posedge CLK, negedge nRST) begin
	if (nRST == 0) begin
		register <= '{default:'0};
	end
	else if (rfif.WEN) begin
		if (rfif.wsel) begin //dont change 0000 location?
			register[rfif.wsel] <= rfif.wdat;
		end
	end

end




always_comb begin
	rfif.rdat1 = register[rfif.rsel1];

	rfif.rdat2 = register[rfif.rsel2];
	
end

endmodule
