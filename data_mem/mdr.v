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

   Autor/es: carlopmol - Carlos Lopez
   Comentarios:
	w indica si se produce una entrada o una salida
	i_o indica si la operación de entrada o salida se produce
	    sobre el bus interno ib o el bus externo eb
	si w=0 y i_o=0, se vuelca el contenido de MDR en el bus interno ib
	si w=0 y i_o=1  se vuelca el contenido de MDR en el bus externo eb
	si w=1 y i_o=0 se vuelca el bus interno ib en MDR
	si w=1 y i_o=1 se vuelca el bus externo eb en MDR
	
	Reset síncrono

--*--------------------------------- End auto header, don't touch this line --*/
`timescale 1ns / 1ps

module mdr(
    input clk,		//señal de reloj activa por flanco de subida
    input reset,	//señal de reset síncrona
    input io,		// ver comentarios del módulo
    input w,
    inout [7:0] eb,
    inout [7:0] ib
    );
    
    reg [7:0]  r_mdr;     //contiene el valor del registro MDR
    
	 assign ib= (w==0 & io==1 ) ? r_mdr : 8'hZZ ;
   assign eb = (w==0 & io==0) ? r_mdr : 8'hZZ ;
	 
    always @(posedge clk) 
    begin
      if(reset)
	      r_mdr<=8'h00;
      else
      case ({w,io}) 
		    2'b10: r_mdr<=ib;
		    2'b11: r_mdr<=eb;
			  default: r_mdr<=r_mdr;
		  endcase
	  end 

endmodule
