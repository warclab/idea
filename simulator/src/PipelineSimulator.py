##################################################################
#
# iDEA Simulator
#   PipelineSimulator.py
#
# Main pipeline simulator file
# Fredrik Brosser 2013-05-14
# 
##################################################################


import collections 
import ast
import sys

from Instruction import *


## Main pipeline simulator class
# Models the behaviour of the iDEA pipeline and the execution of instructions
class PipelineSimulator(object): 

    # Mapping of instruction string to corresponding mathematic operation
    alu_operations = {  'add':'+',  'addi':'+',  'sub':'-',  'subi':'-',
                    'addu':'+', 'addiu':'+', 'subu':'-', 'subiu':'-',
                    'and':'&',  'andi':'&',   'or':'|',   'ori':'|',
                    'sll':'<<', 'sllv':'<<', 'srl':'>>', 'srlv':'>>',
                    'sra':'>>', 'srav':'>>',
                    'div':'/',   'mul':'*',  'xor':'^',  'xori':'^'  }
    
    ## Constructor
    #   instrCollection : Array containing all the instructions to be executed
    #   dataMem : Initial data memory state
    #   mainAddr : Starting address for main routine
    #   oldstdout : stdout channel to terminal
    #   verbose : Verbose output flag
    #   quiet   : Quiet output flag
    #   pipelineData : Number of IF-ID-EX-WB stages (as array)
    def __init__(self,instrCollection,dataMem,mainAddr,oldstdout,verbose,quiet,pipelineData):

        # Local variables in class
        sys.stdout = oldstdout
        self.oldstdout = oldstdout
        self.instrCount = 0
        self.nopCount = 0
        self.coreInstrCount = 0
        self.coreNopCount = 0
        self.cycles = 0
        self.hazardList = []
        self.__done = False
        self.branched = False
        self.stall = False
        self.changedRegs = []
        self.changedRegsVal = []
        self.accessedMem = []
        self.accessedDataMem = []
        self.branchTaken = False
        self.branchAddr = 0

        # Output options from main program
        self.verbose = verbose
        self.quiet = quiet

        # Flags and constants
        self.UseBranchDelaySlot = True
        self.dataMemoryWords = 0xfffc
        self.instructionMemoryWords = 0xfffc

        ## Pipeline stages
        self.nPipelineStages = pipelineData[0]
        self.nIFit = pipelineData[1]
        self.nIDit = pipelineData[2]
        self.nEXit = pipelineData[3]
        self.nWBit = pipelineData[4]

        # Forwarding wires (Not used)
        self.memStageFwd = 0
        self.wbStageFwd = 0
        self.memStageDest = None
        self.wbStageDest = None
        self.memStageWBE = 0
        self.wbStageWBE = 0

        # Registers in ID and EX stages
        self.IDReg1 = None
        self.IDReg2 = None
        self.EXReg1 = None
        self.EXReg2 = None
        
        # self.pipeline is a list<PipelineStage>
        # with the mapping of:
        #   0 = Fetch
        #   1 = Write Back
        #   2 = Read
        #   3 = Execute 
        #   4 = Data Access
        if(not self.quiet):
            print "> Initializing Pipeline with", self.nPipelineStages, "stages:"
        self.pipeline = [None for x in range(0,self.nPipelineStages)]

        # First pipeline stage is always IF
        self.pipeline[0] = FetchStage(Instruction(op='nop', coreInstr=False), self)
        if(not self.quiet): 
            print "\t> Stage " + str(0+1) + "\tIF" + str(0+1), ": Instruction Fetch"

        # Additional IF stages if indicated by nIFit
        for i in range(1, self.nIFit):
            self.pipeline[i] = DummyFetchStage(Instruction(op='nop', coreInstr=False), self)
            if(not self.quiet): 
                print "\t> Stage " + str(i+1) + "\tIF" + str(i+1), ": Instruction Fetch"

        # Fill ID stages with DecodeStage objects
        self.pipeline[self.nIFit] = ReadStage(Instruction(op='nop', coreInstr=False), self)
        if(not self.quiet):
            print "\t> Stage " + str(self.nIFit+1) + "\tID" + str(self.nIFit+1-self.nIFit), ": Instruction Decode"
        for i in range(self.nIFit+1, self.nIFit+self.nIDit):
            self.pipeline[i] = DummyReadStage(Instruction(op='nop', coreInstr=False), self)
            if(not self.quiet):
                print "\t> Stage " + str(i+1) + "\tID" + str(i+1-self.nIFit), ": Instruction Decode"

        # Fill EX stages with ExecuteStage objects
        self.pipeline[self.nIFit+self.nIDit] = ExecStage(Instruction(op='nop', coreInstr=False), self)
        if(not self.quiet):
            print "\t> Stage " + str(self.nIFit+self.nIDit+1) + "\tEX" + str(self.nIFit+self.nIDit+1-self.nIFit-self.nIDit), ": Execute/Memory" 
        for i in range(self.nIFit+self.nIDit+1, self.nIFit+self.nIDit+self.nEXit):
            self.pipeline[i] = DummyExecStage(Instruction(op='nop', coreInstr=False), self)   
            if(not self.quiet):
                print "\t> Stage " + str(i+1) + "\tEX" + str(i+1-self.nIFit-self.nIDit), ": Execute/Memory" 

        # Fill WB stages with WritebackStage objects
        self.pipeline[self.nIFit+self.nIDit+self.nEXit] = WriteStage(Instruction(op='nop', coreInstr=False), self)
        if(not self.quiet):
            print "\t> Stage " + str(self.nIFit+self.nIDit+self.nEXit+1) + "\tWB" + str(self.nIFit+self.nIDit+self.nEXit+1-self.nIFit-self.nIDit-self.nEXit), ": Writeback"   
        for i in range(self.nIFit+self.nIDit+self.nEXit+1, self.nIFit+self.nIDit+self.nEXit+self.nWBit):
            self.pipeline[i] = DummyWriteStage(Instruction(op='nop', coreInstr=False), self) 
            if(not self.quiet):
                print "\t> Stage " + str(i+1) + "\tWB" + str(i+1-self.nIFit-self.nIDit-self.nEXit), ": Writeback"          

        if(not self.quiet):
            print "> Initializing Registers"
        # ex: {'$r0' : 0, '$r1' : 0 ... '$r31' : 0 }
        self.registers = dict([("$r%s" % x, 0) for x in range(32)]) 

        # LO special register
        self.lo = 0
        # HI special register
        self.hi = 0

        # Stack Initalization
        if(not self.quiet):
            print "> Initializing Stack and Main pointers"
        self.registers["$r29"] = 0xfffc

        # programCounter to state where in the instruction collection
        # we are to find correct spot in instruction memory  
        self.programCounter = mainAddr

        # set up the data memory construct, a list index starting at 0 and continuing to 0xfffc
        if(not self.quiet):
            print "> Initializing Data Memory"
        self.dataMemory = dict([(x, 0) for x in range(self.dataMemoryWords)])
        # Input data memory
        self.dataMemIn = dataMem
        if(not self.quiet):
            print "> Initializing Instruction Memory"
        self.instructionMemory = dict([(x, 0) for x in range(self.instructionMemoryWords)])

        # The list of instruction objects passed into the simulator
        self.instrCollection = instrCollection
       
        # Populate main memory with the instructions starting at 0x0
        y=0
        for instr in self.instrCollection:
           self.instructionMemory[0x0 + y] = instr
           self.accessedMem.append(0x0 + y)
           y += 4

        # Populate data memory
        self.readDataMem()

    ## Simple function to copy data memory to the internal variable
    def readDataMem(self):
        if(len(self.dataMemIn.items()) != 0):
            for key, value in self.dataMemIn.items():
                self.dataMemory[key] = value
    
    # Step - step forward one clock cycle.
    # Shift the instructions to the next logical place
    # Technically we do the Fetch instruction here, which is why FetchStage.advance() does nothing
    def step(self):

        # Increment cycle count
        self.cycles +=1
        
        # Move instructions in EX to WB
        for i in range(self.nIFit+self.nIDit+self.nEXit+self.nWBit, self.nIFit+self.nIDit+self.nEXit+1, -1):
            self.pipeline[i-1] = DummyWriteStage(self.pipeline[i-2].instr, self)  
        self.pipeline[self.nIFit+self.nIDit+self.nEXit] = WriteStage(self.pipeline[self.nIFit+self.nIDit+self.nEXit-1].instr, self)  

        # Move instructions in ID to EX
        for i in range(self.nIFit+self.nIDit+self.nEXit, self.nIFit+self.nIDit+1, -1):
            self.pipeline[i-1] = DummyExecStage(self.pipeline[i-2].instr, self)  
        self.pipeline[self.nIFit+self.nIDit] = ExecStage(self.pipeline[self.nIFit+self.nIDit-1].instr, self) 
        
        # Move instructions in IF to ID
        for i in range(self.nIFit+self.nIDit, self.nIFit+1, -1):
            self.pipeline[i-1] = DummyReadStage(self.pipeline[i-2].instr, self)
        self.pipeline[self.nIFit] = ReadStage(self.pipeline[self.nIFit-1].instr, self)  

        # Move instruction pointed to by PC in instruction memory to IF (= perform Instruction Fetch)
        for i in range(self.nIFit, 1, -1):
            self.pipeline[i-1] = DummyFetchStage(self.pipeline[i-2].instr, self) 
        self.pipeline[0] = FetchStage(Instruction(op='nop', coreInstr=False),self)

        # Call advance on each instruction in the pipeline
        for pi in self.pipeline:
                pi.advance()

        # Remove finished instructions from Hazard list
        if (self.pipeline[1].instr.regWrite and len(self.hazardList)>0) :
            self.hazardList.pop(0)
        
        # Check for END directive
        self.checkDone()

        # If we stalled the pipeline, keep the program counter where it is
        if self.stall or self.branched: 
            self.programCounter -= 0x4
            self.branched = False

    ## Check for END directive and stop execution if found
    def checkDone(self):
        """ Check if we are done and set __done variable """
        self.__done = False
        if self.pipeline[self.nPipelineStages-1].instr.op == 'END':
            self.__done = True
    
    ## Main stepping (clock cycle) loop
    def run(self):
        """ Run the simulator, call step until we are done """
        while not self.__done:
            self.step()
            # Print basic cycle information
            if(not self.quiet):
                self.printCycles()
            # Print full debug information
            if(self.verbose):
                self.debug_lite()
        self.debug()
    
    ## If we are modelling data forwarding, this function fetches the appropriate forwarded data
    #   regName : register name to check for forwarding value (dest.reg. of instr. in EX stage)
    def getForwardVal(self, regName):
        # Forward the proper value based on the given register name
        # If the value is not ready, return "NOVAL" 

        # Forward from Mem stage
        if (self.pipeline[4].instr.op != 'nop' 
                and self.pipeline[4].instr.result is not None
                and self.pipeline[4].instr.dest == regName) :
                    return self.pipeline[4].instr.result
        # Forward from Writeback Stage
        elif (self.pipeline[1].instr.op != 'nop' 
            and self.pipeline[1].instr.result is not None
                and self.pipeline[1].instr.dest == regName ):
                    return self.pipeline[1].instr.result
        else :
            # No data dependency - do not forward value
            return "NOVAL" 

    ## If we are modelling data forwarding, this function fetches the appropriate forwarded data
    #   regName : register name to check for forwarding value (dest.reg. of instr. in EX stage)
    # NOTE : this function is used for branch instructions (when evaulating branch conditions)       
    def getForwardValBranch(self, regName):
        # Forward the proper value based on the given register name
        # If the value is not ready, return "NOVAL" 
        if (self.pipeline[3].instr.op != 'nop' 
                and self.pipeline[3].instr.result is not None
                and self.pipeline[3].instr.dest == regName) :
                    return self.pipeline[3].instr.result
        if (self.pipeline[4].instr.op != 'nop' 
                and self.pipeline[4].instr.result is not None
                and self.pipeline[4].instr.dest == regName) :
                    return self.pipeline[4].instr.result
        elif (self.pipeline[1].instr.op != 'nop' 
            and self.pipeline[1].instr.result is not None
                and self.pipeline[1].instr.dest == regName ):
                    return self.pipeline[1].instr.result
        else :
            # No data dependency - do not forward value
            return "NOVAL" 

    ## Print current cycle number to terminal
    def printCycles(self):
        self.oldstdout.write("\r{}".format("Cycles: [" + str(self.cycles) + "]"))
        self.oldstdout.flush()

    ## Print basic debug information (pipeline state)
    # Used for cycle-by-cycle debug in verbose mode
    def debug_lite(self):
        print "###################### PC = " + str(hex(self.programCounter)) + " ######################"
        print "Cycles: ", str(self.cycles)
        self.printPipeline()
        self.printRegFile(True)
        #self.printDataMemory()
        print "\n<Hazard List> : " , self.hazardList
        print "<Updated Registers> : ", self.changedRegs, " = ", self.changedRegsVal, "\n"

    ## Print full debug information (pipeline state)
    # Used as the final debug output when simulation is finished
    def debug(self):
        print "\n######################## Debug ###########################"    
        self.printRegFile(False)
        self.printPipeline()   
        self.printInstructionMemory()
        self.printDataMemory()

        print "\n<Final Program Counter> : ", hex(self.programCounter)
        print "<TotalCycles> : " , float(self.cycles)
        print "<CoreCycles> : " , float(self.coreInstrCount)
        print "<CoreNOPs> : " , float(self.coreNopCount)
        print "<Instructions Executed> : " , float(self.instrCount)
        print "<NOPs> : " , float(self.nopCount)
        print "<CPI> : " , float(self.cycles) / (float(self.instrCount)-float(self.nopCount)) , "\n"

    ## Print the accessed instructions from instruction memory
    def printInstructionMemory(self):
        print "<Accessed Instructions>"
        self.accessedMem = sorted(self.accessedMem)
        for k,v in sorted(self.instructionMemory.iteritems()):
            # Only print if the instruction has been accessed
            if k in self.accessedMem:
                print k, ":" , v

    ## Print full data memory
    def printDataMemory(self):
        print "\n<Accessed Data>"
        self.accessedDataMem = sorted(self.accessedDataMem)
        for k,v in sorted(self.dataMemory.iteritems()):
            # Do not print empty "0" data memory entries and non-accessed memory
            if k in self.accessedDataMem and k is not None and v != 0:
                print hex(int(str(k), 10)), ":" , v
                
    ## Print stage by stage information
    def printPipeline(self):
        print "\n<Pipeline>"
        for i in range(0, self.nPipelineStages):
            print repr(self.pipeline[i])

    ## Print contents of the register file
    # NOTE: The ordering of outputs is just because it looks better
    def printRegFile(self, compact):
        print "\n<Register File>"

        # Print r0-r9
        regstr = ""
        for k,v in sorted(self.registers.iteritems()):
            if len(k) == 3:
                if(not compact):
                    print k, ":" , v
                regstr +=  str(k) + ":  " + str(v) + "\t"
        if(compact):
            print regstr  

        # Print r10-r19
        regstr = ""
        for k,v in sorted(self.registers.iteritems()):
            if len(k) == 4 and k[2] == '1':
                if(not compact):
                    print k, ":" , v
                regstr +=  str(k) + ": " + str(v) + "\t"
        if(compact):
            print regstr  

        # Print r20-r29
        regstr = ""
        for k,v in sorted(self.registers.iteritems()):
            if len(k) == 4 and k[2] == '2':
                if(not compact):
                    print k, ":" , v
                regstr +=  str(k) + ": " + str(v) + "\t"
        if(compact):
            print regstr 

        # Print r30-r39
        regstr = ""
        for k,v in sorted(self.registers.iteritems()):
            if len(k) == 4 and k[2] == '3': 
                if(not compact):
                    print k, ":" , v
                regstr +=  str(k) + ": " + str(v) + "\t"

        # HI and LO special registers
        regstr +=  "hi: " + str(self.hi) + "\t"
        regstr +=  "lo: " + str(self.lo) 
        if(compact):
            print regstr
    
    ## Print all instructions            
    def printStageCollection(self):
        print "\n<Instruction Collection>"
        for index, item in sorted(self.instructionMemory.iteritems()):
            if item != 0:
                print index, ": ", str(item)

