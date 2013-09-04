
bubble.o:     file format elf32-bigmips


Disassembly of section .text:

00000000 <main>:
int main()
{
  unsigned int n = 50;
  unsigned int i, c, d, sum, swap;
  unsigned int main_result = 0;
  unsigned int array[50] = {36, 38, 41, 24, 47, 50, 51, 32, 15, 65,
   0:	3c020000 	lui	v0,0x0
                        8, 8, 8, 9, 9, 11, 11, 12, 15, 15, 
                        15, 17, 17, 18, 19, 20, 21, 21, 21, 21, 
                        22, 22, 22, 24, 24, 25, 25, 31, 32, 35, 
                        36, 38, 41, 45, 47, 50, 51, 54, 55, 65}; 
int main()
{
   4:	27bdff38 	addiu	sp,sp,-200
  unsigned int n = 50;
  unsigned int i, c, d, sum, swap;
  unsigned int main_result = 0;
  unsigned int array[50] = {36, 38, 41, 24, 47, 50, 51, 32, 15, 65,
   8:	244200c8 	addiu	v0,v0,200
   c:	03a01821 	addu	v1,sp,zero
  10:	244400c0 	addiu	a0,v0,192
  14:	8c480000 	lw	t0,0(v0)
  18:	8c470004 	lw	a3,4(v0)
  1c:	8c460008 	lw	a2,8(v0)
  20:	8c45000c 	lw	a1,12(v0)
  24:	24420010 	addiu	v0,v0,16
  28:	ac680000 	sw	t0,0(v1)
  2c:	ac670004 	sw	a3,4(v1)
  30:	ac660008 	sw	a2,8(v1)
  34:	ac65000c 	sw	a1,12(v1)
  38:	1444fff6 	bne	v0,a0,14 <main+0x14>
  3c:	24630010 	addiu	v1,v1,16
  40:	8c440000 	lw	a0,0(v0)
  44:	8c420004 	lw	v0,4(v0)
  48:	ac640000 	sw	a0,0(v1)
  4c:	ac620004 	sw	v0,4(v1)
const unsigned int output[50] = { 0, 0, 1, 1, 2, 2, 3, 4, 5, 6, 
                        8, 8, 8, 9, 9, 11, 11, 12, 15, 15, 
                        15, 17, 17, 18, 19, 20, 21, 21, 21, 21, 
                        22, 22, 22, 24, 24, 25, 25, 31, 32, 35, 
                        36, 38, 41, 45, 47, 50, 51, 54, 55, 65}; 
int main()
  50:	03a03821 	addu	a3,sp,zero
  54:	27a600c4 	addiu	a2,sp,196
                    15, 21, 17, 18, 19, 20, 17, 21, 21, 21,
                    22, 54, 22, 45, 24, 25, 25, 31, 22, 35,
                    2, 0, 1, 1, 0, 2, 3, 4, 5, 6,
                    8, 8, 8, 9, 9, 11, 55, 12, 15, 11};

    for (c = 0 ; c < ( n - 1 ); c++)
START_CCORE
  58:	03a01021 	addu	v0,sp,zero
      {
        for (d = 0 ; d < n - c - 1; d++)
  5c:	10c2000c 	beq	a2,v0,90 <main+0x90>
  60:	00000000 	sll	zero,zero,0x0
        {
          if (array[d] > array[d+1]) /* For decreasing order use < */
  64:	8c430000 	lw	v1,0(v0)
  68:	8c440004 	lw	a0,4(v0)
  6c:	00000000 	sll	zero,zero,0x0
  70:	0083282b 	sltu	a1,a0,v1
  74:	10a00003 	beqz	a1,84 <main+0x84>
  78:	00000000 	sll	zero,zero,0x0
          {
            swap       = array[d];
            array[d]   = array[d+1];
  7c:	ac440000 	sw	a0,0(v0)
            array[d+1] = swap;
  80:	ac430004 	sw	v1,4(v0)
  84:	24420004 	addiu	v0,v0,4
                    2, 0, 1, 1, 0, 2, 3, 4, 5, 6,
                    8, 8, 8, 9, 9, 11, 55, 12, 15, 11};

    for (c = 0 ; c < ( n - 1 ); c++)
      {
        for (d = 0 ; d < n - c - 1; d++)
  88:	14c2fff6 	bne	a2,v0,64 <main+0x64>
  8c:	00000000 	sll	zero,zero,0x0
  90:	24c6fffc 	addiu	a2,a2,-4
                    15, 21, 17, 18, 19, 20, 17, 21, 21, 21,
                    22, 54, 22, 45, 24, 25, 25, 31, 22, 35,
                    2, 0, 1, 1, 0, 2, 3, 4, 5, 6,
                    8, 8, 8, 9, 9, 11, 55, 12, 15, 11};

    for (c = 0 ; c < ( n - 1 ); c++)
  94:	14c7fff0 	bne	a2,a3,58 <main+0x58>
  98:	00001821 	addu	v1,zero,zero
  9c:	3c070000 	lui	a3,0x0
  a0:	00001021 	addu	v0,zero,zero
  a4:	24e70000 	addiu	a3,a3,0
            array[d+1] = swap;
          }
        }
      }

END_CCORE

    for (i = 0; i < 50; i++){
  a8:	240600c8 	addiu	a2,zero,200
const unsigned int output[50] = { 0, 0, 1, 1, 2, 2, 3, 4, 5, 6, 
                        8, 8, 8, 9, 9, 11, 11, 12, 15, 15, 
                        15, 17, 17, 18, 19, 20, 21, 21, 21, 21, 
                        22, 22, 22, 24, 24, 25, 25, 31, 32, 35, 
                        36, 38, 41, 45, 47, 50, 51, 54, 55, 65}; 
int main()
  ac:	00e32821 	addu	a1,a3,v1
  b0:	03a32021 	addu	a0,sp,v1
          }
        }
      }

    for (i = 0; i < 50; i++){
        main_result += (output[i] != array[i]);
  b4:	8ca50000 	lw	a1,0(a1)
  b8:	8c840000 	lw	a0,0(a0)
  bc:	24630004 	addiu	v1,v1,4
  c0:	00a42026 	xor	a0,a1,a0
  c4:	0004202b 	sltu	a0,zero,a0
            array[d+1] = swap;
          }
        }
      }

    for (i = 0; i < 50; i++){
  c8:	1466fff8 	bne	v1,a2,ac <main+0xac>
  cc:	00441021 	addu	v0,v0,a0
        main_result += (output[i] != array[i]);
    }
        //printf ("%d\n", main_result);

  return main_result;
}
  d0:	03e00008 	jr	ra
  d4:	27bd00c8 	addiu	sp,sp,200

