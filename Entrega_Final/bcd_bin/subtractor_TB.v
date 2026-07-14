module subtractor_TB;
reg [3:0] in_nibble;
wire [3:0] sub_bcd;
subtractor uut(.in_nibble(in_nibble), .sub_bcd(sub_bcd));
initial begin
    $dumpfile("subtractor_TB.vcd");
    $dumpvars(0, subtractor_TB);

    in_nibble=4'd14;
    #40;
    in_nibble=4'd0;
    #40;
    in_nibble=4'd1;
    #40;
    in_nibble=4'd3;
    #40;
    $finish;
    
end
endmodule
