module control_TB;
reg clk;
reg rst;
reg init;
reg Zero;
wire Load;
wire SHFT;
wire add;
wire DEC;
wire done;

control uut(.clk(clk), .rst(rst), .init(init), .Zero(Zero), .Load(Load), .SHFT(SHFT), .add(add), .DEC(DEC), .done(done));
initial begin
    clk = 0;
    forever #20 clk = ~clk;
end
initial begin
    $dumpfile("control_TB.vcd");
    $dumpvars(0,control_TB);

    rst=1;
    init=0;
    Zero=0;

    @(posedge clk);
    rst=0;
    init=1;
    @(posedge clk);
    init=0;
    @(posedge clk);
    Zero=1;
    @(posedge clk);
    Zero=0;
    rst=1;
    @(posedge clk);
    rst=0;
    init=1;
    @(posedge clk);
    init=0;
    repeat(4)@(posedge clk);
    Zero=1;
    @(posedge clk);
    Zero=0;
    repeat(29)@(posedge clk);
    #40;
    $finish;
end
endmodule
// colocar 'estados' en ASCII en gtkwave para ver los nombres de los estaods
