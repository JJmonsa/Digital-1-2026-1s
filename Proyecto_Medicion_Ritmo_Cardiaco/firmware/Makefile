# Configuración del compilador
CROSS = riscv64-unknown-elf-
CC = $(CROSS)gcc
AS = $(CROSS)as
LD = $(CROSS)ld
OBJCOPY = $(CROSS)objcopy

# Flags para RISC-V (Arquitectura RV32I sin multiplicador hardware nativo)
CFLAGS = -march=rv32i -mabi=ilp32 -ffreestanding -nostdlib -O2
LDFLAGS = -T linker.ld -m elf32lriscv

all: firmware.hex

firmware.elf: crt0.S main.c
	$(CC) $(CFLAGS) -o firmware.elf crt0.S main.c $(LDFLAGS)

# Genera el archivo .bin y luego el .hex para Verilog
firmware.bin: firmware.elf
	$(OBJCOPY) -O binary firmware.elf firmware.bin

firmware.hex: firmware.bin
	# Convierte binario a hexadecimal legible por $readmemh de Verilog
	python3 -c "import sys; data=open('firmware.bin','rb').read(); [print('%08x'%int.from_bytes(data[i:i+4],'little')) for i in range(0,len(data),4)]" > firmware.hex
	cp firmware.hex ../rtl/

clean:
	rm -f *.elf *.bin *.hex