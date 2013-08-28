## Python Simulator for iDEA
by Fred and Hui Yan

Original repo: https://github.com/maguire/MIPS-Simulator
(credit to user 'maguire')

Forked repo: https://github.com/brosser/MIPS-Simulator
(Simulator for MIPS)

### Description

iDEA-Simulator is a simulator for the iDEA processor architecture, written in Python. 
The simulator runs a given assembly program and outputs simulation logfiles and statistics.

### Justification
* An instruction set simulator to model and accurately predict the behavior of instructions' execution.
* Main motivations:
	- to obtain performance metrics such as instruction count and clock cycles.
	- to identify hazards / data dependencies.
	- to ensure logical and functional correctness.
	- to predict the potential savings/ impact of hardware change. 
	- to analyse opportunity for composite instructions.
* A cross between behavioural and cycle-accurate simulator.

### Sections of the Simulator
* Assembler
	* Pre-processing: Reads and parses the elf32-bigmips code
	* Analysis: Dependency checks and resolving by nop insertions
	* Code generation: Generates the code for simulator (Instruction Memory and Data Memory).
* Simulator
	* Accepts the asm code generated and emulates the execution of the code instructions.
	* Dumps a log file of instruction pipelines.
	
------

### Usage

`python run-simulator.py [options] <Input ASM> <Sim. Log> <Sim. ASM File> <Preproc. Log> <Memory Dump>`

Example:

`python src/run-simulator.py -v benchmark/toy/median/median-O2.asm`

Only the Assembler Input File is a required input, others are optional (default filenames are used).

The input file uses the format elf32-bigmips.

#### Options

- `--version` Show program's version number and exit.
- `-h, --help` Show help message and exit.
- `-v, --verbose` Print cycle by cycle debug information to simulaton log file.
- `-c, --core` Show only core cycle information.
- `-q, --quiet` Show only summary of statistics.
- `-m, --mute` Supress all output.
- `-p <N>` Set number of pipeline stages [N >= 4, default 5]
- `-f <N>` Set number of Instruction Fetch (IF) cycles [default 1]
- `-d <N>` Set number of Instruction Decode (ID) cycles [default 1]
- `-e <N>` Set number of Execute/Memory (EX/MEM) cycles [default 2]
- `-w <N>` Set number of Writeback (WB) stages [default 1]
- `-s` Set execution start address [default @<main>].

The pipeline must contain at least 4 stages (IF-ID-EX-WB). If the pipeline is deeper than 4 stages,
the EX/MEM stage will be allocated more cycles, up to a maximum of 4. After that, the pipeline will be padded with IF.

#### Output

- `<Simulation Run Log File>` Log file from simulation, showing final register file state, accessed data memory 
and run statistics
- `<Simulation Assembly File>` The processed Assembly code as input to the simulator
- `<Preprocessing Log File>` Preprocessing logfile, specifying NOP-insertions, branch address recalculations and
parse log
- `<Data Memory Dump File>` Pre-simulation data memory dump

#### Automated testing

`./runSimulations.sh`.

Bash script that automatically runs all benchmarks and outputs cycle count.
