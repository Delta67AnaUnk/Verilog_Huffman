module CharOutput(
	input clk, n_rst,
	input chsent,
	input Char[7:0],
	output dict_error, done, w_en,
	output Data[7:0]
);
	typedef logic[3:0] {IDLE, WAIT1, WAIT2, LOAD, ERR, END} states;
	reg [7:0] next_d;
	reg [2:0] st;

	states cur,next;
	always_ff begin
		if (n_rst==0) begin
			cur <= IDLE;
			Data <= 0;
			dict_err <= 0;
			done <= 0;
			w_en <= 0;
		end else begin
			cur <= next;
			Data <= next_d;
			dict_err <= st[2];
			w_en <= st[1];
			done <= st[0];
		end
	end

	always_comb begin
		case(cur)
			IDLE:begin if(chsent==1) next=WAIT1;else next=IDLE; next_d=0;st=3'd0; end
			WAIT1: next=WAIT2;
			WAIT2: next=LOAD;
			LOAD:begin if(Char==0) next=ERR;else next=END; end
			END:begin st=3'b011;next=IDLE; end
			ERR:begin st=3'b100;if(chsent==1)next=WAIT1; else next=ERR; end
		endcase
	end


endmodule
