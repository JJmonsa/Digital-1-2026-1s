module regRoot_TB;
 
reg clk;
reg load;
reg shift;
reg setRoot;
wire [7:0] Root;

regRoot uut (.clk(clk), .load(load), .shift(shift), .setRoot(setRoot), .Root(Root));
initial begin
    clk=0;
    forever #20 clk=~clk;
end    
initial begin
    $dumpfile("regRoot_TB.vcd");
    $dumpvars(0, regRoot_TB);

    load=0;
    shift=0;
    setRoot=0;
    @(posedge clk);
    load=1;
    @(posedge clk);
    load=0;
    @(posedge clk);
    setRoot=1;
    @(posedge clk);
    setRoot=0;
    @(posedge clk);
    shift=1;
    repeat(3)@(posedge clk);
    shift=0;
    @(posedge clk);
    setRoot=1;
    @(posedge clk);
    setRoot=0;
    @(posedge clk);
    shift=1;
    @(posedge clk);
    shift=0;
    @(posedge clk);
    setRoot = 1;
    @(posedge clk);
    setRoot=0;
    @(negedge clk);
    shift=1;
    @(negedge clk);
    shift=0;
    @(negedge clk);
    setRoot=1;
    @(negedge clk);
    setRoot=0;
    #80;
    $finish;
end
endmodule
