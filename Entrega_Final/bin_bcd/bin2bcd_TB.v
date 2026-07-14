module bin2bcd_TB;
reg clk;
reg rst;
reg init;
reg [15:0] Bin;
wire [19:0] BCD;
wire done;

bin2bcd uut(.clk(clk), .rst(rst), .init(init), .Bin(Bin), .BCD(BCD), .done(done));
initial begin
    clk=0;
    forever #20 clk=~clk;
end
initial begin
    $dumpfile("bin2bcd_TB.vcd");
    $dumpvars(0, bin2bcd_TB);

    rst=1;
    init=0;
    Bin=16'd115;
    @(posedge clk);
    rst=0;
    @(posedge clk);
    init=1;
    @(posedge clk);
    init=0;
    wait(done);
    @(posedge clk);
    rst=1;
    init=0;
    Bin=16'd65535;
    @(posedge clk);
    rst=0;
    init=1;
    @(posedge clk);
    init=0;
    wait(done);
    #20;
    $finish;
end
endmodule
