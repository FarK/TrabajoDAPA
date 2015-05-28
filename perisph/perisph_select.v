module perisph_select(
	input [7:0] addr,
	output reg enLED,
	output reg enSW,
	output reg enBTN,
	output reg en7seg,
	output reg en7segMSB,
	output reg en7segLSB,
	output reg sdcm_addr,
	output reg ensdcm,
	output reg mem_io
);

`include "perisph_addrs.v"

always @(*)
begin
	enLED = 0;
	enSW = 0;
	enBTN = 0;
	en7seg = 0;
	en7segMSB = 0;
	en7segLSB = 0;
	ensdcm = 0;
	mem_io = 0;
	sdcm_addr = 0;

	case(addr)
		LED_ADDR:
		begin
			enLED = 1;
			mem_io = 1;
		end

		SW_ADDR:
		begin
			enSW = 1;
			mem_io = 1;
		end

		BTN_ADDR:
		begin
			enBTN = 1;
			mem_io = 1;
		end

		SSEG_ADDR_MSB:
		begin
			en7seg = 1;
			en7segMSB = 1;
			mem_io = 1;
		end

		SSEG_ADDR_LSB:
		begin
			en7seg = 1;
			en7segLSB = 1;
			mem_io = 1;
		end

		SDCM_SADDR:
		begin
			sdcm_addr = 0;
			ensdcm = 1;
			mem_io = 1;
		end

		SDCM_DADDR:
		begin
			sdcm_addr = 1;
			ensdcm = 1;
			mem_io = 1;
		end
	endcase
end
endmodule
