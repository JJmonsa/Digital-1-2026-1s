module regA_TB;
reg clk;
reg Load;
reg SHFT;
reg [8:0] in_bits;
wire LSB;

regA uut(.clk(clk), .Load(Load), .SHFT(SHFT), .in_bits(in_bits), .LSB(LSB));

initial begin
    clk =0;
    forever #20 clk =~clk;
end
initial begin
    $dumpfile("regA_TB.vcd");
    $dumpvars(0,regA_TB);

    Load=0;
    SHFT=0;
    in_bits=9'b000011111;
    @(posedge clk);
    Load=1;
    @(posedge clk);
    Load=0;
    SHFT=1;
    repeat(6)@(posedge clk);
    SHFT=0;
    #40;
    in_bits=9'b111111111;
    @(posedge clk);
    Load=1;
    @(posedge clk);
    Load=0;
    SHFT=1;
    repeat(11)@(posedge clk);
    SHFT=0;
    #40;
    in_bits=9'b010101010;
    @(posedge clk);
    Load=1;
    @(posedge clk);
    SHFT=1;
    Load=0;
    repeat(10)@(posedge clk);
    SHFT=0;
    #40;

    $finish;
end

    
endmodule

