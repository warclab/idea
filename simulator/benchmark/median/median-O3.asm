
median.o:     file format elf32-bigmips


Disassembly of section .text:

00000000 <main>:
            window[j] = signal[i - 2 + j];        
        }
        // Sort the elements (only half of them)
        for (j = 0; j < 3; j++) {
            min = j;
            for (k = j + 1; k < 5; k++) {
   0:	3c0c0000 	lui	t4,0x0
const int output[16] = {3, 4, 5, 6, 7,
                        8, 9, 10, 11, 12,
                        13, 14, 15, 16, 17,
                        18}; /*N - window_size - 1*/

int main () {
   4:	27bdff98 	addiu	sp,sp,-104
            window[j] = signal[i - 2 + j];        
        }
        // Sort the elements (only half of them)
        for (j = 0; j < 3; j++) {
            min = j;
            for (k = j + 1; k < 5; k++) {
   8:	258c0000 	addiu	t4,t4,0
   c:	27ae0014 	addiu	t6,sp,20
const int output[16] = {3, 4, 5, 6, 7,
                        8, 9, 10, 11, 12,
                        13, 14, 15, 16, 17,
                        18}; /*N - window_size - 1*/

int main () {
  10:	258f0040 	addiu	t7,t4,64
        // Pick up the window elements
        for (j = 0; j < 5; j++) {
            window[j] = signal[i - 2 + j];        
        }
        // Sort the elements (only half of them)
        for (j = 0; j < 3; j++) {
  14:	240d0003 	addiu	t5,zero,3
    
    // Move window through all elements of input signal
    for (i = 2; i < N - 2; i++) {
        // Pick up the window elements
        for (j = 0; j < 5; j++) {
            window[j] = signal[i - 2 + j];        
START_CCORE
  18:	8d860000 	lw	a2,0(t4)
  1c:	8d850004 	lw	a1,4(t4)
  20:	8d840008 	lw	a0,8(t4)
  24:	8d83000c 	lw	v1,12(t4)
  28:	8d820010 	lw	v0,16(t4)
  2c:	afa60000 	sw	a2,0(sp)
  30:	afa50004 	sw	a1,4(sp)
  34:	afa40008 	sw	a0,8(sp)
  38:	afa3000c 	sw	v1,12(sp)
  3c:	afa20010 	sw	v0,16(sp)
  40:	03a05021 	addu	t2,sp,zero
  44:	00004021 	addu	t0,zero,zero
        }
        // Sort the elements (only half of them)
        for (j = 0; j < 3; j++) {
            min = j;
            for (k = j + 1; k < 5; k++) {
  48:	25090001 	addiu	t1,t0,1
const int output[16] = {3, 4, 5, 6, 7,
                        8, 9, 10, 11, 12,
                        13, 14, 15, 16, 17,
                        18}; /*N - window_size - 1*/

int main () {
  4c:	8d4b0000 	lw	t3,0(t2)
  50:	00091880 	sll	v1,t1,0x2
  54:	03a31821 	addu	v1,sp,v1
  58:	01603021 	addu	a2,t3,zero
            window[j] = signal[i - 2 + j];        
        }
        // Sort the elements (only half of them)
        for (j = 0; j < 3; j++) {
            min = j;
            for (k = j + 1; k < 5; k++) {
  5c:	01201021 	addu	v0,t1,zero
                if (window[k] < window[min])
  60:	8c670000 	lw	a3,0(v1)
  64:	00000000 	sll	zero,zero,0x0
  68:	00e6202a 	slt	a0,a3,a2
  6c:	14800002 	bnez	a0,78 <main+0x78>
  70:	00402821 	addu	a1,v0,zero
  74:	01002821 	addu	a1,t0,zero
  78:	14800002 	bnez	a0,84 <main+0x84>
  7c:	00a04021 	addu	t0,a1,zero
  80:	00c03821 	addu	a3,a2,zero
            window[j] = signal[i - 2 + j];        
        }
        // Sort the elements (only half of them)
        for (j = 0; j < 3; j++) {
            min = j;
            for (k = j + 1; k < 5; k++) {
  84:	24420001 	addiu	v0,v0,1
  88:	28440005 	slti	a0,v0,5
                if (window[k] < window[min])
  8c:	00e03021 	addu	a2,a3,zero
            window[j] = signal[i - 2 + j];        
        }
        // Sort the elements (only half of them)
        for (j = 0; j < 3; j++) {
            min = j;
            for (k = j + 1; k < 5; k++) {
  90:	1480fff3 	bnez	a0,60 <main+0x60>
  94:	24630004 	addiu	v1,v1,4
                    min = k;
            }
            // Put found minimum element in temp
            temp = window[j];
            window[j] = window[min];
            window[min] = temp;
  98:	00052880 	sll	a1,a1,0x2
  9c:	03a52821 	addu	a1,sp,a1
                if (window[k] < window[min])
                    min = k;
            }
            // Put found minimum element in temp
            temp = window[j];
            window[j] = window[min];
  a0:	ad470000 	sw	a3,0(t2)
            window[min] = temp;
  a4:	acab0000 	sw	t3,0(a1)
        // Pick up the window elements
        for (j = 0; j < 5; j++) {
            window[j] = signal[i - 2 + j];        
        }
        // Sort the elements (only half of them)
        for (j = 0; j < 3; j++) {
  a8:	112d0003 	beq	t1,t5,b8 <main+0xb8>
  ac:	254a0004 	addiu	t2,t2,4
  b0:	08000012 	j	48 <main+0x48>
  b4:	01204021 	addu	t0,t1,zero
            temp = window[j];
            window[j] = window[min];
            window[min] = temp;
        }
        // Get the result
        result[i - 2] = window[2];    
  b8:	8fa20008 	lw	v0,8(sp)
  bc:	258c0004 	addiu	t4,t4,4
  c0:	adc20000 	sw	v0,0(t6)
    int result[20];

    int main_result = 0;
    
    // Move window through all elements of input signal
    for (i = 2; i < N - 2; i++) {
  c4:	158fffd4 	bne	t4,t7,18 <main+0x18>
  c8:	25ce0004 	addiu	t6,t6,4
        // Get the result
        result[i - 2] = window[2];    
    }

END_CCORE

    for (i = 0; i < 16 /*N - (window size -1)*/; i++){
        main_result += (result[i] != output[i]);
  cc:	8fa40014 	lw	a0,20(sp)
  d0:	8fa30018 	lw	v1,24(sp)
  d4:	38840003 	xori	a0,a0,0x3
  d8:	38630004 	xori	v1,v1,0x4
  dc:	0003182b 	sltu	v1,zero,v1
  e0:	8fa2001c 	lw	v0,28(sp)
  e4:	0004202b 	sltu	a0,zero,a0
  e8:	00832021 	addu	a0,a0,v1
  ec:	8fa30020 	lw	v1,32(sp)
  f0:	38420005 	xori	v0,v0,0x5
  f4:	0002102b 	sltu	v0,zero,v0
  f8:	38630006 	xori	v1,v1,0x6
  fc:	00822021 	addu	a0,a0,v0
 100:	0003182b 	sltu	v1,zero,v1
 104:	8fa20024 	lw	v0,36(sp)
 108:	00832021 	addu	a0,a0,v1
 10c:	8fa30028 	lw	v1,40(sp)
 110:	38420007 	xori	v0,v0,0x7
 114:	0002102b 	sltu	v0,zero,v0
 118:	38630008 	xori	v1,v1,0x8
 11c:	00822021 	addu	a0,a0,v0
 120:	0003182b 	sltu	v1,zero,v1
 124:	8fa2002c 	lw	v0,44(sp)
 128:	00832021 	addu	a0,a0,v1
 12c:	8fa30030 	lw	v1,48(sp)
 130:	38420009 	xori	v0,v0,0x9
 134:	0002102b 	sltu	v0,zero,v0
 138:	3863000a 	xori	v1,v1,0xa
 13c:	00822021 	addu	a0,a0,v0
 140:	0003182b 	sltu	v1,zero,v1
 144:	8fa20034 	lw	v0,52(sp)
 148:	00832021 	addu	a0,a0,v1
 14c:	8fa30038 	lw	v1,56(sp)
 150:	3842000b 	xori	v0,v0,0xb
 154:	0002102b 	sltu	v0,zero,v0
 158:	3863000c 	xori	v1,v1,0xc
 15c:	00822021 	addu	a0,a0,v0
 160:	0003182b 	sltu	v1,zero,v1
 164:	8fa2003c 	lw	v0,60(sp)
 168:	00832021 	addu	a0,a0,v1
 16c:	8fa30040 	lw	v1,64(sp)
 170:	3842000d 	xori	v0,v0,0xd
 174:	0002102b 	sltu	v0,zero,v0
 178:	3863000e 	xori	v1,v1,0xe
 17c:	00822021 	addu	a0,a0,v0
 180:	0003182b 	sltu	v1,zero,v1
 184:	8fa20044 	lw	v0,68(sp)
 188:	00832021 	addu	a0,a0,v1
 18c:	8fa30048 	lw	v1,72(sp)
 190:	3842000f 	xori	v0,v0,0xf
 194:	0002102b 	sltu	v0,zero,v0
 198:	38630010 	xori	v1,v1,0x10
 19c:	00822021 	addu	a0,a0,v0
 1a0:	0003182b 	sltu	v1,zero,v1
 1a4:	8fa2004c 	lw	v0,76(sp)
 1a8:	00832021 	addu	a0,a0,v1
 1ac:	8fa30050 	lw	v1,80(sp)
 1b0:	38420011 	xori	v0,v0,0x11
 1b4:	0002102b 	sltu	v0,zero,v0
 1b8:	38630012 	xori	v1,v1,0x12
 1bc:	00821021 	addu	v0,a0,v0
 1c0:	0003182b 	sltu	v1,zero,v1
        //printf("%i: %i\n", i, result[i]);
    }
    //printf("%i\n", main_result);
    
return main_result;
}
 1c4:	00621021 	addu	v0,v1,v0
 1c8:	03e00008 	jr	ra
 1cc:	27bd0068 	addiu	sp,sp,104

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
