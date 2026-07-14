module parity_TB;
reg rst;
reg clk;
reg init;
reg [8:0]in_bits;
wire [3:0]bits1;
wire parity;
wire done;

parity uut(.clk(clk), .rst(rst), .init(init), .in_bits(in_bits), .bits1(bits1), .parity(parity), .done(done));
initial begin
    clk=0;
    forever #20 clk=~clk;
end
initial begin
    $dumpfile("parity_TB.vcd");
    $dumpvars(0,parity_TB);

    init=0;
    rst=1;
    in_bits=9'b000000000;
    @(posedge clk);
    rst=0;
    init=1;
    @(posedge clk);
    init=0;
    wait(done);
    #40;
    @(posedge clk);
    rst=1;
    in_bits=9'b111111111;
    @(posedge clk);
    rst=0;
    init=1;
    @(posedge clk);
    init=0;
    wait(done);
    #40;
    @(posedge clk);
    rst=1;
    in_bits=9'b101010101;
    @(posedge clk);
    rst=0;
    init=1;
    @(posedge clk);
    init=0;
    wait(done);
    #40;
    @(posedge clk);
    rst=1;
    in_bits=9'b111100000;
    @(posedge clk);
    rst=0;
    init=1;
    @(posedge clk);
    init=0;
    wait(done);
    #40;
    @(posedge clk);
    rst=1;
    in_bits=9'b100000000;
    @(posedge clk);
    rst=0;
    init=1;
    @(posedge clk);
    init=0;
    wait(done);
    #40;
    $finish;
end


endmodule