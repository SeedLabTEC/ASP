`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:01:34 09/14/2015 
// Design Name: 
// Module Name:    RegistroSinEnable 
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
module RegistroSinEnable #(parameter Widht = 32)
      (CLK,Reset,DataInput,DataOutput);

	 input CLK, Reset;
	 input [Widht-1:0] DataInput;
	 output reg [Widht-1:0] DataOutput = 0;
	 
	 always @(posedge CLK) begin
		if (Reset) DataOutput <= 0;
		else DataOutput  <= DataInput;
	end
			
endmodule 