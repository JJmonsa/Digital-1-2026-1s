module Subtractor_TB;
reg [15:0] RAC;
reg [7:0] Temp;
wire [16:0] SUM;
wire Neg;
Subtractor uut(.RAC(RAC), .Temp(Temp), .SUM(SUM), .Neg(Neg));

initial begin
    $dumpfile("Subtractor_TB.vcd");
    $dumpvars(0, Subtractor_TB);
    
    RAC=15'd14;
    Temp=8'd4;
    #40;
    RAC=16'd20;
    Temp=9'd4;
    #40;
    RAC=16'd100;
    Temp=8'd15;
    #40;
    RAC=16'd0;
    Temp=8'd0;
    #40;
    $finish;
end
endmodule
