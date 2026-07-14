module sum_TB;
    reg [3:0] in_nibble;
    wire [3:0] out_nibble;
sum uut(.in_nibble(in_nibble), .out_nibble(out_nibble));
initial begin
    $dumpfile("sum_TB.vcd");
    $dumpvars(0,sum_TB);

    in_nibble=4'b1111;
    #20;
    in_nibble=4'b0;
    #20;
    in_nibble=4'b1;
    #20;
    in_nibble=4'b0011;
    #20;
    in_nibble=4'b0101;
    #20;
    $finish;
end
endmodule
