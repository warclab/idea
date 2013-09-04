##################################################################
#
# iDEA Simulator
#   InstructionParser.py
#
# Parsing and preprocessing assembly code for simulation
# Fredrik Brosser 2013-05-14
#
##################################################################


from Instruction import Instruction
from Instruction import Nop


class InstructionParser(object):

    ## Constructor
    def __init__(self):

        self.expandInstruction = False
        self.CCoreInstr = []

        # dict (string -> string array) containing the full iDEA instruction set,
        # divided according to instruction type (R, I, J, Pseudo)
        self.instructionSet = {
            'pseudo': [ 'neg', 'negu', 'abs', 'break'],
            'rtype':  [ 'add', 'sub', 'and', 'or', 'jr', 'jalr', 'nor', 'slt',
                        'addu', 'subu', 'sltu', 'xor',
                        'sll', 'srl', 'sra', 'sllv', 'srlv', 'srav',
                        'jr', 'nop', 'mult', 'multu', 'div', 'divu',
                        'mflo', 'mfhi', 'mtlo', 'mthi',
                        'mac'],
            'itype':  [ 'addi', 'subi', 'ori', 'lw', 'sw', 'lh', 'lb', 'sh', 'sb', 'lhu', 'lbu', 'shu', 'sbu',
                        'addiu', 'slti', 'sltiu', 'andi', 'xori', 'lui', 'li',
                        'bne', 'beq', 'blez', 'bgtz', 'bltz', 'bgez', 'bnez', 'beqz',
                        'move'],
            'jtype':  [ 'j', 'jal']
        }

        # Shortforms for dependency log messages
        self.loglines = { 
            "MEM": "Memory dependency between instructions at memory locations ",
            "WAR": "WAR dependency between instructions at memory locations ",
            "RAW": "RAW dependency between instructions at memory locations ",
            "WAW": "WAW dependency between instructions at memory locations ",
            "END": "End of logfile"
            }

        # NOP insertion list
        self.nopInserts = []
        self.nopInsertsCore = []

        # Number of NOPs to be inserted (default value)
        self.nNOPs = 6
        self.IFiterations = 0

    ## Parse complete file
    #   filename : file containing the assembly code to parse
    def parseFile(self, filename):
        with open(filename) as f:
            # Remove newlines
            data = filter((lambda x: x != '\n'), f.readlines())
            # Parse each instruction
            instructions = [self.parse(a.replace(',',' ')) for a in data]
            return instructions

    ## Parse list of assembly code lines
    #   lines : lines of assembly code
    #   nNOPs : number of NOPs to insert
    #   IFiterations : number of IF stages in the pipeline
    #   CCoreInstr : List of core instructions
    def parseLines(self, lines, nNOPs, IFiterations, CCoreInstr):
        self.CCoreInstr = CCoreInstr
        self.IFiterations = IFiterations
        print "###################### Preprocessing Logfile ######################\n"
        self.nNOPs = nNOPs
        
        # Parse line by line
        instructions = [self.parse(a.replace(',',' ')) for a in lines]
        
        # Classify instructions as core or non-core
        instructions = self.insertCoreStatus(instructions)
        
        # Insert END instruction for simulation
        instructions = self.createEndInstruction(instructions)
        print "<Successfully parsed instructions>"
        print "\tInstruction Count: ", len(instructions) 

        # Insert NOP fillers to resolve dependencies
        instructions = self.checkDependencies(instructions)
        print "\n<Preprocessing finished>"
        return instructions

    ## Parse a single line of assembly code
    #   s : line to parse
    def parse(self, s):
        s = s.split()
        
        # Get instruction mnemonic
        instr = s[0]
        instr.strip()
        print s

        # Translate/Expand pseudo instruction
        if instr in self.instructionSet['pseudo']:
            return self.translatePseudoInstruction(s)

        # Create R-Type instruction
        if instr in self.instructionSet['rtype']:
            return self.createRTypeInstruction(s)
        
        # Create I-Type instruction
        elif instr in self.instructionSet['itype']:
            return self.createITypeInstruction(s)    
        
        # Create J-Type instruction
        elif instr in self.instructionSet['jtype']:
            return self.createJTypeInstruction(s)
        
        # None of the above (invalid instruction)
        else:
            print "Could not parse instruction: ", instr
            raise ParseError("Invalid parse instruction")

