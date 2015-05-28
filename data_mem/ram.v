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

   Autor/es: Yamnia Rodrguez
   Comentarios:
   
--*--------------------------------- End auto header, don't touch this line --*/
`timescale 1ns / 1ps
	

module memoria_ram(
  input clk,
  input w,
  input r,
  input [7:0] addr,
  inout [7:0] d_out);
  
  
  
  reg [7:0] ram [(2**8)-1:0]; 
  
  initial
	ram[8'h83] = 8'h22;
  
  always @(posedge clk)
		if (w)
			ram[addr] <= d_out;
  
  assign d_out = r ? ram[addr] : 8'hZZ;

endmodule
