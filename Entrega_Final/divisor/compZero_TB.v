module compZero_TB;
    reg [4:0]Out_C;
    wire Zero;
compZero uut(.Out_C(Out_C), .Zero(Zero));
initial begin
    $dumpfile("compZero_TB.vcd");
    $dumpvars(0,compZero_TB);

    //pruebas
    Out_C = 5'd15;
    #20;

    Out_C = 5'd0;
    #20;

    Out_C = 5'd31;
    #20;

    $finish;
end

endmodule