`timescale 1ns / 1ps
        //////////////////////////////////////////////////////////////////////////////////
        // Company: 
        // Engineer: 
        // 
        // Create Date:    
        // Design Name: 
        // Module Name:    ProgramCounter 
        // Project Name: 
        // Target Devices: 
        // Tool versions: 
        // Description: 
        //file
        // Dependencies: 
        //
        // Revision: 
        // Revision 0.01 - File Created
        // Additional Comments: 
        //
        //////////////////////////////////////////////////////////////////////////////////
        module ProgramCounter #(parameter AddressWidth = 12, ProgramStartAddress = 12'b0) 
        ( CLK, Reset, Enable, LoadEnable, LoadData,CounterOutput);

	        input CLK, Reset, Enable, LoadEnable; 
	        input [AddressWidth-1:0] LoadData;
	 
	        output reg [AddressWidth-1:0] CounterOutput = 0;

   
           always @(posedge CLK) begin
              if (Reset)
                 CounterOutput <= ProgramStartAddress;
              else if (Enable)
                 if (LoadEnable)
                    CounterOutput <= LoadData;
                 else
                    CounterOutput <= CounterOutput + 2'd2;
	        end


        endmodule