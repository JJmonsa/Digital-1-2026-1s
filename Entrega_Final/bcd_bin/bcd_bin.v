module bcd_bin(clk, rst, init, BCD, Bin, done);
input clk;
input rst;
input init;
input [19:0]BCD;
output [15:0]Bin;
output done;
wire Load;
wire SHFT;
wire subtract;
wire DEC;
wire Zero;
wire [19:0] bcd_reg;
wire [19:0] sub_bcd;
wire [4:0] update;

combrsr combrsr0(.clk(clk), .Load(Load), .SHFT(SHFT), .subtract(subtract), .update(update), .in_bcd(BCD), .sub_bcd(sub_bcd), .Bin_out(Bin), .BCD_out(bcd_reg));
comp comp0(.in_comp(bcd_reg[3:0]), .update(update[0]));
comp comp1(.in_comp(bcd_reg[7:4]), .update(update[1]));
comp comp2(.in_comp(bcd_reg[11:8]), .update(update[2]));
comp comp3(.in_comp(bcd_reg[15:12]), .update(update[3]));
comp comp4(.in_comp(bcd_reg[19:16]), .update(update[4]));
subtractor sub0(.in_nibble(bcd_reg[3:0]), .sub_bcd(sub_bcd[3:0]));
subtractor sub1(.in_nibble(bcd_reg[7:4]), .sub_bcd(sub_bcd[7:4]));
subtractor sub2(.in_nibble(bcd_reg[11:8]), .sub_bcd(sub_bcd[11:8]));
subtractor sub3(.in_nibble(bcd_reg[15:12]), .sub_bcd(sub_bcd[15:12]));
subtractor sub4(.in_nibble(bcd_reg[19:16]), .sub_bcd(sub_bcd[19:16]));
counter counter0(.clk(clk), .DEC(DEC), .Load(Load), .Zero(Zero));
control control0(.clk(clk), .init(init), .Zero(Zero), .rst(rst), .Load(Load), .SHFT(SHFT), .subtract(subtract), .DEC(DEC), .done(done));

   
endmodule