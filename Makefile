IVERILOG ?= iverilog
VVP ?= vvp
.PHONY: test
test:
	mkdir -p build
	$(IVERILOG) -g2012 -Wall -s tb_secded_sram -o build/sim rtl/secded_sram.sv tb/tb_secded_sram.sv
	$(VVP) build/sim

YOSYS ?= yosys
.PHONY: synth
synth:
	mkdir -p build
	$(YOSYS) -Q -T -l build/synthesis.log -p 'read_verilog -sv rtl/secded_sram.sv; hierarchy -check -top secded_sram; synth -top secded_sram; stat'
