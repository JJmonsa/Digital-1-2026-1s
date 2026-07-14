module comp_TB;
reg [3:0]in_comp;
wire update;

comp uut(.in_comp(in_comp), .update(update));
initial begin
    $dumpfile("comp_TB.vcd");
    $dumpvars(0,comp_TB);

    in_comp=4'b1111;
    #20;
    in_comp=4'b0;
    #20;
    in_comp=4'b1;
    #20;
    in_comp=4'b0101;
    #20;
    in_comp=4'd4;
    #20;
end 
endmodule
