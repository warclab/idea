##################################################################
#
# iDEA Simulator
#   Instruction.py
#
# Modelling an iDEA instruction
# Fredrik Brosser 2013-05-14
# 
# Supported Instructions:
#
# Pseudo: ['neg', 'negu', 'abs', 'break', 'move'],
# R-Type: ['add', 'sub', 'and', 'or', 'jr', 'jalr', 'nor', 'slt',
#          'addu', 'subu', 'sltu', 'xor', 'sll', 'srl', 'sra', 
#          'sllv', 'srlv', 'srav', 'jr', 'nop', 'mult', 'multu', 
#          'div', 'divu', 'mflo', 'mfhi', 'mtlo', 'mthi', 'mac'],
# I-Type: ['addi', 'subi', 'ori', 'lw', 'sw', 'lh', 'lb', 'sh', 'sb', 
#          'lhu', 'lbu', 'shu', 'sbu', 'addiu', 'slti', 'sltiu', 'andi', 
#          'xori', 'lui', 'li', 'bne', 'beq', 'blez', 'bgtz', 'bltz', 
#          'bgez', 'bnez', 'beqz']
# J-Type: ['j', 'jal']
#
# R-Type Instructions
# opcode(6), rs(5), rt(5), rd(5), sa(5), func(6)
# I-Type Instructions
# opcode(6), rs(5), rt(5), immediate(16)
# J-Type Instructions
# opcode(6), target(26)
# 
# instr - type of instruction
# op - operation
# rs - source register
# rt - transition register
# rd - destination register
# sa (shamt) - shift amount
# target - target address
# func - function
#
##################################################################


# Modelling an iDEA instruction
#   **input : dict containing the initialization data for the instruction
class Instruction(object):
    def __init__(self, **input):
        self.result = None
        
        self.source1RegValue = None 
        self.source2RegValue = None
        self.source3RegValue = None
        self.sourceAddr = None

        # Python dict holding the register and operation information
        # Corresponding to the bit fields of the instructions
        self.values = {
                       'op': None,
                       'dest': None,
                       's1': None,
                       's2': None,
                       's3': None,
                       'immed': None,
                       'shamt': None,
                       'target': None
                       
        }

        # Instruction classifications
        self.controls = {'aluop'   : None,
                         'regRead' : None,
                         'regWrite': None,
                         'readMem' : None,
                         'writeMem': None,
                         'branch'  : None,
                         'coreInstr': None  }

        # Copy input values to instruction object
        for key in input:
            if key in self.values.keys():
                self.values[key] = input[key]
            else:
                self.controls[key] = input[key]

    @property
    def op(self):
        """ Get this Instruction's name """
        return self.values['op']
    
    @property
    def dest(self):
        """ Get this Instruction's destination register """
        return self.values['dest']
    
    @property
    def s1(self):
        """ Get this Instruction's first source register """
        return self.values['s1']
    
    @property
    def s2(self):
        """ Get this Instruction's second source register """
        return self.values['s2']

    @property
    def s3(self):
        """ Get this Instruction's third source register (used for example in MAC)"""
        return self.values['s3']

    @property
    def shamt(self):
        """ Get this Instruction's shift amount """
        return self.values['shamt']
    
    @property
    def immed(self):
        """ Get this Instruction's immediate value """
        return self.values['immed']
    
    @property
    def target(self):
        """ Get this Instruction's target value """
        return self.values['target']
    
    @property
    def aluop(self):
        """ Get this Instruction's control to decide an alu operation """
        return self.controls['aluop']
    
    @property
    def regRead(self):
        """ Get this Instruction's control to decide to read a register"""
        return self.controls['regRead']
    
    @property
    def regWrite(self):
        """ Get this Instruction's control to decide to write a register """
        return self.controls['regWrite']
    
    @property
    def readMem(self):
        """ Get this Instruction's control to decide to read memory """
        return self.controls['readMem']
    
    @property
    def writeMem(self):
        """ Get this Instruction's control to decide to write memory """
        return self.controls['writeMem']
    
    @property
    def branch(self):
        """ Get this Instruction's control to decide if branch instr """
        return self.controls['branch']

    @property 
    def coreInstr(self):
        """ Get this Instruction's core/kernel/loop status """
        return self.controls['coreInstr']
    
    # Get instruction information as a nicely formatted string
    def __str__(self):
        str = "%s\t%s %s %s %s %s %s" % (self.values['op'],
                                  self.values['dest'] if self.values['dest'] else "",
                                  self.values['s1'] if self.values['s1'] else "",
                                  self.values['s2'] if self.values['s2'] else "",
                                  self.values['shamt'] if self.values['shamt'] else "",
                                  self.values['immed'] if self.values['immed'] else "",
                                  self.values['target'] if self.values['target'] else "")
        return str
    
    def __repr__(self):
        return repr(self.values)

    
# Special class modelling a NOP instruction
class Nop(Instruction):

    def __init__(self):
        self.core = False

    def setCore(self,core):
        self.core = core

    @property
    def op(self):
        """ Get this Instruction's name """
        return 'nop'

    def core(self):
        """ Get this Instruction's name """
        return self.core

    def __str__(self):
        return 'nop'  
    pass
