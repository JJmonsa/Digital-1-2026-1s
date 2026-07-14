module raiz (clk, rst, init, Rad, Root, done);
    // entradas
    input clk;
    input rst;
    input init;
    input [15:0] Rad;
    //salidas
    output [7:0] Root;
    output done;
    //señales de control
    wire load;
    wire shift;
    wire load_Temp;
    wire setRoot;
    wire Dec;
    wire update_RAC;

    wire [15:0] w_RAC;
    wire [15:0] w_Rad;
    wire [7:0] w_Root;
    wire [7:0] w_Temp;
    wire [16:0] SUM;
    wire [3:0] out_c;
    wire Neg;
    wire Zero;

regRACRad Racrad0(.clk(clk), .load(load), .shift(shift), .update_RAC(update_RAC), .in_Rad(Rad), .SUM(SUM), .RAC(w_RAC), .Rad(w_Rad));
regRoot Root0(.clk(clk), .load(load), .shift(shift), .setRoot(setRoot), .Root(w_Root));
regTemp temp0(.clk(clk), .load(load), .load_Temp(load_Temp), .Temp(w_Temp), .Root(w_Root));
Subtractor sub0(.RAC(w_RAC), .Temp(w_Temp), .SUM(SUM), .Neg(Neg));
comp comp0(.out_c(out_c), .Zero(Zero));
counter cont0(.clk(clk), .load(load), .Dec(Dec), .out_c(out_c));
control ctrl0(.clk(clk), .rst(rst), .init(init), .Zero(Zero), .Neg(Neg), .load(load), .shift(shift), .load_Temp(load_Temp), .setRoot(setRoot), .Dec(Dec), .update_RAC(update_RAC), .done(done));
assign Root = w_Root;

endmodule