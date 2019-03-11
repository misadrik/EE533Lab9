////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 10.1.03
//  \   \         Application : sch2verilog
//  /   /         Filename : CVTB_FIFO.vf
// /___/   /\     Timestamp : 03/08/2019 14:32:55
// \   \  /  \ 
//  \___\/\___\ 
//
//Command: C:\Xilinx\10.1\ISE\bin\nt\unwrapped\sch2verilog.exe -intstyle ise -family virtex2p -w E:/USC/EE533/Lab/lab9/Lab9Sim_v2/CVTB_FIFO.sch CVTB_FIFO.vf
//Design Name: CVTB_FIFO
//Device: virtex2p
//Purpose:
//    This verilog netlist is translated from an ECS schematic.It can be 
//    synthesized and simulated, but it should not be modified. 
//
`timescale 1ns / 1ps

module COMP8_MXILINX_CVTB_FIFO(A, 
                               B, 
                               EQ);

    input [7:0] A;
    input [7:0] B;
   output EQ;
   
   wire AB0;
   wire AB1;
   wire AB2;
   wire AB3;
   wire AB4;
   wire AB5;
   wire AB6;
   wire AB7;
   wire AB03;
   wire AB47;
   
   AND4 I_36_32 (.I0(AB7), 
                 .I1(AB6), 
                 .I2(AB5), 
                 .I3(AB4), 
                 .O(AB47));
   XNOR2 I_36_33 (.I0(B[6]), 
                  .I1(A[6]), 
                  .O(AB6));
   XNOR2 I_36_34 (.I0(B[7]), 
                  .I1(A[7]), 
                  .O(AB7));
   XNOR2 I_36_35 (.I0(B[5]), 
                  .I1(A[5]), 
                  .O(AB5));
   XNOR2 I_36_36 (.I0(B[4]), 
                  .I1(A[4]), 
                  .O(AB4));
   AND4 I_36_41 (.I0(AB3), 
                 .I1(AB2), 
                 .I2(AB1), 
                 .I3(AB0), 
                 .O(AB03));
   XNOR2 I_36_42 (.I0(B[2]), 
                  .I1(A[2]), 
                  .O(AB2));
   XNOR2 I_36_43 (.I0(B[3]), 
                  .I1(A[3]), 
                  .O(AB3));
   XNOR2 I_36_44 (.I0(B[1]), 
                  .I1(A[1]), 
                  .O(AB1));
   XNOR2 I_36_45 (.I0(B[0]), 
                  .I1(A[0]), 
                  .O(AB0));
   AND2 I_36_50 (.I0(AB47), 
                 .I1(AB03), 
                 .O(EQ));
endmodule
`timescale 1ns / 1ps

module FD8CE_MXILINX_CVTB_FIFO(C, 
                               CE, 
                               CLR, 
                               D, 
                               Q);

    input C;
    input CE;
    input CLR;
    input [7:0] D;
   output [7:0] Q;
   
   
   FDCE I_Q0 (.C(C), 
              .CE(CE), 
              .CLR(CLR), 
              .D(D[0]), 
              .Q(Q[0]));
   defparam I_Q0.INIT = 1'b0;
   FDCE I_Q1 (.C(C), 
              .CE(CE), 
              .CLR(CLR), 
              .D(D[1]), 
              .Q(Q[1]));
   defparam I_Q1.INIT = 1'b0;
   FDCE I_Q2 (.C(C), 
              .CE(CE), 
              .CLR(CLR), 
              .D(D[2]), 
              .Q(Q[2]));
   defparam I_Q2.INIT = 1'b0;
   FDCE I_Q3 (.C(C), 
              .CE(CE), 
              .CLR(CLR), 
              .D(D[3]), 
              .Q(Q[3]));
   defparam I_Q3.INIT = 1'b0;
   FDCE I_Q4 (.C(C), 
              .CE(CE), 
              .CLR(CLR), 
              .D(D[4]), 
              .Q(Q[4]));
   defparam I_Q4.INIT = 1'b0;
   FDCE I_Q5 (.C(C), 
              .CE(CE), 
              .CLR(CLR), 
              .D(D[5]), 
              .Q(Q[5]));
   defparam I_Q5.INIT = 1'b0;
   FDCE I_Q6 (.C(C), 
              .CE(CE), 
              .CLR(CLR), 
              .D(D[6]), 
              .Q(Q[6]));
   defparam I_Q6.INIT = 1'b0;
   FDCE I_Q7 (.C(C), 
              .CE(CE), 
              .CLR(CLR), 
              .D(D[7]), 
              .Q(Q[7]));
   defparam I_Q7.INIT = 1'b0;
