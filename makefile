G = ghdl
W = gtkwave
SRC_DIR = src
SIM_DIR = sim
WAVE_DIR = wave


REG_FILES = $(SRC_DIR)/d_ff.vhd $(SRC_DIR)/reg.vhd
reg_tb: $(REG_FILES) $(SIM_DIR)/reg_tb.vhd
	$(G) -a $(REG_FILES) $(SIM_DIR)/reg_tb.vhd
	$(G) -e reg_tb
	$(G) -r reg_tb --wave=$(WAVE_DIR)/reg_tb.ghw
	$(W) $(WAVE_DIR)/reg_tb.ghw

clear:
	rm -f *.cf
	rm -f $(WAVE_DIR)/*.ghw
