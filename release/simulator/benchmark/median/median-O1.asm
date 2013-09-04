
median.o:     file format elf32-bigmips


Disassembly of section .text:

00000000 <main>:
const int output[16] = {3, 4, 5, 6, 7,
                        8, 9, 10, 11, 12,
                        13, 14, 15, 16, 17,
                        18}; /*N - window_size - 1*/

int main () {
   0:	27bdff98 	addiu	sp,sp,-104
    int result[20];

    int main_result = 0;
    
    // Move window through all elements of input signal
    for (i = 2; i < N - 2; i++) {
   4:	27ad0014 	addiu	t5,sp,20
            window[j] = signal[i - 2 + j];        
        }
        // Sort the elements (only half of them)
        for (j = 0; j < 3; j++) {
            min = j;
            for (k = j + 1; k < 5; k++) {
   8:	00005821 	addu	t3,zero,zero
const int output[16] = {3, 4, 5, 6, 7,
                        8, 9, 10, 11, 12,
                        13, 14, 15, 16, 17,
                        18}; /*N - window_size - 1*/

int main () {
   c:	3c0f0000 	lui	t7,0x0
  10:	25ef0000 	addiu	t7,t7,0
  14:	01a05021 	addu	t2,t5,zero
            window[j] = signal[i - 2 + j];        
        }
        // Sort the elements (only half of them)
        for (j = 0; j < 3; j++) {
            min = j;
            for (k = j + 1; k < 5; k++) {
  18:	24080005 	addiu	t0,zero,5
        // Pick up the window elements
        for (j = 0; j < 5; j++) {
            window[j] = signal[i - 2 + j];        
        }
        // Sort the elements (only half of them)
        for (j = 0; j < 3; j++) {
  1c:	240c0003 	addiu	t4,zero,3
    int result[20];

    int main_result = 0;
    
    // Move window through all elements of input signal
    for (i = 2; i < N - 2; i++) {
  20:	08000034 	j	d0 <main+0xd0>
  24:	240e0010 	addiu	t6,zero,16
        // Pick up the window elements
        for (j = 0; j < 5; j++) {
            window[j] = signal[i - 2 + j];        
START_CCORE
  28:	8c640000 	lw	a0,0(v1)
  2c:	00000000 	sll	zero,zero,0x0
  30:	ac440000 	sw	a0,0(v0)
  34:	24420004 	addiu	v0,v0,4
    int main_result = 0;
    
    // Move window through all elements of input signal
    for (i = 2; i < N - 2; i++) {
        // Pick up the window elements
        for (j = 0; j < 5; j++) {
  38:	144afffb 	bne	v0,t2,28 <main+0x28>
  3c:	24630004 	addiu	v1,v1,4
  40:	08000013 	j	4c <main+0x4c>
  44:	00003021 	addu	a2,zero,zero
            window[j] = signal[i - 2 + j];        
        }
        // Sort the elements (only half of them)
        for (j = 0; j < 3; j++) {
  48:	00e03021 	addu	a2,a3,zero
            min = j;
            for (k = j + 1; k < 5; k++) {
  4c:	24c70001 	addiu	a3,a2,1
  50:	28e20005 	slti	v0,a3,5
  54:	1040000f 	beqz	v0,94 <main+0x94>
  58:	00071880 	sll	v1,a3,0x2
const int output[16] = {3, 4, 5, 6, 7,
                        8, 9, 10, 11, 12,
                        13, 14, 15, 16, 17,
                        18}; /*N - window_size - 1*/

int main () {
  5c:	03a31821 	addu	v1,sp,v1
            window[j] = signal[i - 2 + j];        
        }
        // Sort the elements (only half of them)
        for (j = 0; j < 3; j++) {
            min = j;
            for (k = j + 1; k < 5; k++) {
  60:	00e01021 	addu	v0,a3,zero
                if (window[k] < window[min])
  64:	00062080 	sll	a0,a2,0x2
  68:	03a42021 	addu	a0,sp,a0
  6c:	8c650000 	lw	a1,0(v1)
  70:	8c840000 	lw	a0,0(a0)
  74:	00000000 	sll	zero,zero,0x0
  78:	00a4202a 	slt	a0,a1,a0
  7c:	10800002 	beqz	a0,88 <main+0x88>
  80:	00000000 	sll	zero,zero,0x0
  84:	00403021 	addu	a2,v0,zero
            window[j] = signal[i - 2 + j];        
        }
        // Sort the elements (only half of them)
        for (j = 0; j < 3; j++) {
            min = j;
            for (k = j + 1; k < 5; k++) {
  88:	24420001 	addiu	v0,v0,1
  8c:	1448fff5 	bne	v0,t0,64 <main+0x64>
  90:	24630004 	addiu	v1,v1,4
                if (window[k] < window[min])
                    min = k;
            }
            // Put found minimum element in temp
            temp = window[j];
  94:	8d220000 	lw	v0,0(t1)
            window[j] = window[min];
  98:	00063080 	sll	a2,a2,0x2
  9c:	03a63021 	addu	a2,sp,a2
  a0:	8cc30000 	lw	v1,0(a2)
  a4:	00000000 	sll	zero,zero,0x0
  a8:	ad230000 	sw	v1,0(t1)
            window[min] = temp;
  ac:	acc20000 	sw	v0,0(a2)
        // Pick up the window elements
        for (j = 0; j < 5; j++) {
            window[j] = signal[i - 2 + j];        
        }
        // Sort the elements (only half of them)
        for (j = 0; j < 3; j++) {
  b0:	14ecffe5 	bne	a3,t4,48 <main+0x48>
  b4:	25290004 	addiu	t1,t1,4
            temp = window[j];
            window[j] = window[min];
            window[min] = temp;
        }
        // Get the result
        result[i - 2] = window[2];    
  b8:	8fa20008 	lw	v0,8(sp)
  bc:	00000000 	sll	zero,zero,0x0
  c0:	ada20000 	sw	v0,0(t5)
  c4:	256b0001 	addiu	t3,t3,1
    int result[20];

    int main_result = 0;
    
    // Move window through all elements of input signal
    for (i = 2; i < N - 2; i++) {
  c8:	116e0006 	beq	t3,t6,e4 <main+0xe4>
  cc:	25ad0004 	addiu	t5,t5,4
const int output[16] = {3, 4, 5, 6, 7,
                        8, 9, 10, 11, 12,
                        13, 14, 15, 16, 17,
                        18}; /*N - window_size - 1*/

int main () {
  d0:	000b1880 	sll	v1,t3,0x2
  d4:	01e31821 	addu	v1,t7,v1
    int result[20];

    int main_result = 0;
    
    // Move window through all elements of input signal
    for (i = 2; i < N - 2; i++) {
  d8:	03a04821 	addu	t1,sp,zero
const int output[16] = {3, 4, 5, 6, 7,
                        8, 9, 10, 11, 12,
                        13, 14, 15, 16, 17,
                        18}; /*N - window_size - 1*/

int main () {
  dc:	0800000a 	j	28 <main+0x28>
  e0:	03a01021 	addu	v0,sp,zero
    int result[20];

    int main_result = 0;
    
    // Move window through all elements of input signal
    for (i = 2; i < N - 2; i++) {
  e4:	00001821 	addu	v1,zero,zero
  e8:	00001021 	addu	v0,zero,zero
const int output[16] = {3, 4, 5, 6, 7,
                        8, 9, 10, 11, 12,
                        13, 14, 15, 16, 17,
                        18}; /*N - window_size - 1*/

int main () {
  ec:	27a80014 	addiu	t0,sp,20
  f0:	3c070000 	lui	a3,0x0
  f4:	24e70000 	addiu	a3,a3,0
        }
        // Get the result
        result[i - 2] = window[2];    
    }
END_CCORE

    for (i = 0; i < 16 /*N - (window size -1)*/; i++){
  f8:	24060040 	addiu	a2,zero,64

  // Manually inserted by Fred
  f10: 0000000 addiu a3,a3,0x50

const int output[16] = {3, 4, 5, 6, 7,
                        8, 9, 10, 11, 12,
                        13, 14, 15, 16, 17,
                        18}; /*N - window_size - 1*/

int main () {
  fc:	01032821 	addu	a1,t0,v1
 100:	00e32021 	addu	a0,a3,v1
        // Get the result
        result[i - 2] = window[2];    
    }

    for (i = 0; i < 16 /*N - (window size -1)*/; i++){
        main_result += (result[i] != output[i]);
 104:	8ca50000 	lw	a1,0(a1)
 108:	8c840000 	lw	a0,0(a0)
 10c:	00000000 	sll	zero,zero,0x0
 110:	00a42026 	xor	a0,a1,a0
 114:	0004202b 	sltu	a0,zero,a0
 118:	24630004 	addiu	v1,v1,4
        }
        // Get the result
        result[i - 2] = window[2];    
    }

    for (i = 0; i < 16 /*N - (window size -1)*/; i++){

 // Manually Changed by Fred
 11c:	1466fff7 	bne	v1,a2,100 <main+0xfc>
 120:	00441021 	addu	v0,v0,a0
        //printf("%i: %i\n", i, result[i]);
    }
    //printf("%i\n", main_result);
    
return main_result;
}
 124:	03e00008 	jr	ra
 128:	27bd0068 	addiu	sp,sp,104

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
