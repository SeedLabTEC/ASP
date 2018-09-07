import unittest
from Analizer import Analizer


class TestMyModule(unittest.TestCase):

    def test_sum(self):
        an = Analizer("__Test1_op2.s")
        regs_bank = an.determine_Regs_Bank_Info()
        print "Checking number of register is 7"
        self.assertEqual(regs_bank.number, 8)
        print "Checking number of register is 3"
        self.assertEqual(regs_bank.bits, 6)



if __name__ == "__main__":
    unittest.main()
