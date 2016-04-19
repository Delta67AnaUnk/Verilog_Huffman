module DecodeBlock(
	input clk,n_rst,
	input dict_ready,empty,
	input [7:0] Char,
	output dict_err, w_en, r_en,
	output [7:0] Data,
	output [6:0] code_len
);
	logic serial_d,chsent,c_en,done;

	ByteToBit BTB(.clk(clk), .n_rst(n_rst), .done(done), .dict_ready(dict_ready), .empty(empty), .data(Data), .serial_d(serial_d), .c_en(c_en), .r_en(ren));
	LengthCounter LC(.clk(clk), .n_rst(n_rst), .serial_d(serial_d), c_en(c_en), .chsent(chsent), .code_len(code_len));
	CharOutput CO(.clk(clk), .n_rst(n_rst), .chsent(chsent), .Char(Char), .dict_err(dict_err), .done(done), .w_en(w_en), .Data(Data));
endmodule
