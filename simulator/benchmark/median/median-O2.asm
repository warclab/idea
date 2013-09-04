
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
    
START_CCORE
    // Move window through all elements of input signal
    for (i = 2; i < N - 2; i++) {
   4:	27af0014 	addiu	t7,sp,20
   8:	3c190000 	lui	t9,0x0
   c:	01e07021 	addu	t6,t7,zero
        }
        // Sort the elements (only half of them)
        for (j = 0; j < 3; j++) {
            min = j;
            for (k = j + 1; k < 5; k++) {
                if (window[k] < window[min])
  10:	00006021 	addu	t4,zero,zero
  14:	27390000 	addiu	t9,t9,0
const int output[16] = {3, 4, 5, 6, 7,
                        8, 9, 10, 11, 12,
                        13, 14, 15, 16, 17,
                        18}; /*N - window_size - 1*/

int main () {
  18:	01e05821 	addu	t3,t7,zero
        // Pick up the window elements
        for (j = 0; j < 5; j++) {
            window[j] = signal[i - 2 + j];        
        }
        // Sort the elements (only half of them)
        for (j = 0; j < 3; j++) {
  1c:	240d0003 	addiu	t5,zero,3
    int result[20];

    int main_result = 0;
    
    // Move window through all elements of input signal
    for (i = 2; i < N - 2; i++) {
  20:	24180010 	addiu	t8,zero,16
const int output[16] = {3, 4, 5, 6, 7,
                        8, 9, 10, 11, 12,
                        13, 14, 15, 16, 17,
                        18}; /*N - window_size - 1*/

int main () {

<<<<<<< HEAD

=======
START_CCORE
>>>>>>> 03f5c8031ed4d641b182c1a2d0bcc40eb3b597d4
  
  24:	000c1880 	sll	v1,t4,0x2
  28:	03231821 	addu	v1,t9,v1
    int result[20];

    int main_result = 0;
    
    // Move window through all elements of input signal
    for (i = 2; i < N - 2; i++) {
  2c:	03a04821 	addu	t1,sp,zero
const int output[16] = {3, 4, 5, 6, 7,
                        8, 9, 10, 11, 12,
                        13, 14, 15, 16, 17,
                        18}; /*N - window_size - 1*/

int main () {
  30:	03a01021 	addu	v0,sp,zero
    
    // Move window through all elements of input signal
    for (i = 2; i < N - 2; i++) {
        // Pick up the window elements
        for (j = 0; j < 5; j++) {
            window[j] = signal[i - 2 + j];        
  34:	8c640000 	lw	a0,0(v1)
  38:	00000000 	sll	zero,zero,0x0
  3c:	ac440000 	sw	a0,0(v0)
  40:	24420004 	addiu	v0,v0,4
    int main_result = 0;
    
    // Move window through all elements of input signal
    for (i = 2; i < N - 2; i++) {
        // Pick up the window elements
        for (j = 0; j < 5; j++) {
  44:	144bfffb 	bne	v0,t3,34 <main+0x34>
  48:	24630004 	addiu	v1,v1,4
  4c:	00004021 	addu	t0,zero,zero
            window[j] = signal[i - 2 + j];        
        }
        // Sort the elements (only half of them)
        for (j = 0; j < 3; j++) {
            min = j;
            for (k = j + 1; k < 5; k++) {
  50:	25070001 	addiu	a3,t0,1
const int output[16] = {3, 4, 5, 6, 7,
                        8, 9, 10, 11, 12,
                        13, 14, 15, 16, 17,
                        18}; /*N - window_size - 1*/

int main () {
  54:	8d2a0000 	lw	t2,0(t1)
  58:	00071880 	sll	v1,a3,0x2
  5c:	03a31821 	addu	v1,sp,v1
  60:	01403021 	addu	a2,t2,zero
            window[j] = signal[i - 2 + j];        
        }
        // Sort the elements (only half of them)
        for (j = 0; j < 3; j++) {
            min = j;
            for (k = j + 1; k < 5; k++) {
  64:	00e01021 	addu	v0,a3,zero
                if (window[k] < window[min])
  68:	8c640000 	lw	a0,0(v1)
  6c:	00000000 	sll	zero,zero,0x0
  70:	0086282a 	slt	a1,a0,a2
  74:	10a00003 	beqz	a1,84 <main+0x84>
  78:	24630004 	addiu	v1,v1,4
  7c:	00404021 	addu	t0,v0,zero
  80:	00803021 	addu	a2,a0,zero
            window[j] = signal[i - 2 + j];        
        }
        // Sort the elements (only half of them)
        for (j = 0; j < 3; j++) {
            min = j;
            for (k = j + 1; k < 5; k++) {
  84:	24420001 	addiu	v0,v0,1
  88:	28440005 	slti	a0,v0,5
  8c:	1480fff6 	bnez	a0,68 <main+0x68>
  90:	00000000 	sll	zero,zero,0x0
                    min = k;
            }
            // Put found minimum element in temp
            temp = window[j];
            window[j] = window[min];
            window[min] = temp;
  94:	00084080 	sll	t0,t0,0x2
  98:	03a84021 	addu	t0,sp,t0
                if (window[k] < window[min])
                    min = k;
            }
            // Put found minimum element in temp
            temp = window[j];
            window[j] = window[min];
  9c:	ad260000 	sw	a2,0(t1)
            window[min] = temp;
  a0:	ad0a0000 	sw	t2,0(t0)
        // Pick up the window elements
        for (j = 0; j < 5; j++) {
            window[j] = signal[i - 2 + j];        
        }
        // Sort the elements (only half of them)
        for (j = 0; j < 3; j++) {
  a4:	10ed0003 	beq	a3,t5,b4 <main+0xb4>
  a8:	25290004 	addiu	t1,t1,4
  ac:	08000014 	j	50 <main+0x50>
  b0:	00e04021 	addu	t0,a3,zero
            temp = window[j];
            window[j] = window[min];
            window[min] = temp;
        }
        // Get the result
        result[i - 2] = window[2];    
  b4:	8fa20008 	lw	v0,8(sp)
  b8:	258c0001 	addiu	t4,t4,1
  bc:	adc20000 	sw	v0,0(t6)
    int result[20];

    int main_result = 0;
    
    // Move window through all elements of input signal
    for (i = 2; i < N - 2; i++) {
  c0:	1598ffd8 	bne	t4,t8,24 <main+0x24>
  c4:	25ce0004 	addiu	t6,t6,4
  c8:	3c070000 	lui	a3,0x0
  cc:	00001821 	addu	v1,zero,zero
  d0:	00001021 	addu	v0,zero,zero
  d4:	24e70000 	addiu	a3,a3,0
        }
        // Get the result
        result[i - 2] = window[2];    
    }
END_CCORE

    for (i = 0; i < 16 /*N - (window size -1)*/; i++){
  d8:	24060040 	addiu	a2,zero,64
const int output[16] = {3, 4, 5, 6, 7,
                        8, 9, 10, 11, 12,
                        13, 14, 15, 16, 17,
                        18}; /*N - window_size - 1*/

int main () {

  // Manually inserted by Fred
  d10: 0000000 addiu a3,a3,0x50	

  dc:	01e32821 	addu	a1,t7,v1
  e0:	00e32021 	addu	a0,a3,v1
        // Get the result
        result[i - 2] = window[2];    
    }

    for (i = 0; i < 16 /*N - (window size -1)*/; i++){
        main_result += (result[i] != output[i]);
  e4:	8ca50000 	lw	a1,0(a1)
  e8:	8c840000 	lw	a0,0(a0)
  ec:	24630004 	addiu	v1,v1,4
  f0:	00a42026 	xor	a0,a1,a0
  f4:	0004202b 	sltu	a0,zero,a0
        }
        // Get the result
        result[i - 2] = window[2];    
    }

    for (i = 0; i < 16 /*N - (window size -1)*/; i++){

  // Manually changed by Fred
  f8:	1466fff8 	bne	v1,a2,e0 <main+0xdc>
  fc:	00441021 	addu	v0,v0,a0
        //printf("%i: %i\n", i, result[i]);
    }
    //printf("%i\n", main_result);
    
return main_result;
}
 100:	03e00008 	jr	ra
 104:	27bd0068 	addiu	sp,sp,104

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
