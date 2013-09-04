#!/usr/bin/sh
mips-elf-gcc -O0 -c -g fib.c
mips-elf-objdump -D -S -M no-aliases -j .rodata -j .text -j .bss -j .data fib.o > fib-O0.asm
#mips-elf-objdump -d -S -M no-aliases fib.o > fib-O0.asm # prints full inst instead of pseudo-inst
#mips-elf-objdump -d -S -M gpr-names=numeric fib.o > fib-O0.asm # prints reg number instead of reg name

mips-elf-gcc -O1 -c -g fib.c
mips-elf-objdump -D -S -M no-aliases -j .rodata -j .text -j .bss -j .data fib.o > fib-O1.asm

mips-elf-gcc -O2 -c -g fib.c
mips-elf-objdump -D -S -M no-aliases -j .rodata -j .text -j .bss -j .data fib.o > fib-O2.asm

mips-elf-gcc -O3 -c -g fib.c
mips-elf-objdump -D -S -M no-aliases -j .rodata -j .text -j .bss -j .data fib.o > fib-O3.asm

#http://linux.die.net/man/1/objdump
#http://sourceware.org/binutils/docs/binutils/objdump.html
