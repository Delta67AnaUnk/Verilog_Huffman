module NextByte(
	input clk,n_rst.
	input [7:0] data,
	input dict_ready,empty,done,
	output [7:0] char,
	output c_en,r_en
);
	reg next_r_en,next_c_en;
	reg [7:0] tmp_char;

	always_ff begin
		if(n_rst==0) begin
			char <= 0;
			c_en <= 0;
			r_en <= 0;
		end else begin
			r_en <= next_r_en;
			c_en <= next_c_en;
			char <= tmp_char;
		end
	end

	always_comb begin
		if(dict_ready==1) begin
			next_r_en = 1;
			next_c_en = 0;
		end
		if(done==1&&empty==0) begin
			next_r_en = 1;
			next_c_en = 0;
		end
		if(r_en==1) begin
			tmp_data = data;
			next_r_en = 0;
			next_c_en = 1;
		end
		if(c_en==1) begin
			next_c_en = 0;
		end
	end
endmodule
