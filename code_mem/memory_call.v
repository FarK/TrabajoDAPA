/*
INIT :	CALL FUNC
      	STOP
FUNC :	RET
*/


module memory(
    output reg [15:0] data,
    input [7:0] addr
    );

	`include "../control/opcodes.v"
	`include "registers.v"
	`include "../control/jump_codes.v"
	parameter
		X3 = 3'd0,
		X8 = 8'd0,
		X11 = 11'd0;

	always@*
	begin
		case (addr)
		           0: data={CALL, X3, 8'h02}; // CALL $02
		           1: data={STOP, X11};       // STOP
		           2: data={RET,  X11};       // RET
		     default:
		              data=0;
		endcase
	end

endmodule
