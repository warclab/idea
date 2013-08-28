#!/usr/bin/python

##################################################################
#
# iDEA Simulator
#   run-simulator.py
#
# Top-level program
# 	Use to load input files and options and run the simulation
#
# Fredrik Brosser 2013-05-14
#
#
# USAGE :
# 
# 	run-simulator.py [-hvcqmpfdews] filename
#
# OPTIONS:
#
# `--version` Show program's version number and exit.
# `-h, --help` Show help message and exit.
# `-v, --verbose` Print cycle by cycle debug information to simulaton log file.
# `-c, --core` Show only core cycle information.
# `-q, --quiet` Show only summary of statistics.
# `-m, --mute` Supress all output.
# `-p <N>` Set number of pipeline stages [N >= 4, default 5]
# `-f <N>` Set number of Instruction Fetch (IF) cycles [default 1]
# `-d <N>` Set number of Instruction Decode (ID) cycles [default 1]
# `-e <N>` Set number of Execute/Memory (EX/MEM) cycles [default 2]
# `-w <N>` Set number of Writeback (WB) stages [default 1]
# `-s` Set execution start address [default @<main>]
#
##################################################################


# Imports
import elf32parser
import PipelineSimulator
import Instruction
import InstructionParser
import Sourceline
import Checker
import time
import os
import sys

from bcolors import bcolors
from optparse import OptionParser


