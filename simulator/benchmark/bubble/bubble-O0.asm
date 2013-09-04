
bubble.o:     file format elf32-bigmips


Disassembly of section .text:

00000000 <main>:
                        8, 8, 8, 9, 9, 11, 11, 12, 15, 15, 
                        15, 17, 17, 18, 19, 20, 21, 21, 21, 21, 
                        22, 22, 22, 24, 24, 25, 25, 31, 32, 35, 
                        36, 38, 41, 45, 47, 50, 51, 54, 55, 65}; 
int main()
{
   0:	27bdff08 	addiu	sp,sp,-248
   4:	afbf00f4 	sw	ra,244(sp)
   8:	afbe00f0 	sw	s8,240(sp)
   c:	03a0f021 	addu	s8,sp,zero
  unsigned int n = 50;
  10:	24020032 	addiu	v0,zero,50
  14:	afc20020 	sw	v0,32(s8)
  unsigned int i, c, d, sum, swap;
  unsigned int main_result = 0;
  18:	afc0001c 	sw	zero,28(s8)
  unsigned int array[50] = {36, 38, 41, 24, 47, 50, 51, 32, 15, 65,
  1c:	3c020000 	lui	v0,0x0
  20:	27c40028 	addiu	a0,s8,40
  24:	244300c8 	addiu	v1,v0,200
  28:	240200c8 	addiu	v0,zero,200
  2c:	00602821 	addu	a1,v1,zero
  30:	00403021 	addu	a2,v0,zero

  // Manually by Fred, Apr. 16
  38: 00000000  sll zero,zero,0x0
  38: 00000000  sll zero,zero,0x0
  //34:	0c000000 	jal	0 <main>
  //38:	00000000 	sll	zero,zero,0x0
                    15, 21, 17, 18, 19, 20, 17, 21, 21, 21,
                    22, 54, 22, 45, 24, 25, 25, 31, 22, 35,
                    2, 0, 1, 1, 0, 2, 3, 4, 5, 6,
                    8, 8, 8, 9, 9, 11, 55, 12, 15, 11};

    for (c = 0 ; c < ( n - 1 ); c++)
START_CCORE
  3c:	afc00014 	sw	zero,20(s8)
  40:	08000056 	j	158 <main+0x158>
  44:	00000000 	sll	zero,zero,0x0
      {
        for (d = 0 ; d < n - c - 1; d++)
  48:	afc00018 	sw	zero,24(s8)
  4c:	08000048 	j	120 <main+0x120>
  50:	00000000 	sll	zero,zero,0x0
        {
          if (array[d] > array[d+1]) /* For decreasing order use < */
  54:	8fc20018 	lw	v0,24(s8)
  58:	00000000 	sll	zero,zero,0x0
  5c:	00021080 	sll	v0,v0,0x2
  60:	27c30010 	addiu	v1,s8,16
  64:	00621021 	addu	v0,v1,v0
  68:	8c430018 	lw	v1,24(v0)
  6c:	8fc20018 	lw	v0,24(s8)
  70:	00000000 	sll	zero,zero,0x0
  74:	24420001 	addiu	v0,v0,1
  78:	00021080 	sll	v0,v0,0x2
  7c:	27c40010 	addiu	a0,s8,16
  80:	00821021 	addu	v0,a0,v0
  84:	8c420018 	lw	v0,24(v0)
  88:	00000000 	sll	zero,zero,0x0
  8c:	0043102b 	sltu	v0,v0,v1
  90:	1040001f 	beqz	v0,110 <main+0x110>
  94:	00000000 	sll	zero,zero,0x0
          {
            swap       = array[d];
  98:	8fc20018 	lw	v0,24(s8)
  9c:	00000000 	sll	zero,zero,0x0
  a0:	00021080 	sll	v0,v0,0x2
  a4:	27c30010 	addiu	v1,s8,16
  a8:	00621021 	addu	v0,v1,v0
  ac:	8c420018 	lw	v0,24(v0)
  b0:	00000000 	sll	zero,zero,0x0
  b4:	afc20024 	sw	v0,36(s8)
            array[d]   = array[d+1];
  b8:	8fc20018 	lw	v0,24(s8)
  bc:	00000000 	sll	zero,zero,0x0
  c0:	24420001 	addiu	v0,v0,1
  c4:	00021080 	sll	v0,v0,0x2
  c8:	27c30010 	addiu	v1,s8,16
  cc:	00621021 	addu	v0,v1,v0
  d0:	8c430018 	lw	v1,24(v0)
  d4:	8fc20018 	lw	v0,24(s8)
  d8:	00000000 	sll	zero,zero,0x0
  dc:	00021080 	sll	v0,v0,0x2
  e0:	27c40010 	addiu	a0,s8,16
  e4:	00821021 	addu	v0,a0,v0
  e8:	ac430018 	sw	v1,24(v0)
            array[d+1] = swap;
  ec:	8fc20018 	lw	v0,24(s8)
  f0:	00000000 	sll	zero,zero,0x0
  f4:	24420001 	addiu	v0,v0,1
  f8:	00021080 	sll	v0,v0,0x2
  fc:	27c30010 	addiu	v1,s8,16
 100:	00621021 	addu	v0,v1,v0
 104:	8fc30024 	lw	v1,36(s8)
 108:	00000000 	sll	zero,zero,0x0
 10c:	ac430018 	sw	v1,24(v0)
                    2, 0, 1, 1, 0, 2, 3, 4, 5, 6,
                    8, 8, 8, 9, 9, 11, 55, 12, 15, 11};

    for (c = 0 ; c < ( n - 1 ); c++)
      {
        for (d = 0 ; d < n - c - 1; d++)
 110:	8fc20018 	lw	v0,24(s8)
 114:	00000000 	sll	zero,zero,0x0
 118:	24420001 	addiu	v0,v0,1
 11c:	afc20018 	sw	v0,24(s8)
 120:	8fc30020 	lw	v1,32(s8)
 124:	8fc20014 	lw	v0,20(s8)
 128:	00000000 	sll	zero,zero,0x0
 12c:	00621023 	subu	v0,v1,v0
 130:	2443ffff 	addiu	v1,v0,-1
 134:	8fc20018 	lw	v0,24(s8)
 138:	00000000 	sll	zero,zero,0x0
 13c:	0043102b 	sltu	v0,v0,v1
 140:	1440ffc4 	bnez	v0,54 <main+0x54>
 144:	00000000 	sll	zero,zero,0x0
                    15, 21, 17, 18, 19, 20, 17, 21, 21, 21,
                    22, 54, 22, 45, 24, 25, 25, 31, 22, 35,
                    2, 0, 1, 1, 0, 2, 3, 4, 5, 6,
                    8, 8, 8, 9, 9, 11, 55, 12, 15, 11};

    for (c = 0 ; c < ( n - 1 ); c++)
 148:	8fc20014 	lw	v0,20(s8)
 14c:	00000000 	sll	zero,zero,0x0
 150:	24420001 	addiu	v0,v0,1
 154:	afc20014 	sw	v0,20(s8)
 158:	8fc20020 	lw	v0,32(s8)
 15c:	00000000 	sll	zero,zero,0x0
 160:	2443ffff 	addiu	v1,v0,-1
 164:	8fc20014 	lw	v0,20(s8)
 168:	00000000 	sll	zero,zero,0x0
 16c:	0043102b 	sltu	v0,v0,v1
 170:	1440ffb5 	bnez	v0,48 <main+0x48>
 174:	00000000 	sll	zero,zero,0x0
            array[d+1] = swap;
          }
        }
      }
