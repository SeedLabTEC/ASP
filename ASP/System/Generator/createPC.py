"""
This class create the Program Counter
Inputs: XML with program counter amount
Outputs: ProgramCounter.v
Restrictions: -
"""

#Import library for xml
from xml.dom import minidom

class createPC:
    #Constructor
    def __init__(self, xmlName=""):
        self._xmlName = xmlName
        self._size = ""

    
    def readXML(self):
        #Read xml file
        programCounter = minidom.parse(self._xmlName)
        
        #===============================SIZE====================================
        #Get size
        magnitude = programCounter.getElementsByTagName('ProgramCounter')
        #Setting size
        self._size = magnitude[0].firstChild.data
        #===============================SIZE====================================
    
    def create(self):
        file = open("System/Processor/ProgramCounter.v", "w")
        self.readXML()

        test = '''`timescale 1ns / 1ps
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
        module ProgramCounter #(parameter AddressWidth = %s, ProgramStartAddress = %s'b0) 
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


        endmodule'''%(self._size,self._size)
        
        file.write(test)
        file.close()
