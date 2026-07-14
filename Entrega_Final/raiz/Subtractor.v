module Subtractor (RAC, Temp, SUM, Neg);
    // entradas
    input [15:0] RAC;
    input [7:0] Temp;
    // salidas
    output reg [16:0] SUM;
    output Neg;

    assign Neg = SUM[16];

    always @(*) 
    begin
       SUM = RAC - { 8'b0, Temp[6:0], 1'b1};
    end

endmodule