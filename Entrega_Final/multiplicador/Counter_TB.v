module Counter_TB;
reg clk;
reg load;
reg Shft_Dec;
wire [4:0]Out_C;

Counter uut(.clk(clk), .load(load), .Shft_Dec(Shft_Dec), .Out_C(Out_C));
initial begin
    clk=0;
    forever #20 clk=~clk;
end
initial begin
    $dumpfile("Counter_TB.vcd");
    $dumpvars(0, Counter_TB);

    load=0;
    Shft_Dec=0;
    @(posedge clk);
    load=1;
    @(posedge clk);
    load=0;
    @(posedge clk);
    Shft_Dec=1;
    repeat(5)@(posedge clk);
    Shft_Dec=0;
    @(posedge clk);
    load=1;
    @(posedge clk);
    load=0;
    Shft_Dec=1;
    repeat(16)@(posedge clk);
    Shft_Dec=0;
    #40;
    $finish;
end
    
endmodule
