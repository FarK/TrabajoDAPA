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
   Comentarios: The procesator registers. 
   
--*--------------------------------- End auto header, don't touch this line --*/
`timescale 1ns / 1ps

module fichero_reg(
   input clk,
	input reset,
   input w,
   input [2:0] sw,
   input [2:0] sa,
   input [2:0] sb,
   input [7:0] c_in,
   output reg [7:0] a_out,
   output reg [7:0] b_out
   );
	
	//Signal values to select a register.
	parameter [2:0]
 		REG_0 = 3'b000,	
 		REG_1 = 3'b001,
 		REG_2 = 3'b010,	
 		REG_3 = 3'b011,
		REG_4 = 3'b100,
		REG_5 = 3'b101,
		REG_6 = 3'b110,
		REG_7 = 3'b111;

	//Registers 
	reg [7:0] reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7;

	// Read to bus a
	always @*
		case (sa)
			REG_0:
				a_out= reg0; //Retraso que simula el retraso de las puertas lgicas. 
									  //De esta manera el testbench funcionar para una simulacin en la etapa de route.
									  //Cuando se sintetice, la herramienta obvia este retraso.
			REG_1:
				a_out=reg1;
			REG_2:
				a_out=reg2;
			REG_3:
				a_out=reg3;
			REG_4:
				a_out=reg4;
			REG_5:
				a_out=reg5;
			REG_6:
				a_out=reg6;
			REG_7:
				a_out=reg7;
      default:
				a_out=reg0;      
		endcase

	// Read to bus b
	always @*
		case (sb)
			REG_0:
				b_out=reg0;
			REG_1:
				b_out=reg1;
			REG_2:
				b_out=reg2;
			REG_3:
				b_out=reg3;
			REG_4:
				b_out=reg4;
			REG_5:
				b_out=reg5;
			REG_6:
				b_out=reg6;
			REG_7:
				b_out=reg7;
      default:
				b_out=reg0;      
		endcase

	//Write a register
	always @(posedge clk)
		if (reset) begin
			reg0 <= 8'b0000000;
			reg1 <= 8'b0000000;
			reg2 <= 8'b0000000;
			reg3 <= 8'b0000000;
			reg4 <= 8'b0000000;
			reg5 <= 8'b0000000;
			reg6 <= 8'b0000000;
			reg7 <= 8'b0000000;
		end
		else if (w) begin
			case (sw)
				REG_0:
					reg0 <= c_in;
				REG_1:
					reg1 <= c_in;
				REG_2:
					reg2 <= c_in;
				REG_3:
					reg3 <= c_in;
				REG_4:
					reg4 <= c_in;
				REG_5:
					reg5 <= c_in;
				REG_6:
					reg6 <= c_in;
				REG_7:
					reg7 <= c_in;
        default:
          reg0 <= c_in;
			endcase
		end

endmodule
