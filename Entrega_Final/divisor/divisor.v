module divisor (clk, rst, start, Q, M, Cociente, Residuo, done);
//entradas y salidas
input clk;
input rst;
input start;
input [15:0] Q;
input [15:0] M;
output [15:0] Cociente;
output [16:0] Residuo;
output done;

// señales de control 
wire load;
wire SHFT;
wire update_A;
wire set_Q;
wire DEC;

wire [16:0] w_A;
wire [15:0] w_Q;
wire [16:0] A_sub;
wire [4:0] Out_C;
wire Zero;
wire LessA;

regAQ AQ0(.clk(clk), .set_Q(set_Q), .load(load), .SHFT(SHFT), .update_A(update_A), .in_Q(Q), .A_sub(A_sub), .A(w_A), .Q(w_Q));
subtractor sub0(.A(w_A), .M(M), .A_sub(A_sub));
Counter c0(.clk(clk), .load(load), .DEC(DEC), .Out_C(Out_C));
compZero czero0(.Out_C(Out_C), .Zero(Zero));
compMinor cminor0(.A(w_A), .M(M) , .LessA(LessA));
control ctrl0(.clk(clk), .rst(rst), .start(start), .Zero(Zero), .LessA(LessA), .load(load), .SHFT(SHFT), .update_A(update_A), .set_Q(set_Q), .DEC(DEC), .done(done));
assign Residuo = w_A;
assign Cociente = w_Q;


endmodule