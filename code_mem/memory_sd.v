module memory(
    output reg [15:0] data,
    input [7:0] addr
    );

	`include "../control/opcodes.v"
	`include "registers.v"
	`include "../control/jump_codes.v"
	`include "../perisph/perisph_addrs.v"

	parameter
		BLOCK   = 8'd11,
		BYTE    = 8'd19,
		SUB_R7  = 8'd28,
		BLOCKI  = 8'd31,
		IR1     = 8'd35,
		IR2     = 8'd38,
		IR3     = 8'd41,
		END_BI  = 8'd42,
		WAIT_R  = 8'd43,
		END_WR  = 8'd48,
		WAIT_B  = 8'd49,
		BTN_OFF = 8'd53,
		END_WB  = 8'd57;

	parameter
		X3  = 3'd0,
		X11 = 11'd0;

	always@*
	begin
		case (addr)
		           0:  data = {LDI, R0, 8'h00};
		           1:  data = {LDI, R1, 8'h00};
		           2:  data = {LDI, R2, 8'h00};
		           3:  data = {LDI, R3, 8'h00};
		           4:  data = {LDI, R6, 8'h00};
		           5:  data = {LDI, R7, 8'h02};

		           6:  data = {LDI, R5, 8'h00};
		           7:  data = {STS, R5, LED_ADDR};
		           8:  data = {STS, R5, SSEG_ADDR_LSB};
		           9:  data = {STS, R5, SSEG_ADDR_MSB};

		           10: data = {CALL, X3, WAIT_R};

		/*BLOCK*/  11: data = {LDI, R4, 8'h01};
		           12: data = {STS, R4, SDCM_DADDR};
		           13: data = {STS, R0, SDCM_DADDR};
		           14: data = {STS, R1, SDCM_DADDR};
		           15: data = {STS, R2, SDCM_DADDR};
		           16: data = {STS, R3, SDCM_DADDR};

		           17: data = {CALL, X3, WAIT_R};

		           18: data = {LDI, R4, 8'h02};
		/*BYTE*/   19: data = {STS, R4, SDCM_DADDR};

		           20: data = {CALL, X3, WAIT_R};
		           21: data = {CALL, X3, WAIT_B};

		           22: data = {LDS, R5, SDCM_DADDR};
		           23: data = {STS, R5, SSEG_ADDR_LSB};

		           24: data = {STS, R6, SSEG_ADDR_MSB};
		           25: data = {SUBI, R6, 8'h01};
		           26: data = {BRXX, EQ, SUB_R7};
		           27: data = {JMP, X3, BYTE};
		/*SUB_R7*/ 28: data = {SUBI, R7, 8'h01};
		           29: data = {BRXX, EQ, BLOCKI};
		           30: data = {JMP, X3, BYTE};

		/*BLOCKI*/ 31: data = {LDI, R7, 8'h02};
		           32: data = {ADDI, R0, 8'h01};
		           33: data = {BRXX, EQ, IR1};
		           34: data = {JMP, X3, END_BI};
		/*IR1*/    35: data = {ADDI, R1, 8'h01};
		           36: data = {BRXX, EQ, IR2};
		           37: data = {JMP, X3, END_BI};
		/*IR2*/    38: data = {ADDI, R2, 8'h01};
		           39: data = {BRXX, EQ, IR3};
		           40: data = {JMP, X3, END_BI};
		/*IR3*/    41: data = {ADDI, R3, 8'h01};
		/*END_BI*/ 42: data = {JMP, X3, BLOCK};


		/*WAIT_R*/ 43: data = {LDS, R5, SDCM_SADDR};
		           44: data = {STS, R5, LED_ADDR};
		           45: data = {SUBI, R5, 8'h01};
		           46: data = {BRXX, EQ, END_WR};
		           47: data = {JMP, X3, WAIT_R};
		/*END_WR*/ 48: data = {RET, X11};

		/*WAIT_B*/ 49: data = {LDS, R5, BTN_ADDR};
		           50: data = {SUBI, R5, 8'h02};
		           51: data = {BRXX, EQ, BTN_OFF};
		           52: data = {JMP, X3, WAIT_B};

		/*BTN_OFF*/53: data = {LDS, R5, BTN_ADDR};
		           54: data = {SUBI, R5, 8'h00};
		           55: data = {BRXX, EQ, END_WB};
		           56: data = {JMP, X3, BTN_OFF};
		/*END_WB*/ 57: data = {RET, X11};
		     default:
		              data=0;
		endcase
	end

endmodule
