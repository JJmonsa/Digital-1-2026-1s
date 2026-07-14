module Counter_TB;

    reg clk;
    reg load;
    reg DEC;
    wire [4:0]Out_C;

Counter uut(.clk(clk), .load(load), .DEC(DEC), .Out_C(Out_C));
initial begin
    clk=0;
    forever #20 clk = ~clk;

end
initial begin
    $dumpfile("Counter_TB.vcd");
    $dumpvars(0, Counter_TB);

    load = 0;
    DEC = 0;
    
    @(posedge clk);
    load = 1;
    @(posedge clk);
    load = 0;
    DEC = 1;
    repeat(5) @(posedge clk);
    DEC = 0;
    load = 1;
    @(posedge clk);
    load=0;
    DEC=1;
    repeat(16)@(posedge clk);
    DEC=0;
    @(posedge clk);
    $finish;


end
endmodule

