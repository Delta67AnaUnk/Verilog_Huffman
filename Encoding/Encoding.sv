module Encoding(
	input clk, n_rst,
	input empty,code_len,code_end,
	input [7:0] data,
	output encoded, w_en, 
	output [7:0] char
);

	

	always_ff begin:FF
		if(n_rst==0) begin
		end else begin
		end
	end


endmodule
