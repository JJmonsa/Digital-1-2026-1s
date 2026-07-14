module parity (clk, rst, init, in_bits, bits1, parity, done);
input rst;
input clk;
input init;
input [8:0]in_bits;
output [3:0]bits1;
output parity;
output done;

wire Load;
wire SHFT;
wire DEC;
wire INC;
wire Zero;
wire LSB;

regA regA0(.clk(clk), .Load(Load), .SHFT(SHFT), .in_bits(in_bits), .LSB(LSB));
onesCount onesCount0(.clk(clk), .Load(Load), .INC(INC), .parity(parity), .bits1(bits1));
counter counter0(.clk(clk), .Load(Load), .DEC(DEC), .Zero(Zero));
control control0(.clk(clk), .rst(rst), .init(init), .Zero(Zero), .LSB(LSB), .Load(Load), .SHFT(SHFT), .DEC(DEC), .INC(INC), .done(done));

endmodule