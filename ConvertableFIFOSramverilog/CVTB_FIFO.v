module CVTB_FIFO(
    input clk,
    input rst,
// fifo data_in control
    input [71:0] in_fifo,
    input NetFPGA_WR,
    input first_word,
    input last_word,
    input Block_Netfpga,
// fifo data_read control
    input read_load,
    input fifo_data_out,
// SRAM port
    input SRAM_ADDR_IN,
    input Mem_R2OUT,
    input Mem_MemWrite,
// Manualcontrol port    
    input Manual_WR_ADDR,
    input Manual_WR_DATA,
    input Manual_WR_EN,
// output
    output first_out,
    output last_out,
    output [71:0] Mem_DOUT,
    output [71:0] FIFO_OUT,
    output valid_data
);

wire NetFPGA_WR_EN;

assgin NetFPGA_WR_EN =  NetFPGA_WR & Block_Netfpga;

wire addr1_sel;
assgin addr1_sel = !NetFPGA_WR;

wire [7:0] addr_mux1_out;

ADDR_MUX addr_mux1(
    .sel(addr1_sel),
    .ADDR_MUX_IN1(),
    .ADDR_MUX_IN2(),
    .ADDR_MUX_OUT(addr_mux1_out)
);

ADDR_MUX addr_mux2(
    .sel(fifo_read),
    .ADDR_MUX_IN1(),
    .ADDR_MUX_IN2(Manual_WR_ADDR),
    .ADDR_MUX_OUT()
);

SP_FIFO sp_fifo_64bit(
	.clka(clk),
	.dina(),
	.addra(addr_mux1_out),
	.wea(),
	.douta(),
	.clkb(clk),
	.dinb(),
	.addrb(),
	.web(),
	.doutb());

SP_FIFO sp_fifo_8bit(
	.clka(clk),
	.dina(),
	.addra(addr_mux1_out),
	.wea(),
	.douta(),
	.clkb(clk),
	.dinb(),
	.addrb(),
	.web(),
	.doutb());