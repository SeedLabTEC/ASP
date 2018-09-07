`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:09:29 08/12/2015 
// Design Name: 
// Module Name:    InterfazMemoria 
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
module InterfazMemoriaROM #(parameter  WidthAddressInputPortROM=32, WidthInstruction = 32, ROM_ADDR_BITS = 10, ROM_WIDTH = 8, BEGIN_ADDR_PROGRAM = 0, END_ADDR_PROGRAM= 15, ROM_ADDR_START_BITS = 0)
(CLK, AddressROM, Instruction);

	 input CLK;
	 input [WidthAddressInputPortROM-1:0] AddressROM;
	 
	 //wire [WidthInstruction-1:0] OutputROM;  // Código para Multiplexar Salidas
	 
	 //output reg [WidthInstruction-1:0] Instruction = 0; // Código para Multiplexar Salidas
	 output  [WidthInstruction-1:0] Instruction;
	 reg EnableROM = 0;
	 
	 MemoriesROM #(.WidthInstruction(WidthInstruction), .ROM_ADDR_BITS(ROM_ADDR_BITS), .ROM_WIDTH(ROM_WIDTH), .BEGIN_ADDR(BEGIN_ADDR_PROGRAM), .END_ADDR(END_ADDR_PROGRAM), .ROM_ADDR_START_BITS(ROM_ADDR_START_BITS))   
	 ProgramMemory (
    .CLK(CLK), //*********************
    .ROMEnable(EnableROM),  //*************** =1 si estuviera en el caso de multiplexar salidas
    .AddressROM(AddressROM[ROM_ADDR_BITS-1:0]), 
    .Instruction(Instruction)  //*********************
    );
	 
	 
	 generate
		 if (ROM_ADDR_START_BITS == 0) begin
			 always @* begin
				 if (AddressROM <= ((2**ROM_ADDR_BITS) -1'd1))
						EnableROM <= 1'b1;
				 else
						EnableROM <= 1'b0;
			 end
		 end else begin
			always @* begin
				if ((AddressROM >= 2**ROM_ADDR_START_BITS) && (AddressROM <= ((2**ROM_ADDR_START_BITS)+(2**ROM_ADDR_BITS) -1'd1)))
					EnableROM <= 1'b1;
				else
					EnableROM <= 1'b0;
			end
		 end
	 endgenerate
	 
	 
	 
	 /* Multiplexar Salidas
	 always @* begin
		 if ((AddressROM >= 2**ROM_ADDR_START_BITS) && (AddressROM <= ((2**ROM_ADDR_START_BITS)+(2**ROM_ADDR_BITS) -1'd1)))
				Instruction <= OutputROM;
		 else
				Instruction <= 0;
	 end
	 */


endmodule
