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

   Autor/es: Jos� Carlos Hurtado
   Comentarios:
   
--*--------------------------------- End auto header, don't touch this line --*/
`timescale 1ns / 1ps

module sr_module(
   input clk,
   input reset,
   input v,
   input n,
   input z,
   input c,
   input ws,
   output reg[3:0] sr_out
   );
	
   always @(posedge clk) begin
      if (reset == 1)
         sr_out<= 4'b0000;
      else if (ws == 1)
         sr_out<= {v,n,z,c};
   end
endmodule
