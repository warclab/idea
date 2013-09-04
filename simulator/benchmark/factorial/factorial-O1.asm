
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
  28:	03a02021 	addu	a0,sp,zero
  2c:	24050001 	addiu	a1,zero,1
  30:	0800001a 	j	68 <main+0x68>
  34:	00001821 	addu	v1,zero,zero
	unsigned int i, j;

	for (j=0; j < number; j++) {
		for (i=0; i < j; i++){
			c[j] = c[j] * (i+1);
START_CCORE
  38:	24420001 	addiu	v0,v0,1
  3c:	00e20018 	mult	a3,v0
  40:	00003812 	mflo	a3
    unsigned int main_result = 0;
    unsigned int c[] = {1,1,1,1,1,1,1,1};
	unsigned int i, j;

	for (j=0; j < number; j++) {
		for (i=0; i < j; i++){
  44:	0043402b 	sltu	t0,v0,v1
  48:	1500fffc 	bnez	t0,3c <main+0x3c>
  4c:	24420001 	addiu	v0,v0,1
{
    unsigned int main_result = 0;
    unsigned int c[] = {1,1,1,1,1,1,1,1};
	unsigned int i, j;

	for (j=0; j < number; j++) {
  50:	2ca20008 	sltiu	v0,a1,8
  54:	10400009 	beqz	v0,7c <main+0x7c>
  58:	acc70000 	sw	a3,0(a2)
  5c:	24630001 	addiu	v1,v1,1
  60:	24a50001 	addiu	a1,a1,1
  64:	24840004 	addiu	a0,a0,4
		for (i=0; i < j; i++){
  68:	1060fffc 	beqz	v1,5c <main+0x5c>
  6c:	00001021 	addu	v0,zero,zero
// iteration 8

const unsigned int number = 8; // number of iterations
const unsigned int output[] = {1,1,2,6,24,120,720,5040,40320};

int main()
  70:	8c870000 	lw	a3,0(a0)
  74:	0800000e 	j	38 <main+0x38>
  78:	00803021 	addu	a2,a0,zero
{
    unsigned int main_result = 0;
    unsigned int c[] = {1,1,1,1,1,1,1,1};
	unsigned int i, j;

	for (j=0; j < number; j++) {
  7c:	00001821 	addu	v1,zero,zero
  80:	00001021 	addu	v0,zero,zero
// iteration 8

const unsigned int number = 8; // number of iterations
const unsigned int output[] = {1,1,2,6,24,120,720,5040,40320};

int main()
  84:	3c070000 	lui	a3,0x0
  88:	24e70000 	addiu	a3,a3,0
		for (i=0; i < j; i++){
			c[j] = c[j] * (i+1);
		}
	}
	
	for (j=0; j < number; j++) {
  8c:	24060020 	addiu	a2,zero,32
// iteration 8

const unsigned int number = 8; // number of iterations
const unsigned int output[] = {1,1,2,6,24,120,720,5040,40320};

int main()
  90:	00e32821 	addu	a1,a3,v1
  94:	03a32021 	addu	a0,sp,v1
			c[j] = c[j] * (i+1);
		}
	}
END_CCORE	
	for (j=0; j < number; j++) {
		main_result += (output[j] != c[j]);
  98:	8ca50000 	lw	a1,0(a1)
  9c:	8c840000 	lw	a0,0(a0)
  a0:	00000000 	sll	zero,zero,0x0
  a4:	00a42026 	xor	a0,a1,a0
  a8:	0004202b 	sltu	a0,zero,a0
  ac:	24630004 	addiu	v1,v1,4
		for (i=0; i < j; i++){
			c[j] = c[j] * (i+1);
		}
	}
	
	for (j=0; j < number; j++) {
  b0:	1466fff7 	bne	v1,a2,90 <main+0x90>
  b4:	00441021 	addu	v0,v0,a0
		main_result += (output[j] != c[j]);
	}
	
    return main_result;
}
  b8:	03e00008 	jr	ra
  bc:	27bd0020 	addiu	sp,sp,32

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
