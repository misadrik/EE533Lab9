module DATA_MUX(DATA_MUX_IN1, DATA_MUX_IN2, sel, DATA_MUX_OUT);
input [71:0] DATA_MUX_IN1,DATA_MUX_IN2;
input sel;
output [71:0] DATA_MUX_OUT;

assign DATA_MUX_OUT = sel ? DATA_MUX_IN2 : DATA_MUX_IN1;

endmodule