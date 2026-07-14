module regAQ_TB;

    reg clk;
    reg set_Q;
    reg load;
    reg SHFT;
    reg update_A;
    reg [15:0] in_Q;
    reg [16:0] A_sub;
    wire [16:0] A;
    wire [15:0] Q;

regAQ uut(.clk(clk), .set_Q(set_Q), .load(load), .SHFT(SHFT), .update_A(update_A), .in_Q(in_Q), .A_sub(A_sub), .A(A), .Q(Q));
initial begin
    clk = 0;
    forever #20 clk = ~clk;
end

initial begin
    $dumpfile("regAQ_TB.vcd");
    $dumpvars(0, regAQ_TB);

    //estado inicial
    load = 0;
    SHFT = 0;
    update_A = 0;
    set_Q = 0;
    in_Q = 16'd0;
    A_sub = 17'd0;

    in_Q = 16'b1010101010101010;
    @(posedge clk);
    load=1;
    @(posedge clk);
    load=0;
    @(posedge clk);
    SHFT=1;
    repeat(3)@(posedge clk);
    SHFT=0;
    A_sub=17'b11100011100011100;
    @(posedge clk);
    update_A=1;
    @(posedge clk);
    update_A=0;
    in_Q=16'b1000000000000000;
    @(posedge clk);
    load=1;
    @(posedge clk);
    load=0;
    @(posedge clk);
    set_Q=1;
    @(posedge clk);
    set_Q=0;
    #20;

    $finish;

end

endmodule
