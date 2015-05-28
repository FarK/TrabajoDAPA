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

   Fecha:     14-12-2013
   Revisión:  1

   Autor/es: Miguel Angel Rodriguez Jodar ( rodriguj@atc.us.es )
   Comentarios:

--*--------------------------------- End auto header, don't touch this line --*/
`timescale 1ns / 1ps

module sp (
  input clk,   // reloj, activo en flanco de subida
  input reset, // reset, asincrono, activo a nivel alto
  input c,     // borrado sincrono de SP
  input i,     // incremento sincrono de SP
  input d,     // decremento sincrono de SP
  input r,     // output enable, asincrono, para volcar SP a SP_OUT
  output [7:0] sp_out

);
  reg [7:0] sp = 8'hFF;  // iniciado a FF por configuracion
  assign sp_out = r? sp : 8'hZZ;  // control del triestado

  always @(posedge clk) begin
    if (reset==1'b1)  // reset?
      sp <= 8'hFF;
    else begin        // flanco alto de reloj
      case ({c,i,d})
        3'b100 : sp <= 8'hff;   // borrado
        3'b010 : sp <= sp + 1;  // incremento
        3'b001 : sp <= sp - 1;  // decremento
      endcase                   // resto de casos, el registro no varia
    end
  end
endmodule
