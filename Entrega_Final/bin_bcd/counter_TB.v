module counter_TB;
    reg clk;
    reg DEC;
    reg Load;
    wire Zero;

counter uut(.clk(clk), .DEC(DEC), .Load(Load), .Zero(Zero));
initial begin
    clk=0;
    forever #20 clk = ~clk; 
end

initial begin
    $dumpfile("counter_TB.vcd");
    $dumpvars(0,counter_TB);
    DEC=0;
    Load=0;
    @(posedge clk);
    Load=1;
    @(posedge clk);
    Load=0;
    @(posedge clk);
    DEC=1;
    repeat(5)@(posedge clk);
    DEC=0;
    #40;
    Load=1;
    repeat(2)@(posedge clk);
    Load=0;
    @(posedge clk);
    DEC=1;
    repeat(15)@(posedge clk);
    DEC=0;
    #40;

    $finish;  
end
    
endmodule
