module combrsr (clk, Load, SHFT, subtract, update, in_bcd, sub_bcd, Bin_out, BCD_out);
    input clk;
    input Load;
    input SHFT;
    input subtract;
    input [4:0]update;
    input [19:0]in_bcd;
    input [19:0]sub_bcd;
    output [15:0]Bin_out;
    output [19:0]BCD_out;

    reg [35:0]alldata;
    assign Bin_out=alldata[15:0];
    assign BCD_out=alldata[35:16];

always @(posedge clk) begin
    if (Load) 
    begin
        alldata[35:16] <= in_bcd;
        alldata[15:0] <= 16'b0;    
    end
    else if (SHFT) 
    begin
        alldata <= alldata >> 1;    
    end
    else if (subtract) 
    begin
        if (update[4]) 
            alldata[35:32] <= sub_bcd[19:16];
        if (update[3]) 
            alldata[31:28] <= sub_bcd[15:12];
        if (update[2]) 
            alldata[27:24] <= sub_bcd[11:8];
        if (update[1]) 
            alldata[23:20] <= sub_bcd[7:4];
        if (update[0]) 
            alldata[19:16] <= sub_bcd[3:0];
    end
end
endmodule