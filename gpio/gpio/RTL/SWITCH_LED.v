module SWITCH_LED (
	inout [7:0]	SWITCH,
	output [7:0] LED
	
);	

assign LED[6:0] = SWITCH[6:0];

endmodule