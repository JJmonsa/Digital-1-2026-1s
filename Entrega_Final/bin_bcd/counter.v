module counter (clk, DEC, Load, Zero);
    input clk;
    input DEC;
    input Load;
    output Zero;
    reg[4:0] count;
    assign Zero = (count==0);
always @(posedge clk) 
begin
    if (Load)
    begin
        count <= 5'd16;
    end
    else if (DEC) 
    begin
        count <= count - 1;
    end
end
endmodule