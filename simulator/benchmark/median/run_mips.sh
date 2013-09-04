#!/usr/bin/sh
mips-elf-gcc -O0 -c -g median.c
mips-elf-objdump -D -S -M no-aliases -j .rodata -j .text -j .bss -j .data median.o > median-O0.asm
#mips-elf-objdump -d -S -M no-aliases median.o > median-O0.asm # prints full inst instead of pseudo-inst
#mips-elf-objdump -d -S -M gpr-names=numeric median.o > median-O0.asm # prints reg number instead of reg name

mips-elf-gcc -O1 -c -g median.c
mips-elf-objdump -D -S -M no-aliases -j .rodata -j .text -j .bss -j .data median.o > median-O1.asm

mips-elf-gcc -O2 -c -g median.c
mips-elf-objdump -D -S -M no-aliases -j .rodata -j .text -j .bss -j .data median.o > median-O2.asm

mips-elf-gcc -O3 -c -g median.c
mips-elf-objdump -D -S -M no-aliases -j .rodata -j .text -j .bss -j .data median.o > median-O3.asm

#http://linux.die.net/man/1/objdump
#http://sourceware.org/binutils/docs/binutils/objdump.html
