"""---------------------------------------------------------------------------
This module has the Analizer class which is the responsible for analyzing the
code of the specific application.
----------------------------------------------------------------------------"""

import math
from Reader import Reader
from classes import Registers, Data_Memory, CPU

"""Name of the file with the instructions that requires every ALU operation """
INSTRS_BY_OPERATION_FILE = "System/Analizer/instrs_operations_data"

class Analizer:
    """---------------------------------------------------------------------
    This class is responsible for analyzing the code of the application
    for determining the required operations, addressing levels and data
    memory option.
    ----------------------------------------------------------------------"""

    def __init__(self, asm_code_file):
        """------------------------------------------------------------------
        Constructor method for Analizer class. Receives the asm file name
        to be analized.
        ------------------------------------------------------------------ """
        #Gets the instrucctions and put them on the list
        self.instrs = self.get_Instrs("System/Analizer/"+ asm_code_file)



    def analize(self):
        """------------------------------------------------------------------
        This method do the analysis of the application code and returns
        a CPU object with all the information obtained.
        ------------------------------------------------------------------"""
        #CPU object for storing all the information
        cpu = CPU()
        #Asks for the memory option to be used
        cpu.data_memory = self.ask_for_memory_option()
        #Determines the registers bank information
        cpu.registers = self.determine_Regs_Bank_Info()
        #Gets the operations required
        cpu.operations = self.determine_operations()
        #Gets the addressing levels required
        cpu.addressing_levels = self.determine_addressing_levels()
        cpu.printInfo()
        return cpu


    def get_Instrs(self, asm_file):
        """--------------------------------------------------------------
        Reads the file with the assembler code and puts the instructions
        in the list to be returned
        -----------------------------------------------------------------"""
        #Object to read the asm code
        reader = Reader(asm_file)
        #List to store the instructions
        instrs = []
        for instr in reader.get_Text_Lines():
            instr = instr.replace(" ", "")
            if instr != "" and not instr.startswith("."):
                #Replaces some characteres by spaces
                instr = instr.rstrip('\n').replace(",", " ")
                instr = instr.replace("(", " ")
                instr = instr.replace(")", " ")
                instr = instr.replace("\t", " ")
                #Adds the line to the list
                instrs.append(instr)
        return instrs


    def is_register(self, element, mat):
        """------------------------------------------------------------------
        Returns True if the parameter element is the name of a register of
        RISC-V
        ------------------------------------------------------------------ """
        resp = False
        for list in mat:
            for el in list:
                if element == el:
                    resp = True
                    break
        return resp

    def get_ABI_Names_of_Reg(self, reg, mat):
        """------------------------------------------------------------------
        Return a list with all the ABI names for a register.
        ------------------------------------------------------------------"""
        resp = None
        for list in mat:
            for el in list:
                if reg == el:
                    resp = list
                    break
        return resp

    def determine_Regs_Bank_Info(self):
        """------------------------------------------------------------------
        Determines the information of the registers bank needed by
        the kernel to be executed.
        - Output: Registers object with the information.
        ------------------------------------------------------------------"""
        regs_reported = []
        #The number of registers is 0 initially
        amount = 0
        #The ABI names of the registers are got
        regs_abi_names = self.get_ABI_Names_Regs()
        #The instructions are iterated
        for instr in self.instrs:
            #The instruction is splitted
            parts = instr.split(" ")
            #Deletes the opcode mnemonic
            parts = parts[1:]
            #It is iterated in the parts of the instruction
            for part in parts:
                #If the part is a register
                if self.is_register(part, regs_abi_names):
                    #If the register has not been used
                    if not part in regs_reported:
                        #Increases the registers needed
                        amount +=  1
                        #The ABI names of the register are obtained
                        part_abi_names = self.get_ABI_Names_of_Reg(part, regs_abi_names)
                        #The names are reported to the list
                        regs_reported.extend(part_abi_names)
        #Returns Register Object with all the information got
        return Registers(amount, self.determine_bits_address(amount))




    def determine_bits_address(self, amount):
        """------------------------------------------------------------------
        This method determines the number of required bits for being
        able to address amount number of objects like registers, addresses
        memory, etc.
        -Input: number of objects to be addressed. It should be positive.
        -Output: number of bits required to address 'amount' objects.
        ------------------------------------------------------------------"""
        bits_number = math.log(amount)/math.log(2)
        decimals = bits_number - int(bits_number)
        if decimals != 0:
            bits_number = int(bits_number) + 1
        return int(bits_number)


    def ask_for_memory_option(self):
        """------------------------------------------------------------------
        Asks for the memory option that will be used in the processor.
        First, shows the three options and then the user has to enter the
        1, 2 or 3 according to what she/he needs
        ------------------------------------------------------------------"""
        print "Below they are presented the options for the data memory:\n"
        #Builds the message to be displayed
        ask_msj = "Choose one of the memory options "
        ask_msj += "according to what you require: "
        #Memory options available
        print "OPTION 1"
        print Data_Memory("32 KB", 15, 32)
        print "OPTION 2"
        print Data_Memory("64 KB", 16, 32)
        print "OPTION 3"
        print Data_Memory("128 KB", 17, 32)
        mem_option = -1
        valid_option = False
        while not valid_option:
            #Asks for the memory option
            mem_option = raw_input(ask_msj)
            if mem_option.isdigit() and int(mem_option) > 0 and int(mem_option) <= 3:
                valid_option = True
            else:
                print "Error: the chosen option is not valid\n"
        print "Memory Option to be used: ", mem_option, "\n"
        return str(int(mem_option)+14)


    def get_ABI_Names_Regs(self):
        """------------------------------------------------------------------
        This method returns a list with the ABI names that are
        used by the RISCV assembler.
        ------------------------------------------------------------------"""
        #List to be returned with the abi names
        regs_abi_names = []
        #There are 32 registers
        for i in range(32):
            regs_abi_names.append([])
            regs_abi_names[i].append("x" + str(i))
            #Adds the abi names to the list
            regs_abi_names[i].extend(self.get_ABI_Names_Aux(i))
        return regs_abi_names


    def get_ABI_Names_Aux(self, reg_num):
        """------------------------------------------------------------------
        Returns a list with the ABI names of a specific register.
        The reg_num parameter specifies the register of interest.
        This method is used by the get_ABI_Names_Regs method.
        ------------------------------------------------------------------"""
        #ABI: Application Binary Interface
        abi_names_list = []
        #if reg_num == 0:
            #Hard-wired zero
        #    abi_names_list.append("zero")
        if reg_num == 1:
            #Return address
            abi_names_list.append("ra")
        elif reg_num == 2:
            #Stack pointer
            abi_names_list.append("sp")
        elif reg_num == 3:
            #Global pointer
            abi_names_list.append("gp")
        elif reg_num == 4:
            #Thread pointer
            abi_names_list.append("tp")
        elif reg_num >= 5 and reg_num <= 7:
            #Temporaries: t0-t2
            abi_names_list.append("a" + str(reg_num-5))
        elif reg_num == 8:
            #Saved register
            abi_names_list.append("s0")
            #Frame pointer
            abi_names_list.append("fp")
        elif reg_num == 9:
            #Saved Register
            abi_names_list.append("s1")
        elif reg_num >= 10 and reg_num <= 17:
            #Function arguments: a0-a7
            abi_names_list.append("a" + str(reg_num-10))
        elif reg_num >= 18 and reg_num <= 27:
            #Saved registers: s2-s11
            abi_names_list.append("s" + str(reg_num-16))
        elif reg_num >= 28:
            #Temporaries t3-t5
            abi_names_list.append("t" + str(reg_num-25))
        return abi_names_list



    def determine_operations(self):
        """------------------------------------------------------------------
        Determines the operations that are used in the assembler code of the
        application and put them into a list to be returned.
        ------------------------------------------------------------------"""
        #List of operations
        operations = []
        #Gets a dictonary that indicates the instructions
        #that requires each ALU operation.
        dic = self.get_Instrs_by_Operations_Dic()
        #Instructions that have been analized
        instructions = []
        #Analizes every instruction
        for instr in self.instrs:
            parts = instr.split(" ")
            if parts[0] == "":
                parts = parts[1:]
            opcode = parts[0]
            #If the instruction hasn't been analyzed
            if not opcode in instructions:
                #Operation required by the instruction
                operation = None
                #Gets the keys of the dictonary
                dic_keys = dic.keys()
                #Iterates the keys list where every key
                #corresponds to an ALU operation
                for key in dic_keys:
                    #Obtains the values of that key
                    values = dic.get(key)
                    if opcode in values:
                        #The instruction needs this operation
                        operation = key
                        break
                #If the operation is not in the list
                if not operation in operations and operation != None:
                    #Adds the operation
                    operations.append(operation)
                #Marks the instruction like analyzed
                instructions.append(opcode)
        #Returns the list with the operations needed
        return operations



    def get_Instrs_by_Operations_Dic(self):
        """------------------------------------------------------------------
        Returns a dictionary that contains, for every ALU operation, the
        intructions that require the operation. For doing this, reads the file
        instrs_operations_data.
        ------------------------------------------------------------------"""
        #Object to read the asm_data
        reader = Reader(INSTRS_BY_OPERATION_FILE)
        #Dictionary to be returned
        dic = {}
        #Text lines are got in a list
        for line in reader.get_Text_Lines():
            if line.startswith("*"):
                line = line.rstrip('\n').replace(",", "")
                #The instruction is splitted
                parts = line.split(" ")
                #Removes the * character of the list
                parts = parts[1:]
                dic[parts[0]] = parts[2:]
        return dic


    def determine_addressing_levels(self):
        """------------------------------------------------------------------
        This method determines the addressing levels required by the
        application. For doing this, checks which of the load and store
        instructions are present in the code. Returns a list with the
        addressing levels: 8,16,32,64 [bits]
        ------------------------------------------------------------------"""
        #Acronym AL = Addressing level
        #List to be returned
        levels = []
        for instr in self.instrs:
            parts = instr.split(" ")
            if parts[0] == "":
                parts = parts[1:]
            opcode = parts[0]
            #Addressing level used by instr is assumed to be none
            level = None
            #Checks the load and store instruction which are the ones
            #that determine the ALs
            if opcode.startswith('lw') or opcode.startswith('sw'):
                level = "32"
            elif opcode.startswith('lh') or opcode.startswith('sh'):
                level = "16"
            elif opcode.startswith('lb') or opcode.startswith('sb'):
                level = "8"
            #This AL is not supposed to be used in this first project version
            elif opcode.startswith('ld') or opcode.startswith('sb'):
                level = "64"
            #If the instruction uses an AL and has not been added..
            if level != None and not level in levels:
                #Adds the AL to the list
                levels.append(level)
        return levels
