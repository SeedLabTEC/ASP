`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:23:11 08/08/2015 
// Design Name: 
// Module Name:    MemoriesROM 
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
module MemoriesROM #(parameter WidthInstruction = 32, ROM_ADDR_BITS = 4, ROM_WIDTH = 8, BEGIN_ADDR = 0, END_ADDR= 15, ROM_ADDR_START_BITS = 0)   
    (CLK,ROMEnable,AddressROM,Instruction);
	 
	 // Puertos de la ROM  ******************************
	 input CLK, ROMEnable;
	 input [ROM_ADDR_BITS-1:0] AddressROM;
	 output [WidthInstruction -1:0] Instruction;
	
	 //***************************************************
	 
	 //  Memory ROM Struct*********************
	 
	 //        High Memory            Low Memory
	 //     Instruction[23:16]    Instruction[23:16]  // Address or PC Actual
	 //     Instruction[15:8]     Instruction[7:0]    // Address + 1 or PC +1
	 // La memoria ROM de programa esta compuesta de dos memorias, para alta y baja,
    // cada una de ellas con 1 bytes, pero cuando lee, permite leer a 2 dirrecciones
    // al mismo, siempre es Address y Address + 1, por esta razón la salida son siempre
    // 2 bytes, ya que en realidad se esta leyendo al byte en la posición de Address
    // y al byte en la posición de Address + 1, donde el byte en Address +1 es el MSB 
	 // el byte en la posición de Address es el byte LSB.	

    // Ahora son 2 memorias de programa porque se necesitan 32 bites, por esta razón,
    // en una memoria en la LOW, se almacenerá un archivo con los 16 bits LSB, y en la 
    // high se almacena los otros 16 bits MSB, de esta forma cuando se realiza una 
    // lectura de la ROM el resultado es 32 bits, 16 que provienen de la lectura de los
    // 2 puerto en Address y Addres +1 de la memoria LOW y los otros 16 que provienen
    // de la lectura de los 2 puertos en Address y Address +1 de la memoria HIGH.

	 // COmo se podra notar el PC según este cambio, es PC +2, por esta razón para no afectar 
	 // la lógica, se realiza un desplazamiento a la derecha de 1 bit, equivalente a 
	 // dividir el Address entre 2, y de esta forma el PC aunque llega como PC más 4, 
	 // como PC + 2 se actualizará como
	 
	 //assign AddressROM =  (AddressROM1>>1'b1); // Right Shift Address
	 
	 MemoryROM #(.LOW(1), .ROM_ADDR_BITS(ROM_ADDR_BITS), .ROM_WIDTH(ROM_WIDTH), .BEGIN_ADDR(BEGIN_ADDR), .END_ADDR(END_ADDR), .ROM_ADDR_START_BITS(ROM_ADDR_START_BITS)) 
	 MemoryProgramROMLOW (
    .CLK(CLK), //***********************
    .ROMEnable(ROMEnable), ///**************
    .Address(AddressROM),  ///**************
    .OutputROMMEM(Instruction[(WidthInstruction/2)-1:0]) //***********
    );
	 
	 MemoryROM #(.LOW(0), .ROM_ADDR_BITS(ROM_ADDR_BITS), .ROM_WIDTH(ROM_WIDTH), .BEGIN_ADDR(BEGIN_ADDR), .END_ADDR(END_ADDR), .ROM_ADDR_START_BITS(ROM_ADDR_START_BITS)) 
	 MemoryProgramROMHIGH (
    .CLK(CLK), //***********************
    .ROMEnable(ROMEnable),  ///**************
    .Address(AddressROM),  ///**************
    .OutputROMMEM(Instruction[WidthInstruction-1:(WidthInstruction/2)]) //***********
    );
	 
endmodule
