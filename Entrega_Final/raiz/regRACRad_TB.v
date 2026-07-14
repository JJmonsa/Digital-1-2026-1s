module regRACRad_TB;

reg clk;
reg load;
reg shift;
reg update_RAC;
reg [15:0] in_Rad;
reg [16:0] SUM;
wire [15:0] RAC;
wire [15:0] Rad;

regRACRad uut(.clk(clk), .load(load), .shift(shift), .update_RAC(update_RAC), .in_Rad(in_Rad), .SUM(SUM), .RAC(RAC), .Rad(Rad));
initial begin
    clk=0;
    forever #20 clk=~clk;
end
initial begin
    $dumpfile("regRACRad_TB.vcd");
    $dumpvars(0, regRACRad_TB);

    load=0;
    shift=0;
    update_RAC=0;
    in_Rad=16'b11100011100111000;
    SUM=17'b0;
    @(posedge clk);
    load=1;
    @(posedge clk);
    load=0;
    @(posedge clk);
    shift=1;
    repeat(9)@(posedge clk);
    shift=0;
    SUM=17'b11111111111111111;
    @(posedge clk);
    update_RAC=1;
    @(posedge clk);
    update_RAC=0;
    #40;
    $finish;
end


endmodule
