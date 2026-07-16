# Medidor de Pulso Cardiaco con Matriz WS2812

Este proyecto implementa un Sistema sobre Silicio (SoC) en una FPGA **Colorlight 5A-75E** para medir el ritmo cardiaco y visualizarlo en una matriz LED.

## Estructura del Repositorio
- `rtl/`: Descripción de hardware en Verilog (CPU, periféricos, memoria).
- `firmware/`: Código en C y scripts de compilación para el procesador.
- `constraints/`: Mapeo de pines para la placa Colorlight.

## Requisitos
- **Toolchain RISC-V:** `riscv64-unknown-elf-gcc`
- **Herramientas FPGA:** `yosys`, `nextpnr-ecp5`, `ecppack`
- **Simulación:** `iverilog`, `gtkwave`

## Instrucciones de Uso
1. Compilar todo y generar bitstream: `make`
2. Ejecutar simulación funcional: `make sim`
3. Cargar a la FPGA: `openFPGALoader -b colorlight-5a-75e heart_rate_soc.bit`

## Operación y Resultados
A continuación se muestra el funcionamiento del sistema en tiempo real, detectando el pulso y cambiando los colores de la matriz WS2812:

### Demostración 1

![Demostración del pulso cardiaco 1](img/monitorcardiaco1.gif)

### Demostración 2

![Demostración del pulso cardiaco 2](img/monitorcardiaco2.gif)

### Demostración 3

![Demostración del pulso cardiaco 3](img/monitorcardiaco3.gif)