Disassembly of section .rodata:

00000000 <output>:
	...
   8:	00000001 	0x1
   c:	00000001 	0x1
  10:	00000002 	srl	zero,zero,0x0
  14:	00000002 	srl	zero,zero,0x0
  18:	00000003 	sra	zero,zero,0x0
  1c:	00000004 	sllv	zero,zero,zero
  20:	00000005 	0x5
  24:	00000006 	srlv	zero,zero,zero
  28:	00000008 	jr	zero
  2c:	00000008 	jr	zero
  30:	00000008 	jr	zero
  34:	00000009 	jalr	zero,zero
  38:	00000009 	jalr	zero,zero
  3c:	0000000b 	0xb
  40:	0000000b 	0xb
  44:	0000000c 	syscall
  48:	0000000f 	0xf
  4c:	0000000f 	0xf
  50:	0000000f 	0xf
  54:	00000011 	mthi	zero
  58:	00000011 	mthi	zero
  5c:	00000012 	mflo	zero
  60:	00000013 	mtlo	zero
  64:	00000014 	0x14
  68:	00000015 	0x15
  6c:	00000015 	0x15
  70:	00000015 	0x15
  74:	00000015 	0x15
  78:	00000016 	0x16
  7c:	00000016 	0x16
  80:	00000016 	0x16
  84:	00000018 	mult	zero,zero
  88:	00000018 	mult	zero,zero
  8c:	00000019 	multu	zero,zero
  90:	00000019 	multu	zero,zero
  94:	0000001f 	0x1f
  98:	00000020 	add	zero,zero,zero
  9c:	00000023 	negu	zero,zero
  a0:	00000024 	and	zero,zero,zero
  a4:	00000026 	xor	zero,zero,zero
  a8:	00000029 	0x29
  ac:	0000002d 	0x2d
  b0:	0000002f 	0x2f
  b4:	00000032 	0x32
  b8:	00000033 	0x33
  bc:	00000036 	0x36
  c0:	00000037 	0x37
  c4:	00000041 	0x41

000000c8 <C.0.3070>:
  c8:	00000024 	and	zero,zero,zero
  cc:	00000026 	xor	zero,zero,zero
  d0:	00000029 	0x29
  d4:	00000018 	mult	zero,zero
  d8:	0000002f 	0x2f
  dc:	00000032 	0x32
  e0:	00000033 	0x33
  e4:	00000020 	add	zero,zero,zero
  e8:	0000000f 	0xf
  ec:	00000041 	0x41
  f0:	0000000f 	0xf
  f4:	00000015 	0x15
  f8:	00000011 	mthi	zero
  fc:	00000012 	mflo	zero
 100:	00000013 	mtlo	zero
 104:	00000014 	0x14
 108:	00000011 	mthi	zero
 10c:	00000015 	0x15
 110:	00000015 	0x15
 114:	00000015 	0x15
 118:	00000016 	0x16
 11c:	00000036 	0x36
 120:	00000016 	0x16
 124:	0000002d 	0x2d
 128:	00000018 	mult	zero,zero
 12c:	00000019 	multu	zero,zero
 130:	00000019 	multu	zero,zero
 134:	0000001f 	0x1f
 138:	00000016 	0x16
 13c:	00000023 	negu	zero,zero
 140:	00000002 	srl	zero,zero,0x0
 144:	00000000 	sll	zero,zero,0x0
 148:	00000001 	0x1
 14c:	00000001 	0x1
 150:	00000000 	sll	zero,zero,0x0
 154:	00000002 	srl	zero,zero,0x0
 158:	00000003 	sra	zero,zero,0x0
 15c:	00000004 	sllv	zero,zero,zero
 160:	00000005 	0x5
 164:	00000006 	srlv	zero,zero,zero
 168:	00000008 	jr	zero
 16c:	00000008 	jr	zero
 170:	00000008 	jr	zero
 174:	00000009 	jalr	zero,zero
 178:	00000009 	jalr	zero,zero
 17c:	0000000b 	0xb
 180:	00000037 	0x37
 184:	0000000c 	syscall
 188:	0000000f 	0xf
 18c:	0000000b 	0xb