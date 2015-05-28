/*
 * Description: Glue logic for picoblaze interface
 * ADDR select internal registers/operations as follow:
 *    WRITE_STROBE=1     ADDR  Desc.
 *                         X   Start operation or byte is received
 *                             (see operation 0x01)
 *    READ_STROBE=1      ADDR  Desc.
 *                         0   Read STATUS_REG
 *                         1   Read SDCARD byte out
 *
 *                +---bit2-----+----bit1----+-----bit0----+
 *   STATUS_REG:  |sdhost_busy | sdhost_err | byte_ready  |
 *                +------------+------------+-------------+
 *
 *   Operations:   VAL  Operation
 *                 0x01 Start send 32bits ADDR, after this 4 bytes are expected
 *                      in next 4 writes on port
 *                 0x02 Start read new block using internal ADDR[31:0] reg
 *                 0x04 Read the next byte of the same block
 *
 *   Operation sequence: 0x01, 0xAA, 0xAA, 0xAA, 0xAA, 0x02 (wait..byte_ready),
 *                       0x04, (wait..byte_ready)...
 */

module port_sdcm(
	input  clk,
	input  reset,
	input  enable,

	input  addr,
	input  w_strobe,
	input  [7:0] din,
	output reg [7:0] dout,

	input  miso,
	output mosi,
	output sclk,
	output ss
);
	parameter
		IDLE   = 0,
		ADDR0  = 1,
		ADDR1  = 2,
		ADDR2  = 4,
		ADDR3  = 8,
		WAIT   = 16,
		BYTE   = 32;

	reg [5:0] state, next_state;

	reg addrByte0;
	reg addrByte1;
	reg addrByte2;
	reg addrByte3;
	reg [7:0] addrByte;
	wire [2:0]status_reg;
	// reg [7:0] data_out;

	wire _busy;
	wire _err;
	reg _r_block = 0;
	reg _r_byte;
	reg [31:0] _block_addr = 32'd0;
	wire [7:0] _data_out;

	sdspihost u_sdspihost(
		.clk(clk),
		.reset(reset),
		.busy(_busy),
		.err(_err),
		.r_block(_r_block),
		.r_byte(_r_byte),
		.block_addr(_block_addr),
		.data_out(_data_out),
		.miso(miso),
		.mosi(mosi),
		.sclk(sclk),
		.ss(ss)
	);

	// Registro de estado
	assign status_reg[0] = (!_err) && (!_busy);
	assign status_reg[1] = _err;
	assign status_reg[2] = _busy;

	// assign dout = (enable && !w_strobe)? data_out : 8'hZZ;

	// Multiplexacion de la salida
	always @(*)
	begin
		if(enable && !w_strobe && !reset)
		begin
			if(addr == 1)
				dout <= _data_out;
			else
				dout <= {5'b00000, status_reg};
		end else
			dout <= 8'hZZ;
	end

	// Maquina de estados
	// Parte secuencial
	always @(posedge clk)
	begin
		if(reset)
			state <= IDLE;
		else
			state <= next_state;
	end

	// Parte combinacional
	always @(state, din, w_strobe, enable)
	begin
		next_state = state;

		if(enable)
		begin
			case(state)
				IDLE:
				begin
					if(din == 8'd1 && w_strobe)
						next_state = ADDR0;
				end

				ADDR0:
				begin
					if(w_strobe)
						next_state = ADDR1;
				end
				ADDR1:
				begin
					if(w_strobe)
						next_state = ADDR2;
				end
				ADDR2:
				begin
					if(w_strobe)
						next_state = ADDR3;
				end
				ADDR3:
				begin
					if(w_strobe)
						next_state = WAIT;
				end

				WAIT:
				begin
					if(w_strobe)
					begin
						if(din == 8'd2 || din == 8'd4)
							next_state = BYTE;
						else if(din == 8'd1)
							next_state = ADDR0;
						else
							next_state = IDLE;
					end
				end

				BYTE:
					next_state = WAIT;

				default:
					next_state = IDLE;
			endcase
		end
	end

	// Lógica de salida
	always @(posedge clk)
	begin
		_r_byte   <= 0;
		_r_block  <= 0;
		addrByte  <= 8'd0;
		addrByte0 <= 0;
		addrByte1 <= 0;
		addrByte2 <= 0;
		addrByte3 <= 0;

		case(state)
			IDLE:
			begin
			end

			ADDR0:
			begin
				addrByte <= din;
				addrByte0 <= 1;
			end

			ADDR1:
			begin
				addrByte <= din;
				addrByte1 <= 1;
			end

			ADDR2:
			begin
				addrByte <= din;
				addrByte2 <= 1;
			end

			ADDR3:
			begin
				addrByte <= din;
				addrByte3 <= 1;
			end

			WAIT:
			begin
				_r_block <= 1;
			end

			BYTE:
			begin
				_r_block <= 1;
				_r_byte <= 1;
			end
		endcase
	end

	// Asignación de la dirección de bloque (hay que hacerlo así para evitar
	// latches)
	always @(posedge clk)
	begin
		if(reset)
			_block_addr <= 32'd0;
		else
		begin
			if     (addrByte0) _block_addr[7:0]   <= addrByte;
			else if(addrByte1) _block_addr[15:8]  <= addrByte;
			else if(addrByte2) _block_addr[23:16] <= addrByte;
			else if(addrByte3) _block_addr[31:24] <= addrByte;
		end
	end
endmodule
