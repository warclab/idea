
fib.o:     file format elf32-bigmips


Disassembly of section .text:

00000000 <main>:
                                    24157817, 39088169, 63245986, 102334155, 165580141, 
                                    267914296, 433494437, 701408733, 1134903170, 1836311903/*, 
                                    2971215073, 512559680, 3483774753, 3996334433, 3185141890*/ }; // warning: this decimal constant is unsigned only in ISO C90

int main ()
{
   0:	27bdffd8 	addiu	sp,sp,-40
   4:	afbe0024 	sw	s8,36(sp)
   8:	03a0f021 	addu	s8,sp,zero
   c:	03a05021 	addu	t2,sp,zero
  10:	01405821 	addu	t3,t2,zero
  /* Notice that we need to declare our variables, and their type */

  int n = 45;
  14:	240a002d 	addiu	t2,zero,45
  18:	afca0010 	sw	t2,16(s8)
  int a = 0;
  1c:	afc00000 	sw	zero,0(s8)
  int b = 1;
  20:	240a0001 	addiu	t2,zero,1
  24:	afca0004 	sw	t2,4(s8)
  int i;
  
  volatile int sum[n];
  28:	8fca0010 	lw	t2,16(s8)
  2c:	00000000 	sll	zero,zero,0x0
  30:	254cffff 	addiu	t4,t2,-1
  34:	afcc0014 	sw	t4,20(s8)
  38:	01406021 	addu	t4,t2,zero
  3c:	01802821 	addu	a1,t4,zero
  40:	00002021 	addu	a0,zero,zero
  44:	000566c2 	srl	t4,a1,0x1b
  48:	00044140 	sll	t0,a0,0x5
  4c:	01884025 	or	t0,t4,t0
  50:	00054940 	sll	t1,a1,0x5
  54:	01402021 	addu	a0,t2,zero
  58:	00801821 	addu	v1,a0,zero
  5c:	00001021 	addu	v0,zero,zero
  60:	000326c2 	srl	a0,v1,0x1b
  64:	00023140 	sll	a2,v0,0x5
  68:	00863025 	or	a2,a0,a2
  6c:	00033940 	sll	a3,v1,0x5
  70:	01401021 	addu	v0,t2,zero
  74:	00021080 	sll	v0,v0,0x2
  78:	24420007 	addiu	v0,v0,7
  7c:	24420007 	addiu	v0,v0,7
  80:	000210c2 	srl	v0,v0,0x3
  84:	000210c0 	sll	v0,v0,0x3
  88:	03a2e823 	subu	sp,sp,v0
  8c:	03a01021 	addu	v0,sp,zero
  90:	24420007 	addiu	v0,v0,7
  94:	000210c2 	srl	v0,v0,0x3
  98:	000210c0 	sll	v0,v0,0x3
  9c:	afc20018 	sw	v0,24(s8)
  
  int main_result = 0;
  a0:	afc0000c 	sw	zero,12(s8)
START_CCORE    
    for ( i = 0; i < n; i++)			
  a4:	afc00008 	sw	zero,8(s8)
  a8:	08000045 	j	114 <main+0x114>
  ac:	00000000 	sll	zero,zero,0x0
    {							 
        sum[i] = a + b;
  b0:	8fc30000 	lw	v1,0(s8)
  b4:	8fc20004 	lw	v0,4(s8)
  b8:	00000000 	sll	zero,zero,0x0
  bc:	00621821 	addu	v1,v1,v0
  c0:	8fc40018 	lw	a0,24(s8)
  c4:	8fc20008 	lw	v0,8(s8)
  c8:	00000000 	sll	zero,zero,0x0
  cc:	00021080 	sll	v0,v0,0x2
  d0:	00821021 	addu	v0,a0,v0
  d4:	ac430000 	sw	v1,0(v0)
        a = b;
  d8:	8fc20004 	lw	v0,4(s8)
  dc:	00000000 	sll	zero,zero,0x0
  e0:	afc20000 	sw	v0,0(s8)
        b = sum[i];
  e4:	8fc30018 	lw	v1,24(s8)
  e8:	8fc20008 	lw	v0,8(s8)
  ec:	00000000 	sll	zero,zero,0x0
  f0:	00021080 	sll	v0,v0,0x2
  f4:	00621021 	addu	v0,v1,v0
  f8:	8c420000 	lw	v0,0(v0)
  fc:	00000000 	sll	zero,zero,0x0
 100:	afc20004 	sw	v0,4(s8)
  
  volatile int sum[n];
  
  int main_result = 0;
    
    for ( i = 0; i < n; i++)			
 104:	8fc20008 	lw	v0,8(s8)
 108:	00000000 	sll	zero,zero,0x0
 10c:	24420001 	addiu	v0,v0,1
 110:	afc20008 	sw	v0,8(s8)
 114:	8fc30008 	lw	v1,8(s8)
 118:	8fc20010 	lw	v0,16(s8)
 11c:	00000000 	sll	zero,zero,0x0
 120:	0062102a 	slt	v0,v1,v0
 124:	1440ffe2 	bnez	v0,b0 <main+0xb0>
 128:	00000000 	sll	zero,zero,0x0
        sum[i] = a + b;
        a = b;
        b = sum[i];
    }
 END_CCORE
    
    for (i = 0; i < n; i++){
 12c:	afc00008 	sw	zero,8(s8)
 130:	08000066 	j	198 <main+0x198>
 134:	00000000 	sll	zero,zero,0x0
        main_result += (output[i] != sum[i]);
 138:	3c020000 	lui	v0,0x0
 13c:	8fc30008 	lw	v1,8(s8)
 140:	00000000 	sll	zero,zero,0x0
 144:	00031880 	sll	v1,v1,0x2
 148:	24420000 	addiu	v0,v0,0
 14c:	00621021 	addu	v0,v1,v0
 150:	8c430000 	lw	v1,0(v0)
 154:	8fc40018 	lw	a0,24(s8)
 158:	8fc20008 	lw	v0,8(s8)
 15c:	00000000 	sll	zero,zero,0x0
 160:	00021080 	sll	v0,v0,0x2
 164:	00821021 	addu	v0,a0,v0
 168:	8c420000 	lw	v0,0(v0)
 16c:	00000000 	sll	zero,zero,0x0
 170:	00621026 	xor	v0,v1,v0
 174:	0002102b 	sltu	v0,zero,v0
 178:	8fc3000c 	lw	v1,12(s8)
 17c:	00000000 	sll	zero,zero,0x0
 180:	00621021 	addu	v0,v1,v0
 184:	afc2000c 	sw	v0,12(s8)
        sum[i] = a + b;
        a = b;
        b = sum[i];
    }
    
    for (i = 0; i < n; i++){
 188:	8fc20008 	lw	v0,8(s8)
 18c:	00000000 	sll	zero,zero,0x0
 190:	24420001 	addiu	v0,v0,1
 194:	afc20008 	sw	v0,8(s8)
 198:	8fc30008 	lw	v1,8(s8)
 19c:	8fc20010 	lw	v0,16(s8)
 1a0:	00000000 	sll	zero,zero,0x0
 1a4:	0062102a 	slt	v0,v1,v0
 1a8:	1440ffe3 	bnez	v0,138 <main+0x138>
 1ac:	00000000 	sll	zero,zero,0x0
        main_result += (output[i] != sum[i]);
        //printf("%u, ", sum[i]);
    }
        //printf ("%d\n", main_result);
    
  return main_result;
 1b0:	8fc2000c 	lw	v0,12(s8)
 1b4:	0160e821 	addu	sp,t3,zero
}
 1b8:	03c0e821 	addu	sp,s8,zero
 1bc:	8fbe0024 	lw	s8,36(sp)
 1c0:	27bd0028 	addiu	sp,sp,40
 1c4:	03e00008 	jr	ra
 1c8:	00000000 	sll	zero,zero,0x0

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
