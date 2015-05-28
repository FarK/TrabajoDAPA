`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:44:40 12/15/2013 
// Design Name: 
// Module Name:    ac_tb 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ns

module ac_tb();
    
    reg [0:7] ac_in;
    reg clk, reset, wac, rac;
    wire [7:0] ac_out;
	 
	 ac utt(.ac_in(ac_in), .clk(clk), .reset(reset), .wac(wac), .rac(rac), .ac_out(ac_out));
	 
	 initial
	 begin
	 
	   // Inicializamos las entradas
		ac_in = 8'h01;
		reset = 0;
		wac = 0;
		rac = 0;	
		
		// Reseteamos el sistema
	   repeat(3) @(posedge clk);
		reset =1;
      @(posedge clk); 
      reset =0;
		
		// Realizamos distintas operaciones para el acumulador 
		@(posedge clk); rac = 1;
		@(posedge clk); rac = 0;		
		@(posedge clk); reset = 1;
		@(posedge clk); reset = 0;
		@(posedge clk); wac = 1;
		@(posedge clk); wac = 0;
		@(posedge clk); rac = 1;
		@(posedge clk); rac = 0;
		
      // En el bus de entrada colocamos un 2 y leemos el contenido del acumulador
		@(posedge clk); ac_in = 8'h02;
		@(posedge clk); rac = 1;
		@(posedge clk); rac = 0;
		
		// Realizamos distintas operaciones para el acumulador 
		@(posedge clk); reset = 1;
		@(posedge clk); reset = 0;
	   @(posedge clk); rac = 1;
		@(posedge clk); rac = 0;		
		@(posedge clk); wac = 1;
		@(posedge clk); wac = 0;
	   @(posedge clk); rac = 1;
		@(posedge clk); rac = 0;
		
		// Activamos las dos señales a la vez
		@(posedge clk); ac_in = 8'h03;
	   @(posedge clk); rac = 1;
		@(posedge clk); wac = 1;

		// Simulation finishes at t=100
		repeat(10)  @(posedge clk); 
		$finish;
	 end


   //	Configuración del reloj 
	parameter PERIOD = 50;
   always begin
      clk = 1'b0;
      #(PERIOD/2) clk = 1'b1;
      #(PERIOD/2);
   end  
      
endmodule
