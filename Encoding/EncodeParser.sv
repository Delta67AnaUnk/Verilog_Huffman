module EncodingParser(
	input clk, n_rst,
	input [6:0] code_len,c_en,
	output serial_d,strobe, dict_err
);
	reg next_d,next_strobe,next_err;
	reg [5:0] raw_len;

	typedef logic[2:0]{IDLE, EIDLE, WAIT1, WAIT2, LOAD, SEND, LAST} states;
	states cur,next;

	always_ff begin
		if(n_rst==0) begin
			serial_d <= 0;
			strobe <= 0;
			dict_err <= 0;
		end else begin
			serial_d <= next_d;
			strobe <= next_strobe;
			dict_err <= next_err;
		end
	end

	always_comb begin
		case(cur)
			IDLE: begin if(c_en==1) next=WAIT1; else next=IDLE;
			next_d = 0; next_strobe=0; next_err=0; end
			WAIT1: begin next=WAIT2; next_err = 0; next_strobe = 0; next_d = 0; end
			WAIT2: begin if(code_len==0) next=EIDL; else next=SEND; end
			EIDLE: begin if(c_en==1) next=WAIT1; else next=EIDLE;
			next_err = 1; end
			LOAD: begin next = SEND; raw_len = code_len-1; next_strobe = 0; end
			SEND: begin if(raw_len>0) next=SEND; else next=LAST;
			next_d = 1; next_strobe = 1; next_err = 0; raw_len = raw_len-1; end
			LAST: begin next = IDLE; next_d = 0; next_strobe = 1; next_err = 0; end
		endcase
	end

endmodule
