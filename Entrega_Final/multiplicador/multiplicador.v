module multiplicador (clk, rst, init, A, B, R, done);
//señales externas
input clk;
input rst;
input init;
output done;

//entradas y salidas
input [15:0]A;
input [15:0]B;
output [31:0]R;

//señales internas
wire Shft_Dec;
wire ADD;
wire load;
wire w_Zero;
wire [31:0] w_A;
wire [15:0] w_B;
wire [4:0] w_C;

//implementacion de modulos
RCD RCD0(.clk(clk), .in_B(B), .load(load), .Shft_Dec(Shft_Dec), .Out_B(w_B));
RCI RCI0(.clk(clk), .load(load), .in_A(A), .Shft_Dec(Shft_Dec), .Out_A(w_A));
ACCR ACCR0(.clk(clk), .A(w_A), .ADD(ADD), .reset(load), .R(R));
Counter Counter0(.clk(clk), .load(load), .Shft_Dec(Shft_Dec), .Out_C(w_C));
comp comp0(.Out_C(w_C), .Zero(w_Zero));
control control0(.clk(clk), .rst(rst), .init(init), .LSB(w_B[0]), .Zero(w_Zero), .ADD(ADD), .load(load), .Shft_Dec(Shft_Dec), .done(done));

endmodule