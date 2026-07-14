module sum (in_nibble, out_nibble);
    input [3:0] in_nibble;
    output [3:0] out_nibble;
    assign out_nibble = in_nibble + 4'd3;    
endmodule