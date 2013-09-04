#!/usr/bin/python

##################################################################
#
# iDEA Simulator
#   Sourceline.py
#
# NOT USED!
#   Supposed to contain debug information for instructions
#
# Fredrik Brosser 2013-05-14
#
##################################################################


class Sourceline(object):

    def __init__(self, **input):
        self.instr = None
        self.opcode = None
        self.addr = None 
        self.line = None
        self.comment = None

        for key in input:
            if key in self.values.keys():
                self.values[key] = input[key]
            else:
                self.controls[key] = input[key]

    @property
    def instr(self):
        """ Get this line's instruction """
        return self.instr
    
    @property
    def opcode(self):
        """ Get this line's opcode """
        return opcode
    
    @property
    def addr(self):
        """ Get this line's memory address as given in asm file """
        return self.addr
    
    @property
    def line(self):
        """ Get this line's line number """
        return self.line
    
    @property
    def comment(self):
        """ Get this line's comment (if any) """
        return self.comment
    
    def __str__(self):
        str = "%s %s\t %s %s %s" % (self.line, self.addr, ":", self.opcode, self.instr, self.comment)
        return str
