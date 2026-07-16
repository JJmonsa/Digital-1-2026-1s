module perip_ws2812 (
    input clk,
    input reset,
    input [31:0] d_in,    // Datos del bus de CPU
    input [6:0] cs,       // Señal Chip Select (del SOC.v)
    input [4:0] addr,     // Dirección del registro
    input rd,             // Señal de lectura
    input wr,             // Señal de escritura
    output reg [31:0] d_out, // Datos hacia la CPU
    output reg led_pin    // Pin de salida a la matriz LED
);

    // --- Registros Internos ---
    reg [23:0] color_reg; // Almacena el color RGB (8R, 8G, 8B)
    reg start_tx;         // Disparador de transmisión
    wire done_tx;         // Bandera de fin de transmisión
    
    // --- Lógica de Interfaz de CPU (Mapa de Memoria Interno) ---
    // addr 0x00: Color (24 bits)
    // addr 0x04: Control (bit 0 = start)
    // addr 0x08: Estatus (bit 0 = done)
    
    wire my_cs = cs[4]; // Seleccionado por la dirección 0x0042xxxx

    always @(posedge clk) begin
        if (reset) begin
            color_reg <= 24'h0;
            start_tx <= 1'b0;
        end else if (my_cs && wr) begin
            case (addr[3:2])
                2'b00: color_reg <= d_in[23:0];
                2'b01: start_tx <= d_in;
            endcase
        end else begin
            start_tx <= 1'b0; // Pulso de inicio de un solo ciclo
        end
    end

    // Lectura de registros desde la CPU [5]
    always @(*) begin
        if (my_cs && rd) begin
            case (addr[3:2])
                2'b00: d_out = {8'b0, color_reg};
                2'b10: d_out = {31'b0, done_tx};
                default: d_out = 32'h0;
            endcase
        end else d_out = 32'h0;
    end

    // --- Máquina de Estados Algorítmica (ASM) para el Protocolo WS2812 ---
    // Tiempos para 25MHz (1 ciclo = 40ns)
    parameter T0H = 9;   // 350ns
    parameter T0L = 20;  // 800ns
    parameter T1H = 18;  // 700ns
    parameter T1L = 15;  // 600ns
    parameter T_RES = 1250; // >50us Reset

    reg [2:0] state;
    reg [31:0] timer;
    reg [4:0] bit_count;
    reg [23:0] shift_reg;

    localparam IDLE=0, LOAD=1, SEND_BIT=2, LOW_PHASE=3, NEXT=4, RESET_WAIT=5;

    assign done_tx = (state == IDLE);

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            led_pin <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    led_pin <= 1'b0;
                    if (start_tx) state <= LOAD;
                end

                LOAD: begin
                    shift_reg <= color_reg;
                    bit_count <= 23;
                    state <= SEND_BIT;
                end

                SEND_BIT: begin
                    led_pin <= 1'b1;
                    // Determina tiempo en alto según el bit actual
                    if (shift_reg[bit_count]) begin
                        if (timer < T1H) timer <= timer + 1;
                        else begin
                            timer <= 0;
                            state <= LOW_PHASE;
                        end
                    end else begin
                        if (timer < T0H) timer <= timer + 1;
                        else begin
                            timer <= 0;
                            state <= LOW_PHASE;
                        end
                    end
                end

                LOW_PHASE: begin
                    led_pin <= 1'b0;
                    // Determina tiempo en bajo según el bit
                    if (shift_reg[bit_count]) begin
                        if (timer < T1L) timer <= timer + 1;
                        else begin timer <= 0; state <= NEXT; end
                    end else begin
                        if (timer < T0L) timer <= timer + 1;
                        else begin timer <= 0; state <= NEXT; end
                    end
                end

                NEXT: begin
                    if (bit_count == 0) state <= RESET_WAIT;
                    else begin
                        bit_count <= bit_count - 1;
                        state <= SEND_BIT;
                    end
                end

                RESET_WAIT: begin
                    led_pin <= 1'b0;
                    if (timer < T_RES) timer <= timer + 1;
                    else begin timer <= 0; state <= IDLE; end
                end
            endcase
        end
    end
endmodule