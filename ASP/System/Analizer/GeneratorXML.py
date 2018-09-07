"""---------------------------------------------------------------------------
This module has the GeneratorXML class which is the responsible for creating
the interface with the other systems.
----------------------------------------------------------------------------"""

from lxml import etree
#sudo apt-get install python-lxml

from classes import Registers, Data_Memory, CPU


class GeneratorXML:
    """-----------------------------------------------------------------------
    This class is responsible creating the xml file with all the informartion
    obtained of the analysis process.
    -----------------------------------------------------------------------"""
    def __init__(self, asm_file):
        self.asm_file = asm_file
        

    def create_XML(self, cpu):
        """ -----------------------------------------------------------------
        Creates the xml file with all the information stored in the parameter
        which must be a CPU object.
        ---------------------------------------------------------------------"""
        print "Creating Interface.xml file..."
        #Creates the XML root
        root = etree.Element('CPU')

        #Adds the registers bank informartion
        regs = cpu.registers
        root = self.add_Regs_XML(root, regs)

        mem = cpu.data_memory
        root = self.add_Mem_XML(root, mem)

        op = cpu.operations
        #Attaches the operations to the xml file
        root = self.add_List_XML(root, op, "Operations", "Operation")

        nd = cpu.addressing_levels
        #Attaches the addressing levels to the xml file
        root = self.add_List_XML(root, nd, "Addressing_levels", "Level")
        #Prints the xml
        s = etree.tostring(root, pretty_print=True)
        file = etree.ElementTree(root)
        #Name of the xml file to be created in XML folder
        xmlfile = self.asm_file[0:len(self.asm_file)-2]
        file.write("System/XML/Interface.xml")
        print xmlfile, " file created in the XML folder.\n"


    def add_Regs_XML(self, root, regs):
        """------------------------------------------------------------------
        Creates the child of the bank of registers for the xml file and add
        it to the root.
        ------------------------------------------------------------------"""
        #Creates the child of the bank of registers
        regs_child = etree.Element('Registers')
        regs_number = etree.Element('Amount')
        regs_number.text = str(regs.number)
        regs_bits = etree.Element('Bits')
        regs_bits.text = str(regs.bits)
        #Adds the data to the registers child
        regs_child.append(regs_number)
        regs_child.append(regs_bits)
        #Adds the register child to the root
        root.append(regs_child)
        return root

    def add_Mem_XML(self, root, mem):
        """------------------------------------------------------------------
        Creates the child of the data memory for the xml file and add
        it to the root.
        ------------------------------------------------------------------"""
        #Creates the child of the data memory
        mem_child = etree.Element('Data_Memory')
        mem_option = etree.Element('Option')
        mem_option.text = str(mem)
        #Adds the data to the registers child
        mem_child.append(mem_option)
        #Adds the memory child to the root
        root.append(mem_child)
        return root


    def add_List_XML(self, root, list, tag1, tag2):
        """---------------------------------------------------------------
        This method attaches a root child whose tag is given by the tag1
        parameter. This child has others child every one with tag2 and values
        given by the list elements.
        --------------------------------------------------------------------"""
        parent = etree.Element(tag1)
        #Iterates the elements in the list
        for el in list:
            child = etree.Element(tag2)
            child.text = str(el)
            #Adds the element child to the parent
            parent.append(child)
        #Adds the child list to the root
        root.append(parent)
        return root


if __name__ == "__main__":
    #Test
    regs = Registers(32, 32)
    mem = Data_Memory(1024, 10, 10)
    op = ["AND", "OR", "SUB", "ADD"]
    nd = [8, 16, 32, 64]
    cpu = CPU()
    cpu.data_memory = "1"
    cpu.registers = regs
    cpu.operations = op
    cpu.addressing_levels = nd
    gen = GeneratorXML(cpu)