endmodule
`timescale 1ns / 1ps

module M2_1_MXILINX_CVTB_FIFO(D0, 
                              D1, 
                              S0, 
                              O);

    input D0;
    input D1;
    input S0;
   output O;
   
   wire M0;
   wire M1;
   
   AND2B1 I_36_7 (.I0(S0), 
                  .I1(D0), 
                  .O(M0));
   OR2 I_36_8 (.I0(M1), 
               .I1(M0), 
               .O(O));
   AND2 I_36_9 (.I0(D1), 
                .I1(S0), 
                .O(M1));
endmodule
`timescale 1ns / 1ps

module FTCLEX_MXILINX_CVTB_FIFO(C, 
                                CE, 
                                CLR, 
                                D, 
                                L, 
                                T, 
                                Q);

    input C;
    input CE;
    input CLR;
    input D;
    input L;
    input T;
   output Q;
   
   wire MD;
   wire TQ;
   wire Q_DUMMY;
   
   assign Q = Q_DUMMY;
   M2_1_MXILINX_CVTB_FIFO I_36_30 (.D0(TQ), 
                                   .D1(D), 
                                   .S0(L), 
                                   .O(MD));
   // synthesis attribute HU_SET of I_36_30 is "I_36_30_0"
   XOR2 I_36_32 (.I0(T), 
                 .I1(Q_DUMMY), 
                 .O(TQ));
   FDCE I_36_35 (.C(C), 
                 .CE(CE), 
                 .CLR(CLR), 
                 .D(MD), 
                 .Q(Q_DUMMY));
   // synthesis attribute RLOC of I_36_35 is "X0Y0"
   defparam I_36_35.INIT = 1'b0;
