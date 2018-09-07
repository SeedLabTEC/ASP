`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:09:00 08/06/2015 
// Design Name: 
// Module Name:    MemoryRAM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: MEmory of 32 bits with 2 a la 32 Adress 
//
//////////////////////////////////////////////////////////////////////////////////
module MemoryRAM #(parameter  WidthData = 32, RAM_ADDR_BITS = 4, RAM_WIDTH = 8, InicializarRAM = 0, InicializarByte = 0, 	DIRInicioInicializarRAM   = 0, DIRFinInicializarRAM = 1 ) 
(CLK,  RAMEnable, WriteMemory, LoadData, Address, OutputRAMMEM);
	 

	input  RAMEnable ,WriteMemory;
	input CLK;
	
   reg [RAM_WIDTH-1:0] RAM1 [(2**RAM_ADDR_BITS)-1:0];
   reg [RAM_WIDTH-1:0] OutputData = 0;

   input [RAM_ADDR_BITS-1:0] Address;
	input [RAM_WIDTH-1:0] LoadData;
	output [RAM_WIDTH -1:0] OutputRAMMEM;
   

	
	generate
		if(InicializarRAM == 1) begin // Si se desea inicializar la memoria RAM
			if(WidthData == 32) begin // Si la memoria es de 32 bits 
				if(InicializarByte==0) begin
					initial
						$readmemh("DatosRAMByte0.txt", RAM1, DIRInicioInicializarRAM  , DIRFinInicializarRAM); // Inicializa byte 0 LSB en la memoria RAM [7:0]
				end else if(InicializarByte==1) begin
					initial
						$readmemh("DatosRAMByte1.txt", RAM1, DIRInicioInicializarRAM  , DIRFinInicializarRAM);	// Inicializa byte 1  en la memoria RAM [15:8]			
				end else if(InicializarByte==2) begin
					initial
						$readmemh("DatosRAMByte2.txt", RAM1, DIRInicioInicializarRAM  , DIRFinInicializarRAM);	// Inicializa byte 2  en la memoria RAM [23:16]				
				end else if(InicializarByte==3) begin
					initial
						$readmemh("DatosRAMByte3.txt", RAM1, DIRInicioInicializarRAM  , DIRFinInicializarRAM);	// Inicializa byte 3 MSB en la memoria RAM [31:24]					
				end
			end else begin // Si la memoria es de 64 bits
				if(InicializarByte==0) begin
					initial
						$readmemh("DatosRAMByte0.txt", RAM1, DIRInicioInicializarRAM  , DIRFinInicializarRAM); // Inicializa byte 0 LSB en la memoria RAM [7:0]
				end else if(InicializarByte==1) begin
					initial
						$readmemh("DatosRAMByte1.txt", RAM1, DIRInicioInicializarRAM  , DIRFinInicializarRAM);	// Inicializa byte 1  en la memoria RAM [15:8]			
				end else if(InicializarByte==2) begin
					initial
						$readmemh("DatosRAMByte2.txt", RAM1, DIRInicioInicializarRAM  , DIRFinInicializarRAM);	// Inicializa byte 2  en la memoria RAM [23:16]				
				end else if(InicializarByte==3) begin
					initial
						$readmemh("DatosRAMByte3.txt", RAM1, DIRInicioInicializarRAM  , DIRFinInicializarRAM);	// Inicializa byte 3  en la memoria RAM [31:24]					
				end else if(InicializarByte==4) begin
					initial
						$readmemh("DatosRAMByte4.txt", RAM1, DIRInicioInicializarRAM  , DIRFinInicializarRAM);	// Inicializa byte 4  en la memoria RAM [39:32]					
				end else if(InicializarByte==5) begin
					initial
						$readmemh("DatosRAMByte5.txt", RAM1, DIRInicioInicializarRAM  , DIRFinInicializarRAM);	// Inicializa byte 5  en la memoria RAM [47:40]					
				end else if(InicializarByte==6) begin
					initial
						$readmemh("DatosRAMByte6.txt", RAM1, DIRInicioInicializarRAM  , DIRFinInicializarRAM);	// Inicializa byte 6  en la memoria RAM [55:48]					
				end else if(InicializarByte==7) begin
					initial
						$readmemh("DatosRAMByte7.txt", RAM1, DIRInicioInicializarRAM  , DIRFinInicializarRAM);	// Inicializa byte 7  MSB  en la memoria RAM [63:56]					
				end
			end
			
			
		end
	endgenerate
	
	always @ (posedge CLK)
	begin
		if(RAMEnable) begin
			if (WriteMemory) 
			begin
				RAM1[Address] <= LoadData;
				OutputData <= LoadData;
			end
			else 
			begin
				OutputData <= RAM1[Address];           
			end
		 end
		 else
			OutputData <= 0;
	end
	
	
	
	
	
	assign OutputRAMMEM = OutputData;

endmodule






