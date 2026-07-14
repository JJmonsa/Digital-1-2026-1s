module combrsr_TB;
    reg clk;
    reg Load;
    reg SHFT;
    reg subtract;
    reg [4:0]update;
    reg [19:0]in_bcd;
    reg [19:0]sub_bcd;
    wire [15:0]Bin_out;
    wire [19:0]BCD_out;

combrsr uut(.clk(clk), .Load(Load), .SHFT(SHFT), .subtract(subtract), .update(update), .in_bcd(in_bcd), .sub_bcd(sub_bcd), .Bin_out(Bin_out), .BCD_out(BCD_out));

initial begin
    clk = 0;
    forever #20 clk = ~clk;
end
initial begin
    $dumpfile("combrsr_TB.vcd");
    $dumpvars(0, combrsr_TB);
    
    Load=0;
    SHFT=0;
    subtract=0;
    update=5'b0;

    in_bcd = 20'd999;
    @(posedge clk);
    Load=1;
    @(posedge clk);
    Load=0;
    #40;
    @(posedge clk);
    SHFT=1;
    repeat(5)@(posedge clk);
    SHFT=0;
    #40;
    @(posedge clk);
    sub_bcd = 20'b00110011001100110011;
    subtract=1;
    @(posedge clk);
    subtract=0;
    @(posedge clk);
    update=5'b11111;
    subtract=1;
    @(posedge clk);
    update=5'b0;
    sub_bcd=20'b10101010101010101010; // el registro no se actualiza si los updates son 0
    subtract=0;
    in_bcd=0;
    @(posedge clk);
    Load=1;
    @(posedge clk);
    Load=0;
    #40;
    $finish;
end
    
endmodule