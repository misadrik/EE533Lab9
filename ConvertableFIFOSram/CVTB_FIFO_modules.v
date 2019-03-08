module counter_eight(
    input [7:0] Din,
    input Load,
    input CE,
    input rst,
    input clk,
    output [7:0] Counter_OUT
)

wire COUT_next;

always @(*)
    if(Load)
        COUT_next <= Din;
    else
        COUT_next <= Counter_OUT + 1;


always @(posedge clk or negedge rst)
    if(rst)begin
      Counter_OUT <=0;
    end
    else if(CE)
      Counter_OUT <= COUT_next;
endmodule