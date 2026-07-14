module RCI_TB;

reg clk;
reg Shft_Dec;
reg load;
reg [15:0] in_A;
wire [31:0] Out_A;
RCI uut(.clk(clk), .load(load), .in_A(in_A), .Shft_Dec(Shft_Dec), .Out_A(Out_A));
initial begin
    clk=0;
    forever #20 clk =~clk;
end    
initial begin
    $dumpfile("RCI_TB.vcd");
    $dumpvars(0, RCI_TB);

    load=0;
    Shft_Dec=0;
    in_A=16'b1111111111111111;
    @(posedge clk);
    load=1;
    @(posedge clk);
    load=0;
    @(posedge clk);
    Shft_Dec=1;
    repeat(6)@(posedge clk);
    Shft_Dec=0;
    in_A=16'b1010101010101010;
    @(posedge clk);
    load=1;
    @(posedge clk);
    load=0;
    #40;
    $finish;

    
end
endmodule
