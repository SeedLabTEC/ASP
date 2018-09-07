"""------------------------------------------------------------
This module has the Reader class.
-------------------------------------------------------------"""

class Reader:
    """--------------------------------------------------------
    This class is responsible for reading the content of files
    ----------------------------------------------------------"""

    def __init__(self, file_name):
        """-----------------------------------------------------
        Receives the name of the file and call the method that
        put the text lines in a list.
        ------------------------------------------------------"""
        #List with all the instrucctions of the asm code
        self.lines = []
        #Checks the parameter type is correct
        if (self.check_file_name(file_name)):
            # Reads the file and fill the list
            # with the text lines
            self.read_Text(file_name)


    def check_file_name(self, asm_file_name):
        """---------------------------------------------------
        Receives the name of the file that has the asm asm_code
        and checks that its data type is correct.
        ------------------------------------------------------"""
        valid_name = isinstance(asm_file_name, str)
        if (not valid_name):
            print "Error: name indicated is not a text string"
        return valid_name


    def print_Text(self):
        """---------------------------------------------------
        Prints the text lines in the list of the class.
        ------------------------------------------------------"""
        print "---Line number:", len(self.lines), "---"
        i = 0
        for line in self.lines:
            print i, line
            i = i + 1
        print "---End of the text---"

    def get_Text_Lines(self):
        return self.lines


    def read_Text(self, file_name):
        """---------------------------------------------------
        Receives the name of the file, reads the content and
        put the text lines in the list 'lines' of the class.
        ------------------------------------------------------"""
        try:
            #Gets the file descriptor for reading the file
            file = open(file_name, "r")
        except (IOError):
            print "Error when opening the file '", file_name, "'"
            print "Check the file name is correct"
        else:
            #Adds the instructions to the list
            for line in file.readlines():
                self.lines.append(line)
            #Closes the file
            file.close()
