module control_TB;
reg clk;
reg rst;
reg init;
reg Neg;
reg Zero;
wire load;
wire shift;
wire load_Temp;
wire Dec;
wire setRoot;
wire update_RAC;
wire done;
control uut(.clk(clk), .rst(rst), .init(init), .Zero(Zero), .Neg(Neg), .load(load), .shift(shift), .load_Temp(load_Temp), .setRoot(setRoot), .Dec(Dec), .update_RAC(update_RAC), .done(done));
initial begin
    clk=0;
    forever #20 clk=~clk;
end
initial begin
    $dumpfile("control_TB.vcd");
    $dumpvars(0, control_TB);
    rst=1;
    init=0;
    Neg=0;
    Zero=0;
    @(posedge clk);
    init=1;
    rst=0;
    @(posedge clk);
    init=0;
    repeat(9)@(posedge clk);
    Neg=1;
    @(posedge clk);
    Neg=0;
    #40;
    @(posedge clk);
    rst=1;
    @(posedge clk);
    rst=0;
    init=1;
    @(posedge clk);
    init=0;
    Zero=1;
    repeat(29)@(posedge clk);
    Zero=0;
    #40;
    $finish;

end


endmodule