## Parent class for all pipeline stage types
class PipelineStage(object):

    ## Constructor
    #   instruction : the instruction loaded in the stage
    #   simulator : the pipeline simulator object in which the stage exists
    def __init__(self, instruction, simulator):
        self.instr = instruction
        self.simulator = simulator
        
    # What to do in the pipeline stage, what happends on a new clock cycle?
    # NOTE : Depends on the stage type
    def advance(self):
        pass
    
    # Print the stage name and currently executed instruction
    def __repr__(self):
        return str(self) + ':\t' + str(self.instr)
    
## Instruction Fetch
# Pipeline stage type, child class to PipelineStage
class FetchStage(PipelineStage):
    def advance(self): 
        #Fetch the next instruction according to simulator program counter 
        # ...if we are not outside instruction memory
        if self.simulator.programCounter < (len(self.simulator.instrCollection) * 4 + 0x0):
            self.instr = self.simulator.instructionMemory[self.simulator.programCounter]
            # Non-NOP instruction
            if(self.instr and self.instr.op != "nop" and self.instr.op != None):
                self.simulator.instrCount += 1
            # NOP
            if(self.instr.op is 'nop'):
                self.simulator.instrCount += 1
                self.simulator.nopCount += 1
            # Instruction is a core instruction
            if(self.instr.coreInstr):
                self.simulator.coreInstrCount += 1
                # Instruction is a core instruction and a NOP
                if(self.instr.op is 'nop'):
                    self.simulator.coreNopCount += 1
        else:
            # Something wrong (outside memory range) - ignore instruction
            self.instr = Instruction(op='nop', coreInstr=False)
        # Advance PC
        self.simulator.programCounter += 4
         
    def __str__(self):
        return 'Fetch\t\t\t\t'
    
