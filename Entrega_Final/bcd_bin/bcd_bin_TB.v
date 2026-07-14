module bcd2bin_TB;
reg clk;
reg rst;
reg init;
reg [19:0]BCD;
wire [15:0]Bin;
wire done;

bcd_bin uut(.clk(clk), .rst(rst), .init(init), .BCD(BCD), .Bin(Bin), .done(done));

initial begin
    clk=0;
    forever #20 clk = ~clk;
end
initial begin
    $dumpfile("bcd2bin_TB.vcd");
    $dumpvars(0, bcd2bin_TB);
    rst=1;
    init=0;
    BCD=20'h11111;
    @(posedge clk);
    rst=0;
    init=1;
    @(posedge clk);
    init=0;
    wait(done);
    #40;
    BCD=20'h00000;
    rst=1;
    @(posedge clk);
    rst=0;
    init=1;
    @(posedge clk);
    init=0;
    wait(done);
    #40;
    rst=1;
    BCD=20'h99;
    init=0;
    @(posedge clk);
    rst=0;
    init=1;
    @(posedge clk);
    init=0;
    wait(done)
    #40;
    rst=1;
    BCD=20'h81;
    init=0;
    @(posedge clk);
    init=1;
    rst=0;
    @(posedge clk);
    init=0;
    wait(done);
    #40;
    rst=1;
    BCD=20'h8888;
    init=0;
    @(posedge clk);
    init=1;
    rst=0;
    @(posedge clk);
    init=0;
    wait(done);
    #40;
    rst=1;
    BCD=20'h23987;
    init=0;
    @(posedge clk);
    init=1;
    rst=0;
    @(posedge clk);
    init=0;
    wait(done);
    $finish;
end
    
endmodule

