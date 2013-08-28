
factorial.o:     file format elf32-bigmips


Disassembly of section .text:

00000000 <main>:

const unsigned int number = 8; // number of iterations
const unsigned int output[] = {1,1,2,6,24,120,720,5040,40320};

int main()
{
   0:	27bdffc8 	addiu	sp,sp,-56
   4:	afbe0034 	sw	s8,52(sp)
   8:	03a0f021 	addu	s8,sp,zero
    unsigned int main_result = 0;
   c:	afc00000 	sw	zero,0(s8)
    unsigned int c[] = {1,1,1,1,1,1,1,1};
  10:	24020001 	addiu	v0,zero,1
  14:	afc2000c 	sw	v0,12(s8)
  18:	24020001 	addiu	v0,zero,1
  1c:	afc20010 	sw	v0,16(s8)
  20:	24020001 	addiu	v0,zero,1
  24:	afc20014 	sw	v0,20(s8)
  28:	24020001 	addiu	v0,zero,1
  2c:	afc20018 	sw	v0,24(s8)
  30:	24020001 	addiu	v0,zero,1
  34:	afc2001c 	sw	v0,28(s8)
  38:	24020001 	addiu	v0,zero,1
  3c:	afc20020 	sw	v0,32(s8)
  40:	24020001 	addiu	v0,zero,1
  44:	afc20024 	sw	v0,36(s8)
  48:	24020001 	addiu	v0,zero,1
  4c:	afc20028 	sw	v0,40(s8)
	unsigned int i, j;
START_CCORE
	for (j=0; j < number; j++) {
  50:	afc00008 	sw	zero,8(s8)
  54:	08000037 	j	dc <main+0xdc>
  58:	00000000 	sll	zero,zero,0x0
		for (i=0; i < j; i++){
  5c:	afc00004 	sw	zero,4(s8)
  60:	0800002d 	j	b4 <main+0xb4>
  64:	00000000 	sll	zero,zero,0x0
			c[j] = c[j] * (i+1);
  68:	8fc20008 	lw	v0,8(s8)
  6c:	00000000 	sll	zero,zero,0x0
  70:	00021080 	sll	v0,v0,0x2
  74:	03c21021 	addu	v0,s8,v0
  78:	8c43000c 	lw	v1,12(v0)
  7c:	8fc20004 	lw	v0,4(s8)
  80:	00000000 	sll	zero,zero,0x0
  84:	24420001 	addiu	v0,v0,1
  88:	00620018 	mult	v1,v0
  8c:	00001812 	mflo	v1
  90:	8fc20008 	lw	v0,8(s8)
  94:	00000000 	sll	zero,zero,0x0
  98:	00021080 	sll	v0,v0,0x2
  9c:	03c21021 	addu	v0,s8,v0
  a0:	ac43000c 	sw	v1,12(v0)
    unsigned int main_result = 0;
    unsigned int c[] = {1,1,1,1,1,1,1,1};
	unsigned int i, j;

	for (j=0; j < number; j++) {
		for (i=0; i < j; i++){
  a4:	8fc20004 	lw	v0,4(s8)
  a8:	00000000 	sll	zero,zero,0x0
  ac:	24420001 	addiu	v0,v0,1
  b0:	afc20004 	sw	v0,4(s8)
  b4:	8fc30004 	lw	v1,4(s8)
  b8:	8fc20008 	lw	v0,8(s8)
  bc:	00000000 	sll	zero,zero,0x0
  c0:	0062102b 	sltu	v0,v1,v0
  c4:	1440ffe8 	bnez	v0,68 <main+0x68>
  c8:	00000000 	sll	zero,zero,0x0
{
    unsigned int main_result = 0;
    unsigned int c[] = {1,1,1,1,1,1,1,1};
	unsigned int i, j;

	for (j=0; j < number; j++) {
  cc:	8fc20008 	lw	v0,8(s8)
  d0:	00000000 	sll	zero,zero,0x0
  d4:	24420001 	addiu	v0,v0,1
  d8:	afc20008 	sw	v0,8(s8)
  dc:	8f820000 	lw	v0,0(gp)
  e0:	8fc30008 	lw	v1,8(s8)
  e4:	00000000 	sll	zero,zero,0x0
  e8:	0062102b 	sltu	v0,v1,v0
  ec:	1440ffdb 	bnez	v0,5c <main+0x5c>
  f0:	00000000 	sll	zero,zero,0x0
		for (i=0; i < j; i++){
			c[j] = c[j] * (i+1);
		}
	}
	
	for (j=0; j < number; j++) {
  f4:	afc00008 	sw	zero,8(s8)
  f8:	08000057 	j	15c <main+0x15c>
  fc:	00000000 	sll	zero,zero,0x0
		main_result += (output[j] != c[j]);
 100:	3c020000 	lui	v0,0x0
 104:	8fc30008 	lw	v1,8(s8)
 108:	00000000 	sll	zero,zero,0x0
 10c:	00031880 	sll	v1,v1,0x2
 110:	24420000 	addiu	v0,v0,0
 114:	00621021 	addu	v0,v1,v0
 118:	8c430000 	lw	v1,0(v0)
 11c:	8fc20008 	lw	v0,8(s8)
 120:	00000000 	sll	zero,zero,0x0
 124:	00021080 	sll	v0,v0,0x2
 128:	03c21021 	addu	v0,s8,v0
 12c:	8c42000c 	lw	v0,12(v0)
 130:	00000000 	sll	zero,zero,0x0
 134:	00621026 	xor	v0,v1,v0
 138:	0002102b 	sltu	v0,zero,v0
 13c:	8fc30000 	lw	v1,0(s8)
 140:	00000000 	sll	zero,zero,0x0
 144:	00621021 	addu	v0,v1,v0
 148:	afc20000 	sw	v0,0(s8)
		for (i=0; i < j; i++){
			c[j] = c[j] * (i+1);
		}
	}
	
	for (j=0; j < number; j++) {
 14c:	8fc20008 	lw	v0,8(s8)
 150:	00000000 	sll	zero,zero,0x0
 154:	24420001 	addiu	v0,v0,1
 158:	afc20008 	sw	v0,8(s8)
 15c:	8f820000 	lw	v0,0(gp)
 160:	8fc30008 	lw	v1,8(s8)
 164:	00000000 	sll	zero,zero,0x0
 168:	0062102b 	sltu	v0,v1,v0
 16c:	1440ffe4 	bnez	v0,100 <main+0x100>
 170:	00000000 	sll	zero,zero,0x0
END_CCORE
		main_result += (output[j] != c[j]);
	}
	
    return main_result;
 174:	8fc20000 	lw	v0,0(s8)
}
 178:	03c0e821 	addu	sp,s8,zero
 17c:	8fbe0034 	lw	s8,52(sp)
 180:	27bd0038 	addiu	sp,sp,56
 184:	03e00008 	jr	ra
 188:	00000000 	sll	zero,zero,0x0

Disassembly of section .rodata:

00000000 <output>:
   0:	00000001 	0x1
   4:	00000001 	0x1
   8:	00000002 	srl	zero,zero,0x0
   c:	00000006 	srlv	zero,zero,zero
  10:	00000018 	mult	zero,zero
  14:	00000078 	0x78
  18:	000002d0 	0x2d0
  1c:	000013b0 	0x13b0
  20:	00009d80 	sll	s3,zero,0x16