END_CCORE

    for (i = 0; i < 50; i++){
 178:	afc00010 	sw	zero,16(s8)

  // Manually changed by Fred, Apr. 16
 17c:	08000079 	j	1e8 <main+0x1e4>

 180:	00000000 	sll	zero,zero,0x0
        main_result += (output[i] != array[i]);
 184:	3c020000 	lui	v0,0x0
 188:	8fc30010 	lw	v1,16(s8)
 18c:	00000000 	sll	zero,zero,0x0
 190:	00031880 	sll	v1,v1,0x2
 194:	24420000 	addiu	v0,v0,0
 198:	00621021 	addu	v0,v1,v0
  // Manually inserted by Fred, Apr. 16
 888: 88888888  addiu v0, v0, 0xc8
 19c:	8c430000 	lw	v1,0(v0)
 1a0:	8fc20010 	lw	v0,16(s8)
 1a4:	00000000 	sll	zero,zero,0x0
 1a8:	00021080 	sll	v0,v0,0x2
 1ac:	27c40010 	addiu	a0,s8,16
 1b0:	00821021 	addu	v0,a0,v0
 1b4:	8c420018 	lw	v0,24(v0)
 1b8:	00000000 	sll	zero,zero,0x0
 1bc:	00621026 	xor	v0,v1,v0
 1c0:	0002102b 	sltu	v0,zero,v0
 1c4:	8fc3001c 	lw	v1,28(s8)
 1c8:	00000000 	sll	zero,zero,0x0
 1cc:	00621021 	addu	v0,v1,v0
 1d0:	afc2001c 	sw	v0,28(s8)
            array[d+1] = swap;
          }
        }
      }

    for (i = 0; i < 50; i++){
 1d4:	8fc20010 	lw	v0,16(s8)
 1d8:	00000000 	sll	zero,zero,0x0
 1dc:	24420001 	addiu	v0,v0,1
 1e0:	afc20010 	sw	v0,16(s8)
 1e4:	8fc20010 	lw	v0,16(s8)
 1e8:	00000000 	sll	zero,zero,0x0
 1ec:	2c420032 	sltiu	v0,v0,50
 1f0:	1440ffe4 	bnez	v0,184 <main+0x184>
 1f4:	00000000 	sll	zero,zero,0x0
        main_result += (output[i] != array[i]);
    }
        //printf ("%d\n", main_result);

  return main_result;
 1f8:	8fc2001c 	lw	v0,28(s8)
}
 1fc:	03c0e821 	addu	sp,s8,zero
 1ff: 24420001  addiu v0,zero,0
 200:	8fbf00f4 	lw	ra,244(sp)
 204:	8fbe00f0 	lw	s8,240(sp)
 208:	27bd00f8 	addiu	sp,sp,248
 20c:	03e00008 	jr	ra
 210:	00000000 	sll	zero,zero,0x0

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