
factorial.o:     file format elf32-bigmips


Disassembly of section .text:

00000000 <main>:

const unsigned int number = 8; // number of iterations
const unsigned int output[] = {1,1,2,6,24,120,720,5040,40320};

int main()
{
   0:	27bdffe0 	addiu	sp,sp,-32
    unsigned int main_result = 0;
    unsigned int c[] = {1,1,1,1,1,1,1,1};
   4:	24020001 	addiu	v0,zero,1
   8:	afa20000 	sw	v0,0(sp)
   c:	afa20004 	sw	v0,4(sp)
  10:	afa20008 	sw	v0,8(sp)
  14:	afa2000c 	sw	v0,12(sp)
  18:	afa20010 	sw	v0,16(sp)
  1c:	afa20014 	sw	v0,20(sp)
  20:	afa20018 	sw	v0,24(sp)
  24:	afa2001c 	sw	v0,28(sp)
  28:	03a02821 	addu	a1,sp,zero
  2c:	24060001 	addiu	a2,zero,1
  30:	00002021 	addu	a0,zero,zero
	unsigned int i, j;

	for (j=0; j < number; j++) {
		for (i=0; i < j; i++){
  34:	1080000b 	beqz	a0,64 <main+0x64>
  38:	00001021 	addu	v0,zero,zero
// iteration 8
START_CCORE
const unsigned int number = 8; // number of iterations
const unsigned int output[] = {1,1,2,6,24,120,720,5040,40320};

int main()
  3c:	8ca70000 	lw	a3,0(a1)
    unsigned int c[] = {1,1,1,1,1,1,1,1};
	unsigned int i, j;

	for (j=0; j < number; j++) {
		for (i=0; i < j; i++){
			c[j] = c[j] * (i+1);
  40:	24420001 	addiu	v0,v0,1
  44:	00e20018 	mult	a3,v0
    unsigned int main_result = 0;
    unsigned int c[] = {1,1,1,1,1,1,1,1};
	unsigned int i, j;

	for (j=0; j < number; j++) {
		for (i=0; i < j; i++){
  48:	0044182b 	sltu	v1,v0,a0
			c[j] = c[j] * (i+1);
  4c:	00003812 	mflo	a3
    unsigned int main_result = 0;
    unsigned int c[] = {1,1,1,1,1,1,1,1};
	unsigned int i, j;

	for (j=0; j < number; j++) {
		for (i=0; i < j; i++){
  50:	1460fffc 	bnez	v1,44 <main+0x44>
  54:	24420001 	addiu	v0,v0,1
{
    unsigned int main_result = 0;
    unsigned int c[] = {1,1,1,1,1,1,1,1};
	unsigned int i, j;

	for (j=0; j < number; j++) {
  58:	2cc20008 	sltiu	v0,a2,8
  5c:	10400005 	beqz	v0,74 <main+0x74>
  60:	aca70000 	sw	a3,0(a1)
  64:	24840001 	addiu	a0,a0,1
  68:	24c60001 	addiu	a2,a2,1
  6c:	0800000d 	j	34 <main+0x34>
  70:	24a50004 	addiu	a1,a1,4
			c[j] = c[j] * (i+1);
		}
	}
END_CCORE	
	for (j=0; j < number; j++) {
		main_result += (output[j] != c[j]);
  74:	8fa40000 	lw	a0,0(sp)
  78:	8fa30004 	lw	v1,4(sp)
  7c:	38840001 	xori	a0,a0,0x1
  80:	38630001 	xori	v1,v1,0x1
  84:	0003182b 	sltu	v1,zero,v1
  88:	8fa20008 	lw	v0,8(sp)
  8c:	0004202b 	sltu	a0,zero,a0
  90:	00832021 	addu	a0,a0,v1
  94:	8fa3000c 	lw	v1,12(sp)
  98:	38420002 	xori	v0,v0,0x2
  9c:	0002102b 	sltu	v0,zero,v0
  a0:	38630006 	xori	v1,v1,0x6
  a4:	00822021 	addu	a0,a0,v0
  a8:	0003182b 	sltu	v1,zero,v1
  ac:	8fa20010 	lw	v0,16(sp)
  b0:	00832021 	addu	a0,a0,v1
  b4:	8fa30014 	lw	v1,20(sp)
  b8:	38420018 	xori	v0,v0,0x18
  bc:	0002102b 	sltu	v0,zero,v0
  c0:	38630078 	xori	v1,v1,0x78
  c4:	00822021 	addu	a0,a0,v0
  c8:	0003182b 	sltu	v1,zero,v1
  cc:	8fa20018 	lw	v0,24(sp)
  d0:	00832021 	addu	a0,a0,v1
  d4:	8fa3001c 	lw	v1,28(sp)
  d8:	384202d0 	xori	v0,v0,0x2d0
  dc:	0002102b 	sltu	v0,zero,v0
  e0:	386313b0 	xori	v1,v1,0x13b0
  e4:	00821021 	addu	v0,a0,v0
  e8:	0003182b 	sltu	v1,zero,v1
	}
	
    return main_result;
}
  ec:	00621021 	addu	v0,v1,v0
  f0:	03e00008 	jr	ra
  f4:	27bd0020 	addiu	sp,sp,32

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
