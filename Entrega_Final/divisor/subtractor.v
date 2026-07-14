//restador suma complemento a 2
module subtractor (A, M, A_sub);
    // entradas y Salidas
    input [16:0] A;
    input [15:0] M;
    output [16:0] A_sub;
    
    //complemento a 2
    wire [16:0] comp2_M;
    assign comp2_M = ~{1'b0,M} + 1'b1;
    assign A_sub = A + comp2_M;
    
endmodule