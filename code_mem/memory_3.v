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

   Fecha:     05-02-2014
   Revisin:  1

   Autor/es: Carlos López / Yamnia Rodriguez
					
   
	
--*--------------------------------- End auto header, don't touch this line --*/

/*
Programa 3: Aritméticas y salto

Este programa prueba las instrucciones aritméticas y de salto realizando un bucle. Consiste en multiplicar dos números mediante sumas sucesivas

  LDI  R0,$08
  LDI  R1,$10
  LDI  R2,$00
BUCLE:
  SUBI R1,$01
  BRZS FIN
  ADD  R2,R0
  JMP  BUCLE
FIN:
  STS $80,R2
  STOP
*/


module memory(
    output reg [15:0] data,
    input [7:0] addr
    );

always@*
begin


	case (addr)
	8'b00000000: data=16'b1111100000001000; // LDI  R0,$08
	8'b00000001: data=16'b1111100100010000; // LDI  R1,$10
	8'b00000010: data=16'b1111101000000000; // LDI  R2,$00
	8'b00000011: data=16'b1101000100000001; // BUCLE: SUBI R1,$01
  	8'b00000100: data=16'b0011000000000111; // BRZS FIN
	8'b00000101: data=16'b0100001000000000; // ADD  R2,R0
  	8'b00000110: data=16'b0011100000000011; // JMP  BUCLE
	8'b00000111: data=16'b0001001010000000; // FIN: STS $80,R2
	8'b00001000: data=16'b1011100000000000; // STOP
	default:     data=0;



	endcase
end



endmodule
