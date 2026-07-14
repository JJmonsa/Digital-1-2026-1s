module subtractor_TB;
    reg [16:0]A;
    reg [15:0]M;
    wire [16:0]A_sub;

subtractor uut(.A(A), .M(M), .A_sub(A_sub));
initial begin
    $dumpfile("subtractor_TB.vcd");
    $dumpvars(0, subtractor_TB);

    A = 17'd11;
    M = 16'd4;
    #20;
    
    A = 17'd1; // Para visualizar el resultado bien se debe colocar en GTKwave los datos en Signed decimal
    M = 16'd8;
    #20;

    A = 17'd10000; // Para visualizar el resultado bien se debe colocar en GTKwave los datos en Signed decimal
    M = 16'd20000;
    #20;

    A = 17'd50;
    M = 16'd50;
    #20;
    $finish;

end
endmodule
