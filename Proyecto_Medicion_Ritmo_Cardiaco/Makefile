PROJECT = heart_rate_soc
TOP_MODULE = SOC

# Herramientas
YOSYS = yosys
NEXTPNR = nextpnr-ecp5
ECPPACK = ecppack

# Rutas
RTL_DIR = rtl
FIRMWARE_DIR = firmware
CONSTRAINTS = constraints/colorlight_5A_75E.lpf

all: $(PROJECT).bit

# 1. Compilar Software
sw:
	$(MAKE) -C $(FIRMWARE_DIR)

# 2. Síntesis de Hardware (Yosys)
$(PROJECT).json: sw
	$(YOSYS) -p "synth_ecp5 -top $(TOP_MODULE) -json $@" $(RTL_DIR)/*.v

# 3. Place & Route (nextpnr)
$(PROJECT).config: $(PROJECT).json
	$(NEXTPNR) --25k --package CABGA256 --speed 6 --json $< --lpf $(CONSTRAINTS) --textcfg $@

# 4. Generar Bitstream para la FPGA
$(PROJECT).bit: $(PROJECT).config
	$(ECPPACK) $< $@

# Simulación con Icarus Verilog
sim: sw
	iverilog -o sim.vpp $(RTL_DIR)/SOC_TB.v $(RTL_DIR)/*.v
	vvp sim.vpp
	gtkwave SOC_TB.vcd &

clean:
	rm -f *.json *.config *.bit *.vpp *.vcd
	$(MAKE) -C $(FIRMWARE_DIR) clean

.PHONY: all sw sim clean