// registro combinado AQ
module regAQ (clk, set_Q, load, SHFT, update_A, in_Q, A_sub, A, Q);

    //Señales de control
    input clk;
    input set_Q;
    input load;
    input SHFT;
    input update_A;
    //Entradas
    input [15:0] in_Q;
    input [16:0] A_sub;
    //Salidas
    output reg[16:0] A;
    output reg[15:0] Q;

always @(posedge clk) 
begin
    if (load) 
    begin
        A <= 17'b0;
        Q <= in_Q;   
    end
    else if (SHFT) 
    begin
        {A,Q} <= {A,Q} <<1;   
    end
    else 
    begin
        if (update_A) 
            A <= A_sub;
        if (set_Q)
            Q[0] <= 1'b1;
    end
end

endmodule