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

--*--------------------------------- End auto header, don't touch this line --*/
`timescale 1ns / 1ps



module pc (
  input clk,
  input reset,
  input w,
  input r,
  input i,
  inout [7:0] pc_inout,
  output[7:0] pc_out
);
	reg [7:0] dir = 8'h00;

	always @(posedge clk)
	begin
		if (reset)
			dir <= 8'h00;
		else if (w)
			dir <= pc_inout;
		else if (i)
			dir<=dir+1;
	end

	assign pc_inout = r ? dir : 8'hZZ;
	assign pc_out = dir;

endmodule