endmodule
`timescale 1ns / 1ps

module CB8CLE_MXILINX_CVTB_FIFO(C, 
                                CE, 
                                CLR, 
                                D, 
                                L, 
                                CEO, 
                                Q, 
                                TC);

    input C;
    input CE;
    input CLR;
    input [7:0] D;
    input L;
   output CEO;
   output [7:0] Q;
   output TC;
   
   wire OR_CE_L;
   wire T2;
   wire T3;
   wire T4;
   wire T5;
   wire T6;
   wire T7;
   wire XLXN_1;
   wire [7:0] Q_DUMMY;
   wire TC_DUMMY;
   
   assign Q[7:0] = Q_DUMMY[7:0];
   assign TC = TC_DUMMY;
   FTCLEX_MXILINX_CVTB_FIFO I_Q0 (.C(C), 
                                  .CE(OR_CE_L), 
                                  .CLR(CLR), 
                                  .D(D[0]), 
                                  .L(L), 
                                  .T(XLXN_1), 
                                  .Q(Q_DUMMY[0]));
   // synthesis attribute HU_SET of I_Q0 is "I_Q0_1"
   FTCLEX_MXILINX_CVTB_FIFO I_Q1 (.C(C), 
                                  .CE(OR_CE_L), 
                                  .CLR(CLR), 
                                  .D(D[1]), 
                                  .L(L), 
                                  .T(Q_DUMMY[0]), 
                                  .Q(Q_DUMMY[1]));
   // synthesis attribute HU_SET of I_Q1 is "I_Q1_2"
   FTCLEX_MXILINX_CVTB_FIFO I_Q2 (.C(C), 
                                  .CE(OR_CE_L), 
                                  .CLR(CLR), 
                                  .D(D[2]), 
                                  .L(L), 
                                  .T(T2), 
                                  .Q(Q_DUMMY[2]));
   // synthesis attribute HU_SET of I_Q2 is "I_Q2_3"
   FTCLEX_MXILINX_CVTB_FIFO I_Q3 (.C(C), 
                                  .CE(OR_CE_L), 
                                  .CLR(CLR), 
                                  .D(D[3]), 
                                  .L(L), 
                                  .T(T3), 
                                  .Q(Q_DUMMY[3]));
   // synthesis attribute HU_SET of I_Q3 is "I_Q3_4"
   FTCLEX_MXILINX_CVTB_FIFO I_Q4 (.C(C), 
                                  .CE(OR_CE_L), 
                                  .CLR(CLR), 
                                  .D(D[4]), 
                                  .L(L), 
                                  .T(T4), 
                                  .Q(Q_DUMMY[4]));
   // synthesis attribute HU_SET of I_Q4 is "I_Q4_5"
   FTCLEX_MXILINX_CVTB_FIFO I_Q5 (.C(C), 
                                  .CE(OR_CE_L), 
                                  .CLR(CLR), 
                                  .D(D[5]), 
                                  .L(L), 
                                  .T(T5), 
                                  .Q(Q_DUMMY[5]));
   // synthesis attribute HU_SET of I_Q5 is "I_Q5_6"
   FTCLEX_MXILINX_CVTB_FIFO I_Q6 (.C(C), 
                                  .CE(OR_CE_L), 
                                  .CLR(CLR), 
                                  .D(D[6]), 
                                  .L(L), 
                                  .T(T6), 
                                  .Q(Q_DUMMY[6]));
   // synthesis attribute HU_SET of I_Q6 is "I_Q6_7"
   FTCLEX_MXILINX_CVTB_FIFO I_Q7 (.C(C), 
                                  .CE(OR_CE_L), 
                                  .CLR(CLR), 
                                  .D(D[7]), 
                                  .L(L), 
                                  .T(T7), 
                                  .Q(Q_DUMMY[7]));
   // synthesis attribute HU_SET of I_Q7 is "I_Q7_8"
   AND3 I_36_8 (.I0(Q_DUMMY[5]), 
                .I1(Q_DUMMY[4]), 
                .I2(T4), 
                .O(T6));
   AND2 I_36_11 (.I0(Q_DUMMY[4]), 
                 .I1(T4), 
                 .O(T5));
   VCC I_36_12 (.P(XLXN_1));
   AND2 I_36_19 (.I0(Q_DUMMY[1]), 
                 .I1(Q_DUMMY[0]), 
                 .O(T2));
   AND3 I_36_21 (.I0(Q_DUMMY[2]), 
                 .I1(Q_DUMMY[1]), 
                 .I2(Q_DUMMY[0]), 
                 .O(T3));
   AND4 I_36_23 (.I0(Q_DUMMY[3]), 
                 .I1(Q_DUMMY[2]), 
                 .I2(Q_DUMMY[1]), 
                 .I3(Q_DUMMY[0]), 
                 .O(T4));
   AND4 I_36_25 (.I0(Q_DUMMY[6]), 
                 .I1(Q_DUMMY[5]), 
                 .I2(Q_DUMMY[4]), 
                 .I3(T4), 
                 .O(T7));
   AND5 I_36_29 (.I0(Q_DUMMY[7]), 
                 .I1(Q_DUMMY[6]), 
                 .I2(Q_DUMMY[5]), 
                 .I3(Q_DUMMY[4]), 
                 .I4(T4), 
                 .O(TC_DUMMY));
   AND2 I_36_33 (.I0(CE), 
                 .I1(TC_DUMMY), 
                 .O(CEO));
   OR2 I_36_49 (.I0(CE), 
                .I1(L), 
                .O(OR_CE_L));
endmodule
`timescale 1ns / 1ps

