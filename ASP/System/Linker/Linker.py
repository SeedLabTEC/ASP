"""----------------------------------------------------------------------------
This file contain all the method related with toolchain manipulation and the 
parameter definition, fallowing the next steps:

1) Generates the object file.
2) Generates the dump file. 
3) Generates the machine code in hexadecimal.
4) Optimize the machine code.
6) Establish the ROM memory parameters.
7) Generates the txt files who are loading in to the ROM memory.
8) Generates the memoryParam.vh file.
9) Generates ProgramCounter.xml file
10) Reorganize all the files.
--------------------------------------------------------------------------- """

#Libs for commands execution
import commands 
import sys
import os

#Files names definition
archivoE = sys.argv[1]
a = len(archivoE) - 1
b = a - 1
archivoO = 'System/Linker/' + archivoE[0:a] + 'o'
archivoD = 'System/Linker/' + archivoE[0:a] + 'dump'
archivoT = 'System/Linker/' + archivoE[0:a] + 'txt'
archivoOp = 'System/Linker/' + archivoE[0:b] + '_Optimizado.txt'

ROM_ADDR_BITS = 0
ROM_ADDR_START_BITS = 0
BEGIN_ADDR_ROM_PROGRAM = 0
END_ADDR_ROM_PROGRAM = 0
ProgramStartAddressPC = 0

#Functions
# Object file generation
def getObjectFile():
    res = commands.getoutput('riscv32-unknown-elf-gcc -o ' + archivoO + ' System/Linker/'+ archivoE + ' -march=rv32i')
    if (len(res) == 0):
        print 'The object code has been obtained.'
    else:
        print "Error obtaining object code..."

# Dump file generation
def getDumpFile():
    res = commands.getoutput('riscv32-unknown-elf-objdump -d ' + archivoO + ' > '+ archivoD)
    if (len(res) == 0):
        print 'The assembler dump has been obtained.'
    else:
        print "Error obtaining the dump..."
        print res

# Hexadecimal code generation
def getHexaCode():
    res = commands.getoutput('elf2hex 4 65536 ' + archivoO + ' > '+ archivoT)
    if (len(res) == 0):
        print 'The assemblers hexadecimal file has been obtained.'
    else:
        print "Error getting the hexadecimal file..."
        print res

# Base adress definition
def getBase():
    archivoH32 = open(archivoT,"r")
    base = 0
    #linea1 = archivoH32.readline()
    #print linea1 == '00000000\n'
    for linea in archivoH32.readlines():
        if(linea == '00000000\n'):
            base = base + 1
        else:
            break
    archivoH32.close
    return base + 1

#Last adress definition
def getFinal(base):
    archivoH32 = open(archivoT,"r")
    final = 0
    final2 = 0
    for linea in archivoH32.readlines():
        if(final >= base):
            if(linea == '00000000\n'):
                final2 = final2 + 1
                if(final2 >= (final + 100)):
                    break
            else:
                final = final2
                final = final + 1
                final2 = final
        else:
            final = final + 1
            final2 = final
    archivoH32.close
    return final2

#Optimization of the hexagesimal code
def getCompressFile(base, final):
    count = 1
    archivoH32 = open(archivoT,"r")
    archivoH32C= open(archivoOp,"w+")
    for linea in archivoH32.readlines():
        if(count >= base and count <= final):
            archivoH32C.write(linea)
        count = count + 1
    tamanoMemoria = getParam(final-base)
    tamanoMemoria = tamanoMemoria - 1
    for i in range(tamanoMemoria):
        archivoH32C.write("00000000\n")
    archivoH32.close
    archivoH32C.close
    print "Optimizing hexadecimal file."

#Content generation
def getFilesToLoad():
    archivoH32 = open(archivoOp,"r")
    archivoL = open("System/Linker/CodigoProgramaLOW.txt","w+")
    archivoH = open("System/Linker/CodigoProgramaHIGH.txt","w+")
    for linea in archivoH32.readlines():
        archivoL.write(linea[6:8] + "\n")
        archivoL.write(linea[4:6] + "\n")
        archivoH.write(linea[2:4] + "\n")
        archivoH.write(linea[0:2] + "\n")
    archivoL.close
    archivoH.close
    print "Loading files have been obtained."

