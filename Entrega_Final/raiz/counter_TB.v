module counter_TB;
reg clk;
reg load;
reg Dec;
wire [3:0]out_c;

counter uut(.clk(clk), .load(load), .Dec(Dec), .out_c(out_c));
initial begin
    clk=0;
    forever #20 clk=~clk;
end
initial begin
    $dumpfile("counter_TB.vcd");
    $dumpvars(0, counter_TB);
    load=0;
    Dec=0;
    @(posedge clk);
    load=1;
    @(posedge clk);
    load=0;
    @(posedge clk);
    Dec=1;
    repeat(6)@(posedge clk);
    Dec=0;
    #40;
    @(posedge clk);
    load=1;
    @(posedge clk);
    load=0;
    Dec=1;
    repeat(8)@(posedge clk);
    Dec=0;
    #40;
    $finish;

end
    
endmodule
