module ACCR_TB;
reg clk;
reg ADD;
reg reset;
reg [31:0]A;
wire [31:0] R;

ACCR uut(.clk(clk), .A(A), .ADD(ADD), .reset(reset), .R(R));

initial begin
    clk = 0;
    forever #20clk=~clk;
end
initial begin
    $dumpfile("ACCR_TB.vcd");
    $dumpvars(0, ACCR_TB);

    reset=1;
    ADD=0;
    A=32'd10;
    @(negedge clk);
    reset=0;
    @(negedge clk);
    ADD=1;
    @(negedge clk);
    ADD=0;
    #40;
    A=32'd115;
    @(negedge clk);
    ADD=1;
    @(negedge clk);
    ADD=0;
    @(negedge clk);
    reset=1;
    @(negedge clk);
    reset=0;
    #40;
    A=32'b11111111111111111111111111111111;
    ADD=1;
    #20;
    ADD=0;
    #40;
    ADD=1;
    #40;
    ADD=0;
    #80;
    $finish;

end
endmodule
