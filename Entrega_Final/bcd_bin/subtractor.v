module subtractor (in_nibble, sub_bcd);
input [3:0] in_nibble;
output[3:0] sub_bcd;
assign sub_bcd = in_nibble - 4'd3;
endmodule