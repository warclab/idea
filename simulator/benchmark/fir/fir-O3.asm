
fir.o:     file format elf32-bigmips


Disassembly of section .text:

00000000 <main>:
                        33, 25, 35, 25, 14, 31, 41, 17, 15, 22,
                        16, 26, 22, 29, 25, 11, 33, 20, 21, 9,
                        25, 21, 4, 21, 14, 14, 32, 30, 13, 1,
                        0, 0, 0, 0}; // Padded line for y[49]

int main () {
   0:	27bdff38 	addiu	sp,sp,-200
        int y[50];

    for (n = 0; n < ndata; n++) {
        sum = 0;
        for (k = 0; k < ncoeff; k++) {
            sum = sum + coeff[k] * data[k+n];
   4:	24020498 	addiu	v0,zero,1176
            y[n] = sum;  
START_CCORE         
   8:	afa20000 	sw	v0,0(sp)
   c:	24020458 	addiu	v0,zero,1112
  10:	afa20004 	sw	v0,4(sp)
  14:	240202cc 	addiu	v0,zero,716
  18:	afa20008 	sw	v0,8(sp)
  1c:	240202d0 	addiu	v0,zero,720
  20:	afa2000c 	sw	v0,12(sp)
  24:	24020330 	addiu	v0,zero,816
  28:	afa20010 	sw	v0,16(sp)
  2c:	240203ca 	addiu	v0,zero,970
  30:	afa20014 	sw	v0,20(sp)
  34:	2402038f 	addiu	v0,zero,911
  38:	afa20018 	sw	v0,24(sp)
  3c:	2402034e 	addiu	v0,zero,846
  40:	afa2001c 	sw	v0,28(sp)
  44:	24020361 	addiu	v0,zero,865
  48:	afa20020 	sw	v0,32(sp)
  4c:	24020320 	addiu	v0,zero,800
  50:	afa20024 	sw	v0,36(sp)
  54:	2402024c 	addiu	v0,zero,588
  58:	afa20028 	sw	v0,40(sp)
  5c:	2402024f 	addiu	v0,zero,591
  60:	afa2002c 	sw	v0,44(sp)
  64:	2402026d 	addiu	v0,zero,621
  68:	afa20030 	sw	v0,48(sp)
  6c:	240201b0 	addiu	v0,zero,432
  70:	afa20034 	sw	v0,52(sp)
  74:	24020228 	addiu	v0,zero,552
  78:	afa20038 	sw	v0,56(sp)
  7c:	240202c6 	addiu	v0,zero,710
  80:	afa2003c 	sw	v0,60(sp)
  84:	24020417 	addiu	v0,zero,1047
  88:	afa20040 	sw	v0,64(sp)
  8c:	240203d9 	addiu	v0,zero,985
  90:	afa20044 	sw	v0,68(sp)
  94:	240204cf 	addiu	v0,zero,1231
  98:	afa20048 	sw	v0,72(sp)
  9c:	24020496 	addiu	v0,zero,1174
  a0:	afa2004c 	sw	v0,76(sp)
  a4:	2402047b 	addiu	v0,zero,1147
  a8:	afa20050 	sw	v0,80(sp)
  ac:	240203f2 	addiu	v0,zero,1010
  b0:	afa20054 	sw	v0,84(sp)
  b4:	2402044b 	addiu	v0,zero,1099
  b8:	afa20058 	sw	v0,88(sp)
  bc:	240204c5 	addiu	v0,zero,1221
  c0:	afa2005c 	sw	v0,92(sp)
  c4:	24020461 	addiu	v0,zero,1121
  c8:	afa20060 	sw	v0,96(sp)
  cc:	24020377 	addiu	v0,zero,887
  d0:	afa20064 	sw	v0,100(sp)
  d4:	24020329 	addiu	v0,zero,809
  d8:	afa20068 	sw	v0,104(sp)
  dc:	2402033e 	addiu	v0,zero,830
  e0:	afa2006c 	sw	v0,108(sp)
  e4:	2402035d 	addiu	v0,zero,861
  e8:	afa20070 	sw	v0,112(sp)
  ec:	240203eb 	addiu	v0,zero,1003
  f0:	afa20074 	sw	v0,116(sp)
  f4:	24020407 	addiu	v0,zero,1031
  f8:	afa20078 	sw	v0,120(sp)
  fc:	240203e8 	addiu	v0,zero,1000
 100:	afa2007c 	sw	v0,124(sp)
 104:	240203b5 	addiu	v0,zero,949
 108:	afa20080 	sw	v0,128(sp)
 10c:	240403f4 	addiu	a0,zero,1012
 110:	24020391 	addiu	v0,zero,913
 114:	afa20084 	sw	v0,132(sp)
 118:	afa40088 	sw	a0,136(sp)
 11c:	2404032d 	addiu	a0,zero,813
 120:	afa4008c 	sw	a0,140(sp)
 124:	2404031d 	addiu	a0,zero,797
 128:	afa40090 	sw	a0,144(sp)
 12c:	240402eb 	addiu	a0,zero,747
 130:	afa40094 	sw	a0,148(sp)
 134:	240402fb 	addiu	a0,zero,763
 138:	afa40098 	sw	a0,152(sp)
 13c:	24040296 	addiu	a0,zero,662
 140:	afa4009c 	sw	a0,156(sp)
 144:	2404024e 	addiu	a0,zero,590
 148:	afa400a0 	sw	a0,160(sp)
 14c:	24040298 	addiu	a0,zero,664
 150:	afa400a4 	sw	a0,164(sp)
 154:	240402cf 	addiu	a0,zero,719
 158:	afa400a8 	sw	a0,168(sp)
 15c:	240403a9 	addiu	a0,zero,937
 160:	afa400ac 	sw	a0,172(sp)
 164:	24040413 	addiu	a0,zero,1043
 168:	afa400b0 	sw	a0,176(sp)
 16c:	2404032f 	addiu	a0,zero,815
 170:	afa400b4 	sw	a0,180(sp)
 174:	240401c5 	addiu	a0,zero,453
 178:	afa400b8 	sw	a0,184(sp)
 17c:	240400aa 	addiu	a0,zero,170
 180:	afa400bc 	sw	a0,188(sp)
 184:	2404002c 	addiu	a0,zero,44
 188:	afa400c0 	sw	a0,192(sp)
 18c:	3c070000 	lui	a3,0x0
 190:	24040003 	addiu	a0,zero,3
 194:	00001821 	addu	v1,zero,zero
 198:	00001021 	addu	v0,zero,zero
 19c:	afa400c4 	sw	a0,196(sp)
 1a0:	24e70000 	addiu	a3,a3,0
        }
    }
    
    for (i = 0; i < 50; i++){
 1a4:	240600c8 	addiu	a2,zero,200
                        33, 25, 35, 25, 14, 31, 41, 17, 15, 22,
                        16, 26, 22, 29, 25, 11, 33, 20, 21, 9,
                        25, 21, 4, 21, 14, 14, 32, 30, 13, 1,
                        0, 0, 0, 0}; // Padded line for y[49]

int main () {
 1a8:	00e32821 	addu	a1,a3,v1
 1ac:	03a32021 	addu	a0,sp,v1
            y[n] = sum;           
        }
    }
    
    for (i = 0; i < 50; i++){
        main_result += (output[i] != y[i]);
 1b0:	8ca50000 	lw	a1,0(a1)
 1b4:	8c840000 	lw	a0,0(a0)
 1b8:	24630004 	addiu	v1,v1,4
 1bc:	00a42026 	xor	a0,a1,a0
 1c0:	0004202b 	sltu	a0,zero,a0
            sum = sum + coeff[k] * data[k+n];
            y[n] = sum;           
        }
    }
    
    for (i = 0; i < 50; i++){
 1c4:	1466fff8 	bne	v1,a2,1a8 <main+0x1a8>
 1c8:	00441021 	addu	v0,v0,a0
END_CCORE
        main_result += (output[i] != y[i]);
    }
    //printf ("%d\n", main_result);
    
    return main_result;
}
 1cc:	03e00008 	jr	ra
 1d0:	27bd00c8 	addiu	sp,sp,200

