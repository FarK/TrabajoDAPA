`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:17:11 12/12/2013
// Design Name:   fichero_reg
// Module Name:   fichero_reg_tb.v
// Project Name:  RegsProcesador
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fichero_reg
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fichero_reg_tb;

	// Inputs
	reg clk;
	reg reset;
	reg w;
	reg [2:0] sw;
	reg [2:0] sa;
	reg [2:0] sb;
	reg [7:0] c_in;

	// Outputs
	wire [7:0] a_out;
	wire [7:0] b_out;

	// Instantiate the Unit Under Test (UUT)
	fichero_reg uut (
		.clk(clk), 
		.reset(reset),
		.w(w), 
		.sw(sw), 
		.sa(sa), 
		.sb(sb), 
		.c_in(c_in), 
		.a_out(a_out), 
		.b_out(b_out)
	);
	
	reg [3:0] counter;
	reg [2:0] addr;
	reg [7:0] value;

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		w = 0;
		sw = 0;
		sa = 0;
		sb = 0;
		c_in = 0;
		#20
		
		// Initialization of registers
		reset = 1;
		#40
		
		//Test 1
		//Write and read the same register: In the a_out and b_out, 
		//first you can see the register value before writing.
		//Then, in the next clock cicle, you can see the written value.
		reset = 0;
		w = 1;
		addr = 0;
		value = 0;
		for (counter=0; counter < 8; counter = counter + 1) begin
			@(posedge clk); //Wait to posedge to update the inputs of the uut
			c_in = value;
			sw = addr;
			sa = addr;
			sb = addr;
			@(posedge clk); //To write
			if(counter > 0)
			if (a_out == b_out && a_out == 0); //Before writing, the register values are zero.
			else $finish;
			@(posedge clk); //To read the value written
			if(counter > 0)
			if (a_out == b_out && a_out == value);
			else $finish;
			#12 addr = addr + 1;
			value = value + 1;
		end
		
		//Test 2	
		//Read and check that its value is the last value written.
		@(posedge clk); //Wait to posedge to update the inputs of the uut
		w = 0;
		sa = 4;
		sb = 3;
		@(posedge clk);
		if (a_out == 4 && b_out == 3);
		else $finish;
		
		//Test 3
		//Reset and read 0.
		@(posedge clk); //Wait to posedge to update the inputs of the uut
		w = 1; //not matter
		reset = 1;
		@(posedge clk);
		reset = 0;
		w = 0;
		counter = 0;
		for (counter=0; counter < 8; counter = counter + 1) begin
			@(posedge clk); //Wait to posedge to update the inputs of the uut
			sa = counter;
			sb = counter;
			@(posedge clk);
			if (a_out == 0 && b_out == 0); //Check all values are zero after reseting
			else $finish;
		end
		
		#20 $finish;
	end
		// Clock generator (50 MHz)
	always
		#10	clk = ~clk;
      
endmodule

