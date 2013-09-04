
mmult.o:     file format elf32-bigmips


Disassembly of section .text:

00000000 <main>:
    int x, y;
    int sum = 0;

    int main_result = 0;

    for (i = 0; i < 5; i++) {
   0:	3c0d0000 	lui	t5,0x0
   4:	25ad0000 	addiu	t5,t5,0
   8:	3c0c0000 	lui	t4,0x0
                            {51, 25, 51, 26, 52},
                            {71, 35, 71, 36, 72},
                            {91, 45, 91, 46, 92}};

int main()
{
   c:	27bdff98 	addiu	sp,sp,-104
    int x, y;
    int sum = 0;

    int main_result = 0;

    for (i = 0; i < 5; i++) {
  10:	25a60014 	addiu	a2,t5,20
  14:	00004021 	addu	t0,zero,zero
  18:	258c0000 	addiu	t4,t4,0
        for (j = 0; j < 5; j++) {
  1c:	240b0005 	addiu	t3,zero,5

START_CCORE
  20:	00084880 	sll	t1,t0,0x2
  24:	00085100 	sll	t2,t0,0x4
                            {31, 15, 31, 16, 32},
                            {51, 25, 51, 26, 52},
                            {71, 35, 71, 36, 72},
                            {91, 45, 91, 46, 92}};

int main()
  28:	012a5021 	addu	t2,t1,t2
  2c:	00003821 	addu	a3,zero,zero
  30:	01aa5021 	addu	t2,t5,t2
    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
                c[i][j]=sum;
  34:	01284821 	addu	t1,t1,t0
  38:	01272821 	addu	a1,t1,a3
                            {31, 15, 31, 16, 32},
                            {51, 25, 51, 26, 52},
                            {71, 35, 71, 36, 72},
                            {91, 45, 91, 46, 92}};

int main()
  3c:	00072080 	sll	a0,a3,0x2
    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
                c[i][j]=sum;
  40:	00052880 	sll	a1,a1,0x2
                            {31, 15, 31, 16, 32},
                            {51, 25, 51, 26, 52},
                            {71, 35, 71, 36, 72},
                            {91, 45, 91, 46, 92}};

int main()
  44:	01401021 	addu	v0,t2,zero
  48:	01842021 	addu	a0,t4,a0
  4c:	00001821 	addu	v1,zero,zero
    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
                c[i][j]=sum;
  50:	03a52821 	addu	a1,sp,a1

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];

// Manually inserted by Fred, Apr. 15
  88: 88888888  addiu a0,a0,0x64
 
  54:	8c4e0000 	lw	t6,0(v0)
  58:	8c8f0000 	lw	t7,0(a0)

// Manually inserted by Fred, Apr. 15
  88: 88888888  subi a0,a0,0x64

                c[i][j]=sum;
  5c:	24420004 	addiu	v0,v0,4

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
  60:	01ee0018 	mult	t7,t6
                c[i][j]=sum;
  64:	24840014 	addiu	a0,a0,20

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
  68:	00007012 	mflo	t6
  6c:	006e1821 	addu	v1,v1,t6
                c[i][j]=sum;
  70:	aca30000 	sw	v1,0(a1)
    int main_result = 0;

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
  74:	14c2fff7 	bne	a2,v0,54 <main+0x54>
  78:	00000000 	sll	zero,zero,0x0
    int sum = 0;

    int main_result = 0;

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
  7c:	24e70001 	addiu	a3,a3,1
  80:	14ebffee 	bne	a3,t3,3c <main+0x3c>
  84:	01272821 	addu	a1,t1,a3
    int x, y;
    int sum = 0;

    int main_result = 0;

    for (i = 0; i < 5; i++) {
  88:	25080001 	addiu	t0,t0,1
  8c:	1507ffe4 	bne	t0,a3,20 <main+0x20>
  90:	24c60014 	addiu	a2,a2,20
  94:	3c0a0000 	lui	t2,0x0
  98:	00003821 	addu	a3,zero,zero
  9c:	00001021 	addu	v0,zero,zero
  a0:	254a0000 	addiu	t2,t2,0
            }
        }
    }
END_CCORE
    
    for (x = 0; x < 5; x++){
        for (y = 0; y < 5; y++) {
  a4:	24090005 	addiu	t1,zero,5
                            {31, 15, 31, 16, 32},
                            {51, 25, 51, 26, 52},
                            {71, 35, 71, 36, 72},
                            {91, 45, 91, 46, 92}};

int main()
  a8:	00074080 	sll	t0,a3,0x2
  ac:	00072100 	sll	a0,a3,0x4
  b0:	01042021 	addu	a0,t0,a0
  b4:	01442021 	addu	a0,t2,a0
  b8:	00001821 	addu	v1,zero,zero
        }
    }
    
    for (x = 0; x < 5; x++){
        for (y = 0; y < 5; y++) {
            main_result += (output[x][y] != c[x][y]);
  bc:	01074021 	addu	t0,t0,a3
  c0:	01032821 	addu	a1,t0,v1
  c4:	00052880 	sll	a1,a1,0x2
  c8:	03a52821 	addu	a1,sp,a1

  // Manually inserted by Fred, Apr. 15
  88: 88888888  addiu a0,a0,0xc8

  cc:	8c860000 	lw	a2,0(a0)

  // Manually inserted by Fred, Apr. 15
  88: 88888888  subi a0,a0,0xc8

  d0:	8ca50000 	lw	a1,0(a1)
            }
        }
    }
    
    for (x = 0; x < 5; x++){
        for (y = 0; y < 5; y++) {
  d4:	24630001 	addiu	v1,v1,1
            main_result += (output[x][y] != c[x][y]);
  d8:	00c52826 	xor	a1,a2,a1
  dc:	0005282b 	sltu	a1,zero,a1
  e0:	00451021 	addu	v0,v0,a1
            }
        }
    }
    
    for (x = 0; x < 5; x++){
        for (y = 0; y < 5; y++) {

  // Manually
  e4:	1469fff6 	bne	v1,t1,c8 <main+0xc0>

  e8:	24840004 	addiu	a0,a0,4
                c[i][j]=sum;
            }
        }
    }
    
    for (x = 0; x < 5; x++){
  ec:	24e70001 	addiu	a3,a3,1

  // Manually
  f0:	14e3ffed 	bne	a3,v1,b0 <main+0xa8>

  f4:	00000000 	sll	zero,zero,0x0
    }

    //printf("%d\n", main_result);

    return main_result;
}
  f8:	03e00008 	jr	ra
  fc:	27bd0068 	addiu	sp,sp,104

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
