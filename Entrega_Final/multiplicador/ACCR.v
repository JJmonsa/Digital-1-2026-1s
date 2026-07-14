module ACCR (clk, A, ADD, reset, R);

//señales de control
input clk;
input ADD;
input reset;

// entradas y salidas
input [31:0]A;
output reg [31:0] R;

always @(negedge clk) 
begin
    if (reset)
        R <= 32'b0;
    else if(ADD)
        R <= R+A;
    
end
    
endmodule