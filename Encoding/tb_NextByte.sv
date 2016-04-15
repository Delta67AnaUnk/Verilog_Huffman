`timescale 1ns / 10ps

module tb_NextByte();
	localparam CLK_PERIOD = 6;
	localparam DATA_PERIOD = (CLK_PERIOD*8);
	localparam MAX_DATA = (DATA_PERIOD*0.965);
	localparam MIN_DATA = (DATA_PERIOD*1.035);
	reg g_clk;
	reg g_rst;

	reg [3:0] tb_case;
	reg [7:0] t_data;
	reg [7:0] t_char;
	reg t_ready,t_empty, t_done, t_cen, t_ren;

	NextByte DUT(.clk(g_clk),.n_rst(g_rst),.data(t_data),.dict_ready(t_ready),.empty(.t_empty),.done(t_done),.char(t_char),.c_en(t_cen),.r_en(t_ren));
	
	always
	begin
		g_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		g_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end

	task reset;
	begin
		#2;
		g_rst = 0;
		#2;
		g_rst = 1;
	end
	endtask

	task data;
		input [31:0] data;
		input [3:0]empty;
		input [3:0]ready;
		input [3:0]done;
	begin
		@(posedge g_clk);
		repeat(4) begin
			t_data = data[31:24];
			data = data<<8;
			t_empty = empty[7];
			empty = empty<<1;
			t_done = done[7];
			done = done<<1;
		end
	end
	endtask

	initial begin
		g_clk = 0;
		g_rst = 1;

		// Case 0 reset test;
		tb_case = 0;
		g_rst = 0;
		#(CLK_PERIOD*2);
		g_rst = 1;

		// Case 1 normal two byte data
		tb_case = 1;
		reset;
		

	end

endmodule
