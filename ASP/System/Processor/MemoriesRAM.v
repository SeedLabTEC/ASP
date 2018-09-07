`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:10:23 08/08/2015 
// Design Name: 
// Module Name:    MemoriesRAM 
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
module MemoriesRAM#(parameter  WidthData = 32, RAM_ADDR_BITS = 17, InicializarRAM = 0, DIRInicioInicializarRAM = 0, DIRFinInicializarRAM = 1)   
    (CLK, RAMEnableByte0LSB, RAMEnableByte1, RAMEnableByte2, RAMEnableByte3MSB, 
	 WriteMemoryByte0LSB, WriteMemoryByte1, WriteMemoryByte2, WriteMemoryByte3MSB, 
	 DataLoad,AddressRAM,DataOutput);
	 
	 // Puertos de la RAM  ******************************
	 input CLK, RAMEnableByte0LSB, RAMEnableByte1, RAMEnableByte2, RAMEnableByte3MSB;
	 input WriteMemoryByte0LSB, WriteMemoryByte1, WriteMemoryByte2, WriteMemoryByte3MSB;
	 input [RAM_ADDR_BITS-1:0] AddressRAM;
	 input [WidthData -1:0] DataLoad;
	 output [WidthData -1:0] DataOutput;

	MemoryRAM #(.WidthData(32), .RAM_ADDR_BITS(RAM_ADDR_BITS), .RAM_WIDTH(8), .InicializarRAM(InicializarRAM), .InicializarByte(3), .DIRInicioInicializarRAM(DIRInicioInicializarRAM), .DIRFinInicializarRAM(DIRFinInicializarRAM))   
	MemoryRAMByte3MSB(
    .CLK(CLK), //********************************
    .RAMEnable(RAMEnableByte3MSB), //************************************
    .WriteMemory(WriteMemoryByte3MSB), //************************
    .LoadData(DataLoad[31:24]), //*****************
    .Address(AddressRAM),   //*************************
    .OutputRAMMEM(DataOutput[31:24]) //*************
    );
	
	MemoryRAM #(.WidthData(32), .RAM_ADDR_BITS(RAM_ADDR_BITS), .RAM_WIDTH(8), .InicializarRAM(InicializarRAM), .InicializarByte(2), .DIRInicioInicializarRAM(DIRInicioInicializarRAM), .DIRFinInicializarRAM(DIRFinInicializarRAM))   
	MemoryRAMByte2(
    .CLK(CLK), //*************************************
    .RAMEnable(RAMEnableByte2), //***********************
    .WriteMemory(WriteMemoryByte2),   //******************
    .LoadData(DataLoad[23:16]), //***********************
    .Address(AddressRAM), //*************************
    .OutputRAMMEM(DataOutput[23:16]) //***************
    );
	
	MemoryRAM #(.WidthData(32), .RAM_ADDR_BITS(RAM_ADDR_BITS), .RAM_WIDTH(8), .InicializarRAM(InicializarRAM), .InicializarByte(1), .DIRInicioInicializarRAM(DIRInicioInicializarRAM), .DIRFinInicializarRAM(DIRFinInicializarRAM))     
	MemoryRAMByte1(
    .CLK(CLK), //****************************************
    .RAMEnable(RAMEnableByte1),  //*********************************
    .WriteMemory(WriteMemoryByte1),  //*******************
    .LoadData(DataLoad[15:8]), //*****************
    .Address(AddressRAM),   //********************
    .OutputRAMMEM(DataOutput[15:8])  //************************
    );
	
	
	MemoryRAM #(.WidthData(32), .RAM_ADDR_BITS(RAM_ADDR_BITS), .RAM_WIDTH(8), .InicializarRAM(InicializarRAM), .InicializarByte(0), .DIRInicioInicializarRAM(DIRInicioInicializarRAM), .DIRFinInicializarRAM(DIRFinInicializarRAM))     
	MemoryRAMByte0LSB (
    .CLK(CLK),            //*******************************
    .RAMEnable(RAMEnableByte0LSB), //************************************* 
    .WriteMemory(WriteMemoryByte0LSB), //**************************************
    .LoadData(DataLoad[7:0]), //*********************************
    .Address(AddressRAM),  //*********************************** 
    .OutputRAMMEM(DataOutput[7:0])  //*********************
    );
	
	 
	 
	 
	 
	 
endmodule
