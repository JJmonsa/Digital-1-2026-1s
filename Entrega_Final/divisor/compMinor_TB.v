module compMinor_TB;

reg [16:0]A;
reg [15:0]M;
wire LessA;

compMinor uut(.A(A), .M(M), .LessA(LessA));
initial begin
    $dumpfile("compMinor_TB.vcd");
    $dumpvars(0,compMinor_TB);

    //pruebas:
    A = 17'd8;
    M = 16'd4;
    #20;

    A = 17'd37;
    M = 16'd16;
    #20;

    A = 17'd80;
    M = 16'd200;
    #20;

    A = 17'd100;
    M = 16'd100;
    #20;    
    $finish;
end
    
endmodule