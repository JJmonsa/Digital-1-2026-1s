module multiplicador_TB;
reg clk;
reg rst;
reg init;
wire done;
reg [15:0]A;
reg [15:0]B;
wire [31:0]R;

multiplicador uut(.clk(clk), .rst(rst), .init(init), .A(A), .B(B), .R(R), .done(done));
initial begin
    clk=0;
    forever #20 clk=~clk;
end
initial begin
    $dumpfile("multiplicador_TB.vcd");
    $dumpvars(0, multiplicador_TB);
    
    init=0;
    rst=1;
    A=100;
    B=10;
    @(posedge clk);
    rst=0;
    @(posedge clk);
    init=1;
    @(posedge clk);
    init=0;
    wait(done);
    #40;
    rst=1;
    A=240;
    B=130;
    @(posedge clk);
    rst=0;
    @(posedge clk);
    init=1;
    @(posedge clk);
    init=0;
    wait(done);
    #40;
    rst=1;
    A=789;
    B=51;
    @(posedge clk);
    rst=0;
    @(posedge clk);
    init=1;
    @(posedge clk);
    init=0;
    wait(done);
    #40;
    $finish;


end

endmodule
