"""
This class create the Memory RAM with a specific size
Inputs: XML with program counter amount
Outputs: CreateRAM.v
Restrictions: -
"""

#Import library for xml
from xml.dom import minidom

class createRAM:
    #Constructor
    def __init__(self, option=""):
        self._option = option

    
    def create(self):
        file = open("System/Processor/RAMmemoryparam.vh", "w")

        test = '''`ifndef _RAMmemoryparam_vh_
`define _RAMmemoryparam_vh_
`define RAM_ADDR_BITS %s
`endif'''%(self._option)
        
        file.write(test)
        file.close()
