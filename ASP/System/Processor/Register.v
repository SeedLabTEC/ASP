`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:02:13 08/04/2015 
// Design Name: 
// Module Name:    Register 
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
module Register #(parameter Widht = 32)(CLK,Reset,Enable,DataInput,DataOutput);

	 input CLK, Reset, Enable;
	 input [Widht-1:0] DataInput;
	 output reg [Widht-1:0] DataOutput = 0;
	 
	 always @(posedge CLK) begin
			if (Reset) begin
				DataOutput <= 0;
			end else if (Enable) begin
				DataOutput <= DataInput;
			end
	end
			
endmodule
