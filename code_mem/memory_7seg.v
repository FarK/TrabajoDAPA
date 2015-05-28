/*
	LDS R0,$81
	STS $80,R0
	STS $83,R0
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
			8'b00000010: data={STS, 3'b000, 8'h83}; // STS $83,R0
			8'b00000011: data={JMP, 3'b000, 8'h00}; // JMP $0
			8'b00000100: data={STOP, 11'd0}; // STOP
			default:
				data=0;
		endcase
	end

endmodule
