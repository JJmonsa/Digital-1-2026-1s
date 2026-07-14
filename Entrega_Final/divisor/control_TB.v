module control_TB;

    reg clk;
    reg rst;
    reg start;
    reg Zero;
    reg LessA;
    wire load;
    wire SHFT;
    wire update_A;
    wire set_Q;
    wire DEC;
    wire done;

control uut(.clk(clk), .rst(rst), .start(start), .Zero(Zero), .LessA(LessA), .load(load), .SHFT(SHFT), .update_A(update_A), .set_Q(set_Q), .DEC(DEC), .done(done));
initial begin
    clk = 0;
    forever#20 clk = ~clk;
end
initial begin
    $dumpfile("control_TB.vcd");
    $dumpvars(0, control_TB);
    rst=1;
    start=0;
    Zero=0;
    LessA=0;

    //primer camino init, check counter, shift, check minor, dec counter, check counter, done
    @(posedge clk);
    rst=0;
    start=1;
    @(posedge clk);
    start=0;
    repeat(2)@(posedge clk);
    LessA=1;
    @(posedge clk);
    LessA=0;
    @(posedge clk);
    Zero=1;
    @(posedge clk);
    Zero=0;
    // segundo camino init, check counter, shift, check minor, substract, dec counter,check counter, done
    @(posedge clk);
    rst=1;
    @(posedge clk);
    start=1;
    rst=0;
    @(posedge clk);
    start=0;
    repeat(5)@(posedge clk);
    Zero=1;
    @(posedge clk);
    Zero=0;
    repeat(29)@(posedge clk);
    #40;

    $finish;

end

endmodule