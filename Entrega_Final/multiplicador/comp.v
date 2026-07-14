module comp (Out_C, Zero);
//entradas y salidas
input [4:0] Out_C;
output Zero;
//comparación
assign Zero = (Out_C==0);
endmodule