##########################################################
#
#   INSTRUCTION CREATION
#
##########################################################

    ## Translate pseudo instruction into iDEA supported instruction
    def translatePseudoInstruction(self, s):
        if(s[0] in ["neg", "negu"]):
            return Instruction(op="sub", dest=s[1], s1=s[2], s2="$0", regRead=1, regWrite=1, aluop=1)
        elif s[0] == "abs" and n == 0:
            return Instruction(op="abs", s1 = s[1], regRead = 1, regWrite=1, aluop=1)
        elif s[0] == "break":
            return Instruction(op='nop')

    ## Append END instruction to the end of the file (replacing the last JR)
    def createEndInstruction(self, instructions):
        replaceindex = -1
        # Find index to input END in
        for idx, instr in enumerate(reversed(instructions)):
            if instr.op == 'jr':
                replaceindex = len(instructions)-idx
                break
        if(replaceindex != -1):
            # Create and insert END instruction (only used by simulator)
            instructions.pop(replaceindex-1)
            instructions.insert(replaceindex, Instruction(op="END", dest=None, s1=None, s2=None, regRead=0, regWrite=0, aluop=0))
        return instructions

    ## Create and return an R-Type instruction, setting the instruction fields and classifications accordingly
    #   s : instruction line
    def createRTypeInstruction(self, s):
        if s[0] in ["jr", "jalr"]:
            return Instruction(op=s[0], s1 = s[1], regRead = 1, aluop=0, branch=1)
        if(s[0] == "nop" or (s[0] == "sll" and s[1] == "$r0")):
            return Instruction(op='nop')
        if(s[0] in ["mult", "multu"]):
            return Instruction(op=s[0], dest=s[1], s1=s[1], s2=s[2], regRead=1, regWrite=1, aluop=1)
        if(s[0] in ["mflo", "mfhi"]):
            return Instruction(op=s[0], dest=s[1], s1=None, s2=None, regWrite=1, aluop=1)
        if(s[0] in ["mtlo", "mthi"]):
            return Instruction(op=s[0], dest=s[1], s1=None, s2=None, regWrite=1, aluop=1)
        if(s[0] in ['sll', 'srl', 'sra']):
            return Instruction(op=s[0], dest=s[1], s1=s[2], shamt=s[3], regRead=1, regWrite=1, aluop=1)
        if(s[0] in ['mac']):
            return Instruction(op=s[0], dest=s[1], s1=s[2], s2=s[3], s3=s[1], regRead=1, regWrite=1, aluop=1)
        return Instruction(op=s[0], dest=s[1], s1=s[2], s2=s[3], regRead=1, regWrite=1, aluop=1)

    ## Create and return an I-Type instruction, setting the instruction fields and classifications accordingly
    #   s : instruction line
    def createITypeInstruction(self, s):
        memread = s[0] in ['lw', 'lb', 'lh', 'lbu', 'lhu']
        memwrite = s[0] in ['sw', 'sb', 'sh', 'sbu', 'shu']
        if (memread or memwrite):
            import re 
            regex = re.compile("(-?\d+)\((\$r\d+)\)")
            match = regex.match(s[2])
            immedval = match.group(1) 
            sval = match.group(2)
            if s[0] in ['lw', 'lb', 'lh', 'lbu', 'lhu'] :
                return Instruction(op=s[0], dest = s[1], s1=sval, immed = immedval, regRead = 1,regWrite = 1, aluop=1,  readMem = 1)
            else:
                return Instruction(op=s[0],  s1 = s[1], s2=sval,immed = immedval, regRead = 1, aluop=1, writeMem = 1)
        elif ( s[0] in ['bne', 'beq'] ) :
            return Instruction(op=s[0], s1=s[1] , s2= s[2], immed = s[3], regRead = 1, aluop = 1, branch=1)
        elif( s[0] in ['beqz', 'bnez', 'blez', 'bgtz', 'bltz', 'bgez'] ) :
            return Instruction(op=s[0], s1=s[1], s2 = None, immed=s[2], regRead = 1, aluop = 1, branch=1)
        # Pseudoinstructions
        if( s[0] == "move" ) :
            return Instruction(op="addi", dest=s[1], s1=s[2], immed=0, regRead=1, regWrite=1, aluop=1)
        elif( s[0] in ["li", "lui"]) :
            return Instruction(op=s[0], dest=s[1], s1=s[2], immed=s[2], regRead=0, regWrite=1, aluop=1)
        else :
            return Instruction(op=s[0], dest=s[1], s1=s[2], immed=s[3], regRead=1, regWrite=1, aluop=1)

    ## Create and return J-Type instruction, setting the instruction fields and classifications accordingly
    #   s : instruction line
    def createJTypeInstruction(self, s):
        # J or JAL
        return Instruction(op=s[0], target=s[1], branch=1)

    ## Classify core instructions by setting their coreInstr flag
    def insertCoreStatus(self, instructions):
        for i in range(0, len(instructions)):
            instructions[i].controls['coreInstr'] = self.CCoreInstr[i]
        return instructions

