module raiz_TB;
    reg clk;
    reg rst;
    reg init;
    reg [15:0] Rad;
    wire [7:0] Root;
    wire done;

raiz uut(.clk(clk), .rst(rst), .init(init), .Rad(Rad), .Root(Root), .done(done));
initial begin
    clk=0;
    forever #20 clk=~clk;
end
initial begin
    $dumpfile("raiz_TB.vcd");
    $dumpvars(0, raiz_TB);

    rst=1;
    init=0;
    Rad=16'd32;
    @(posedge clk);
    rst=0;
    @(posedge clk);
    init=1;
    @(posedge clk);
    init=0;
    wait(done);
    #40;
    Rad=16'd16;
    @(posedge clk);
    rst=1;
    @(posedge clk);
    rst=0;
    @(posedge clk);
    init=1;
    @(posedge clk);
    init=0;
    wait(done);
    #40;
    Rad=16'd65535;
    @(posedge clk);
    rst=1;
    @(posedge clk);
    rst=0;
    @(posedge clk);
    init=1;
    @(posedge clk);
    init=0;
    wait(done);
    #40;
    Rad=16'd1;
    @(posedge clk);
    rst=1;
    @(posedge clk);
    rst=0;
    @(posedge clk);
    init=1;
    @(posedge clk);
    init=0;
    wait(done);
    #40;

    $finish;
end
    
endmodule
