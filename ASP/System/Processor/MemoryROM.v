`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:56:08 08/08/2015 
// Design Name: 
// Module Name:    MemoryROM 
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
module MemoryROM#(parameter LOW = 0, ROM_ADDR_BITS = 4, ROM_WIDTH = 8, BEGIN_ADDR = 0, END_ADDR= 15, ROM_ADDR_START_BITS = 0) 
(CLK, ROMEnable, Address, OutputROMMEM);
	 

	input  ROMEnable;
	input CLK;
	
   reg [ROM_WIDTH-1:0] ROM1 [(2**ROM_ADDR_BITS)-1:0];
   reg [ROM_WIDTH-1:0] OutputData1 = 0,OutputData0 = 0;

   input [ROM_ADDR_BITS-1:0] Address;
	output [2*ROM_WIDTH -1:0] OutputROMMEM;
   
	
	
	generate
		if (LOW==1 && ROM_ADDR_START_BITS == 0) begin
			initial
					$readmemh("CodigoProgramaLOW.txt", ROM1, BEGIN_ADDR, END_ADDR);
		end else if(LOW==1 && ROM_ADDR_START_BITS != 0) begin
			initial
					$readmemh("CodigoProgramaLOW.txt", ROM1, (BEGIN_ADDR-(2**ROM_ADDR_START_BITS)), (END_ADDR -(2**ROM_ADDR_START_BITS)));
		end else if(LOW==0 && ROM_ADDR_START_BITS == 0)  begin
			initial
					$readmemh("CodigoProgramaHIGH.txt", ROM1, BEGIN_ADDR, END_ADDR);
		end else if(LOW==0 && ROM_ADDR_START_BITS != 0)  begin
			initial
					$readmemh("CodigoProgramaHIGH.txt", ROM1, (BEGIN_ADDR-(2**ROM_ADDR_START_BITS)), (END_ADDR -(2**ROM_ADDR_START_BITS)));
		end
	endgenerate 
	
	
	
	always @ (posedge CLK)
	begin
		if(ROMEnable) begin
			OutputData1 <= ROM1[Address+1];           //     Bit MSB
		 end
		 else
			OutputData1 <= 0;
	end
	
	
	always @ (posedge CLK)
	begin
		if(ROMEnable) begin
			OutputData0 <= ROM1[Address];           //     Bit LSB
		end else
			OutputData0 <= 0;
	end
	
	
	assign OutputROMMEM = {OutputData1,OutputData0};

endmodule 