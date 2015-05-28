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

`include "code_mem/memory_sd.v"
// `include "code_mem/memory_test.v"
//`include "code_mem/memory_call.v"
//`include "code_mem/memory_counter.v"
// `include "code_mem/memory_7seg.v"
// `include "code_mem/memory_sw.v"
// `include "code_mem/memory_1.v"

/* Para probar diferentes programas solo hay que cambiar el include */

/* Módulo top para conexión a los periféricos
  de la placa Basys 2 */

module cs2014(
  input ext_clk,
  input [7:0] sw_in,
  output dp_out,
  output [3:0] an_out,
  output [6:0] seg_out,
  output [7:0] leds_out,
  input [3:0] btn_in,
  input  miso,
  output mosi,
  output sclk,
  output ss
    );

  wire reset;
  wire [7:0] ram_address;
  wire [7:0] ram_data;

  // El procesador se reseta pulsando el botón 0
  assign reset = btn_in[0];

  // Se debe instanciar la unidad de control y la unidad de datos e
  // interconectar entre sí.

   wire v;
   wire n;
   wire z;
   wire c;
   wire [15:8] ir15_8;
   wire ipc;
   wire wpc;
   wire rpc;
   wire isp;
   wire rsp;
   wire csp;
   wire dsp;
   wire cpc;
   wire wac;
   wire i_o;
   wire wmdr;
   wire wmar;
   wire wmem;
   wire rmem;
   wire wir;
   wire ws;
   wire [3:0] op;
   wire inm;
   wire wreg;
   wire rac;

   // I/O
   wire enLED;
   wire enSW;
   wire enBTN;
   wire en7seg;
   wire en7segMSB;
   wire en7segLSB;
   wire ensdcm;
   wire sdcm_addr;
   wire mem_io;


unidad_control u_control (
    .clk(ext_clk),
    .reset(reset),
    .v(v),
    .n(n),
    .z(z),
    .c(c),
    .ir15_8(ir15_8),
    .ipc(ipc),
    .wpc(wpc),
    .rpc(rpc),
    .isp(isp),
    .rsp(rsp),
    .csp(csp),
    .dsp(dsp),
    .cpc(cpc),
    .wac(wac),
    .i_o(i_o),
    .wmdr(wmdr),
    .wmar(wmar),
    .wmem(wmem),
    .rmem(rmem),
    .wir(wir),
    .ws(ws),
    .op(op),
    .inm(inm),
    .wreg(wreg),
    .rac(rac)
    );

unidad_datos u_datos(
    .clk(ext_clk),
    .reset(reset),
    .v(v),
    .n(n),
    .z(z),
    .c(c),
    .ir15_8(ir15_8),
    .wreg(wreg),
    .ws(ws),
    .inm(inm),
    .op(op),
    .cpc(cpc),
    .wac(wac),
    .rac(rac),
    .isp(isp),
    .dsp(dsp),
    .csp(csp),
    .rsp(rsp),
    .ipc(ipc),
    .wpc(wpc),
    .rpc(rpc),
    .wir(wir),
    .i_o_(i_o),
    .wmdr(wmdr),
    .wmar(wmar),
    .wmem(wmem),
    .rmem(rmem & ~mem_io),	// MUX IO
    .ram_address(ram_address),
    .ram_data(ram_data)
    );


// Entrada salida
perisph_select inst_perisph_select(
	.addr(ram_address),
	.enLED(enLED),
	.enSW(enSW),
	.enBTN(enBTN),
	.en7seg(en7seg),
	.en7segMSB(en7segMSB),
	.en7segLSB(en7segLSB),
	.sdcm_addr(sdcm_addr),
	.ensdcm(ensdcm),
	.mem_io(mem_io)
);

port_switches_basys2 inst_switches (
	.r(enSW),
	.clk(ext_clk),
	.enable(enSW),
	.port_out(ram_data),
	.switches_in(sw_in)
);

port_buttons inst_buttons (
	.r(enBTN),
	.clk(ext_clk),
	.enable(enBTN),
	.port_out(ram_data),
	.buttons_in(btn_in[3:1])
);

port_leds_basys2 inst_leds (
	.clk(ext_clk),
	.w(wmem),
	.enable(enLED),
	.port_in(ram_data),
	.leds_out(leds_out)
);

port_display_basys2 inst_display(
	.clk(ext_clk),
	.enable(en7seg),
	.digit_in(ram_data),
	.w_msb(en7segMSB),
	.w_lsb(en7segLSB),
	.seg_out(seg_out),
	.dp_out(dp_out),
	.an_out(an_out)
);

port_sdcm u_port_sdcm(
	.clk(ext_clk),
	.reset(reset),
	.enable(ensdcm),
	.addr(sdcm_addr),
	.w_strobe(wmem),
	.dout(ram_data),
	.din(ram_data),

	.miso(miso),
	.mosi(mosi),
	.sclk(sclk),
	.ss(ss)
);
endmodule
