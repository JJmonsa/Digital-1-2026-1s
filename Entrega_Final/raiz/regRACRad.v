module regRACRad (clk, load, shift, update_RAC, in_Rad, SUM, RAC, Rad);
    //señales de control
    input clk;
    input load;
    input shift;
    input update_RAC;
    // datos del modulo
    input [15:0] in_Rad;
    input [16:0] SUM;
    // salidas
    output reg [15:0] RAC;
    output reg [15:0] Rad;

    always @(posedge clk) 
    begin
        if (load) 
        begin
            RAC <= 16'd0;
            Rad <= in_Rad;
        end
        else if (shift) 
        begin
            {RAC,Rad} <= {RAC,Rad} << 2;    
        end
        else if (update_RAC) 
        begin
            RAC <= SUM[15:0];
        end    
    end
endmodule