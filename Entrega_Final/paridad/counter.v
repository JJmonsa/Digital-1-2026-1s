module counter (clk, Load, DEC, Zero);
input clk;
input Load;
input DEC;
output Zero;
reg [3:0] counter;
assign Zero = (counter==0);
always @(posedge clk) 
begin
    if (Load) 
    begin
        counter <= 4'd9;    
    end
    else if (DEC) 
    begin
        counter <= counter - 1;    
    end
end
endmodule