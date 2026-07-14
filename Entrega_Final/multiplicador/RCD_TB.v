module RCD_TB;

reg clk;
reg load;
reg Shft_Dec;
reg [15:0]in_B;
wire [15:0]Out_B;
RCD uut(.clk(clk), .in_B(in_B), .load(load), .Shft_Dec(Shft_Dec), .Out_B(Out_B));
initial begin
    clk=0;
    forever #20 clk =~clk;
end    
initial begin
    $dumpfile("RCD_TB.vcd");
    $dumpvars(0, RCD_TB);

    load=0;
    Shft_Dec=0;
    in_B=16'b1111111111111111;
    @(posedge clk);
    load=1;
    @(posedge clk);
    load=0;
    @(posedge clk);
    Shft_Dec=1;
    repeat(6)@(posedge clk);
    Shft_Dec=0;
    in_B=16'b1010101010101010;
    @(posedge clk);
    load=1;
    @(posedge clk);
    load=0;
    #40;
    $finish;

    
end
endmodule