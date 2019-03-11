module FIFO_SRAM
   #(
      parameter DATA_WIDTH = 64,
      parameter CTRL_WIDTH = DATA_WIDTH/8,
      parameter UDP_REG_SRC_WIDTH = 2
   )(
      input  [DATA_WIDTH-1:0]             in_data,
      input  [CTRL_WIDTH-1:0]             in_ctrl,
      input                               in_wr,
      output                              in_rdy,

      output [DATA_WIDTH-1:0]             out_data,
      output [CTRL_WIDTH-1:0]             out_ctrl,
      output                              out_wr,
      input                               out_rdy,

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
      input                                rst,
      input                                clk,
		
		input [63:0] MEM_R2out,
		input [7:0] addra,
		input Mem_MemWrite,
      output [71:0] MEM_WB_DATA_IN,
		
		input connect,
		
      input data_processed,
      input fifo_read,
		output [7:0]first_addr,
		output [7:0]last_addr,
		output full
      
   );
   
   // wire [31:0]data_processed32;
//   reg data_processed;
   // assign data_processed =data_processed32[0];
	
	wire DataProcessed;
	reg FIFOprocessed;

   reg [1:0] state_next, state;
   reg [2:0] header_counter_next, header_counter;
   
   reg end_of_pkt_next, end_of_pkt;
   reg in_pkt_body_next, in_pkt_body;
   reg begin_pkt_next, begin_pkt;

   reg fifo_sram_full;

   wire in_fifo_nearly_full;
   wire in_fifo_empty;

   reg in_fifo_rd;
   wire in_fifo_rd_en;
   wire fifo_data_out;

   reg out_wr_int;

   reg fifo_sram_full_flag;

   wire valid_data;

   reg [CTRL_WIDTH-1:0] in_fifo_ctrl;
   reg [DATA_WIDTH-1:0] in_fifo_data;

   wire [CTRL_WIDTH-1:0] in_fifo_ctrl_p;
   wire [DATA_WIDTH-1:0] in_fifo_data_p;

   //control signals
   reg fifo_output_en;

   parameter       START = 2'b00;
   parameter       HEADER = 2'b01;
   parameter       PAYLOAD = 2'b10;

/* -------      Modules       ----------*/
assign in_rdy = !in_fifo_nearly_full;
assign in_fifo_rd_en = !in_fifo_empty && in_fifo_rd;

fallthrough_small_fifo #(
   .WIDTH(CTRL_WIDTH+DATA_WIDTH),
   .MAX_DEPTH_BITS(2)
) input_fifo (
   .din           ({in_ctrl, in_data}),   // Data in
   .wr_en         (in_wr),                // Write enable
   .rd_en         (in_fifo_rd_en),        // Read the next word 
   .dout          ({in_fifo_ctrl_p, in_fifo_data_p}),
   .full          (),
   .nearly_full   (in_fifo_nearly_full),
   .empty         (in_fifo_empty),
   .reset         (rst),
   .clk           (clk)
);
assign fifo_data_out = valid_data&out_rdy&fifo_output_en;

wire [7:0] first_out;
wire [7:0] last_out;
assign first_addr = first_out;
assign last_addr = last_out;

// wire [31:0] FIRST_ADDR;
// assign FIRST_ADDR ={16'h0000, first_out, last_out};

