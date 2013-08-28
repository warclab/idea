##################################################################
#
# iDEA Simulator
#   bcolors.py
#
# Debug colour output formatting
# Fredrik Brosser 2013-05-14
#
##################################################################


class bcolors:

    ## Colour definitions
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'

    ## Constructor
    def __init__(self):
	   self.defaultErrorMsg = "Error"

    ## Disable colour output
    def disable(self):
        self.HEADER = ''
        self.OKBLUE = ''
        self.OKGREEN = ''
        self.WARNING = ''
        self.FAIL = ''
        self.ENDC = ''

    ## Print information for a successful test in Green
    #   s : Name/Filename of test
    #   stats : Statistics displayed for the test
    def printPass(self, s, stats):
        n = 1
        i = 40
        while i > 4:
            if (len(s) < i):
                n += 1
            i -= 8
        printstr = self.OKGREEN + "Passed \t| " + s + "\t"
        for stat in stats:
            printstr += str(stat) + "\t"  
        printstr += self.ENDC
        print printstr

    ## Print a single statistic only (core cycles)
    def printCoreOnly(self, ccore):
        printstr = self.OKGREEN + str(ccore) + self.ENDC
        print printstr

    ## Print information for a failed test in Red
    #   s : Name/Filename of test
    #   errorMsg : Error message to be displayed
    def printFail(self, s, errorMsg):
	   print self.FAIL + "Failed \t|\t " + s + "\t" + errorMsg + self.ENDC

    ## Print general error message
    #   errorMsg : Error message to be displayed
    def printError(self, errorMsg):
       print self.FAIL + errorMsg + self.ENDC

# END of bcolors.py