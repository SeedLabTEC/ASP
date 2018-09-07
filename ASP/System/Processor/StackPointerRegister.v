`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:36:15 09/17/2015 
// Design Name: 
// Module Name:    StackPointerRegister 
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
module StackPointerRegister#(parameter Widht = 32, StackPointer = 32'h00000AF0)(CLK,Reset,Enable,DataInput,DataOutput);

	 input CLK, Reset, Enable;
	 input [Widht-1:0] DataInput;
	 output reg [Widht-1:0] DataOutput = 0;
	 
	 always @(posedge CLK) begin
			if (Reset) begin
				DataOutput <= StackPointer;
			end else if (Enable) begin
				DataOutput <= DataInput;
			end
	end
			
endmodule
