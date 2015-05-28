`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Indira Lanza
//
// Create Date:   12:18:31 01/14/2014
// Design Name:   ir
// Module Name:   E:/Master Universitario Ingenieria de Computadores y Redes/DAPA/Indira DAPA Proyecto/ProyectoIR/ir_tb.v
// Project Name:  ProyectoIR
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ir
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ir_tb;

	// Inputs
	reg clk;
	reg reset;
	reg w;
	reg [15:0] ir_in;

	// Outputs
	wire [15:0] ir_out;

	// Instantiate the Unit Under Test (UUT)
	ir uut (
		.clk(clk), 
		.reset(reset), 
		.w(w), 
		.ir_in(ir_in), 
		.ir_out(ir_out)
	);

	initial begin
		$dumpfile("ir_tb.vcd");
		$dumpvars(0,ir_tb);
	end

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		w = 0;
		ir_in = 16'h00;

		// Wait 100 ns for global reset to finish
		repeat(3) @(posedge clk); 
      reset =1;

		
	  @(posedge clk); //se espera solo un flanco del reloj para que el procesador lo ejecute lo mas rapido posible
     reset =0;
	 
	  @(posedge clk); 
	  ir_in = 16'h01;
	 
	  repeat(3) @(posedge clk); 
	  w=1;
	  @(posedge clk);
	  w=0;
	


	 
	 @(posedge clk);
	 $finish;
		
        
		// Add stimulus here

	end
	
	 always begin
     clk = #5 !clk;  // un reloj de periodo 10ns, para simulacion
   end
      
      
endmodule

