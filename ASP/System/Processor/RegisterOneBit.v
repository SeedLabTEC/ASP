`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:44:19 08/20/2015 
// Design Name: 
// Module Name:    RegisterOneBit 
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
module RegisterOneBit 
	(CLK,Reset,Enable,DataInput,DataOutput);

	 input CLK, Reset, Enable;
	 input  DataInput;
	 output reg  DataOutput = 0;
	 
	 always @(posedge CLK) begin
			if (Reset) begin
				DataOutput <= 1'b0;
			end else if (Enable) begin
				DataOutput <= DataInput;
			end
	end
			
endmodule
