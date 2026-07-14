module control_TB;
    reg clk;
    reg init;
    reg Zero;
    reg rst;
    wire Load;
    wire SHFT;
    wire subtract;
    wire DEC;
    wire done;

control uut(.clk(clk), .init(init), .Zero(Zero), .rst(rst), .Load(Load), .SHFT(SHFT), .subtract(subtract), .DEC(DEC), .done(done));

initial begin
    clk=0;
    forever #20 clk = ~clk;
end
initial begin
    $dumpfile("control_TB.vcd");
    $dumpvars(0, control_TB);

    init=0;
    rst=1;
    Zero=0;
    @(posedge clk);
    init=1;
    rst=0;
    @(posedge clk);
    init=0;
    repeat(3)@(posedge clk);
    Zero=1;
    @(posedge clk);
    Zero=0;
    repeat(29)@(posedge clk);
    #40;
    $finish;
end
endmodule
