module comp_TB;
reg [3:0]out_c;
wire Zero;

comp uut(.out_c(out_c), .Zero(Zero));

initial begin
    $dumpfile("comp_TB.vcd");
    $dumpvars(0, comp_TB);

    out_c = 4'b1010;
    #40;
    out_c = 4'b1111;
    #40;
    out_c = 4'b0;
    #40;
    out_c = 4'b0001;
    #40;
    out_c = 4'b1000;
    #40;
    $finish;

end

endmodule