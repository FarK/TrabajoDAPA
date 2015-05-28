/*
      	LDI R1,$FF
      	LDI R2,$FF
      	LDI R3,$FF
INIT :	LDS R0,$81
LOOP :		SUBI R0,$01
      		STS $80,R0
      		STS $82,R0
      		BRVS $INIT
LOOP2:			SUBI R1,$01
      			STS $83,R1
      			BRZS $LOOP
LOOP3:				SUBI R2,$01
      				BRZS $LOOP2
LOOP4:					SUBI R3,$01
      					BRZS $LOOP3
      					JMP $LOOP4
*/


module memory(
    output reg [15:0] data,
    input [7:0] addr
    );

	`include "../control/opcodes.v"

	always@*
	begin
		case (addr)
		           0: data={LDI,  3'b001, 8'h00}; // LDI  R1,$FF
		           1: data={LDI,  3'b010, 8'hFF}; // LDI  R2,$FF
		           2: data={LDI,  3'b011, 8'hFF}; // LDI  R3,$FF
		/*INIT*/   3: data={LDS,  3'b000, 8'h81}; // LDS  R0,$81
		/*LOOP*/   4: data={SUBI, 3'b000, 8'h01}; // SUBI R0,$01
		           5: data={STS,  3'b000, 8'h82}; // STS  $82,R0
		           6: data={STS,  3'b000, 8'h80}; // STS  $80,R0
		           7: data={BRXX, 3'b010, 8'h03}; // BRVS $INIT
		/*LOOP2*/  8: data={SUBI, 3'b001, 8'h01}; // SUBI R1,$01
		           9: data={STS,  3'b001, 8'h83}; // STS  $83,R1
		/*LOOP3*/ 11: data={SUBI, 3'b010, 8'h01}; // SUBI R2,$01
		          10: data={BRXX, 3'b000, 8'h04}; // BRZS $LOOP
		          12: data={BRXX, 3'b000, 8'h08}; // BRZS $LOOP2
		/*LOOP4*/ 13: data={SUBI, 3'b011, 8'h01}; // SUBI R3,$01
		          14: data={BRXX, 3'b000, 8'h0B}; // BRZS $LOOP3
		          15: data={JMP,  3'b000, 8'h0D}; // JMP  $LOOP4
		     default:
		              data=0;
		endcase
	end

endmodule