module CVTB_FIFO(clk, 
                 fifo_data_out, 
                 fifo_read, 
                 first_word, 
                 in_fifo, 
                 last_word, 
                 Manual_Write_ADDR, 
                 Manual_WR_DATA, 
                 Manual_WR_EN, 
                 Mem_MemWrite, 
                 Mem_R2OUT, 
                 Netfpga_Write, 
                 read_load, 
                 rst, 
                 SRAM_ADDRIN, 
                 first_out, 
                 last_out, 
                 MEM_Dout, 
                 out_fifo, 
                 valid_data);

    input clk;
    input fifo_data_out;
    input fifo_read;
    input first_word;
    input [71:0] in_fifo;
    input last_word;
    input [7:0] Manual_Write_ADDR;
    input [71:0] Manual_WR_DATA;
    input Manual_WR_EN;
    input Mem_MemWrite;
    input [71:0] Mem_R2OUT;
    input Netfpga_Write;
    input read_load;
    input rst;
    input [7:0] SRAM_ADDRIN;
   output [7:0] first_out;
   output [7:0] last_out;
   output [71:0] MEM_Dout;
   output [71:0] out_fifo;
   output valid_data;
   
   wire [7:0] addra_in;
   wire [71:0] DATA_IN;
   wire [71:0] DATA_IN2;
   wire [7:0] XLXN_2;
   wire XLXN_151;
   wire [7:0] XLXN_187;
   wire [0:0] XLXN_196;
   wire [7:0] XLXN_199;
   wire XLXN_207;
   wire XLXN_216;
   wire [7:0] first_out_DUMMY;
   wire [7:0] last_out_DUMMY;
   
   assign first_out[7:0] = first_out_DUMMY[7:0];
   assign last_out[7:0] = last_out_DUMMY[7:0];
   ADDR_MUX XLXI_2 (.ADDR_MUX_IN1(XLXN_187[7:0]), 
                    .ADDR_MUX_IN2(SRAM_ADDRIN[7:0]), 
                    .sel(XLXN_151), 
                    .ADDR_MUX_OUT(addra_in[7:0]));
   ADDR_MUX XLXI_3 (.ADDR_MUX_IN1(XLXN_199[7:0]), 
                    .ADDR_MUX_IN2(Manual_Write_ADDR[7:0]), 
                    .sel(fifo_read), 
                    .ADDR_MUX_OUT(XLXN_2[7:0]));
   DATA_MUX XLXI_4 (.DATA_MUX_IN1(in_fifo[71:0]), 
                    .DATA_MUX_IN2(Mem_R2OUT[71:0]), 
                    .sel(XLXN_151), 
                    .DATA_MUX_OUT(DATA_IN[71:0]));
   DATA_MUX XLXI_5 (.DATA_MUX_IN1(), 
                    .DATA_MUX_IN2(Manual_WR_DATA[71:0]), 
                    .sel(fifo_read), 
                    .DATA_MUX_OUT(DATA_IN2[71:0]));
   INV XLXI_45 (.I(Netfpga_Write), 
                .O(XLXN_151));
   FD8CE_MXILINX_CVTB_FIFO XLXI_60 (.C(clk), 
                                    .CE(last_word), 
                                    .CLR(rst), 
                                    .D(XLXN_187[7:0]), 
                                    .Q(last_out_DUMMY[7:0]));
   // synthesis attribute HU_SET of XLXI_60 is "XLXI_60_9"
   FD8CE_MXILINX_CVTB_FIFO XLXI_65 (.C(clk), 
                                    .CE(first_word), 
                                    .CLR(rst), 
                                    .D(XLXN_187[7:0]), 
                                    .Q(first_out_DUMMY[7:0]));
   // synthesis attribute HU_SET of XLXI_65 is "XLXI_65_12"
   CB8CLE_MXILINX_CVTB_FIFO XLXI_67 (.C(clk), 
                                     .CE(fifo_data_out), 
                                     .CLR(rst), 
                                     .D(first_out_DUMMY[7:0]), 
                                     .L(read_load), 
                                     .CEO(), 
                                     .Q(XLXN_199[7:0]), 
                                     .TC());
   // synthesis attribute HU_SET of XLXI_67 is "XLXI_67_11"
   CB8CLE_MXILINX_CVTB_FIFO XLXI_74 (.C(clk), 
                                     .CE(Netfpga_Write), 
                                     .CLR(rst), 
                                     .D(last_out_DUMMY[7:0]), 
                                     .L(XLXN_216), 
                                     .CEO(), 
                                     .Q(XLXN_187[7:0]), 
                                     .TC());
   // synthesis attribute HU_SET of XLXI_74 is "XLXI_74_10"
   OR2 XLXI_76 (.I0(Mem_MemWrite), 
                .I1(Netfpga_Write), 
                .O(XLXN_196[0]));
   COMP8_MXILINX_CVTB_FIFO XLXI_77 (.A(XLXN_199[7:0]), 
                                    .B(last_out_DUMMY[7:0]), 
                                    .EQ(XLXN_207));
   // synthesis attribute HU_SET of XLXI_77 is "XLXI_77_13"
   INV XLXI_78 (.I(XLXN_207), 
                .O(valid_data));
   GND XLXI_79 (.G(XLXN_216));
   SP_FIFO XLXI_81 (.addra(addra_in[7:0]), 
                    .addrb(XLXN_2[7:0]), 
                    .clka(clk), 
                    .clkb(clk), 
                    .dina(DATA_IN[63:0]), 
                    .dinb(DATA_IN2[63:0]), 
                    .wea(XLXN_196[0]), 
                    .web(Manual_WR_EN), 
                    .douta(MEM_Dout[63:0]), 
                    .doutb(out_fifo[63:0]));
   SP_FIFO2 XLXI_82 (.addra(addra_in[7:0]), 
                     .addrb(XLXN_2[7:0]), 
                     .clka(clk), 
                     .clkb(clk), 
                     .dina(DATA_IN[71:64]), 
                     .dinb(DATA_IN2[71:64]), 
                     .wea(Netfpga_Write), 
                     .web(Manual_WR_EN), 
                     .douta(MEM_Dout[71:64]), 
                     .doutb(out_fifo[71:64]));
endmodule
