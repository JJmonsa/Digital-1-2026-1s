module regTemp_TB;
reg clk;
reg load;
reg load_Temp;
reg [7:0] Root;
wire [7:0] Temp;

regTemp uut(.clk(clk), .load(load), .load_Temp(load_Temp), .Temp(Temp), .Root(Root));
initial begin
    clk=0;
    forever #20 clk=~clk;
end
initial begin
    $dumpfile("regTemp_TB.vcd");
    $dumpvars(0, regTemp_TB);

    load=0;
    load_Temp=0;
    Root=8'b11001100;
    @(posedge clk);
    load=1;
    @(posedge clk);
    load=0;
    @(posedge clk);
    load_Temp=1;
    @(posedge clk);
    load_Temp=0;
    Root=8'b00001111;
    @(posedge clk);
    load_Temp=1;
    @(posedge clk);
    load_Temp=0;
    @(posedge clk)
    load=1;
    @(posedge clk);
    load=0;
    #80;
    $finish;

end
    
endmodule
