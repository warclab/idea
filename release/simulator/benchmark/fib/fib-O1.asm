
fib.o:     file format elf32-bigmips


Disassembly of section .text:

00000000 <main>:
                                    24157817, 39088169, 63245986, 102334155, 165580141, 
                                    267914296, 433494437, 701408733, 1134903170, 1836311903/*, 
                                    2971215073, 512559680, 3483774753, 3996334433, 3185141890*/ }; // warning: this decimal constant is unsigned only in ISO C90

int main ()
{
   0:	27bdffe8 	addiu	sp,sp,-24
   4:	afbe0014 	sw	s8,20(sp)
   8:	03a0f021 	addu	s8,sp,zero
  int n = 45;
  int a = 0;
  int b = 1;
  int i;
  
  volatile int sum[n];
   c:	27bdff40 	addiu	sp,sp,-192
  10:	03a02821 	addu	a1,sp,zero
  
  int main_result = 0;
    
    for ( i = 0; i < n; i++)			
  14:	00001021 	addu	v0,zero,zero
{
  /* Notice that we need to declare our variables, and their type */

  int n = 45;
  int a = 0;
  int b = 1;
  18:	24040001 	addiu	a0,zero,1
int main ()
{
  /* Notice that we need to declare our variables, and their type */

  int n = 45;
  int a = 0;
  1c:	00001821 	addu	v1,zero,zero
  
  volatile int sum[n];
  
  int main_result = 0;
    
    for ( i = 0; i < n; i++)			
  20:	0800000b 	j	2c <main+0x2c>
  24:	2407002d 	addiu	a3,zero,45
    {							 
        sum[i] = a + b;
        a = b;
        b = sum[i];
START_CCORE
  28:	00c02021 	addu	a0,a2,zero
  
  int main_result = 0;
    
    for ( i = 0; i < n; i++)			
    {							 
        sum[i] = a + b;
  2c:	00833021 	addu	a2,a0,v1
  30:	00021880 	sll	v1,v0,0x2
  34:	00a31821 	addu	v1,a1,v1
  38:	ac660000 	sw	a2,0(v1)
        a = b;
        b = sum[i];
  3c:	8c660000 	lw	a2,0(v1)
  
  volatile int sum[n];
  
  int main_result = 0;
    
    for ( i = 0; i < n; i++)			
  40:	24420001 	addiu	v0,v0,1
  44:	1447fff8 	bne	v0,a3,28 <main+0x28>
  48:	00801821 	addu	v1,a0,zero
  4c:	3c040000 	lui	a0,0x0
  50:	24840000 	addiu	a0,a0,0
  54:	00001021 	addu	v0,zero,zero
  58:	00001821 	addu	v1,zero,zero
        sum[i] = a + b;
        a = b;
        b = sum[i];
    }
END_CCORE    
    for (i = 0; i < n; i++){
  5c:	2408002d 	addiu	t0,zero,45
        main_result += (output[i] != sum[i]);
  60:	00033080 	sll	a2,v1,0x2
  64:	00a63021 	addu	a2,a1,a2
  68:	8cc60000 	lw	a2,0(a2)
  6c:	8c870000 	lw	a3,0(a0)
  70:	00000000 	sll	zero,zero,0x0
  74:	00e63026 	xor	a2,a3,a2
  78:	0006302b 	sltu	a2,zero,a2
  7c:	00461021 	addu	v0,v0,a2
        sum[i] = a + b;
        a = b;
        b = sum[i];
    }
    
    for (i = 0; i < n; i++){
  80:	24630001 	addiu	v1,v1,1
  84:	1468fff6 	bne	v1,t0,60 <main+0x60>
  88:	24840004 	addiu	a0,a0,4
        //printf("%u, ", sum[i]);
    }
        //printf ("%d\n", main_result);
    
  return main_result;
}
  8c:	03c0e821 	addu	sp,s8,zero
  90:	8fbe0014 	lw	s8,20(sp)
  94:	03e00008 	jr	ra
  98:	27bd0018 	addiu	sp,sp,24

Disassembly of section .rodata:

00000000 <output>:
   0:	00000001 	0x1
   4:	00000002 	srl	zero,zero,0x0
   8:	00000003 	sra	zero,zero,0x0
   c:	00000005 	0x5
  10:	00000008 	jr	zero
  14:	0000000d 	break
  18:	00000015 	0x15
  1c:	00000022 	neg	zero,zero
  20:	00000037 	0x37
  24:	00000059 	0x59
  28:	00000090 	0x90
  2c:	000000e9 	0xe9
  30:	00000179 	0x179
  34:	00000262 	0x262
  38:	000003db 	0x3db
  3c:	0000063d 	0x63d
  40:	00000a18 	0xa18
  44:	00001055 	0x1055
  48:	00001a6d 	0x1a6d
  4c:	00002ac2 	srl	a1,zero,0xb
  50:	0000452f 	0x452f
  54:	00006ff1 	0x6ff1
  58:	0000b520 	0xb520
  5c:	00012511 	0x12511
  60:	0001da31 	0x1da31
  64:	0002ff42 	srl	ra,v0,0x1d
  68:	0004d973 	0x4d973
  6c:	0007d8b5 	0x7d8b5
  70:	000cb228 	0xcb228
  74:	00148add 	0x148add
  78:	00213d05 	0x213d05
  7c:	0035c7e2 	0x35c7e2
  80:	005704e7 	0x5704e7
  84:	008cccc9 	0x8cccc9
  88:	00e3d1b0 	0xe3d1b0
  8c:	01709e79 	0x1709e79
  90:	02547029 	0x2547029
  94:	03c50ea2 	0x3c50ea2
  98:	06197ecb 	0x6197ecb
  9c:	09de8d6d 	j	77a35b4 <output+0x77a35b4>
  a0:	0ff80c38 	jal	fe030e0 <output+0xfe030e0>
  a4:	19d699a5 	0x19d699a5
  a8:	29cea5dd 	slti	t6,t6,-23075
  ac:	43a53f82 	c0	0x1a53f82
  b0:	6d73e55f 	0x6d73e55f
