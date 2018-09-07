`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:05:28 09/14/2015 
// Design Name: 
// Module Name:    RegisterOneBitSinEnable 
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
module RegisterOneBitSinEnable
    (CLK,Reset,DataInput,DataOutput);

	 input CLK, Reset;
	 input  DataInput;
	 output reg  DataOutput = 0;
	 
	 always @(posedge CLK) begin
		if (Reset) 
			DataOutput <= 1'b0;
		else 
			DataOutput <= DataInput;
	end
			
endmodule
