BUILD_DIR=build
TB_DIR=test_benches

TB = pc_tb.v
TB_DEPS = code_mem/pc.v

COMP_OUT = $(TB:.v=.out)
SIM_OUT = $(TB:.v=.vcd)

.PHONY = sim

all : $(BUILD_DIR) $(BUILD_DIR)/$(SIM_OUT)

$(BUILD_DIR)/$(COMP_OUT) : $(TB_DIR)/$(TB) $(TB_DEPS)
	iverilog -I control/ $(TB_DIR)/$(TB) $(TB_DEPS) -o $(BUILD_DIR)/$(COMP_OUT)

$(BUILD_DIR)/$(SIM_OUT) : $(BUILD_DIR)/$(COMP_OUT)
	cd $(BUILD_DIR);\
	vvp $(COMP_OUT) -lxt

sim : $(BUILD_DIR) $(BUILD_DIR)/$(SIM_OUT)
	gtkwave $(BUILD_DIR)/$(SIM_OUT) 2>/dev/null >/dev/null &

$(BUILD_DIR) :
	@mkdir $(BUILD_DIR)

clear :
	@-rm $(BUILD_DIR)/$(COMP_OUT)
	@-rm $(BUILD_DIR)/$(SIM_OUT)
