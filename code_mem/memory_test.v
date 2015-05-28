module memory(
    output reg [15:0] data,
    input [7:0] addr
    );

	`include "../control/opcodes.v"
	`include "registers.v"
	`include "../control/jump_codes.v"
	`include "../perisph/perisph_addrs.v"

	parameter
		// BLOCK  = 8'd6,
		BYTE   = 8'd3,
		// WAIT   = 8'd14,
		// READY  = 8'd18,
		SUB_R7 = 8'd7,
		BLOCKI = 8'd10;

	parameter
		X3 = 3'd0;

	always@*
	begin
		case (addr)
		           0:  data = {LDI, R0, 8'h00};
		           1:  data = {LDI, R6, 8'h00};
		           2:  data = {LDI, R7, 8'h02};

		/*BYTE*/   3:  data = {ADDI, R0, 8'h01};

		           4:  data = {SUBI, R6, 8'h01};
		           5:  data = {BRXX, EQ, SUB_R7};
		           6:  data = {JMP, X3, BYTE};
		/*SUB_R7*/ 7:  data = {SUBI, R7, 8'h01};
		           8:  data = {BRXX, EQ, BLOCKI};
		           9: data = {JMP, X3, BYTE};

		/*BLOCKI*/ 10: data = {LDI, R7, 8'h02};
		           11: data = {JMP, X3, BYTE};
		     default:
		              data=0;
		endcase
	end

endmodule
