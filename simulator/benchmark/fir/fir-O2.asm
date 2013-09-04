
fir.o:     file format elf32-bigmips


Disassembly of section .text:

00000000 <main>:
                            588, 591, 621, 432, 552, 710, 1047, 985, 1231, 1174,
                            1147, 1010, 1099, 1221, 1121, 887, 809, 830, 861, 1003,
                            1031, 1000, 949, 913, 1012, 813, 797, 747, 763, 662,
                            590, 664, 719, 937, 1043, 815, 453, 170, 44, 3}; 

int main () {
   0:	27bdff20 	addiu	sp,sp,-224
    int k, n;
    int sum;
    
    int ndata = 50;
    int ncoeff = 5;
    int /*short*/ coeff[5] = { 3, 5, 15, 12, 7};
   4:	24020003 	addiu	v0,zero,3
   8:	afa20000 	sw	v0,0(sp)
   c:	24020005 	addiu	v0,zero,5
  10:	afa20004 	sw	v0,4(sp)
  14:	2402000f 	addiu	v0,zero,15
  18:	afa20008 	sw	v0,8(sp)
  1c:	2402000c 	addiu	v0,zero,12
  20:	27a50014 	addiu	a1,sp,20
  24:	afa2000c 	sw	v0,12(sp)
  28:	3c0a0000 	lui	t2,0x0
  2c:	24020007 	addiu	v0,zero,7
  30:	afa20010 	sw	v0,16(sp)
  34:	00a03821 	addu	a3,a1,zero
    int y[50];

    for (n = 0; n < ndata; n++) {
  38:	00003021 	addu	a2,zero,zero
  3c:	254a0000 	addiu	t2,t2,0
  40:	27a90004 	addiu	t1,sp,4
  44:	24080032 	addiu	t0,zero,50
                            588, 591, 621, 432, 552, 710, 1047, 985, 1231, 1174,
                            1147, 1010, 1099, 1221, 1121, 887, 809, 830, 861, 1003,
                            1031, 1000, 949, 913, 1012, 813, 797, 747, 763, 662,
                            590, 664, 719, 937, 1043, 815, 453, 170, 44, 3}; 

int main () {
START_CCORE
  48:	00061880 	sll	v1,a2,0x2
  4c:	01431821 	addu	v1,t2,v1
    int y[50];

    for (n = 0; n < ndata; n++) {
        sum = 0;
        for (k = 0; k < ncoeff; k++) {
            sum = sum + coeff[k] * data[k+n];
  50:	8c6b0000 	lw	t3,0(v1)
                            588, 591, 621, 432, 552, 710, 1047, 985, 1231, 1174,
                            1147, 1010, 1099, 1221, 1121, 887, 809, 830, 861, 1003,
                            1031, 1000, 949, 913, 1012, 813, 797, 747, 763, 662,
                            590, 664, 719, 937, 1043, 815, 453, 170, 44, 3}; 

int main () {
  54:	240c0003 	addiu	t4,zero,3
    int y[50];

    for (n = 0; n < ndata; n++) {
        sum = 0;
        for (k = 0; k < ncoeff; k++) {
            sum = sum + coeff[k] * data[k+n];
  58:	018b0018 	mult	t4,t3
                            588, 591, 621, 432, 552, 710, 1047, 985, 1231, 1174,
                            1147, 1010, 1099, 1221, 1121, 887, 809, 830, 861, 1003,
                            1031, 1000, 949, 913, 1012, 813, 797, 747, 763, 662,
                            590, 664, 719, 937, 1043, 815, 453, 170, 44, 3}; 

int main () {
  5c:	00002021 	addu	a0,zero,zero
  60:	01201021 	addu	v0,t1,zero
    int y[50];

    for (n = 0; n < ndata; n++) {
        sum = 0;
        for (k = 0; k < ncoeff; k++) {
            sum = sum + coeff[k] * data[k+n];
  64:	24630004 	addiu	v1,v1,4
  68:	00005812 	mflo	t3
    int /*short*/ coeff[5] = { 3, 5, 15, 12, 7};
    int y[50];

    for (n = 0; n < ndata; n++) {
        sum = 0;
        for (k = 0; k < ncoeff; k++) {
  6c:	10a20009 	beq	a1,v0,94 <main+0x94>
  70:	008b2021 	addu	a0,a0,t3
            sum = sum + coeff[k] * data[k+n];
  74:	8c6b0000 	lw	t3,0(v1)
    int k, n;
    int sum;
    
    int ndata = 50;
    int ncoeff = 5;
    int /*short*/ coeff[5] = { 3, 5, 15, 12, 7};
  78:	8c4c0000 	lw	t4,0(v0)
  7c:	24420004 	addiu	v0,v0,4
    int y[50];

    for (n = 0; n < ndata; n++) {
        sum = 0;
        for (k = 0; k < ncoeff; k++) {
            sum = sum + coeff[k] * data[k+n];
  80:	018b0018 	mult	t4,t3
  84:	24630004 	addiu	v1,v1,4
  88:	00005812 	mflo	t3
    int /*short*/ coeff[5] = { 3, 5, 15, 12, 7};
    int y[50];

    for (n = 0; n < ndata; n++) {
        sum = 0;
        for (k = 0; k < ncoeff; k++) {
  8c:	14a2fff9 	bne	a1,v0,74 <main+0x74>
  90:	008b2021 	addu	a0,a0,t3
    int ndata = 50;
    int ncoeff = 5;
    int /*short*/ coeff[5] = { 3, 5, 15, 12, 7};
    int y[50];

    for (n = 0; n < ndata; n++) {
  94:	24c60001 	addiu	a2,a2,1
        sum = 0;
        for (k = 0; k < ncoeff; k++) {
  98:	ace40000 	sw	a0,0(a3)
    int ndata = 50;
    int ncoeff = 5;
    int /*short*/ coeff[5] = { 3, 5, 15, 12, 7};
    int y[50];

    for (n = 0; n < ndata; n++) {
  9c:	14c8ffea 	bne	a2,t0,48 <main+0x48>
  a0:	24e70004 	addiu	a3,a3,4
  a4:	3c080000 	lui	t0,0x0
  a8:	00001821 	addu	v1,zero,zero
  ac:	00001021 	addu	v0,zero,zero
  b0:	25080000 	addiu	t0,t0,0
            sum = sum + coeff[k] * data[k+n];
            y[n] = sum;           
        }
    }
END_CCORE

    for (i = 0; i < 50; i++){
  b4:	240700c8 	addiu	a3,zero,200
                            588, 591, 621, 432, 552, 710, 1047, 985, 1231, 1174,
                            1147, 1010, 1099, 1221, 1121, 887, 809, 830, 861, 1003,
                            1031, 1000, 949, 913, 1012, 813, 797, 747, 763, 662,
                            590, 664, 719, 937, 1043, 815, 453, 170, 44, 3}; 

int main () {
  b8:	01033021 	addu	a2,t0,v1
  bc:	00a32021 	addu	a0,a1,v1
            y[n] = sum;           
        }
    }
    
 // Manually inserted by Fred, Apr. 4 2013
  888: 88888888  addiu a2,a2,0xd8    

    for (i = 0; i < 50; i++){
        main_result += (output[i] != y[i]);
  c0:	8cc60000 	lw	a2,0(a2)
  c4:	8c840000 	lw	a0,0(a0)
  c8:	24630004 	addiu	v1,v1,4
  cc:	00c42026 	xor	a0,a2,a0
  d0:	0004202b 	sltu	a0,zero,a0
            sum = sum + coeff[k] * data[k+n];
            y[n] = sum;           
        }
    }
    
    for (i = 0; i < 50; i++){
  d4:	1467fff8 	bne	v1,a3,b8 <main+0xb8>
  d8:	00441021 	addu	v0,v0,a0
        main_result += (output[i] != y[i]);
    }
    //printf ("%d\n", main_result);
    
    return main_result;
}
  dc:	03e00008 	jr	ra
  e0:	27bd00e0 	addiu	sp,sp,224

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
