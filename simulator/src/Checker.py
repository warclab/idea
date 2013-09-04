#!/usr/bin/python

##################################################################
#
# iDEA Simulator
#   Checker.py
#
# Post-simulation status and correctness checking
# Hui Yan Cheah
#
##################################################################
 

# Imports
import re
import sys
import math


class Checker:

    ## Constructor
    #   simRunFileName : File name of the simulation run log file
    #   quiet : Set quiet flag to supress output
    def __init__(self, simRunFileName, quiet):
        # Open the file
        try:
            f = open(simRunFileName, "r");
        except IOError:
            print "Opening of simulation log file failed"
            sys.exit()

        self.quiet = quiet
        self.lines = f.readlines()

        self.cycles = 0
        self.nops = 0
        self.corecycles = 0
        self.cpi = 0
        self.corenops = 0

        self.getStats()

    ## Check for r2 = 0 after simulation is finished (indicating successful run)
    def runCheck(self):
        lineN = len(self.lines)-1
        self.getStats()

        # reverse simulation file line list to start looking from the end of the file (faster)
        for line in reversed(self.lines):
            lineN -= 1
            # Find debug information section
            # Caveat: Debug sequence must not change.
            if re.match( ".*" + "Debug" + ".*" , line): 
                # Store the 6th line after Debug.  
                string = self.lines[lineN+6]        
                strp = string.strip()
                s = strp.split(' ')
                # Check if r2 = 0 "$r2 : 0"
                if re.match('0', s[2]): 
                    # Successful run
                    if(not self.quiet):
                        print "\nSuccess: ", "$r2 = " + s[2]
                        return
                    else:
                        return True
                else:
                    # Failed run
                    if(not self.quiet):
                        print "\nFail: ", "$r2 = " + s[2]
                        return
                    else:
                        return False

    ## Collect statistics from simulation run file
    def getStats(self):
        lineN = len(self.lines)-1
        # Start looking from end of simulation run file
        for line in reversed(self.lines):
            lineN -= 1
            # Get total number of clock cycles
            if re.match( '<TotalCycles> :' + '.*' , line): 
                strp = line.strip()
                s = strp.split(' ')
                self.cycles = str(s[3])
            # Get total number of NOPs
            if re.match( '<NOPs> :' + '.*' , line): 
                strp = line.strip()
                s = strp.split(' ')
                self.nops = str(s[3])
            # Get CPI
            if re.match( '<CPI> :' + '.*' , line): 
                strp = line.strip()
                s = strp.split(' ')
                self.cpi = str(s[3])
            # Get core clock cycles
            if re.match( '<CoreCycles> :' + '.*' , line):
                strp = line.strip()
                s = strp.split(' ')
                self.corecycles = str(s[3])
            # Get core NOPs
            if re.match( '<CoreNOPs> :' + '.*' , line): 
                strp = line.strip()
                s = strp.split(' ')
                self.corenops = str(s[3])

    # Getter function for Core NOPs
    def getCoreNops(self):
        return (str(self.corenops)).replace(' ', '')[:-2].upper()

    # Getter function for Core Cycles
    def getCoreCycles(self):
        return (str(self.corecycles)).replace(' ', '')[:-2].upper()

    # Getter function for Cycle Count
    def getCycles(self):
        return (str(self.cycles)).replace(' ', '')[:-2].upper()

    # Getter function for NOP Count
    def getNOPs(self):
        return (str(self.nops)).replace(' ', '')[:-2].upper()

    # Getter function for CPI Value
    def getCPI(self):
        return str(round(float(self.cpi), 3))
