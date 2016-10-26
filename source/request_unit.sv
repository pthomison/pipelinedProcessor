/*
	Emily Fredette
	request unit
*/

// interface
`include "request_unit_if.vh"

module request_unit (
  input CLK, nRST,
  request_unit_if.ru ruif
);

always_comb begin
	ruif.dmemren = ruif.dren;
	ruif.dmemwen = ruif.dwen;
	// if (!nRST) begin
	// 	ruif.dmemren = 0;
	// 	ruif.dmemwen = 0;
	// end
	// else begin
	// 	if (ruif.dhit) begin
	// 		ruif.dmemren = 0;
	// 		ruif.dmemwen = 0;
	// 	end
	// 	else begin
	// 		//if (ruif.dwen) begin
	// 		if (ruif.ihit & ruif.dwen) begin
	// 			ruif.dmemwen = 1;
	// 			ruif.dmemren = 0;
	// 		end

	// 		//if (ruif.dren) begin
	// 		if (ruif.ihit & ruif.dren) begin
	// 			ruif.dmemren = 1;
	// 			ruif.dmemwen = 0;
	// 		end
	// 	end
	// end
end

endmodule
