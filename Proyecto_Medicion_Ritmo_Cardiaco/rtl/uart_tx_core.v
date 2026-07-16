module uart_tx_core #(parameter clk_freq=25000000, parameter baud=115200) (
    input clk, rst,
    input [7:0] data,
    input start,
    output reg tx_pin,
    output reg busy
);
    localparam BIT_PERIOD = clk_freq / baud;
    reg [31:0] timer;
    reg [3:0] bit_idx;
    reg [9:0] shift_reg;

    always @(posedge clk) begin
        if (rst) begin
            tx_pin <= 1'b1;
            busy <= 0;
        end else if (!busy && start) begin
            shift_reg <= {1'b1, data, 1'b0}; // Stop, Data, Start
            timer <= 0;
            bit_idx <= 0;
            busy <= 1;
        end else if (busy) begin
            if (timer < BIT_PERIOD) timer <= timer + 1;
            else begin
                timer <= 0;
                tx_pin <= shift_reg[bit_idx];
                if (bit_idx < 9) bit_idx <= bit_idx + 1;
                else busy <= 0;
            end
        end
    end
endmodule