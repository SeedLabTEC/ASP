"""----------------------------------------------------------------------------
This file generates the assembler code with the toolchain and run the 
system modules in the right order. 
--------------------------------------------------------------------------- """

#Libs for commands execution
import commands
import os

archivo = raw_input('Please insert the name of the file \n')
print 'Compiling the file: ' + archivo 
#Compilation of the input file
res = commands.getoutput('riscv32-unknown-elf-gcc -S C_Source/' + archivo + ' -march=rv32i')
#Modules execution
if (len(res) == 0):
    print 'The assembler file has been obtained.'
    a = len(archivo) - 1;
    archivo_Ensamblador = archivo[0:a] + 's'
    commands.getoutput("cp " + archivo_Ensamblador + " System/Analizer/")
    os.system("python System/Analizer/Main.py " + archivo_Ensamblador)
    commands.getoutput("rm System/Analizer/" + archivo_Ensamblador)
    commands.getoutput("cp " + archivo_Ensamblador + " System/Linker/")    
    os.system("python System/Linker/Linker.py " + archivo_Ensamblador)
    os.system("python System/Generator/Main.py")
    commands.getoutput("rm -r Processor")
    commands.getoutput("cp -r System/Processor Processor/")
else:
    print "Compilation error..."
    print res













#riscv32-unknown-elf-gcc -S holamundo.c -march=rv32i'
#riscv32-unknown-elf-gcc -o hola.o  holamundo.s -march=rv32i'
