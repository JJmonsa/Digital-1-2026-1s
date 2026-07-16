`timescale 1ns / 1ps

module SOC_TB;
    reg clk;
    reg resetn;
    reg pulse_sensor;
    wire led_data;
    wire tx;

    // Instancia del SoC (UUT: Unit Under Test)
    SOC uut (
        .clk(clk),
        .resetn(resetn),
        .RXD(1'b1),
        .TXD(tx),
        .pulse_sensor_pin(pulse_sensor),
        .ws2812_data_pin(led_data)
    );

    // Generador de Reloj (25MHz -> 40ns periodo)
    always #20 clk = ~clk;

    initial begin
        // Configuración de visualización de señales
        $dumpfile("SOC_TB.vcd");
        $dumpvars(0, SOC_TB);

        // Inicialización
        clk = 0;
        resetn = 0;
        pulse_sensor = 0;

        // Liberar Reset tras 100ns
        #100 resetn = 1;

        // Simular un pulso cardiaco (latido)
        #500 pulse_sensor = 1;
        #1000 pulse_sensor = 0;

        // Dejar correr la simulación para ver la respuesta del WS2812
        #50000;
        $finish;
    end
endmodule