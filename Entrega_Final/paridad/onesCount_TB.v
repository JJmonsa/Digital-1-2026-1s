module onesCount_TB;
reg clk;
reg Load;
reg INC;
wire parity;
wire [3:0]bits1;

onesCount uut(.clk(clk), .Load(Load), .INC(INC), .parity(parity), .bits1(bits1));
initial begin
    clk=0;
    forever #20 clk =~clk;
end
initial begin
    $dumpfile("onesCount_TB.vcd");
    $dumpvars(0,onesCount_TB);

    Load=0;
    INC=0;
    @(posedge clk);
    Load=1;
    @(posedge clk);
    Load=0;
    @(posedge clk);
    INC=1;
    repeat(5)@(posedge clk);
    INC=0;
    #40;
    @(posedge clk);
    Load=1;
    @(posedge clk);
    Load=0;
    INC=1;
    repeat(10)@(posedge clk);
    INC=0;
    #40;
    $finish;

end

endmodule
