//comparador para determinar si el contador terminó
module compZero (Out_C, Zero);
    //entrada y salida
    input [4:0]Out_C;
    output Zero;
    //comparación
    assign Zero = (Out_C == 0);
endmodule