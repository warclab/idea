##################################################################
#
# iDEA Simulator
#   elf32parser.py
#
# elf32-bigmips to MIPS-Simulator format converter
# Fredrik Brosser 2013-05-14
#
##################################################################


# Imports
import sys
import re
import collections

from elf32instr import elf32instr
from pprint import pprint


class elf32parser:

	## Constructor
	def __init__(self):	
		self.doSimConv = True
		self.parseDataMem = False
		self.foundMain = False
		self.inputFile = None
		self.instructions = []

		# Modelling data memory as a python dict
		self.dataMemory = dict([(x*4, 0) for x in range(0xffc/4)])
		self.dataMemory.clear()

		self.lines = []
		
		# <main> start address
		self.mainAddr = 0
		
		# Core instruction tracking
		self.CCoreInstr = []
		self.coreInstr = False
		self.ccoreStart = False

	## Parse instructions from file
	def parseInstructions(self):

		# Read line by line in file, stripping the newline character
		lines = [line.strip() for line in self.inputFile]

		# List of core instructions
		self.CCoreInstr = []
		self.coreInstr = False

		# Iterate line by line
		for line in lines:

			# Hexadecimal operand/imm?
			ishex = False
			if("0x" in line):
				ishex = True

			# Find assembly instructions (ignoring whitespace lines, C-code and assembler directives)
			# Normal instruction
			if('.rodata:' in line or 'Disassembly of section .data:' in line):
				self.parseDataMem = True
			# Mark "computation core" instructions from now on (after START_CCORE flag)
			if('START_CCORE' in line and self.coreInstr is False):
				print "STARTING CORE CYCLE COUNT"
				self.coreInstr = True
			# Quit marking instructions as core instructions (after END_CCORE flag)
			if('END_CCORE' in line and self.coreInstr is True):
				print "ENDING CORE CYCLE COUNT"
				self.coreInstr = False

			# Parse Instruction Memory
			if(self.parseDataMem == False):
				# Look for <main> start address
				if(self.foundMain == False):
					match = re.match('([0-9a-fA-F]+)' + '\s+' + '<main>:', line)
					# Found the <main> start address
					if match:
						self.mainAddr = int(match.group(1),16)
						self.foundMain = True
				match = re.match('([0-9a-fA-F]+)' + ':' + '\s+' + '([0-9a-fA-F]+)' + '\s+' + '(\w+)' + '\s+' + '((\w+)(,\s*-?\w+)*)(\([a-zA-Z0-9_]+\))*', line)
				if match:
					operands = [x.strip() for x in match.group(4).split(',')]
					mnemonic = match.group(3)
					# If hex operand, convert to decimal
					if(ishex or mnemonic in ['j', 'jal', 'bne', 'beq', 'bltz', 'bgtz', 'bnez', 'beqz', 'blez', 'bgez']) :
						operands[-1] = str(int(str(operands[-1]), 16))
					self.instructions.append(elf32instr('', match.group(1), match.group(2), match.group(3), len(operands), operands, match.group(7)))
					self.CCoreInstr.append(self.coreInstr)
					continue
				# NOPs and instructions without operands
				match = re.match('([0-9a-fA-F]+)' + ':' + '\s+' + '([0-9a-fA-F]+)' + '\s+' + '(\w+)' + '\s?', line)
				if match:
					self.instructions.append(elf32instr('', match.group(1), match.group(2), match.group(3), 0, [], None))
					self.CCoreInstr.append(self.coreInstr)
			
			# Parse Data Memory
			elif(self.parseDataMem == True):
				match = re.match('([0-9a-fA-F]+)' + ':' + '\s+' + '([0-9a-fA-F]+)' + '\s+?' + '(\w+)?' + '\s+?' + '((\w+)(,\s*-?\w+)*)(\([a-zA-Z0-9_]+\))*', line)
				if match:
					self.dataMemory[int(str(match.group(1)),16)] = int(str(match.group(2)),16)
		return

	## Convert from elf32-bigmips to simulator assembly format
	def convertToSimASM(self, inputFileName, SimAsmFilename, DataMemFilename):

		# Open the input file
		try:
		    self.inputFile = open(inputFileName, "r");
		except IOError:
		    print "There was an error opening the input file."
		    sys.exit()

		self.parseInstructions()
		self.inputFile.close()

		# Fill lines array with converted instructions on simulator format
		for instruction in self.instructions:
			self.lines.append(instruction.getSimData())

		# Open simulator assembly code file for writing
		SimAsmFile = open(SimAsmFilename, 'w')
		sys.stdout = SimAsmFile
		
		# Print converted assembly code to simulation code file
		for line in self.lines:
			print line

		# Open data memory file
		DataMemFile = open(DataMemFilename, 'w')
		sys.stdout = DataMemFile
		
		# Print all read data memory to data memory file
		pprint(self.dataMemory)
		return 

	## Getter function for data memory
	def getDataMem(self):
		return self.dataMemory

	## Getter function for converted assembly code lines
	def getLines(self):
		return self.lines

	## Getter function for <main> start adress
	def getMainAddr(self):
		return self.mainAddr

	## Getter function for core instruction list
	def getCCoreInstr(self):
		return self.CCoreInstr
