module onesCount(clk, Load, INC, parity, bits1);
input clk;
input Load;
input INC;
output parity;
output [3:0]bits1;
reg [3:0]onesCount;
assign bits1 = onesCount;
assign parity = onesCount[0];

always @(posedge clk) 
begin
    if (Load) 
    begin
        onesCount <= 4'b0;
    end
    else if (INC) 
    begin
        onesCount <= onesCount+1;    
    end
end    
endmodule