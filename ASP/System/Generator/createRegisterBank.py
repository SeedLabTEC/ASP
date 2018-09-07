"""
This class create the register bank
Inputs: register bank size
Outputs: BankRegister.v
Restrictions: -
"""

class createRB:
    #Constructor
    def __init__(self, size=""):
        self._size = size;
        self._n = int(size)-1;

    def create(self):
        file = open("System/Processor/BankRegister.v", "w")
        registerAddress = self.createAlways();
        temp = ('''`timescale 1ns / 1ps
        module BankRegister #(parameter Widht = 4, StackPointer = 32'h00000AF0) (input CLK, //+
                     input Reset,//+
                     input [Widht-1:0] WriteData,//+ //data input 
                     input WriteRegister,//+ //write enable
                     input [3:0] ReadRegister1, //src1
                     input [3:0] ReadRegister2, //src2
                     input [3:0] WriteRegisterAddress, //dst
                     output  [Widht-1:0] ReadData1, //+ //operand1
                     output  [Widht-1:0] ReadData2); //+ //operand2                    
        wire [31:0] outs [%s:0];


        //source registers selection (muxes)
        assign ReadData1 = outs[ReadRegister1];
        assign ReadData2 = outs[ReadRegister2];

        reg[%s:0] wen;
        always@(WriteRegisterAddress, wen) begin
            case (WriteRegisterAddress)\n'''%(self._n, self._n) + 
            registerAddress) +"\n"+'''default:
   begin
     wen = 0;
   end
   
   endcase
    
    end 

        //dynamic instantiation of registers
        genvar i;
        generate for (i=0; i<%s; i=i+1) begin: regs_gen
             Register reg32_inst(CLK, Reset, wen[i], WriteData, outs[i]);
            end
        endgenerate

        endmodule'''%(int(self._size)-1)

        file.write(temp)
        file.close()

    def createAlways(self):
        result = "";
        for i in range(0,int(self._size)):
            result +=str(i)+":"+" wen = "+str(2**i)+";"+"\n";
        return result;

    
