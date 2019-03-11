`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:31:59 02/18/2019 
// Design Name: 
// Module Name:    PipelineDatapath 
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

module PipelineDatapath
   #(
      parameter DATA_WIDTH = 64,
      parameter CTRL_WIDTH = DATA_WIDTH/8,
      parameter UDP_REG_SRC_WIDTH = 2
   )
	(
	 // --- Datastream part
		input [DATA_WIDTH-1:0]					in_data,
		input [CTRL_WIDTH-1:0]					in_ctrl,
		input 										in_wr,
		output										in_rdy,
		
		output [DATA_WIDTH-1:0]					out_data,
		output [CTRL_WIDTH-1:0]					out_ctrl,
		output										out_wr,
		input											out_rdy,
	 // --- Register interface
      input                               reg_req_in,
      input                               reg_ack_in,
      input                               reg_rd_wr_L_in,
      input  [`UDP_REG_ADDR_WIDTH-1:0]    reg_addr_in,
      input  [`CPCI_NF2_DATA_WIDTH-1:0]   reg_data_in,
      input  [UDP_REG_SRC_WIDTH-1:0]      reg_src_in,
		

      output                              reg_req_out,
      output                              reg_ack_out,
      output                              reg_rd_wr_L_out,
      output  [`UDP_REG_ADDR_WIDTH-1:0]   reg_addr_out,
      output  [`CPCI_NF2_DATA_WIDTH-1:0]  reg_data_out,
      output  [UDP_REG_SRC_WIDTH-1:0]     reg_src_out,

      // misc
      input                                reset,
      input                                clk
		
//		input [31:0]Address,
//		input [31:0]Instruction
		/*
		input [31:0]wdata_high,
		input [31:0]wdata_low,
		input [31:0]wctrl,
		input [31:0]dinb_low,
		input [31:0]dinb_high,
		input [31:0]ctrlb
		*/
    );
	 
	reg [8:0]InstCounter; 
	wire [31:0]instcounter;
	assign instcounter = InstCounter;
	reg start;
/*****************************************************************************************************************************
	WB STAGE
******************************************************************************************************************************/
	wire [63:0]WB_Dout;
	wire WB_MemtoReg;
	wire [4:0]WB_WReg1;
	wire WB_WRegEn;
	wire [63:0]WB_wdata;
	wire WB_FIFO_Info;
	wire [63:0]memnALU;
	wire [63:0]firstnlast;
/*****************************************************************************************************************************
	IF STAGE
******************************************************************************************************************************/
//sw reg
	wire [31:0]Address;
	wire [31:0]Instruction;
	
	wire [31:0]IF_Dout;
	wire InstLoad;
	assign InstLoad = Address[9];
	wire [8:0]address;
	assign address = Address[8:0];
	wire [31:0]InstructionWatcher;
	
	InstructionMemory imem(.addra(InstCounter),.wea(1'b0),.douta(IF_Dout),
								.addrb(address),.dinb(Instruction),.web(!InstLoad),.doutb(),
								.clka(clk),.clkb(clk));
	wire [31:0]ID_Inst;
	assign ID_Inst = IF_Dout;
/*****************************************************************************************************************************
	ID STAGE
******************************************************************************************************************************/	
//Control Unit
	wire [5:0]ID_EX_CTRL;
	wire [3:0]ID_MEM_CTRL;
	wire [2:0]ID_WB_CTRL;
	wire [11:0]ID_IMM;
	
	ControlUnit cu(.Instr(ID_Inst),
	.CU_EX_CTRL(ID_EX_CTRL),.CU_MEM_CTRL(ID_MEM_CTRL),.CU_WB_CTRL(ID_WB_CTRL),.CU_IMME(ID_IMM));
//RF inputs		
	wire [4:0]ID_rs1;
	wire [4:0]ID_rs2;
	wire [4:0]ID_rd;
		
	assign ID_rs1 = ID_Inst[19:15];
	assign ID_rs2 = ID_Inst[24:20];
	assign ID_rd = ID_Inst[11:7];
//RF outputs	
	wire [63:0]ID_r1data;
	wire [63:0]ID_r2data;
//hw reg	
	wire [31:0]regfileDFF0_high;
	wire [31:0]regfileDFF0_low;
//sw reg	
	wire [31:0]wdata_high;
	wire [31:0]wdata_low;
	wire [31:0]wctrl;
	
	RegFile regfile(.r0addr(ID_rs1),.r1addr(ID_rs2),.wdata(WB_wdata),.waddr(WB_WReg1),.wena(WB_WRegEn),.r0data(ID_r1data),.r1data(ID_r2data),
						.dff({regfileDFF0_high,regfileDFF0_low}),.clk(clk),
						.swena(wctrl[5]),.swaddr(wctrl[4:0]),.swdata({wdata_high,wdata_low}));

//ID-EX registers
	wire [3:0]ID_ALUopcode;
	assign ID_ALUopcode = {ID_Inst[30],ID_Inst[14:12]};

	wire [63:0]EX_R1out;
	wire [63:0]EX_R2out;
	wire [4:0]EX_rd;
	wire [3:0]EX_ALUopcode;
	wire [4:0]EX_rs2;
	wire [5:0]EX_EX_CTRL;
	wire [3:0]EX_MEM_CTRL;
	wire [2:0]EX_WB_CTRL;
	wire [11:0]EX_IMM;
	ID_EXreg id_exreg(.ID_R1out(ID_r1data),.ID_R2out(ID_r2data),.ID_WReg1(ID_rd),
							.ID_rs2(ID_rs2),.ID_EX_CTRL(ID_EX_CTRL),.ID_MEM_CTRL(ID_MEM_CTRL),.ID_WB_CTRL(ID_WB_CTRL),.ID_IMM(ID_IMM),
							
							.EX_R1out(EX_R1out),.EX_R2out(EX_R2out),.EX_WReg1(EX_rd),
							.EX_rs2(EX_rs2),.EX_EX_CTRL(EX_EX_CTRL),.EX_MEM_CTRL(EX_MEM_CTRL),.EX_WB_CTRL(EX_WB_CTRL),.EX_IMM(EX_IMM),
							.clk(clk),.reset(InstLoad));
/*****************************************************************************************************************************
	EX STAGE
******************************************************************************************************************************/
//EX stage control signal
	wire EX_ALUSrc;
	wire [3:0]EX_ALUop;
	wire EX_RegDst;
	assign EX_ALUSrc = EX_EX_CTRL[5];
	assign EX_ALUop = EX_EX_CTRL[4:1];
	assign EX_RegDst = EX_EX_CTRL[0];
//Immediate number
	wire [63:0]IMM;
	assign IMM = EX_IMM[11] ? {52'hfffffffffffff,EX_IMM} : {52'h0,EX_IMM};
//ALU part	
	wire [63:0]R2;//ALUsrc
	assign R2 = EX_ALUSrc ? IMM : EX_R2out;
	
	wire [63:0]EX_ALUoutput;
	wire EX_carry;
	wire EX_overflow;
	ALU64bit alu64bit(.A(EX_R1out),.B(R2),.Opcode(EX_ALUop),
						.ALUoutput(EX_ALUoutput),.Carry(EX_carry),.Overflow(EX_overflow));
//RF write addr
	wire [4:0]EX_WReg1;
	assign EX_WReg1 = EX_RegDst ? EX_rd : EX_rs2;
	
//EX-MEM registers
	wire [4:0]MEM_WReg1;
	wire [63:0]MEM_ALUoutput;
	wire [63:0]MEM_R2out;
	wire [3:0]MEM_MEM_CTRL;
	wire [2:0]MEM_WB_CTRL;
	wire [8:0]MEM_IMM;
	EX_MEMreg ex_memreg(.EX_WReg1(EX_WReg1),.EX_ALUoutput(EX_ALUoutput),.EX_R2out(EX_R2out),.EX_MEM_CTRL(EX_MEM_CTRL),.EX_WB_CTRL(EX_WB_CTRL),.EX_IMM(EX_IMM[8:0]),
							.MEM_WReg1(MEM_WReg1),.MEM_ALUoutput(MEM_ALUoutput),.MEM_R2out(MEM_R2out),.MEM_MEM_CTRL(MEM_MEM_CTRL),.MEM_WB_CTRL(MEM_WB_CTRL),.MEM_IMM(MEM_IMM),
							.clk(clk),.reset(InstLoad));
/*****************************************************************************************************************************
	MEM STAGE
******************************************************************************************************************************/	
//MEM stage control signal
	wire MEM_Jump;
	wire [1:0]MEM_Branch;
	wire MEM_WMemEn;
	assign MEM_Jump = MEM_MEM_CTRL[1];
	assign MEM_Branch = MEM_MEM_CTRL[3:2];
	assign MEM_WMemEn = MEM_MEM_CTRL[0];
//branch
	wire equal;
	wire beq;
	wire bne;
	wire blt;
	assign equal = !(|MEM_ALUoutput[7:0]);
	assign beq = equal & !MEM_Branch[1] & !MEM_Branch[0];
	assign bne = !equal & !MEM_Branch[1] & MEM_Branch[0];
	assign blt = MEM_ALUoutput[63] & MEM_Branch[1] & !MEM_Branch[0];
//data memory outputs
	wire [63:0]MEM_Dout;
//sw reg
	wire [31:0]dinb_low;
	wire [31:0]dinb_high;
	wire [31:0]ctrlb;
//hw reg	
	wire [31:0]doutb_high;
	wire [31:0]doutb_low;
	wire [7:0]a;
//FIFO signals	
	wire [7:0]MEM_first_out;
	wire [7:0]MEM_last_out;
	wire full;
	wire connect;
	assign connect = ctrlb[9];
	wire manualreset;
	assign manualreset = ctrlb[10];
 
//	DataMemory datamemory(.addra(MEM_ALUoutput[7:0]),.dina(MEM_R2out),.wea(MEM_WMemEn),.clka(clk),.douta(MEM_Dout),
//								.addrb(ctrlb[7:0]),.dinb({dinb_high,dinb_low}),.web(ctrlb[8]),.clkb(clk),.doutb({doutb_high,doutb_low}));

	FIFO_SRAM fifosram(.in_data(in_data),.in_ctrl(in_ctrl),.in_wr(in_wr),.in_rdy(in_rdy),
							.out_data(out_data),.out_ctrl(out_ctrl),.out_wr(out_wr),.out_rdy(out_rdy),
							.data_processed(beq),.connect(connect),
							.first_addr(MEM_first_out),.last_addr(MEM_last_out),.full(full),
//							.reg_req_in,.reg_ack_in,.reg_rd_wr_L_in,.reg_addr_in,.reg_data_in,.reg_src_in,
//							.reg_req_out,.reg_ack_out,.reg_rd_wr_L_out,.reg_addr_out,.reg_data_out,.reg_src_out,
							.Mem_MemWrite(MEM_WMemEn),.MEM_R2out(MEM_R2out),.addra(MEM_ALUoutput[7:0]),
							.MEM_WB_DATA_IN({a,MEM_Dout}),
							
							.rst(reset||manualreset),.clk(clk));
							
	assign doutb_high = out_data[63:32];
	assign doutb_low = out_data[31:0];
	assign InstructionWatcher = {in_wr,in_rdy,out_rdy,beq,full,InstLoad && full,InstCounter};

//MEM-WB registers	
	wire [63:0]WB_ALUoutput;
	wire [2:0]WB_WB_CTRL;
	wire [7:0]WB_first_out;
	wire [7:0]WB_last_out;
	MEM_WBreg mem_wbreg(.MEM_WReg1(MEM_WReg1),.MEM_ALUoutput(MEM_ALUoutput),.MEM_WB_CTRL(MEM_WB_CTRL),.first_in(MEM_first_out),.last_in(MEM_last_out),
							.WB_WReg1(WB_WReg1),.WB_ALUoutput(WB_ALUoutput),.WB_WB_CTRL(WB_WB_CTRL),.first_out(WB_first_out),.last_out(WB_last_out),
							.clk(clk),.reset(InstLoad));
	assign WB_Dout = MEM_Dout;
/*****************************************************************************************************************************
	WB STAGE
******************************************************************************************************************************/
//WB stage control signal
	assign WB_FIFO_Info = WB_WB_CTRL[2];
	assign WB_MemtoReg = WB_WB_CTRL[1];
	assign WB_WRegEn = WB_WB_CTRL[0];
	
	assign memnALU = WB_MemtoReg ? WB_Dout : WB_ALUoutput;
	assign firstnlast = WB_MemtoReg ? {56'h00000000000000,WB_last_out} : {56'h00000000000000,WB_first_out};
	assign WB_wdata = WB_FIFO_Info ? firstnlast : memnALU;

/*****************************************************************************************************************************
	DATA STREAM
******************************************************************************************************************************/


/*****************************************************************************************************************************
	REGISTER INTERFACE
******************************************************************************************************************************/	
	generic_regs
   #( 
      .UDP_REG_SRC_WIDTH   (UDP_REG_SRC_WIDTH),
      .TAG                 (`PIPE_BLOCK_ADDR),          // Tag -- eg. MODULE_TAG
      .REG_ADDR_WIDTH      (`PIPE_REG_ADDR_WIDTH),     // Width of block addresses -- eg. MODULE_REG_ADDR_WIDTH
      .NUM_COUNTERS        (0),                 // Number of counters
      .NUM_SOFTWARE_REGS   (8),                 // Number of sw regs
      .NUM_HARDWARE_REGS   (5)                  // Number of hw regs
   ) module_regs (
      .reg_req_in       (reg_req_in),
      .reg_ack_in       (reg_ack_in),
      .reg_rd_wr_L_in   (reg_rd_wr_L_in),
      .reg_addr_in      (reg_addr_in),
      .reg_data_in      (reg_data_in),
      .reg_src_in       (reg_src_in),

      .reg_req_out      (reg_req_out),
      .reg_ack_out      (reg_ack_out),
      .reg_rd_wr_L_out  (reg_rd_wr_L_out),
      .reg_addr_out     (reg_addr_out),
      .reg_data_out     (reg_data_out),
      .reg_src_out      (reg_src_out),

      // --- counters interface
      .counter_updates  (),
      .counter_decrement(),

      // --- SW regs interface
      .software_regs    ({Address,Instruction,wdata_low,wdata_high,wctrl,dinb_low,dinb_high,ctrlb}),

      // --- HW regs interface
      .hardware_regs    ({doutb_low,doutb_high,regfileDFF0_low,regfileDFF0_high,InstructionWatcher}),

      .clk              (clk),
      .reset            (reset)
    );


/*****************************************************************************************************************************
	INSTRUCTION COUNTER
******************************************************************************************************************************/	
	initial
	begin
		InstCounter = 0;
		start = 0;
	end
	
	always @(posedge clk)
	begin
		
		if(full && InstLoad)
		begin
			if(start)
			begin
				if(beq || bne || blt || MEM_Jump)
					InstCounter <= MEM_IMM;
				else
				begin
					if(InstCounter < 9'b111111111)
						InstCounter <= InstCounter + 1;
					else
						InstCounter <= 9'b000000000;
				end
			end
			else
				start <= 1;
		end
		else
		begin
			InstCounter <= 0;
		end
			
	end

endmodule
