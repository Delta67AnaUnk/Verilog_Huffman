module LengthCounter(
	input clk,n_rst,
	input serial_d,c_en,
	output chsent,
	output [6:0] code_len
);
	reg [6:0] tmplen;
	reg next_ch;
	
	always_ff begin
		if(n_rst==0) begin
			code_len <= 0;
			chsent <= 0;
		end else begin
			code_len <= tmplen;
			chsent <= next_ch;
			if (c_en==1) begin
				if(serial_d==1) begin
					tmplen <= tmplen+1;
					next_ch = 0;
				end else begin
					tmplen <= 1;
					next_ch = 1;
				end
			end
		end
	end

endmodule
