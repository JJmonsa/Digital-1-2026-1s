module comblsr_TB;
reg clk;
reg SHFT;
reg add;
reg Load;
reg [4:0] update;
reg [15:0] in_Bin;
reg [19:0] in_bcd;
wire [19:0] BCD_Out;

comblsr uut(.clk(clk), .update(update), .SHFT(SHFT), .add(add), .Load(Load), .in_Bin(in_Bin), .in_bcd(in_bcd), .BCD_Out(BCD_Out));
initial begin
    clk = 0;
    forever #20 clk = ~clk;
end
initial begin
    $dumpfile("comblsr_TB.vcd");
    $dumpvars(0,comblsr_TB);

    SHFT = 0;
    add=0;
    Load=0;
    update=0;
    in_Bin=0;
    in_bcd=0;

    in_Bin=16'd720;
    Load=1;
    repeat(2)@(posedge clk);
    Load=0;
    @(posedge clk);
    SHFT=1;
    repeat(5)@(posedge clk);
    SHFT=0;
    @(posedge clk);
    update = 5'b10000;
    in_bcd = 20'b00110011001100110011;
    add=1;
    @(posedge clk);
    add=0;
    @(posedge clk);
    update = 5'b10101;
    add=1;
    @(posedge clk);
    add=0;
    #20;
    @(posedge clk);
    update = 5'b11111;
    add=1;
    @(posedge clk);
    add=0;
    #40;
    @(posedge clk);
    SHFT=1;
    repeat(5)@(posedge clk);
    SHFT=0;
    update = 5'b11111;
    add=1;
    @(posedge clk);
    add=0;
    #80;
    in_Bin=16'd65535;
    @(posedge clk);
    Load=1;
    @(posedge clk);
    Load=0;
    #80;
    $finish;

end

endmodule