## A dummy IF stage, does not really perform any action, just passes on the instruction
class DummyFetchStage(PipelineStage):
    def advance(self):
        # Nothing to see here, move along...
        return
 
    def __str__(self):
        return 'Fetch\t\t\t\t'  

## A dummy ID stage, does not really perform any action, just passes on the instruction
class DummyReadStage(PipelineStage):
    def advance(self):
        # Nothing to see here, move along...
        return
 
    def __str__(self):
        return 'Read from Register\t\t' 

## A dummy EX stage, does not really perform any action, just passes on the instruction
class DummyExecStage(PipelineStage):
    def advance(self):
        # Nothing to see here, move along...
        return
 
    def __str__(self):
        return 'Execution/Memory\t' 

## A dummy WB stage, does not really perform any action, just passes on the instruction
class DummyWriteStage(PipelineStage):
    def advance(self):
        # Nothing to see here, move along...
        return
 
    def __str__(self):
        return 'Write to Register\t'      

## Instruction Decode
# Pipeline stage type, child class to PipelineStage
class ReadStage(PipelineStage):
    def advance(self):
        #Read the necessary registers from the registers file used in this instruction 

        # Read only if instruction has operands (read from register file)
        if(self.instr.regRead):
            # Read operand1
            self.instr.source1RegValue = int(self.simulator.registers[self.instr.s1])
            if (self.instr.immed and
                # These instructions require special treatment
                (self.instr.op not in ['lw', 'sw', 'bne', 'beq', 'beqz', 'bnez', 'blez', 
                    'bgtz', 'bltz', 'bgez'])):
                # Read operand2
                self.instr.source2RegValue = int(self.instr.immed)
            if(self.instr.op in ['srlv', 'sllv', 'srav']):
                # Read operand2
                self.instr.source2RegValue = int(self.instr.s2)

            elif self.instr.s2:
                # Read operand2
                self.instr.source2RegValue = int(self.simulator.registers[self.instr.s2])

            if self.instr.s3:
                # Read operand3 (for certain instructions, such as macc)
                self.instr.source3RegValue = int(self.simulator.registers[self.instr.s3])

        # Jump and Link
        if self.instr.op == 'jal':
            # Save return address in $ra = $r31
            self.simulator.registers["$r31"] = self.simulator.programCounter
            self.simulator.changedRegs.append("$r31")
            self.simulator.changedRegsVal.append(hex(self.simulator.programCounter))
            # Get target value
            targetval = int(self.instr.target)
            self.simulator.programCounter = targetval
            if(self.simulator.verbose):
                print "Jump to address", hex(targetval)
            # Set the o instructions currently in the pipeline to a Nop
            # Branch Delay Slot or Stall
            if(self.simulator.nIFit >= 2):
                self.simulator.pipeline[0] = FetchStage(Instruction(op='nop', coreInstr=True), self)
            if(self.simulator.nIFit == 3):
                self.simulator.pipeline[1] = FetchStage(Instruction(op='nop', coreInstr=True), self)

        # Jump
        if self.instr.op == 'j':
            targetval = int(self.instr.target)
            self.simulator.programCounter = targetval
            if(self.simulator.verbose):
                print "Jump to address", hex(targetval)
            # Set the o  instructions currently in the pipeline to a Nop
            # Branch Delay Slot or Stall
            if(self.simulator.nIFit >= 2):
                self.simulator.pipeline[0] = FetchStage(Instruction(op='nop', coreInstr=True), self)
            if(self.simulator.nIFit == 3):
                self.simulator.pipeline[1] = FetchStage(Instruction(op='nop', coreInstr=True), self)
       
        # Jump to Register
        if self.instr.op == 'jr':
            if(self.simulator.verbose):
                print "Jump to address", hex(self.instr.source1RegValue)
            self.simulator.programCounter = self.instr.source1RegValue
            # Branch Delay Slot or Stall
            if(self.simulator.nIFit >= 2):
                self.simulator.pipeline[0] = FetchStage(Instruction(op='nop', coreInstr=True), self)
            if(self.simulator.nIFit == 3):
                self.simulator.pipeline[1] = FetchStage(Instruction(op='nop', coreInstr=True), self)

        # Jump and Link Register
        elif self.instr.op == 'jalr':
            # Save return address in $ra = $r31
            self.simulator.registers["$r31"] = self.simulator.programCounter
            self.simulator.changedRegs.append("$r31")
            if(self.simulator.verbose):
                print "Jump to address", hex(self.instr.source1RegValue)
            self.simulator.changedRegsVal.append(hex(self.simulator.programCounter))
            self.simulator.programCounter = self.instr.source1RegValue
            # Branch Delay slot or Stall
            if(self.simulator.nIFit >= 2):
                self.simulator.pipeline[0] = FetchStage(Instruction(op='nop', coreInstr=True), self)
            if(self.simulator.nIFit == 3):
                self.simulator.pipeline[1] = FetchStage(Instruction(op='nop', coreInstr=True), self)

    def __str__(self):
        return 'Read from Register\t'
 
