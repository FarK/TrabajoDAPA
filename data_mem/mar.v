/*-----------------------------------------------------------------------------
   Este fichero es parte del procesador DAPA2014 dise�ado en la asignatura
   Dise�o de Avanzado de Procesadores y Aplicaciones del 
   Master Universitario en Ingenier�a de Computadores y Redes de la
   Universidad de Sevilla
   
   It is distributed under GNU General Public License
   See at http://www.gnu.org/licenses/gpl.html 
   Copyright (C) 2013 Paulino Ruiz de Clavijo V�zquez <paulino@dte.us.es>
   You can get more info at http://www.dte.us.es/id2
--------------------------------------------------------------------------------

   Fecha:     04-12-2013
   Revisi�n:  1

   Autor/es:    Tom�s Jes�s Rubio Campos, Miguel Angel Rodriguez Jodar
   Comentarios: La se�al de entrada seg�n el dibujo se llama wmar
   
--*--------------------------------- End auto header, don't touch this line --*/
`timescale 1ns / 1ps

module mar(
    input clk,
    input reset,
    input wmar,
    input [7:0] mar_in,
    output [7:0] mar_out
    );
    
	 reg [7:0] mar = 8'h00;	 
	 assign mar_out = mar;
	 
	 always @(posedge clk) begin
		if (reset == 1'b1)
			mar <= 8'h00;
		else if (wmar == 1'b1)
			mar <= mar_in;
	 end
endmodule
