module counter (clk, load, Dec, out_c);
    //señales de control
    input clk;
    input load;
    input Dec;
    output reg [3:0]out_c;
    always @(posedge clk) 
    begin
        if (load) 
        begin
            out_c <= 4'd8;
        end
        else if (Dec) 
        begin
            out_c <= out_c - 1'b1;
        end
    end
    
endmodule