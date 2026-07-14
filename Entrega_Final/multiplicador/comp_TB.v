module comp_TB;
reg [4:0] Out_C;
wire Zero;

comp uut(.Out_C(Out_C), .Zero(Zero));

initial begin
    $dumpfile("comp_TB.vcd");
    $dumpvars(0, comp_TB);

    Out_C = 5'b10101;
    #40;
    Out_C = 5'b11111;
    #40;
    Out_C = 5'b0;
    #40;
    Out_C = 6'b111111;
    #40;
    Out_C = 5'b00001;
    #40;
    Out_C = 5'b10000;
    #40;
    $finish;

end

endmodule