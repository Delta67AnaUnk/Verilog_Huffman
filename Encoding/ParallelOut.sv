module ParallelOut(
	input clk, n_rst,
	input serial_d, strobe,
	output done, w_en, 
	output [7:0]encoded_data
);
	reg [7:0] raw_out;
	reg [2:0] count,next_count;
	reg next_done,next_w_en;
	typedef logic[1:0] {IDLE, SHIFT, SEND} states;
	state cur, next;
	always_ff begin
		if(n_rst == 0) begin
			encoded_data <= 0;
			done <= 0;
			w_en <= 0;
			count <= 0;
		end else begin
			encoded_data <= raw_out;
			done <= next_done;
			w_en <= next_w_en;
			count <= next_count;
		end
	end

	always_comb begin
		case(cur)
			IDLE: begin next_count=8; next_done=0; next_w_en=0; if(strobe==1)next=SHIFT;else next=IDLE; end
			SHIFT: begin next_count=count-1; raw_out = raw_out<<1; raw_out[0] = serial_d; 
			if(next_count==0)next=SEND;else next=SHIFT; end
			SEND: begin next_w_en=0;next_done=0;next=IDLE; end
		endcase
	end

endmodule
