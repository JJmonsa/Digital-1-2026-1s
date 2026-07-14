module control_TB;
reg clk;
reg rst;
reg init;
reg LSB;
reg Zero;
wire ADD;
wire load;
wire Shft_Dec;
wire done;

control uut(.clk(clk), .rst(rst), .init(init), .LSB(LSB), .Zero(Zero), .ADD(ADD), .load(load), .Shft_Dec(Shft_Dec), .done(done));
initial begin
    clk=0;
    forever #20 clk=~clk;
end
initial begin
    $dumpfile("control_TB.vcd");
    $dumpvars(0, control_TB);

    rst=1;
    init=0;
    LSB=0;
    Zero=0;
    @(posedge clk);
    rst=0;
    init=1;
    @(posedge clk);
    init=0;
    #80;
    @(posedge clk);
    rst=1;
    @(posedge clk);
    rst=0;
    #40;
    @(posedge clk);
    init=1;
    @(posedge clk);
    init=0;
    @(posedge clk);
    LSB=1;
    @(posedge clk);
    LSB=0;
    #80;
    @(posedge clk);
    Zero=1;
    @(posedge clk);
    Zero=0;
    repeat(29)@(posedge clk);
    $finish;



end

endmodule
