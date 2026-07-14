module comp (out_c, Zero);
    //entrada del comparador
    input [3:0]out_c;
    // salida del comparador
    output Zero;
    // comparación
    assign Zero = (out_c == 0);   
endmodule