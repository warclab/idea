######################################################################
# Modelsim simulation .do file template
######################################################################
set primitive "./../../../rtl-pipeline/primitive"
set rtl "./../../../rtl-pipeline"

# Create work library
rm -rf work
vlib work
cp -f $rtl/defines.v .
cp -f $rtl/bitmask.v .
cp -f $rtl/data_mem.v .
cp -r $rtl/data.mif .

# Primitive simulation model
vlog "$primitive/glbl.v"
vlog "$primitive/RAM32M.v"
vlog "$primitive/DSP48E1.v"
vlog "$primitive/RAMB36E1.v"

# Design RTL
vlog "defines.v"
vlog "bitmask.v"
vlog "$rtl/decode.v"
vlog "$rtl/alu_core.v"
vlog "$rtl/control.v"
vlog "$rtl/cpu_core.v"
vlog "$rtl/cpu_top.v"
vlog "data_mem.v"
vlog "$rtl/alu_intermediate_shreg.v"
vlog "$rtl/id_intermediate_shreg.v"
vlog "$rtl/if_o_shreg.v"
vlog "$rtl/ex_o_shreg.v"
vlog "$rtl/execute.v"
vlog "$rtl/fetch.v"
vlog "$rtl/input_map.v"
vlog "inst_mem.v"
vlog "$rtl/effective_addr.v"
vlog "$rtl/regfile.v"
vlog "test_tb.v"

# Call vsim to invoke simulator
vsim -voptargs="+acc" -t 1ps -lib work test_tb glbl

# Source the wave do file
#do wave.do

# Set the window types
log -r *
add wave -radix hexadecimal *

# Run simulation
run -all
