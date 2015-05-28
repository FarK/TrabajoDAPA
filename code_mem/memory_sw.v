`timescale 1ns / 1ps
/*-----------------------------------------------------------------------------
   Este fichero es parte del procesador DAPA2014 diseado en la asignatura
   Diseo de Avanzado de Procesadores y Aplicaciones del
   Master Universitario en Ingeniera de Computadores y Redes de la
   Universidad de Sevilla

   It is distributed under GNU General Public License
   See at http://www.gnu.org/licenses/gpl.html
   Copyright (C) 2013 Paulino Ruiz de Clavijo Vzquez <paulino@dte.us.es>
   You can get more info at http://www.dte.us.es/id2
--------------------------------------------------------------------------------

   Fecha:     18-01-2014
   Revisin:  1

   Autor/es: Yamnia Rodrguez
   Comentarios: Programa 1

--*--------------------------------- End auto header, don't touch this line --*/

/*
	LDS R0,$81
	STS $80,R0
	STOP
*/


module memory(
    output reg [15:0] data,
    input [7:0] addr
    );

	`include "../control/opcodes.v"

	always@*
	begin
		case (addr)
			8'b00000000: data={LDS, 3'b000, 8'h81}; // LDS R0,$81
			8'b00000001: data={STS, 3'b000, 8'h80}; // STS $80,R0
			8'b00000010: data={STOP, 11'd0}; // STOP
			default:
				data=0;
		endcase
	end

endmodule
