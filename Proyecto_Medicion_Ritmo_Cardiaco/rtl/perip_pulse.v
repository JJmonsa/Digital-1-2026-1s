module perip_pulse (
    input clk,            // Reloj del sistema (ej. 25MHz)
    input reset,          // Reset sincrónico
    input [31:0] d_in,    // Datos de entrada desde la CPU
    input [6:0] cs,       // Chip Select (dirección 0x0041xxxx)
    input [4:0] addr,     // Dirección del registro interno
    input rd,             // Señal de lectura
    input wr,             // Señal de escritura
    output reg [31:0] d_out, // Datos de salida hacia la CPU
    input sensor_in       // Señal física del sensor de pulso
);

    // --- Registros de Interfaz de CPU ---
    reg [31:0] beat_count;   // Contador acumulado de pulsos
    reg [31:0] last_period;  // Ciclos de reloj entre los últimos dos pulsos
    reg [31:0] timer;        // Cronómetro interno
    
    // --- Lógica de Detección de Flanco (Edge Detection) ---
    reg sensor_sync_0, sensor_sync_1;
    wire pulse_detected;

    always @(posedge clk) begin
        sensor_sync_0 <= sensor_in;      // Sincronización para evitar metaestabilidad
        sensor_sync_1 <= sensor_sync_0;
    end
    assign pulse_detected = sensor_sync_0 && !sensor_sync_1; // Flanco de subida

    // --- Máquina de Estados / Lógica de Conteo (Camino de Datos) ---
    // Implementa la funcionalidad de medir el intervalo de tiempo
    always @(posedge clk) begin
        if (reset) begin
            beat_count <= 32'h0;
            timer <= 32'h0;
            last_period <= 32'h0;
        end else begin
            timer <= timer + 1;
            if (pulse_detected) begin
                beat_count <= beat_count + 1;
                last_period <= timer; // Guarda el tiempo transcurrido
                timer <= 32'h0;       // Reinicia para el siguiente latido
            end
        end
    end

    // addr 0x00: Leer/Reiniciar contador de pulsos
    // addr 0x04: Leer periodo (ciclos de reloj entre latidos)
    // addr 0x08: Leer tiempo actual del cronómetro
    
    wire my_cs = cs; // Activado por el decodificador del SOC.v

    // Escritura (Reset manual desde software)
    always @(posedge clk) begin
        if (reset) begin
        end else if (my_cs && wr) begin
            if (addr[3:2] == 2'b00) beat_count <= d_in; // Permite reiniciar conteo
        end
    end

    // Lectura (Multiplexor de salida hacia la CPU) [8, 9]
    always @(*) begin
        if (my_cs && rd) begin
            case (addr[3:2])
                2'b00:   d_out = beat_count;
                2'b01:   d_out = last_period;
                2'b10:   d_out = timer;
                default: d_out = 32'h0;
            endcase
        end else begin
            d_out = 32'h0;
        end
    end

endmodule