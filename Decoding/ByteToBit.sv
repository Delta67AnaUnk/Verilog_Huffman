module ByteToBit(
	input clk,n_rst,
	input done, dict_ready,empty,
	input [7:0] data,
	output serial_d, c_en, r_en
);
	reg next_r_en,next_c_en,next_d;
	reg [3:0] count,next_count;
	reg [7:0] tmp;

	always_ff begin
		if(n_rst==0) begin
			serial_d <= 0;
			c_en <= 0;
			r_en <= 0;
			count <= 8;
		end else begin
			r_en <= next_r_en;
			c_en <= next_c_en;
			serial_d <= next_d;
		end
	end

	always_comb begin
		if(dict_ready==1) begin
			next_r_en = 1;
			next_c_en = 0;
			next_count = 8;
		end
		if(done==1&&empty==0) begin
			next_r_en = 1;
			next_c_en = 0;
			next_count = 8;
		end
		if(done==1&&empty==1) begin
			next_r_en = 0;
			next_c_en = 0;
			next_count = 8;
			tmp = 0;
		end
		if(r_en==1) begin
			next_r_en = 0;
			next_c_en = 1;
			tmp = data;
		end
		if(c_en==1&&count>0) begin
			next_d = tmp[0];
			tmp = tmp>>1;
			count = count-1;
		end else if(c_en==1&&count==0) begin
			next_c_en = 0;
			next_r_en = 1;
			count = 8;
		end
	end

endmodule
