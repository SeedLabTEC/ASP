"""-----------------------------------------------------------------------
This file contains the declaration of several classes which are used in
the analysis process.
-----------------------------------------------------------------------"""


class Registers:
    """-----------------------------------------------------------------------
    This class is the model of a bank of registers so it has 2 attributes:
        * number -- amount of register in the bank
        * bits   -- number of bits for addresing the registers
    -----------------------------------------------------------------------"""

    def __init__(self, cant = -1, bits = -1):
        """-------------------------------------------------------------------
        Constructor method for the Registers class.
        -------------------------------------------------------------------"""
        self.number = cant
        self.bits = bits

    def __repr__(self):
        """-------------------------------------------------------------------
        Method for defining the way of printing of a object of this class.
        -------------------------------------------------------------------"""
        reg = "\n--- Registers Bank Info ---\n"
        reg += "--Number: %i \n--Address bus bits: %i\n"
        reg += "---------------------------"
        return  reg % (self.number, self.bits)


class Data_Memory:
    """-----------------------------------------------------------------------
    This class is the model of a Data Memory so it has 3 attributes:
        * size      -- size of the memory
        * bus_dir   -- number of bits for addresing
        * bus_data  -- number of bits for the data
    -----------------------------------------------------------------------"""

    def __init__(self, size="-1", b_dir=-1, b_data=-1):
        """-------------------------------------------------------------------
        Constructor method for the Data_Memory class.
        -------------------------------------------------------------------"""
        self.size = size
        self.bus_dir = b_dir
        self.bus_data = b_data

    def __repr__(self):
        """-------------------------------------------------------------------
        Method for defining the way of printing of a object of this class.
        -------------------------------------------------------------------"""
        mem = "--- Data_Memory --- \n"
        mem += "-Size: %s \n-bus_dir = %i\n-bus_data: %i\n"
        return mem % (self.size, self.bus_dir, self.bus_data)


class CPU:
    """-----------------------------------------------------------------------
        This class is used for storing the information obtained from the
        analysis process.
        * data_memory -- data memory option that will be used
        * registers   -- bank of register (Registers object)
        * operations  -- list of operations
        * addressing_levels -- list of addressing levels
    -----------------------------------------------------------------------"""

    def __init__(self):
        """-------------------------------------------------------------------
        Constructor method for the CPU class.
        -------------------------------------------------------------------"""
        self.data_memory = "-1"
        self.registers = None
        self.operations = []
        self.addressing_levels = []

    def printInfo(self):
        """-------------------------------------------------------------------
        Method for defining the way of printing of a object of this class.
        -------------------------------------------------------------------"""
        print "#################### CPU #######################"
        self.print_Data_Mem()
        print 'Operations:'
        print self.operations
        print '\nAddressing levels:'
        print self.addressing_levels
        print "#################### END CPU ####################\n"

    def print_Data_Mem(self):
        """-------------------------------------------------------------------
        Method for printing the data memory of the cpu according to the option.
        -------------------------------------------------------------------"""
        if self.data_memory == "15":
            print Data_Memory("32 KB", 15, 32)
        elif self.data_memory == "16":
            print Data_Memory("64 KB", 16, 32)
        elif self.data_memory == "17":
            print Data_Memory("128 KB", 17, 32)
