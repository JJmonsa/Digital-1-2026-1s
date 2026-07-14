module counter_TB;
reg clk;
reg DEC;
reg Load;
wire Zero;

counter uut(.clk(clk), .DEC(DEC), .Load(Load), .Zero(Zero));

initial begin
    clk=0;
    forever #20 clk=~clk;
end
initial begin
    $dumpfile("counter_TB.vcd");
    $dumpvars(0, counter_TB);
    Load=0;
    DEC=0;
    @(posedge clk);
    Load=1;
    @(posedge clk);
    Load=0;
    #40;
    DEC=1;
    repeat(5)@(posedge clk);
    DEC=0;
    Load=1;
    @(posedge clk);
    Load=0;
    DEC=1;
    wait(Zero);
    #40;
    $finish;


end
endmodule
