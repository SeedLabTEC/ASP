`timescale 1ns / 1ps
        module BankRegister #(parameter Widht = 4, StackPointer = 32'h00000AF0) (input CLK, //+
                     input Reset,//+
                     input [Widht-1:0] WriteData,//+ //data input 
                     input WriteRegister,//+ //write enable
                     input [3:0] ReadRegister1, //src1
                     input [3:0] ReadRegister2, //src2
                     input [3:0] WriteRegisterAddress, //dst
                     output  [Widht-1:0] ReadData1, //+ //operand1
                     output  [Widht-1:0] ReadData2); //+ //operand2                    
        wire [31:0] outs [19:0];


        //source registers selection (muxes)
        assign ReadData1 = outs[ReadRegister1];
        assign ReadData2 = outs[ReadRegister2];

        reg[19:0] wen;
        always@(WriteRegisterAddress, wen) begin
            case (WriteRegisterAddress)
0: wen = 1;
1: wen = 2;
2: wen = 4;
3: wen = 8;
4: wen = 16;
5: wen = 32;
6: wen = 64;
7: wen = 128;
8: wen = 256;
9: wen = 512;
10: wen = 1024;
11: wen = 2048;
12: wen = 4096;
13: wen = 8192;
14: wen = 16384;
15: wen = 32768;
16: wen = 65536;
17: wen = 131072;
18: wen = 262144;
19: wen = 524288;

default:
   begin
     wen = 0;
   end
   
   endcase
    
    end 

        //dynamic instantiation of registers
        genvar i;
        generate for (i=0; i<19; i=i+1) begin: regs_gen
             Register reg32_inst(CLK, Reset, wen[i], WriteData, outs[i]);
            end
        endgenerate

        endmodule