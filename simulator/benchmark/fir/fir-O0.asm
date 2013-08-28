
fir.o:     file format elf32-bigmips


Disassembly of section .text:

00000000 <main>:
                            588, 591, 621, 432, 552, 710, 1047, 985, 1231, 1174,
                            1147, 1010, 1099, 1221, 1121, 887, 809, 830, 861, 1003,
                            1031, 1000, 949, 913, 1012, 813, 797, 747, 763, 662,
                            590, 664, 719, 937, 1043, 815, 453, 170, 44, 3}; 

int main () {
   0:	27bdff00 	addiu	sp,sp,-256
   4:	afbe00fc 	sw	s8,252(sp)
   8:	03a0f021 	addu	s8,sp,zero

    int i;
    int main_result = 0;
   c:	afc00004 	sw	zero,4(s8)

    int k, n;
    int sum;
    
    int ndata = 50;
  10:	24020032 	addiu	v0,zero,50
  14:	afc20014 	sw	v0,20(s8)
    int ncoeff = 5;
  18:	24020005 	addiu	v0,zero,5
  1c:	afc20018 	sw	v0,24(s8)
    int /*short*/ coeff[5] = { 3, 5, 15, 12, 7};
  20:	24020003 	addiu	v0,zero,3
  24:	afc2001c 	sw	v0,28(s8)
  28:	24020005 	addiu	v0,zero,5
  2c:	afc20020 	sw	v0,32(s8)
  30:	2402000f 	addiu	v0,zero,15
  34:	afc20024 	sw	v0,36(s8)
  38:	2402000c 	addiu	v0,zero,12
  3c:	afc20028 	sw	v0,40(s8)
  40:	24020007 	addiu	v0,zero,7
  44:	afc2002c 	sw	v0,44(s8)
    int y[50];

    for (n = 0; n < ndata; n++) {
  48:	afc0000c 	sw	zero,12(s8)
  4c:	08000043 	j	10c <main+0x10c>
  50:	00000000 	sll	zero,zero,0x0
        sum = 0;
START_CCORE
  54:	afc00010 	sw	zero,16(s8)
        for (k = 0; k < ncoeff; k++) {
  58:	afc00008 	sw	zero,8(s8)
  5c:	08000039 	j	e4 <main+0xe4>
  60:	00000000 	sll	zero,zero,0x0
            sum = sum + coeff[k] * data[k+n];
  64:	8fc20008 	lw	v0,8(s8)
  68:	00000000 	sll	zero,zero,0x0
  6c:	00021080 	sll	v0,v0,0x2
  70:	03c21021 	addu	v0,s8,v0
  74:	8c44001c 	lw	a0,28(v0)
  78:	8fc30008 	lw	v1,8(s8)
  7c:	8fc2000c 	lw	v0,12(s8)
  80:	00000000 	sll	zero,zero,0x0
  84:	00621821 	addu	v1,v1,v0
  88:	3c020000 	lui	v0,0x0
  8c:	00031880 	sll	v1,v1,0x2
  90:	24420000 	addiu	v0,v0,0
  94:	00621021 	addu	v0,v1,v0
  98:	8c420000 	lw	v0,0(v0)
  9c:	00000000 	sll	zero,zero,0x0
  a0:	00820018 	mult	a0,v0
  a4:	00001812 	mflo	v1
  a8:	8fc20010 	lw	v0,16(s8)
  ac:	00000000 	sll	zero,zero,0x0
  b0:	00431021 	addu	v0,v0,v1
  b4:	afc20010 	sw	v0,16(s8)
            y[n] = sum;           
  b8:	8fc2000c 	lw	v0,12(s8)
  bc:	00000000 	sll	zero,zero,0x0
  c0:	00021080 	sll	v0,v0,0x2
  c4:	03c21021 	addu	v0,s8,v0
  c8:	8fc30010 	lw	v1,16(s8)
  cc:	00000000 	sll	zero,zero,0x0
  d0:	ac430030 	sw	v1,48(v0)
    int /*short*/ coeff[5] = { 3, 5, 15, 12, 7};
    int y[50];

    for (n = 0; n < ndata; n++) {
        sum = 0;
        for (k = 0; k < ncoeff; k++) {
  d4:	8fc20008 	lw	v0,8(s8)
  d8:	00000000 	sll	zero,zero,0x0
  dc:	24420001 	addiu	v0,v0,1
  e0:	afc20008 	sw	v0,8(s8)
  e4:	8fc30008 	lw	v1,8(s8)
  e8:	8fc20018 	lw	v0,24(s8)
  ec:	00000000 	sll	zero,zero,0x0
  f0:	0062102a 	slt	v0,v1,v0
  f4:	1440ffdb 	bnez	v0,64 <main+0x64>
  f8:	00000000 	sll	zero,zero,0x0
    int ndata = 50;
    int ncoeff = 5;
    int /*short*/ coeff[5] = { 3, 5, 15, 12, 7};
    int y[50];

    for (n = 0; n < ndata; n++) {
  fc:	8fc2000c 	lw	v0,12(s8)
 100:	00000000 	sll	zero,zero,0x0
 104:	24420001 	addiu	v0,v0,1
 108:	afc2000c 	sw	v0,12(s8)
 10c:	8fc3000c 	lw	v1,12(s8)
 110:	8fc20014 	lw	v0,20(s8)
 114:	00000000 	sll	zero,zero,0x0
 118:	0062102a 	slt	v0,v1,v0
 11c:	1440ffcd 	bnez	v0,54 <main+0x54>
 120:	00000000 	sll	zero,zero,0x0
            sum = sum + coeff[k] * data[k+n];
            y[n] = sum;           
        }
    }
END_CCORE
    
    for (i = 0; i < 50; i++){
 124:	afc00000 	sw	zero,0(s8)

 // Manually inserted by Fred, Apr. 4 2013
 888: 88888888  addiu v0,v0,0xd8


 128:	08000063 	j	18c <main+0x18c>
 12c:	00000000 	sll	zero,zero,0x0
        main_result += (output[i] != y[i]);
 130:	3c020000 	lui	v0,0x0
 134:	8fc30000 	lw	v1,0(s8)
 138:	00000000 	sll	zero,zero,0x0
 13c:	00031880 	sll	v1,v1,0x2
 140:	24420000 	addiu	v0,v0,0
 144:	00621021 	addu	v0,v1,v0
 148:	8c430000 	lw	v1,0(v0)
 14c:	8fc20000 	lw	v0,0(s8)
 150:	00000000 	sll	zero,zero,0x0
 154:	00021080 	sll	v0,v0,0x2
 158:	03c21021 	addu	v0,s8,v0
 15c:	8c420030 	lw	v0,48(v0)
 160:	00000000 	sll	zero,zero,0x0
 164:	00621026 	xor	v0,v1,v0
 168:	0002102b 	sltu	v0,zero,v0
 16c:	8fc30004 	lw	v1,4(s8)
 170:	00000000 	sll	zero,zero,0x0
 174:	00621021 	addu	v0,v1,v0
 178:	afc20004 	sw	v0,4(s8)
            sum = sum + coeff[k] * data[k+n];
            y[n] = sum;           
        }
    }
    
    for (i = 0; i < 50; i++){
 17c:	8fc20000 	lw	v0,0(s8)
 180:	00000000 	sll	zero,zero,0x0
 184:	24420001 	addiu	v0,v0,1
 188:	afc20000 	sw	v0,0(s8)
 18c:	8fc20000 	lw	v0,0(s8)
 190:	00000000 	sll	zero,zero,0x0
 194:	28420032 	slti	v0,v0,50
 198:	1440ffe5 	bnez	v0,130 <main+0x130>
 19c:	00000000 	sll	zero,zero,0x0
        main_result += (output[i] != y[i]);
    }
    //printf ("%d\n", main_result);
    
    return main_result;
 1a0:	8fc20004 	lw	v0,4(s8)
}
 1a4:	03c0e821 	addu	sp,s8,zero
 1a8:	8fbe00fc 	lw	s8,252(sp)
 1ac:	27bd0100 	addiu	sp,sp,256
 1b0:	03e00008 	jr	ra
 1b4:	00000000 	sll	zero,zero,0x0

Disassembly of section .rodata:

00000000 <data>:
   0:	0000002d 	0x2d
   4:	00000001 	0x1
   8:	00000016 	0x16
   c:	00000035 	0x35
  10:	0000000a 	0xa
  14:	0000000c 	syscall
  18:	0000000d 	break
  1c:	00000019 	multu	zero,zero
  20:	00000021 	addu	zero,zero,zero
  24:	0000000e 	0xe
  28:	0000000c 	syscall
  2c:	00000024 	and	zero,zero,zero
  30:	0000000c 	syscall
  34:	00000002 	srl	zero,zero,0x0
  38:	00000018 	mult	zero,zero
  3c:	0000000f 	0xf
  40:	00000005 	0x5
  44:	00000003 	sra	zero,zero,0x0
  48:	0000002a 	slt	zero,zero,zero
  4c:	0000000d 	break
  50:	00000021 	addu	zero,zero,zero
  54:	00000019 	multu	zero,zero
  58:	00000023 	negu	zero,zero
  5c:	00000019 	multu	zero,zero
  60:	0000000e 	0xe
  64:	0000001f 	0x1f
  68:	00000029 	0x29
  6c:	00000011 	mthi	zero
  70:	0000000f 	0xf
  74:	00000016 	0x16
  78:	00000010 	mfhi	zero
  7c:	0000001a 	div	zero,zero,zero
  80:	00000016 	0x16
  84:	0000001d 	0x1d
  88:	00000019 	multu	zero,zero
  8c:	0000000b 	0xb
  90:	00000021 	addu	zero,zero,zero
  94:	00000014 	0x14
  98:	00000015 	0x15
  9c:	00000009 	jalr	zero,zero
  a0:	00000019 	multu	zero,zero
  a4:	00000015 	0x15
  a8:	00000004 	sllv	zero,zero,zero
  ac:	00000015 	0x15
  b0:	0000000e 	0xe
  b4:	0000000e 	0xe
  b8:	00000020 	add	zero,zero,zero
  bc:	0000001e 	0x1e
  c0:	0000000d 	break
  c4:	00000001 	0x1
	...

000000d8 <output>:
  d8:	00000498 	0x498
  dc:	00000458 	0x458
  e0:	000002cc 	syscall	0xb
  e4:	000002d0 	0x2d0
  e8:	00000330 	0x330
  ec:	000003ca 	0x3ca
  f0:	0000038f 	0x38f
  f4:	0000034e 	0x34e
  f8:	00000361 	0x361
  fc:	00000320 	0x320
 100:	0000024c 	syscall	0x9
 104:	0000024f 	0x24f
 108:	0000026d 	0x26d
 10c:	000001b0 	0x1b0
 110:	00000228 	0x228
 114:	000002c6 	0x2c6
 118:	00000417 	0x417
 11c:	000003d9 	0x3d9
 120:	000004cf 	0x4cf
 124:	00000496 	0x496
 128:	0000047b 	0x47b
 12c:	000003f2 	0x3f2
 130:	0000044b 	0x44b
 134:	000004c5 	0x4c5
 138:	00000461 	0x461
 13c:	00000377 	0x377
 140:	00000329 	0x329
 144:	0000033e 	0x33e
 148:	0000035d 	0x35d
 14c:	000003eb 	0x3eb
 150:	00000407 	0x407
 154:	000003e8 	0x3e8
 158:	000003b5 	0x3b5
 15c:	00000391 	0x391
 160:	000003f4 	0x3f4
 164:	0000032d 	0x32d
 168:	0000031d 	0x31d
 16c:	000002eb 	0x2eb
 170:	000002fb 	0x2fb
 174:	00000296 	0x296
 178:	0000024e 	0x24e
 17c:	00000298 	0x298
 180:	000002cf 	0x2cf
 184:	000003a9 	0x3a9
 188:	00000413 	0x413
 18c:	0000032f 	0x32f
 190:	000001c5 	0x1c5
 194:	000000aa 	0xaa
 198:	0000002c 	0x2c
 19c:	00000003 	sra	zero,zero,0x0
