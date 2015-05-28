`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:22:56 01/07/2014
// Design Name:   mdr
// Module Name:   /home/clm/Documentos/per/master US/asignaturas/DAP/projecto trabajo/procesador/mdr_tb.v
// Project Name:  procesador
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mdr
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mdr_tb;

	// Inputs
	reg clk;
	reg reset;
	reg io;
	reg w;

	// Bidirs
	wire [7:0] eb;
	wire [7:0] ib;

	// Instantiate the Unit Under Test (UUT)
	mdr uut (
		.clk(clk), 
		.reset(reset), 
		.io(io), 
		.w(w), 
		.eb(eb), 
		.ib(ib)
	);

  reg [7:0] reg_eb;
	reg [7:0] reg_ib;
	
	assign eb=reg_eb; //hago esto porque no puedo asignar a un puerto inout un valor en ...
	assign ib=reg_ib; //... un bloque procedural. En lugar de trabajar sobre eb/ib lo hago
						   //... sobre reg_eb y reg_ib que son registros y si lo permiten
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
    w = 0;
  
		io = 0;
    
    reg_eb = 8'hzz;
		reg_ib = 8'hzz;

		// Wait 100 ns for global reset to finish
		repeat(3) @(posedge clk);
		reset =1;
    @(posedge clk); 
    reset =0;
    

		// escribimos desde el bus externo hacia MDR
    repeat(10) @(posedge clk);
		w=1; io=1; 
    reg_eb = 8'h33;
    reg_ib = 8'hzz;
    @(posedge clk) ;
		// leemos en bus interno el valor de MDR
		w=0; io=1;	
		repeat(10) @(posedge clk);
		// escribimos desde el bus interno hacia MDR
		reg_ib=8'h11;
		w=1; io=0; 
    @(posedge clk);
		
		// leemos en bus externo el valor de MDR
		w=0; io=0;
		repeat(10)  @(posedge clk); 
      $finish;
	end
	
	parameter PERIOD = 50;

   always begin
      clk = 1'b0;
      #(PERIOD/2) clk = 1'b1;
      #(PERIOD/2);
   end  
      
endmodule

