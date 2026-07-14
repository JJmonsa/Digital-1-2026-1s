module regTemp (clk, load, load_Temp, Temp, Root);
    //señales de control
    input clk;
    input load;
    input load_Temp;
    // entrada de datos
    input [7:0] Root;
    // salida del modulo
    output reg [7:0] Temp;
    always @(posedge clk) 
    begin
        if (load) 
        begin
            Temp <= 8'd0;    
        end    
        else if (load_Temp) 
        begin
            Temp <= Root;    
        end
    end
endmodule