`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:00:06 01/07/2014
// Design Name:   alu
// Module Name:   C:/Users/Manuel Dominguez/Desktop/dapa/alu/alu_tb.v
// Project Name:  alu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module alu_tb;

	// Inputs
	reg [7:0] a;
	reg [7:0] b;
	reg [3:0] s_in;
	reg [3:0] op;

	// Outputs
	wire s_c;
	wire s_z;
	wire s_n;
	wire s_v;
	wire [7:0] result;

	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.a(a), 
		.b(b), 
		.s_in(s_in), 
		.op(op), 
		.s_c(s_c), 
		.s_z(s_z), 
		.s_n(s_n), 
		.s_v(s_v), 
		.result(result)
	);

	initial
		begin
		// Initialize Inputs
		a = 0;
		b = 1;
		s_in = 0;
		op = 0;
		
/*		#5; op = 1;
		#5; op = 2;
		#5; op = 3;
		#5; op = 4;
		#5; op = 5;
		#5; op = 6;
		#5; op = 7;
		#5; op = 8;
		#5; op = 9;*/
		#5; op = 10;
/*		#5; op = 11;
		#5; op = 12;
		#5; op = 13;
		#5; op = 14;
		#5; op = 15;*/

		
		/*#5; a = 220;
		b = 100;
		op = 0;
		
		#5; op = 1;
		#5; op = 2;
		#5; op = 3;
		#5; op = 4;
		#5; op = 5;
		#5; op = 6;
		#5; op = 7;
		#5; op = 8;
		#5; op = 9;
		#5; op = 10;
		#5; op = 11;
		#5; op = 12;
		#5; op = 13;
		#5; op = 14;
		#5; op = 15;

		#5; a = -120;
		b = 200;
		op = 0;
		
		#5; op = 1;
		#5; op = 2;
		#5; op = 3;
		#5; op = 4;
		#5; op = 5;
		#5; op = 6;
		#5; op = 7;
		#5; op = 8;
		#5; op = 9;
		#5; op = 10;
		#5; op = 11;
		#5; op = 12;
		#5; op = 13;
		#5; op = 14;
		#5; op = 15;
		
		#5; a = 220;
		b = -100;
		op = 0;
		
		#5; op = 1;
		#5; op = 2;
		#5; op = 3;
		#5; op = 4;
		#5; op = 5;
		#5; op = 6;
		#5; op = 7;
		#5; op = 8;
		#5; op = 9;
		#5; op = 10;
		#5; op = 11;
		#5; op = 12;
		#5; op = 13;
		#5; op = 14;
		#5; op = 15;
		
		#5; a = -120;
		b = -100;
		op = 0;
		
		#5; op = 1;
		#5; op = 2;
		#5; op = 3;
		#5; op = 4;
		#5; op = 5;
		#5; op = 6;
		#5; op = 7;
		#5; op = 8;
		#5; op = 9;
		#5; op = 10;
		#5; op = 11;
		#5; op = 12;
		#5; op = 13;
		#5; op = 14;
		#5; op = 15;*/

		// Simulation finishes at t=100
		#100; $finish;

		end
      
endmodule

