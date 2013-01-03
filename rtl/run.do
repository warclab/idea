######################################################################
# Modelsim simulation .do file template
######################################################################

# Create work library
rm -rf work
vlib work

set primitive "./primitive"

# Primitive simulation model
vlog "$primitive/glbl.v"
vlog "$primitive/RAM32M.v"
vlog "$primitive/DSP48E1.v"
vlog "$primitive/RAMB36E1.v"

# Design RTL
vlog "decode.v"
vlog "alu_core.v"
vlog "control.v"
vlog "cpu_core.v"
vlog "cpu_top.v"
vlog "data_mem_infer.v"
vlog "defines.v"
vlog "ex1.v"
vlog "ex2.v"
vlog "ex3.v"
vlog "ex4.v"
vlog "execute.v"
vlog "fetch.v"
vlog "input_map.v"
vlog "inst_mem_infer.v"
vlog "offset_add.v"
vlog "regfile.v"
vlog "status_register.v"
vlog "test_tb.v"

# Call vsim to invoke simulator
vsim -voptargs="+acc" -t 1ps -lib work test_tb glbl

# Source the wave do file
do wave.do

# Set the window types
log -r *
#add wave -radix hexadecimal *

# Run simulation
run -all
