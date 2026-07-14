module divisor_TB;

    reg clk;
    reg rst;
    reg start;
    reg [15:0] Q;
    reg [15:0] M;
    wire [15:0] Cociente;
    wire [16:0] Residuo;
    wire done;

divisor uut(.clk(clk), .rst(rst), .start(start), .Q(Q), .M(M), .Cociente(Cociente), .Residuo(Residuo), .done(done));
initial begin
    clk=0;
    forever #20 clk = ~clk;
end
initial begin
    $dumpfile("divisor_TB.vcd");
    $dumpvars(0, divisor_TB);

    rst =1;
    start = 0;
    Q = 0;
    M = 0;

    @(posedge clk);
    rst=0;

    Q=16'd99;
    M=16'd3;
    start=1;
    @(posedge clk);
    start=0;

    wait(done);
    @(posedge clk);
    rst=1;
    @(posedge clk);
    rst=0;

    Q=16'd111;
    M=16'd2;
    start=1;
    @(posedge clk);
    start=0;
    wait(done);
    repeat(2) @(posedge clk);
    $finish;
end

endmodule
