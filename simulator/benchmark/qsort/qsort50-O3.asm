
qsort.o:     file format elf32-bigmips


Disassembly of section .text:

00000000 <main>:
    int i = 0;
    int beg[50/*100*/], end[50/*100*/];

    //int counter = 0; 

    beg[0]=0; end[0]=50/*100*/;
   0:	240e0032 	addiu	t6,zero,50
                        2622, 2214, 62, 937, 1043, 5, 3, 170, 44, 3,
                        722, 2222, 1242, 234, 1043, 256, 453, 352, 231, 3,
                        457, 24, 124, 2412, 48, 235, 453, 952, 1245, 412,
                        235, 666, 1290, 101, 523, 823, 111, 214, 62, 9*/}; 

int main() {
   4:	27bdfe70 	addiu	sp,sp,-400
    int i = 0;
    int beg[50/*100*/], end[50/*100*/];

    //int counter = 0; 

    beg[0]=0; end[0]=50/*100*/;
   8:	24020032 	addiu	v0,zero,50

        L=beg[i]; R=end[i]-1;

        if (L<R) {

            piv=arr[L];
   c:	3c0a0000 	lui	t2,0x0
    int i = 0;
    int beg[50/*100*/], end[50/*100*/];

    //int counter = 0; 

    beg[0]=0; end[0]=50/*100*/;
  10:	00002021 	addu	a0,zero,zero

START_CCORE

    while (i>=0) {

        L=beg[i]; R=end[i]-1;
  14:	25c6ffff 	addiu	a2,t6,-1

        if (L<R) {

            piv=arr[L];
  18:	254a0000 	addiu	t2,t2,0
    int i = 0;
    int beg[50/*100*/], end[50/*100*/];

    //int counter = 0; 

    beg[0]=0; end[0]=50/*100*/;
  1c:	afa200c8 	sw	v0,200(sp)

    while (i>=0) {

        L=beg[i]; R=end[i]-1;

        if (L<R) {
  20:	0086102a 	slt	v0,a0,a2
    int i = 0;
    int beg[50/*100*/], end[50/*100*/];

    //int counter = 0; 

    beg[0]=0; end[0]=50/*100*/;
  24:	afa00000 	sw	zero,0(sp)
                        235, 666, 1290, 101, 523, 823, 111, 214, 62, 9*/}; 

int main() {

    int piv, L, R, swap;
    int i = 0;
  28:	00006821 	addu	t5,zero,zero

    //int counter = 0; 

    beg[0]=0; end[0]=50/*100*/;

    while (i>=0) {
  2c:	240fffff 	addiu	t7,zero,-1

        L=beg[i]; R=end[i]-1;

        if (L<R) {
  30:	1040005a 	beqz	v0,19c <main+0x19c>
  34:	01406021 	addu	t4,t2,zero

            piv=arr[L];
  38:	00045880 	sll	t3,a0,0x2
  3c:	014b1021 	addu	v0,t2,t3
  40:	8c480000 	lw	t0,0(v0)
  44:	0086102a 	slt	v0,a0,a2

            while (L<R) {
                while (arr[R]>=piv && L<R){ 
  48:	00061880 	sll	v1,a2,0x2
  4c:	01431821 	addu	v1,t2,v1
  50:	8c670000 	lw	a3,0(v1)
  54:	00000000 	sll	zero,zero,0x0
  58:	00e8182a 	slt	v1,a3,t0
  5c:	1460000e 	bnez	v1,98 <main+0x98>
  60:	00000000 	sll	zero,zero,0x0
  64:	10400013 	beqz	v0,b4 <main+0xb4>
  68:	24c3ffff 	addiu	v1,a2,-1
                        2622, 2214, 62, 937, 1043, 5, 3, 170, 44, 3,
                        722, 2222, 1242, 234, 1043, 256, 453, 352, 231, 3,
                        457, 24, 124, 2412, 48, 235, 453, 952, 1245, 412,
                        235, 666, 1290, 101, 523, 823, 111, 214, 62, 9*/}; 

int main() {
  6c:	00032880 	sll	a1,v1,0x2
  70:	08000021 	j	84 <main+0x84>
  74:	01852821 	addu	a1,t4,a1
        if (L<R) {

            piv=arr[L];

            while (L<R) {
                while (arr[R]>=piv && L<R){ 
  78:	1040000e 	beqz	v0,b4 <main+0xb4>
  7c:	24a5fffc 	addiu	a1,a1,-4
  80:	2463ffff 	addiu	v1,v1,-1
  84:	8ca70000 	lw	a3,0(a1)
  88:	0083102a 	slt	v0,a0,v1
  8c:	00e8482a 	slt	t1,a3,t0
  90:	1120fff9 	beqz	t1,78 <main+0x78>
  94:	00603021 	addu	a2,v1,zero
			        R--; 
                    //counter = counter + 1;
                }

		        if (L<R) 
  98:	10400007 	beqz	v0,b8 <main+0xb8>
  9c:	014b1821 	addu	v1,t2,t3
			        arr[L++]=arr[R];
  a0:	014b5821 	addu	t3,t2,t3
  a4:	24840001 	addiu	a0,a0,1
  a8:	ad670000 	sw	a3,0(t3)
  ac:	0086102a 	slt	v0,a0,a2
  b0:	00045880 	sll	t3,a0,0x2

                while (arr[L]<=piv && L<R) {
  b4:	014b1821 	addu	v1,t2,t3
  b8:	8c670000 	lw	a3,0(v1)
  bc:	00000000 	sll	zero,zero,0x0
  c0:	0107182a 	slt	v1,t0,a3
  c4:	1460000f 	bnez	v1,104 <main+0x104>
  c8:	00000000 	sll	zero,zero,0x0
  cc:	10400013 	beqz	v0,11c <main+0x11c>
  d0:	24850001 	addiu	a1,a0,1
                        2622, 2214, 62, 937, 1043, 5, 3, 170, 44, 3,
                        722, 2222, 1242, 234, 1043, 256, 453, 352, 231, 3,
                        457, 24, 124, 2412, 48, 235, 453, 952, 1245, 412,
                        235, 666, 1290, 101, 523, 823, 111, 214, 62, 9*/}; 

int main() {
  d4:	00051880 	sll	v1,a1,0x2
  d8:	0800003b 	j	ec <main+0xec>
  dc:	01831821 	addu	v1,t4,v1
                }

		        if (L<R) 
			        arr[L++]=arr[R];

                while (arr[L]<=piv && L<R) {
  e0:	10400033 	beqz	v0,1b0 <main+0x1b0>
  e4:	24630004 	addiu	v1,v1,4
  e8:	24a50001 	addiu	a1,a1,1
  ec:	8c670000 	lw	a3,0(v1)
			       L++;
  f0:	00a02021 	addu	a0,a1,zero
                }

		        if (L<R) 
			        arr[L++]=arr[R];

                while (arr[L]<=piv && L<R) {
  f4:	0107482a 	slt	t1,t0,a3
  f8:	1120fff9 	beqz	t1,e0 <main+0xe0>
  fc:	00a6102a 	slt	v0,a1,a2
 100:	00055880 	sll	t3,a1,0x2
			       L++;
                   //counter = counter + 1;
                }

		        if (L<R) 
 104:	10400007 	beqz	v0,124 <main+0x124>
 108:	00061080 	sll	v0,a2,0x2
			        arr[R--]=arr[L]; 
 10c:	01421021 	addu	v0,t2,v0
 110:	24c6ffff 	addiu	a2,a2,-1
 114:	ac470000 	sw	a3,0(v0)
 118:	0086102a 	slt	v0,a0,a2

        if (L<R) {

            piv=arr[L];

            while (L<R) {
 11c:	1440ffcb 	bnez	v0,4c <main+0x4c>
 120:	00061880 	sll	v1,a2,0x2
		        if (L<R) 
			        arr[R--]=arr[L]; 
	        }

            arr[L]=piv; 
	        beg[i+1]=L+1; 
 124:	25a50001 	addiu	a1,t5,1
 128:	00051080 	sll	v0,a1,0x2
	        end[i+1]=end[i]; 
	        end[i++]=L;
 12c:	000d6880 	sll	t5,t5,0x2
		        if (L<R) 
			        arr[R--]=arr[L]; 
	        }

            arr[L]=piv; 
	        beg[i+1]=L+1; 
 130:	03a21021 	addu	v0,sp,v0
 134:	24830001 	addiu	v1,a0,1
	        end[i+1]=end[i]; 
	        end[i++]=L;
 138:	03ad6821 	addu	t5,sp,t5
			        arr[R--]=arr[L]; 
	        }

            arr[L]=piv; 
	        beg[i+1]=L+1; 
	        end[i+1]=end[i]; 
 13c:	ac4e00c8 	sw	t6,200(v0)
		        if (L<R) 
			        arr[R--]=arr[L]; 
	        }

            arr[L]=piv; 
	        beg[i+1]=L+1; 
 140:	ac430000 	sw	v1,0(v0)
	        end[i+1]=end[i]; 
	        end[i++]=L;
 144:	ada400c8 	sw	a0,200(t5)

            if ((end[i]-beg[i]) > (end[i-1]-beg[i-1])) {
 148:	8c4600c8 	lw	a2,200(v0)
 14c:	8da70000 	lw	a3,0(t5)
 150:	00c37023 	subu	t6,a2,v1
 154:	00874823 	subu	t1,a0,a3

		        if (L<R) 
			        arr[R--]=arr[L]; 
	        }

            arr[L]=piv; 
 158:	014b5821 	addu	t3,t2,t3
	        beg[i+1]=L+1; 
	        end[i+1]=end[i]; 
	        end[i++]=L;

            if ((end[i]-beg[i]) > (end[i-1]-beg[i-1])) {
 15c:	012e482a 	slt	t1,t1,t6
 160:	11200005 	beqz	t1,178 <main+0x178>
 164:	ad680000 	sw	t0,0(t3)
                swap=beg[i]; 
                beg[i]=beg[i-1]; 
 168:	ac470000 	sw	a3,0(v0)
                beg[i-1]=swap;
                swap=end[i]; 
                end[i]=end[i-1]; 
 16c:	ac4400c8 	sw	a0,200(v0)
	        end[i++]=L;

            if ((end[i]-beg[i]) > (end[i-1]-beg[i-1])) {
                swap=beg[i]; 
                beg[i]=beg[i-1]; 
                beg[i-1]=swap;
 170:	ada30000 	sw	v1,0(t5)
                swap=end[i]; 
                end[i]=end[i-1]; 
                end[i-1]=swap; 
 174:	ada600c8 	sw	a2,200(t5)
                        235, 666, 1290, 101, 523, 823, 111, 214, 62, 9*/}; 

int main() {

    int piv, L, R, swap;
    int i = 0;
 178:	00a06821 	addu	t5,a1,zero

    //int counter = 0; 

    beg[0]=0; end[0]=50/*100*/;

    while (i>=0) {
 17c:	000d1080 	sll	v0,t5,0x2
 180:	03a21021 	addu	v0,sp,v0
 184:	8c4e00c8 	lw	t6,200(v0)
 188:	8c440000 	lw	a0,0(v0)

        L=beg[i]; R=end[i]-1;
 18c:	25c6ffff 	addiu	a2,t6,-1

        if (L<R) {
 190:	0086102a 	slt	v0,a0,a2
 194:	1440ffa8 	bnez	v0,38 <main+0x38>
 198:	00000000 	sll	zero,zero,0x0
                end[i]=end[i-1]; 
                end[i-1]=swap; 
            }
        }
        else {
            i--; 
 19c:	25adffff 	addiu	t5,t5,-1

    //int counter = 0; 

    beg[0]=0; end[0]=50/*100*/;

    while (i>=0) {
 1a0:	15affff6 	bne	t5,t7,17c <main+0x17c>
 1a4:	00000000 	sll	zero,zero,0x0

END_CCORE    

    //for(i = 0; i < 50/*100*/; i++) {
  	//    printf("%d, ", arr[i]);
    //}
    //printf ("%d", counter);
 1a8:	03e00008 	jr	ra
 1ac:	27bd0190 	addiu	sp,sp,400

        if (L<R) {

            piv=arr[L];

            while (L<R) {
 1b0:	1440ffa5 	bnez	v0,48 <main+0x48>
 1b4:	00055880 	sll	t3,a1,0x2
		        if (L<R) 
			        arr[R--]=arr[L]; 
	        }

            arr[L]=piv; 
	        beg[i+1]=L+1; 
 1b8:	0800004a 	j	128 <main+0x128>
 1bc:	25a50001 	addiu	a1,t5,1

Disassembly of section .data:

00000000 <arr>:
   0:	00000498 	0x498
   4:	00000458 	0x458
   8:	000002cc 	syscall	0xb
   c:	000002d0 	0x2d0
  10:	00000330 	0x330
  14:	000003ca 	0x3ca
  18:	0000038f 	0x38f
  1c:	0000034e 	0x34e
  20:	00000361 	0x361
  24:	00000320 	0x320
  28:	0000024c 	syscall	0x9
  2c:	0000024f 	0x24f
  30:	0000026d 	0x26d
  34:	000001b0 	0x1b0
  38:	00000228 	0x228
  3c:	000002c6 	0x2c6
  40:	00000417 	0x417
  44:	000003d9 	0x3d9
  48:	000004cf 	0x4cf
  4c:	00000496 	0x496
  50:	00000012 	mflo	zero
  54:	000003f2 	0x3f2
  58:	00000101 	0x101
  5c:	000004c5 	0x4c5
  60:	00000064 	0x64
  64:	00000377 	0x377
  68:	00000236 	0x236
  6c:	0000033e 	0x33e
  70:	0000013a 	0x13a
  74:	00000015 	0x15
  78:	0000047b 	0x47b
  7c:	00000011 	mthi	zero
  80:	0000044b 	0x44b
  84:	00000001 	0x1
  88:	00000461 	0x461
  8c:	0000005e 	0x5e
  90:	00000329 	0x329
  94:	00000001 	0x1
  98:	0000035d 	0x35d
  9c:	00000022 	neg	zero,zero
  a0:	00000407 	0x407
  a4:	000003e8 	0x3e8
  a8:	000003b5 	0x3b5
  ac:	00000391 	0x391
  b0:	000003f4 	0x3f4
  b4:	0000032d 	0x32d
  b8:	0000031d 	0x31d
  bc:	000002eb 	0x2eb
  c0:	000002fb 	0x2fb
  c4:	00000296 	0x296
