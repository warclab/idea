#!/bin/bash
# Bash script to run all benchmark simulations
# To run this script, do:
# $ chmod +x runSimulations.sh
# $ ./runSimulations.sh option
# <option> all 5 9
# E.g. ./runSimulations.sh all

# All benchmarks
benchmarks=(
"./benchmark/fib/fib-O0.asm"
"./benchmark/fib/fib-O1.asm"
"./benchmark/fib/fib-O2.asm"
"./benchmark/fib/fib-O3.asm"
"./benchmark/fir/fir-O0.asm"
"./benchmark/fir/fir-O1.asm"
"./benchmark/fir/fir-O2.asm"
"./benchmark/fir/fir-O3.asm"
"./benchmark/median/median-O0.asm"
"./benchmark/median/median-O1.asm"
"./benchmark/median/median-O2.asm"
"./benchmark/median/median-O3.asm"
"./benchmark/mmult/mmult-O0.asm"
"./benchmark/mmult/mmult-O1.asm"
"./benchmark/mmult/mmult-O2.asm"
"./benchmark/mmult/mmult-O3.asm"
"./benchmark/bubble/bubble-O0.asm"
"./benchmark/bubble/bubble-O1.asm"
"./benchmark/bubble/bubble-O2.asm"
"./benchmark/bubble/bubble-O3.asm"
"./benchmark/factorial/factorial-O0.asm"
"./benchmark/factorial/factorial-O1.asm"
"./benchmark/factorial/factorial-O2.asm"
"./benchmark/factorial/factorial-O3.asm"
"./benchmark/qsort/qsort-O0.asm"
"./benchmark/qsort/qsort-O1.asm"
"./benchmark/qsort/qsort-O2.asm"
"./benchmark/qsort/qsort-O3.asm"
"./benchmark/crc/crc-O0.asm"
"./benchmark/crc/crc-O1.asm"
"./benchmark/crc/crc-O2.asm"
"./benchmark/crc/crc-O3.asm"
)

if [ -f runSimulations.log ];
then
	rm -rf runSimulations.log
fi

if [ $# -lt 1 ];
then
	echo "Please specify number of stages: all, 5 or 9"
	exit
fi

if [ $1 = "all" ];
then
	nE=( 2 3 4 )
	nF=( 1 2 3 )
elif [ $1 = "5" ];
then
	nE=( 2 )
	nF=( 1 )
elif [ $1 = "9" ];
then
	nE=( 4 )
	nF=( 3 )
fi

{
for E in ${nE[@]}
do
	for F in ${nF[@]}
	do
		let I=$F+1+$E+1	

		echo -e "\n"
		echo -ne "[  $I Stage Pipeline  ]:"
		echo -ne "\t"
		for ((i=1; i <= $F; i++))
		do
		 if [ $i -eq 1 ] 
		 	then echo -ne " IF " 
		 fi
		 if [ $i -ne 1 ] 
		 	then echo -ne "- IF " 
		 fi
		done
		echo -ne "- ID " 
		for ((i=1; i <= $E; i++))
		do
		 echo -ne "- EX "
		done
		echo -e "- WB "
		echo -e "# Result \t\t Benchmark\t\t      Cycles\tNOPs\tCPI\tCore  CoreNOPs\t% NOPs\tExecution Time\tCore Execution Time"
		echo -e "-------------------------------------------------------------------------------------------------------------------------------------------"
		
		# Run all benchmarks
		for b in "${benchmarks[@]}"
		do
			:
			echo -en "$I "; python src/run-simulator.py -q -p $I -f $F -d 1 -e $E -w 1 $b
		done
	done
done
} | tee -a runSimulations.log