## Execution Stage
# Pipeline stage type, child class to PipelineStage    
class ExecStage(PipelineStage):
    def advance(self):
        
        # Skip NOPs and no-ALU-operation instruction
        if self.instr.op != 'nop' and self.instr.aluop:
            # No forwarding in iDEA   

            ## Execute the instruction according to its mnemonic

            # END directive - skip
            if self.instr.op == 'END':
                return
            # Calculate the offset of load instructions
            if  self.instr.op in ['lw', 'lh', 'lb', 'lhu', 'lbu']:
                self.instr.source1RegValue = self.instr.source1RegValue + int(self.instr.immed)
            # Calculate the offset of store instructions
            elif  self.instr.op in ['sw', 'sh', 'sb', 'shu', 'sbu']:
                self.instr.source2RegValue = self.instr.source2RegValue + int(self.instr.immed)
            # Load immediate
            elif (self.instr.op == 'li'):
                self.instr.result = int(self.instr.immed, 10)
            # Load upper immediate
            elif (self.instr.op == 'lui'):
                self.instr.result = int(self.instr.immed, 10)  
            # Absolute value
            elif self.instr.op == 'abs':
                self.simulator.result = abs(self.instr.source1RegValue)
            # Add immediate
            elif (self.instr.op == "addi"):
                self.instr.result = int(self.instr.source1RegValue) + int(self.instr.immed)
            # Add unsigned
            elif (self.instr.op == "addu"):
                self.instr.result = int(self.instr.source1RegValue) + int(self.instr.source2RegValue)
            # Move result to Lo register
            elif (self.instr.op == "mflo"):
                self.instr.result = self.simulator.lo
            # Move result to Hi register
            elif (self.instr.op == "mfhi"):
                self.instr.result = self.simulator.hi
            # Perform multiplication and place results in Lo and Hi
            elif (self.instr.op in ["mult", "multu"]):
                    a = int(self.instr.source1RegValue)
                    b = int(self.instr.source2RegValue)
                    z = a * b
                    self.simulator.lo = z & 0x0000FFFF
                    self.simulator.hi = z & 0xFFFF0000
            # Perform division and place results in Lo and Hi
            elif (self.instr.op in ["div", "divu"]):
                    a = int(self.instr.source1RegValue)
                    b = int(self.instr.source2RegValue)
                    self.simulator.lo = (a / b) & 0x0000FFFF
                    self.simulator.hi = (a % b) & 0xFFFF0000
            # Branch if Not Equal
            elif self.instr.op == 'bne':
                if int(self.instr.source1RegValue) != int(self.instr.source2RegValue):
                    self.doBranch()
            # Branch if Equal
            elif self.instr.op == 'beq':
                if int(self.instr.source1RegValue) == int(self.instr.source2RegValue):
                    self.doBranch()
            # Branch if Greater Than Zero
            elif self.instr.op == 'bgtz':
                if int(self.instr.source1RegValue) > 0:
                    self.doBranch()
            # Branch if Greater than or Equal to Zero
            elif self.instr.op == 'bgez':
                if int(self.instr.source1RegValue) >= 0:
                    self.doBranch()
            # Branch if Not Equal to Zero
            elif self.instr.op == 'bnez':
                if int(self.instr.source1RegValue) != 0:
                    self.doBranch()
            # Branch if EQual to Zero
            elif self.instr.op == 'beqz':
                if int(self.instr.source1RegValue) == 0:
                    self.doBranch()
            # Branch if Less Than Zero
            elif self.instr.op == 'bltz':
                if int(self.instr.source1RegValue) < 0:
                    self.doBranch()
            # Branch if Less than or Equal to Zero
            elif self.instr.op == 'blez':
                if int(self.instr.source1RegValue) <= 0:
                    self.doBranch()
            # Shift left logical
            elif self.instr.op in ['sll']:      
                self.instr.result = int(self.instr.source1RegValue) << int(self.instr.shamt)
            # Shift right
            elif self.instr.op in ['srl', 'sra']:
                self.instr.result = int(self.instr.source1RegValue) >> int(self.instr.shamt)
            # Multiply-Accumulate (note use of three operands)
            elif self.instr.op in ['mac']:
                self.instr.result = int(self.instr.source3RegValue) + (int(self.instr.source1RegValue)*int(self.instr.source2RegValue))
            else :        
                # Set Less Than / Set Less Than Unsigned 
                if (self.instr.op in ['slt', 'sltu']):
                    a = int(self.instr.source1RegValue)
                    b = int(self.instr.source2RegValue)
                    self.instr.result = 1 if (a<b) else 0

                # Set Less Than Immediate / Set Less Than Immediate Unsigned
                elif (self.instr.op in ['slti', 'sltiu']):
                    a = int(self.instr.source1RegValue)
                    b = int(self.instr.immed)
                    self.instr.result = 1 if (a<b) else 0

                # Logical NOR
                elif (self.instr.op == 'nor'):
                    self.instr.result = ~(self.instr.source1RegValue | self.instr.source2RegValue)

                # Normal instruction, according to instruction mapping in (alu_operations)
                else:
                    self.instr.result = eval("%d %s %d" % (int((self.instr.source1RegValue)), 
                            self.simulator.alu_operations[self.instr.op], 
                            int((self.instr.source2RegValue))))                        

        # Load Immediate
        if(self.instr.op == "li"):
            self.simulator.dataMemory[self.instr.source1RegValue] = self.instr.immed
            self.simulator.accessedDataMem.append(self.instr.source1RegValue)
            checked = []
            # Append the accessed memory location to the accessed list
            for e in self.simulator.accessedDataMem:
                if e not in checked:
                    checked.append(e)
            self.simulator.accessedDataMem = checked
        
        # All store instructions go here
        if self.instr.writeMem:
            writeValue = 0

            # Address calculation and byte offset
            addr = self.instr.source2RegValue
            byteoffset = addr%4
            addr -= byteoffset        

            # Write byte (8 bit)
            if(self.instr.op in ["sb", "sbu"]):
                writeValue = (self.instr.source1RegValue & 0x000000FF)

                # Make room for new byte to be written
                mask = (0x00FFFFFF>>byteoffset)
                self.simulator.dataMemory[addr] = self.simulator.dataMemory[addr] & mask
                mask = writeValue<<(3-byteoffset)
                self.simulator.dataMemory[addr] = self.simulator.dataMemory[addr] & mask

            # Write halfword (16 bit)
            elif(self.instr.op in ["sh", "shu"]):
                writeValue = (self.instr.source1RegValue & 0x0000FFFF)
                addr = self.instr.source2RegValue

                # Make room for new halfword to be written
                mask = (0x0000FFFF>>byteoffset)
                self.simulator.dataMemory[addr] = self.simulator.dataMemory[addr] & mask
                mask = writeValue<<(3-byteoffset)
                self.simulator.dataMemory[addr] = self.simulator.dataMemory[addr] & mask

            # Write whole word (32 bit)
            else:
                writeValue = self.instr.source1RegValue    

            # Debug output if in verbose mode
            if(self.simulator.verbose):
                print "Storing ", writeValue, "to memory address", addr
            self.simulator.dataMemory[addr] = writeValue

            # Add the memory location to accessed data memory location list
            self.simulator.accessedDataMem.append(addr)
            checked = []
            for e in self.simulator.accessedDataMem:
                if e not in checked:
                    checked.append(e)
            self.simulator.accessedDataMem = checked

        # All load instructions go here
        elif self.instr.readMem:
            addr = self.instr.source1RegValue
            # Address error due to faulty instruction format
            if(addr is None):
                print "No s1: ", self.instr
            # Byte offset
            byteoffset = addr%4
            addr -= byteoffset   

            # Read whole word (32 bit)
            if self.instr.op == 'lw':
                if(addr in self.simulator.dataMemory):
                    self.instr.result = self.simulator.dataMemory[addr] #& 0xFFFFFFFF
                # Trying to access a memory location outside of the data memory range
                else:
                    print "MEMORY ACCESS ERROR", self.instr
                    print "ON ADDRESS ", hex(addr)
                    self.instr.result = self.simulator.dataMemory[addr] #& 0xFFFFFFFF

            # Read Halfword (16 bit)
            elif self.instr.op in ['lh', 'lhu']:
                # Read corresponding halfword in word
                byteoffset = addr%4
                addr -= byteoffset
                if(addr in self.simulator.dataMemory):
                    # Mask out halfword
                    self.instr.result = self.simulator.dataMemory[addr] & (0xFFFF0000>>(byteoffset*2))
                # Trying to access a memory location outside of the data memory range
                else:
                    print "MEMORY ACCESS ERROR", self.instr
                    self.instr.result = self.simulator.dataMemory[addr] & (0xFFFF0000>>(byteoffset*2))

            # Read single byte (8 bit)
            elif self.instr.op in ['lb', 'lbu']:
                # Read corresponding byte in word
                byteoffset = addr%4
                addr -= byteoffset
                if(addr in self.simulator.dataMemory):
                    # Mask out single byte
                    self.instr.result = self.simulator.dataMemory[addr] & (0xFF000000>>(byteoffset*2))
                # Trying to access a memory location outside of the data memory range
                else:
                    print "MEMORY ACCESS ERROR", self.instr
                    self.instr.result = self.simulator.dataMemory[addr] & (0xFF000000>>(byteoffset*2))

    ## Perform branching (update PC)
    def doBranch(self):
        # Read target value
        targetval = int(self.instr.immed)
        # Debug output if in verbose mode
        if(self.simulator.verbose):
            print "Branching to target ", hex(targetval)
        # Update PC
        self.simulator.programCounter = targetval + 4
        # Set the other instructions currently in the pipeline to NOPS (depending on the number of IF stages)
        self.simulator.pipeline[0] = FetchStage(Instruction(op='nop', coreInstr=True), self)
        if(self.simulator.nIFit >= 2):
            self.simulator.pipeline[1] = FetchStage(Instruction(op='nop', coreInstr=True), self)
        if(self.simulator.nIFit == 3):
            self.simulator.pipeline[2] = FetchStage(Instruction(op='nop', coreInstr=True), self)

        # Indicate branch by setting branched flag
        self.simulator.branched = True

    def __str__(self):
        return 'Execution/Memory\t'
  
## Writeback Stage
# Pipeline stage type, child class to PipelineStage  
class WriteStage(PipelineStage):
    def advance(self):
        # Write back result to the register file
        
        # Data forwarding information from WB stage
        self.simulator.wbStageWBE = self.instr.regWrite
        self.simulator.wbStageFwd = self.instr.result
        self.simulator.wbStageDest = self.instr.dest

        self.simulator.changedRegs = []
        self.simulator.changedRegsVal = []
        if self.instr.regWrite:
            # Ignore writes to r0 ($zero)
            if self.instr.dest == '$r0':    
                pass
            # Mult and Div use special registers Hi and Lo - Ignore
            if (self.instr.op in ['mult', 'multu', 'div', 'divu']):
                pass
            # Normal instruction
            elif self.instr.dest:
                # Write back result to register
                self.simulator.registers[self.instr.dest] = self.instr.result #& 0xFFFFFFFF
                # Append the written back register to list of changed registers
                self.simulator.changedRegs.append(self.instr.dest)
                self.simulator.changedRegsVal.append(self.instr.result)
                
    def __str__(self):
        return 'Write to Register\t'

# END
