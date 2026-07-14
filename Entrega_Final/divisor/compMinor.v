// Comparador de A<M
module compMinor (A, M , LessA);
    //entradas y salida
    input [16:0] A;
    input [15:0] M;
    output LessA;

    //comparación
    assign LessA = (A < {1'b0,M});

endmodule