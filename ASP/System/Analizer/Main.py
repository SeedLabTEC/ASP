"""----------------------------------------------------------------------------
This file contains the main method which is first to be executed.
The next 2 steps are followed by this method:
1) First, it is done the analysis of the application code and asks the user
to select the data memory option to be used. For doing this is used an Analizer
class object.
2) Finally, it is used a GeneratorXML class object for making the interface
with all the information gotten from the analysis.
--------------------------------------------------------------------------- """
import sys
from Analizer import Analizer
from GeneratorXML import GeneratorXML


def main():
    #Gets the asm file name 
    ASM_FILE = sys.argv[1]
    #Object to do the analysis
    analizer = Analizer(ASM_FILE)
    #Gets the information in a CPU object
    cpu = analizer.analize()
    #Creates the interface (XML file) for the other modules
    gen_XML = GeneratorXML(ASM_FILE)
    gen_XML.create_XML(cpu)


if __name__ == "__main__":
    main()
