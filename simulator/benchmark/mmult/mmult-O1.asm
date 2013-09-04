  
mmult.o:     file format elf32-bigmips


Disassembly of section .text:

00000000 <main>:
                            {51, 25, 51, 26, 52},
                            {71, 35, 71, 36, 72},
                            {91, 45, 91, 46, 92}};

int main()
{
   0:	27bdff98 	addiu	sp,sp,-104
    int x, y;
    int sum = 0;

    int main_result = 0;

    for (i = 0; i < 5; i++) {
   4:	3c060000 	lui	a2,0x0
   8:	24c60014 	addiu	a2,a2,20
   c:	00004821 	addu	t1,zero,zero
                            {31, 15, 31, 16, 32},
                            {51, 25, 51, 26, 52},
                            {71, 35, 71, 36, 72},
                            {91, 45, 91, 46, 92}};

int main()
  10:	3c0d0000 	lui	t5,0x0
  14:	25ad0000 	addiu	t5,t5,0
  18:	3c0c0000 	lui	t4,0x0
  1c:	258c0000 	addiu	t4,t4,0
    int sum = 0;

    int main_result = 0;

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
  20:	08000022 	j	8c <main+0x88>
  24:	24080005 	addiu	t0,zero,5
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
START_CCORE
  28:	8c8f0000 	lw	t7,0(a0)
  2c:	8c4e0000 	lw	t6,0(v0)
  30:	00000000 	sll	zero,zero,0x0
  

  34:	01ee0018 	mult	t7,t6
  38:	00007012 	mflo	t6
  3c:	006e1821 	addu	v1,v1,t6
                c[i][j]=sum;
  40:	aca30000 	sw	v1,0(a1)
  44:	24420004 	addiu	v0,v0,4
    int main_result = 0;

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
  48:	14c2fff7 	bne	a2,v0,28 <main+0x28>
  4c:	24840014 	addiu	a0,a0,20
    int sum = 0;

    int main_result = 0;

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
  50:	24e70001 	addiu	a3,a3,1
  54:	10e80009 	beq	a3,t0,80 <main+0x7c>
  58:	00000000 	sll	zero,zero,0x0
                            {31, 15, 31, 16, 32},
                            {51, 25, 51, 26, 52},
                            {71, 35, 71, 36, 72},
                            {91, 45, 91, 46, 92}};

int main()
  5c:	01601021 	addu	v0,t3,zero
  60:	00072080 	sll	a0,a3,0x2

  // Manually inserted by Fred Apr. 15
  88: 88888888  addiu a0,a0,0x64

  64:	01842021 	addu	a0,t4,a0
  68:	00001821 	addu	v1,zero,zero
    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
                c[i][j]=sum;
  6c:	01472821 	addu	a1,t2,a3
  70:	00052880 	sll	a1,a1,0x2
  74:	0800000a 	j	28 <main+0x28>
  78:	03a52821 	addu	a1,sp,a1
    int x, y;
    int sum = 0;

    int main_result = 0;

    for (i = 0; i < 5; i++) {
  7c:	25290001 	addiu	t1,t1,1
  80:	11280019 	beq	t1,t0,ec <main+0xe8>
  84:	24c60014 	addiu	a2,a2,20
                            {31, 15, 31, 16, 32},
                            {51, 25, 51, 26, 52},
                            {71, 35, 71, 36, 72},
                            {91, 45, 91, 46, 92}};

int main()
  88:	00003821 	addu	a3,zero,zero
  8c:	00095080 	sll	t2,t1,0x2
  90:	00095900 	sll	t3,t1,0x4
  94:	014b5821 	addu	t3,t2,t3
  98:	01ab5821 	addu	t3,t5,t3
    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
                c[i][j]=sum;
  9c:	08000017 	j	5c <main+0x5c>
  a0:	01495021 	addu	t2,t2,t1
END_CCORE
        }
    }
    
    for (x = 0; x < 5; x++){
        for (y = 0; y < 5; y++) {
            main_result += (output[x][y] != c[x][y]);
  a4:	01032821 	addu	a1,t0,v1
  a8:	00052880 	sll	a1,a1,0x2
  ac:	03a52821 	addu	a1,sp,a1
  b0:	8ca50000 	lw	a1,0(a1)
  b4:	8c860000 	lw	a2,0(a0)
  b8:	00000000 	sll	zero,zero,0x0
  bc:	00c52826 	xor	a1,a2,a1
  c0:	0005282b 	sltu	a1,zero,a1
  c4:	00451021 	addu	v0,v0,a1
            }
        }
    }
    
    for (x = 0; x < 5; x++){
        for (y = 0; y < 5; y++) {
  c8:	24630001 	addiu	v1,v1,1
  cc:	1469fff5 	bne	v1,t1,a8 <main+0xa4>
  d0:	24840004 	addiu	a0,a0,4
                c[i][j]=sum;
            }
        }
    }
    
    for (x = 0; x < 5; x++){
  d4:	24e70001 	addiu	a3,a3,1
  d8:	14e90008 	bne	a3,t1,100 <main+0xfc>
  dc:	00000000 	sll	zero,zero,0x0
    }

    //printf("%d\n", main_result);

    return main_result;
}
  e0:	08000047 	j	124 <main+0x11c>
  e4:	27bd0068 	addiu	sp,sp,104
    int x, y;
    int sum = 0;

    int main_result = 0;

    for (i = 0; i < 5; i++) {
  e8:	00003821 	addu	a3,zero,zero
  ec:	00001021 	addu	v0,zero,zero
                            {31, 15, 31, 16, 32},
                            {51, 25, 51, 26, 52},
                            {71, 35, 71, 36, 72},
                            {91, 45, 91, 46, 92}};

