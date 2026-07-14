module regA (clk, Load, SHFT, in_bits, LSB);
input clk;
input Load;
input SHFT;
input [8:0] in_bits;
output LSB;
reg [8:0] regA;
assign LSB = regA[0];

always @(posedge clk) begin
    if (Load) 
    begin
        regA <= in_bits;    
    end
    else if (SHFT) 
    begin
        regA <= regA>>1;    
    end
end
    
endmodule