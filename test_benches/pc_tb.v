`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:   18:47:36 01/08/2014
// Design Name:   pc
// Module Name:   C:/Documents and Settings/Administrador/dapa/pc_tb.v
// Project Name:  dapa
// Target Device:
// Tool versions:
// Description:
//
// Verilog Test Fixture created by ISE for module: pc
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////

module pc_tb;

	// Inputs
	reg clk;
	reg reset;
	reg w;
	reg r;
	reg i;

	// Outputs
	wire [7:0] pc_out;

	// Bidirs
	wire [7:0] pc_inout;
	reg [7:0]  aux;
	
	assign pc_inout=aux;

	// Instantiate the Unit Under Test (UUT)
	pc uut (
		.clk(clk),
		.reset(reset),
		.w(w),
		.r(r),
		.i(i),
		.pc_inout(pc_inout),
		.pc_out(pc_out)
	);

	initial begin
		$dumpfile("pc_tb.vcd");
		$dumpvars(0,pc_tb);
	end

	initial begin
		// Initialize Inputs
		w = 0;
		r = 0;
		i = 0;

		repeat(3) @(posedge clk);
		reset =1;
		aux <= 8'hZZ;
      @(posedge clk);
      reset = 0;
		@(posedge clk); r = 1;
		@(posedge clk); r = 0;
		aux <= 8'h77;
		@(posedge clk); w = 1;
		@(posedge clk); w = 0;
		aux <= 8'hZZ;
		@(posedge clk); r = 1;
		@(posedge clk); r = 0;
		@(posedge clk); i = 1;
		@(posedge clk); i = 0;
		@(posedge clk); r = 1;
		@(posedge clk); r = 0;
		@(posedge clk); reset = 1;
		@(posedge clk); reset = 0;

		// Wait 100 ns for global reset to finish
		repeat(10)  @(posedge clk);
		$finish;

		// Add stimulus here

	end

	 initial clk = 1;
	 always #25 clk = ~clk;

endmodule

