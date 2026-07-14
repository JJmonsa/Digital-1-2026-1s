module bin2bcd (clk, rst, init, Bin, BCD, done);

input clk;
input rst;
input init;
input [15:0] Bin;
output [19:0] BCD;
output done;

wire Load;
wire SHFT;
wire add;
wire DEC;
wire Zero;
wire [19:0] bcd_reg;
wire [19:0] bcd_add;
wire [4:0] update;

comblsr REG0(.clk(clk), .update(update), .SHFT(SHFT), .add(add), .Load(Load), .in_Bin(Bin), .in_bcd(bcd_add), .BCD_Out(bcd_reg));
comp comp0(.in_comp(bcd_reg[3:0]), .update(update[0]));
comp comp1(.in_comp(bcd_reg[7:4]), .update(update[1]));
comp comp2(.in_comp(bcd_reg[11:8]), .update(update[2]));
comp comp3(.in_comp(bcd_reg[15:12]), .update(update[3]));
comp comp4(.in_comp(bcd_reg[19:16]), .update(update[4]));
sum sum0(.in_nibble(bcd_reg[3:0]), .out_nibble(bcd_add[3:0]));
sum sum1(.in_nibble(bcd_reg[7:4]), .out_nibble(bcd_add[7:4]));
sum sum2(.in_nibble(bcd_reg[11:8]), .out_nibble(bcd_add[11:8]));
sum sum3(.in_nibble(bcd_reg[15:12]), .out_nibble(bcd_add[15:12]));
sum sum4(.in_nibble(bcd_reg[19:16]), .out_nibble(bcd_add[19:16]));
counter counter0(.clk(clk), .DEC(DEC), .Load(Load), .Zero(Zero));
control control0(.clk(clk), .rst(rst), .init(init), .Zero(Zero), .Load(Load), .SHFT(SHFT), .add(add), .DEC(DEC), .done(done));
assign BCD=bcd_reg;
    
endmodule