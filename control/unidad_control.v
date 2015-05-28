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

//`timescale 1ns / 1ps

module unidad_control(
	input clk,
	input reset,
	input v,
	input n,
	input z,
	input c,
	input [15:8] ir15_8,
	output reg ipc,
	output reg wpc,
	output reg rpc,
	output reg isp,
	output reg rsp,
	output reg csp,
	output reg dsp,
	output reg cpc,
	output reg wac,
	output reg i_o,
	output reg wmdr,
	output reg wmar,
	output reg wmem,
	output reg rmem,
	output reg wir,
	output reg ws,
	output reg [3:0] op,
	output reg inm,
	output reg wreg,
	output reg rac
);

reg [7:0] current_state,next_state;

`include "opcodes.v"
`include "states.v"
`include "jump_codes.v"

always @(posedge clk)
begin
	if(reset)
		current_state <= INITIAL;
	else
		current_state <= next_state;
end

always @(*)
begin
	ipc = 0;
	wpc = 0;
	rpc = 0;
	isp = 0;
	rsp = 0;
	csp = 0;
	dsp = 0;
	cpc = 0;
	wac = 0;
	i_o = 0;
	wmdr= 0;
	wmar= 0;
	wmem= 0;
	rmem= 0;
	wir = 0;
	ws  = 0;
	op  = 0;
	inm = 0;
	wreg= 0;
	rac = 0;

	case(current_state)
		INITIAL:
		begin
			csp = 1;
			cpc = 1;
			next_state = FETCH;
		end

		FETCH:
		begin
			wir = 1;
			ipc = 1;
			next_state = DECODE;
		end

		DECODE:
		case (ir15_8[15:11])
			ST:	// Rb -> AC
			begin
				op  = 4'b0111;
				wac = 1;
				next_state = ST1;
			end

			LD:	// Ra -> AC
			begin
				op  = 4'b1111;
				wac = 1;
				next_state = LD1;
			end

			STS:	// IM -> AC
			begin
				inm = 1;
				op  = 4'b1111;
				wac = 1;
				next_state = STS1;
			end

			LDS:	// IM -> AC
			begin
				inm = 1;
				op  = 4'b1111;
				wac = 1;
				next_state = LDS1;
			end

			CALL:	// SP->MAR & SP<-SP-1 & IM->AC
			begin
				rsp  = 1;
				wmar = 1;
				dsp  = 1;
				inm  = 1;
				op   = 4'b1111;
				wac  = 1;
				next_state = CALL1;
			end

			RET:	// SP<-SP+1
			begin
				isp  = 1;
				next_state = RET1;
			end

			BRXX:	// IM->AC & Check cond
			begin
				inm  = 1;
				op   = 4'b1111;
				wac  = 1;
				if(ir15_8[10:8] == EQ && z)
					next_state = BR_JUMP;
				else if(ir15_8[10:8] == CS && c)
					next_state = BR_JUMP;
				else if(ir15_8[10:8] == VS && v)
					next_state = BR_JUMP;
				else if(ir15_8[10:8] == LT && (n ^ v))
					next_state = BR_JUMP;
				else
					next_state = FETCH;
			end

			JMP:	// IM->AC
			begin
				inm  = 1;
				op   = 4'b1111;
				wac  = 1;
				next_state = JMP1;
			end

			ADD:	// Rd + Rf -> AC
			begin
				op  = 4'b1000;
				wac = 1;
				ws = 1;
				next_state = ADD1;
			end

			SUB:	// Rd - Rf -> AC
			begin
				op  = 4'b1010;
				wac = 1;
				ws = 1;
				next_state = SUB1;
			end

			CP:	// Rd -> AC
			begin
				op  = 4'b0110;
				wac = 1;
				next_state = CP1;
			end

			MOV:	// Rf -> AC
			begin
				op   = 4'b1111;
				wac = 1;
				next_state = MOV1;
			end

			CLC:	// SR[C] <- 0
			begin
				op = 4'b0000;
				ws = 1;
				next_state = FETCH;
			end

			SEC:	// SR[C] <- 1
			begin
				op = 4'b0001;
				ws = 1;
				next_state = FETCH;
			end

			ROR:	// AC <- SHR(Rd)
			begin
				op = 4'b0100;
				wac = 1;
				ws = 1;
				next_state = ROR1;
			end

			ROL:	// AC <- SHL(Rd)
			begin
				op = 4'b0101;
				wac = 1;
				ws = 1;
				next_state = ROL1;
			end

			ADDI:	// AC <- Rd + inm
			begin
				op = 4'b1000;
				inm = 1;
				wac = 1;
				ws = 1;
				next_state = ADDI1;
			end

			SUBI:	// AC <- Rd - inm
			begin
				op = 4'b1010;
				inm = 1;
				wac = 1;
				ws = 1;
				next_state = SUBI1;
			end

			CPI:	// Rd - inm
			begin
				op = 4'b1010;
				inm = 1;
				ws = 1;
				next_state = FETCH;
			end

			LDI:	// IM -> AC
			begin
				inm = 1;
				op  = 4'b1111;
				wac = 1;
				next_state = LDI1;
			end

			STOP: next_state = DECODE;
			default: next_state = ERROR; // TODO: CREAR ESTE ESTADO
		endcase

		// EXECUTE
		// ST ---------------------
		ST1:	// AC -> MAR  &  Ra -> AC
		begin
			rac = 1;
			wmar = 1;
			op  = 4'b1111;
			wac = 1;
			next_state = ST2;
		end
		ST2:	// AC -> MDR
		begin
			rac = 1;
			wmdr = 1;
			next_state = ST3;
		end
		ST3:	// MDR -> MEM
		begin
			wmem = 1;
			wmdr = 0;
			i_o = 0;
			next_state = FETCH;
		end

		// LD ---------------------
		LD1:	// AC -> MAR
		begin
			rac = 1;
			wmar = 1;
			next_state = LD2;
		end
		LD2:	// MEM -> MDR
		begin
			rmem = 1;
			wmdr = 1;
			i_o = 1;
			next_state = LD3;
		end
		LD3:	// MDR -> REG
		begin
			i_o = 1;
			wreg = 1;
			next_state = FETCH;
		end

		// STS --------------------
		STS1:	// AC -> MAR  &  REG -> AC
		begin
			rac = 1;
			wmar = 1;
			op  = 4'b0111;
			wac = 1;
			next_state = STS2;
		end
		STS2:	// AC -> MDR
		begin
			rac = 1;
			wmdr = 1;
			next_state = STS3;
		end
		STS3:	// MDR -> MEM
		begin
			wmem = 1;
			wmdr = 0;
			i_o = 0;
			next_state = FETCH;
		end

		// LDS --------------------
		LDS1:	// AC -> MAR
		begin
			rac = 1;
			wmar = 1;
			next_state = LDS2;
		end
		LDS2:	// MEM -> MDR
		begin
			rmem = 1;
			wmdr = 1;
			i_o = 1;
			next_state = LDS3;
		end
		LDS3:	// MDR -> REG
		begin
			i_o = 1;
			wreg = 1;
			next_state = FETCH;
		end

		// CALL -------------------
		CALL1:	// PC->MDR
		begin
			rpc = 1;
			wmdr = 1;
			next_state = CALL2;
		end
		CALL2:	// MDR->MEM & AC->PC
		begin
			wmem = 1;
			rac = 1;
			wpc = 1;
			next_state = FETCH;
		end

		// RET --------------------
		RET1:	// SP->MAR
		begin
			rsp  = 1;
			wmar = 1;
			next_state = RET2;
		end

		RET2:	// MEM->MDR
		begin
			rmem = 1;
			wmdr = 1;
			i_o  = 1;
			next_state = RET3;
		end
		RET3:	// MDR->PC
		begin
			i_o = 1;
			wpc = 1;
			next_state = FETCH;
		end

		// BRXX -------------------
		BR_JUMP:	// AC -> PC
		begin
			rac = 1;
			wpc = 1;
			next_state = FETCH;
		end

		// JMP --------------------
		JMP1:	// AC -> PC
		begin
			rac = 1;
			wpc = 1;
			next_state = FETCH;
		end

		// ADD --------------------
		ADD1:	// AC -> Reg
		begin
			rac  = 1;
			wreg = 1;
			next_state = FETCH;
		end

		// SUB --------------------
		SUB1:	// AC -> Reg
		begin
			rac  = 1;
			wreg = 1;
			next_state = FETCH;
		end

		// CP ---------------------
		CP1:	// AC -> Reg
		begin
			rac  = 1;
			wreg = 1;
			next_state = FETCH;
		end

		// MOV --------------------
		MOV1:	// AC -> Reg
		begin
			rac  = 1;
			wreg = 1;
			next_state = FETCH;
		end

		// ROR --------------------
		ROR1:	// AC -> Reg
		begin
			rac  = 1;
			wreg = 1;
			next_state = FETCH;
		end

		// ROL --------------------
		ROL1:	// AC -> Reg
		begin
			rac  = 1;
			wreg = 1;
			next_state = FETCH;
		end

		// ADDI -------------------
		ADDI1:	// AC -> Reg
		begin
			rac  = 1;
			wreg = 1;
			next_state = FETCH;
		end

		// SUBI -------------------
		SUBI1:	// AC -> Reg
		begin
			rac  = 1;
			wreg = 1;
			next_state = FETCH;
		end

		// LDI --------------------
		LDI1:	// AC -> Reg
		begin
			rac = 1;
			wreg = 1;
			next_state = FETCH;
		end

		default:
			next_state = INITIAL;
	endcase
end

endmodule
