`timescale 1ns / 1ps

module sd_tb;
	reg clk;
	reg reset;
	reg enable;

	reg addr;
	reg w_strobe;
	reg [7:0] din;
	reg [7:0] dout;

	port_sdcm u_port_sdcm(
		.clk(clk),
		.reset(reset),
		.enable(enable),
		.addr(addr),
		.w_strobe(w_strobe),
		.dout(dout),
		.din(din)
	);

	always begin
		#50 clk = ~clk;
	end

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		enable = 0;
		addr = 0;
		w_strobe = 0;
		din = 8'd0;

		@(posedge clk);
		reset = 0;
		enable = 1;

		@(posedge clk);
		din = 8'd1;
		w_strobe = 1;

		@(posedge clk);
		din = 8'd1;
		@(posedge clk);
		din = 8'd2;
		@(posedge clk);
		din = 8'd3;
		@(posedge clk);
		din = 8'd4;

		@(posedge clk);
		w_strobe = 0;
		enable = 0;
		@(posedge clk);
		@(posedge clk);

		@(posedge clk);
		w_strobe = 1;
		enable = 1;
		din = 8'd2;

		repeat(3)
		begin
			@(posedge clk);
			w_strobe = 0;
			@(posedge clk);
			@(posedge clk);

			@(posedge clk);
			w_strobe = 1;
			din = 8'd4;
		end

		@(posedge clk);
		w_strobe = 1;
		din = 8'd1;
	end
endmodule
