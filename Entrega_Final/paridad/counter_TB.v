module counter_TB;
reg clk;
reg Load;
reg DEC;
wire Zero;

counter uut(.clk(clk), .Load(Load), .DEC(DEC), .Zero(Zero));
initial begin
    clk=0;
    forever #20 clk=~clk;
end
initial begin
    $dumpfile("counter_TB.vcd");
    $dumpvars(0,counter_TB);

    Load=0;
    DEC=0;
    @(posedge clk);
    Load=1;
    @(posedge clk);
    Load=0;
    @(posedge clk);
    DEC=1;
    repeat(5)@(posedge clk);
    DEC=0;
    #40;
    @(posedge clk);
    Load=1;
    @(posedge clk);
    Load=0;
    DEC=1;
    repeat(9)@(posedge clk);
    #40;
    DEC=0;
    #40;
    @(posedge clk);
    Load=1;
    @(posedge clk);
    Load=0;
    DEC=1;
    wait(Zero);
    DEC=0;
    #40;
    $finish;

end


endmodule