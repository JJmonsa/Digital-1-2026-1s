module comp (in_comp, update);
input [3:0]in_comp;
output update;
assign update = (in_comp >= 4'd8);
endmodule