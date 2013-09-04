
median.o:     file format elf32-bigmips


Disassembly of section .text:

00000000 <main>:
const int output[16] = {3, 4, 5, 6, 7,
                        8, 9, 10, 11, 12,
                        13, 14, 15, 16, 17,
                        18}; /*N - window_size - 1*/

int main () {
   0:                        27bdff78 	addiu	sp,sp,-136
   4:	afbe0084 	sw	s8,132(sp)
   8:	03a0f021 	addu	s8,sp,zero

    int i, j, k;
    int min, temp;
    int N = 20; 
   c:	24020014 	addiu	v0,zero,20
  10:	afc20014 	sw	v0,20(s8)
    int window[5];
    int result[20];

    int main_result = 0;
  14:	afc00010 	sw	zero,16(s8)
    
    // Move window through all elements of input signal
    for (i = 2; i < N - 2; i++) {
  18:	24020002 	addiu	v0,zero,2
  1c:	afc20000 	sw	v0,0(s8)
  20:	08000078 	j	1e0 <main+0x1e0>
  24:	00000000 	sll	zero,zero,0x0
        // Pick up the window elements
        for (j = 0; j < 5; j++) {
START_CCORE
  28:	afc00004 	sw	zero,4(s8)
  2c:	08000021 	j	84 <main+0x84>
  30:	00000000 	sll	zero,zero,0x0
            window[j] = signal[i - 2 + j];        
  34:	8fc20000 	lw	v0,0(s8)
  38:	00000000 	sll	zero,zero,0x0
  3c:	2443fffe 	addiu	v1,v0,-2
  40:	8fc20004 	lw	v0,4(s8)
  44:	00000000 	sll	zero,zero,0x0
  48:	00621821 	addu	v1,v1,v0
  4c:	3c020000 	lui	v0,0x0
  50:	00031880 	sll	v1,v1,0x2
  54:	24420000 	addiu	v0,v0,0
  58:	00621021 	addu	v0,v1,v0
  5c:	8c430000 	lw	v1,0(v0)
  60:	8fc20004 	lw	v0,4(s8)
  64:	00000000 	sll	zero,zero,0x0
  68:	00021080 	sll	v0,v0,0x2
  6c:	03c21021 	addu	v0,s8,v0
  70:	ac43001c 	sw	v1,28(v0)
    int main_result = 0;
    
    // Move window through all elements of input signal
    for (i = 2; i < N - 2; i++) {
        // Pick up the window elements
        for (j = 0; j < 5; j++) {
  74:	8fc20004 	lw	v0,4(s8)
  78:	00000000 	sll	zero,zero,0x0
  7c:	24420001 	addiu	v0,v0,1
  80:	afc20004 	sw	v0,4(s8)
  84:	8fc20004 	lw	v0,4(s8)
  88:	00000000 	sll	zero,zero,0x0
  8c:	28420005 	slti	v0,v0,5
  90:	1440ffe8 	bnez	v0,34 <main+0x34>
  94:	00000000 	sll	zero,zero,0x0
            window[j] = signal[i - 2 + j];        
        }
        // Sort the elements (only half of them)
        for (j = 0; j < 3; j++) {
  98:	afc00004 	sw	zero,4(s8)
  9c:	08000068 	j	1a0 <main+0x1a0>
  a0:	00000000 	sll	zero,zero,0x0
            min = j;
  a4:	8fc20004 	lw	v0,4(s8)
  a8:	00000000 	sll	zero,zero,0x0
  ac:	afc2000c 	sw	v0,12(s8)
            for (k = j + 1; k < 5; k++) {
  b0:	8fc20004 	lw	v0,4(s8)
  b4:	00000000 	sll	zero,zero,0x0
  b8:	24420001 	addiu	v0,v0,1
  bc:	afc20008 	sw	v0,8(s8)
  c0:	08000047 	j	11c <main+0x11c>
  c4:	00000000 	sll	zero,zero,0x0
                if (window[k] < window[min])
  c8:	8fc20008 	lw	v0,8(s8)
  cc:	00000000 	sll	zero,zero,0x0
  d0:	00021080 	sll	v0,v0,0x2
  d4:	03c21021 	addu	v0,s8,v0
  d8:	8c43001c 	lw	v1,28(v0)
  dc:	8fc2000c 	lw	v0,12(s8)
  e0:	00000000 	sll	zero,zero,0x0
  e4:	00021080 	sll	v0,v0,0x2
  e8:	03c21021 	addu	v0,s8,v0
  ec:	8c42001c 	lw	v0,28(v0)
  f0:	00000000 	sll	zero,zero,0x0
  f4:	0062102a 	slt	v0,v1,v0
  f8:	10400004 	beqz	v0,10c <main+0x10c>
  fc:	00000000 	sll	zero,zero,0x0
                    min = k;
 100:	8fc20008 	lw	v0,8(s8)
 104:	00000000 	sll	zero,zero,0x0
 108:	afc2000c 	sw	v0,12(s8)
            window[j] = signal[i - 2 + j];        
        }
        // Sort the elements (only half of them)
        for (j = 0; j < 3; j++) {
            min = j;
            for (k = j + 1; k < 5; k++) {
 10c:	8fc20008 	lw	v0,8(s8)
 110:	00000000 	sll	zero,zero,0x0
 114:	24420001 	addiu	v0,v0,1
 118:	afc20008 	sw	v0,8(s8)
 11c:	8fc20008 	lw	v0,8(s8)
 120:	00000000 	sll	zero,zero,0x0
 124:	28420005 	slti	v0,v0,5
 128:	1440ffe7 	bnez	v0,c8 <main+0xc8>
 12c:	00000000 	sll	zero,zero,0x0
                if (window[k] < window[min])
                    min = k;
            }
            // Put found minimum element in temp
            temp = window[j];
 130:	8fc20004 	lw	v0,4(s8)
 134:	00000000 	sll	zero,zero,0x0
 138:	00021080 	sll	v0,v0,0x2
 13c:	03c21021 	addu	v0,s8,v0
 140:	8c42001c 	lw	v0,28(v0)
 144:	00000000 	sll	zero,zero,0x0
 148:	afc20018 	sw	v0,24(s8)
            window[j] = window[min];
 14c:	8fc2000c 	lw	v0,12(s8)
 150:	00000000 	sll	zero,zero,0x0
 154:	00021080 	sll	v0,v0,0x2
 158:	03c21021 	addu	v0,s8,v0
 15c:	8c43001c 	lw	v1,28(v0)
 160:	8fc20004 	lw	v0,4(s8)
 164:	00000000 	sll	zero,zero,0x0
 168:	00021080 	sll	v0,v0,0x2
 16c:	03c21021 	addu	v0,s8,v0
 170:	ac43001c 	sw	v1,28(v0)
            window[min] = temp;
 174:	8fc2000c 	lw	v0,12(s8)
 178:	00000000 	sll	zero,zero,0x0
 17c:	00021080 	sll	v0,v0,0x2
 180:	03c21021 	addu	v0,s8,v0
 184:	8fc30018 	lw	v1,24(s8)
 188:	00000000 	sll	zero,zero,0x0
 18c:	ac43001c 	sw	v1,28(v0)
        // Pick up the window elements
        for (j = 0; j < 5; j++) {
            window[j] = signal[i - 2 + j];        
        }
        // Sort the elements (only half of them)
        for (j = 0; j < 3; j++) {
 190:	8fc20004 	lw	v0,4(s8)
 194:	00000000 	sll	zero,zero,0x0
 198:	24420001 	addiu	v0,v0,1
 19c:	afc20004 	sw	v0,4(s8)
 1a0:	8fc20004 	lw	v0,4(s8)
 1a4:	00000000 	sll	zero,zero,0x0
 1a8:	28420003 	slti	v0,v0,3
 1ac:	1440ffbd 	bnez	v0,a4 <main+0xa4>
 1b0:	00000000 	sll	zero,zero,0x0
            temp = window[j];
            window[j] = window[min];
            window[min] = temp;
        }
        // Get the result
        result[i - 2] = window[2];    
 1b4:	8fc20000 	lw	v0,0(s8)
 1b8:	00000000 	sll	zero,zero,0x0
 1bc:	2442fffe 	addiu	v0,v0,-2
 1c0:	8fc30024 	lw	v1,36(s8)
 1c4:	00021080 	sll	v0,v0,0x2
 1c8:	03c21021 	addu	v0,s8,v0
 1cc:	ac430030 	sw	v1,48(v0)
    int result[20];

    int main_result = 0;
    
    // Move window through all elements of input signal
    for (i = 2; i < N - 2; i++) {
 1d0:	8fc20000 	lw	v0,0(s8)
 1d4:	00000000 	sll	zero,zero,0x0
 1d8:	24420001 	addiu	v0,v0,1
 1dc:	afc20000 	sw	v0,0(s8)
 1e0:	8fc20014 	lw	v0,20(s8)
 1e4:	00000000 	sll	zero,zero,0x0
 1e8:	2443fffe 	addiu	v1,v0,-2
 1ec:	8fc20000 	lw	v0,0(s8)
 1f0:	00000000 	sll	zero,zero,0x0
 1f4:	0043102a 	slt	v0,v0,v1
 1f8:	1440ff8b 	bnez	v0,28 <main+0x28>
 1fc:	00000000 	sll	zero,zero,0x0
END_CCORE
        }
        // Get the result
        result[i - 2] = window[2];    
    }

    for (i = 0; i < 16 /*N - (window size -1)*/; i++){
 200:	afc00000 	sw	zero,0(s8)

 // Manually inserted
 202: 00000000  addiu v0,v0,0x50

 204:	0800009a 	j	268 <main+0x268>
 208:	00000000 	sll	zero,zero,0x0
        main_result += (result[i] != output[i]);
 20c:	8fc20000 	lw	v0,0(s8)
 210:	00000000 	sll	zero,zero,0x0
 214:	00021080 	sll	v0,v0,0x2
 218:	03c21021 	addu	v0,s8,v0
 21c:	8c430030 	lw	v1,48(v0)
 220:	3c020000 	lui	v0,0x0
 224:	8fc40000 	lw	a0,0(s8)
 228:	00000000 	sll	zero,zero,0x0
 22c:	00042080 	sll	a0,a0,0x2
 230:	24420000 	addiu	v0,v0,0
 234:	00821021 	addu	v0,a0,v0
 238:	8c420000 	lw	v0,0(v0)
 23c:	00000000 	sll	zero,zero,0x0
 240:	00621026 	xor	v0,v1,v0
 244:	0002102b 	sltu	v0,zero,v0
 248:	8fc30010 	lw	v1,16(s8)
 24c:	00000000 	sll	zero,zero,0x0
 250:	00621021 	addu	v0,v1,v0
 254:	afc20010 	sw	v0,16(s8)
        }
        // Get the result
        result[i - 2] = window[2];    
    }

    for (i = 0; i < 16 /*N - (window size -1)*/; i++){
 258:	8fc20000 	lw	v0,0(s8)
 25c:	00000000 	sll	zero,zero,0x0
 260:	24420001 	addiu	v0,v0,1
 264:	afc20000 	sw	v0,0(s8)
 268:	8fc20000 	lw	v0,0(s8)
 26c:	00000000 	sll	zero,zero,0x0
 270:	28420010 	slti	v0,v0,16
 274:	1440ffe5 	bnez	v0,20c <main+0x20c>
 278:	00000000 	sll	zero,zero,0x0

        main_result += (result[i] != output[i]);
        //printf("%i: %i\n", i, result[i]);
    }
    //printf("%i\n", main_result);
    
return main_result;
 27c:	8fc20010 	lw	v0,16(s8)
}
 280:	03c0e821 	addu	sp,s8,zero
 284:	8fbe0084 	lw	s8,132(sp)
 288:	27bd0088 	addiu	sp,sp,136
 28c:	03e00008 	jr	ra
 290:	00000000 	sll	zero,zero,0x0

Disassembly of section .rodata:

00000000 <signal>:
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

00000050 <output>:
  50:	00000003 	sra	zero,zero,0x0
  54:	00000004 	sllv	zero,zero,zero
  58:	00000005 	0x5
  5c:	00000006 	srlv	zero,zero,zero
  60:	00000007 	srav	zero,zero,zero
  64:	00000008 	jr	zero
  68:	00000009 	jalr	zero,zero
  6c:	0000000a 	0xa
  70:	0000000b 	0xb
  74:	0000000c 	syscall
  78:	0000000d 	break
  7c:	0000000e 	0xe
  80:	0000000f 	0xf
  84:	00000010 	mfhi	zero
  88:	00000011 	mthi	zero
  8c:	00000012 	mflo	zero
