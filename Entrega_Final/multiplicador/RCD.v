//REGISTRO DE CORRIMIENTO A LA DERECHA
module RCD (clk, in_B, load, Shft_Dec, Out_B);

//señales de control
input clk;
input load;
input Shft_Dec;

//entradas y salidas
input [15:0]in_B;
output reg[15:0]Out_B;

always @(negedge clk) 
begin
    if (load)
        Out_B <= in_B;

    else if(Shft_Dec)
        Out_B <= Out_B >> 1;
        
end
endmodule