Disassembly of section .rodata:

00000000 <output>:
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
  50:	0000047b 	0x47b
  54:	000003f2 	0x3f2
  58:	0000044b 	0x44b
  5c:	000004c5 	0x4c5
  60:	00000461 	0x461
  64:	00000377 	0x377
  68:	00000329 	0x329
  6c:	0000033e 	0x33e
  70:	0000035d 	0x35d
  74:	000003eb 	0x3eb
  78:	00000407 	0x407
  7c:	000003e8 	0x3e8
  80:	000003b5 	0x3b5
  84:	00000391 	0x391
  88:	000003f4 	0x3f4
  8c:	0000032d 	0x32d
  90:	0000031d 	0x31d
  94:	000002eb 	0x2eb
  98:	000002fb 	0x2fb
  9c:	00000296 	0x296
  a0:	0000024e 	0x24e
  a4:	00000298 	0x298
  a8:	000002cf 	0x2cf
  ac:	000003a9 	0x3a9
  b0:	00000413 	0x413
  b4:	0000032f 	0x32f
  b8:	000001c5 	0x1c5
  bc:	000000aa 	0xaa
  c0:	0000002c 	0x2c
  c4:	00000003 	sra	zero,zero,0x0

000000c8 <data>:
  c8:	0000002d 	0x2d
  cc:	00000001 	0x1
  d0:	00000016 	0x16
  d4:	00000035 	0x35
  d8:	0000000a 	0xa
  dc:	0000000c 	syscall
  e0:	0000000d 	break
  e4:	00000019 	multu	zero,zero
  e8:	00000021 	addu	zero,zero,zero
  ec:	0000000e 	0xe
  f0:	0000000c 	syscall
  f4:	00000024 	and	zero,zero,zero
  f8:	0000000c 	syscall
  fc:	00000002 	srl	zero,zero,0x0
 100:	00000018 	mult	zero,zero
 104:	0000000f 	0xf
 108:	00000005 	0x5
 10c:	00000003 	sra	zero,zero,0x0
 110:	0000002a 	slt	zero,zero,zero
 114:	0000000d 	break
 118:	00000021 	addu	zero,zero,zero
 11c:	00000019 	multu	zero,zero
 120:	00000023 	negu	zero,zero
 124:	00000019 	multu	zero,zero
 128:	0000000e 	0xe
 12c:	0000001f 	0x1f
 130:	00000029 	0x29
 134:	00000011 	mthi	zero
 138:	0000000f 	0xf
 13c:	00000016 	0x16
 140:	00000010 	mfhi	zero
 144:	0000001a 	div	zero,zero,zero
 148:	00000016 	0x16
 14c:	0000001d 	0x1d
 150:	00000019 	multu	zero,zero
 154:	0000000b 	0xb
 158:	00000021 	addu	zero,zero,zero
 15c:	00000014 	0x14
 160:	00000015 	0x15
 164:	00000009 	jalr	zero,zero
 168:	00000019 	multu	zero,zero
 16c:	00000015 	0x15
 170:	00000004 	sllv	zero,zero,zero
 174:	00000015 	0x15
 178:	0000000e 	0xe
 17c:	0000000e 	0xe
 180:	00000020 	add	zero,zero,zero
 184:	0000001e 	0x1e
 188:	0000000d 	break
 18c:	00000001 	0x1
	...
