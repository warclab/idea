
mmult.o:     file format elf32-bigmips


Disassembly of section .text:

00000000 <main>:

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
   0:	3c030000 	lui	v1,0x0
   4:	24620000 	addiu	v0,v1,0
   8:	8c440004 	lw	a0,4(v0)
   c:	8c680000 	lw	t0,0(v1)
  10:	8c490008 	lw	t1,8(v0)
  14:	00881821 	addu	v1,a0,t0
  18:	8c4c000c 	lw	t4,12(v0)
  1c:	8c4e0010 	lw	t6,16(v0)
  20:	00693821 	addu	a3,v1,t1
                            {51, 25, 51, 26, 52},
                            {71, 35, 71, 36, 72},
                            {91, 45, 91, 46, 92}};

int main()
{
  24:	27bdff78 	addiu	sp,sp,-136

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
START_CCORE
  28:	8c460018 	lw	a2,24(v0)
  2c:	8c4a0014 	lw	t2,20(v0)
  30:	006c5821 	addu	t3,v1,t4
  34:	01244821 	addu	t1,t1,a0
  38:	00ee6821 	addu	t5,a3,t6
  3c:	008c6021 	addu	t4,a0,t4
                c[i][j]=sum;
  40:	afa80000 	sw	t0,0(sp)
                            {51, 25, 51, 26, 52},
                            {71, 35, 71, 36, 72},
                            {91, 45, 91, 46, 92}};

int main()
{
  44:	afb60084 	sw	s6,132(sp)
    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
                c[i][j]=sum;
  48:	afa30000 	sw	v1,0(sp)
                            {51, 25, 51, 26, 52},
                            {71, 35, 71, 36, 72},
                            {91, 45, 91, 46, 92}};

int main()
{
  4c:	afb50080 	sw	s5,128(sp)
    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
                c[i][j]=sum;
  50:	afa70000 	sw	a3,0(sp)
                            {51, 25, 51, 26, 52},
                            {71, 35, 71, 36, 72},
                            {91, 45, 91, 46, 92}};

int main()
{
  54:	afb4007c 	sw	s4,124(sp)
    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
                c[i][j]=sum;
  58:	afa70000 	sw	a3,0(sp)
                            {51, 25, 51, 26, 52},
                            {71, 35, 71, 36, 72},
                            {91, 45, 91, 46, 92}};

int main()
{
  5c:	afb30078 	sw	s3,120(sp)
    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
                c[i][j]=sum;
  60:	afad0000 	sw	t5,0(sp)
                            {51, 25, 51, 26, 52},
                            {71, 35, 71, 36, 72},
                            {91, 45, 91, 46, 92}};

int main()
{
  64:	afb20074 	sw	s2,116(sp)
    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
                c[i][j]=sum;
  68:	afa00004 	sw	zero,4(sp)
                            {51, 25, 51, 26, 52},
                            {71, 35, 71, 36, 72},
                            {91, 45, 91, 46, 92}};

int main()
{
  6c:	afb10070 	sw	s1,112(sp)
    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
                c[i][j]=sum;
  70:	afa40004 	sw	a0,4(sp)
                            {51, 25, 51, 26, 52},
                            {71, 35, 71, 36, 72},
                            {91, 45, 91, 46, 92}};

