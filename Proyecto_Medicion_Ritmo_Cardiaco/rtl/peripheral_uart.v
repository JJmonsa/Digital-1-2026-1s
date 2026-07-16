module peripheral_uart #(
    parameter clk_freq = 25000000,
    parameter baud = 115200
)(
    input clk,
    input rst,
    input [31:0] d_in,
    input [6:0] cs,
    input [4:0] addr,
    input rd,
    input wr,
    output reg [31:0] d_out,
    output uart_tx,
    input  uart_rx,
    output [3:0] ledout
);
    // Registros internos y señales de control
    // addr 0x00: Transmitir dato / Recibir dato
    // addr 0x04: Status
    
    wire my_cs = cs; 
    reg [7:0] tx_reg;
    reg tx_start;
    wire tx_busy;

    // Instancia del motor UART (Simple TX)
    uart_tx_core #(clk_freq, baud) core (
        .clk(clk), .rst(rst),
        .data(tx_reg), .start(tx_start),
        .tx_pin(uart_tx), .busy(tx_busy)
    );

    always @(posedge clk) begin
        if (rst) tx_start <= 0;
        else if (my_cs && wr && addr[3:2] == 2'b00) begin
            tx_reg <= d_in[7:0];
            tx_start <= 1;
        end else tx_start <= 0;
    end

    always @(*) begin
        if (my_cs && rd) begin
            case(addr[3:2])
                2'b00: d_out = 32'h0; // Buffer de recepción (no implementado)
                2'b01: d_out = {31'b0, tx_busy};
                default: d_out = 32'h0;
            endcase
        end else d_out = 32'h0;
    end
endmodule