module Translator(
	input clk,n_rst,
	input [5:0] code_len,
	input code_end,
	output serial,done
);
	reg cend;
	reg [5:0] len;

	always_ff begin:FF
		if(n_rst == 0) begin
			serial <= 0;
			done <= 0;
		end else begin
			if(done==1) begin
				done <= 0;
				len = code_len;
				cend = code_end;
			end
			if(len>1) begin
				len <= len -1;
				serial <= 0;
			end else if(len==1) begin
				len <= 0;
				serial <= cend;
				done <= 1;
			end
		end
	end

endmodule