int main()
{
  74:	afb0006c 	sw	s0,108(sp)
    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
                c[i][j]=sum;
  78:	afa90004 	sw	t1,4(sp)

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
  7c:	016e7021 	addu	t6,t3,t6
                c[i][j]=sum;
  80:	afa90004 	sw	t1,4(sp)
  84:	afa90004 	sw	t1,4(sp)
  88:	afa80008 	sw	t0,8(sp)
  8c:	afa30008 	sw	v1,8(sp)
  90:	afa70008 	sw	a3,8(sp)
  94:	afa70008 	sw	a3,8(sp)
  98:	afad0008 	sw	t5,8(sp)
  9c:	afa0000c 	sw	zero,12(sp)
  a0:	afa4000c 	sw	a0,12(sp)
  a4:	afa4000c 	sw	a0,12(sp)
  a8:	afac000c 	sw	t4,12(sp)
  ac:	afac000c 	sw	t4,12(sp)

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
  b0:	8c4c001c 	lw	t4,28(v0)
                c[i][j]=sum;
  b4:	afa80010 	sw	t0,16(sp)

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
  b8:	00ca2821 	addu	a1,a2,t2
                c[i][j]=sum;
  bc:	afa30010 	sw	v1,16(sp)

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
  c0:	8c500024 	lw	s0,36(v0)
                c[i][j]=sum;
  c4:	afa30010 	sw	v1,16(sp)
  c8:	afab0010 	sw	t3,16(sp)
  cc:	afae0010 	sw	t6,16(sp)

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
  d0:	8c4e0020 	lw	t6,32(v0)
  d4:	00ac4021 	addu	t0,a1,t4
  d8:	8c44002c 	lw	a0,44(v0)
  dc:	8c490028 	lw	t1,40(v0)
  e0:	00ae6821 	addu	t5,a1,t6
  e4:	01866021 	addu	t4,t4,a2
  e8:	0110c821 	addu	t9,t0,s0
  ec:	01c67021 	addu	t6,t6,a2
                c[i][j]=sum;
  f0:	afaa0014 	sw	t2,20(sp)

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
  f4:	8c4b0030 	lw	t3,48(v0)
                c[i][j]=sum;
  f8:	afa50014 	sw	a1,20(sp)

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
  fc:	8c580038 	lw	t8,56(v0)
                c[i][j]=sum;
 100:	afa80014 	sw	t0,20(sp)
 104:	afa80014 	sw	t0,20(sp)
 108:	afb90014 	sw	t9,20(sp)
 10c:	afa00018 	sw	zero,24(sp)
 110:	afa60018 	sw	a2,24(sp)
 114:	afac0018 	sw	t4,24(sp)
 118:	afac0018 	sw	t4,24(sp)
 11c:	afac0018 	sw	t4,24(sp)
 120:	afaa001c 	sw	t2,28(sp)
 124:	afa5001c 	sw	a1,28(sp)
 128:	afa8001c 	sw	t0,28(sp)
 12c:	afa8001c 	sw	t0,28(sp)
 130:	afb9001c 	sw	t9,28(sp)
 134:	afa00020 	sw	zero,32(sp)
 138:	afa60020 	sw	a2,32(sp)
 13c:	afa60020 	sw	a2,32(sp)
 140:	afae0020 	sw	t6,32(sp)
 144:	afae0020 	sw	t6,32(sp)
 148:	afaa0024 	sw	t2,36(sp)
 14c:	afa50024 	sw	a1,36(sp)

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
 150:	8c4e0034 	lw	t6,52(v0)
 154:	00891821 	addu	v1,a0,t1
                c[i][j]=sum;
 158:	afa50024 	sw	a1,36(sp)

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
 15c:	006b3821 	addu	a3,v1,t3
                c[i][j]=sum;
 160:	afad0024 	sw	t5,36(sp)

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
 164:	8c4a003c 	lw	t2,60(v0)
 168:	01b08021 	addu	s0,t5,s0
 16c:	006e6821 	addu	t5,v1,t6
 170:	00f87821 	addu	t7,a3,t8
 174:	01645821 	addu	t3,t3,a0
 178:	008e7021 	addu	t6,a0,t6
 17c:	01b8c021 	addu	t8,t5,t8
                c[i][j]=sum;
 180:	afb00024 	sw	s0,36(sp)

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
 184:	8c460040 	lw	a2,64(v0)
                c[i][j]=sum;
 188:	afa90028 	sw	t1,40(sp)

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
 18c:	8c4c0044 	lw	t4,68(v0)
                c[i][j]=sum;
 190:	afa30028 	sw	v1,40(sp)

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
 194:	8c50004c 	lw	s0,76(v0)
                c[i][j]=sum;
 198:	afa70028 	sw	a3,40(sp)
 19c:	afa70028 	sw	a3,40(sp)
 1a0:	afaf0028 	sw	t7,40(sp)
 1a4:	afa0002c 	sw	zero,44(sp)
 1a8:	afa4002c 	sw	a0,44(sp)
 1ac:	afab002c 	sw	t3,44(sp)
 1b0:	afab002c 	sw	t3,44(sp)
 1b4:	afab002c 	sw	t3,44(sp)
 1b8:	afa90030 	sw	t1,48(sp)
 1bc:	afa30030 	sw	v1,48(sp)
 1c0:	afa70030 	sw	a3,48(sp)
 1c4:	afa70030 	sw	a3,48(sp)
 1c8:	afaf0030 	sw	t7,48(sp)
 1cc:	afa00034 	sw	zero,52(sp)
 1d0:	afa40034 	sw	a0,52(sp)
 1d4:	afa40034 	sw	a0,52(sp)
 1d8:	afae0034 	sw	t6,52(sp)
 1dc:	afae0034 	sw	t6,52(sp)
 1e0:	afa90038 	sw	t1,56(sp)
 1e4:	afa30038 	sw	v1,56(sp)
 1e8:	afa30038 	sw	v1,56(sp)
 1ec:	afad0038 	sw	t5,56(sp)
 1f0:	afb80038 	sw	t8,56(sp)
 1f4:	afaa003c 	sw	t2,60(sp)

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
 1f8:	8c440054 	lw	a0,84(v0)
 1fc:	8c490050 	lw	t1,80(v0)
 200:	8c580048 	lw	t8,72(v0)
 204:	8c4b0058 	lw	t3,88(v0)
 208:	00ca2821 	addu	a1,a2,t2
 20c:	01241821 	addu	v1,t1,a0
 210:	8c4e0060 	lw	t6,96(v0)
 214:	00ac4021 	addu	t0,a1,t4
 218:	006b3821 	addu	a3,v1,t3
 21c:	00b87821 	addu	t7,a1,t8
 220:	01866021 	addu	t4,t4,a2
 224:	0110c821 	addu	t9,t0,s0
 228:	00ee6821 	addu	t5,a3,t6
 22c:	0306c021 	addu	t8,t8,a2
 230:	01f08021 	addu	s0,t7,s0
                c[i][j]=sum;
 234:	afa5003c 	sw	a1,60(sp)
 238:	afa8003c 	sw	t0,60(sp)
 23c:	afa8003c 	sw	t0,60(sp)
 240:	afb9003c 	sw	t9,60(sp)
 244:	afa00040 	sw	zero,64(sp)
 248:	afa60040 	sw	a2,64(sp)
 24c:	afac0040 	sw	t4,64(sp)
 250:	afac0040 	sw	t4,64(sp)
 254:	afac0040 	sw	t4,64(sp)
 258:	afaa0044 	sw	t2,68(sp)
 25c:	afa50044 	sw	a1,68(sp)
 260:	afa80044 	sw	t0,68(sp)
 264:	afa80044 	sw	t0,68(sp)
 268:	afb90044 	sw	t9,68(sp)
 26c:	afa00048 	sw	zero,72(sp)
 270:	afa60048 	sw	a2,72(sp)
 274:	afa60048 	sw	a2,72(sp)
 278:	afb80048 	sw	t8,72(sp)
 27c:	afb80048 	sw	t8,72(sp)
 280:	afaa004c 	sw	t2,76(sp)
 284:	afa5004c 	sw	a1,76(sp)
 288:	afa5004c 	sw	a1,76(sp)
 28c:	afaf004c 	sw	t7,76(sp)
 290:	afb0004c 	sw	s0,76(sp)
 294:	afa90050 	sw	t1,80(sp)
 298:	afa30050 	sw	v1,80(sp)
 29c:	afa70050 	sw	a3,80(sp)
 2a0:	afa70050 	sw	a3,80(sp)
 2a4:	afad0050 	sw	t5,80(sp)

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
 2a8:	8c48005c 	lw	t0,92(v0)
 2ac:	008b5821 	addu	t3,a0,t3
 2b0:	00683021 	addu	a2,v1,t0
        }
    }
