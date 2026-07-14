module Counter (clk, load, Shft_Dec, Out_C);

//señales de control
input clk;
input load;
input Shft_Dec;

//salida
output reg [4:0]Out_C; // como el número es de máximo 16 bits por ahora entonces el contador solo necesita 5 bits

always @(negedge clk) 
begin
    if (load)
        Out_C <= 5'd16; 
    else if(Shft_Dec)
        Out_C <= Out_C - 1;
        
end
    
endmodule