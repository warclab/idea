onerror {resume}
quietly WaveActivateNextPane {} 0
add wave /test_tb/clk
add wave /test_tb/rst
add wave -radix hexadecimal /test_tb/reg_addr_0
add wave -radix hexadecimal /test_tb/reg_addr_1
add wave -radix hexadecimal /test_tb/reg_addr_2
add wave -radix hexadecimal /test_tb/reg_addr_3
add wave -radix hexadecimal /test_tb/reg_addr_4
add wave -radix hexadecimal /test_tb/clk_count
add wave -radix hexadecimal /test_tb/inst_count
