"""
This class create the ALU
Inputs: Array Operations
Outputs: ALU.v
Restrictions: Arrays
"""

import shutil
import commands 

class createALU:
    #Constructor
    def __init__(self, operations=[], nameFile="ALUInteger.v"):
        self._operations = operations
        self._nameFile = nameFile
        
    
    #Orden
    """ADD
    SLL
    SLT
    SLTU
    XOR
    SRL
    OR
    AND
    SUB
    SRA
    BEQ"""
    
    def getOperations(self):
        orden = ["ADD", "SLL", "SLT", "SLTU", "XOR", "SRL", "OR", "AND", "SUB", "SRA", "BEQ"]
        #Special case: When implement all the operations
        if len(self._operations) == 0:
            return []
        else:
            for i in range(0, len(self._operations)):
                orden.remove(self._operations[i])    
            return orden

    def createALUModule(self):
        file = open("System/Generator/TempALU.v", "r+")
        #Temporal for store the file and then written in the final file
        term = []
        operationsToRemove = self.getOperations() #Operations eliminated

        if len(operationsToRemove)==0:
            #shutil.copyfile("System/Generator/TempALU.v", "ALUInteger.v")
            commands.getoutput('cp System/Generator/TempALU.v System/Processor/')
            commands.getoutput('mv System/Processor/TempALU.v System/Processor/ALUInteger.v' )
            
        else:
            #Index for the operation to remove
            indexOperation=0
            #Flag that indicated when the operation end
            endOperation = 0 
            flag = 0
            counter = 0
            for linea in file.readlines():
                if operationsToRemove[indexOperation]+":" in linea:
                    if operationsToRemove[indexOperation][0] == linea[8]:
                        term.append("/*"+linea)
                        endOperation = 1
                    else:
                        term.append(linea)
                        endOperation = 0
                elif "end" in linea and endOperation==1:
                    term.append(linea+"*/")
                    endOperation = 0
                    counter +=1
                    if counter == 3 and flag == 0:
                        counter = 0
                        flag = 1
                        if len(operationsToRemove) == 1:
                            pass
                        else:
                            indexOperation+=1
                    elif flag==1 and counter == 1:
                        counter = 0
                        if indexOperation < len(operationsToRemove)-1:
                            indexOperation+=1
                        else:
                            pass
                else:
                    term.append(linea)
            file.close()

            finalFile = open("System/Processor/"+self._nameFile, "w")


            for i in range(0, len(term)):
                finalFile.write(term[i])

            finalFile.close()
