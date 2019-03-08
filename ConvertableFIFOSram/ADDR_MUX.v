module ADDR_MUX(ADDR_MUX_IN1, ADDR_MUX_IN2,sel,ADDR_MUX_OUT);
input [7:0] ADDR_MUX_IN1,ADDR_MUX_IN2;
input sel;
output [7:0] ADDR_MUX_OUT;

assign ADDR_MUX_OUT = sel ? ADDR_MUX_IN2:ADDR_MUX_IN1;

endmodule