int main()
  f0:	3c0a0000 	lui	t2,0x0
  f4:	254a0000 	addiu	t2,t2,0
            }
        }
    }
    
    for (x = 0; x < 5; x++){
        for (y = 0; y < 5; y++) {
  f8:	24090005 	addiu	t1,zero,5
                            {31, 15, 31, 16, 32},
                            {51, 25, 51, 26, 52},
                            {71, 35, 71, 36, 72},
                            {91, 45, 91, 46, 92}};

int main()
  fc:	00072080 	sll	a0,a3,0x2
 100:	00071900 	sll	v1,a3,0x4
 104:	00832021 	addu	a0,a0,v1
 108:	01442021 	addu	a0,t2,a0

 // Manually inserted by Fred, Apr 15
 888: 88888888  addiu a0,a0,0xc8

 10c:	00001821 	addu	v1,zero,zero
        }
    }
    
    for (x = 0; x < 5; x++){
        for (y = 0; y < 5; y++) {
            main_result += (output[x][y] != c[x][y]);
 110:	00074080 	sll	t0,a3,0x2
 114:	08000029 	j	a8 <main+0xa4>
 118:	01074021 	addu	t0,t0,a3
    }

    //printf("%d\n", main_result);

    return main_result;
}
 11c:	03e00008 	jr	ra
 120:	00000000 	sll	zero,zero,0x0

Disassembly of section .rodata:

00000000 <a>:
   0:	00000001 	0x1
   4:	00000002 	srl	zero,zero,0x0
   8:	00000003 	sra	zero,zero,0x0
   c:	00000004 	sllv	zero,zero,zero
  10:	00000005 	0x5
  14:	00000006 	srlv	zero,zero,zero
  18:	00000007 	srav	zero,zero,zero
  1c:	00000008 	jr	zero
  20:	00000009 	jalr	zero,zero
  24:	0000000a 	0xa
  28:	0000000b 	0xb
  2c:	0000000c 	syscall
  30:	0000000d 	break
  34:	0000000e 	0xe
  38:	0000000f 	0xf
  3c:	00000010 	mfhi	zero
  40:	00000011 	mthi	zero
  44:	00000012 	mflo	zero
  48:	00000013 	mtlo	zero
  4c:	00000014 	0x14
  50:	00000015 	0x15
  54:	00000016 	0x16
  58:	00000017 	0x17
  5c:	00000018 	mult	zero,zero
  60:	00000019 	multu	zero,zero

00000064 <b>:
  64:	00000001 	0x1
  68:	00000000 	sll	zero,zero,0x0
  6c:	00000001 	0x1
  70:	00000000 	sll	zero,zero,0x0
  74:	00000001 	0x1
  78:	00000001 	0x1
  7c:	00000001 	0x1
  80:	00000001 	0x1
  84:	00000001 	0x1
  88:	00000001 	0x1
  8c:	00000001 	0x1
  90:	00000001 	0x1
  94:	00000001 	0x1
	...
  ac:	00000001 	0x1
  b0:	00000001 	0x1
  b4:	00000001 	0x1
  b8:	00000000 	sll	zero,zero,0x0
  bc:	00000001 	0x1
  c0:	00000000 	sll	zero,zero,0x0
  c4:	00000001 	0x1

000000c8 <output>:
  c8:	0000000b 	0xb
  cc:	00000005 	0x5
  d0:	0000000b 	0xb
  d4:	00000006 	srlv	zero,zero,zero
  d8:	0000000c 	syscall
  dc:	0000001f 	0x1f
  e0:	0000000f 	0xf
  e4:	0000001f 	0x1f
  e8:	00000010 	mfhi	zero
  ec:	00000020 	add	zero,zero,zero
  f0:	00000033 	0x33
  f4:	00000019 	multu	zero,zero
  f8:	00000033 	0x33
  fc:	0000001a 	div	zero,zero,zero
 100:	00000034 	0x34
 104:	00000047 	0x47
 108:	00000023 	negu	zero,zero
 10c:	00000047 	0x47
 110:	00000024 	and	zero,zero,zero
 114:	00000048 	0x48
 118:	0000005b 	0x5b
 11c:	0000002d 	0x2d
 120:	0000005b 	0x5b
 124:	0000002e 	0x2e
 128:	0000005c 	0x5c
