module EncodeBlock(
	input clk,n_rst,
	input r_en,w_en,dict_ready,empty,
	input [7:0] data;
	input [6:0] code_len;
	output [7:0] char;
	output [7:0] encoded_data;
	output dict_err
);
	logic c_en, done, strobe, serial_d;

	EncodeParser EP(.clk(clk),.n_rst(n_rst),.code_len(code_len),.c_en(c_en),.serial_d(serial_d),.strobe(strobe),.dict_err(dict_err));
	NextByte NB(.clk(clk),.n_rst(n_rst),.data(data),.dict_ready(dict_ready),.empty(empty),.done(done),char(char),.c_en(c_en),.r_en(r_en));
	ParallelOut PO(.clk(clk),.n_rst(n_rst),.serial_d(serial_d),.strobe(strobe),.done(done),.w_en(w_en),.encoded_data(encoded_data));

endmodule
