
mmult.o:     file format elf32-bigmips


Disassembly of section .text:

00000000 <main>:
                            {51, 25, 51, 26, 52},
                            {71, 35, 71, 36, 72},
                            {91, 45, 91, 46, 92}};

int main()
{
   0:	27bdff78 	addiu	sp,sp,-136
   4:	afbe0084 	sw	s8,132(sp)
   8:	03a0f021 	addu	s8,sp,zero
    int volatile c[5][5]; 
    int i, j, k;
    int x, y;
    int sum = 0;
   c:	afc00014 	sw	zero,20(s8)

    int main_result = 0;
  10:	afc00018 	sw	zero,24(s8)

    for (i = 0; i < 5; i++) {
  14:	afc00000 	sw	zero,0(s8)

  // Manually
  18:	08000053 	j	150 <main+0x14c>

  1c:	00000000 	sll	zero,zero,0x0
        for (j = 0; j < 5; j++) {
START_CCORE
  20:	afc00004 	sw	zero,4(s8)

  // Manually
  24:	0800004a 	j	12c <main+0x128>

  28:	00000000 	sll	zero,zero,0x0
            sum = 0;
  2c:	afc00014 	sw	zero,20(s8)
            for (k = 0; k < 5 ; k++) {
  30:	afc00008 	sw	zero,8(s8)

  // Manually
  34:	08000041 	j	108 <main+0x104>

  38:	00000000 	sll	zero,zero,0x0
                sum = sum + a[i][k] * b[k][j];
  3c:	3c040000 	lui	a0,0x0
  40:	8fc30000 	lw	v1,0(s8)
  44:	00000000 	sll	zero,zero,0x0
  48:	00601021 	addu	v0,v1,zero
  4c:	00021080 	sll	v0,v0,0x2
  50:	00431021 	addu	v0,v0,v1
  54:	8fc30008 	lw	v1,8(s8)
  58:	00000000 	sll	zero,zero,0x0
  5c:	00431021 	addu	v0,v0,v1
  60:	00021880 	sll	v1,v0,0x2
  64:	24820000 	addiu	v0,a0,0
  68:	00621021 	addu	v0,v1,v0
  6c:	8c450000 	lw	a1,0(v0)
  70:	3c040000 	lui	a0,0x0
  74:	8fc30008 	lw	v1,8(s8)
  78:	00000000 	sll	zero,zero,0x0
  7c:	00601021 	addu	v0,v1,zero
  80:	00021080 	sll	v0,v0,0x2
  84:	00431021 	addu	v0,v0,v1
  88:	8fc30004 	lw	v1,4(s8)
  8c:	00000000 	sll	zero,zero,0x0
  90:	00431021 	addu	v0,v0,v1
  94:	00021880 	sll	v1,v0,0x2
  98:	24820000 	addiu	v0,a0,0
  9c:	00621021 	addu	v0,v1,v0

// Manually inserted by Fred, Apr. 15
  88: 88888888  addiu v0,v0,0x64

  a0:	8c420000 	lw	v0,0(v0)
  a4:	00000000 	sll	zero,zero,0x0
  a8:	00a20018 	mult	a1,v0
  ac:	00001812 	mflo	v1
  b0:	8fc20014 	lw	v0,20(s8)
  b4:	00000000 	sll	zero,zero,0x0
  b8:	00431021 	addu	v0,v0,v1
  bc:	afc20014 	sw	v0,20(s8)
                c[i][j]=sum;
  c0:	8fc30000 	lw	v1,0(s8)
  c4:	00000000 	sll	zero,zero,0x0
  c8:	00601021 	addu	v0,v1,zero
  cc:	00021080 	sll	v0,v0,0x2
  d0:	00431021 	addu	v0,v0,v1
  d4:	8fc30004 	lw	v1,4(s8)
  d8:	00000000 	sll	zero,zero,0x0
  dc:	00431021 	addu	v0,v0,v1
  e0:	00021080 	sll	v0,v0,0x2
  e4:	03c21021 	addu	v0,s8,v0
  e8:	8fc30014 	lw	v1,20(s8)
  ec:	00000000 	sll	zero,zero,0x0
  f0:	ac43001c 	sw	v1,28(v0)
    int main_result = 0;

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
  f4:	8fc20008 	lw	v0,8(s8)
  f8:	00000000 	sll	zero,zero,0x0
  fc:	24420001 	addiu	v0,v0,1
 100:	afc20008 	sw	v0,8(s8)
 104:	8fc20008 	lw	v0,8(s8)
 108:	00000000 	sll	zero,zero,0x0
 10c:	28420005 	slti	v0,v0,5
 110:	1440ffca 	bnez	v0,3c <main+0x3c>
 114:	00000000 	sll	zero,zero,0x0
    int sum = 0;

    int main_result = 0;

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
 118:	8fc20004 	lw	v0,4(s8)
 11c:	00000000 	sll	zero,zero,0x0
 120:	24420001 	addiu	v0,v0,1
 124:	afc20004 	sw	v0,4(s8)
 128:	8fc20004 	lw	v0,4(s8)
 12c:	00000000 	sll	zero,zero,0x0
 130:	28420005 	slti	v0,v0,5
 134:	1440ffbd 	bnez	v0,2c <main+0x2c>
 138:	00000000 	sll	zero,zero,0x0
    int x, y;
    int sum = 0;

    int main_result = 0;

    for (i = 0; i < 5; i++) {
 13c:	8fc20000 	lw	v0,0(s8)
 140:	00000000 	sll	zero,zero,0x0
 144:	24420001 	addiu	v0,v0,1
 148:	afc20000 	sw	v0,0(s8)
 14c:	8fc20000 	lw	v0,0(s8)
 150:	00000000 	sll	zero,zero,0x0
 154:	28420005 	slti	v0,v0,5
 158:	1440ffb1 	bnez	v0,20 <main+0x20>
 15c:	00000000 	sll	zero,zero,0x0
                c[i][j]=sum;
            }
        }
    }
    
    for (x = 0; x < 5; x++){
 160:	afc0000c 	sw	zero,12(s8)

 // Manually +4 +8
 164:	0800008a 	j	234 <main+0x228>

 168:	00000000 	sll	zero,zero,0x0
        for (y = 0; y < 5; y++) {
 16c:	afc00010 	sw	zero,16(s8)

 // Manually +4 +8
 170:	08000081 	j	210 <main+0x204>

 174:	00000000 	sll	zero,zero,0x0
END_CCORE
            main_result += (output[x][y] != c[x][y]);
 178:	3c040000 	lui	a0,0x0
 17c:	8fc3000c 	lw	v1,12(s8)
 180:	00000000 	sll	zero,zero,0x0
 184:	00601021 	addu	v0,v1,zero
 188:	00021080 	sll	v0,v0,0x2
 18c:	00431021 	addu	v0,v0,v1
 190:	8fc30010 	lw	v1,16(s8)
 194:	00000000 	sll	zero,zero,0x0
 198:	00431021 	addu	v0,v0,v1
 19c:	00021880 	sll	v1,v0,0x2
 1a0:	24820000 	addiu	v0,a0,0
 1a4:	00621021 	addu	v0,v1,v0

 // Manually inserted by Fred, Apr. 15
 888: 88888888  addiu v0,v0,0xc8

 1a8:	8c440000 	lw	a0,0(v0)
 
// Manually inserted by Fred, Apr. 15
 888: 88888888  subi v0,v0,0xc8

 1ac:	8fc3000c 	lw	v1,12(s8)
 1b0:	00000000 	sll	zero,zero,0x0
 1b4:	00601021 	addu	v0,v1,zero
 1b8:	00021080 	sll	v0,v0,0x2
 1bc:	00431021 	addu	v0,v0,v1
 1c0:	8fc30010 	lw	v1,16(s8)
 1c4:	00000000 	sll	zero,zero,0x0
 1c8:	00431021 	addu	v0,v0,v1
 1cc:	00021080 	sll	v0,v0,0x2
 1d0:	03c21021 	addu	v0,s8,v0
 1d4:	8c42001c 	lw	v0,28(v0)
 1d8:	00000000 	sll	zero,zero,0x0
 1dc:	00821026 	xor	v0,a0,v0
 1e0:	0002102b 	sltu	v0,zero,v0
 1e4:	8fc30018 	lw	v1,24(s8)
 1e8:	00000000 	sll	zero,zero,0x0
 1ec:	00621021 	addu	v0,v1,v0
 1f0:	afc20018 	sw	v0,24(s8)
            }
        }
    }
    
    for (x = 0; x < 5; x++){
        for (y = 0; y < 5; y++) {
 1f4:	8fc20010 	lw	v0,16(s8)
 1f8:	00000000 	sll	zero,zero,0x0
 1fc:	24420001 	addiu	v0,v0,1
 200:	afc20010 	sw	v0,16(s8)
 204:	8fc20010 	lw	v0,16(s8)
 208:	00000000 	sll	zero,zero,0x0
 20c:	28420005 	slti	v0,v0,5

 // Manually
 210:	1440ffd9 	bnez	v0,17c <main+0x178>

 214:	00000000 	sll	zero,zero,0x0
                c[i][j]=sum;
            }
        }
    }
    
    for (x = 0; x < 5; x++){
 218:	8fc2000c 	lw	v0,12(s8)
 21c:	00000000 	sll	zero,zero,0x0
 220:	24420001 	addiu	v0,v0,1
 224:	afc2000c 	sw	v0,12(s8)
 228:	8fc2000c 	lw	v0,12(s8)
 22c:	00000000 	sll	zero,zero,0x0
 230:	28420005 	slti	v0,v0,5

  // Manually
 234:	1440ffcd 	bnez	v0,170 <main+0x16c>

 238:	00000000 	sll	zero,zero,0x0
        }
    }

    //printf("%d\n", main_result);

    return main_result;
 23c:	8fc20018 	lw	v0,24(s8)
}
 240:	03c0e821 	addu	sp,s8,zero
 244:	8fbe0084 	lw	s8,132(sp)
 248:	27bd0088 	addiu	sp,sp,136
 24c:	03e00008 	jr	ra
 250:	00000000 	sll	zero,zero,0x0

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