def main() :

	# Hard-coded table holding clock frequency information for HW
	frequencyTable = {
                       5: 193.723,
                       6: 257.931,
                       7: 266.241,
                       8: 311.818,
                       9: 405.844
                    }

    # Create option parser
	parser = OptionParser(usage="usage: run-simulator.py [-hvcqmpfdews] filename", version="1.0")

	# Add options (self-documenting)
	parser.add_option("-v", "--verbose", 
					action="store_true",
					dest="verbose",
					default=False,
					help="log cycle by cycle debug information")
	parser.add_option("-c", "--core", 
					action="store_true",
					dest="core",
					default=False,
					help="show only core cycles")
	parser.add_option("-q", "--quiet", 
					action="store_true",
					dest="quiet",
					default=False,
					help="less terminal output")
	parser.add_option("-m", "--mute", 
					action="store_true",
					dest="mute",
					default=False,
					help="no summary output")
	parser.add_option("-p",# "--pipeline",
					type="int",
					dest="pipeline",
					default=5,
					help="set number of pipeline stages [default 5]")
	parser.add_option("-f",# "--IFStages",
					type="int",
					dest="ifcycles",
					default=-1,
					help="set number of Fetch (IF) Stage cycles")
	parser.add_option("-d",# "--IDStages",
					type="int",
					dest="idcycles",
					default=-1,
					help="set number of Decode (ID) Stage cycles")
	parser.add_option("-e",# "--EXStages",
					type="int",
					dest="excycles",
					default=-1,
					help="set number of Execution (EX) Stage cycles")
	parser.add_option("-w",# "--WBStages",
					type="int",
					dest="wbcycles",
					default=-1,
					help="set number of Writeback (WB) Stage cycles")
	parser.add_option("-s",# "--WBStages",
					type="int",
					dest="startAddr",
					default=0x0,
					help="set execution start address")

	(options, args) = parser.parse_args()

	# For automated coloured testing output
	B = bcolors()

	# Integer conversion
	options.pipeline = int(options.pipeline)
	options.ifcycles = int(options.ifcycles)
	options.idcycles = int(options.idcycles)
	options.excycles = int(options.excycles)
	options.wbcycles = int(options.wbcycles)

	pipelineConfigError = False

	# Pipeline checking
	if(options.pipeline < 4):
		pipelineConfigError = True

	# Use 1 ID and WB Cycle by default
	if(options.idcycles == -1):
		options.idcycles = 1
	if(options.wbcycles == -1):
		options.wbcycles = 1
	# Use maximum number of EX/MEM Cycles by default (ugly code...)
	if(options.excycles == -1 and options.pipeline >= 5):
		if(options.pipeline == 5):
			options.excycles = 2
		elif(options.pipeline == 6):
			options.excycles = 3
		else:
			options.excycles = 4
	# The rest of the instructions will be WB
	if(options.ifcycles == -1):
		remCycles = options.pipeline-options.idcycles-options.excycles-options.wbcycles
		if(remCycles < 1):
			pipelineConfigError = True
		options.ifcycles = remCycles

	# Double check for correct pipeline configuration
	pipelineSum = options.ifcycles + options.idcycles + options.excycles + options.wbcycles
	if(pipelineSum != options.pipeline):
		pipelineConfigError = True

	# Give error if something is wrong
	if(pipelineConfigError):
		B.printError("Error: Incorrect pipeline configuration")
		sys.exit()		

	inputFile = None

	# Open the input file
	try:
		inputFile = open(args[0], "r");
	except IOError:
		B.printError("Error: Could not open input file\t" + args[0])
		sys.exit()

	# Default values
	defaultSimASMFile = "simasm.sim"
	defaultDataMemFile = "datamem.sim"
	defaultPreProcLogFile = "preprocLog.sim"
	defaultSimRunFile = "simrun.sim"

	oldstdout = sys.stdout


	# Initialize parsers
	iparser = InstructionParser.InstructionParser()
	eparser = elf32parser.elf32parser()
	
	# If custom simulation assembly file output is set
	SimAsmFileName = args[2] if len(args) >= 3 else defaultSimASMFile
	SimAsmFile = open(SimAsmFileName, 'w')
	sys.stdout = SimAsmFile

	# If custom data memory file output is set
	DataMemFileName = args[4] if len(args) >= 5 else defaultDataMemFile

	if(not options.quiet):
		oldstdout.write("> Starting Parser...\n")

	# Convert elf32-bigmips to simulator friendly format
	eparser.convertToSimASM(args[0], SimAsmFileName, DataMemFileName)

	# Extract statistics
	lines = eparser.getLines()
	datamem = eparser.getDataMem() 
	mainAddr = eparser.getMainAddr()
	coreInstr = eparser.getCCoreInstr()

	# IF custom preprocessing log file name is set
	PPLogFileName = args[3] if len(args) >= 4 else defaultPreProcLogFile
	PPLogFile = open(PPLogFileName, 'w')
	sys.stdout = PPLogFile

	if(not options.quiet):
		oldstdout.write("> Starting Assembler...\n")

	# Parse in lines, do preprocessing and check for dependencies
	lines = iparser.parseLines(lines, (options.pipeline-options.ifcycles), options.ifcycles, coreInstr)

	pipelineInfo = [options.pipeline, options.ifcycles, options.idcycles, options.excycles, options.wbcycles]

	# Initialize simulator
	pipelinesim = PipelineSimulator.PipelineSimulator(lines, datamem, options.startAddr, oldstdout, options.verbose, options.quiet, pipelineInfo)
	
	if(not options.quiet):
		print "> Starting Simulation..."

	startTime = time.clock()

	# Set logfile
	simulationFileName = args[1] if len(args) >= 2 else defaultSimRunFile
	simulationFile = open(simulationFileName, 'w')
	sys.stdout = simulationFile

	# Run simulation
	pipelinesim.run()

	elapsedTime = (time.clock() - startTime)

	if(not options.quiet):
		oldstdout.write("\n> Simulation Completed in ")
		oldstdout.write(str(elapsedTime))
		oldstdout.write(" s")

	# Close output files
	simulationFile.close()
	PPLogFile.close()

	sys.stdout = oldstdout
	checker = Checker.Checker(simulationFileName, options.quiet)
	success = False

	# Give output according to the settings

	# Normal terminal-based single run output
	if(not options.quiet):
		checker.runCheck()

	# Only summary and statistics output (for use in automated scripts)
	elif(not options.mute):
		success = checker.runCheck()
		if(success):
			if(options.core):
				B.printCoreOnly(checker.getCoreCycles())
			else:
				# Compile statistics
				pNOPs = str(round(float(str(float(checker.getCoreNops())/(float(checker.getCoreCycles()))))*100, 1))
				c = checker.getCycles()
				n = checker.getNOPs()
				cpi = checker.getCPI()
				cc = checker.getCoreCycles()
				cn = checker.getCoreNops()
				ex = str(round(float(int(c) * float(1/frequencyTable.get(options.pipeline))), 8)) + "us"
				cex = str(round(float(int(cc) * float(1/frequencyTable.get(options.pipeline))), 8)) + "us"
				# Print successful test
				B.printPass(args[0], [c, n, cpi, cc, cn, pNOPs, ex, cex])
		else:
			# Indicate failure
			B.printFail(args[0], "")

if __name__ == "__main__":
    main()
