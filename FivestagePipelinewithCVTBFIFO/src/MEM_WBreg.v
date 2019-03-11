`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:09:05 02/18/2019 
// Design Name: 
// Module Name:    MEM_WBreg 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MEM_WBreg(
    input [4:0] MEM_WReg1,
	 input [63:0] MEM_ALUoutput,
	 input [2:0] MEM_WB_CTRL,
	 input [7:0]first_in,
	 input [7:0]last_in,

	 output [4:0]WB_WReg1,
	 output [63:0]WB_ALUoutput,
	 output [2:0]WB_WB_CTRL,
	 output [7:0]first_out,
	 output [7:0]last_out,
	 
    input clk,
	 input reset
    );
	 
	reg [4:0] WReg1;
	reg [63:0]ALUoutput;
	reg [2:0]WB_CTRL;
	reg [7:0]first_addr;
	reg [7:0]last_addr;
	
	assign WB_WReg1 = WReg1;
	assign WB_ALUoutput = ALUoutput;
	assign WB_WB_CTRL = WB_CTRL;
	assign first_out = first_addr;
	assign last_out = last_addr;
	
	always @(posedge clk,negedge reset)
	begin
		if(!reset)
		begin
			WReg1 <= 0;
			ALUoutput <= 0;
			WB_CTRL <= 0;
			first_addr <= 0;
			last_addr <= 0;
		end
		else
		begin
			WReg1 <= MEM_WReg1;
			ALUoutput <= MEM_ALUoutput;
			WB_CTRL <= MEM_WB_CTRL;
			first_addr <= first_in;
			last_addr <= last_in;
		end
	end

endmodule
