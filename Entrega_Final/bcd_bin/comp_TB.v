module comp_TB;
reg [3:0]in_comp;
wire update;

comp uut(.in_comp(in_comp), .update(update));

initial begin
    $dumpfile("comp_TB.vcd");
    $dumpvars(0, comp_TB);

    in_comp = 4'd7;
    #40;
    in_comp = 4'd8;
    #40;
    in_comp = 4'd0;
    #40;
    in_comp = 4'd15;
    #40;
    $finish;
end
endmodule