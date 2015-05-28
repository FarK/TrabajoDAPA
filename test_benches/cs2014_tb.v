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

   Autor/es:
   Comentarios:

--*--------------------------------- End auto header, don't touch this line --*/
`timescale 1ns / 1ps


module cs2014_tb;

  // Inputs
  reg ext_clk;
  reg reset;
  reg [7:0] sw;
  reg [3:0] btn;

  // Outputs
  wire dp;
  wire [3:0] an;
  wire [6:0] seg;
  wire [7:0] leds;


  initial begin
  	$dumpfile("cs2014_tb.vcd");
  	$dumpvars(0,cs2014_tb);
  end

   always begin
      #50 ext_clk = ~ext_clk;
   end

  // Instantiate the Unit Under Test (UUT)
  cs2014 uut (
    .ext_clk(ext_clk),
    .sw_in(sw),
    .dp_out(dp),
    .an_out(an),
    .seg_out(seg),
    .leds_out(leds),
    .btn_in(btn)
  );

  initial begin
    // Initialize Inputs
    ext_clk = 0;
    // Para hacer reset hay que pulsar 2 botones
    btn=4'b0001;

    sw = 8'h11;

    // Wait 100 ns for global reset to finish
    #100;
    btn=4'b0100;
	 
	 repeat(10)
	 begin
		 #2000
		 btn=4'b0000;
		 #2000
		 btn=4'b0100;
	 end

    // Add stimulus here
    #10000;
    $finish;

  end

endmodule

