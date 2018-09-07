"""
This class read the xml file from first system
Inputs: xml file
Outputs: File interpretation
Restrictions: Just xml file
"""

#Import library for xml
from xml.dom import minidom

class readXML:
    #Constructor 
    def __init__(self, xmlName="", register="", dataMemory="", operations=[]):
        
        self._xmlName = xmlName
        self._register = register
        self._dataMemory = dataMemory
        self._operations = operations

    def getData(self):

        #Read xml file
        architecture = minidom.parse(self._xmlName)
        
        #===========================REGISTER====================================
        #Get amount of registers
        amountRegister = architecture.getElementsByTagName('Amount')

        #Inserting amount
        self._register = amountRegister[0].firstChild.data
        #===========================REGISTER====================================


        #===========================DATA MEMORY=================================
        #Get capacity
        capacityDataMemory = architecture.getElementsByTagName('Option')

        #Inserting Memory capacity
        self._dataMemory = capacityDataMemory[0].firstChild.data

        #===========================DATA MEMORY=================================


        #===========================OPERATIONS==================================
        #Get amount of registers
        operations = architecture.getElementsByTagName('Operation')

        for elem in operations:  
            #print(elem.firstChild.data)
            self._operations.append(elem.firstChild.data)
        #===========================OPERATIONS==================================
