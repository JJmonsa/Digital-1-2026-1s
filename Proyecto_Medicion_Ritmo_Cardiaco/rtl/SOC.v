module SOC (
    input clk,
    input resetn,
    input RXD,
    output TXD,
    input pulse_sensor_pin, // Entrada del sensor de pulso
    output ws2812_data_pin,  // Salida hacia la matriz LED
    output [3:0] LEDS        // LEDs de diagnóstico
);

    wire [31:0] mem_addr;
    wire [31:0] mem_wdata;
    wire [31:0] mem_rdata;
    wire [3:0]  mem_wmask;
    wire        mem_rstrb;
    wire        rd = mem_rstrb;
    wire        wr = |mem_wmask;

    reg [6:0] cs; 
    always @* begin
        case (mem_addr[31:16])
            16'h0000: cs = 7'b0000001; // 0x00000000 - RAM (Programa)
            16'h0040: cs = 7'b0000010; // 0x00400000 - UART [8]
            16'h0041: cs = 7'b0000100; // 0x00410000 - GPIO / Pulsos
            16'h0042: cs = 7'b0001000; // 0x00420000 - WS2812 Controller
            default:  cs = 7'b0000001; 
        endcase
    end

    
    FemtoRV32 CPU (
        .clk(clk),
        .reset(resetn),
        .mem_addr(mem_addr),
        .mem_wdata(mem_wdata),
        .mem_wmask(mem_wmask),
        .mem_rdata(mem_rdata),
        .mem_rstrb(mem_rstrb),
        .mem_rbusy(1'b0),
        .mem_wbusy(1'b0)
    );

    wire [31:0] ram_dout;
    bram RAM (
        .clk(clk),
        .mem_addr(mem_addr),
        .mem_wdata(mem_wdata),
        .mem_wmask({4{cs}} & mem_wmask),
        .mem_rdata(ram_dout),
        .mem_rstrb(cs & rd)
    );

    
    wire [31:0] pulse_dout;
    perip_pulse pulse_inst (
        .clk(clk),
        .reset(!resetn),
        .d_in(mem_wdata),
        .cs(cs[13]),
        .addr(mem_addr[4:0]),
        .rd(rd),
        .wr(wr),
        .d_out(pulse_dout),
        .sensor_in(pulse_sensor_pin)
    );

    wire [31:0] ws2812_dout;
    perip_ws2812 ws2812_inst (
        .clk(clk),
        .reset(!resetn),
        .d_in(mem_wdata),
        .cs(cs[14]),
        .addr(mem_addr[4:0]),
        .rd(rd),
        .wr(wr),
        .d_out(ws2812_dout),
        .led_pin(ws2812_data_pin)
    );

    wire [31:0] uart_dout;
    peripheral_uart #( .clk_freq(25000000), .baud(115200) ) uart_inst (
        .clk(clk),
        .rst(!resetn),
        .d_in(mem_wdata),
        .cs(cs[15]),
        .addr(mem_addr[4:0]),
        .rd(rd),
        .wr(wr),
        .d_out(uart_dout),
        .uart_tx(TXD),
        .uart_rx(RXD),
        .ledout(LEDS)
    );

    reg [31:0] m_rdata;
    always @* begin
        case (cs)
            7'b0000001: m_rdata = ram_dout;
            7'b0000010: m_rdata = uart_dout;
            7'b0000100: m_rdata = pulse_dout;
            7'b0001000: m_rdata = ws2812_dout;
            default:    m_rdata = 32'h66666666; // Valor de error
        endcase
    end
    assign mem_rdata = m_rdata;

endmodule