END_CCORE
    
    for (x = 0; x < 5; x++){
        for (y = 0; y < 5; y++) {
            main_result += (output[x][y] != c[x][y]);
 2b4:	3c050000 	lui	a1,0x0

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
 2b8:	01044021 	addu	t0,t0,a0
 2bc:	00ce7021 	addu	t6,a2,t6
                c[i][j]=sum;
 2c0:	afa00054 	sw	zero,84(sp)
        }
    }
    
    for (x = 0; x < 5; x++){
        for (y = 0; y < 5; y++) {
            main_result += (output[x][y] != c[x][y]);
 2c4:	24a20000 	addiu	v0,a1,0
    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
                c[i][j]=sum;
 2c8:	afa40054 	sw	a0,84(sp)
 2cc:	afab0054 	sw	t3,84(sp)
 2d0:	afab0054 	sw	t3,84(sp)
 2d4:	afab0054 	sw	t3,84(sp)
 2d8:	afa90058 	sw	t1,88(sp)
 2dc:	afa30058 	sw	v1,88(sp)
 2e0:	afa70058 	sw	a3,88(sp)
 2e4:	afa70058 	sw	a3,88(sp)
 2e8:	afad0058 	sw	t5,88(sp)
 2ec:	afa0005c 	sw	zero,92(sp)
 2f0:	afa4005c 	sw	a0,92(sp)
 2f4:	afa4005c 	sw	a0,92(sp)
 2f8:	afa8005c 	sw	t0,92(sp)
 2fc:	afa8005c 	sw	t0,92(sp)
 300:	afa90060 	sw	t1,96(sp)
 304:	afa30060 	sw	v1,96(sp)
 308:	afa30060 	sw	v1,96(sp)
 30c:	afa60060 	sw	a2,96(sp)
 310:	afae0060 	sw	t6,96(sp)
        }
    }
    
    for (x = 0; x < 5; x++){
        for (y = 0; y < 5; y++) {
            main_result += (output[x][y] != c[x][y]);
 314:	8fb80000 	lw	t8,0(sp)
 318:	8c560018 	lw	s6,24(v0)
 31c:	8fb30004 	lw	s3,4(sp)
 320:	8c490014 	lw	t1,20(v0)
 324:	8fac0008 	lw	t4,8(sp)
 328:	8fa8000c 	lw	t0,12(sp)
 32c:	8fb00010 	lw	s0,16(sp)
 330:	8fa60014 	lw	a2,20(sp)
 334:	8fa30018 	lw	v1,24(sp)
 338:	8c4b001c 	lw	t3,28(v0)
 33c:	8fa4001c 	lw	a0,28(sp)
 340:	02c3b026 	xor	s6,s6,v1
 344:	01264826 	xor	t1,t1,a2
 348:	8fa30020 	lw	v1,32(sp)
 34c:	8c4a0020 	lw	t2,32(v0)
 350:	8fa60024 	lw	a2,36(sp)
 354:	0009482b 	sltu	t1,zero,t1
 358:	01645826 	xor	t3,t3,a0
 35c:	8c470024 	lw	a3,36(v0)
 360:	0016b02b 	sltu	s6,zero,s6
 364:	8fa40028 	lw	a0,40(sp)
 368:	02c9b021 	addu	s6,s6,t1
 36c:	000b582b 	sltu	t3,zero,t3
 370:	01435026 	xor	t2,t2,v1
 374:	8c490028 	lw	t1,40(v0)
 378:	8fa3002c 	lw	v1,44(sp)
 37c:	02cbb021 	addu	s6,s6,t3
 380:	000a502b 	sltu	t2,zero,t2
 384:	00e63826 	xor	a3,a3,a2
 388:	8c4b002c 	lw	t3,44(v0)
 38c:	8fa60030 	lw	a2,48(sp)
 390:	02cab021 	addu	s6,s6,t2
 394:	0007382b 	sltu	a3,zero,a3
 398:	01244826 	xor	t1,t1,a0
 39c:	8c4a0030 	lw	t2,48(v0)
 3a0:	8fa40034 	lw	a0,52(sp)
 3a4:	02c7b021 	addu	s6,s6,a3
 3a8:	0009482b 	sltu	t1,zero,t1
 3ac:	01635826 	xor	t3,t3,v1
 3b0:	8c470034 	lw	a3,52(v0)
 3b4:	8fa30038 	lw	v1,56(sp)
 3b8:	02c9b021 	addu	s6,s6,t1
 3bc:	000b582b 	sltu	t3,zero,t3
 3c0:	01465026 	xor	t2,t2,a2
 3c4:	8c490038 	lw	t1,56(v0)
 3c8:	8fa6003c 	lw	a2,60(sp)
 3cc:	02cbb021 	addu	s6,s6,t3
 3d0:	000a502b 	sltu	t2,zero,t2
 3d4:	00e43826 	xor	a3,a3,a0
 3d8:	8c52003c 	lw	s2,60(v0)
 3dc:	8fa40040 	lw	a0,64(sp)
 3e0:	8c540004 	lw	s4,4(v0)
 3e4:	8cb10000 	lw	s1,0(a1)
 3e8:	02cab021 	addu	s6,s6,t2
 3ec:	0007382b 	sltu	a3,zero,a3
 3f0:	01234826 	xor	t1,t1,v1
 3f4:	8c590040 	lw	t9,64(v0)
 3f8:	8fab0044 	lw	t3,68(sp)
 3fc:	8c450008 	lw	a1,8(v0)
 400:	8fa30048 	lw	v1,72(sp)
 404:	8c4f0044 	lw	t7,68(v0)
 408:	8c550054 	lw	s5,84(v0)
 40c:	8c4d0050 	lw	t5,80(v0)
 410:	02c7b021 	addu	s6,s6,a3
 414:	0009482b 	sltu	t1,zero,t1
 418:	8fa7004c 	lw	a3,76(sp)
 41c:	02469026 	xor	s2,s2,a2
 420:	8faa0050 	lw	t2,80(sp)
 424:	8fae0054 	lw	t6,84(sp)
 428:	02c9b021 	addu	s6,s6,t1
 42c:	8fa60058 	lw	a2,88(sp)
 430:	8c490058 	lw	t1,88(v0)
 434:	0293a026 	xor	s4,s4,s3
 438:	02388826 	xor	s1,s1,t8
 43c:	8c53000c 	lw	s3,12(v0)
 440:	0324c826 	xor	t9,t9,a0
 444:	8c580048 	lw	t8,72(v0)
 448:	0012902b 	sltu	s2,zero,s2
 44c:	8fa4005c 	lw	a0,92(sp)
 450:	02d29021 	addu	s2,s6,s2
 454:	0014a02b 	sltu	s4,zero,s4
 458:	00ac6026 	xor	t4,a1,t4
 45c:	01eb5826 	xor	t3,t7,t3
 460:	8c450010 	lw	a1,16(v0)
 464:	8c4f004c 	lw	t7,76(v0)
 468:	02ae7026 	xor	t6,s5,t6
 46c:	01aa5026 	xor	t2,t5,t2
 470:	0011882b 	sltu	s1,zero,s1
 474:	8c4d005c 	lw	t5,92(v0)
 478:	0019c82b 	sltu	t9,zero,t9
 47c:	02918821 	addu	s1,s4,s1
 480:	02684026 	xor	t0,s3,t0
 484:	0259c821 	addu	t9,s2,t9
 488:	0303c026 	xor	t8,t8,v1
 48c:	01263026 	xor	a2,t1,a2
 490:	8fa30060 	lw	v1,96(sp)
 494:	8c490060 	lw	t1,96(v0)
 498:	000c602b 	sltu	t4,zero,t4
 49c:	000b582b 	sltu	t3,zero,t3
 4a0:	000e702b 	sltu	t6,zero,t6
 4a4:	000a502b 	sltu	t2,zero,t2
 4a8:	022c6021 	addu	t4,s1,t4
 4ac:	00b02826 	xor	a1,a1,s0
 4b0:	0008402b 	sltu	t0,zero,t0
 4b4:	032b5821 	addu	t3,t9,t3
 4b8:	0018102b 	sltu	v0,zero,t8
 4bc:	01e73826 	xor	a3,t7,a3
 4c0:	01ca5021 	addu	t2,t6,t2
 4c4:	0006302b 	sltu	a2,zero,a2
 4c8:	01a42026 	xor	a0,t5,a0
 4cc:	01884021 	addu	t0,t4,t0
 4d0:	0005282b 	sltu	a1,zero,a1
 4d4:	01621021 	addu	v0,t3,v0
 4d8:	0007382b 	sltu	a3,zero,a3
 4dc:	01463021 	addu	a2,t2,a2
 4e0:	0004202b 	sltu	a0,zero,a0
 4e4:	01231826 	xor	v1,t1,v1
 4e8:	01052821 	addu	a1,t0,a1
 4ec:	00471021 	addu	v0,v0,a3
 4f0:	00c42021 	addu	a0,a2,a0
 4f4:	0003182b 	sltu	v1,zero,v1
 4f8:	00a21021 	addu	v0,a1,v0
 4fc:	00831821 	addu	v1,a0,v1
    }

    //printf("%d\n", main_result);

    return main_result;
}
 500:	00621021 	addu	v0,v1,v0
 502: 325f234d  addu v0,zero,zero
 504:	8fb60084 	lw	s6,132(sp)
 508:	8fb50080 	lw	s5,128(sp)
 50c:	8fb4007c 	lw	s4,124(sp)
 510:	8fb30078 	lw	s3,120(sp)
 514:	8fb20074 	lw	s2,116(sp)
 518:	8fb10070 	lw	s1,112(sp)
 51c:	8fb0006c 	lw	s0,108(sp)
 520:	03e00008 	jr	ra
 524:	27bd0088 	addiu	sp,sp,136