CVTB_FIFO cvtb_fifo(
   .clk(clk),               
   .fifo_read(0),//manual write
   .fifo_data_out(fifo_data_out), 
   .first_word(begin_pkt), 
   .in_fifo({in_fifo_ctrl,in_fifo_data}), 
   .Mem_MemWrite(Mem_MemWrite), 
   .Netfpga_Write(in_fifo_rd),
   .last_word(end_of_pkt), 
   .Mem_R2OUT({8'h00,MEM_R2out}), 
   .rst(rst), 
   .SRAM_ADDRIN(addra), 
   .MEM_Dout(MEM_WB_DATA_IN), 
   .out_fifo({out_ctrl, out_data}), 
   .valid_data(valid_data),
   .read_load(DataProcessed),
   .first_out(first_out),
   .last_out(last_out),
   .Manual_Write_ADDR(0),
   .Manual_WR_DATA(0),
   .Manual_WR_EN(0)
   );

/*
 generic_regs
   #( 
      .UDP_REG_SRC_WIDTH   (UDP_REG_SRC_WIDTH),
      .TAG                 (`IDS_BLOCK_ADDR),          // Tag -- eg. MODULE_TAG
      .REG_ADDR_WIDTH      (`IDS_REG_ADDR_WIDTH),     // Width of block addresses -- eg. MODULE_REG_ADDR_WIDTH
      .NUM_COUNTERS        (0),                 // Number of counters
      .NUM_SOFTWARE_REGS   (1),                 // Number of sw regs
      .NUM_HARDWARE_REGS   (1)                  // Number of hw regs
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
      .software_regs    (data_processed32),

      // --- HW regs interface
      .hardware_regs    (FIRST_ADDR),

      .clk              (clk),
      .reset            (rst)
    );
*/
reg out_rdy_clk;

assign out_wr = out_wr_int&out_rdy_clk;
assign full = fifo_sram_full;
assign DataProcessed = connect ? data_processed : FIFOprocessed;


// logic  
 always @(*) begin
      state_next = state;
      header_counter_next = header_counter;
      // out_wr_int = 0;
      //out_data = 0;
      end_of_pkt_next = end_of_pkt;
      in_pkt_body_next = in_pkt_body;
      begin_pkt_next = begin_pkt;

      if (!valid_data&&fifo_output_en)begin
         fifo_sram_full_flag=0;
      end
      
      // if (!in_fifo_empty && out_rdy) begin
         if(!in_fifo_empty && !fifo_sram_full) begin
            // out_wr_int = 1;
         //out_data = in_fifo_data;

         case(state)
            START: begin
               if (in_fifo_ctrl_p != 0) begin
                  state_next = HEADER;
                  begin_pkt_next = 1;
                  end_of_pkt_next = 0;   // takes matcher out of reset
                  fifo_sram_full_flag = 0;
               end
            end
            HEADER: begin
               begin_pkt_next = 0;
               fifo_sram_full_flag = 0;
               if (in_fifo_ctrl_p == 0) begin
                  header_counter_next = header_counter + 1'b1;
                  if (header_counter_next == 3) begin
                    state_next = PAYLOAD;
                  end
               end
            end
            PAYLOAD: begin
               if (in_fifo_ctrl_p != 0) begin
                  state_next = START;
                  header_counter_next = 0;
                  end_of_pkt_next = 1;   // will reset matcher
                  in_pkt_body_next = 0;
                  fifo_sram_full_flag = 1;
               end
               else begin
                  fifo_sram_full_flag = 0;
                  in_pkt_body_next = 1;
               end
            end
         endcase // case(state)
      end
   end
   
   always @(posedge clk) 
   if(rst) begin
      header_counter <= 0;
      state <= START;
      begin_pkt <= 0;
      end_of_pkt <= 0;
      in_pkt_body <= 0;
      fifo_sram_full <= 0;
      fifo_output_en <=0;
      in_fifo_rd<=1;
      end
   else
   begin
      header_counter <= header_counter_next;
      state <= state_next;
      begin_pkt <= begin_pkt_next;
      in_pkt_body <= in_pkt_body_next;
      end_of_pkt <= end_of_pkt_next;
      in_fifo_data <= in_fifo_data_p;
      in_fifo_ctrl <= in_fifo_ctrl_p;
      in_fifo_rd <= 1;
      out_wr_int <= fifo_output_en; //sram has clock output is late 1 clock
      FIFOprocessed <= end_of_pkt;
      out_rdy_clk <= out_rdy;
      
      if (fifo_sram_full_flag)begin
         fifo_sram_full <= 1;
      end
      if (fifo_sram_full) begin
         end_of_pkt <=0;
         in_fifo_rd <=0;
      end
      if (DataProcessed)
      begin
         fifo_output_en <= 1;
      end
      if (!valid_data&&fifo_output_en)begin
         fifo_sram_full <= 0;
         fifo_output_en <= 0;
      end
   end
endmodule