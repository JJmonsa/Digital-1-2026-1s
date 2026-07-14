module comblsr(clk, update, SHFT, add, Load, in_Bin, in_bcd, BCD_Out);
    // señales de control
    input clk;
    input SHFT;
    input add;
    input Load;
    input [4:0] update;

    //entradas
    input [15:0] in_Bin;
    input [19:0] in_bcd;
    //salida
    output [19:0] BCD_Out;
    reg[35:0] alldata;
    assign BCD_Out=alldata[35:16];



always @(posedge clk) begin
    if (Load) 
    begin
        alldata[35:16] <= 20'b0; 
        alldata[15:0] <= in_Bin;
    end
    else if (SHFT) begin
        alldata <= alldata << 1;
    end
    else if (add) 
    begin
        if(update[4]==1'b1)
            alldata[35:32]<=in_bcd[19:16];
        if(update[3]==1'b1)
            alldata[31:28]<=in_bcd[15:12];
        if(update[2]==1'b1)
            alldata[27:24]<=in_bcd[11:8];
        if(update[1]==1'b1)
            alldata[23:20]<=in_bcd[7:4];
        if(update[0]==1'b1)
            alldata[19:16]<=in_bcd[3:0];
    end

end



endmodule