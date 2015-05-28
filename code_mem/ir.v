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
   Revisión:  1

   Autor/es: Indira Lanza
   Comentarios:
   
--*--------------------------------- End auto header, don't touch this line --*/
`timescale 1ns / 1ps


module ir (
  input clk,   // reloj, activo en flanco de subida
  input reset, // reset, asincrono, activo a nivel alto
  input w,     
  input [15:0] ir_in,     
  output [15:0] ir_out

);


  reg [15:0] ir;  // iniciado a 0 
  


  always @(posedge clk) 
  begin
    if (reset==1)  // reset
      ir <= 0;
    else         // flanco alto de reloj
	    if (w==1)
         ir <= ir_in;
            
    
  end
  assign ir_out=ir;
  
endmodule
