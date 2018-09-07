"""
This class use for testing classes
"""

from readXML import *
from createALU import *
from createPC import *
from createRegisterBank import *
from createRAM import *

#=======================================READ XML================================

pathModulosHW = "System/XML/Interface.xml"
pathPC = "System/XML/ProgramCounter.xml"

obj = readXML(pathModulosHW)

obj.getData()

print "Registros"
print "Cantidad: "+obj._register+"\n"

print "Memoria de datos"
print "Capacidad: "+obj._dataMemory+"\n"

print "Operaciones"
for i in range(len(obj._operations)):
    print obj._operations[i]
#=======================================READ XML================================

#=====================================CREATE ALU================================
alu = createALU(obj._operations, "ALUInteger.v")

alu.createALUModule()
#=====================================CREATE ALU================================

#=====================================CREATE PC=================================
pc = createPC(pathPC)

pc.create()
#=====================================CREATE PC=================================

#============================== CREATE REGISTER BANK============================
rb = createRB(obj._register);
rb.create();
#============================== CREATE REGISTER BANK============================

#================================== CREATE RAM =================================
RAM = createRAM(obj._dataMemory);
RAM.create();
#================================== CREATE RAM =================================