##########################################################
#
#   DEPENDENCY CHECKING
#
##########################################################

    # Checking for WAR, RAW and Memory depencences between consecutive instructions
    def checkDependencies(self, instr):

        # List indicating how many NOPs will be inserted before each instruction
        nList = []
        
        # distance moved "up" the instruction list
        dist = 0

        # Initialize NOP list
        for i in range(0, len(instr)-1):
            nList.append(0)

        # Iterate over all instructions
        for i in range(0, len(instr)-1):
            dist = 0
            l = 1
            # Skip NOP instructions (no dependencies)
            if instr[i].op == 'nop':
                    continue
            # While we are not out of the dependency range and not out of the instruction list bounds
            while(dist < self.nNOPs and i-l >= 0):

                # Set previous and current instructions
                curr = instr[i]
                prev = instr[i-l]

                # If previous is a NOP, immedidately skip to the next previous
                if(prev.op == 'nop'):
                    dist += nList[i] + 1
                    l += 1
                    continue

                # Difference between immediate values (for checking for accesses to same memory space)
                imd = abs(int(curr.immed)-int(prev.immed)) if (curr.immed and prev.immed) else 0
                # Check for Write-after-Read hazard
                #matchWAR = ((curr.dest == prev.s1 or curr.dest == prev.s2) and curr.dest is not None)
                # Check for Read-after-Write hazard
                matchRAW = ((prev.dest == curr.s1 or prev.dest == curr.s2) and prev.dest is not None)
                # Check for Read-after-Read hazard
                #matchRAR = (prev.dest == curr.dest and prev.dest is not None)
                # Check for writes to the same memory location
                matchsw1 = ((curr.writeMem) and ((prev.writeMem and (curr.s2 == prev.s2) and (imd <= 4)))) 
                # Check for load dependencies
                matchsw2 = ((prev.readMem and (curr.s2 == prev.s1) and (imd <= 4)))
                # Classify instruction as a jump
                currIsJump = curr.op in ['j', 'jr', 'jal', 'jalr']
                # Classify instruction as a branch
                currIsBranch = curr.op in ['bne', 'beq', 'blez', 'bgtz', 'bltz', 'bgez', 'bnez', 'beqz']
                if (currIsJump or currIsBranch):
                    # Pad jumps and branches with nops
                    nList[i] = self.nNOPs
                    for n in range (0, nList[i]):
                        # Core instruction
                        self.nopInsertsCore.append(curr.controls['coreInstr'])
                # Load-store dependency resolving
                if (matchsw1 or matchsw2):
                    nList[i] = self.nNOPs-dist
                    for n in range (0, nList[i]):
                        self.nopInsertsCore.append(curr.controls['coreInstr'])
                #if (matchWAR or matchRAW or matchRAR):
                # Insert NOPs for Read-After-Write hazard resolving
                if(matchRAW):
                    nList[i] = self.nNOPs-dist
                    for n in range (0, nList[i]):
                        self.nopInsertsCore.append(curr.controls['coreInstr'])
                # Update distance to next potential dependency by taking into account already inserted NOPs
                dist += nList[i] + nList[i-l] + 1
                # Increment distance and fetch the next previous by moving up the instruction list
                l += 1
                
        print "\n<Dependency Checking>"
        print nList

        # Insert entries into NOP insertion list
        for i in range (0, len(nList)):
            for n in range (0, nList[i]):
                self.nopInserts.append(i)

        print "\n<NOP Inserts>"
        print self.nopInserts
        return self.insertNOPs(instr)

    ## Insert NOPs
    def insertNOPs(self, instructions):
        t = 0
        # 1st iteration
        for k in range(0, len(self.nopInserts)):
            # Insert NOPs
            instructions.insert(self.nopInserts[k], Instruction(op='nop', coreInstr=self.nopInsertsCore[k])) #Nop)
            # Recalculate target values for branches and jumps
            for i in instructions:
                targetval = 0
                vstr = ''
                if i.branch:
                    # Branch
                    if(i.op in ['bne', 'beq', 'blez', 'bgtz', 'bltz' 'bgez', 'bnez', 'beqz']) :
                        targetval = int(i.immed)
                        vstr = 'immed'
                    # Jump
                    elif(i.op in ['j', 'jal']):
                        targetval = int(i.target)
                        vstr = 'target'
                # Update target value by 0x4
                if(targetval >= (self.nopInserts[k])*4):
                    targetval += 4
                    i.values[vstr] = targetval
            # Inserted NOP - update all remaining NOP insertions by adding 1 to the insertion address
            for j in range(k+1, len(self.nopInserts)):
                self.nopInserts[j] += 1

        # Get addresses of instructions that are targets of branches or jumps
        targetvals = []
        self.nopInserts = []

        for i in instructions:
            if i.branch:
                if(i.op in ['bne', 'beq', 'blez', 'bgtz', 'bltz' 'bgez', 'bnez', 'beqz']) :
                    if(int(i.immed) not in targetvals):
                        targetvals.append(int(i.immed))
                elif(i.op in ['j', 'jal']):
                    if(int(i.target) not in targetvals):
                        targetvals.append(int(i.target))

        # Insert NOPs to pad the branches and jumps across PC changes if there is a dependency
        for k in range (0, len(instructions)-1):
            # Address p
            p = k*0x4 
            # If P is a target, pad with NOPs
            if(p in targetvals):
                for q in range(0, self.nNOPs):
                    self.nopInserts.append(k)

        print "TARGETVALS: "
        for t in targetvals:
            print hex(t)

        # 2nd Iteration
        for k in range(0, len(self.nopInserts)):
            # Insert NOPs
            instructions.insert(self.nopInserts[k], Instruction(op='nop', coreInstr=True))#Nop)
            # Recalculate target values for branches and jumps
            for i in instructions:
                targetval = 0
                vstr = ''
                if i.branch:
                    if(i.op in ['bne', 'beq', 'blez', 'bgtz', 'bltz' 'bgez', 'bnez', 'beqz']) :
                        targetval = int(i.immed)
                        vstr = 'immed'
                    elif(i.op in ['j', 'jal']):
                        targetval = int(i.target)
                        vstr = 'target'
                    else:
                        targetval = 0
                if(targetval >= (self.nopInserts[k])*4):
                    targetval += 4
                    i.values[vstr] = targetval

            for j in range(k+1, len(self.nopInserts)):
                self.nopInserts[j] += 1

        # 3rd Iteration
        # Recalculate target values for branches and jumps
        for i in instructions:
            targetval = 0
            vstr = ''
            if i.branch:
                if(i.op in ['bne', 'beq', 'blez', 'bgtz', 'bltz' 'bgez', 'bnez', 'beqz']) :
                    targetval = int(i.immed)
                    vstr = 'immed'
                elif(i.op in ['j', 'jal']):
                    targetval = int(i.target)
                    vstr = 'target'
                else:
                    targetval = 0
                i.values[vstr] = (targetval-((self.nNOPs)*0x4))

        print "\n<Processed Instructions>"
        addr = 0x0
        for i in instructions:
            print hex(addr), ": ", i
            addr += 0x4

        print "<End of Preprocessing>"

        return instructions

##########################################################
#
#   ERROR CLASS
#
##########################################################

## Simple error class for reporting errors
class ParseError(Exception):
    def __init__(self, value):
        self.value = value
    def __str__(self):
        return repr(self.value)

