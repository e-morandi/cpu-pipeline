G = ghdl
W = gtkwave
SRC_DIR = src
SIM_DIR = sim
WAVE_DIR = wave


REG_FILES = $(SRC_DIR)/d_ff.vhd $(SRC_DIR)/reg.vhd
reg_tb: $(REG_FILES) $(SIM_DIR)/reg_tb.vhd
	$(G) -a --std=08 $(REG_FILES) $(SIM_DIR)/reg_tb.vhd
	$(G) -e --std=08 reg_tb
	$(G) -r --std=08 reg_tb --wave=$(WAVE_DIR)/reg_tb.ghw
	$(W) $(WAVE_DIR)/reg_tb.ghw

ADDER_FILES = $(SRC_DIR)/adder.vhd
adder_tb: $(ADDER_FILES) $(SIM_DIR)/adder_tb.vhd
	  $(G) -a --std=08 $(ADDER_FILES) $(SIM_DIR)/adder_tb.vhd
	  $(G) -e --std=08 adder_tb
	  $(G) -r --std=08 adder_tb --wave=$(WAVE_DIR)/adder_tb.ghw
	  $(W) $(WAVE_DIR)/adder_tb.ghw

SUB_FILES = $(SRC_DIR)/subtractor.vhd
subtractor_tb: $(SUB_FILES) $(SIM_DIR)/subtractor_tb.vhd
	       $(G) -a --std=08 $(SUB_FILES) $(SIM_DIR)/subtractor_tb.vhd
	       $(G) -e --std=08 subtractor_tb
	       $(G) -r --std=08 subtractor_tb --wave=$(WAVE_DIR)/subtractor_tb.ghw
	       $(W) $(WAVE_DIR)/subtractor_tb.ghw

ALU_FILES = $(ADDER_FILES) $(SUB_FILES) $(SRC_DIR)/alu.vhd
alu_tb: $(ALU_FILES) $(SIM_DIR)/alu_tb.vhd
	$(G) -a --std=08 $(ALU_FILES) $(SIM_DIR)/alu_tb.vhd
	$(G) -e --std=08 alu_tb
	$(G) -r --std=08 alu_tb --wave=$(WAVE_DIR)/alu_tb.ghw
	$(W) $(WAVE_DIR)/alu_tb.ghw

clear:
	rm -f *.cf
	rm -f $(WAVE_DIR)/*.ghw
