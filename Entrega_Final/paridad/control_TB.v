module control_TB;
reg clk;
reg rst;
reg init;
reg Zero;
reg LSB;
wire Load;
wire SHFT;
wire DEC;
wire INC;
wire done;

control uut(.clk(clk), .rst(rst), .init(init), .Zero(Zero), .LSB(LSB), .Load(Load), .SHFT(SHFT), .DEC(DEC), .INC(INC), .done(done));

initial begin
    clk=0;
    forever #20 clk=~clk;
end
initial begin
    $dumpfile("control_TB.vcd");
    $dumpvars(0,control_TB);

    rst=1;
    init=0;
    Zero=0;
    LSB=0;
    @(posedge clk);
    init=1;
    rst=0;
    @(posedge clk);
    init=0;
    Zero=1;
    @(posedge clk);
    Zero=0;
    repeat(28)@(posedge clk);
    #80;
    @(posedge clk);
    init=1;
    @(posedge clk);
    init=0;
    @(posedge clk);
    LSB=1;
    @(posedge clk);
    LSB=0;
    repeat(2)@(posedge clk);
    Zero=1;
    @(posedge clk)
    Zero=0;
    #40;
    @(posedge clk);
    rst=1;
    @(posedge clk);
    rst=0;
    init=1;
    @(posedge clk);
    init=0;
    repeat(3)@(posedge clk);
    LSB=1;
    repeat(2)@(posedge clk);
    LSB=0;
    repeat(2)@(posedge clk);
    Zero=1;
    @(posedge clk);
    Zero=0;
    #40;

    $finish;
end
    
endmodule