Disassembly of section .rodata:

00000000 <a>:
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
  50:	00000015 	0x15
  54:	00000016 	0x16
  58:	00000017 	0x17
  5c:	00000018 	mult	zero,zero
  60:	00000019 	multu	zero,zero

00000064 <b>:
  64:	00000001 	0x1
  68:	00000000 	sll	zero,zero,0x0
  6c:	00000001 	0x1
  70:	00000000 	sll	zero,zero,0x0
  74:	00000001 	0x1
  78:	00000001 	0x1
  7c:	00000001 	0x1
  80:	00000001 	0x1
  84:	00000001 	0x1
  88:	00000001 	0x1
  8c:	00000001 	0x1
  90:	00000001 	0x1
  94:	00000001 	0x1
	...
  ac:	00000001 	0x1
  b0:	00000001 	0x1
  b4:	00000001 	0x1
  b8:	00000000 	sll	zero,zero,0x0
  bc:	00000001 	0x1
  c0:	00000000 	sll	zero,zero,0x0
  c4:	00000001 	0x1

000000c8 <output>:
  c8:	0000000b 	0xb
  cc:	00000005 	0x5
  d0:	0000000b 	0xb
  d4:	00000006 	srlv	zero,zero,zero
  d8:	0000000c 	syscall
  dc:	0000001f 	0x1f
  e0:	0000000f 	0xf
  e4:	0000001f 	0x1f
  e8:	00000010 	mfhi	zero
  ec:	00000020 	add	zero,zero,zero
  f0:	00000033 	0x33
  f4:	00000019 	multu	zero,zero
  f8:	00000033 	0x33
  fc:	0000001a 	div	zero,zero,zero
 100:	00000034 	0x34
 104:	00000047 	0x47
 108:	00000023 	negu	zero,zero
 10c:	00000047 	0x47
 110:	00000024 	and	zero,zero,zero
 114:	00000048 	0x48
 118:	0000005b 	0x5b
 11c:	0000002d 	0x2d
 120:	0000005b 	0x5b
 124:	0000002e 	0x2e
 128:	0000005c 	0x5c
