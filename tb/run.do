######################################################################
# Modelsim simulation .do file template
######################################################################

# Create work library
rm -rf work
vlib work

set primitive "../rtl/primitive"
set rtl "../rtl"

# Primitive simulation model
vlog "$primitive/glbl.v"
vlog "$primitive/RAM32M.v"
vlog "$primitive/DSP48E1.v"
vlog "$primitive/RAMB36E1.v"

# Design RTL
vlog "$rtl/decode.v"
vlog "$rtl/alu_core.v"
vlog "$rtl/control.v"
vlog "$rtl/cpu_core.v"
vlog "$rtl/cpu_top.v"
vlog "$rtl/data_mem_infer.v"
vlog "$rtl/defines.v"
vlog "$rtl/ex1.v"
vlog "$rtl/ex2.v"
vlog "$rtl/ex3.v"
vlog "$rtl/ex4.v"
vlog "$rtl/execute.v"
vlog "$rtl/fetch.v"
vlog "$rtl/input_map.v"
vlog "$rtl/inst_mem_infer.v"
vlog "$rtl/offset_add.v"
vlog "$rtl/regfile.v"
vlog "$rtl/status_register.v"
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
