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

   Fecha:     04-12-2013
   Revisin:  2

   Autor/es: Juan Braga
					Yamnia
   Comentarios: R2: Se añade @* en el always
	
--*--------------------------------- End auto header, don't touch this line --*/

/*
	LDI R0,$AA
	STS $80,R0
	LDS R1,$83
	STS $81,R1
	STOP
*/


module memory(
    output reg [15:0] data,
    input [7:0] addr
    );

always@*
begin
	case (addr)
	8'b00000000: data=16'b1111100010101010; // LDI R0,$AA
	8'b00000001: data=16'b0001000010000000; // STS $80,R0
	8'b00000010: data=16'b0001100110000011; // LDS R1,$83 //Rf (10-8 de IP) ? MEM[addr] (en 7-0 de IR)
	8'b00000011: data=16'b0001000110000001; // STS $81,R1
	8'b00000100: data=16'b1011100000000000; // STOP
	default:   data=0;

	endcase
end



endmodule
