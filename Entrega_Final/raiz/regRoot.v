module regRoot (clk, load, shift, setRoot, Root);
    //señales de control 
    input clk;
    input load;
    input shift;
    input setRoot;
    // salida
    output reg [7:0] Root;
    always @(posedge clk) 
    begin
        if (load) 
        begin
            Root <= 8'd0;    
        end
        else if (shift) 
        begin
            Root <= Root << 1;    
        end
        else if (setRoot) 
        begin
            Root[0] <= 1'b1;     
        end
    end
endmodule