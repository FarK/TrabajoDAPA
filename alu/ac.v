`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:54:18 12/11/2013 
// Design Name: 
// Module Name:    ac 
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
/*-----------------------------------------------------------------------------
   Este fichero es parte del procesador DAPA2014 diseñado en la asignatura
   Diseño de Avanzado de Procesadores y Aplicaciones del 
   Master Universitario en Ingeniería de Computadores y Redes de la
   Universidad de Sevilla
   
   It is distributed under GNU General Public License
   See at http://www.gnu.org/licenses/gpl.html 
   Copyright (C) 2013 Paulino Ruiz de Clavijo Vázquez <paulino@dte.us.es>
   You can get more info at http://www.dte.us.es/id2
--------------------------------------------------------------------------------

   Fecha:     04-12-2013
   Revisión:  2

   Autor/es: --
					Yamnia Rodr�guez
   Comentarios:
   
--*----------------- ---------------- End auto header, don't touch this line --*/
`timescale 1ns / 1ps

module ac(
    input [0:7] ac_in,
    input clk,
    input reset,
    input wac,
    input rac,
    output [7:0] ac_out
    );
	
	reg [7:0] aux = 8'h00;
	reg [7:0] sal;
	
	// Reset y escritura en acumulador controlados por flanco positivo de reloj
	always @(posedge clk) 
	begin
			if (reset)
				aux <= 8'h00;
		   else if (wac) begin
				aux <= ac_in;
			end					
   end
	
//	Lectura acumulador as�ncrona
		always @(*)
		   begin
				if (rac) 
					sal <= aux;					
				else
		         sal <= 8'hZZ;
			end

		
			assign ac_out = sal;
		
endmodule


	
	
	

