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

   Autor/es: ---
					Yamnia Rodrguez
   Comentarios: R2: Se corrigen conexiones entre mdulos y se declaran cables.

--*--------------------------------- End auto header, don't touch this line --*/
// `timescale 1ns / 1ps
// `default_nettype none

/* Para probar diferentes programas solo hay que cambiar el include */

//`include "memory_1.v"
//`include "memory_2.v"

module unidad_datos(
    input clk,
    input reset,
    output v,
    output n,
    output z,
    output c,
    output wire [15:8] ir15_8,
    input wreg,
    input ws,
    input inm,
    input [3:0] op,
    input wac,
    input rac,
    input isp,
    input dsp,
    input csp,
    input rsp,
    input ipc,
    input wpc,
    input rpc,
    input wir,
    input i_o_,
    input wmdr,
    input wmar,
	 output [7:0] ram_address,
    inout  [7:0] ram_data,
	 input wmem,
	 input rmem,
	 input cpc
    );


    // voy a usar la nomenclatura _nombre para indicar que se trata de wire
    wire [7:0] bus_interno;  //Bus para conectar Registros, Memoria, PC, SP, AC
    // wire [7:0] _mar_out;	//conecta MAR con memoria_ram.addr
    //assign ram_address=_mar_out;  //conexion al exterior para mapeo de dispositivos externos
    //assign ram_data=eb;     //conexion al exterior para enviar datos a dispositivos externos
    wire [7:0] _pc_out;  //Conecta PC con memoria de código
    wire [15:0] _ir_out; //conecta IR con UC, ALU, REGS
    wire [7:0] _b_mux;  //conecta mux(inm) con ALU
    wire _c, _z, _n, _v; //conecta flags de ALU con SR
    wire [7:0] _a_out;	//conecta REGS con mux de entrada a ALU

    // wire [7:0] d_out;
    wire [15:0] data;
    // wire [15:0] ir_in;
    //wire [3:0] sr_out;
    // wire [7:0] b;
    // wire [3:0] s_in;
    wire [7:0] result;
    wire [7:0] b_out;

    ///// PROGRAMS /////
    memory ud_memory(.data(data),.addr(_pc_out));
    //memory_1 ud_memory_1(.data(data),.addr(_pc_out));
    //////////

    mar ud_mar (.clk(clk), .reset(reset),.wmar(wmar),.mar_in(bus_interno),.mar_out(ram_address) );
    mdr ud_mdr (.clk(clk), .reset(reset),.io(i_o_), .w(wmdr), .eb(ram_data), .ib(bus_interno));
    pc ud_pc ( .clk(clk), .reset(cpc), .w(wpc), .r(rpc), .i(ipc), .pc_inout(bus_interno), .pc_out(_pc_out));
    sp ud_sp ( .clk(clk), .reset(reset), .c(csp), .i(isp), .d(dsp), .r(rsp), .sp_out(bus_interno));
    ac ud_ac(.ac_in(result), .clk(clk), .reset(reset), .wac(wac), .rac(rac),.ac_out(bus_interno));
    memoria_ram ud_memoria_ram(.clk(clk),.w(wmem),.r(rmem),.addr(ram_address), .d_out(ram_data));
    ir ud_ir (	.clk(clk), .reset(reset), .w(wir), .ir_in(data), .ir_out(_ir_out));
    assign ir15_8=_ir_out[15:8];

    // MAL: sr_module ud_sr_module(.clk(clk),.reset(reset),.v(_v),.n(_n),.z(_z),.c(_c),.ws(ws), .sr_out({v,n,z,c}) );
    //sr_module ud_sr_module(.clk(clk),.reset(reset),.v(_v),.n(_n),.z(_z),.c(_c),.ws(ws), .sr_out(sr_out) );

    sr_module ud_sr_module(
    	.clk(clk),
    	.reset(reset),
    	.v(_v),
    	.n(_n),
    	.z(_z),
    	.c(_c),
    	.ws(ws),
    	.sr_out({v,n,z,c})
    );

    // Multiplexor de entrada a bus "b" de la ALU
    assign _b_mux = inm ? _ir_out[7:0] : _a_out;

    alu ud_alu (.a(b_out), .b(_b_mux), .s_in({v,n,z,c}), .op(op), .s_c(_c), .s_z(_z), .s_n(_n),.s_v(_v), .result(result)); //antes: .result(ac_in)

    // Cableamos los flags de la ALU a los puertos que salen hacia la UC
    //assign c=_c; assign z=_z; assign v=_v;	assign n=_n;
    /*
    assign c=sr_out[0];
    assign v=sr_out[1];
    assign n=sr_out[2];
    assign z=sr_out[3];
	 */


    fichero_reg ud_reg(
	    .clk(clk),.reset(reset),.w(wreg),.sw(_ir_out[10:8]),.sa(_ir_out[2:0]),
	    .sb(_ir_out[10:8]),.c_in(bus_interno),.a_out(_a_out),.b_out(b_out));


    endmodule
