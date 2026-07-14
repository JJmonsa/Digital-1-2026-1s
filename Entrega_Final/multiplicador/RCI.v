//MODULO REGISTRO DE CORRIMIENTO A LA IZQUIERDA
module RCI (clk, load, in_A, Shft_Dec, Out_A);

// señales de control
input clk;
input Shft_Dec;
input load;

// entradas y salidas
input [15:0] in_A;
output reg [31:0] Out_A;

always @(negedge clk)
begin

    if(load)
        Out_A <= in_A;

    else if(Shft_Dec)
        Out_A <= Out_A << 1;

end
endmodule