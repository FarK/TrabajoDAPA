`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       Universidad de Sevilla
// Engineer:      Miguel Angel Rodriguez Jodar ( rodriguj@atc.us.es )
//
// Create Date:   22:10:52 12/14/2013
// Design Name:   sp
// Module Name:   C:/Users/rodriguj/Documents/dapa/trunk//sp_tb.v
// Project Name:  testbench_sp_ise
// Target Device:
// Tool versions:
// Description:
//
// Verilog Test Fixture created by ISE for module: sp
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////

module sp_tb;

	// Inputs
	reg clk;
	reg reset;
	reg c;
	reg i;
	reg d;
	reg r;

	// Outputs
	wire [7:0] sp_out;

	// Instantiate the Unit Under Test (UUT)
	sp uut (
		.clk(clk), 
		.reset(reset), 
		.c(c), 
		.i(i), 
		.d(d), 
		.r(r), 
		.sp_out(sp_out)
	);
   
   task esperar_ciclos (input integer ciclos);
   begin     
     repeat(ciclos) @(posedge clk);
   end
   endtask

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		c = 0;
		i = 0;
		d = 0;
		r = 1;

		// un poco de reset
		esperar_ciclos(2);
		reset = 0;
        
		// Add stimulus here
      c = 1;
      esperar_ciclos(4);
		c = 0;
      i = 1;
      esperar_ciclos(4);
      d = 1;
      esperar_ciclos(4);
      i = 0;
      esperar_ciclos(4);
      r = 0;
      esperar_ciclos(4);
      r = 1;
      esperar_ciclos(4);
      d = 0;
      esperar_ciclos(4);
      
      $finish;
	end
      
   always begin
     clk = #5 !clk;  // un reloj de periodo 10ns, para simulacion
   end
      
endmodule