#Parameters definition
def getParam(tamanoCodigo):
    tamanoCodigo = tamanoCodigo * 2
    bits = 0
    dirinicio = 32768
    programStart = 15
    while((2**bits) <= tamanoCodigo):
        bits+=1
    dirend = dirinicio + (2**bits) -1;
    print("Code size: "+ str(tamanoCodigo/2))
    print("Memory size: "+ str((2**bits)))
    print("Number of sizing bits: "+str(bits))
    print("Start of program: " + str(programStart))
    print("Initial direction: " + format(dirinicio, '#06X'))
    print("Final address: " + format(dirend,'#06X'))
    global ROM_ADDR_BITS
    ROM_ADDR_BITS = bits
    global ROM_ADDR_START_BITS
    ROM_ADDR_START_BITS = programStart
    global BEGIN_ADDR_ROM_PROGRAM
    BEGIN_ADDR_ROM_PROGRAM = dirinicio
    global END_ADDR_ROM_PROGRAM
    END_ADDR_ROM_PROGRAM = dirend
    tamanoCodigo = tamanoCodigo / 2
    return 2**(bits-1) - tamanoCodigo

def getProgramStartAddressPC():
    arDump = open(archivoD,"r")
    for linea in arDump.readlines():
        if(len(linea) > 0):
            #print(linea[0:len(linea)-1])
            if(linea[len(linea)-10:len(linea)] == "<_start>:\n"):
                stdir = int(linea[0:len(linea)-11],16)
            if(linea[len(linea)-8:len(linea)] == "<main>:\n"):
                madir = int(linea[0:len(linea)-9],16)
    pc = (madir - stdir)/2 + 0x8000
    print("Initial PC address: " + format(pc,'#06X'))
    global ProgramStartAddressPC
    ProgramStartAddressPC = pc
    arDump.close

#Parameters file generation
def getParamFile():
    archivoParam = open("System/Linker/ROMmemoryparam.vh","w+")
    #Header = "// ROMmemoryparam.vh\n //If we have not included file before, \n// this symbol _my_incl_vh_ is not defined.\n" 
    #CM = "// Start of include contents\n"
    RAB = "`define ROM_ADDR_BITS " + str(ROM_ADDR_BITS) + "\n"
    RASB = "`define ROM_ADDR_START_BITS " + str(ROM_ADDR_START_BITS) + "\n"
    BARP = "`define BEGIN_ADDR_ROM_PROGRAM 32'd" + str(BEGIN_ADDR_ROM_PROGRAM) + "\n"
    EARP = "`define END_ADDR_ROM_PROGRAM 32'd"  + str(END_ADDR_ROM_PROGRAM) + "\n"
    SP = "`define StackPointer 32'd" + str(BEGIN_ADDR_ROM_PROGRAM) + "\n" 
    PSAPC = "`define ProgramStartAddressPC 32'd" + str(ProgramStartAddressPC)+ "\n"
    contenido = "`ifndef _ROMmemoryparam_vh \n`define _ROMmemoryparam_vh \n"+RAB+RASB+BARP+EARP+SP+PSAPC+"`endif"
    archivoParam.write(contenido)
    archivoParam.close
    print 'The parameters file of the ROM memory has been created.'

#Parameter for pc generation 
def getPCFile():
    archivoPC = open("System/Linker/ProgramCounter.xml","w+")
    archivoPC.write( "<ProgramCounter>"+ str(ROM_ADDR_BITS)+"</ProgramCounter>")
    archivoPC.close
    print 'The XML file with the dimensions of the PC has been created.'

#Files organization
def organizeFiles():
    commands.getoutput('mv ' + archivoE + '  System/Linker/Temporal_Linker_Files')
    commands.getoutput('rm  System/Linker/' + archivoE)
    commands.getoutput('mv ' + archivoO + '  System/Linker/Temporal_Linker_Files')
    commands.getoutput('mv ' + archivoD + '  System/Linker/Temporal_Linker_Files')
    commands.getoutput('mv ' + archivoT + '  System/Linker/Temporal_Linker_Files')
    commands.getoutput('mv ' + archivoOp + '  System/Linker/Temporal_Linker_Files')
    commands.getoutput('mv System/Linker/ProgramCounter.xml System/XML')
    commands.getoutput('mv System/Linker/CodigoProgramaHIGH.txt System/Processor')
    commands.getoutput('mv System/Linker/CodigoProgramaLOW.txt System/Processor')
    commands.getoutput('mv System/Linker/ROMmemoryparam.vh System/Processor')
    print "The system files have been re-organized."


#Functions calls
getObjectFile()
getDumpFile()
getHexaCode()
base = getBase()
final = getFinal(base)
getCompressFile(base, final)
getFilesToLoad()
getProgramStartAddressPC()
getParamFile()
getPCFile()
organizeFiles()


