IVERILOG ?= iverilog
VVP ?= vvp
.PHONY: test
test:
	mkdir -p build
	$(IVERILOG) -g2012 -Wall -s tb_secded_sram -o build/sim rtl/secded_sram.sv tb/tb_secded_sram.sv
	$(VVP) build/sim
