
firmware.elf:     file format elf32-littleriscv


Disassembly of section .text:

80000000 <crtStart>:

.text

.global crtStart
crtStart:
  j _start
80000000:	0b00006f          	j	800000b0 <_start>
  nop
80000004:	00000013          	nop
  nop
80000008:	00000013          	nop
  nop
8000000c:	00000013          	nop
  nop
80000010:	00000013          	nop
  nop
80000014:	00000013          	nop
  nop
80000018:	00000013          	nop
  nop
8000001c:	00000013          	nop

80000020 <trap_entry>:
  
.global  trap_entry
trap_entry:
  sw x1,  - 1*4(sp)
80000020:	fe112e23          	sw	ra,-4(sp)
  sw x5,  - 2*4(sp)
80000024:	fe512c23          	sw	t0,-8(sp)
  sw x6,  - 3*4(sp)
80000028:	fe612a23          	sw	t1,-12(sp)
  sw x7,  - 4*4(sp)
8000002c:	fe712823          	sw	t2,-16(sp)
  sw x10, - 5*4(sp)
80000030:	fea12623          	sw	a0,-20(sp)
  sw x11, - 6*4(sp)
80000034:	feb12423          	sw	a1,-24(sp)
  sw x12, - 7*4(sp)
80000038:	fec12223          	sw	a2,-28(sp)
  sw x13, - 8*4(sp)
8000003c:	fed12023          	sw	a3,-32(sp)
  sw x14, - 9*4(sp)
80000040:	fce12e23          	sw	a4,-36(sp)
  sw x15, -10*4(sp)
80000044:	fcf12c23          	sw	a5,-40(sp)
  sw x16, -11*4(sp)
80000048:	fd012a23          	sw	a6,-44(sp)
  sw x17, -12*4(sp)
8000004c:	fd112823          	sw	a7,-48(sp)
  sw x28, -13*4(sp)
80000050:	fdc12623          	sw	t3,-52(sp)
  sw x29, -14*4(sp)
80000054:	fdd12423          	sw	t4,-56(sp)
  sw x30, -15*4(sp)
80000058:	fde12223          	sw	t5,-60(sp)
  sw x31, -16*4(sp)
8000005c:	fdf12023          	sw	t6,-64(sp)
  addi sp,sp,-16*4
80000060:	fc010113          	addi	sp,sp,-64
  call irqCallback
80000064:	36d010ef          	jal	ra,80001bd0 <irqCallback>
  lw x1 , 15*4(sp)
80000068:	03c12083          	lw	ra,60(sp)
  lw x5,  14*4(sp)
8000006c:	03812283          	lw	t0,56(sp)
  lw x6,  13*4(sp)
80000070:	03412303          	lw	t1,52(sp)
  lw x7,  12*4(sp)
80000074:	03012383          	lw	t2,48(sp)
  lw x10, 11*4(sp)
80000078:	02c12503          	lw	a0,44(sp)
  lw x11, 10*4(sp)
8000007c:	02812583          	lw	a1,40(sp)
  lw x12,  9*4(sp)
80000080:	02412603          	lw	a2,36(sp)
  lw x13,  8*4(sp)
80000084:	02012683          	lw	a3,32(sp)
  lw x14,  7*4(sp)
80000088:	01c12703          	lw	a4,28(sp)
  lw x15,  6*4(sp)
8000008c:	01812783          	lw	a5,24(sp)
  lw x16,  5*4(sp)
80000090:	01412803          	lw	a6,20(sp)
  lw x17,  4*4(sp)
80000094:	01012883          	lw	a7,16(sp)
  lw x28,  3*4(sp)
80000098:	00c12e03          	lw	t3,12(sp)
  lw x29,  2*4(sp)
8000009c:	00812e83          	lw	t4,8(sp)
  lw x30,  1*4(sp)
800000a0:	00412f03          	lw	t5,4(sp)
  lw x31,  0*4(sp)
800000a4:	00012f83          	lw	t6,0(sp)
  addi sp,sp,16*4
800000a8:	04010113          	addi	sp,sp,64
  mret
800000ac:	30200073          	mret

800000b0 <_start>:
#.equ    STACK_TOP, 0x200000       # 2MB total memory
#.equ    STACK_TOP, 0x200000       # 1MB total memory
.equ    STACK_TOP, 0x80020000       # 128KB total memory

_start:
    la  gp, __global_pointer$
800000b0:	00018193          	mv	gp,gp
    li  sp,STACK_TOP    # load stack pointer
800000b4:	80020137          	lui	sp,0x80020

# zero-init bss section
    la a0, _sbss
800000b8:	80818513          	addi	a0,gp,-2040 # 8000eb78 <_edata>
    la a1, _ebss
800000bc:	00011597          	auipc	a1,0x11
800000c0:	55458593          	addi	a1,a1,1364 # 80011610 <_ebss>
    bge a0, a1, end_init_bss
800000c4:	00b55863          	bge	a0,a1,800000d4 <end_init_bss>

800000c8 <loop_init_bss>:
loop_init_bss:
    sw zero, 0(a0)
800000c8:	00052023          	sw	zero,0(a0)
    addi a0, a0, 4
800000cc:	00450513          	addi	a0,a0,4
    blt a0, a1, loop_init_bss
800000d0:	feb54ce3          	blt	a0,a1,800000c8 <loop_init_bss>

800000d4 <end_init_bss>:

end_init_bss:
    li a0, 0x880     //880 enable timer + external interrupts
800000d4:	00001537          	lui	a0,0x1
800000d8:	88050513          	addi	a0,a0,-1920 # 880 <crtStart-0x7ffff780>
    csrw mie,a0
800000dc:	30451073          	csrw	mie,a0
    li a0, 0x1808     //1808 enable interrupts
800000e0:	00002537          	lui	a0,0x2
800000e4:	80850513          	addi	a0,a0,-2040 # 1808 <crtStart-0x7fffe7f8>
    csrw mstatus,a0
800000e8:	30051073          	csrw	mstatus,a0
    
    call main
800000ec:	1dd0d0ef          	jal	ra,8000dac8 <_end>

800000f0 <load_dir.part.0>:
// starting from `start`, load `len` file names into file_names, 
// file_dir. 
// *count is set to number of all valid entries and `file_len` is
// set to valid entries on this page.
// return: 0 if successful
int load_dir(char *dir, int start, int len, int *count) {
800000f0:	e6010113          	addi	sp,sp,-416 # 8001fe60 <STACK_TOP+0xfffffe60>
800000f4:	18812c23          	sw	s0,408(sp)
800000f8:	00050413          	mv	s0,a0
800000fc:	18912a23          	sw	s1,404(sp)
            init_ok = 1;
            break;
        }
    if (!init_ok) return 99;

    if (f_opendir(&d, dir) != 0) {
80000100:	00010513          	mv	a0,sp
int load_dir(char *dir, int start, int len, int *count) {
80000104:	00058493          	mv	s1,a1
    if (f_opendir(&d, dir) != 0) {
80000108:	00040593          	mv	a1,s0
int load_dir(char *dir, int start, int len, int *count) {
8000010c:	19312623          	sw	s3,396(sp)
80000110:	17712e23          	sw	s7,380(sp)
80000114:	18112e23          	sw	ra,412(sp)
80000118:	19212823          	sw	s2,400(sp)
8000011c:	19412423          	sw	s4,392(sp)
80000120:	19512223          	sw	s5,388(sp)
80000124:	19612023          	sw	s6,384(sp)
80000128:	17812c23          	sw	s8,376(sp)
8000012c:	00060993          	mv	s3,a2
80000130:	00068b93          	mv	s7,a3
    if (f_opendir(&d, dir) != 0) {
80000134:	638080ef          	jal	ra,8000876c <f_opendir>
80000138:	16051c63          	bnez	a0,800002b0 <load_dir.part.0+0x1c0>
        return -1;
    }
    // an entry to return to parent dir or main menu 
    int is_root = dir[1] == '\0';
    if (start == 0 && len > 0) {
8000013c:	10048863          	beqz	s1,8000024c <load_dir.part.0+0x15c>
            break;
        if ((fno.fattrib & AM_HID) || (fno.fattrib & AM_SYS))
             // skip hidden and system files
            continue;
        if (cnt >= start && file_len < len) {
            strncpy(file_names[file_len], fno.fname, 256);
80000140:	8000fb37          	lui	s6,0x8000f
            file_dir[file_len] = fno.fattrib & AM_DIR;
80000144:	80011ab7          	lui	s5,0x80011
            file_sizes[file_len] = fno.fsize;
80000148:	80011a37          	lui	s4,0x80011
int load_dir(char *dir, int start, int len, int *count) {
8000014c:	00100413          	li	s0,1
        if (cnt >= start && file_len < len) {
80000150:	80011937          	lui	s2,0x80011
            strncpy(file_names[file_len], fno.fname, 256);
80000154:	ff0b0b13          	addi	s6,s6,-16 # 8000eff0 <STACK_TOP+0xfffeeff0>
            file_dir[file_len] = fno.fattrib & AM_DIR;
80000158:	4a0a8a93          	addi	s5,s5,1184 # 800114a0 <STACK_TOP+0xffff14a0>
            file_sizes[file_len] = fno.fsize;
8000015c:	c48a0a13          	addi	s4,s4,-952 # 80010c48 <STACK_TOP+0xffff0c48>
            file_len++;
            DEBUG("%s\n", fno.fname);
80000160:	8000ec37          	lui	s8,0x8000e
    while (f_readdir(&d, &fno) == FR_OK) {
80000164:	05010593          	addi	a1,sp,80
80000168:	00010513          	mv	a0,sp
8000016c:	774080ef          	jal	ra,800088e0 <f_readdir>
80000170:	02051c63          	bnez	a0,800001a8 <load_dir.part.0+0xb8>
        if (fno.fname[0] == 0)
80000174:	06a14783          	lbu	a5,106(sp)
80000178:	02078863          	beqz	a5,800001a8 <load_dir.part.0+0xb8>
        if ((fno.fattrib & AM_HID) || (fno.fattrib & AM_SYS))
8000017c:	05c14783          	lbu	a5,92(sp)
80000180:	0067f793          	andi	a5,a5,6
80000184:	fe0790e3          	bnez	a5,80000164 <load_dir.part.0+0x74>
        if (cnt >= start && file_len < len) {
80000188:	00944663          	blt	s0,s1,80000194 <load_dir.part.0+0xa4>
8000018c:	83c92503          	lw	a0,-1988(s2) # 8001083c <STACK_TOP+0xffff083c>
80000190:	07354463          	blt	a0,s3,800001f8 <load_dir.part.0+0x108>
        }
        cnt++;
80000194:	00140413          	addi	s0,s0,1
    while (f_readdir(&d, &fno) == FR_OK) {
80000198:	05010593          	addi	a1,sp,80
8000019c:	00010513          	mv	a0,sp
800001a0:	740080ef          	jal	ra,800088e0 <f_readdir>
800001a4:	fc0508e3          	beqz	a0,80000174 <load_dir.part.0+0x84>
    }
    f_closedir(&d);
800001a8:	00010513          	mv	a0,sp
800001ac:	704080ef          	jal	ra,800088b0 <f_closedir>
    *count = cnt;
    DEBUG("load_dir: count=%d\n", cnt);
800001b0:	8000e537          	lui	a0,0x8000e
    *count = cnt;
800001b4:	008ba023          	sw	s0,0(s7)
    DEBUG("load_dir: count=%d\n", cnt);
800001b8:	00040593          	mv	a1,s0
800001bc:	c6850513          	addi	a0,a0,-920 # 8000dc68 <STACK_TOP+0xfffedc68>
800001c0:	278020ef          	jal	ra,80002438 <uart_printf>
    return 0;
800001c4:	00000513          	li	a0,0
}
800001c8:	19c12083          	lw	ra,412(sp)
800001cc:	19812403          	lw	s0,408(sp)
800001d0:	19412483          	lw	s1,404(sp)
800001d4:	19012903          	lw	s2,400(sp)
800001d8:	18c12983          	lw	s3,396(sp)
800001dc:	18812a03          	lw	s4,392(sp)
800001e0:	18412a83          	lw	s5,388(sp)
800001e4:	18012b03          	lw	s6,384(sp)
800001e8:	17c12b83          	lw	s7,380(sp)
800001ec:	17812c03          	lw	s8,376(sp)
800001f0:	1a010113          	addi	sp,sp,416
800001f4:	00008067          	ret
            strncpy(file_names[file_len], fno.fname, 256);
800001f8:	00851513          	slli	a0,a0,0x8
800001fc:	06a10593          	addi	a1,sp,106
80000200:	10000613          	li	a2,256
80000204:	00ab0533          	add	a0,s6,a0
80000208:	7c8020ef          	jal	ra,800029d0 <strncpy>
            file_dir[file_len] = fno.fattrib & AM_DIR;
8000020c:	83c92783          	lw	a5,-1988(s2)
80000210:	05c14683          	lbu	a3,92(sp)
            DEBUG("%s\n", fno.fname);
80000214:	06a10593          	addi	a1,sp,106
            file_dir[file_len] = fno.fattrib & AM_DIR;
80000218:	00279713          	slli	a4,a5,0x2
8000021c:	00ea8633          	add	a2,s5,a4
80000220:	0106f693          	andi	a3,a3,16
80000224:	00d62023          	sw	a3,0(a2)
            file_sizes[file_len] = fno.fsize;
80000228:	05012683          	lw	a3,80(sp)
8000022c:	00ea0733          	add	a4,s4,a4
            file_len++;
80000230:	00178793          	addi	a5,a5,1
            DEBUG("%s\n", fno.fname);
80000234:	d08c0513          	addi	a0,s8,-760 # 8000dd08 <STACK_TOP+0xfffedd08>
            file_sizes[file_len] = fno.fsize;
80000238:	00d72023          	sw	a3,0(a4)
            file_len++;
8000023c:	82f92e23          	sw	a5,-1988(s2)
        cnt++;
80000240:	00140413          	addi	s0,s0,1
            DEBUG("%s\n", fno.fname);
80000244:	1f4020ef          	jal	ra,80002438 <uart_printf>
        cnt++;
80000248:	f51ff06f          	j	80000198 <load_dir.part.0+0xa8>
    if (start == 0 && len > 0) {
8000024c:	ef305ae3          	blez	s3,80000140 <load_dir.part.0+0x50>
        if (is_root) {
80000250:	00144783          	lbu	a5,1(s0)
            strncpy(file_names[0], "<< Return to main menu", 256);
80000254:	10000613          	li	a2,256
        if (is_root) {
80000258:	02078c63          	beqz	a5,80000290 <load_dir.part.0+0x1a0>
            strncpy(file_names[0], "..", 256);
8000025c:	8000e5b7          	lui	a1,0x8000e
80000260:	8000f537          	lui	a0,0x8000f
80000264:	c6458593          	addi	a1,a1,-924 # 8000dc64 <STACK_TOP+0xfffedc64>
80000268:	ff050513          	addi	a0,a0,-16 # 8000eff0 <STACK_TOP+0xfffeeff0>
8000026c:	764020ef          	jal	ra,800029d0 <strncpy>
            file_dir[0] = 1;
80000270:	800117b7          	lui	a5,0x80011
80000274:	00100713          	li	a4,1
80000278:	4ae7a023          	sw	a4,1184(a5) # 800114a0 <STACK_TOP+0xffff14a0>
        file_len++;
8000027c:	80011737          	lui	a4,0x80011
80000280:	83c72783          	lw	a5,-1988(a4) # 8001083c <STACK_TOP+0xffff083c>
80000284:	00178793          	addi	a5,a5,1
80000288:	82f72e23          	sw	a5,-1988(a4)
8000028c:	eb5ff06f          	j	80000140 <load_dir.part.0+0x50>
            strncpy(file_names[0], "<< Return to main menu", 256);
80000290:	8000e5b7          	lui	a1,0x8000e
80000294:	8000f537          	lui	a0,0x8000f
80000298:	c4c58593          	addi	a1,a1,-948 # 8000dc4c <STACK_TOP+0xfffedc4c>
8000029c:	ff050513          	addi	a0,a0,-16 # 8000eff0 <STACK_TOP+0xfffeeff0>
800002a0:	730020ef          	jal	ra,800029d0 <strncpy>
            file_dir[0] = 0;
800002a4:	800117b7          	lui	a5,0x80011
800002a8:	4a07a023          	sw	zero,1184(a5) # 800114a0 <STACK_TOP+0xffff14a0>
800002ac:	fd1ff06f          	j	8000027c <load_dir.part.0+0x18c>
        return -1;
800002b0:	fff00513          	li	a0,-1
800002b4:	f15ff06f          	j	800001c8 <load_dir.part.0+0xd8>

800002b8 <load_option>:
int load_option()  {
800002b8:	98010113          	addi	sp,sp,-1664
    if (f_open(&f, OPTION_FILE, FA_READ))
800002bc:	8000e5b7          	lui	a1,0x8000e
800002c0:	00100613          	li	a2,1
800002c4:	c7c58593          	addi	a1,a1,-900 # 8000dc7c <STACK_TOP+0xfffedc7c>
800002c8:	00010513          	mv	a0,sp
int load_option()  {
800002cc:	66812c23          	sw	s0,1656(sp)
800002d0:	66112e23          	sw	ra,1660(sp)
800002d4:	66912a23          	sw	s1,1652(sp)
800002d8:	67212823          	sw	s2,1648(sp)
800002dc:	67312623          	sw	s3,1644(sp)
800002e0:	67412423          	sw	s4,1640(sp)
800002e4:	67512223          	sw	s5,1636(sp)
800002e8:	67612023          	sw	s6,1632(sp)
800002ec:	65712e23          	sw	s7,1628(sp)
800002f0:	65812c23          	sw	s8,1624(sp)
    if (f_open(&f, OPTION_FILE, FA_READ))
800002f4:	130070ef          	jal	ra,80007424 <f_open>
800002f8:	00100413          	li	s0,1
800002fc:	0c051063          	bnez	a0,800003bc <load_option+0x104>
        uart_printf("key=%s, value=%s\n", key, value);
80000300:	8000e9b7          	lui	s3,0x8000e
        if (strcmp(key, "osd_key") == 0) {
80000304:	8000e937          	lui	s2,0x8000e
        } else if (strcmp(key, "backup_bsram") == 0) {
80000308:	8000eab7          	lui	s5,0x8000e
            if (strcasecmp(value, "true") == 0)
8000030c:	8000eb37          	lui	s6,0x8000e
                option_backup_bsram = true;
80000310:	00100c13          	li	s8,1
            option_osd_key = atoi(value);
80000314:	8000fa37          	lui	s4,0x8000f
    while (f_gets(buf, 1024, &f)) {
80000318:	00010613          	mv	a2,sp
8000031c:	40000593          	li	a1,1024
80000320:	25010513          	addi	a0,sp,592
80000324:	44c090ef          	jal	ra,80009770 <f_gets>
80000328:	10050063          	beqz	a0,80000428 <load_option+0x170>
        line = trimwhitespace(buf);
8000032c:	25010513          	addi	a0,sp,592
80000330:	764020ef          	jal	ra,80002a94 <trimwhitespace>
        if (line[0] == '\0' || line[0] == '[' || line[0] == ';' || line[0] == '#')
80000334:	00054783          	lbu	a5,0(a0)
        line = trimwhitespace(buf);
80000338:	00050413          	mv	s0,a0
        if (line[0] == '\0' || line[0] == '[' || line[0] == ';' || line[0] == '#')
8000033c:	fc078ee3          	beqz	a5,80000318 <load_option+0x60>
80000340:	fc578713          	addi	a4,a5,-59
80000344:	0df77713          	andi	a4,a4,223
80000348:	fc0708e3          	beqz	a4,80000318 <load_option+0x60>
8000034c:	02300713          	li	a4,35
80000350:	fce784e3          	beq	a5,a4,80000318 <load_option+0x60>
        char *s = strchr(line, '=');
80000354:	03d00593          	li	a1,61
80000358:	6a0020ef          	jal	ra,800029f8 <strchr>
8000035c:	00050493          	mv	s1,a0
        if (!s) {
80000360:	04050863          	beqz	a0,800003b0 <load_option+0xf8>
        *s='\0';
80000364:	00050023          	sb	zero,0(a0)
        key = trimwhitespace(line);
80000368:	00040513          	mv	a0,s0
8000036c:	728020ef          	jal	ra,80002a94 <trimwhitespace>
80000370:	00050413          	mv	s0,a0
        value = trimwhitespace(s+1);
80000374:	00148513          	addi	a0,s1,1
80000378:	71c020ef          	jal	ra,80002a94 <trimwhitespace>
        uart_printf("key=%s, value=%s\n", key, value);
8000037c:	00050613          	mv	a2,a0
80000380:	00040593          	mv	a1,s0
        value = trimwhitespace(s+1);
80000384:	00050493          	mv	s1,a0
        uart_printf("key=%s, value=%s\n", key, value);
80000388:	c8c98513          	addi	a0,s3,-884 # 8000dc8c <STACK_TOP+0xfffedc8c>
8000038c:	0ac020ef          	jal	ra,80002438 <uart_printf>
        if (strcmp(key, "osd_key") == 0) {
80000390:	ca090593          	addi	a1,s2,-864 # 8000dca0 <STACK_TOP+0xfffedca0>
80000394:	00040513          	mv	a0,s0
80000398:	3f4020ef          	jal	ra,8000278c <strcmp>
8000039c:	04051a63          	bnez	a0,800003f0 <load_option+0x138>
            option_osd_key = atoi(value);
800003a0:	00048513          	mv	a0,s1
800003a4:	768020ef          	jal	ra,80002b0c <atoi>
800003a8:	b6aa2823          	sw	a0,-1168(s4) # 8000eb70 <STACK_TOP+0xfffeeb70>
            if (option_osd_key <= 0) {
800003ac:	f6a046e3          	bgtz	a0,80000318 <load_option+0x60>
    f_close(&f);
800003b0:	00010513          	mv	a0,sp
            r = OPTION_INVALID;
800003b4:	00200413          	li	s0,2
    f_close(&f);
800003b8:	775070ef          	jal	ra,8000832c <f_close>
}
800003bc:	00040513          	mv	a0,s0
800003c0:	67c12083          	lw	ra,1660(sp)
800003c4:	67812403          	lw	s0,1656(sp)
800003c8:	67412483          	lw	s1,1652(sp)
800003cc:	67012903          	lw	s2,1648(sp)
800003d0:	66c12983          	lw	s3,1644(sp)
800003d4:	66812a03          	lw	s4,1640(sp)
800003d8:	66412a83          	lw	s5,1636(sp)
800003dc:	66012b03          	lw	s6,1632(sp)
800003e0:	65c12b83          	lw	s7,1628(sp)
800003e4:	65812c03          	lw	s8,1624(sp)
800003e8:	68010113          	addi	sp,sp,1664
800003ec:	00008067          	ret
        } else if (strcmp(key, "backup_bsram") == 0) {
800003f0:	ca8a8593          	addi	a1,s5,-856 # 8000dca8 <STACK_TOP+0xfffedca8>
800003f4:	00040513          	mv	a0,s0
800003f8:	394020ef          	jal	ra,8000278c <strcmp>
800003fc:	f0051ee3          	bnez	a0,80000318 <load_option+0x60>
            if (strcasecmp(value, "true") == 0)
80000400:	cb8b0593          	addi	a1,s6,-840 # 8000dcb8 <STACK_TOP+0xfffedcb8>
80000404:	00048513          	mv	a0,s1
80000408:	3b4020ef          	jal	ra,800027bc <strcasecmp>
8000040c:	02051663          	bnez	a0,80000438 <load_option+0x180>
    while (f_gets(buf, 1024, &f)) {
80000410:	00010613          	mv	a2,sp
80000414:	40000593          	li	a1,1024
80000418:	25010513          	addi	a0,sp,592
                option_backup_bsram = true;
8000041c:	c7818423          	sb	s8,-920(gp) # 8000efd8 <option_backup_bsram>
    while (f_gets(buf, 1024, &f)) {
80000420:	350090ef          	jal	ra,80009770 <f_gets>
80000424:	f00514e3          	bnez	a0,8000032c <load_option+0x74>
    f_close(&f);
80000428:	00010513          	mv	a0,sp
    int r = 0;
8000042c:	00000413          	li	s0,0
    f_close(&f);
80000430:	6fd070ef          	jal	ra,8000832c <f_close>
    return r;
80000434:	f89ff06f          	j	800003bc <load_option+0x104>
                option_backup_bsram = false;
80000438:	c6018423          	sb	zero,-920(gp) # 8000efd8 <option_backup_bsram>
8000043c:	eddff06f          	j	80000318 <load_option+0x60>

80000440 <status>:
void status(char *msg) {
80000440:	ff010113          	addi	sp,sp,-16
80000444:	00912223          	sw	s1,4(sp)
    cursor(0, 27);
80000448:	01b00593          	li	a1,27
void status(char *msg) {
8000044c:	00050493          	mv	s1,a0
    cursor(0, 27);
80000450:	00000513          	li	a0,0
void status(char *msg) {
80000454:	00812423          	sw	s0,8(sp)
80000458:	00112623          	sw	ra,12(sp)
    cursor(0, 27);
8000045c:	02000413          	li	s0,32
80000460:	79c010ef          	jal	ra,80001bfc <cursor>
        putchar(' ');
80000464:	fff40413          	addi	s0,s0,-1
80000468:	02000513          	li	a0,32
8000046c:	7dc010ef          	jal	ra,80001c48 <putchar>
    for (int i = 0; i < 32; i++)
80000470:	fe041ae3          	bnez	s0,80000464 <status+0x24>
    cursor(2, 27);
80000474:	00200513          	li	a0,2
80000478:	01b00593          	li	a1,27
8000047c:	780010ef          	jal	ra,80001bfc <cursor>
}
80000480:	00812403          	lw	s0,8(sp)
80000484:	00c12083          	lw	ra,12(sp)
    print(msg);
80000488:	00048513          	mv	a0,s1
}
8000048c:	00412483          	lw	s1,4(sp)
80000490:	01010113          	addi	sp,sp,16
    print(msg);
80000494:	0750106f          	j	80001d08 <print>

80000498 <backup_load.part.1>:
}

void backup_load(char *name, int size) {
    core_backup_valid = false;
    if (!option_backup_bsram || size == 0) return;
    char path[266] = "/saves/";
80000498:	766177b7          	lui	a5,0x76617
void backup_load(char *name, int size) {
8000049c:	b6010113          	addi	sp,sp,-1184
    char path[266] = "/saves/";
800004a0:	32f78793          	addi	a5,a5,815 # 7661732f <crtStart-0x99e8cd1>
800004a4:	00f12223          	sw	a5,4(sp)
800004a8:	002f77b7          	lui	a5,0x2f7
void backup_load(char *name, int size) {
800004ac:	49212823          	sw	s2,1168(sp)
    char path[266] = "/saves/";
800004b0:	00000593          	li	a1,0
800004b4:	36578793          	addi	a5,a5,869 # 2f7365 <crtStart-0x7fd08c9b>
void backup_load(char *name, int size) {
800004b8:	00050913          	mv	s2,a0
    char path[266] = "/saves/";
800004bc:	10200613          	li	a2,258
800004c0:	00c10513          	addi	a0,sp,12
void backup_load(char *name, int size) {
800004c4:	48112e23          	sw	ra,1180(sp)
800004c8:	48812c23          	sw	s0,1176(sp)
800004cc:	48912a23          	sw	s1,1172(sp)
800004d0:	49312623          	sw	s3,1164(sp)
    char path[266] = "/saves/";
800004d4:	00f12423          	sw	a5,8(sp)
800004d8:	248020ef          	jal	ra,80002720 <memset>
    FILINFO fno;
    uint8_t *bsram = (uint8_t *)0x700000;			// directly read into BSRAM

    if (f_stat(path, &fno) != FR_OK) {
800004dc:	11010593          	addi	a1,sp,272
800004e0:	00410513          	addi	a0,sp,4
800004e4:	490080ef          	jal	ra,80008974 <f_stat>
800004e8:	00050863          	beqz	a0,800004f8 <backup_load.part.1+0x60>
        if (f_mkdir(path) != FR_OK) {
800004ec:	00410513          	addi	a0,sp,4
800004f0:	261080ef          	jal	ra,80008f50 <f_mkdir>
800004f4:	0c051063          	bnez	a0,800005b4 <backup_load.part.1+0x11c>
            status("Cannot create /saves");
            uart_printf("Cannot create /saves\n");
            goto backup_load_crc;
        }
    }
    strcat(path, core_backup_name);
800004f8:	80011437          	lui	s0,0x80011
800004fc:	4fc40593          	addi	a1,s0,1276 # 800114fc <STACK_TOP+0xffff14fc>
80000500:	00410513          	addi	a0,sp,4
80000504:	3ec020ef          	jal	ra,800028f0 <strcat>
    uart_printf("Loading save file from: %s\n", core_backup_name);
80000508:	8000e537          	lui	a0,0x8000e
8000050c:	4fc40593          	addi	a1,s0,1276
80000510:	cf050513          	addi	a0,a0,-784 # 8000dcf0 <STACK_TOP+0xfffedcf0>
80000514:	725010ef          	jal	ra,80002438 <uart_printf>
    FIL f;
    if (f_open(&f, path, FA_READ) != FR_OK) {
80000518:	00100613          	li	a2,1
8000051c:	00410593          	addi	a1,sp,4
80000520:	23010513          	addi	a0,sp,560
80000524:	701060ef          	jal	ra,80007424 <f_open>
80000528:	00050413          	mv	s0,a0
8000052c:	0a051263          	bnez	a0,800005d0 <backup_load.part.1+0x138>
        core_backup_valid = true;					// new save file, mark as valid
        uart_printf("Cannot open save file, assuming new\n");
        goto backup_load_crc;
    }
    uint8_t *p = bsram;	
80000530:	007004b7          	lui	s1,0x700
    unsigned int load = 0;
    while (load < size) {
        unsigned int br;
        if (f_read(&f, p, 1024, &br) != FR_OK || br < 1024) 
80000534:	3ff00993          	li	s3,1023
    while (load < size) {
80000538:	00091e63          	bnez	s2,80000554 <backup_load.part.1+0xbc>
8000053c:	0300006f          	j	8000056c <backup_load.part.1+0xd4>
        if (f_read(&f, p, 1024, &br) != FR_OK || br < 1024) 
80000540:	00012783          	lw	a5,0(sp)
80000544:	02f9f463          	bgeu	s3,a5,8000056c <backup_load.part.1+0xd4>
            break;
        p += br;
        load += br;
80000548:	00f40433          	add	s0,s0,a5
        p += br;
8000054c:	00f484b3          	add	s1,s1,a5
    while (load < size) {
80000550:	01247e63          	bgeu	s0,s2,8000056c <backup_load.part.1+0xd4>
        if (f_read(&f, p, 1024, &br) != FR_OK || br < 1024) 
80000554:	00048593          	mv	a1,s1
80000558:	00010693          	mv	a3,sp
8000055c:	40000613          	li	a2,1024
80000560:	23010513          	addi	a0,sp,560
80000564:	3b8070ef          	jal	ra,8000791c <f_read>
80000568:	fc050ce3          	beqz	a0,80000540 <backup_load.part.1+0xa8>
    }
    core_backup_valid = true;
8000056c:	800117b7          	lui	a5,0x80011
80000570:	00100713          	li	a4,1
    f_close(&f);
80000574:	23010513          	addi	a0,sp,560
    core_backup_valid = true;
80000578:	c4e78223          	sb	a4,-956(a5) # 80010c44 <STACK_TOP+0xffff0c44>
    f_close(&f);
8000057c:	5b1070ef          	jal	ra,8000832c <f_close>
    uart_printf("Save file loaded\n", load);
80000580:	8000e537          	lui	a0,0x8000e
80000584:	00040593          	mv	a1,s0
80000588:	d3450513          	addi	a0,a0,-716 # 8000dd34 <STACK_TOP+0xfffedd34>
8000058c:	6ad010ef          	jal	ra,80002438 <uart_printf>

backup_load_crc:
        reg_cartram_dirty = 0;

    return;
}
80000590:	49c12083          	lw	ra,1180(sp)
80000594:	49812403          	lw	s0,1176(sp)
        reg_cartram_dirty = 0;
80000598:	020007b7          	lui	a5,0x2000
8000059c:	0807a023          	sw	zero,128(a5) # 2000080 <crtStart-0x7dffff80>
}
800005a0:	49412483          	lw	s1,1172(sp)
800005a4:	49012903          	lw	s2,1168(sp)
800005a8:	48c12983          	lw	s3,1164(sp)
800005ac:	4a010113          	addi	sp,sp,1184
800005b0:	00008067          	ret
            status("Cannot create /saves");
800005b4:	8000e537          	lui	a0,0x8000e
800005b8:	cc050513          	addi	a0,a0,-832 # 8000dcc0 <STACK_TOP+0xfffedcc0>
800005bc:	e85ff0ef          	jal	ra,80000440 <status>
            uart_printf("Cannot create /saves\n");
800005c0:	8000e537          	lui	a0,0x8000e
800005c4:	cd850513          	addi	a0,a0,-808 # 8000dcd8 <STACK_TOP+0xfffedcd8>
800005c8:	671010ef          	jal	ra,80002438 <uart_printf>
            goto backup_load_crc;
800005cc:	fc5ff06f          	j	80000590 <backup_load.part.1+0xf8>
        uart_printf("Cannot open save file, assuming new\n");
800005d0:	8000e537          	lui	a0,0x8000e
        core_backup_valid = true;					// new save file, mark as valid
800005d4:	800117b7          	lui	a5,0x80011
800005d8:	00100713          	li	a4,1
        uart_printf("Cannot open save file, assuming new\n");
800005dc:	d0c50513          	addi	a0,a0,-756 # 8000dd0c <STACK_TOP+0xfffedd0c>
        core_backup_valid = true;					// new save file, mark as valid
800005e0:	c4e78223          	sb	a4,-956(a5) # 80010c44 <STACK_TOP+0xffff0c44>
        uart_printf("Cannot open save file, assuming new\n");
800005e4:	655010ef          	jal	ra,80002438 <uart_printf>
        goto backup_load_crc;
800005e8:	fa9ff06f          	j	80000590 <backup_load.part.1+0xf8>

800005ec <backup_save.part.3>:

// return 0: successfully saved, 1: BSRAM unchanged, 2: file write failure
int backup_save(char *name, int size) {
    if (!option_backup_bsram || !core_backup_valid || size == 0) return 1;
    char path[266] = "/saves/";
800005ec:	766177b7          	lui	a5,0x76617
int backup_save(char *name, int size) {
800005f0:	c9010113          	addi	sp,sp,-880
    char path[266] = "/saves/";
800005f4:	32f78793          	addi	a5,a5,815 # 7661732f <crtStart-0x99e8cd1>
800005f8:	00f12223          	sw	a5,4(sp)
800005fc:	002f77b7          	lui	a5,0x2f7
80000600:	36578793          	addi	a5,a5,869 # 2f7365 <crtStart-0x7fd08c9b>
int backup_save(char *name, int size) {
80000604:	36912223          	sw	s1,868(sp)
    char path[266] = "/saves/";
80000608:	10200613          	li	a2,258
8000060c:	00000593          	li	a1,0
int backup_save(char *name, int size) {
80000610:	00050493          	mv	s1,a0
    char path[266] = "/saves/";
80000614:	00c10513          	addi	a0,sp,12
80000618:	00f12423          	sw	a5,8(sp)
int backup_save(char *name, int size) {
8000061c:	36112623          	sw	ra,876(sp)
80000620:	36812423          	sw	s0,872(sp)
80000624:	37212023          	sw	s2,864(sp)
    char path[266] = "/saves/";
80000628:	0f8020ef          	jal	ra,80002720 <memset>
    FIL f;
    uint8_t *bsram = (uint8_t *)0x700000;		// directly read from BSRAM
    int r = 0;

    uart_printf("backup_save: start\n");
8000062c:	8000e537          	lui	a0,0x8000e
80000630:	d4850513          	addi	a0,a0,-696 # 8000dd48 <STACK_TOP+0xfffedd48>

    // first check if BSRAM content is changed since last save
    // GBA uses dirty flag
    if (reg_cartram_dirty == 0) {
80000634:	02000437          	lui	s0,0x2000
    uart_printf("backup_save: start\n");
80000638:	601010ef          	jal	ra,80002438 <uart_printf>
    if (reg_cartram_dirty == 0) {
8000063c:	08042783          	lw	a5,128(s0) # 2000080 <crtStart-0x7dffff80>
80000640:	0c078e63          	beqz	a5,8000071c <backup_save.part.3+0x130>
        r = 1;
        uart_printf("Save data not changed\n");
        goto save_end;
    }
    uart_printf("Save data CHANGED\n");
80000644:	8000e537          	lui	a0,0x8000e
80000648:	d7450513          	addi	a0,a0,-652 # 8000dd74 <STACK_TOP+0xfffedd74>
8000064c:	5ed010ef          	jal	ra,80002438 <uart_printf>
    reg_cartram_dirty = 0;

    strcat(path, core_backup_name);
80000650:	80011937          	lui	s2,0x80011
80000654:	4fc90593          	addi	a1,s2,1276 # 800114fc <STACK_TOP+0xffff14fc>
    reg_cartram_dirty = 0;
80000658:	08042023          	sw	zero,128(s0)
    strcat(path, core_backup_name);
8000065c:	00410513          	addi	a0,sp,4
80000660:	290020ef          	jal	ra,800028f0 <strcat>
    if (f_open(&f, path, FA_WRITE | FA_CREATE_ALWAYS) != FR_OK) {
80000664:	00a00613          	li	a2,10
80000668:	00410593          	addi	a1,sp,4
8000066c:	11010513          	addi	a0,sp,272
80000670:	5b5060ef          	jal	ra,80007424 <f_open>
80000674:	06051463          	bnez	a0,800006dc <backup_save.part.3+0xf0>
        goto save_end;
    }
    unsigned int bw;
    // for (int off = 0; off < size; off += bw) {
    // 	if (f_write(&f, bsram, 1024, &bw) != FR_OK) {
    uart_printf("Writing save file to: %s, len=%d\n", core_backup_name, size);
80000678:	8000e537          	lui	a0,0x8000e
8000067c:	00048613          	mv	a2,s1
80000680:	4fc90593          	addi	a1,s2,1276
80000684:	da050513          	addi	a0,a0,-608 # 8000dda0 <STACK_TOP+0xfffedda0>
80000688:	5b1010ef          	jal	ra,80002438 <uart_printf>
    if (f_write(&f, bsram, size, &bw) != FR_OK || bw != size) {
8000068c:	00010693          	mv	a3,sp
80000690:	00048613          	mv	a2,s1
80000694:	007005b7          	lui	a1,0x700
80000698:	11010513          	addi	a0,sp,272
8000069c:	540070ef          	jal	ra,80007bdc <f_write>
800006a0:	00051863          	bnez	a0,800006b0 <backup_save.part.3+0xc4>
800006a4:	00012783          	lw	a5,0(sp)
    int r = 0;
800006a8:	00000413          	li	s0,0
    if (f_write(&f, bsram, size, &bw) != FR_OK || bw != size) {
800006ac:	02f48263          	beq	s1,a5,800006d0 <backup_save.part.3+0xe4>
        status("Write failure");
800006b0:	8000e537          	lui	a0,0x8000e
800006b4:	dc450513          	addi	a0,a0,-572 # 8000ddc4 <STACK_TOP+0xfffeddc4>
800006b8:	d89ff0ef          	jal	ra,80000440 <status>
        uart_printf("Write failure, bw=%d\n", bw);
800006bc:	00012583          	lw	a1,0(sp)
800006c0:	8000e537          	lui	a0,0x8000e
800006c4:	dd450513          	addi	a0,a0,-556 # 8000ddd4 <STACK_TOP+0xfffeddd4>
800006c8:	571010ef          	jal	ra,80002438 <uart_printf>
        r = 2;
800006cc:	00200413          	li	s0,2
        goto bsram_save_close;
    }
    // }

bsram_save_close:
    f_close(&f);
800006d0:	11010513          	addi	a0,sp,272
800006d4:	459070ef          	jal	ra,8000832c <f_close>
800006d8:	01c0006f          	j	800006f4 <backup_save.part.3+0x108>
        status("Cannot write save file");
800006dc:	8000e437          	lui	s0,0x8000e
800006e0:	d8840513          	addi	a0,s0,-632 # 8000dd88 <STACK_TOP+0xfffedd88>
800006e4:	d5dff0ef          	jal	ra,80000440 <status>
        uart_printf("Cannot write save file");
800006e8:	d8840513          	addi	a0,s0,-632
800006ec:	54d010ef          	jal	ra,80002438 <uart_printf>
        r = 2;
800006f0:	00200413          	li	s0,2

save_end:
    uart_printf("backup_save: end\n");
800006f4:	8000e537          	lui	a0,0x8000e
800006f8:	dec50513          	addi	a0,a0,-532 # 8000ddec <STACK_TOP+0xfffeddec>
800006fc:	53d010ef          	jal	ra,80002438 <uart_printf>
    return r;
}
80000700:	00040513          	mv	a0,s0
80000704:	36c12083          	lw	ra,876(sp)
80000708:	36812403          	lw	s0,872(sp)
8000070c:	36412483          	lw	s1,868(sp)
80000710:	36012903          	lw	s2,864(sp)
80000714:	37010113          	addi	sp,sp,880
80000718:	00008067          	ret
        uart_printf("Save data not changed\n");
8000071c:	8000e537          	lui	a0,0x8000e
80000720:	d5c50513          	addi	a0,a0,-676 # 8000dd5c <STACK_TOP+0xfffedd5c>
80000724:	515010ef          	jal	ra,80002438 <uart_printf>
        r = 1;
80000728:	00100413          	li	s0,1
8000072c:	fc9ff06f          	j	800006f4 <backup_save.part.3+0x108>

80000730 <message>:
void message(char *msg, int center) {
80000730:	f9010113          	addi	sp,sp,-112
80000734:	06812423          	sw	s0,104(sp)
80000738:	06912223          	sw	s1,100(sp)
8000073c:	07212023          	sw	s2,96(sp)
80000740:	05312e23          	sw	s3,92(sp)
80000744:	05412c23          	sw	s4,88(sp)
80000748:	05512a23          	sw	s5,84(sp)
8000074c:	05812423          	sw	s8,72(sp)
80000750:	05912223          	sw	s9,68(sp)
80000754:	00050493          	mv	s1,a0
80000758:	06112623          	sw	ra,108(sp)
8000075c:	05612823          	sw	s6,80(sp)
80000760:	05712623          	sw	s7,76(sp)
80000764:	05a12023          	sw	s10,64(sp)
80000768:	03b12e23          	sw	s11,60(sp)
8000076c:	00058c93          	mv	s9,a1
    int len = strlen(msg);
80000770:	2d4020ef          	jal	ra,80002a44 <strlen>
80000774:	00810993          	addi	s3,sp,8
80000778:	00050a93          	mv	s5,a0
    char *sol = msg;
8000077c:	00048913          	mv	s2,s1
    for (int i = 0; i < 10; i++) {
80000780:	00000c13          	li	s8,0
    int w[10], lines=10, maxw = 0;
80000784:	00000413          	li	s0,0
    if (x > y) return x;
    else       return y;
}

inline int min(int x, int y) {
    if (x < y) return x;
80000788:	01900a13          	li	s4,25
        char *eol = strchr(sol, '\n');
8000078c:	00090513          	mv	a0,s2
80000790:	00a00593          	li	a1,10
80000794:	264020ef          	jal	ra,800029f8 <strchr>
            w[i] = min(eol - sol, 26);
80000798:	412507b3          	sub	a5,a0,s2
    for (int i = 0; i < 10; i++) {
8000079c:	00a00713          	li	a4,10
        if (eol) { // found \n
800007a0:	1a050e63          	beqz	a0,8000095c <message+0x22c>
    for (int i = 0; i < 10; i++) {
800007a4:	001c0c13          	addi	s8,s8,1
800007a8:	00fa5463          	bge	s4,a5,800007b0 <message+0x80>
    else       return y;
800007ac:	01a00793          	li	a5,26
            w[i] = min(eol - sol, 26);
800007b0:	00f9a023          	sw	a5,0(s3)
    if (x > y) return x;
800007b4:	00f45463          	bge	s0,a5,800007bc <message+0x8c>
800007b8:	00078413          	mv	s0,a5
            sol = eol+1;
800007bc:	00150913          	addi	s2,a0,1
800007c0:	00498993          	addi	s3,s3,4
    for (int i = 0; i < 10; i++) {
800007c4:	fcec14e3          	bne	s8,a4,8000078c <message+0x5c>
    int x0 = 16 - ((maxw + 2) >> 1);
800007c8:	00240d13          	addi	s10,s0,2
800007cc:	401d5d13          	srai	s10,s10,0x1
800007d0:	01000993          	li	s3,16
800007d4:	41a989b3          	sub	s3,s3,s10
    int x1 = x0 + maxw + 2;
800007d8:	01340433          	add	s0,s0,s3
800007dc:	00240b13          	addi	s6,s0,2
    int y1 = y0 + lines + 2;
800007e0:	01400d93          	li	s11,20
800007e4:	01200b93          	li	s7,18
    int y0 = 14 - ((lines + 2) >> 1);
800007e8:	00800a93          	li	s5,8
            lines = i+1;
800007ec:	000a8913          	mv	s2,s5
            if ((x == x0 || x == x1-1) && (y == y0 || y == y1-1))
800007f0:	001b8b93          	addi	s7,s7,1
            else if (x == x0 || x == x1-1)
800007f4:	00140a13          	addi	s4,s0,1
        for (int x = x0; x < x1; x++) {
800007f8:	00098413          	mv	s0,s3
800007fc:	0369d863          	bge	s3,s6,8000082c <message+0xfc>
            cursor(x, y);
80000800:	00090593          	mv	a1,s2
80000804:	00040513          	mv	a0,s0
80000808:	3f4010ef          	jal	ra,80001bfc <cursor>
            if ((x == x0 || x == x1-1) && (y == y0 || y == y1-1))
8000080c:	0b340e63          	beq	s0,s3,800008c8 <message+0x198>
80000810:	0a8a0c63          	beq	s4,s0,800008c8 <message+0x198>
            else if (y == y0 || y == y1-1)
80000814:	0b590463          	beq	s2,s5,800008bc <message+0x18c>
80000818:	0b2b8263          	beq	s7,s2,800008bc <message+0x18c>
                putchar(' ');
8000081c:	02000513          	li	a0,32
80000820:	428010ef          	jal	ra,80001c48 <putchar>
        for (int x = x0; x < x1; x++) {
80000824:	00140413          	addi	s0,s0,1
80000828:	fd641ce3          	bne	s0,s6,80000800 <message+0xd0>
    for (int y = y0; y < y1; y++)
8000082c:	00190913          	addi	s2,s2,1
80000830:	fdb944e3          	blt	s2,s11,800007f8 <message+0xc8>
80000834:	415009b3          	neg	s3,s5
            cursor(x0+1, y0+i+1);
80000838:	01100793          	li	a5,17
8000083c:	001a8913          	addi	s2,s5,1
80000840:	00299993          	slli	s3,s3,0x2
80000844:	015c0ab3          	add	s5,s8,s5
80000848:	41a78d33          	sub	s10,a5,s10
            cursor(16-(w[i]>>1), y0+i+1);
8000084c:	01000a13          	li	s4,16
        while (*s != '\n' && *s != '\0') {
80000850:	00a00413          	li	s0,10
        if (center)
80000854:	040c8c63          	beqz	s9,800008ac <message+0x17c>
            cursor(16-(w[i]>>1), y0+i+1);
80000858:	00291793          	slli	a5,s2,0x2
8000085c:	013787b3          	add	a5,a5,s3
80000860:	00810713          	addi	a4,sp,8
80000864:	00f707b3          	add	a5,a4,a5
80000868:	ffc7a503          	lw	a0,-4(a5)
8000086c:	00090593          	mv	a1,s2
80000870:	40155513          	srai	a0,a0,0x1
80000874:	40aa0533          	sub	a0,s4,a0
80000878:	384010ef          	jal	ra,80001bfc <cursor>
        while (*s != '\n' && *s != '\0') {
8000087c:	0004c503          	lbu	a0,0(s1) # 700000 <crtStart-0x7f900000>
80000880:	00850c63          	beq	a0,s0,80000898 <message+0x168>
80000884:	00050a63          	beqz	a0,80000898 <message+0x168>
            s++;
80000888:	00148493          	addi	s1,s1,1
            putchar(*s);
8000088c:	3bc010ef          	jal	ra,80001c48 <putchar>
        while (*s != '\n' && *s != '\0') {
80000890:	0004c503          	lbu	a0,0(s1)
80000894:	fe8518e3          	bne	a0,s0,80000884 <message+0x154>
        s++;
80000898:	00148493          	addi	s1,s1,1
8000089c:	00190793          	addi	a5,s2,1
    for (int i = 0; i < lines; i++) {
800008a0:	052a8863          	beq	s5,s2,800008f0 <message+0x1c0>
800008a4:	00078913          	mv	s2,a5
        if (center)
800008a8:	fa0c98e3          	bnez	s9,80000858 <message+0x128>
            cursor(x0+1, y0+i+1);
800008ac:	00090593          	mv	a1,s2
800008b0:	000d0513          	mv	a0,s10
800008b4:	348010ef          	jal	ra,80001bfc <cursor>
800008b8:	fc5ff06f          	j	8000087c <message+0x14c>
                putchar('-');
800008bc:	02d00513          	li	a0,45
800008c0:	388010ef          	jal	ra,80001c48 <putchar>
800008c4:	f61ff06f          	j	80000824 <message+0xf4>
            if ((x == x0 || x == x1-1) && (y == y0 || y == y1-1))
800008c8:	01590e63          	beq	s2,s5,800008e4 <message+0x1b4>
800008cc:	012b8c63          	beq	s7,s2,800008e4 <message+0x1b4>
            else if (x == x0 || x == x1-1)
800008d0:	01340463          	beq	s0,s3,800008d8 <message+0x1a8>
800008d4:	f54412e3          	bne	s0,s4,80000818 <message+0xe8>
                putchar('|');
800008d8:	07c00513          	li	a0,124
800008dc:	36c010ef          	jal	ra,80001c48 <putchar>
800008e0:	f45ff06f          	j	80000824 <message+0xf4>
                putchar('+');
800008e4:	02b00513          	li	a0,43
800008e8:	360010ef          	jal	ra,80001c48 <putchar>
800008ec:	f39ff06f          	j	80000824 <message+0xf4>
    delay(300);
800008f0:	12c00513          	li	a0,300
800008f4:	38d010ef          	jal	ra,80002480 <delay>
        joy_get(&joy1, &joy2);
800008f8:	00410593          	addi	a1,sp,4
800008fc:	00010513          	mv	a0,sp
80000900:	39d010ef          	jal	ra,8000249c <joy_get>
           if ((joy1 & 0x1) || (joy1 & 0x100) || (joy2 & 0x1) || (joy2 & 0x100))
80000904:	00012783          	lw	a5,0(sp)
80000908:	00412703          	lw	a4,4(sp)
8000090c:	00e7e7b3          	or	a5,a5,a4
80000910:	1017f793          	andi	a5,a5,257
80000914:	fe0782e3          	beqz	a5,800008f8 <message+0x1c8>
    delay(300);
80000918:	12c00513          	li	a0,300
8000091c:	365010ef          	jal	ra,80002480 <delay>
}
80000920:	06c12083          	lw	ra,108(sp)
80000924:	06812403          	lw	s0,104(sp)
80000928:	06412483          	lw	s1,100(sp)
8000092c:	06012903          	lw	s2,96(sp)
80000930:	05c12983          	lw	s3,92(sp)
80000934:	05812a03          	lw	s4,88(sp)
80000938:	05412a83          	lw	s5,84(sp)
8000093c:	05012b03          	lw	s6,80(sp)
80000940:	04c12b83          	lw	s7,76(sp)
80000944:	04812c03          	lw	s8,72(sp)
80000948:	04412c83          	lw	s9,68(sp)
8000094c:	04012d03          	lw	s10,64(sp)
80000950:	03c12d83          	lw	s11,60(sp)
80000954:	07010113          	addi	sp,sp,112
80000958:	00008067          	ret
    char *end = msg + len;
8000095c:	01548ab3          	add	s5,s1,s5
            w[i] = min(end - sol, 26);
80000960:	412a8933          	sub	s2,s5,s2
    if (x < y) return x;
80000964:	01900793          	li	a5,25
80000968:	0527ce63          	blt	a5,s2,800009c4 <message+0x294>
8000096c:	002c1793          	slli	a5,s8,0x2
80000970:	03010713          	addi	a4,sp,48
80000974:	00f707b3          	add	a5,a4,a5
80000978:	fd27ac23          	sw	s2,-40(a5)
    if (x > y) return x;
8000097c:	04894063          	blt	s2,s0,800009bc <message+0x28c>
    int y0 = 14 - ((lines + 2) >> 1);
80000980:	003c0793          	addi	a5,s8,3
80000984:	4017d793          	srai	a5,a5,0x1
80000988:	00e00a93          	li	s5,14
            lines = i+1;
8000098c:	001c0c13          	addi	s8,s8,1
    int y0 = 14 - ((lines + 2) >> 1);
80000990:	40fa8ab3          	sub	s5,s5,a5
    int y1 = y0 + lines + 2;
80000994:	015c0bb3          	add	s7,s8,s5
    int x0 = 16 - ((maxw + 2) >> 1);
80000998:	00290d13          	addi	s10,s2,2
    int y1 = y0 + lines + 2;
8000099c:	002b8d93          	addi	s11,s7,2
    int x0 = 16 - ((maxw + 2) >> 1);
800009a0:	401d5d13          	srai	s10,s10,0x1
    for (int y = y0; y < y1; y++)
800009a4:	e9bad8e3          	bge	s5,s11,80000834 <message+0x104>
    int x0 = 16 - ((maxw + 2) >> 1);
800009a8:	01000993          	li	s3,16
800009ac:	41a989b3          	sub	s3,s3,s10
    int x1 = x0 + maxw + 2;
800009b0:	01390433          	add	s0,s2,s3
800009b4:	00240b13          	addi	s6,s0,2
800009b8:	e35ff06f          	j	800007ec <message+0xbc>
800009bc:	00040913          	mv	s2,s0
800009c0:	fc1ff06f          	j	80000980 <message+0x250>
            w[i] = min(end - sol, 26);
800009c4:	002c1793          	slli	a5,s8,0x2
800009c8:	03010713          	addi	a4,sp,48
    else       return y;
800009cc:	01a00913          	li	s2,26
800009d0:	00f707b3          	add	a5,a4,a5
800009d4:	fd27ac23          	sw	s2,-40(a5)
    if (x > y) return x;
800009d8:	fa8954e3          	bge	s2,s0,80000980 <message+0x250>
800009dc:	fe1ff06f          	j	800009bc <message+0x28c>

800009e0 <save_option>:
int save_option() {
800009e0:	da010113          	addi	sp,sp,-608
800009e4:	24812c23          	sw	s0,600(sp)
    if (f_open(&f, OPTION_FILE, FA_READ | FA_WRITE | FA_CREATE_ALWAYS)) {
800009e8:	8000e437          	lui	s0,0x8000e
800009ec:	00b00613          	li	a2,11
800009f0:	c7c40593          	addi	a1,s0,-900 # 8000dc7c <STACK_TOP+0xfffedc7c>
800009f4:	00010513          	mv	a0,sp
int save_option() {
800009f8:	24112e23          	sw	ra,604(sp)
    if (f_open(&f, OPTION_FILE, FA_READ | FA_WRITE | FA_CREATE_ALWAYS)) {
800009fc:	229060ef          	jal	ra,80007424 <f_open>
80000a00:	08051663          	bnez	a0,80000a8c <save_option+0xac>
    if (f_puts("osd_key=", &f) < 0) {
80000a04:	8000e537          	lui	a0,0x8000e
80000a08:	00010593          	mv	a1,sp
80000a0c:	e1050513          	addi	a0,a0,-496 # 8000de10 <STACK_TOP+0xfffede10>
80000a10:	675080ef          	jal	ra,80009884 <f_puts>
80000a14:	0a054e63          	bltz	a0,80000ad0 <save_option+0xf0>
    if (option_osd_key == OPTION_OSD_KEY_SELECT_START)
80000a18:	8000f7b7          	lui	a5,0x8000f
80000a1c:	b707a703          	lw	a4,-1168(a5) # 8000eb70 <STACK_TOP+0xfffeeb70>
80000a20:	00100793          	li	a5,1
        f_puts("1\n", &f);
80000a24:	00010593          	mv	a1,sp
    if (option_osd_key == OPTION_OSD_KEY_SELECT_START)
80000a28:	08f70c63          	beq	a4,a5,80000ac0 <save_option+0xe0>
        f_puts("2\n", &f);
80000a2c:	8000e537          	lui	a0,0x8000e
80000a30:	e3050513          	addi	a0,a0,-464 # 8000de30 <STACK_TOP+0xfffede30>
80000a34:	651080ef          	jal	ra,80009884 <f_puts>
    f_puts("backup_bsram=", &f);
80000a38:	8000e537          	lui	a0,0x8000e
80000a3c:	00010593          	mv	a1,sp
80000a40:	e3450513          	addi	a0,a0,-460 # 8000de34 <STACK_TOP+0xfffede34>
80000a44:	641080ef          	jal	ra,80009884 <f_puts>
    if (option_backup_bsram)
80000a48:	c681c783          	lbu	a5,-920(gp) # 8000efd8 <option_backup_bsram>
        f_puts("true\n", &f);
80000a4c:	00010593          	mv	a1,sp
    if (option_backup_bsram)
80000a50:	06078063          	beqz	a5,80000ab0 <save_option+0xd0>
        f_puts("true\n", &f);
80000a54:	8000e537          	lui	a0,0x8000e
80000a58:	e4450513          	addi	a0,a0,-444 # 8000de44 <STACK_TOP+0xfffede44>
80000a5c:	629080ef          	jal	ra,80009884 <f_puts>
    f_close(&f);
80000a60:	00010513          	mv	a0,sp
80000a64:	0c9070ef          	jal	ra,8000832c <f_close>
    f_chmod(OPTION_FILE, AM_HID, AM_HID);
80000a68:	c7c40513          	addi	a0,s0,-900
80000a6c:	00200613          	li	a2,2
80000a70:	00200593          	li	a1,2
80000a74:	345080ef          	jal	ra,800095b8 <f_chmod>
}
80000a78:	25c12083          	lw	ra,604(sp)
80000a7c:	25812403          	lw	s0,600(sp)
    return 0;
80000a80:	00000513          	li	a0,0
}
80000a84:	26010113          	addi	sp,sp,608
80000a88:	00008067          	ret
        message("f_open failed",1);
80000a8c:	8000e537          	lui	a0,0x8000e
80000a90:	e0050513          	addi	a0,a0,-512 # 8000de00 <STACK_TOP+0xfffede00>
80000a94:	00100593          	li	a1,1
80000a98:	c99ff0ef          	jal	ra,80000730 <message>
}
80000a9c:	25c12083          	lw	ra,604(sp)
80000aa0:	25812403          	lw	s0,600(sp)
        return 1;
80000aa4:	00100513          	li	a0,1
}
80000aa8:	26010113          	addi	sp,sp,608
80000aac:	00008067          	ret
        f_puts("false\n", &f);
80000ab0:	8000e537          	lui	a0,0x8000e
80000ab4:	e4c50513          	addi	a0,a0,-436 # 8000de4c <STACK_TOP+0xfffede4c>
80000ab8:	5cd080ef          	jal	ra,80009884 <f_puts>
80000abc:	fa5ff06f          	j	80000a60 <save_option+0x80>
        f_puts("1\n", &f);
80000ac0:	8000e537          	lui	a0,0x8000e
80000ac4:	e2c50513          	addi	a0,a0,-468 # 8000de2c <STACK_TOP+0xfffede2c>
80000ac8:	5bd080ef          	jal	ra,80009884 <f_puts>
80000acc:	f6dff06f          	j	80000a38 <save_option+0x58>
        message("f_puts failed",1);
80000ad0:	8000e537          	lui	a0,0x8000e
80000ad4:	00100593          	li	a1,1
80000ad8:	e1c50513          	addi	a0,a0,-484 # 8000de1c <STACK_TOP+0xfffede1c>
80000adc:	c55ff0ef          	jal	ra,80000730 <message>
        goto save_options_close;
80000ae0:	f81ff06f          	j	80000a60 <save_option+0x80>

80000ae4 <load_dir>:
int load_dir(char *dir, int start, int len, int *count) {
80000ae4:	fe010113          	addi	sp,sp,-32
80000ae8:	00912a23          	sw	s1,20(sp)
80000aec:	01212823          	sw	s2,16(sp)
80000af0:	01312623          	sw	s3,12(sp)
80000af4:	00050493          	mv	s1,a0
80000af8:	00060993          	mv	s3,a2
80000afc:	00058913          	mv	s2,a1
    DEBUG("load_dir: %s, start=%d, len=%d\n", dir, start, len);
80000b00:	00058613          	mv	a2,a1
80000b04:	00050593          	mv	a1,a0
80000b08:	8000e537          	lui	a0,0x8000e
int load_dir(char *dir, int start, int len, int *count) {
80000b0c:	01412423          	sw	s4,8(sp)
    DEBUG("load_dir: %s, start=%d, len=%d\n", dir, start, len);
80000b10:	e5450513          	addi	a0,a0,-428 # 8000de54 <STACK_TOP+0xfffede54>
int load_dir(char *dir, int start, int len, int *count) {
80000b14:	00068a13          	mv	s4,a3
    DEBUG("load_dir: %s, start=%d, len=%d\n", dir, start, len);
80000b18:	00098693          	mv	a3,s3
int load_dir(char *dir, int start, int len, int *count) {
80000b1c:	00812c23          	sw	s0,24(sp)
80000b20:	00112e23          	sw	ra,28(sp)
    DEBUG("load_dir: %s, start=%d, len=%d\n", dir, start, len);
80000b24:	115010ef          	jal	ra,80002438 <uart_printf>
    file_len = 0;
80000b28:	800117b7          	lui	a5,0x80011
80000b2c:	8207ae23          	sw	zero,-1988(a5) # 8001083c <STACK_TOP+0xffff083c>
80000b30:	00b00413          	li	s0,11
        if (sd_init() == 0) {
80000b34:	40c020ef          	jal	ra,80002f40 <sd_init>
80000b38:	fff40413          	addi	s0,s0,-1
80000b3c:	02050663          	beqz	a0,80000b68 <load_dir+0x84>
    for (int i = 0; i <= 10; i++)
80000b40:	fe041ae3          	bnez	s0,80000b34 <load_dir+0x50>
}
80000b44:	01c12083          	lw	ra,28(sp)
80000b48:	01812403          	lw	s0,24(sp)
80000b4c:	01412483          	lw	s1,20(sp)
80000b50:	01012903          	lw	s2,16(sp)
80000b54:	00c12983          	lw	s3,12(sp)
80000b58:	00812a03          	lw	s4,8(sp)
80000b5c:	06300513          	li	a0,99
80000b60:	02010113          	addi	sp,sp,32
80000b64:	00008067          	ret
80000b68:	01812403          	lw	s0,24(sp)
80000b6c:	01c12083          	lw	ra,28(sp)
80000b70:	000a0693          	mv	a3,s4
80000b74:	00098613          	mv	a2,s3
80000b78:	00812a03          	lw	s4,8(sp)
80000b7c:	00c12983          	lw	s3,12(sp)
80000b80:	00090593          	mv	a1,s2
80000b84:	00048513          	mv	a0,s1
80000b88:	01012903          	lw	s2,16(sp)
80000b8c:	01412483          	lw	s1,20(sp)
80000b90:	02010113          	addi	sp,sp,32
80000b94:	d5cff06f          	j	800000f0 <load_dir.part.0>

80000b98 <menu_options>:
    uart_print("options\n");
80000b98:	8000e537          	lui	a0,0x8000e
void menu_options() {
80000b9c:	fb010113          	addi	sp,sp,-80
    uart_print("options\n");
80000ba0:	e7450513          	addi	a0,a0,-396 # 8000de74 <STACK_TOP+0xfffede74>
void menu_options() {
80000ba4:	04912223          	sw	s1,68(sp)
80000ba8:	05212023          	sw	s2,64(sp)
80000bac:	03312e23          	sw	s3,60(sp)
80000bb0:	03412c23          	sw	s4,56(sp)
80000bb4:	03512a23          	sw	s5,52(sp)
80000bb8:	03612823          	sw	s6,48(sp)
80000bbc:	03712623          	sw	s7,44(sp)
80000bc0:	03812423          	sw	s8,40(sp)
80000bc4:	03912223          	sw	s9,36(sp)
80000bc8:	03a12023          	sw	s10,32(sp)
80000bcc:	04112623          	sw	ra,76(sp)
80000bd0:	04812423          	sw	s0,72(sp)
80000bd4:	01b12e23          	sw	s11,28(sp)
    int choice = 0;
80000bd8:	00012623          	sw	zero,12(sp)
    uart_print("options\n");
80000bdc:	8000ecb7          	lui	s9,0x8000e
80000be0:	035010ef          	jal	ra,80002414 <uart_print>
80000be4:	8000ec37          	lui	s8,0x8000e
80000be8:	8000ebb7          	lui	s7,0x8000e
80000bec:	8000f4b7          	lui	s1,0x8000f
80000bf0:	8000eb37          	lui	s6,0x8000e
80000bf4:	8000eab7          	lui	s5,0x8000e
            print("SELECT&RIGHT");
80000bf8:	8000ed37          	lui	s10,0x8000e
            print("Yes");
80000bfc:	8000ea37          	lui	s4,0x8000e
            print("No");
80000c00:	8000e9b7          	lui	s3,0x8000e
        if (option_osd_key == OPTION_OSD_KEY_SELECT_START)
80000c04:	00100413          	li	s0,1
                    status("Saving options...");
80000c08:	8000edb7          	lui	s11,0x8000e
        clear();
80000c0c:	780010ef          	jal	ra,8000238c <clear>
        cursor(8, 10);
80000c10:	00a00593          	li	a1,10
80000c14:	00800513          	li	a0,8
80000c18:	7e5000ef          	jal	ra,80001bfc <cursor>
        print("--- Options ---");
80000c1c:	e80c8513          	addi	a0,s9,-384 # 8000de80 <STACK_TOP+0xfffede80>
80000c20:	0e8010ef          	jal	ra,80001d08 <print>
        cursor(2, 12);
80000c24:	00c00593          	li	a1,12
80000c28:	00200513          	li	a0,2
80000c2c:	7d1000ef          	jal	ra,80001bfc <cursor>
        print("<< Return to main menu");
80000c30:	c4cc0513          	addi	a0,s8,-948 # 8000dc4c <STACK_TOP+0xfffedc4c>
80000c34:	0d4010ef          	jal	ra,80001d08 <print>
        cursor(2, 14);
80000c38:	00e00593          	li	a1,14
80000c3c:	00200513          	li	a0,2
80000c40:	7bd000ef          	jal	ra,80001bfc <cursor>
        print("OSD hot key:");
80000c44:	e90b8513          	addi	a0,s7,-368 # 8000de90 <STACK_TOP+0xfffede90>
80000c48:	0c0010ef          	jal	ra,80001d08 <print>
        cursor(16, 14);
80000c4c:	00e00593          	li	a1,14
80000c50:	01000513          	li	a0,16
80000c54:	7a9000ef          	jal	ra,80001bfc <cursor>
        if (option_osd_key == OPTION_OSD_KEY_SELECT_START)
80000c58:	b704a783          	lw	a5,-1168(s1) # 8000eb70 <STACK_TOP+0xfffeeb70>
80000c5c:	12878463          	beq	a5,s0,80000d84 <menu_options+0x1ec>
            print("SELECT&RIGHT");
80000c60:	eb0d0513          	addi	a0,s10,-336 # 8000deb0 <STACK_TOP+0xfffedeb0>
80000c64:	0a4010ef          	jal	ra,80001d08 <print>
        cursor(2, 15);
80000c68:	00f00593          	li	a1,15
80000c6c:	00200513          	li	a0,2
80000c70:	78d000ef          	jal	ra,80001bfc <cursor>
        print("Save to SD:");
80000c74:	ec0b0513          	addi	a0,s6,-320 # 8000dec0 <STACK_TOP+0xfffedec0>
80000c78:	090010ef          	jal	ra,80001d08 <print>
        cursor(2, 16);
80000c7c:	01000593          	li	a1,16
80000c80:	00200513          	li	a0,2
80000c84:	779000ef          	jal	ra,80001bfc <cursor>
        print("Audio Open:");
80000c88:	ecca8513          	addi	a0,s5,-308 # 8000decc <STACK_TOP+0xfffedecc>
80000c8c:	07c010ef          	jal	ra,80001d08 <print>
        cursor(16, 16);
80000c90:	01000593          	li	a1,16
80000c94:	01000513          	li	a0,16
80000c98:	765000ef          	jal	ra,80001bfc <cursor>
        if(reg_audio_off)
80000c9c:	020007b7          	lui	a5,0x2000
80000ca0:	0907a783          	lw	a5,144(a5) # 2000090 <crtStart-0x7dffff70>
80000ca4:	0c078a63          	beqz	a5,80000d78 <menu_options+0x1e0>
            print("No");
80000ca8:	ed898513          	addi	a0,s3,-296 # 8000ded8 <STACK_TOP+0xfffeded8>
80000cac:	05c010ef          	jal	ra,80001d08 <print>
        cursor(16, 15);
80000cb0:	00f00593          	li	a1,15
80000cb4:	01000513          	li	a0,16
80000cb8:	745000ef          	jal	ra,80001bfc <cursor>
        if (option_backup_bsram)
80000cbc:	c681c783          	lbu	a5,-920(gp) # 8000efd8 <option_backup_bsram>
80000cc0:	0a078663          	beqz	a5,80000d6c <menu_options+0x1d4>
            print("Yes");
80000cc4:	edca0513          	addi	a0,s4,-292 # 8000dedc <STACK_TOP+0xfffededc>
80000cc8:	040010ef          	jal	ra,80001d08 <print>
        delay(300);
80000ccc:	12c00513          	li	a0,300
80000cd0:	7b0010ef          	jal	ra,80002480 <delay>
            if (joy_choice(12, 5, &choice, OSD_KEY_CODE) == 1) {
80000cd4:	b704a783          	lw	a5,-1168(s1)
80000cd8:	00c10613          	addi	a2,sp,12
80000cdc:	00500593          	li	a1,5
80000ce0:	00c00513          	li	a0,12
80000ce4:	00c00693          	li	a3,12
80000ce8:	00878463          	beq	a5,s0,80000cf0 <menu_options+0x158>
80000cec:	08400693          	li	a3,132
80000cf0:	7cc010ef          	jal	ra,800024bc <joy_choice>
80000cf4:	fe8510e3          	bne	a0,s0,80000cd4 <menu_options+0x13c>
                if (choice == 0) {
80000cf8:	00c12783          	lw	a5,12(sp)
80000cfc:	02078a63          	beqz	a5,80000d30 <menu_options+0x198>
                } else if (choice == 1) {
80000d00:	fc878ae3          	beq	a5,s0,80000cd4 <menu_options+0x13c>
                    if (choice == 2) {
80000d04:	00200713          	li	a4,2
80000d08:	0ae78e63          	beq	a5,a4,80000dc4 <menu_options+0x22c>
                    } else if (choice == 3) {
80000d0c:	00300713          	li	a4,3
80000d10:	08e78263          	beq	a5,a4,80000d94 <menu_options+0x1fc>
                    } else if (choice == 4) {
80000d14:	00400713          	li	a4,4
80000d18:	08e79463          	bne	a5,a4,80000da0 <menu_options+0x208>
                        reg_audio_off = !reg_audio_off  ;
80000d1c:	02000737          	lui	a4,0x2000
80000d20:	09072783          	lw	a5,144(a4) # 2000090 <crtStart-0x7dffff70>
80000d24:	0017b793          	seqz	a5,a5
80000d28:	08f72823          	sw	a5,144(a4)
80000d2c:	0740006f          	j	80000da0 <menu_options+0x208>
}
80000d30:	04c12083          	lw	ra,76(sp)
80000d34:	04812403          	lw	s0,72(sp)
80000d38:	04412483          	lw	s1,68(sp)
80000d3c:	04012903          	lw	s2,64(sp)
80000d40:	03c12983          	lw	s3,60(sp)
80000d44:	03812a03          	lw	s4,56(sp)
80000d48:	03412a83          	lw	s5,52(sp)
80000d4c:	03012b03          	lw	s6,48(sp)
80000d50:	02c12b83          	lw	s7,44(sp)
80000d54:	02812c03          	lw	s8,40(sp)
80000d58:	02412c83          	lw	s9,36(sp)
80000d5c:	02012d03          	lw	s10,32(sp)
80000d60:	01c12d83          	lw	s11,28(sp)
80000d64:	05010113          	addi	sp,sp,80
80000d68:	00008067          	ret
            print("No");
80000d6c:	ed898513          	addi	a0,s3,-296
80000d70:	799000ef          	jal	ra,80001d08 <print>
80000d74:	f59ff06f          	j	80000ccc <menu_options+0x134>
            print("Yes");
80000d78:	edca0513          	addi	a0,s4,-292
80000d7c:	78d000ef          	jal	ra,80001d08 <print>
80000d80:	f31ff06f          	j	80000cb0 <menu_options+0x118>
            print("SELECT&START");
80000d84:	8000e7b7          	lui	a5,0x8000e
80000d88:	ea078513          	addi	a0,a5,-352 # 8000dea0 <STACK_TOP+0xfffedea0>
80000d8c:	77d000ef          	jal	ra,80001d08 <print>
80000d90:	ed9ff06f          	j	80000c68 <menu_options+0xd0>
                        option_backup_bsram = !option_backup_bsram;
80000d94:	c681c783          	lbu	a5,-920(gp) # 8000efd8 <option_backup_bsram>
80000d98:	0017c793          	xori	a5,a5,1
80000d9c:	c6f18423          	sb	a5,-920(gp) # 8000efd8 <option_backup_bsram>
                    status("Saving options...");
80000da0:	ee0d8513          	addi	a0,s11,-288 # 8000dee0 <STACK_TOP+0xfffedee0>
80000da4:	e9cff0ef          	jal	ra,80000440 <status>
                    if (save_option()) {
80000da8:	c39ff0ef          	jal	ra,800009e0 <save_option>
80000dac:	e60500e3          	beqz	a0,80000c0c <menu_options+0x74>
                        message("Cannot save options to SD",1);
80000db0:	8000e537          	lui	a0,0x8000e
80000db4:	00100593          	li	a1,1
80000db8:	ef450513          	addi	a0,a0,-268 # 8000def4 <STACK_TOP+0xfffedef4>
80000dbc:	975ff0ef          	jal	ra,80000730 <message>
                        break;
80000dc0:	e45ff06f          	j	80000c04 <menu_options+0x6c>
                        if (option_osd_key == OPTION_OSD_KEY_SELECT_START)
80000dc4:	b704a703          	lw	a4,-1168(s1)
80000dc8:	00870663          	beq	a4,s0,80000dd4 <menu_options+0x23c>
                            option_osd_key = OPTION_OSD_KEY_SELECT_START;
80000dcc:	b684a823          	sw	s0,-1168(s1)
80000dd0:	fd1ff06f          	j	80000da0 <menu_options+0x208>
                            option_osd_key = OPTION_OSD_KEY_SELECT_RIGHT;
80000dd4:	b6f4a823          	sw	a5,-1168(s1)
80000dd8:	fc9ff06f          	j	80000da0 <menu_options+0x208>

80000ddc <parse_snes_header>:
                      int *ram_size, int *company) {
80000ddc:	f9010113          	addi	sp,sp,-112
80000de0:	03b12e23          	sw	s11,60(sp)
80000de4:	00060d93          	mv	s11,a2
    if (f_lseek(fp, pos))
80000de8:	41f5d613          	srai	a2,a1,0x1f
                      int *ram_size, int *company) {
80000dec:	06812423          	sw	s0,104(sp)
80000df0:	06912223          	sw	s1,100(sp)
80000df4:	07212023          	sw	s2,96(sp)
80000df8:	05312e23          	sw	s3,92(sp)
80000dfc:	05412c23          	sw	s4,88(sp)
80000e00:	05512a23          	sw	s5,84(sp)
80000e04:	05612823          	sw	s6,80(sp)
80000e08:	06112623          	sw	ra,108(sp)
80000e0c:	05712623          	sw	s7,76(sp)
80000e10:	05812423          	sw	s8,72(sp)
80000e14:	05912223          	sw	s9,68(sp)
80000e18:	05a12023          	sw	s10,64(sp)
80000e1c:	00058493          	mv	s1,a1
80000e20:	00050b13          	mv	s6,a0
80000e24:	00068913          	mv	s2,a3
80000e28:	00070413          	mv	s0,a4
80000e2c:	00078a93          	mv	s5,a5
80000e30:	00080a13          	mv	s4,a6
80000e34:	00088993          	mv	s3,a7
    if (f_lseek(fp, pos))
80000e38:	540070ef          	jal	ra,80008378 <f_lseek>
80000e3c:	04050263          	beqz	a0,80000e80 <parse_snes_header+0xa4>
        return 1;
80000e40:	00100513          	li	a0,1
}
80000e44:	06c12083          	lw	ra,108(sp)
80000e48:	06812403          	lw	s0,104(sp)
80000e4c:	06412483          	lw	s1,100(sp)
80000e50:	06012903          	lw	s2,96(sp)
80000e54:	05c12983          	lw	s3,92(sp)
80000e58:	05812a03          	lw	s4,88(sp)
80000e5c:	05412a83          	lw	s5,84(sp)
80000e60:	05012b03          	lw	s6,80(sp)
80000e64:	04c12b83          	lw	s7,76(sp)
80000e68:	04812c03          	lw	s8,72(sp)
80000e6c:	04412c83          	lw	s9,68(sp)
80000e70:	04012d03          	lw	s10,64(sp)
80000e74:	03c12d83          	lw	s11,60(sp)
80000e78:	07010113          	addi	sp,sp,112
80000e7c:	00008067          	ret
    f_read(fp, hdr, 64, &br);
80000e80:	02c10693          	addi	a3,sp,44
80000e84:	04000613          	li	a2,64
80000e88:	00040593          	mv	a1,s0
80000e8c:	000b0513          	mv	a0,s6
80000e90:	28d060ef          	jal	ra,8000791c <f_read>
    if (br != 64) return 1;
80000e94:	02c12703          	lw	a4,44(sp)
80000e98:	04000793          	li	a5,64
80000e9c:	faf712e3          	bne	a4,a5,80000e40 <parse_snes_header+0x64>
    int checksum = (hdr[28] << 8) + hdr[29];
80000ea0:	01c44803          	lbu	a6,28(s0)
    int checksum_compliment = (hdr[30] << 8) + hdr[31];
80000ea4:	01e44883          	lbu	a7,30(s0)
    int checksum = (hdr[28] << 8) + hdr[29];
80000ea8:	01d44683          	lbu	a3,29(s0)
    int checksum_compliment = (hdr[30] << 8) + hdr[31];
80000eac:	01f44703          	lbu	a4,31(s0)
    int reset = (hdr[61] << 8) + hdr[60];
80000eb0:	03d44b03          	lbu	s6,61(s0)
80000eb4:	03c44783          	lbu	a5,60(s0)
    int rom = hdr[23];
80000eb8:	01744c83          	lbu	s9,23(s0)
    int checksum = (hdr[28] << 8) + hdr[29];
80000ebc:	00881813          	slli	a6,a6,0x8
    int checksum_compliment = (hdr[30] << 8) + hdr[31];
80000ec0:	00889893          	slli	a7,a7,0x8
    status("");
80000ec4:	8000e537          	lui	a0,0x8000e
    int checksum = (hdr[28] << 8) + hdr[29];
80000ec8:	00d80833          	add	a6,a6,a3
    int checksum_compliment = (hdr[30] << 8) + hdr[31];
80000ecc:	00e888b3          	add	a7,a7,a4
    status("");
80000ed0:	05850513          	addi	a0,a0,88 # 8000e058 <STACK_TOP+0xfffee058>
    int reset = (hdr[61] << 8) + hdr[60];
80000ed4:	008b1b13          	slli	s6,s6,0x8
    int checksum = (hdr[28] << 8) + hdr[29];
80000ed8:	01012e23          	sw	a6,28(sp)
    int checksum_compliment = (hdr[30] << 8) + hdr[31];
80000edc:	01112c23          	sw	a7,24(sp)
    int reset = (hdr[61] << 8) + hdr[60];
80000ee0:	00fb0b33          	add	s6,s6,a5
    int size2 = 1024 << rom;
80000ee4:	40000d13          	li	s10,1024
    int mc = hdr[21];
80000ee8:	01544c03          	lbu	s8,21(s0)
    int ram = hdr[24];
80000eec:	01844b83          	lbu	s7,24(s0)
    status("");
80000ef0:	d50ff0ef          	jal	ra,80000440 <status>
    int size2 = 1024 << rom;
80000ef4:	019d1d33          	sll	s10,s10,s9
    printf("size=%d", size2);
80000ef8:	8000e537          	lui	a0,0x8000e
80000efc:	000d0593          	mv	a1,s10
80000f00:	f1050513          	addi	a0,a0,-240 # 8000df10 <STACK_TOP+0xfffedf10>
80000f04:	440010ef          	jal	ra,80002344 <printf>
    if (checksum + checksum_compliment == 0xffff) score++;
80000f08:	01812883          	lw	a7,24(sp)
80000f0c:	01c12803          	lw	a6,28(sp)
80000f10:	000106b7          	lui	a3,0x10
80000f14:	fff68693          	addi	a3,a3,-1 # ffff <crtStart-0x7fff0001>
    if (size2 >= file_size) score++;
80000f18:	01bd2633          	slt	a2,s10,s11
    if (rom == 1) score++;
80000f1c:	fffc8713          	addi	a4,s9,-1
    if (checksum + checksum_compliment == 0xffff) score++;
80000f20:	011807b3          	add	a5,a6,a7
    if (rom == 1) score++;
80000f24:	00173713          	seqz	a4,a4
    if (checksum + checksum_compliment == 0xffff) score++;
80000f28:	40d787b3          	sub	a5,a5,a3
    if (size2 >= file_size) score++;
80000f2c:	00164613          	xori	a2,a2,1
    if (rom == 1) score++;
80000f30:	00e60633          	add	a2,a2,a4
    if (checksum + checksum_compliment == 0xffff) score++;
80000f34:	0017b793          	seqz	a5,a5
80000f38:	00f60633          	add	a2,a2,a5
    for (int i = 0; i < 21; i++)
80000f3c:	00040713          	mv	a4,s0
80000f40:	01540513          	addi	a0,s0,21
    int all_ascii = 1;
80000f44:	00100693          	li	a3,1
        if (hdr[i] < 32 || hdr[i] > 127)
80000f48:	05f00593          	li	a1,95
80000f4c:	00074783          	lbu	a5,0(a4)
80000f50:	00170713          	addi	a4,a4,1
80000f54:	fe078793          	addi	a5,a5,-32
80000f58:	0ff7f793          	andi	a5,a5,255
            all_ascii = 0;
80000f5c:	00f5b7b3          	sltu	a5,a1,a5
80000f60:	fff78793          	addi	a5,a5,-1
80000f64:	00f6f6b3          	and	a3,a3,a5
    for (int i = 0; i < 21; i++)
80000f68:	fee512e3          	bne	a0,a4,80000f4c <parse_snes_header+0x170>
    score += all_ascii;
80000f6c:	00d60d33          	add	s10,a2,a3
    DEBUG("pos=%x, type=%d, map_ctrl=%d, rom=%d, ram=%d, checksum=%x, checksum_comp=%x, reset=%x, score=%d\n", 
80000f70:	8000e537          	lui	a0,0x8000e
80000f74:	000b8793          	mv	a5,s7
80000f78:	01a12223          	sw	s10,4(sp)
80000f7c:	01612023          	sw	s6,0(sp)
80000f80:	000c8713          	mv	a4,s9
80000f84:	000c0693          	mv	a3,s8
80000f88:	00090613          	mv	a2,s2
80000f8c:	00048593          	mv	a1,s1
80000f90:	f1850513          	addi	a0,a0,-232 # 8000df18 <STACK_TOP+0xfffedf18>
80000f94:	4a4010ef          	jal	ra,80002438 <uart_printf>
    if (rom < 14 && ram <= 7 && score >= 1 && 
80000f98:	00d00793          	li	a5,13
80000f9c:	eb97c2e3          	blt	a5,s9,80000e40 <parse_snes_header+0x64>
80000fa0:	00700793          	li	a5,7
80000fa4:	e977cee3          	blt	a5,s7,80000e40 <parse_snes_header+0x64>
80000fa8:	e80d0ce3          	beqz	s10,80000e40 <parse_snes_header+0x64>
80000fac:	000087b7          	lui	a5,0x8
80000fb0:	e8fb48e3          	blt	s6,a5,80000e40 <parse_snes_header+0x64>
        reset >= 0x8000 &&				// reset vector position correct
80000fb4:	04091063          	bnez	s2,80000ff4 <parse_snes_header+0x218>
       ((typ == 0 && (mc & 3) == 0) || 	// normal LoROM
80000fb8:	003c7793          	andi	a5,s8,3
80000fbc:	00078663          	beqz	a5,80000fc8 <parse_snes_header+0x1ec>
80000fc0:	05300793          	li	a5,83
80000fc4:	e6fc1ee3          	bne	s8,a5,80000e40 <parse_snes_header+0x64>
        *map_ctrl = mc;
80000fc8:	018aa023          	sw	s8,0(s5)
        *rom_type_header = hdr[22];
80000fcc:	01644783          	lbu	a5,22(s0)
        return 0;
80000fd0:	00000513          	li	a0,0
        *rom_type_header = hdr[22];
80000fd4:	00fa2023          	sw	a5,0(s4)
        *ram_size = ram;
80000fd8:	07012783          	lw	a5,112(sp)
        *rom_size = rom;
80000fdc:	0199a023          	sw	s9,0(s3)
        *ram_size = ram;
80000fe0:	0177a023          	sw	s7,0(a5) # 8000 <crtStart-0x7fff8000>
        *company = hdr[26];
80000fe4:	01a44703          	lbu	a4,26(s0)
80000fe8:	07412783          	lw	a5,116(sp)
80000fec:	00e7a023          	sw	a4,0(a5)
        return 0;
80000ff0:	e55ff06f          	j	80000e44 <parse_snes_header+0x68>
        (typ == 0 && mc == 0x53)    ||	// contra 3 has 0x53 and LoROM
80000ff4:	00100793          	li	a5,1
80000ff8:	00f90663          	beq	s2,a5,80001004 <parse_snes_header+0x228>
        (typ == 1 && (mc & 3) == 1) ||	// HiROM
80000ffc:	00200793          	li	a5,2
80001000:	e4f910e3          	bne	s2,a5,80000e40 <parse_snes_header+0x64>
        (typ == 2 && (mc & 3) == 2))) {	// ExHiROM
80001004:	003c7793          	andi	a5,s8,3
80001008:	e3279ce3          	bne	a5,s2,80000e40 <parse_snes_header+0x64>
8000100c:	fbdff06f          	j	80000fc8 <parse_snes_header+0x1ec>

80001010 <gba_load_bios>:
void gba_load_bios() {
80001010:	c6010113          	addi	sp,sp,-928
80001014:	39312623          	sw	s3,908(sp)
    if (gba_bios_loaded | gba_missing_bios_warned) return;
80001018:	800119b7          	lui	s3,0x80011
8000101c:	8409c783          	lbu	a5,-1984(s3) # 80010840 <STACK_TOP+0xffff0840>
void gba_load_bios() {
80001020:	38112e23          	sw	ra,924(sp)
80001024:	38812c23          	sw	s0,920(sp)
80001028:	38912a23          	sw	s1,916(sp)
8000102c:	39212823          	sw	s2,912(sp)
    if (gba_bios_loaded | gba_missing_bios_warned) return;
80001030:	0a079a63          	bnez	a5,800010e4 <gba_load_bios+0xd4>
80001034:	80011437          	lui	s0,0x80011
80001038:	5fe44783          	lbu	a5,1534(s0) # 800115fe <STACK_TOP+0xffff15fe>
8000103c:	0a079463          	bnez	a5,800010e4 <gba_load_bios+0xd4>
    DEBUG("gba_load_bios start\n");
80001040:	8000e537          	lui	a0,0x8000e
80001044:	f7c50513          	addi	a0,a0,-132 # 8000df7c <STACK_TOP+0xfffedf7c>
80001048:	3f0010ef          	jal	ra,80002438 <uart_printf>
    if (f_stat("/gba_bios.bin", &fno) != FR_OK) {
8000104c:	8000e4b7          	lui	s1,0x8000e
80001050:	01010593          	addi	a1,sp,16
80001054:	fec48513          	addi	a0,s1,-20 # 8000dfec <STACK_TOP+0xfffedfec>
80001058:	11d070ef          	jal	ra,80008974 <f_stat>
8000105c:	0a051263          	bnez	a0,80001100 <gba_load_bios+0xf0>
    if (f_open(&f, "/gba_bios.bin", FA_READ) != FR_OK) {
80001060:	00100613          	li	a2,1
80001064:	fec48593          	addi	a1,s1,-20
80001068:	13010513          	addi	a0,sp,304
8000106c:	3b8060ef          	jal	ra,80007424 <f_open>
80001070:	0c051263          	bnez	a0,80001134 <gba_load_bios+0x124>
    core_ctrl(4);
80001074:	00400513          	li	a0,4
80001078:	618010ef          	jal	ra,80002690 <core_ctrl>
8000107c:	80011937          	lui	s2,0x80011
        if ((r = f_read(&f, load_buf, 1024, &br)) != FR_OK)
80001080:	00c10693          	addi	a3,sp,12
80001084:	40000613          	li	a2,1024
80001088:	84490593          	addi	a1,s2,-1980 # 80010844 <STACK_TOP+0xffff0844>
8000108c:	13010513          	addi	a0,sp,304
80001090:	08d060ef          	jal	ra,8000791c <f_read>
80001094:	02051a63          	bnez	a0,800010c8 <gba_load_bios+0xb8>
        for (int i = 0; i < br; i += 4) {
80001098:	00c12783          	lw	a5,12(sp)
8000109c:	02078663          	beqz	a5,800010c8 <gba_load_bios+0xb8>
800010a0:	84490493          	addi	s1,s2,-1980
800010a4:	00000413          	li	s0,0
            core_data(w);
800010a8:	0004a503          	lw	a0,0(s1)
        for (int i = 0; i < br; i += 4) {
800010ac:	00440413          	addi	s0,s0,4
800010b0:	00448493          	addi	s1,s1,4
            core_data(w);
800010b4:	5e8010ef          	jal	ra,8000269c <core_data>
        for (int i = 0; i < br; i += 4) {
800010b8:	00c12783          	lw	a5,12(sp)
800010bc:	fef466e3          	bltu	s0,a5,800010a8 <gba_load_bios+0x98>
    } while (br == 1024);
800010c0:	40000713          	li	a4,1024
800010c4:	fae78ee3          	beq	a5,a4,80001080 <gba_load_bios+0x70>
    f_close(&f);
800010c8:	13010513          	addi	a0,sp,304
800010cc:	260070ef          	jal	ra,8000832c <f_close>
    DEBUG("gba_load_bios end\n");
800010d0:	8000e537          	lui	a0,0x8000e
    gba_bios_loaded = 1;
800010d4:	00100793          	li	a5,1
    DEBUG("gba_load_bios end\n");
800010d8:	ffc50513          	addi	a0,a0,-4 # 8000dffc <STACK_TOP+0xfffedffc>
    gba_bios_loaded = 1;
800010dc:	84f98023          	sb	a5,-1984(s3)
    DEBUG("gba_load_bios end\n");
800010e0:	358010ef          	jal	ra,80002438 <uart_printf>
}
800010e4:	39c12083          	lw	ra,924(sp)
800010e8:	39812403          	lw	s0,920(sp)
800010ec:	39412483          	lw	s1,916(sp)
800010f0:	39012903          	lw	s2,912(sp)
800010f4:	38c12983          	lw	s3,908(sp)
800010f8:	3a010113          	addi	sp,sp,928
800010fc:	00008067          	ret
        message( "Cannot find /gba_bios.bin\n"
80001100:	8000e537          	lui	a0,0x8000e
80001104:	00100593          	li	a1,1
80001108:	f9450513          	addi	a0,a0,-108 # 8000df94 <STACK_TOP+0xfffedf94>
8000110c:	e24ff0ef          	jal	ra,80000730 <message>
        gba_missing_bios_warned = 1;
80001110:	00100793          	li	a5,1
80001114:	5ef40f23          	sb	a5,1534(s0)
}
80001118:	39c12083          	lw	ra,924(sp)
8000111c:	39812403          	lw	s0,920(sp)
80001120:	39412483          	lw	s1,916(sp)
80001124:	39012903          	lw	s2,912(sp)
80001128:	38c12983          	lw	s3,908(sp)
8000112c:	3a010113          	addi	sp,sp,928
80001130:	00008067          	ret
        message("Cannot open /gba_bios.bin", 1);
80001134:	8000e537          	lui	a0,0x8000e
80001138:	00100593          	li	a1,1
8000113c:	fe050513          	addi	a0,a0,-32 # 8000dfe0 <STACK_TOP+0xfffedfe0>
80001140:	df0ff0ef          	jal	ra,80000730 <message>
}
80001144:	39c12083          	lw	ra,924(sp)
80001148:	39812403          	lw	s0,920(sp)
8000114c:	39412483          	lw	s1,916(sp)
80001150:	39012903          	lw	s2,912(sp)
80001154:	38c12983          	lw	s3,908(sp)
80001158:	3a010113          	addi	sp,sp,928
8000115c:	00008067          	ret

80001160 <loadgba.part.2>:
int loadgba(int rom) {
80001160:	d5010113          	addi	sp,sp,-688
    r = f_open(&f, load_fname, FA_READ);
80001164:	800115b7          	lui	a1,0x80011
int loadgba(int rom) {
80001168:	2a812423          	sw	s0,680(sp)
    r = f_open(&f, load_fname, FA_READ);
8000116c:	00100613          	li	a2,1
int loadgba(int rom) {
80001170:	00050413          	mv	s0,a0
    r = f_open(&f, load_fname, FA_READ);
80001174:	0a058593          	addi	a1,a1,160 # 800110a0 <STACK_TOP+0xffff10a0>
80001178:	02010513          	addi	a0,sp,32
int loadgba(int rom) {
8000117c:	2a112623          	sw	ra,684(sp)
80001180:	2a912223          	sw	s1,676(sp)
80001184:	2b212023          	sw	s2,672(sp)
80001188:	29312e23          	sw	s3,668(sp)
8000118c:	29412c23          	sw	s4,664(sp)
80001190:	29512a23          	sw	s5,660(sp)
80001194:	29612823          	sw	s6,656(sp)
80001198:	29712623          	sw	s7,652(sp)
8000119c:	29812423          	sw	s8,648(sp)
800011a0:	29912223          	sw	s9,644(sp)
800011a4:	29a12023          	sw	s10,640(sp)
800011a8:	27b12e23          	sw	s11,636(sp)
    r = f_open(&f, load_fname, FA_READ);
800011ac:	278060ef          	jal	ra,80007424 <f_open>
    if (r) {
800011b0:	32051263          	bnez	a0,800014d4 <loadgba.part.2+0x374>
    unsigned int size = file_sizes[rom];
800011b4:	800117b7          	lui	a5,0x80011
800011b8:	00241413          	slli	s0,s0,0x2
800011bc:	c4878793          	addi	a5,a5,-952 # 80010c48 <STACK_TOP+0xffff0c48>
800011c0:	008787b3          	add	a5,a5,s0
    core_ctrl(1);		// enable game loading, this resets GBA
800011c4:	00100513          	li	a0,1
    unsigned int size = file_sizes[rom];
800011c8:	0007ac83          	lw	s9,0(a5)
    core_ctrl(1);		// enable game loading, this resets GBA
800011cc:	4c4010ef          	jal	ra,80002690 <core_ctrl>
    core_running = false;
800011d0:	800117b7          	lui	a5,0x80011
    if ((r = f_lseek(&f, off)) != FR_OK) {
800011d4:	00000593          	li	a1,0
800011d8:	00000613          	li	a2,0
800011dc:	02010513          	addi	a0,sp,32
    core_running = false;
800011e0:	82078823          	sb	zero,-2000(a5) # 80010830 <STACK_TOP+0xffff0830>
    if ((r = f_lseek(&f, off)) != FR_OK) {
800011e4:	194070ef          	jal	ra,80008378 <f_lseek>
800011e8:	00050413          	mv	s0,a0
800011ec:	30051663          	bnez	a0,800014f8 <loadgba.part.2+0x398>
    gba_backup_type = GBA_BACKUP_NONE;
800011f0:	800114b7          	lui	s1,0x80011
            printf("%d/%dK ", total >> 10, size >> 10);
800011f4:	00acd793          	srli	a5,s9,0xa
        if ((total & 0xffff) == 0) {	// display progress every 64KB
800011f8:	00010bb7          	lui	s7,0x10
                        if ((w & 0xffff) == 0x565F ||                   // '_V'
800011fc:	00005c37          	lui	s8,0x5
    gba_backup_type = GBA_BACKUP_NONE;
80001200:	8204ac23          	sw	zero,-1992(s1) # 80010838 <STACK_TOP+0xffff0838>
            printf("%d/%dK ", total >> 10, size >> 10);
80001204:	00f12623          	sw	a5,12(sp)
    unsigned int off = 0, br, total = 0;
80001208:	00000913          	li	s2,0
8000120c:	80011b37          	lui	s6,0x80011
        if ((total & 0xffff) == 0) {	// display progress every 64KB
80001210:	fffb8b93          	addi	s7,s7,-1 # ffff <crtStart-0x7fff0001>
                        if ((w & 0xffff) == 0x565F ||                   // '_V'
80001214:	65fc0c13          	addi	s8,s8,1631 # 565f <crtStart-0x7fffa9a1>
        if ((r = f_read(&f, load_buf, 1024, &br)) != FR_OK)
80001218:	01c10693          	addi	a3,sp,28
8000121c:	40000613          	li	a2,1024
80001220:	844b0593          	addi	a1,s6,-1980 # 80010844 <STACK_TOP+0xffff0844>
80001224:	02010513          	addi	a0,sp,32
80001228:	6f4060ef          	jal	ra,8000791c <f_read>
8000122c:	00050a93          	mv	s5,a0
80001230:	0c051463          	bnez	a0,800012f8 <loadgba.part.2+0x198>
        for (int i = 0; i < br; i += 4) {
80001234:	01c12783          	lw	a5,28(sp)
80001238:	20078863          	beqz	a5,80001448 <loadgba.part.2+0x2e8>
                        if ((w & 0xffff) == 0x565F ||                   // '_V'
8000123c:	565f4a37          	lui	s4,0x565f4
                        if ( (  w & 0xffffff) == 0x565f48 ||            // 'H_V'
80001240:	010009b7          	lui	s3,0x1000
80001244:	844b0d93          	addi	s11,s6,-1980
        for (int i = 0; i < br; i += 4) {
80001248:	00000d13          	li	s10,0
                        if ((w & 0xffff) == 0x565F ||                   // '_V'
8000124c:	65fa0a13          	addi	s4,s4,1631 # 565f465f <crtStart-0x29a0b9a1>
                        if ( (  w & 0xffffff) == 0x565f48 ||            // 'H_V'
80001250:	fff98993          	addi	s3,s3,-1 # ffffff <crtStart-0x7f000001>
80001254:	03c0006f          	j	80001290 <loadgba.part.2+0x130>
                    switch (w) {
80001258:	52504637          	lui	a2,0x52504
8000125c:	54560613          	addi	a2,a2,1349 # 52504545 <crtStart-0x2dafbabb>
80001260:	1ccc8863          	beq	s9,a2,80001430 <loadgba.part.2+0x2d0>
80001264:	53415637          	lui	a2,0x53415
80001268:	c4660613          	addi	a2,a2,-954 # 53414c46 <crtStart-0x2cbeb3ba>
8000126c:	18cc8663          	beq	s9,a2,800013f8 <loadgba.part.2+0x298>
80001270:	4d415637          	lui	a2,0x4d415
80001274:	25360613          	addi	a2,a2,595 # 4d415253 <crtStart-0x32beadad>
80001278:	00cc9463          	bne	s9,a2,80001280 <loadgba.part.2+0x120>
                            detect = 3;
8000127c:	00300413          	li	s0,3
        for (int i = 0; i < br; i += 4) {
80001280:	01c12683          	lw	a3,28(sp)
80001284:	004d0d13          	addi	s10,s10,4
80001288:	004d8d93          	addi	s11,s11,4
8000128c:	04dd7c63          	bgeu	s10,a3,800012e4 <loadgba.part.2+0x184>
            uint32_t w = *(uint32_t *)(load_buf + i);
80001290:	000dac83          	lw	s9,0(s11)
            core_data(w);				// send actual ROM data
80001294:	000c8513          	mv	a0,s9
80001298:	404010ef          	jal	ra,8000269c <core_data>
            if (gba_backup_type == GBA_BACKUP_NONE) {
8000129c:	8384a603          	lw	a2,-1992(s1)
800012a0:	fe0610e3          	bnez	a2,80001280 <loadgba.part.2+0x120>
                if (detect == 0) {                                      // fast path
800012a4:	fa040ae3          	beqz	s0,80001258 <loadgba.part.2+0xf8>
                    if (detect == 1 && w == 0x565f4d4f) {                // 'OM_V'
800012a8:	00100613          	li	a2,1
800012ac:	12c40863          	beq	s0,a2,800013dc <loadgba.part.2+0x27c>
                    } else if (detect == 2) {
800012b0:	00200613          	li	a2,2
800012b4:	14c40663          	beq	s0,a2,80001400 <loadgba.part.2+0x2a0>
                        if ((w & 0xffff) == 0x565F ||                   // '_V'
800012b8:	017cf633          	and	a2,s9,s7
800012bc:	01860663          	beq	a2,s8,800012c8 <loadgba.part.2+0x168>
                        detect = 0;
800012c0:	00000413          	li	s0,0
                        if ((w & 0xffff) == 0x565F ||                   // '_V'
800012c4:	fb4c9ee3          	bne	s9,s4,80001280 <loadgba.part.2+0x120>
                            gba_backup_type = GBA_BACKUP_SRAM;
800012c8:	00300693          	li	a3,3
800012cc:	82d4ac23          	sw	a3,-1992(s1)
        for (int i = 0; i < br; i += 4) {
800012d0:	01c12683          	lw	a3,28(sp)
800012d4:	004d0d13          	addi	s10,s10,4
                        detect = 0;
800012d8:	00000413          	li	s0,0
800012dc:	004d8d93          	addi	s11,s11,4
        for (int i = 0; i < br; i += 4) {
800012e0:	fadd68e3          	bltu	s10,a3,80001290 <loadgba.part.2+0x130>
        total += br;
800012e4:	00d90933          	add	s2,s2,a3
        if ((total & 0xffff) == 0) {	// display progress every 64KB
800012e8:	017977b3          	and	a5,s2,s7
800012ec:	16078263          	beqz	a5,80001450 <loadgba.part.2+0x2f0>
    } while (br == 1024);
800012f0:	40000793          	li	a5,1024
800012f4:	f2f682e3          	beq	a3,a5,80001218 <loadgba.part.2+0xb8>
    DEBUG("loadgba: %d bytes rom sent.\n", total); 
800012f8:	8000e537          	lui	a0,0x8000e
800012fc:	00090593          	mv	a1,s2
80001300:	03c50513          	addi	a0,a0,60 # 8000e03c <STACK_TOP+0xfffee03c>
80001304:	134010ef          	jal	ra,80002438 <uart_printf>
    core_ctrl(2);
80001308:	00200513          	li	a0,2
8000130c:	384010ef          	jal	ra,80002690 <core_ctrl>
    if (gba_backup_type == GBA_BACKUP_SRAM || gba_backup_type == GBA_BACKUP_FLASH512K || gba_backup_type == GBA_BACKUP_FLASH1M)
80001310:	8384a783          	lw	a5,-1992(s1)
    DEBUG("loadgba: initializaing cartram with loader command 2");
80001314:	8000e537          	lui	a0,0x8000e
80001318:	05c50513          	addi	a0,a0,92 # 8000e05c <STACK_TOP+0xfffee05c>
    if (gba_backup_type == GBA_BACKUP_SRAM || gba_backup_type == GBA_BACKUP_FLASH512K || gba_backup_type == GBA_BACKUP_FLASH1M)
8000131c:	fff78913          	addi	s2,a5,-1
80001320:	00393913          	sltiu	s2,s2,3
80001324:	41200933          	neg	s2,s2
    DEBUG("loadgba: initializaing cartram with loader command 2");
80001328:	00008437          	lui	s0,0x8
8000132c:	10c010ef          	jal	ra,80002438 <uart_printf>
        core_data(cartrom_data);
80001330:	fff40413          	addi	s0,s0,-1 # 7fff <crtStart-0x7fff8001>
80001334:	00090513          	mv	a0,s2
80001338:	364010ef          	jal	ra,8000269c <core_data>
    for (int i = 0; i < 128*1024/4; i++)
8000133c:	fe041ae3          	bnez	s0,80001330 <loadgba.part.2+0x1d0>
    DEBUG("loadgba: set backup type=%d.\n", gba_backup_type); 
80001340:	8384a583          	lw	a1,-1992(s1)
80001344:	8000e537          	lui	a0,0x8000e
80001348:	09450513          	addi	a0,a0,148 # 8000e094 <STACK_TOP+0xfffee094>
8000134c:	0ec010ef          	jal	ra,80002438 <uart_printf>
    core_ctrl(3);
80001350:	00300513          	li	a0,3
80001354:	33c010ef          	jal	ra,80002690 <core_ctrl>
    core_data(gba_backup_type);
80001358:	8384a503          	lw	a0,-1992(s1)
8000135c:	340010ef          	jal	ra,8000269c <core_data>
    if (gba_backup_type != GBA_BACKUP_NONE) {
80001360:	8384a783          	lw	a5,-1992(s1)
80001364:	10079a63          	bnez	a5,80001478 <loadgba.part.2+0x318>
    gba_load_bios();
80001368:	ca9ff0ef          	jal	ra,80001010 <gba_load_bios>
    status("Success");
8000136c:	8000e537          	lui	a0,0x8000e
80001370:	0dc50513          	addi	a0,a0,220 # 8000e0dc <STACK_TOP+0xfffee0dc>
80001374:	8ccff0ef          	jal	ra,80000440 <status>
    core_running = true;
80001378:	00100793          	li	a5,1
8000137c:	80011737          	lui	a4,0x80011
    overlay(0);		// turn off OSD
80001380:	00000513          	li	a0,0
    core_running = true;
80001384:	82f70823          	sb	a5,-2000(a4) # 80010830 <STACK_TOP+0xffff0830>
    overlay(0);		// turn off OSD
80001388:	089000ef          	jal	ra,80001c10 <overlay>
    core_ctrl(0);   // turn off game loading, this starts the core
8000138c:	00000513          	li	a0,0
80001390:	300010ef          	jal	ra,80002690 <core_ctrl>
    f_close(&f);
80001394:	02010513          	addi	a0,sp,32
80001398:	795060ef          	jal	ra,8000832c <f_close>
}
8000139c:	2ac12083          	lw	ra,684(sp)
800013a0:	2a812403          	lw	s0,680(sp)
800013a4:	000a8513          	mv	a0,s5
800013a8:	2a412483          	lw	s1,676(sp)
800013ac:	2a012903          	lw	s2,672(sp)
800013b0:	29c12983          	lw	s3,668(sp)
800013b4:	29812a03          	lw	s4,664(sp)
800013b8:	29412a83          	lw	s5,660(sp)
800013bc:	29012b03          	lw	s6,656(sp)
800013c0:	28c12b83          	lw	s7,652(sp)
800013c4:	28812c03          	lw	s8,648(sp)
800013c8:	28412c83          	lw	s9,644(sp)
800013cc:	28012d03          	lw	s10,640(sp)
800013d0:	27c12d83          	lw	s11,636(sp)
800013d4:	2b010113          	addi	sp,sp,688
800013d8:	00008067          	ret
                    if (detect == 1 && w == 0x565f4d4f) {                // 'OM_V'
800013dc:	565f5637          	lui	a2,0x565f5
800013e0:	d4f60613          	addi	a2,a2,-689 # 565f4d4f <crtStart-0x29a0b2b1>
                        detect = 0;
800013e4:	00000413          	li	s0,0
                    if (detect == 1 && w == 0x565f4d4f) {                // 'OM_V'
800013e8:	e8cc9ce3          	bne	s9,a2,80001280 <loadgba.part.2+0x120>
                        gba_backup_type = GBA_BACKUP_EEPROM;
800013ec:	00400693          	li	a3,4
800013f0:	82d4ac23          	sw	a3,-1992(s1)
                        detect = 0;
800013f4:	e8dff06f          	j	80001280 <loadgba.part.2+0x120>
                            detect = 2;
800013f8:	00200413          	li	s0,2
800013fc:	e85ff06f          	j	80001280 <loadgba.part.2+0x120>
                        if ( (  w & 0xffffff) == 0x565f48 ||            // 'H_V'
80001400:	00566637          	lui	a2,0x566
80001404:	013cf5b3          	and	a1,s9,s3
80001408:	f4860613          	addi	a2,a2,-184 # 565f48 <crtStart-0x7fa9a0b8>
8000140c:	02c58663          	beq	a1,a2,80001438 <loadgba.part.2+0x2d8>
80001410:	32313637          	lui	a2,0x32313
80001414:	54860613          	addi	a2,a2,1352 # 32313548 <crtStart-0x4dcecab8>
80001418:	02cc8063          	beq	s9,a2,80001438 <loadgba.part.2+0x2d8>
                        else if (w == 0x5F4D3148)                       // 'H1M_'
8000141c:	5f4d3637          	lui	a2,0x5f4d3
80001420:	14860613          	addi	a2,a2,328 # 5f4d3148 <crtStart-0x20b2ceb8>
80001424:	0acc8263          	beq	s9,a2,800014c8 <loadgba.part.2+0x368>
                        detect = 0;
80001428:	00000413          	li	s0,0
8000142c:	e55ff06f          	j	80001280 <loadgba.part.2+0x120>
                            detect = 1;
80001430:	00100413          	li	s0,1
80001434:	e4dff06f          	j	80001280 <loadgba.part.2+0x120>
                            gba_backup_type = GBA_BACKUP_FLASH512K;
80001438:	00100693          	li	a3,1
8000143c:	82d4ac23          	sw	a3,-1992(s1)
                        detect = 0;
80001440:	00000413          	li	s0,0
80001444:	e3dff06f          	j	80001280 <loadgba.part.2+0x120>
        if ((total & 0xffff) == 0) {	// display progress every 64KB
80001448:	017977b3          	and	a5,s2,s7
8000144c:	ea0796e3          	bnez	a5,800012f8 <loadgba.part.2+0x198>
            status("");
80001450:	8000e7b7          	lui	a5,0x8000e
80001454:	05878513          	addi	a0,a5,88 # 8000e058 <STACK_TOP+0xfffee058>
80001458:	fe9fe0ef          	jal	ra,80000440 <status>
            printf("%d/%dK ", total >> 10, size >> 10);
8000145c:	00c12603          	lw	a2,12(sp)
80001460:	8000e7b7          	lui	a5,0x8000e
80001464:	00a95593          	srli	a1,s2,0xa
80001468:	03478513          	addi	a0,a5,52 # 8000e034 <STACK_TOP+0xfffee034>
8000146c:	6d9000ef          	jal	ra,80002344 <printf>
80001470:	01c12683          	lw	a3,28(sp)
80001474:	e7dff06f          	j	800012f0 <loadgba.part.2+0x190>
        if (gba_backup_type == GBA_BACKUP_FLASH1M) 
80001478:	00200713          	li	a4,2
8000147c:	06e78663          	beq	a5,a4,800014e8 <loadgba.part.2+0x388>
        else if (gba_backup_type == GBA_BACKUP_EEPROM)
80001480:	00400713          	li	a4,4
80001484:	08e78463          	beq	a5,a4,8000150c <loadgba.part.2+0x3ac>
            core_backup_size = 64*1024;    
80001488:	000107b7          	lui	a5,0x10
8000148c:	c6f1ae23          	sw	a5,-900(gp) # 8000efec <core_backup_size>
80001490:	00010637          	lui	a2,0x10
        DEBUG("loadgba: calling backup_load: %s %d\n", core_backup_name, core_backup_size);
80001494:	800115b7          	lui	a1,0x80011
80001498:	8000e537          	lui	a0,0x8000e
8000149c:	4fc58593          	addi	a1,a1,1276 # 800114fc <STACK_TOP+0xffff14fc>
800014a0:	0b450513          	addi	a0,a0,180 # 8000e0b4 <STACK_TOP+0xfffee0b4>
800014a4:	795000ef          	jal	ra,80002438 <uart_printf>
    if (!option_backup_bsram || size == 0) return;
800014a8:	c681c783          	lbu	a5,-920(gp) # 8000efd8 <option_backup_bsram>
    core_backup_valid = false;
800014ac:	80011737          	lui	a4,0x80011
800014b0:	c4070223          	sb	zero,-956(a4) # 80010c44 <STACK_TOP+0xffff0c44>
        backup_load(core_backup_name, core_backup_size);
800014b4:	c7c1a503          	lw	a0,-900(gp) # 8000efec <core_backup_size>
    if (!option_backup_bsram || size == 0) return;
800014b8:	ea0788e3          	beqz	a5,80001368 <loadgba.part.2+0x208>
800014bc:	ea0506e3          	beqz	a0,80001368 <loadgba.part.2+0x208>
800014c0:	fd9fe0ef          	jal	ra,80000498 <backup_load.part.1>
800014c4:	ea5ff06f          	j	80001368 <loadgba.part.2+0x208>
                            gba_backup_type = GBA_BACKUP_FLASH1M;
800014c8:	8284ac23          	sw	s0,-1992(s1)
                        detect = 0;
800014cc:	00000413          	li	s0,0
800014d0:	db1ff06f          	j	80001280 <loadgba.part.2+0x120>
800014d4:	00050a93          	mv	s5,a0
        status("Cannot open file");
800014d8:	8000e537          	lui	a0,0x8000e
800014dc:	01050513          	addi	a0,a0,16 # 8000e010 <STACK_TOP+0xfffee010>
800014e0:	f61fe0ef          	jal	ra,80000440 <status>
        goto loadgba_end;
800014e4:	eb9ff06f          	j	8000139c <loadgba.part.2+0x23c>
            core_backup_size = 128*1024;
800014e8:	000207b7          	lui	a5,0x20
800014ec:	c6f1ae23          	sw	a5,-900(gp) # 8000efec <core_backup_size>
800014f0:	00020637          	lui	a2,0x20
800014f4:	fa1ff06f          	j	80001494 <loadgba.part.2+0x334>
        status("Seek failure");
800014f8:	8000e537          	lui	a0,0x8000e
800014fc:	02450513          	addi	a0,a0,36 # 8000e024 <STACK_TOP+0xfffee024>
80001500:	f41fe0ef          	jal	ra,80000440 <status>
80001504:	00040a93          	mv	s5,s0
80001508:	e85ff06f          	j	8000138c <loadgba.part.2+0x22c>
            core_backup_size = 8*1024;
8000150c:	000027b7          	lui	a5,0x2
80001510:	c6f1ae23          	sw	a5,-900(gp) # 8000efec <core_backup_size>
80001514:	00002637          	lui	a2,0x2
80001518:	f7dff06f          	j	80001494 <loadgba.part.2+0x334>

8000151c <loadgba>:
int loadgba(int rom) {
8000151c:	fe010113          	addi	sp,sp,-32
80001520:	00912a23          	sw	s1,20(sp)
    strncpy(load_fname, pwd, 1024);
80001524:	800115b7          	lui	a1,0x80011
80001528:	800114b7          	lui	s1,0x80011
int loadgba(int rom) {
8000152c:	01312623          	sw	s3,12(sp)
    strncpy(load_fname, pwd, 1024);
80001530:	40000613          	li	a2,1024
int loadgba(int rom) {
80001534:	00050993          	mv	s3,a0
    strncpy(load_fname, pwd, 1024);
80001538:	ca058593          	addi	a1,a1,-864 # 80010ca0 <STACK_TOP+0xffff0ca0>
8000153c:	0a048513          	addi	a0,s1,160 # 800110a0 <STACK_TOP+0xffff10a0>
int loadgba(int rom) {
80001540:	00112e23          	sw	ra,28(sp)
80001544:	00812c23          	sw	s0,24(sp)
80001548:	01212823          	sw	s2,16(sp)
    strncpy(load_fname, pwd, 1024);
8000154c:	484010ef          	jal	ra,800029d0 <strncpy>
    strncat(load_fname, "/", 1024);
80001550:	8000e5b7          	lui	a1,0x8000e
80001554:	40000613          	li	a2,1024
80001558:	0e458593          	addi	a1,a1,228 # 8000e0e4 <STACK_TOP+0xfffee0e4>
8000155c:	0a048513          	addi	a0,s1,160
80001560:	3dc010ef          	jal	ra,8000293c <strncat>
    strncat(load_fname, file_names[rom], 1024);
80001564:	8000f7b7          	lui	a5,0x8000f
80001568:	ff078793          	addi	a5,a5,-16 # 8000eff0 <STACK_TOP+0xfffeeff0>
8000156c:	00899413          	slli	s0,s3,0x8
80001570:	00f40433          	add	s0,s0,a5
80001574:	00040593          	mv	a1,s0
80001578:	40000613          	li	a2,1024
8000157c:	0a048513          	addi	a0,s1,160
80001580:	3bc010ef          	jal	ra,8000293c <strncat>
    DEBUG("loadgba start\n");
80001584:	8000e537          	lui	a0,0x8000e
80001588:	0e850513          	addi	a0,a0,232 # 8000e0e8 <STACK_TOP+0xfffee0e8>
8000158c:	6ad000ef          	jal	ra,80002438 <uart_printf>
    char *p = strcasestr(file_names[rom], ".gba");
80001590:	8000e5b7          	lui	a1,0x8000e
80001594:	0f858593          	addi	a1,a1,248 # 8000e0f8 <STACK_TOP+0xfffee0f8>
80001598:	00040513          	mv	a0,s0
8000159c:	2c0010ef          	jal	ra,8000285c <strcasestr>
    if (p == NULL) {
800015a0:	06050c63          	beqz	a0,80001618 <loadgba+0xfc>
    int base_len = p-file_names[rom];
800015a4:	408504b3          	sub	s1,a0,s0
    strncpy(core_backup_name, file_names[rom], base_len);
800015a8:	80011937          	lui	s2,0x80011
800015ac:	00048613          	mv	a2,s1
800015b0:	00040593          	mv	a1,s0
800015b4:	4fc90513          	addi	a0,s2,1276 # 800114fc <STACK_TOP+0xffff14fc>
800015b8:	418010ef          	jal	ra,800029d0 <strncpy>
    strcpy(core_backup_name+base_len, ".srm");
800015bc:	4fc90513          	addi	a0,s2,1276
800015c0:	8000e5b7          	lui	a1,0x8000e
800015c4:	11458593          	addi	a1,a1,276 # 8000e114 <STACK_TOP+0xfffee114>
800015c8:	00950533          	add	a0,a0,s1
800015cc:	3e8010ef          	jal	ra,800029b4 <strcpy>
    if (sd_init() != 0) return 99;
800015d0:	171010ef          	jal	ra,80002f40 <sd_init>
800015d4:	02051263          	bnez	a0,800015f8 <loadgba+0xdc>
}
800015d8:	01812403          	lw	s0,24(sp)
800015dc:	01c12083          	lw	ra,28(sp)
800015e0:	01412483          	lw	s1,20(sp)
800015e4:	01012903          	lw	s2,16(sp)
800015e8:	00098513          	mv	a0,s3
800015ec:	00c12983          	lw	s3,12(sp)
800015f0:	02010113          	addi	sp,sp,32
800015f4:	b6dff06f          	j	80001160 <loadgba.part.2>
800015f8:	01c12083          	lw	ra,28(sp)
800015fc:	01812403          	lw	s0,24(sp)
80001600:	01412483          	lw	s1,20(sp)
80001604:	01012903          	lw	s2,16(sp)
80001608:	00c12983          	lw	s3,12(sp)
    if (sd_init() != 0) return 99;
8000160c:	06300513          	li	a0,99
}
80001610:	02010113          	addi	sp,sp,32
80001614:	00008067          	ret
        status("Only .gba supported");
80001618:	8000e537          	lui	a0,0x8000e
8000161c:	10050513          	addi	a0,a0,256 # 8000e100 <STACK_TOP+0xfffee100>
80001620:	e21fe0ef          	jal	ra,80000440 <status>
}
80001624:	01c12083          	lw	ra,28(sp)
80001628:	01812403          	lw	s0,24(sp)
8000162c:	01412483          	lw	s1,20(sp)
80001630:	01012903          	lw	s2,16(sp)
80001634:	00c12983          	lw	s3,12(sp)
    int r = 1;
80001638:	00100513          	li	a0,1
}
8000163c:	02010113          	addi	sp,sp,32
80001640:	00008067          	ret

80001644 <menu_loadrom>:
int menu_loadrom(int *choice) {
80001644:	fa010113          	addi	sp,sp,-96
80001648:	03712e23          	sw	s7,60(sp)
                    print(file_names[i]);
8000164c:	8000f737          	lui	a4,0x8000f
    pwd[0] = '/';
80001650:	80011bb7          	lui	s7,0x80011
int menu_loadrom(int *choice) {
80001654:	05312623          	sw	s3,76(sp)
80001658:	05612023          	sw	s6,64(sp)
8000165c:	03912a23          	sw	s9,52(sp)
80001660:	03a12823          	sw	s10,48(sp)
                    print(file_names[i]);
80001664:	ff070693          	addi	a3,a4,-16 # 8000eff0 <STACK_TOP+0xfffeeff0>
int menu_loadrom(int *choice) {
80001668:	04112e23          	sw	ra,92(sp)
8000166c:	04812c23          	sw	s0,88(sp)
80001670:	04912a23          	sw	s1,84(sp)
80001674:	05212823          	sw	s2,80(sp)
80001678:	05412423          	sw	s4,72(sp)
8000167c:	05512223          	sw	s5,68(sp)
80001680:	03812c23          	sw	s8,56(sp)
80001684:	03b12623          	sw	s11,44(sp)
    pwd[0] = '/';
80001688:	ca0b8793          	addi	a5,s7,-864 # 80010ca0 <STACK_TOP+0xffff0ca0>
8000168c:	02f00713          	li	a4,47
                    if (idx != 0 && file_dir[i])
80001690:	80011b37          	lui	s6,0x80011
                    print(file_names[i]);
80001694:	00d12623          	sw	a3,12(sp)
int menu_loadrom(int *choice) {
80001698:	00050c93          	mv	s9,a0
    int active = 0;
8000169c:	00012e23          	sw	zero,28(sp)
    pwd[0] = '/';
800016a0:	00e78023          	sb	a4,0(a5)
    pwd[1] = '\0';
800016a4:	000780a3          	sb	zero,1(a5)
    int page = 0, pages, total;
800016a8:	00000993          	li	s3,0
800016ac:	00012223          	sw	zero,4(sp)
                    print(file_names[i]);
800016b0:	e0068d13          	addi	s10,a3,-512
                    if (idx != 0 && file_dir[i])
800016b4:	4a0b0b13          	addi	s6,s6,1184 # 800114a0 <STACK_TOP+0xffff14a0>
        clear();
800016b8:	4d5000ef          	jal	ra,8000238c <clear>
        int r = load_dir(pwd, page*PAGESIZE, PAGESIZE, &total);
800016bc:	00412783          	lw	a5,4(sp)
800016c0:	01810693          	addi	a3,sp,24
800016c4:	01600613          	li	a2,22
800016c8:	01378433          	add	s0,a5,s3
800016cc:	00241413          	slli	s0,s0,0x2
800016d0:	41340433          	sub	s0,s0,s3
800016d4:	00141413          	slli	s0,s0,0x1
800016d8:	00040593          	mv	a1,s0
800016dc:	ca0b8513          	addi	a0,s7,-864
800016e0:	c04ff0ef          	jal	ra,80000ae4 <load_dir>
800016e4:	00050493          	mv	s1,a0
        if (r == 0) {
800016e8:	1e051063          	bnez	a0,800018c8 <menu_loadrom+0x284>
            pages = (total+PAGESIZE-1) / PAGESIZE;
800016ec:	01812503          	lw	a0,24(sp)
800016f0:	01600593          	li	a1,22
            printf("%d/%d", page+1, pages);
800016f4:	00198493          	addi	s1,s3,1
            pages = (total+PAGESIZE-1) / PAGESIZE;
800016f8:	01550513          	addi	a0,a0,21
            printf("%d/%d", page+1, pages);
800016fc:	00912423          	sw	s1,8(sp)
            pages = (total+PAGESIZE-1) / PAGESIZE;
80001700:	2c80c0ef          	jal	ra,8000d9c8 <__divsi3>
            status("Page ");
80001704:	8000e7b7          	lui	a5,0x8000e
            pages = (total+PAGESIZE-1) / PAGESIZE;
80001708:	00050a93          	mv	s5,a0
            status("Page ");
8000170c:	11c78513          	addi	a0,a5,284 # 8000e11c <STACK_TOP+0xfffee11c>
80001710:	d31fe0ef          	jal	ra,80000440 <status>
            printf("%d/%d", page+1, pages);
80001714:	8000e537          	lui	a0,0x8000e
80001718:	00048593          	mv	a1,s1
8000171c:	000a8613          	mv	a2,s5
80001720:	12450513          	addi	a0,a0,292 # 8000e124 <STACK_TOP+0xfffee124>
80001724:	421000ef          	jal	ra,80002344 <printf>
            if (active > file_len-1)
80001728:	800114b7          	lui	s1,0x80011
8000172c:	83c4a783          	lw	a5,-1988(s1) # 8001083c <STACK_TOP+0xffff083c>
80001730:	01c12703          	lw	a4,28(sp)
80001734:	00f74663          	blt	a4,a5,80001740 <menu_loadrom+0xfc>
                active = file_len-1;
80001738:	fff78793          	addi	a5,a5,-1
8000173c:	00f12e23          	sw	a5,28(sp)
    int page = 0, pages, total;
80001740:	00200c13          	li	s8,2
80001744:	ffe40413          	addi	s0,s0,-2
                        print("/");
80001748:	8000ea37          	lui	s4,0x8000e
            for (int i = 0; i < PAGESIZE; i++) {
8000174c:	01800913          	li	s2,24
80001750:	00c0006f          	j	8000175c <menu_loadrom+0x118>
80001754:	001c0c13          	addi	s8,s8,1
80001758:	052c0663          	beq	s8,s2,800017a4 <menu_loadrom+0x160>
                cursor(2, i+TOPLINE);
8000175c:	000c0593          	mv	a1,s8
80001760:	00200513          	li	a0,2
80001764:	498000ef          	jal	ra,80001bfc <cursor>
                if (idx < total) {
80001768:	01812703          	lw	a4,24(sp)
8000176c:	01840db3          	add	s11,s0,s8
80001770:	feedd2e3          	bge	s11,a4,80001754 <menu_loadrom+0x110>
                    print(file_names[i]);
80001774:	008c1513          	slli	a0,s8,0x8
80001778:	00ad0533          	add	a0,s10,a0
8000177c:	58c000ef          	jal	ra,80001d08 <print>
                    if (idx != 0 && file_dir[i])
80001780:	002c1713          	slli	a4,s8,0x2
80001784:	01670733          	add	a4,a4,s6
80001788:	fc0d86e3          	beqz	s11,80001754 <menu_loadrom+0x110>
8000178c:	ff872783          	lw	a5,-8(a4)
80001790:	fc0782e3          	beqz	a5,80001754 <menu_loadrom+0x110>
                        print("/");
80001794:	0e4a0513          	addi	a0,s4,228 # 8000e0e4 <STACK_TOP+0xfffee0e4>
80001798:	001c0c13          	addi	s8,s8,1
8000179c:	56c000ef          	jal	ra,80001d08 <print>
            for (int i = 0; i < PAGESIZE; i++) {
800017a0:	fb2c1ee3          	bne	s8,s2,8000175c <menu_loadrom+0x118>
            delay(300);
800017a4:	12c00513          	li	a0,300
800017a8:	4d9000ef          	jal	ra,80002480 <delay>
800017ac:	8000f937          	lui	s2,0x8000f
                int r = joy_choice(TOPLINE, file_len, &active, OSD_KEY_CODE);
800017b0:	00100413          	li	s0,1
                } else if (r == 3 && page > 0) {
800017b4:	00300a13          	li	s4,3
                if (r == 2 && page < pages-1) {
800017b8:	fffa8a93          	addi	s5,s5,-1
                    if (strcmp(pwd, "/") == 0 && page == 0 && active == 0) {
800017bc:	8000ec37          	lui	s8,0x8000e
                int r = joy_choice(TOPLINE, file_len, &active, OSD_KEY_CODE);
800017c0:	b7092783          	lw	a5,-1168(s2) # 8000eb70 <STACK_TOP+0xfffeeb70>
800017c4:	01c10613          	addi	a2,sp,28
800017c8:	00200513          	li	a0,2
800017cc:	83c4a583          	lw	a1,-1988(s1)
800017d0:	00c00693          	li	a3,12
800017d4:	00878463          	beq	a5,s0,800017dc <menu_loadrom+0x198>
800017d8:	08400693          	li	a3,132
800017dc:	4e1000ef          	jal	ra,800024bc <joy_choice>
800017e0:	00050d93          	mv	s11,a0
                if (r == 2 && page < pages-1) {
800017e4:	00200713          	li	a4,2
                if (r == 1) {
800017e8:	02850a63          	beq	a0,s0,8000181c <menu_loadrom+0x1d8>
                if (r == 2 && page < pages-1) {
800017ec:	00e50e63          	beq	a0,a4,80001808 <menu_loadrom+0x1c4>
                } else if (r == 3 && page > 0) {
800017f0:	fd4518e3          	bne	a0,s4,800017c0 <menu_loadrom+0x17c>
800017f4:	fc0986e3          	beqz	s3,800017c0 <menu_loadrom+0x17c>
                    page--;
800017f8:	fff98993          	addi	s3,s3,-1
                    break;
800017fc:	00199793          	slli	a5,s3,0x1
80001800:	00f12223          	sw	a5,4(sp)
80001804:	eb5ff06f          	j	800016b8 <menu_loadrom+0x74>
                if (r == 2 && page < pages-1) {
80001808:	fb59dce3          	bge	s3,s5,800017c0 <menu_loadrom+0x17c>
            printf("%d/%d", page+1, pages);
8000180c:	00812983          	lw	s3,8(sp)
80001810:	00199793          	slli	a5,s3,0x1
80001814:	00f12223          	sw	a5,4(sp)
80001818:	ea1ff06f          	j	800016b8 <menu_loadrom+0x74>
                    if (strcmp(pwd, "/") == 0 && page == 0 && active == 0) {
8000181c:	0e4c0593          	addi	a1,s8,228 # 8000e0e4 <STACK_TOP+0xfffee0e4>
80001820:	ca0b8513          	addi	a0,s7,-864
80001824:	769000ef          	jal	ra,8000278c <strcmp>
80001828:	01c12703          	lw	a4,28(sp)
                    } else if (file_dir[active]) {
8000182c:	00271693          	slli	a3,a4,0x2
80001830:	00db0633          	add	a2,s6,a3
                    if (strcmp(pwd, "/") == 0 && page == 0 && active == 0) {
80001834:	013766b3          	or	a3,a4,s3
80001838:	00a6e6b3          	or	a3,a3,a0
                        res = loadgba(active);
8000183c:	00070513          	mv	a0,a4
                    if (strcmp(pwd, "/") == 0 && page == 0 && active == 0) {
80001840:	0a068463          	beqz	a3,800018e8 <menu_loadrom+0x2a4>
                    } else if (file_dir[active]) {
80001844:	00062783          	lw	a5,0(a2) # 2000 <crtStart-0x7fffe000>
80001848:	02079263          	bnez	a5,8000186c <menu_loadrom+0x228>
                        *choice = active;
8000184c:	00eca023          	sw	a4,0(s9)
                        res = loadgba(active);
80001850:	ccdff0ef          	jal	ra,8000151c <loadgba>
                        if (res != 0) {
80001854:	f60506e3          	beqz	a0,800017c0 <menu_loadrom+0x17c>
                            message("Cannot load rom",1);
80001858:	8000e537          	lui	a0,0x8000e
8000185c:	00100593          	li	a1,1
80001860:	12c50513          	addi	a0,a0,300 # 8000e12c <STACK_TOP+0xfffee12c>
80001864:	ecdfe0ef          	jal	ra,80000730 <message>
                            break;
80001868:	e51ff06f          	j	800016b8 <menu_loadrom+0x74>
                        if (file_names[active][0] == '.' && file_names[active][1] == '.') {
8000186c:	00871793          	slli	a5,a4,0x8
80001870:	00c12703          	lw	a4,12(sp)
80001874:	02e00693          	li	a3,46
80001878:	00f707b3          	add	a5,a4,a5
8000187c:	0007c703          	lbu	a4,0(a5)
80001880:	00d71663          	bne	a4,a3,8000188c <menu_loadrom+0x248>
80001884:	0017c783          	lbu	a5,1(a5)
80001888:	0ae78063          	beq	a5,a4,80001928 <menu_loadrom+0x2e4>
                            strncat(pwd, "/", PWD_SIZE);
8000188c:	40000613          	li	a2,1024
80001890:	0e4c0593          	addi	a1,s8,228
80001894:	ca0b8513          	addi	a0,s7,-864
80001898:	0a4010ef          	jal	ra,8000293c <strncat>
                            strncat(pwd, file_names[active], PWD_SIZE);
8000189c:	01c12583          	lw	a1,28(sp)
800018a0:	00c12783          	lw	a5,12(sp)
800018a4:	40000613          	li	a2,1024
800018a8:	00859593          	slli	a1,a1,0x8
800018ac:	ca0b8513          	addi	a0,s7,-864
800018b0:	00b785b3          	add	a1,a5,a1
800018b4:	088010ef          	jal	ra,8000293c <strncat>
                        active = 0;
800018b8:	00012e23          	sw	zero,28(sp)
                        page = 0;
800018bc:	00000993          	li	s3,0
800018c0:	00012223          	sw	zero,4(sp)
                        break;
800018c4:	df5ff06f          	j	800016b8 <menu_loadrom+0x74>
            status("Error opening director");
800018c8:	8000e537          	lui	a0,0x8000e
800018cc:	13c50513          	addi	a0,a0,316 # 8000e13c <STACK_TOP+0xfffee13c>
800018d0:	b71fe0ef          	jal	ra,80000440 <status>
            printf(" %d", r);
800018d4:	8000e537          	lui	a0,0x8000e
800018d8:	00048593          	mv	a1,s1
800018dc:	15450513          	addi	a0,a0,340 # 8000e154 <STACK_TOP+0xfffee154>
800018e0:	265000ef          	jal	ra,80002344 <printf>
            return -1;
800018e4:	fff00d93          	li	s11,-1
}
800018e8:	05c12083          	lw	ra,92(sp)
800018ec:	05812403          	lw	s0,88(sp)
800018f0:	000d8513          	mv	a0,s11
800018f4:	05412483          	lw	s1,84(sp)
800018f8:	05012903          	lw	s2,80(sp)
800018fc:	04c12983          	lw	s3,76(sp)
80001900:	04812a03          	lw	s4,72(sp)
80001904:	04412a83          	lw	s5,68(sp)
80001908:	04012b03          	lw	s6,64(sp)
8000190c:	03c12b83          	lw	s7,60(sp)
80001910:	03812c03          	lw	s8,56(sp)
80001914:	03412c83          	lw	s9,52(sp)
80001918:	03012d03          	lw	s10,48(sp)
8000191c:	02c12d83          	lw	s11,44(sp)
80001920:	06010113          	addi	sp,sp,96
80001924:	00008067          	ret
                            char *slash = strrchr(pwd, '/');
80001928:	02f00593          	li	a1,47
8000192c:	ca0b8513          	addi	a0,s7,-864
80001930:	0f4010ef          	jal	ra,80002a24 <strrchr>
                            if (slash)
80001934:	f80502e3          	beqz	a0,800018b8 <menu_loadrom+0x274>
                                *slash = '\0';
80001938:	00050023          	sb	zero,0(a0)
8000193c:	f7dff06f          	j	800018b8 <menu_loadrom+0x274>

80001940 <backup_load>:
    if (!option_backup_bsram || size == 0) return;
80001940:	c681c783          	lbu	a5,-920(gp) # 8000efd8 <option_backup_bsram>
    core_backup_valid = false;
80001944:	80011737          	lui	a4,0x80011
80001948:	c4070223          	sb	zero,-956(a4) # 80010c44 <STACK_TOP+0xffff0c44>
    if (!option_backup_bsram || size == 0) return;
8000194c:	00078463          	beqz	a5,80001954 <backup_load+0x14>
80001950:	00059463          	bnez	a1,80001958 <backup_load+0x18>
}
80001954:	00008067          	ret
80001958:	00058513          	mv	a0,a1
8000195c:	b3dfe06f          	j	80000498 <backup_load.part.1>

80001960 <backup_save>:
    if (!option_backup_bsram || !core_backup_valid || size == 0) return 1;
80001960:	c681c783          	lbu	a5,-920(gp) # 8000efd8 <option_backup_bsram>
80001964:	00078e63          	beqz	a5,80001980 <backup_save+0x20>
80001968:	800117b7          	lui	a5,0x80011
8000196c:	c447c783          	lbu	a5,-956(a5) # 80010c44 <STACK_TOP+0xffff0c44>
80001970:	00078863          	beqz	a5,80001980 <backup_save+0x20>
80001974:	00058663          	beqz	a1,80001980 <backup_save+0x20>
80001978:	00058513          	mv	a0,a1
8000197c:	c71fe06f          	j	800005ec <backup_save.part.3>
}
80001980:	00100513          	li	a0,1
80001984:	00008067          	ret

80001988 <backup_process>:

int backup_success_time;
void backup_process() {
    if (!core_running)
80001988:	800117b7          	lui	a5,0x80011
8000198c:	8307c783          	lbu	a5,-2000(a5) # 80010830 <STACK_TOP+0xffff0830>
80001990:	06078c63          	beqz	a5,80001a08 <backup_process+0x80>
        return;
    int size = 0;

    // if (gba_backup_type == GBA_BACKUP_NONE || gba_backup_type == GBA_BACKUP_EEPROM)     // disable EEPROM persistence for now
    if (gba_backup_type == GBA_BACKUP_NONE)
80001994:	800117b7          	lui	a5,0x80011
80001998:	8387a583          	lw	a1,-1992(a5) # 80010838 <STACK_TOP+0xffff0838>
8000199c:	06058663          	beqz	a1,80001a08 <backup_process+0x80>
void backup_process() {
800019a0:	ff010113          	addi	sp,sp,-16
800019a4:	00912223          	sw	s1,4(sp)
800019a8:	00112623          	sw	ra,12(sp)
800019ac:	00812423          	sw	s0,8(sp)
800019b0:	01212023          	sw	s2,0(sp)
        return;
    if (gba_backup_type == GBA_BACKUP_FLASH1M) 
800019b4:	00200793          	li	a5,2
        size = 128*1024;
800019b8:	000204b7          	lui	s1,0x20
    if (gba_backup_type == GBA_BACKUP_FLASH1M) 
800019bc:	00f58a63          	beq	a1,a5,800019d0 <backup_process+0x48>
    else if (gba_backup_type == GBA_BACKUP_EEPROM)
800019c0:	00400793          	li	a5,4
        size = 8*1024;
800019c4:	000024b7          	lui	s1,0x2
    else if (gba_backup_type == GBA_BACKUP_EEPROM)
800019c8:	00f58463          	beq	a1,a5,800019d0 <backup_process+0x48>
    else
        size = 64*1024;
800019cc:	000104b7          	lui	s1,0x10
    else
        return c;
}

inline uint32_t time_millis() {
    return reg_time;
800019d0:	020007b7          	lui	a5,0x2000

    int t = time_millis();
    if (t - core_backup_time >= 10000) {                    // need to save
800019d4:	80011937          	lui	s2,0x80011
800019d8:	0507a403          	lw	s0,80(a5) # 2000050 <crtStart-0x7dffffb0>
800019dc:	83492703          	lw	a4,-1996(s2) # 80010834 <STACK_TOP+0xffff0834>
800019e0:	000027b7          	lui	a5,0x2
800019e4:	70f78793          	addi	a5,a5,1807 # 270f <crtStart-0x7fffd8f1>
800019e8:	40e40733          	sub	a4,s0,a4
800019ec:	02e7e063          	bltu	a5,a4,80001a0c <backup_process+0x84>
            printf("Backup saved to sdcard %ds ago ", (t-backup_success_time)/1000);
            print_hex_digits(snes_bsram_crc16, 4);
        }
        core_backup_time = t;
    }
}
800019f0:	00c12083          	lw	ra,12(sp)
800019f4:	00812403          	lw	s0,8(sp)
800019f8:	00412483          	lw	s1,4(sp)
800019fc:	00012903          	lw	s2,0(sp)
80001a00:	01010113          	addi	sp,sp,16
80001a04:	00008067          	ret
80001a08:	00008067          	ret
        uart_printf("Check backup: type=%d, size=%d\n", gba_backup_type, size);
80001a0c:	8000e537          	lui	a0,0x8000e
80001a10:	00048613          	mv	a2,s1
80001a14:	15850513          	addi	a0,a0,344 # 8000e158 <STACK_TOP+0xfffee158>
80001a18:	221000ef          	jal	ra,80002438 <uart_printf>
    if (!option_backup_bsram || !core_backup_valid || size == 0) return 1;
80001a1c:	c681c783          	lbu	a5,-920(gp) # 8000efd8 <option_backup_bsram>
80001a20:	04078463          	beqz	a5,80001a68 <backup_process+0xe0>
80001a24:	800117b7          	lui	a5,0x80011
80001a28:	c447c783          	lbu	a5,-956(a5) # 80010c44 <STACK_TOP+0xffff0c44>
80001a2c:	02078e63          	beqz	a5,80001a68 <backup_process+0xe0>
80001a30:	00048513          	mv	a0,s1
80001a34:	bb9fe0ef          	jal	ra,800005ec <backup_save.part.3>
            backup_success_time = t;
80001a38:	800104b7          	lui	s1,0x80010
        if (r == 0)
80001a3c:	02051c63          	bnez	a0,80001a74 <backup_process+0xec>
            backup_success_time = t;
80001a40:	5e84a823          	sw	s0,1520(s1) # 800105f0 <STACK_TOP+0xffff05f0>
80001a44:	00040793          	mv	a5,s0
        if (backup_success_time != 0) {
80001a48:	02079a63          	bnez	a5,80001a7c <backup_process+0xf4>
        core_backup_time = t;
80001a4c:	82892a23          	sw	s0,-1996(s2)
}
80001a50:	00c12083          	lw	ra,12(sp)
80001a54:	00812403          	lw	s0,8(sp)
80001a58:	00412483          	lw	s1,4(sp)
80001a5c:	00012903          	lw	s2,0(sp)
80001a60:	01010113          	addi	sp,sp,16
80001a64:	00008067          	ret
80001a68:	800104b7          	lui	s1,0x80010
80001a6c:	5f04a783          	lw	a5,1520(s1) # 800105f0 <STACK_TOP+0xffff05f0>
80001a70:	fd9ff06f          	j	80001a48 <backup_process+0xc0>
80001a74:	5f04a783          	lw	a5,1520(s1)
80001a78:	fd1ff06f          	j	80001a48 <backup_process+0xc0>
            status("");
80001a7c:	8000e537          	lui	a0,0x8000e
80001a80:	05850513          	addi	a0,a0,88 # 8000e058 <STACK_TOP+0xfffee058>
80001a84:	9bdfe0ef          	jal	ra,80000440 <status>
            printf("Backup saved to sdcard %ds ago ", (t-backup_success_time)/1000);
80001a88:	5f04a503          	lw	a0,1520(s1)
80001a8c:	3e800593          	li	a1,1000
80001a90:	40a40533          	sub	a0,s0,a0
80001a94:	7350b0ef          	jal	ra,8000d9c8 <__divsi3>
80001a98:	00050593          	mv	a1,a0
80001a9c:	8000e537          	lui	a0,0x8000e
80001aa0:	17850513          	addi	a0,a0,376 # 8000e178 <STACK_TOP+0xfffee178>
80001aa4:	0a1000ef          	jal	ra,80002344 <printf>
            print_hex_digits(snes_bsram_crc16, 4);
80001aa8:	800117b7          	lui	a5,0x80011
80001aac:	5fc7d503          	lhu	a0,1532(a5) # 800115fc <STACK_TOP+0xffff15fc>
80001ab0:	00400593          	li	a1,4
80001ab4:	380000ef          	jal	ra,80001e34 <print_hex_digits>
80001ab8:	f95ff06f          	j	80001a4c <backup_process+0xc4>

80001abc <gen_crc16>:
uint16_t gen_crc16(const volatile uint8_t *data, int size) {
    uint16_t out = 0;
    int bits_read = 0, bit_flag;

    /* Sanity check: */
    if(data == NULL)
80001abc:	10050663          	beqz	a0,80001bc8 <gen_crc16+0x10c>
80001ac0:	00000713          	li	a4,0
80001ac4:	00000793          	li	a5,0
        return 0;

    while(size > 0)
80001ac8:	08b05463          	blez	a1,80001b50 <gen_crc16+0x94>
    {
        bit_flag = out >> 15;

        /* Get next bit: */
        out <<= 1;
        out |= (*data >> bits_read) & 1; // item a) work from the least significant bits
80001acc:	00054783          	lbu	a5,0(a0)
            size--;
        }

        /* Cycle check: */
        if(bit_flag)
            out ^= CRC16;
80001ad0:	ffff88b7          	lui	a7,0xffff8
        bits_read++;
80001ad4:	00100693          	li	a3,1
        out |= (*data >> bits_read) & 1; // item a) work from the least significant bits
80001ad8:	0017f793          	andi	a5,a5,1
        if(bits_read > 7)
80001adc:	00800313          	li	t1,8
            out ^= CRC16;
80001ae0:	00588893          	addi	a7,a7,5 # ffff8005 <STACK_TOP+0x7ffd8005>
80001ae4:	00f7d713          	srli	a4,a5,0xf
80001ae8:	00179793          	slli	a5,a5,0x1
80001aec:	01071813          	slli	a6,a4,0x10
80001af0:	01079613          	slli	a2,a5,0x10
80001af4:	01085813          	srli	a6,a6,0x10
80001af8:	01065613          	srli	a2,a2,0x10
    while(size > 0)
80001afc:	04058a63          	beqz	a1,80001b50 <gen_crc16+0x94>
        out |= (*data >> bits_read) & 1; // item a) work from the least significant bits
80001b00:	00054783          	lbu	a5,0(a0)
80001b04:	40d7d7b3          	sra	a5,a5,a3
80001b08:	0017f793          	andi	a5,a5,1
80001b0c:	00c7e7b3          	or	a5,a5,a2
        bits_read++;
80001b10:	00168693          	addi	a3,a3,1
            out ^= CRC16;
80001b14:	0117c733          	xor	a4,a5,a7
        if(bits_read > 7)
80001b18:	00669863          	bne	a3,t1,80001b28 <gen_crc16+0x6c>
            data++;
80001b1c:	00150513          	addi	a0,a0,1
            size--;
80001b20:	fff58593          	addi	a1,a1,-1
            bits_read = 0;
80001b24:	00000693          	li	a3,0
        if(bit_flag)
80001b28:	fa080ee3          	beqz	a6,80001ae4 <gen_crc16+0x28>
            out ^= CRC16;
80001b2c:	01071793          	slli	a5,a4,0x10
80001b30:	0107d793          	srli	a5,a5,0x10
80001b34:	00f7d713          	srli	a4,a5,0xf
80001b38:	00179793          	slli	a5,a5,0x1
80001b3c:	01071813          	slli	a6,a4,0x10
80001b40:	01079613          	slli	a2,a5,0x10
80001b44:	01085813          	srli	a6,a6,0x10
80001b48:	01065613          	srli	a2,a2,0x10
    while(size > 0)
80001b4c:	fa059ae3          	bnez	a1,80001b00 <gen_crc16+0x44>
    int i;
    for (i = 0; i < 16; ++i) {
        bit_flag = out >> 15;
        out <<= 1;
        if(bit_flag)
            out ^= CRC16;
80001b50:	ffff85b7          	lui	a1,0xffff8
    uint16_t out = 0;
80001b54:	01000693          	li	a3,16
            out ^= CRC16;
80001b58:	00558593          	addi	a1,a1,5 # ffff8005 <STACK_TOP+0x7ffd8005>
        bit_flag = out >> 15;
80001b5c:	01071713          	slli	a4,a4,0x10
        out <<= 1;
80001b60:	01079793          	slli	a5,a5,0x10
80001b64:	0107d793          	srli	a5,a5,0x10
        bit_flag = out >> 15;
80001b68:	01075713          	srli	a4,a4,0x10
        if(bit_flag)
80001b6c:	fff68693          	addi	a3,a3,-1
            out ^= CRC16;
80001b70:	00b7c633          	xor	a2,a5,a1
        if(bit_flag)
80001b74:	00070663          	beqz	a4,80001b80 <gen_crc16+0xc4>
            out ^= CRC16;
80001b78:	01061793          	slli	a5,a2,0x10
80001b7c:	0107d793          	srli	a5,a5,0x10
    for (i = 0; i < 16; ++i) {
80001b80:	00068863          	beqz	a3,80001b90 <gen_crc16+0xd4>
80001b84:	00f7d713          	srli	a4,a5,0xf
80001b88:	00179793          	slli	a5,a5,0x1
80001b8c:	fd1ff06f          	j	80001b5c <gen_crc16+0xa0>
80001b90:	01000593          	li	a1,16
    }

    // item c) reverse the bits
    uint16_t crc = 0;
    i = 0x8000;
    int j = 0x0001;
80001b94:	00100613          	li	a2,1
    uint16_t crc = 0;
80001b98:	00000513          	li	a0,0
    i = 0x8000;
80001b9c:	000086b7          	lui	a3,0x8
    for (; i != 0; i >>=1, j <<= 1) {
        if (i & out) crc |= j;
80001ba0:	00d7f733          	and	a4,a5,a3
80001ba4:	fff58593          	addi	a1,a1,-1
80001ba8:	00a66833          	or	a6,a2,a0
80001bac:	00070663          	beqz	a4,80001bb8 <gen_crc16+0xfc>
80001bb0:	01081513          	slli	a0,a6,0x10
80001bb4:	01055513          	srli	a0,a0,0x10
    for (; i != 0; i >>=1, j <<= 1) {
80001bb8:	4016d693          	srai	a3,a3,0x1
80001bbc:	00161613          	slli	a2,a2,0x1
80001bc0:	fe0590e3          	bnez	a1,80001ba0 <gen_crc16+0xe4>
80001bc4:	00008067          	ret
        return 0;
80001bc8:	00000513          	li	a0,0
    }

    return crc;
}
80001bcc:	00008067          	ret

80001bd0 <irqCallback>:
        }
    }
}

void irqCallback() {
    uart_printf("successful IRQ callback\n");
80001bd0:	8000e537          	lui	a0,0x8000e
void irqCallback() {
80001bd4:	ff010113          	addi	sp,sp,-16
    uart_printf("successful IRQ callback\n");
80001bd8:	24050513          	addi	a0,a0,576 # 8000e240 <STACK_TOP+0xfffee240>
void irqCallback() {
80001bdc:	00112623          	sw	ra,12(sp)
    uart_printf("successful IRQ callback\n");
80001be0:	059000ef          	jal	ra,80002438 <uart_printf>
    reg_capture_en = 1;
}
80001be4:	00c12083          	lw	ra,12(sp)
    reg_capture_en = 1;
80001be8:	020007b7          	lui	a5,0x2000
80001bec:	00100713          	li	a4,1
80001bf0:	0ae7a023          	sw	a4,160(a5) # 20000a0 <crtStart-0x7dffff60>
}
80001bf4:	01010113          	addi	sp,sp,16
80001bf8:	00008067          	ret

80001bfc <cursor>:
#define FREQ 10800000

int curx, cury;

void cursor(int x, int y) {
   curx = x;
80001bfc:	800117b7          	lui	a5,0x80011
80001c00:	60a7a423          	sw	a0,1544(a5) # 80011608 <STACK_TOP+0xffff1608>
   cury = y;
80001c04:	800117b7          	lui	a5,0x80011
80001c08:	60b7a023          	sw	a1,1536(a5) # 80011600 <STACK_TOP+0xffff1600>
}
80001c0c:	00008067          	ret

80001c10 <overlay>:

int _overlay_status;

void overlay(int on) {
   if (on)
      reg_textdisp = 0x01000000;
80001c10:	020007b7          	lui	a5,0x2000
   if (on)
80001c14:	00050c63          	beqz	a0,80001c2c <overlay+0x1c>
      reg_textdisp = 0x01000000;
80001c18:	01000737          	lui	a4,0x1000
80001c1c:	00e7a023          	sw	a4,0(a5) # 2000000 <crtStart-0x7e000000>
   else
      reg_textdisp = 0x02000000;
   _overlay_status = on;
80001c20:	800117b7          	lui	a5,0x80011
80001c24:	60a7a223          	sw	a0,1540(a5) # 80011604 <STACK_TOP+0xffff1604>
}
80001c28:	00008067          	ret
      reg_textdisp = 0x02000000;
80001c2c:	00f7a023          	sw	a5,0(a5)
   _overlay_status = on;
80001c30:	800117b7          	lui	a5,0x80011
80001c34:	60a7a223          	sw	a0,1540(a5) # 80011604 <STACK_TOP+0xffff1604>
}
80001c38:	00008067          	ret

80001c3c <overlay_status>:

int overlay_status() {
   return _overlay_status;
80001c3c:	800117b7          	lui	a5,0x80011
}
80001c40:	6047a503          	lw	a0,1540(a5) # 80011604 <STACK_TOP+0xffff1604>
80001c44:	00008067          	ret

80001c48 <putchar>:

int putchar(int c)
{
	if (curx >= 0 && curx < 32 && cury >= 0 && cury < 28) {
80001c48:	800117b7          	lui	a5,0x80011
80001c4c:	6087a703          	lw	a4,1544(a5) # 80011608 <STACK_TOP+0xffff1608>
80001c50:	01f00693          	li	a3,31
80001c54:	04e6e263          	bltu	a3,a4,80001c98 <putchar+0x50>
80001c58:	800116b7          	lui	a3,0x80011
80001c5c:	6006a683          	lw	a3,1536(a3) # 80011600 <STACK_TOP+0xffff1600>
80001c60:	01b00613          	li	a2,27
80001c64:	02d66a63          	bltu	a2,a3,80001c98 <putchar+0x50>
      reg_textdisp = (curx << 16) + (cury << 8) + c;
80001c68:	01071613          	slli	a2,a4,0x10
80001c6c:	00869693          	slli	a3,a3,0x8
80001c70:	00d606b3          	add	a3,a2,a3
80001c74:	00a686b3          	add	a3,a3,a0
80001c78:	02000637          	lui	a2,0x2000
80001c7c:	00d62023          	sw	a3,0(a2) # 2000000 <crtStart-0x7e000000>
      if (c >= 32 && c < 128)
80001c80:	fe050693          	addi	a3,a0,-32
80001c84:	05f00613          	li	a2,95
80001c88:	00d66863          	bltu	a2,a3,80001c98 <putchar+0x50>
         curx++;
80001c8c:	00170713          	addi	a4,a4,1 # 1000001 <crtStart-0x7effffff>
80001c90:	60e7a423          	sw	a4,1544(a5)
   }
   // new line
   if (c == '\n') {
80001c94:	00008067          	ret
80001c98:	00a00713          	li	a4,10
80001c9c:	00e50463          	beq	a0,a4,80001ca4 <putchar+0x5c>
      curx = 2;
      cury++;
   }
   return c;
}
80001ca0:	00008067          	ret
      cury++;
80001ca4:	800116b7          	lui	a3,0x80011
80001ca8:	6006a703          	lw	a4,1536(a3) # 80011600 <STACK_TOP+0xffff1600>
      curx = 2;
80001cac:	00200613          	li	a2,2
80001cb0:	60c7a423          	sw	a2,1544(a5)
      cury++;
80001cb4:	00170793          	addi	a5,a4,1
80001cb8:	60f6a023          	sw	a5,1536(a3)
}
80001cbc:	00008067          	ret

80001cc0 <_putchar>:
int uart_putchar(int c);
int _putchar(int c, int uart) {
80001cc0:	ff010113          	addi	sp,sp,-16
80001cc4:	00812423          	sw	s0,8(sp)
80001cc8:	00112623          	sw	ra,12(sp)
80001ccc:	00050413          	mv	s0,a0
   if (uart)
80001cd0:	02058063          	beqz	a1,80001cf0 <_putchar+0x30>
void uart_init(int clkdiv) {
   reg_uart_clkdiv = clkdiv;
}

int uart_putchar(int c) {
   reg_uart_data = c;
80001cd4:	020007b7          	lui	a5,0x2000
80001cd8:	00a7aa23          	sw	a0,20(a5) # 2000014 <crtStart-0x7dffffec>
}
80001cdc:	00c12083          	lw	ra,12(sp)
80001ce0:	00040513          	mv	a0,s0
80001ce4:	00812403          	lw	s0,8(sp)
80001ce8:	01010113          	addi	sp,sp,16
80001cec:	00008067          	ret
      putchar(c);
80001cf0:	f59ff0ef          	jal	ra,80001c48 <putchar>
}
80001cf4:	00040513          	mv	a0,s0
80001cf8:	00c12083          	lw	ra,12(sp)
80001cfc:	00812403          	lw	s0,8(sp)
80001d00:	01010113          	addi	sp,sp,16
80001d04:	00008067          	ret

80001d08 <print>:
{
80001d08:	ff010113          	addi	sp,sp,-16
80001d0c:	00812423          	sw	s0,8(sp)
80001d10:	00112623          	sw	ra,12(sp)
80001d14:	00050413          	mv	s0,a0
	while (*p)
80001d18:	00054503          	lbu	a0,0(a0)
80001d1c:	00050a63          	beqz	a0,80001d30 <print+0x28>
		putchar(*(p++));
80001d20:	00140413          	addi	s0,s0,1
80001d24:	f25ff0ef          	jal	ra,80001c48 <putchar>
	while (*p)
80001d28:	00044503          	lbu	a0,0(s0)
80001d2c:	fe051ae3          	bnez	a0,80001d20 <print+0x18>
}
80001d30:	00c12083          	lw	ra,12(sp)
80001d34:	00812403          	lw	s0,8(sp)
80001d38:	00000513          	li	a0,0
80001d3c:	01010113          	addi	sp,sp,16
80001d40:	00008067          	ret

80001d44 <_print>:
int _print(const char *p, int uart) {
80001d44:	ff010113          	addi	sp,sp,-16
80001d48:	00812423          	sw	s0,8(sp)
80001d4c:	00112623          	sw	ra,12(sp)
80001d50:	00050413          	mv	s0,a0
80001d54:	00054503          	lbu	a0,0(a0)
   if (uart)
80001d58:	02058863          	beqz	a1,80001d88 <_print+0x44>
   return c;
}

int uart_print(const char *s) {
	while (*s)
80001d5c:	00050c63          	beqz	a0,80001d74 <_print+0x30>
   reg_uart_data = c;
80001d60:	020007b7          	lui	a5,0x2000
		_putchar(*(s++), 1);   
80001d64:	00140413          	addi	s0,s0,1
   reg_uart_data = c;
80001d68:	00a7aa23          	sw	a0,20(a5) # 2000014 <crtStart-0x7dffffec>
	while (*s)
80001d6c:	00044503          	lbu	a0,0(s0)
80001d70:	fe051ae3          	bnez	a0,80001d64 <_print+0x20>
}
80001d74:	00c12083          	lw	ra,12(sp)
80001d78:	00812403          	lw	s0,8(sp)
80001d7c:	00000513          	li	a0,0
80001d80:	01010113          	addi	sp,sp,16
80001d84:	00008067          	ret
	while (*p)
80001d88:	fe0506e3          	beqz	a0,80001d74 <_print+0x30>
		putchar(*(p++));
80001d8c:	00140413          	addi	s0,s0,1
80001d90:	eb9ff0ef          	jal	ra,80001c48 <putchar>
	while (*p)
80001d94:	00044503          	lbu	a0,0(s0)
80001d98:	ff1ff06f          	j	80001d88 <_print+0x44>

80001d9c <_print_hex_digits>:
void _print_hex_digits(uint32_t val, int nbdigits, int uart) {
80001d9c:	fe010113          	addi	sp,sp,-32
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
80001da0:	fff58593          	addi	a1,a1,-1
void _print_hex_digits(uint32_t val, int nbdigits, int uart) {
80001da4:	00812c23          	sw	s0,24(sp)
80001da8:	00112e23          	sw	ra,28(sp)
80001dac:	00912a23          	sw	s1,20(sp)
80001db0:	01212823          	sw	s2,16(sp)
80001db4:	01312623          	sw	s3,12(sp)
80001db8:	01412423          	sw	s4,8(sp)
80001dbc:	01512223          	sw	s5,4(sp)
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
80001dc0:	00259413          	slli	s0,a1,0x2
80001dc4:	04044663          	bltz	s0,80001e10 <_print_hex_digits+0x74>
80001dc8:	8000e9b7          	lui	s3,0x8000e
80001dcc:	00060913          	mv	s2,a2
80001dd0:	00050493          	mv	s1,a0
80001dd4:	ffc00a13          	li	s4,-4
80001dd8:	25c98993          	addi	s3,s3,604 # 8000e25c <STACK_TOP+0xfffee25c>
   reg_uart_data = c;
80001ddc:	02000ab7          	lui	s5,0x2000
80001de0:	0100006f          	j	80001df0 <_print_hex_digits+0x54>
80001de4:	00aaaa23          	sw	a0,20(s5) # 2000014 <crtStart-0x7dffffec>
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
80001de8:	ffc40413          	addi	s0,s0,-4
80001dec:	03440263          	beq	s0,s4,80001e10 <_print_hex_digits+0x74>
      _putchar("0123456789ABCDEF"[(val >> i) % 16], uart);
80001df0:	0084d7b3          	srl	a5,s1,s0
80001df4:	00f7f793          	andi	a5,a5,15
80001df8:	00f987b3          	add	a5,s3,a5
80001dfc:	0007c503          	lbu	a0,0(a5)
   if (uart)
80001e00:	fe0912e3          	bnez	s2,80001de4 <_print_hex_digits+0x48>
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
80001e04:	ffc40413          	addi	s0,s0,-4
      putchar(c);
80001e08:	e41ff0ef          	jal	ra,80001c48 <putchar>
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
80001e0c:	ff4412e3          	bne	s0,s4,80001df0 <_print_hex_digits+0x54>
}
80001e10:	01c12083          	lw	ra,28(sp)
80001e14:	01812403          	lw	s0,24(sp)
80001e18:	01412483          	lw	s1,20(sp)
80001e1c:	01012903          	lw	s2,16(sp)
80001e20:	00c12983          	lw	s3,12(sp)
80001e24:	00812a03          	lw	s4,8(sp)
80001e28:	00412a83          	lw	s5,4(sp)
80001e2c:	02010113          	addi	sp,sp,32
80001e30:	00008067          	ret

80001e34 <print_hex_digits>:
void print_hex_digits(uint32_t val, int nbdigits) {
80001e34:	fe010113          	addi	sp,sp,-32
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
80001e38:	fff58593          	addi	a1,a1,-1
void print_hex_digits(uint32_t val, int nbdigits) {
80001e3c:	00812c23          	sw	s0,24(sp)
80001e40:	00112e23          	sw	ra,28(sp)
80001e44:	00912a23          	sw	s1,20(sp)
80001e48:	01212823          	sw	s2,16(sp)
80001e4c:	01312623          	sw	s3,12(sp)
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
80001e50:	00259413          	slli	s0,a1,0x2
80001e54:	02044863          	bltz	s0,80001e84 <print_hex_digits+0x50>
80001e58:	8000e937          	lui	s2,0x8000e
80001e5c:	00050493          	mv	s1,a0
80001e60:	ffc00993          	li	s3,-4
80001e64:	25c90913          	addi	s2,s2,604 # 8000e25c <STACK_TOP+0xfffee25c>
      _putchar("0123456789ABCDEF"[(val >> i) % 16], uart);
80001e68:	0084d7b3          	srl	a5,s1,s0
80001e6c:	00f7f793          	andi	a5,a5,15
80001e70:	00f907b3          	add	a5,s2,a5
      putchar(c);
80001e74:	0007c503          	lbu	a0,0(a5)
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
80001e78:	ffc40413          	addi	s0,s0,-4
      putchar(c);
80001e7c:	dcdff0ef          	jal	ra,80001c48 <putchar>
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
80001e80:	ff3414e3          	bne	s0,s3,80001e68 <print_hex_digits+0x34>
}
80001e84:	01c12083          	lw	ra,28(sp)
80001e88:	01812403          	lw	s0,24(sp)
80001e8c:	01412483          	lw	s1,20(sp)
80001e90:	01012903          	lw	s2,16(sp)
80001e94:	00c12983          	lw	s3,12(sp)
80001e98:	02010113          	addi	sp,sp,32
80001e9c:	00008067          	ret

80001ea0 <uart_print_hex_digits>:
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
80001ea0:	fff58593          	addi	a1,a1,-1
80001ea4:	00259593          	slli	a1,a1,0x2
80001ea8:	0205c863          	bltz	a1,80001ed8 <uart_print_hex_digits+0x38>
80001eac:	8000e737          	lui	a4,0x8000e
80001eb0:	ffc00613          	li	a2,-4
80001eb4:	25c70713          	addi	a4,a4,604 # 8000e25c <STACK_TOP+0xfffee25c>
   reg_uart_data = c;
80001eb8:	020006b7          	lui	a3,0x2000
      _putchar("0123456789ABCDEF"[(val >> i) % 16], uart);
80001ebc:	00b557b3          	srl	a5,a0,a1
80001ec0:	00f7f793          	andi	a5,a5,15
80001ec4:	00f707b3          	add	a5,a4,a5
   reg_uart_data = c;
80001ec8:	0007c783          	lbu	a5,0(a5)
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
80001ecc:	ffc58593          	addi	a1,a1,-4
   reg_uart_data = c;
80001ed0:	00f6aa23          	sw	a5,20(a3) # 2000014 <crtStart-0x7dffffec>
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
80001ed4:	fec594e3          	bne	a1,a2,80001ebc <uart_print_hex_digits+0x1c>
}
80001ed8:	00008067          	ret

80001edc <_print_hex>:
void _print_hex(uint32_t val, int uart) {
80001edc:	fe010113          	addi	sp,sp,-32
80001ee0:	00912a23          	sw	s1,20(sp)
80001ee4:	8000e4b7          	lui	s1,0x8000e
80001ee8:	00812c23          	sw	s0,24(sp)
80001eec:	01212823          	sw	s2,16(sp)
80001ef0:	01312623          	sw	s3,12(sp)
80001ef4:	01412423          	sw	s4,8(sp)
80001ef8:	01512223          	sw	s5,4(sp)
80001efc:	00112e23          	sw	ra,28(sp)
80001f00:	00050a13          	mv	s4,a0
80001f04:	00058993          	mv	s3,a1
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
80001f08:	01c00413          	li	s0,28
80001f0c:	25c48493          	addi	s1,s1,604 # 8000e25c <STACK_TOP+0xfffee25c>
   reg_uart_data = c;
80001f10:	02000ab7          	lui	s5,0x2000
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
80001f14:	ffc00913          	li	s2,-4
80001f18:	0100006f          	j	80001f28 <_print_hex+0x4c>
   reg_uart_data = c;
80001f1c:	00aaaa23          	sw	a0,20(s5) # 2000014 <crtStart-0x7dffffec>
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
80001f20:	ffc40413          	addi	s0,s0,-4
80001f24:	03240263          	beq	s0,s2,80001f48 <_print_hex+0x6c>
      _putchar("0123456789ABCDEF"[(val >> i) % 16], uart);
80001f28:	008a57b3          	srl	a5,s4,s0
80001f2c:	00f7f793          	andi	a5,a5,15
80001f30:	00f487b3          	add	a5,s1,a5
80001f34:	0007c503          	lbu	a0,0(a5)
   if (uart)
80001f38:	fe0992e3          	bnez	s3,80001f1c <_print_hex+0x40>
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
80001f3c:	ffc40413          	addi	s0,s0,-4
      putchar(c);
80001f40:	d09ff0ef          	jal	ra,80001c48 <putchar>
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
80001f44:	ff2412e3          	bne	s0,s2,80001f28 <_print_hex+0x4c>
}
80001f48:	01c12083          	lw	ra,28(sp)
80001f4c:	01812403          	lw	s0,24(sp)
80001f50:	01412483          	lw	s1,20(sp)
80001f54:	01012903          	lw	s2,16(sp)
80001f58:	00c12983          	lw	s3,12(sp)
80001f5c:	00812a03          	lw	s4,8(sp)
80001f60:	00412a83          	lw	s5,4(sp)
80001f64:	02010113          	addi	sp,sp,32
80001f68:	00008067          	ret

80001f6c <print_hex>:
void print_hex(uint32_t val) {
80001f6c:	fe010113          	addi	sp,sp,-32
80001f70:	00912a23          	sw	s1,20(sp)
80001f74:	8000e4b7          	lui	s1,0x8000e
80001f78:	00812c23          	sw	s0,24(sp)
80001f7c:	01212823          	sw	s2,16(sp)
80001f80:	01312623          	sw	s3,12(sp)
80001f84:	00112e23          	sw	ra,28(sp)
80001f88:	00050993          	mv	s3,a0
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
80001f8c:	01c00413          	li	s0,28
80001f90:	25c48493          	addi	s1,s1,604 # 8000e25c <STACK_TOP+0xfffee25c>
80001f94:	ffc00913          	li	s2,-4
      _putchar("0123456789ABCDEF"[(val >> i) % 16], uart);
80001f98:	0089d7b3          	srl	a5,s3,s0
80001f9c:	00f7f793          	andi	a5,a5,15
80001fa0:	00f487b3          	add	a5,s1,a5
      putchar(c);
80001fa4:	0007c503          	lbu	a0,0(a5)
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
80001fa8:	ffc40413          	addi	s0,s0,-4
      putchar(c);
80001fac:	c9dff0ef          	jal	ra,80001c48 <putchar>
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
80001fb0:	ff2414e3          	bne	s0,s2,80001f98 <print_hex+0x2c>
}
80001fb4:	01c12083          	lw	ra,28(sp)
80001fb8:	01812403          	lw	s0,24(sp)
80001fbc:	01412483          	lw	s1,20(sp)
80001fc0:	01012903          	lw	s2,16(sp)
80001fc4:	00c12983          	lw	s3,12(sp)
80001fc8:	02010113          	addi	sp,sp,32
80001fcc:	00008067          	ret

80001fd0 <uart_print_hex>:
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
80001fd0:	8000e6b7          	lui	a3,0x8000e
80001fd4:	01c00713          	li	a4,28
80001fd8:	25c68693          	addi	a3,a3,604 # 8000e25c <STACK_TOP+0xfffee25c>
   reg_uart_data = c;
80001fdc:	020005b7          	lui	a1,0x2000
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
80001fe0:	ffc00613          	li	a2,-4
      _putchar("0123456789ABCDEF"[(val >> i) % 16], uart);
80001fe4:	00e557b3          	srl	a5,a0,a4
80001fe8:	00f7f793          	andi	a5,a5,15
80001fec:	00f687b3          	add	a5,a3,a5
   reg_uart_data = c;
80001ff0:	0007c783          	lbu	a5,0(a5)
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
80001ff4:	ffc70713          	addi	a4,a4,-4
   reg_uart_data = c;
80001ff8:	00f5aa23          	sw	a5,20(a1) # 2000014 <crtStart-0x7dffffec>
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
80001ffc:	fec714e3          	bne	a4,a2,80001fe4 <uart_print_hex+0x14>
}
80002000:	00008067          	ret

80002004 <_print_dec>:
void _print_dec(int val, int uart) {
80002004:	ee010113          	addi	sp,sp,-288
80002008:	10912a23          	sw	s1,276(sp)
8000200c:	11312623          	sw	s3,268(sp)
80002010:	10112e23          	sw	ra,284(sp)
80002014:	10812c23          	sw	s0,280(sp)
80002018:	11212823          	sw	s2,272(sp)
8000201c:	00050493          	mv	s1,a0
80002020:	00058993          	mv	s3,a1
   if(val < 0) {
80002024:	00055c63          	bgez	a0,8000203c <_print_dec+0x38>
   if (uart)
80002028:	08058263          	beqz	a1,800020ac <_print_dec+0xa8>
   reg_uart_data = c;
8000202c:	020007b7          	lui	a5,0x2000
80002030:	02d00713          	li	a4,45
80002034:	00e7aa23          	sw	a4,20(a5) # 2000014 <crtStart-0x7dffffec>
      _print_dec(-val, uart);
80002038:	409004b3          	neg	s1,s1
   char *p = buffer;
8000203c:	00010913          	mv	s2,sp
80002040:	00090413          	mv	s0,s2
80002044:	0200006f          	j	80002064 <_print_dec+0x60>
      *(p++) = val % 10;
80002048:	2050b0ef          	jal	ra,8000da4c <__modsi3>
8000204c:	00140413          	addi	s0,s0,1
80002050:	fea40fa3          	sb	a0,-1(s0)
      val = val / 10;
80002054:	00a00593          	li	a1,10
80002058:	00048513          	mv	a0,s1
8000205c:	16d0b0ef          	jal	ra,8000d9c8 <__divsi3>
80002060:	00050493          	mv	s1,a0
      *(p++) = val % 10;
80002064:	00a00593          	li	a1,10
80002068:	00048513          	mv	a0,s1
   while (val || p == buffer) {
8000206c:	fc049ee3          	bnez	s1,80002048 <_print_dec+0x44>
80002070:	fd240ce3          	beq	s0,s2,80002048 <_print_dec+0x44>
   reg_uart_data = c;
80002074:	020004b7          	lui	s1,0x2000
      _putchar('0' + *(--p), uart);
80002078:	fff40413          	addi	s0,s0,-1
8000207c:	00044503          	lbu	a0,0(s0)
80002080:	03050513          	addi	a0,a0,48
   if (uart)
80002084:	02098a63          	beqz	s3,800020b8 <_print_dec+0xb4>
   reg_uart_data = c;
80002088:	00a4aa23          	sw	a0,20(s1) # 2000014 <crtStart-0x7dffffec>
   while (p != buffer) {
8000208c:	ff2416e3          	bne	s0,s2,80002078 <_print_dec+0x74>
}
80002090:	11c12083          	lw	ra,284(sp)
80002094:	11812403          	lw	s0,280(sp)
80002098:	11412483          	lw	s1,276(sp)
8000209c:	11012903          	lw	s2,272(sp)
800020a0:	10c12983          	lw	s3,268(sp)
800020a4:	12010113          	addi	sp,sp,288
800020a8:	00008067          	ret
      putchar(c);
800020ac:	02d00513          	li	a0,45
800020b0:	b99ff0ef          	jal	ra,80001c48 <putchar>
800020b4:	f85ff06f          	j	80002038 <_print_dec+0x34>
800020b8:	b91ff0ef          	jal	ra,80001c48 <putchar>
   while (p != buffer) {
800020bc:	fb241ee3          	bne	s0,s2,80002078 <_print_dec+0x74>
800020c0:	fd1ff06f          	j	80002090 <_print_dec+0x8c>

800020c4 <print_dec>:
   _print_dec(val, 0);
800020c4:	00000593          	li	a1,0
800020c8:	f3dff06f          	j	80002004 <_print_dec>

800020cc <uart_print_dec>:
   _print_dec(val, 1);
800020cc:	00100593          	li	a1,1
800020d0:	f35ff06f          	j	80002004 <_print_dec>

800020d4 <_printf>:
int _printf(const char *fmt, va_list ap, int uart) {
800020d4:	fb010113          	addi	sp,sp,-80
800020d8:	04812423          	sw	s0,72(sp)
800020dc:	04112623          	sw	ra,76(sp)
800020e0:	04912223          	sw	s1,68(sp)
800020e4:	05212023          	sw	s2,64(sp)
800020e8:	03312e23          	sw	s3,60(sp)
800020ec:	03412c23          	sw	s4,56(sp)
800020f0:	03512a23          	sw	s5,52(sp)
800020f4:	03612823          	sw	s6,48(sp)
800020f8:	03712623          	sw	s7,44(sp)
800020fc:	03812423          	sw	s8,40(sp)
80002100:	03912223          	sw	s9,36(sp)
80002104:	03a12023          	sw	s10,32(sp)
80002108:	01b12e23          	sw	s11,28(sp)
8000210c:	00050413          	mv	s0,a0
    for(;*fmt;fmt++) {
80002110:	00054503          	lbu	a0,0(a0)
80002114:	08050663          	beqz	a0,800021a0 <_printf+0xcc>
80002118:	8000eb37          	lui	s6,0x8000e
8000211c:	00058913          	mv	s2,a1
80002120:	00060993          	mv	s3,a2
        if(*fmt=='%') {
80002124:	02500a93          	li	s5,37
   reg_uart_data = c;
80002128:	02000a37          	lui	s4,0x2000
                 if(*fmt=='s') _print(va_arg(ap,char *), uart);
8000212c:	07300b93          	li	s7,115
            else if(*fmt=='x') _print_hex(va_arg(ap,int), uart);
80002130:	07800c13          	li	s8,120
            else if(*fmt=='d') _print_dec(va_arg(ap,int), uart);
80002134:	06400c93          	li	s9,100
80002138:	25cb0b13          	addi	s6,s6,604 # 8000e25c <STACK_TOP+0xfffee25c>
8000213c:	0200006f          	j	8000215c <_printf+0x88>
   if (uart)
80002140:	0a098063          	beqz	s3,800021e0 <_printf+0x10c>
   reg_uart_data = c;
80002144:	00048793          	mv	a5,s1
80002148:	00aa2a23          	sw	a0,20(s4) # 2000014 <crtStart-0x7dffffec>
8000214c:	00040493          	mv	s1,s0
80002150:	00078413          	mv	s0,a5
    for(;*fmt;fmt++) {
80002154:	0014c503          	lbu	a0,1(s1)
80002158:	04050463          	beqz	a0,800021a0 <_printf+0xcc>
        if(*fmt=='%') {
8000215c:	00140493          	addi	s1,s0,1
80002160:	ff5510e3          	bne	a0,s5,80002140 <_printf+0x6c>
                 if(*fmt=='s') _print(va_arg(ap,char *), uart);
80002164:	00144503          	lbu	a0,1(s0)
80002168:	00240413          	addi	s0,s0,2
8000216c:	09750463          	beq	a0,s7,800021f4 <_printf+0x120>
            else if(*fmt=='x') _print_hex(va_arg(ap,int), uart);
80002170:	0f850a63          	beq	a0,s8,80002264 <_printf+0x190>
            else if(*fmt=='d') _print_dec(va_arg(ap,int), uart);
80002174:	0d950e63          	beq	a0,s9,80002250 <_printf+0x17c>
            else if(*fmt=='c') _putchar(va_arg(ap,int), uart);	   
80002178:	06300793          	li	a5,99
8000217c:	0af50e63          	beq	a0,a5,80002238 <_printf+0x164>
            else if(*fmt=='b') _print_hex_digits(va_arg(ap,int), 2, uart);	      // byte
80002180:	06200793          	li	a5,98
80002184:	12f50c63          	beq	a0,a5,800022bc <_printf+0x1e8>
            else if(*fmt=='w') _print_hex_digits(va_arg(ap,int), 4, uart);	      // 16-bit word
80002188:	07700793          	li	a5,119
8000218c:	16f50263          	beq	a0,a5,800022f0 <_printf+0x21c>
   if (uart)
80002190:	10098c63          	beqz	s3,800022a8 <_printf+0x1d4>
   reg_uart_data = c;
80002194:	00aa2a23          	sw	a0,20(s4)
    for(;*fmt;fmt++) {
80002198:	0014c503          	lbu	a0,1(s1)
8000219c:	fc0510e3          	bnez	a0,8000215c <_printf+0x88>
}
800021a0:	04c12083          	lw	ra,76(sp)
800021a4:	04812403          	lw	s0,72(sp)
800021a8:	04412483          	lw	s1,68(sp)
800021ac:	04012903          	lw	s2,64(sp)
800021b0:	03c12983          	lw	s3,60(sp)
800021b4:	03812a03          	lw	s4,56(sp)
800021b8:	03412a83          	lw	s5,52(sp)
800021bc:	03012b03          	lw	s6,48(sp)
800021c0:	02c12b83          	lw	s7,44(sp)
800021c4:	02812c03          	lw	s8,40(sp)
800021c8:	02412c83          	lw	s9,36(sp)
800021cc:	02012d03          	lw	s10,32(sp)
800021d0:	01c12d83          	lw	s11,28(sp)
800021d4:	00000513          	li	a0,0
800021d8:	05010113          	addi	sp,sp,80
800021dc:	00008067          	ret
      putchar(c);
800021e0:	a69ff0ef          	jal	ra,80001c48 <putchar>
800021e4:	00048793          	mv	a5,s1
800021e8:	00040493          	mv	s1,s0
800021ec:	00078413          	mv	s0,a5
800021f0:	f65ff06f          	j	80002154 <_printf+0x80>
                 if(*fmt=='s') _print(va_arg(ap,char *), uart);
800021f4:	00490d13          	addi	s10,s2,4
800021f8:	00092903          	lw	s2,0(s2)
   if (uart)
800021fc:	02098663          	beqz	s3,80002228 <_printf+0x154>
	while (*s)
80002200:	00094783          	lbu	a5,0(s2)
80002204:	00078a63          	beqz	a5,80002218 <_printf+0x144>
		_putchar(*(s++), 1);   
80002208:	00190913          	addi	s2,s2,1
   reg_uart_data = c;
8000220c:	00fa2a23          	sw	a5,20(s4)
	while (*s)
80002210:	00094783          	lbu	a5,0(s2)
80002214:	fe079ae3          	bnez	a5,80002208 <_printf+0x134>
                 if(*fmt=='s') _print(va_arg(ap,char *), uart);
80002218:	000d0913          	mv	s2,s10
8000221c:	f39ff06f          	j	80002154 <_printf+0x80>
		putchar(*(p++));
80002220:	00190913          	addi	s2,s2,1
80002224:	a25ff0ef          	jal	ra,80001c48 <putchar>
	while (*p)
80002228:	00094503          	lbu	a0,0(s2)
8000222c:	fe051ae3          	bnez	a0,80002220 <_printf+0x14c>
                 if(*fmt=='s') _print(va_arg(ap,char *), uart);
80002230:	000d0913          	mv	s2,s10
80002234:	f21ff06f          	j	80002154 <_printf+0x80>
            else if(*fmt=='c') _putchar(va_arg(ap,int), uart);	   
80002238:	00490d13          	addi	s10,s2,4
8000223c:	00092503          	lw	a0,0(s2)
   if (uart)
80002240:	06098863          	beqz	s3,800022b0 <_printf+0x1dc>
   reg_uart_data = c;
80002244:	00aa2a23          	sw	a0,20(s4)
            else if(*fmt=='c') _putchar(va_arg(ap,int), uart);	   
80002248:	000d0913          	mv	s2,s10
8000224c:	f09ff06f          	j	80002154 <_printf+0x80>
            else if(*fmt=='d') _print_dec(va_arg(ap,int), uart);
80002250:	00092503          	lw	a0,0(s2)
80002254:	00098593          	mv	a1,s3
80002258:	00490913          	addi	s2,s2,4
8000225c:	da9ff0ef          	jal	ra,80002004 <_print_dec>
80002260:	ef5ff06f          	j	80002154 <_printf+0x80>
            else if(*fmt=='x') _print_hex(va_arg(ap,int), uart);
80002264:	00092703          	lw	a4,0(s2)
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
80002268:	01c00d13          	li	s10,28
            else if(*fmt=='x') _print_hex(va_arg(ap,int), uart);
8000226c:	00490913          	addi	s2,s2,4
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
80002270:	ffc00d93          	li	s11,-4
80002274:	0100006f          	j	80002284 <_printf+0x1b0>
   reg_uart_data = c;
80002278:	00aa2a23          	sw	a0,20(s4)
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
8000227c:	ffcd0d13          	addi	s10,s10,-4
80002280:	edbd0ae3          	beq	s10,s11,80002154 <_printf+0x80>
      _putchar("0123456789ABCDEF"[(val >> i) % 16], uart);
80002284:	01a757b3          	srl	a5,a4,s10
80002288:	00f7f793          	andi	a5,a5,15
8000228c:	00fb07b3          	add	a5,s6,a5
80002290:	0007c503          	lbu	a0,0(a5)
   if (uart)
80002294:	fe0992e3          	bnez	s3,80002278 <_printf+0x1a4>
80002298:	00e12623          	sw	a4,12(sp)
      putchar(c);
8000229c:	9adff0ef          	jal	ra,80001c48 <putchar>
800022a0:	00c12703          	lw	a4,12(sp)
800022a4:	fd9ff06f          	j	8000227c <_printf+0x1a8>
800022a8:	9a1ff0ef          	jal	ra,80001c48 <putchar>
800022ac:	ea9ff06f          	j	80002154 <_printf+0x80>
800022b0:	999ff0ef          	jal	ra,80001c48 <putchar>
            else if(*fmt=='c') _putchar(va_arg(ap,int), uart);	   
800022b4:	000d0913          	mv	s2,s10
800022b8:	e9dff06f          	j	80002154 <_printf+0x80>
            else if(*fmt=='b') _print_hex_digits(va_arg(ap,int), 2, uart);	      // byte
800022bc:	00092783          	lw	a5,0(s2)
800022c0:	00490913          	addi	s2,s2,4
      _putchar("0123456789ABCDEF"[(val >> i) % 16], uart);
800022c4:	0047d713          	srli	a4,a5,0x4
800022c8:	00f77713          	andi	a4,a4,15
800022cc:	00f7f793          	andi	a5,a5,15
800022d0:	00eb0733          	add	a4,s6,a4
800022d4:	00fb07b3          	add	a5,s6,a5
800022d8:	00074503          	lbu	a0,0(a4)
   if (uart)
800022dc:	0007cd03          	lbu	s10,0(a5)
800022e0:	04098a63          	beqz	s3,80002334 <_printf+0x260>
   reg_uart_data = c;
800022e4:	00aa2a23          	sw	a0,20(s4)
800022e8:	01aa2a23          	sw	s10,20(s4)
   return c;
800022ec:	e69ff06f          	j	80002154 <_printf+0x80>
            else if(*fmt=='w') _print_hex_digits(va_arg(ap,int), 4, uart);	      // 16-bit word
800022f0:	00092703          	lw	a4,0(s2)
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
800022f4:	00c00d13          	li	s10,12
            else if(*fmt=='w') _print_hex_digits(va_arg(ap,int), 4, uart);	      // 16-bit word
800022f8:	00490913          	addi	s2,s2,4
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
800022fc:	ffc00d93          	li	s11,-4
80002300:	0100006f          	j	80002310 <_printf+0x23c>
   reg_uart_data = c;
80002304:	00aa2a23          	sw	a0,20(s4)
   for (int i = (4*nbdigits)-4; i >= 0; i -= 4) {
80002308:	ffcd0d13          	addi	s10,s10,-4
8000230c:	e5bd04e3          	beq	s10,s11,80002154 <_printf+0x80>
      _putchar("0123456789ABCDEF"[(val >> i) % 16], uart);
80002310:	01a757b3          	srl	a5,a4,s10
80002314:	00f7f793          	andi	a5,a5,15
80002318:	00fb07b3          	add	a5,s6,a5
8000231c:	0007c503          	lbu	a0,0(a5)
   if (uart)
80002320:	fe0992e3          	bnez	s3,80002304 <_printf+0x230>
80002324:	00e12623          	sw	a4,12(sp)
      putchar(c);
80002328:	921ff0ef          	jal	ra,80001c48 <putchar>
8000232c:	00c12703          	lw	a4,12(sp)
80002330:	fd9ff06f          	j	80002308 <_printf+0x234>
80002334:	915ff0ef          	jal	ra,80001c48 <putchar>
80002338:	000d0513          	mv	a0,s10
8000233c:	90dff0ef          	jal	ra,80001c48 <putchar>
80002340:	e15ff06f          	j	80002154 <_printf+0x80>

80002344 <printf>:
{
80002344:	fc010113          	addi	sp,sp,-64
   va_start(ap, fmt);
80002348:	02410313          	addi	t1,sp,36
{
8000234c:	02b12223          	sw	a1,36(sp)
80002350:	02c12423          	sw	a2,40(sp)
   _printf(fmt, ap, 0);
80002354:	00030593          	mv	a1,t1
80002358:	00000613          	li	a2,0
{
8000235c:	00112e23          	sw	ra,28(sp)
80002360:	02d12623          	sw	a3,44(sp)
80002364:	02e12823          	sw	a4,48(sp)
80002368:	02f12a23          	sw	a5,52(sp)
8000236c:	03012c23          	sw	a6,56(sp)
80002370:	03112e23          	sw	a7,60(sp)
   va_start(ap, fmt);
80002374:	00612623          	sw	t1,12(sp)
   _printf(fmt, ap, 0);
80002378:	d5dff0ef          	jal	ra,800020d4 <_printf>
}
8000237c:	01c12083          	lw	ra,28(sp)
80002380:	00000513          	li	a0,0
80002384:	04010113          	addi	sp,sp,64
80002388:	00008067          	ret

8000238c <clear>:
void clear() {
8000238c:	fe010113          	addi	sp,sp,-32
80002390:	00912a23          	sw	s1,20(sp)
80002394:	01212823          	sw	s2,16(sp)
80002398:	01312623          	sw	s3,12(sp)
8000239c:	01412423          	sw	s4,8(sp)
800023a0:	00112e23          	sw	ra,28(sp)
800023a4:	00812c23          	sw	s0,24(sp)
   for (int i = 0; i < 28; i++) {
800023a8:	00000493          	li	s1,0
800023ac:	80011a37          	lui	s4,0x80011
800023b0:	800119b7          	lui	s3,0x80011
800023b4:	01c00913          	li	s2,28
   curx = x;
800023b8:	600a2423          	sw	zero,1544(s4) # 80011608 <STACK_TOP+0xffff1608>
   cury = y;
800023bc:	6099a023          	sw	s1,1536(s3) # 80011600 <STACK_TOP+0xffff1600>
800023c0:	02000413          	li	s0,32
         putchar(' ');
800023c4:	fff40413          	addi	s0,s0,-1
800023c8:	02000513          	li	a0,32
800023cc:	87dff0ef          	jal	ra,80001c48 <putchar>
      for (int j = 0; j < 32; j++)
800023d0:	fe041ae3          	bnez	s0,800023c4 <clear+0x38>
   for (int i = 0; i < 28; i++) {
800023d4:	00148493          	addi	s1,s1,1
800023d8:	ff2490e3          	bne	s1,s2,800023b8 <clear+0x2c>
}
800023dc:	01c12083          	lw	ra,28(sp)
800023e0:	01812403          	lw	s0,24(sp)
800023e4:	01412483          	lw	s1,20(sp)
800023e8:	01012903          	lw	s2,16(sp)
800023ec:	00c12983          	lw	s3,12(sp)
800023f0:	00812a03          	lw	s4,8(sp)
800023f4:	02010113          	addi	sp,sp,32
800023f8:	00008067          	ret

800023fc <uart_init>:
   reg_uart_clkdiv = clkdiv;
800023fc:	020007b7          	lui	a5,0x2000
80002400:	00a7a823          	sw	a0,16(a5) # 2000010 <crtStart-0x7dfffff0>
}
80002404:	00008067          	ret

80002408 <uart_putchar>:
   reg_uart_data = c;
80002408:	020007b7          	lui	a5,0x2000
8000240c:	00a7aa23          	sw	a0,20(a5) # 2000014 <crtStart-0x7dffffec>
}
80002410:	00008067          	ret

80002414 <uart_print>:
	while (*s)
80002414:	00054783          	lbu	a5,0(a0)
80002418:	00078c63          	beqz	a5,80002430 <uart_print+0x1c>
   reg_uart_data = c;
8000241c:	02000737          	lui	a4,0x2000
		_putchar(*(s++), 1);   
80002420:	00150513          	addi	a0,a0,1
   reg_uart_data = c;
80002424:	00f72a23          	sw	a5,20(a4) # 2000014 <crtStart-0x7dffffec>
	while (*s)
80002428:	00054783          	lbu	a5,0(a0)
8000242c:	fe079ae3          	bnez	a5,80002420 <uart_print+0xc>
   return 0;
}
80002430:	00000513          	li	a0,0
80002434:	00008067          	ret

80002438 <uart_printf>:

int uart_printf(const char *fmt,...) {
80002438:	fc010113          	addi	sp,sp,-64
   va_list ap;
   va_start(ap, fmt);
8000243c:	02410313          	addi	t1,sp,36
int uart_printf(const char *fmt,...) {
80002440:	02b12223          	sw	a1,36(sp)
80002444:	02c12423          	sw	a2,40(sp)
   _printf(fmt, ap, 1);
80002448:	00030593          	mv	a1,t1
8000244c:	00100613          	li	a2,1
int uart_printf(const char *fmt,...) {
80002450:	00112e23          	sw	ra,28(sp)
80002454:	02d12623          	sw	a3,44(sp)
80002458:	02e12823          	sw	a4,48(sp)
8000245c:	02f12a23          	sw	a5,52(sp)
80002460:	03012c23          	sw	a6,56(sp)
80002464:	03112e23          	sw	a7,60(sp)
   va_start(ap, fmt);
80002468:	00612623          	sw	t1,12(sp)
   _printf(fmt, ap, 1);
8000246c:	c69ff0ef          	jal	ra,800020d4 <_printf>
   va_end(ap);
   return 0;   
}
80002470:	01c12083          	lw	ra,28(sp)
80002474:	00000513          	li	a0,0
80002478:	04010113          	addi	sp,sp,64
8000247c:	00008067          	ret

80002480 <delay>:
80002480:	020007b7          	lui	a5,0x2000
80002484:	0507a683          	lw	a3,80(a5) # 2000050 <crtStart-0x7dffffb0>
80002488:	02000737          	lui	a4,0x2000
8000248c:	05072783          	lw	a5,80(a4) # 2000050 <crtStart-0x7dffffb0>
//    }
// }

void delay(int ms) {
   int t0 = time_millis();
   while (time_millis() - t0 < ms) {}
80002490:	40d787b3          	sub	a5,a5,a3
80002494:	fea7ece3          	bltu	a5,a0,8000248c <delay+0xc>
}
80002498:	00008067          	ret

8000249c <joy_get>:

void joy_get(int *joy1, int *joy2) {
   uint32_t joy = reg_joystick;
8000249c:	020007b7          	lui	a5,0x2000
800024a0:	0407a783          	lw	a5,64(a5) # 2000040 <crtStart-0x7dffffc0>
   *joy1 = joy & 0xffff;
800024a4:	01079713          	slli	a4,a5,0x10
800024a8:	01075713          	srli	a4,a4,0x10
800024ac:	00e52023          	sw	a4,0(a0)
   *joy2 = (joy >> 16) & 0xffff;
800024b0:	0107d793          	srli	a5,a5,0x10
800024b4:	00f5a023          	sw	a5,0(a1)
   // uart_printf("joy_get: joy1=%x, joy2=%x\n", *joy1, *joy2);
}
800024b8:	00008067          	ret

800024bc <joy_choice>:

void backup_process();

// (R L X A RT LT DN UP START SELECT Y B)
// overlay_key_code: 0x84 for SELECT&RIGHT, 0xC for SELECT&START, 0x804 for SELECT/RB
int joy_choice(int start_line, int len, int *active, int overlay_key_code) {
800024bc:	fd010113          	addi	sp,sp,-48
800024c0:	03212023          	sw	s2,32(sp)
   if (*active < 0 || *active >= len)
800024c4:	00062903          	lw	s2,0(a2)
int joy_choice(int start_line, int len, int *active, int overlay_key_code) {
800024c8:	02912223          	sw	s1,36(sp)
800024cc:	01412c23          	sw	s4,24(sp)
800024d0:	01612823          	sw	s6,16(sp)
800024d4:	02112623          	sw	ra,44(sp)
800024d8:	02812423          	sw	s0,40(sp)
800024dc:	01312e23          	sw	s3,28(sp)
800024e0:	01512a23          	sw	s5,20(sp)
800024e4:	01712623          	sw	s7,12(sp)
800024e8:	00060493          	mv	s1,a2
800024ec:	00050a13          	mv	s4,a0
800024f0:	00058b13          	mv	s6,a1
   if (*active < 0 || *active >= len)
800024f4:	0c094063          	bltz	s2,800025b4 <joy_choice+0xf8>
800024f8:	0ab95e63          	bge	s2,a1,800025b4 <joy_choice+0xf8>
   uint32_t joy = reg_joystick;
800024fc:	020007b7          	lui	a5,0x2000
80002500:	0407a403          	lw	s0,64(a5) # 2000040 <crtStart-0x7dffffc0>
   return _overlay_status;
80002504:	80011ab7          	lui	s5,0x80011
   *joy1 = joy & 0xffff;
80002508:	01041993          	slli	s3,s0,0x10
8000250c:	0109d993          	srli	s3,s3,0x10
   *joy2 = (joy >> 16) & 0xffff;
80002510:	01045b93          	srli	s7,s0,0x10

   // DEBUG("joy_choice: start\n");
   joy_get(&joy1, &joy2);
   // DEBUG("joy_choice: joy1=%x, joy2=%x\n", joy1, joy2);

   if ((joy1 == overlay_key_code) || (joy2 == overlay_key_code)) {
80002514:	0d368263          	beq	a3,s3,800025d8 <joy_choice+0x11c>
80002518:	0d768063          	beq	a3,s7,800025d8 <joy_choice+0x11c>
      overlay(!overlay_status());    // toggle OSD
      delay(300);
   }

   backup_process();                // saves backup every 10 seconds
8000251c:	c6cff0ef          	jal	ra,80001988 <backup_process>

   if (!overlay_status()) {         // stop responding when OSD is off
80002520:	604aa783          	lw	a5,1540(s5) # 80011604 <STACK_TOP+0xffff1604>
80002524:	0e078a63          	beqz	a5,80002618 <joy_choice+0x15c>
      // DEBUG("joy_choice: overlay off\n");
      return 0;
   }

   if ((joy1 & 0x10) || (joy2 & 0x10)) {
80002528:	01746433          	or	s0,s0,s7
8000252c:	01047793          	andi	a5,s0,16
80002530:	00078a63          	beqz	a5,80002544 <joy_choice+0x88>
      if (*active > 0) (*active)--;
80002534:	0004a783          	lw	a5,0(s1)
80002538:	00f05663          	blez	a5,80002544 <joy_choice+0x88>
8000253c:	fff78793          	addi	a5,a5,-1
80002540:	00f4a023          	sw	a5,0(s1)
   }
   if ((joy1 & 0x20) || (joy2 & 0x20)) {
80002544:	02047793          	andi	a5,s0,32
80002548:	00078c63          	beqz	a5,80002560 <joy_choice+0xa4>
      if (*active < len-1) (*active)++;
8000254c:	0004a783          	lw	a5,0(s1)
80002550:	fffb0b13          	addi	s6,s6,-1
80002554:	0167d663          	bge	a5,s6,80002560 <joy_choice+0xa4>
80002558:	00178793          	addi	a5,a5,1
8000255c:	00f4a023          	sw	a5,0(s1)
   }
   if ((joy1 & 0x40) || (joy2 & 0x40))
80002560:	04047793          	andi	a5,s0,64
      return 3;      // previous page
80002564:	00300513          	li	a0,3
   if ((joy1 & 0x40) || (joy2 & 0x40))
80002568:	02079063          	bnez	a5,80002588 <joy_choice+0xcc>
   if ((joy1 & 0x80) || (joy2 & 0x80))
8000256c:	08047413          	andi	s0,s0,128
      return 2;      // next page
80002570:	00200513          	li	a0,2
   if ((joy1 & 0x80) || (joy2 & 0x80))
80002574:	00041a63          	bnez	s0,80002588 <joy_choice+0xcc>
   if ((joy1 & 0x1) || (joy1 & 0x100) || (joy2 & 0x1) || (joy2 & 0x100))
80002578:	0179e9b3          	or	s3,s3,s7
8000257c:	1019f993          	andi	s3,s3,257
      return 1;      // confirm
80002580:	00100513          	li	a0,1
   if ((joy1 & 0x1) || (joy1 & 0x100) || (joy2 & 0x1) || (joy2 & 0x100))
80002584:	0a098663          	beqz	s3,80002630 <joy_choice+0x174>
   }

   // DEBUG("joy_choice: return\n");

   return 0;      
}
80002588:	02c12083          	lw	ra,44(sp)
8000258c:	02812403          	lw	s0,40(sp)
80002590:	02412483          	lw	s1,36(sp)
80002594:	02012903          	lw	s2,32(sp)
80002598:	01c12983          	lw	s3,28(sp)
8000259c:	01812a03          	lw	s4,24(sp)
800025a0:	01412a83          	lw	s5,20(sp)
800025a4:	01012b03          	lw	s6,16(sp)
800025a8:	00c12b83          	lw	s7,12(sp)
800025ac:	03010113          	addi	sp,sp,48
800025b0:	00008067          	ret
   uint32_t joy = reg_joystick;
800025b4:	020007b7          	lui	a5,0x2000
800025b8:	0407a403          	lw	s0,64(a5) # 2000040 <crtStart-0x7dffffc0>
      *active = 0;
800025bc:	0004a023          	sw	zero,0(s1)
800025c0:	00000913          	li	s2,0
   *joy1 = joy & 0xffff;
800025c4:	01041993          	slli	s3,s0,0x10
800025c8:	0109d993          	srli	s3,s3,0x10
   *joy2 = (joy >> 16) & 0xffff;
800025cc:	01045b93          	srli	s7,s0,0x10
   return _overlay_status;
800025d0:	80011ab7          	lui	s5,0x80011
   if ((joy1 == overlay_key_code) || (joy2 == overlay_key_code)) {
800025d4:	f53692e3          	bne	a3,s3,80002518 <joy_choice+0x5c>
   return _overlay_status;
800025d8:	604aa783          	lw	a5,1540(s5) # 80011604 <STACK_TOP+0xffff1604>
      overlay(!overlay_status());    // toggle OSD
800025dc:	0017b713          	seqz	a4,a5
   if (on)
800025e0:	04078063          	beqz	a5,80002620 <joy_choice+0x164>
      reg_textdisp = 0x02000000;
800025e4:	020007b7          	lui	a5,0x2000
800025e8:	00f7a023          	sw	a5,0(a5) # 2000000 <crtStart-0x7e000000>
800025ec:	020007b7          	lui	a5,0x2000
800025f0:	0507a503          	lw	a0,80(a5) # 2000050 <crtStart-0x7dffffb0>
   _overlay_status = on;
800025f4:	60eaa223          	sw	a4,1540(s5)
800025f8:	020006b7          	lui	a3,0x2000
   while (time_millis() - t0 < ms) {}
800025fc:	12b00713          	li	a4,299
80002600:	0506a783          	lw	a5,80(a3) # 2000050 <crtStart-0x7dffffb0>
80002604:	40a787b3          	sub	a5,a5,a0
80002608:	fef77ce3          	bgeu	a4,a5,80002600 <joy_choice+0x144>
   backup_process();                // saves backup every 10 seconds
8000260c:	b7cff0ef          	jal	ra,80001988 <backup_process>
   if (!overlay_status()) {         // stop responding when OSD is off
80002610:	604aa783          	lw	a5,1540(s5)
80002614:	f0079ae3          	bnez	a5,80002528 <joy_choice+0x6c>
      return 0;
80002618:	00000513          	li	a0,0
8000261c:	f6dff06f          	j	80002588 <joy_choice+0xcc>
      reg_textdisp = 0x01000000;
80002620:	020007b7          	lui	a5,0x2000
80002624:	010006b7          	lui	a3,0x1000
80002628:	00d7a023          	sw	a3,0(a5) # 2000000 <crtStart-0x7e000000>
8000262c:	fc1ff06f          	j	800025ec <joy_choice+0x130>
   cursor(0, start_line + (*active));
80002630:	0004a783          	lw	a5,0(s1)
   curx = x;
80002634:	800119b7          	lui	s3,0x80011
   cury = y;
80002638:	80011437          	lui	s0,0x80011
   cursor(0, start_line + (*active));
8000263c:	00fa07b3          	add	a5,s4,a5
		putchar(*(p++));
80002640:	03e00513          	li	a0,62
   cury = y;
80002644:	60f42023          	sw	a5,1536(s0) # 80011600 <STACK_TOP+0xffff1600>
   curx = x;
80002648:	6009a423          	sw	zero,1544(s3) # 80011608 <STACK_TOP+0xffff1608>
		putchar(*(p++));
8000264c:	dfcff0ef          	jal	ra,80001c48 <putchar>
   if (last != *active) {
80002650:	0004a783          	lw	a5,0(s1)
80002654:	fd2782e3          	beq	a5,s2,80002618 <joy_choice+0x15c>
      cursor(0, start_line + last);
80002658:	012a0933          	add	s2,s4,s2
		putchar(*(p++));
8000265c:	02000513          	li	a0,32
   curx = x;
80002660:	6009a423          	sw	zero,1544(s3)
   cury = y;
80002664:	61242023          	sw	s2,1536(s0)
		putchar(*(p++));
80002668:	de0ff0ef          	jal	ra,80001c48 <putchar>
8000266c:	020007b7          	lui	a5,0x2000
80002670:	0507a603          	lw	a2,80(a5) # 2000050 <crtStart-0x7dffffb0>
80002674:	020006b7          	lui	a3,0x2000
   while (time_millis() - t0 < ms) {}
80002678:	06300713          	li	a4,99
8000267c:	0506a783          	lw	a5,80(a3) # 2000050 <crtStart-0x7dffffb0>
80002680:	40c787b3          	sub	a5,a5,a2
80002684:	fef77ce3          	bgeu	a4,a5,8000267c <joy_choice+0x1c0>
      return 0;
80002688:	00000513          	li	a0,0
8000268c:	efdff06f          	j	80002588 <joy_choice+0xcc>

80002690 <core_ctrl>:

void core_ctrl(uint32_t ctrl) {
   reg_romload_ctrl = ctrl;
80002690:	020007b7          	lui	a5,0x2000
80002694:	02a7a823          	sw	a0,48(a5) # 2000030 <crtStart-0x7dffffd0>
}
80002698:	00008067          	ret

8000269c <core_data>:
extern void core_data(uint32_t data) {
   reg_romload_data = data;
8000269c:	020007b7          	lui	a5,0x2000
800026a0:	02a7aa23          	sw	a0,52(a5) # 2000034 <crtStart-0x7dffffcc>
}
800026a4:	00008067          	ret

800026a8 <memcpy>:
   uint32_t * plDst = (uint32_t *) dst;
   uint32_t const * plSrc = (uint32_t const *) src;

   // If source and destination are aligned,
   // copy 32s bit by 32 bits.
   if (!((uint32_t)src & 3) && !((uint32_t)dst & 3)) {
800026a8:	00a5e733          	or	a4,a1,a0
800026ac:	00377713          	andi	a4,a4,3
   uint32_t * plDst = (uint32_t *) dst;
800026b0:	00050793          	mv	a5,a0
   if (!((uint32_t)src & 3) && !((uint32_t)dst & 3)) {
800026b4:	02070263          	beqz	a4,800026d8 <memcpy+0x30>
   }

   uint8_t* pcDst = (uint8_t *) plDst;
   uint8_t const* pcSrc = (uint8_t const *) plSrc;
   
   while (len--) {
800026b8:	00060e63          	beqz	a2,800026d4 <memcpy+0x2c>
800026bc:	00c78633          	add	a2,a5,a2
      *pcDst++ = *pcSrc++;
800026c0:	00158593          	addi	a1,a1,1
800026c4:	fff5c703          	lbu	a4,-1(a1)
800026c8:	00178793          	addi	a5,a5,1
800026cc:	fee78fa3          	sb	a4,-1(a5)
   while (len--) {
800026d0:	fec798e3          	bne	a5,a2,800026c0 <memcpy+0x18>
   }
   
   return dst;
}
800026d4:	00008067          	ret
      while (len >= 4) {
800026d8:	00300793          	li	a5,3
800026dc:	02c7fe63          	bgeu	a5,a2,80002718 <memcpy+0x70>
800026e0:	ffc60893          	addi	a7,a2,-4
800026e4:	ffc8f893          	andi	a7,a7,-4
800026e8:	00488893          	addi	a7,a7,4
800026ec:	011507b3          	add	a5,a0,a7
   uint32_t const * plSrc = (uint32_t const *) src;
800026f0:	00058693          	mv	a3,a1
   uint32_t * plDst = (uint32_t *) dst;
800026f4:	00050713          	mv	a4,a0
	 *plDst++ = *plSrc++;
800026f8:	00468693          	addi	a3,a3,4
800026fc:	ffc6a803          	lw	a6,-4(a3)
80002700:	00470713          	addi	a4,a4,4
80002704:	ff072e23          	sw	a6,-4(a4)
      while (len >= 4) {
80002708:	fee798e3          	bne	a5,a4,800026f8 <memcpy+0x50>
8000270c:	00367613          	andi	a2,a2,3
80002710:	011585b3          	add	a1,a1,a7
80002714:	fa5ff06f          	j	800026b8 <memcpy+0x10>
   uint32_t * plDst = (uint32_t *) dst;
80002718:	00050793          	mv	a5,a0
8000271c:	f9dff06f          	j	800026b8 <memcpy+0x10>

80002720 <memset>:
 * Super-slow memset function.
 * TODO: write word by word.
 */ 
void* memset(void* s, int c, size_t n) {
   uint8_t* p = (uint8_t*)s;
   for(size_t i=0; i<n; ++i) {
80002720:	0ff5f593          	andi	a1,a1,255
80002724:	00c50733          	add	a4,a0,a2
   uint8_t* p = (uint8_t*)s;
80002728:	00050793          	mv	a5,a0
   for(size_t i=0; i<n; ++i) {
8000272c:	00060863          	beqz	a2,8000273c <memset+0x1c>
       *p = (uint8_t)c;
80002730:	00b78023          	sb	a1,0(a5)
       p++;
80002734:	00178793          	addi	a5,a5,1
   for(size_t i=0; i<n; ++i) {
80002738:	fee79ce3          	bne	a5,a4,80002730 <memset+0x10>
   }
   return s;
}
8000273c:	00008067          	ret

80002740 <memcmp>:

int memcmp(const void *s1, const void *s2, size_t n) {
   uint8_t *p1 = (uint8_t *)s1;
   uint8_t *p2 = (uint8_t *)s2;
   for (int i = 0; i < n; i++) {
80002740:	02060863          	beqz	a2,80002770 <memcmp+0x30>
      if (*p1 != *p2)
80002744:	00054783          	lbu	a5,0(a0)
80002748:	0005c703          	lbu	a4,0(a1)
8000274c:	00c50633          	add	a2,a0,a2
80002750:	00f70a63          	beq	a4,a5,80002764 <memcmp+0x24>
80002754:	0240006f          	j	80002778 <memcmp+0x38>
80002758:	00054783          	lbu	a5,0(a0)
8000275c:	0005c703          	lbu	a4,0(a1)
80002760:	00e79c63          	bne	a5,a4,80002778 <memcmp+0x38>
         return (*p1) < (*p2) ? -1 : 1;
      p1++;
80002764:	00150513          	addi	a0,a0,1
      p2++;
80002768:	00158593          	addi	a1,a1,1
   for (int i = 0; i < n; i++) {
8000276c:	fea616e3          	bne	a2,a0,80002758 <memcmp+0x18>
   }
   return 0;
80002770:	00000513          	li	a0,0
}
80002774:	00008067          	ret
         return (*p1) < (*p2) ? -1 : 1;
80002778:	00e7b533          	sltu	a0,a5,a4
8000277c:	40a00533          	neg	a0,a0
80002780:	ffe57513          	andi	a0,a0,-2
80002784:	00150513          	addi	a0,a0,1
80002788:	00008067          	ret

8000278c <strcmp>:

int strcmp(const char* s1, const char* s2)
{
   while(*s1 && (*s1 == *s2)) {
8000278c:	00054783          	lbu	a5,0(a0)
80002790:	0005c703          	lbu	a4,0(a1)
80002794:	00078e63          	beqz	a5,800027b0 <strcmp+0x24>
80002798:	00e79e63          	bne	a5,a4,800027b4 <strcmp+0x28>
      s1++;
8000279c:	00150513          	addi	a0,a0,1
   while(*s1 && (*s1 == *s2)) {
800027a0:	00054783          	lbu	a5,0(a0)
      s2++;
800027a4:	00158593          	addi	a1,a1,1
800027a8:	0005c703          	lbu	a4,0(a1)
   while(*s1 && (*s1 == *s2)) {
800027ac:	fe0796e3          	bnez	a5,80002798 <strcmp+0xc>
800027b0:	00000793          	li	a5,0
   }
   return *(const unsigned char*)s1 - *(const unsigned char*)s2;
}
800027b4:	40e78533          	sub	a0,a5,a4
800027b8:	00008067          	ret

800027bc <strcasecmp>:

int strcasecmp(const char* s1, const char* s2) {
   while(*s1 && (tolower(*s1) == tolower(*s2))) {
800027bc:	00054783          	lbu	a5,0(a0)
800027c0:	0005c703          	lbu	a4,0(a1)
    if (c >= 'A' && c <= 'Z')
800027c4:	01900813          	li	a6,25
800027c8:	02078e63          	beqz	a5,80002804 <strcasecmp+0x48>
800027cc:	fbf78613          	addi	a2,a5,-65
      s1++;
800027d0:	00150513          	addi	a0,a0,1
800027d4:	fbf70893          	addi	a7,a4,-65
      s2++;
800027d8:	00158593          	addi	a1,a1,1
        return c;
800027dc:	00078693          	mv	a3,a5
    if (c >= 'A' && c <= 'Z')
800027e0:	00c86463          	bltu	a6,a2,800027e8 <strcasecmp+0x2c>
        return c + ('a' - 'A');
800027e4:	02078693          	addi	a3,a5,32
        return c;
800027e8:	00070613          	mv	a2,a4
    if (c >= 'A' && c <= 'Z')
800027ec:	01186463          	bltu	a6,a7,800027f4 <strcasecmp+0x38>
        return c + ('a' - 'A');
800027f0:	02070613          	addi	a2,a4,32
   while(*s1 && (tolower(*s1) == tolower(*s2))) {
800027f4:	00d61863          	bne	a2,a3,80002804 <strcasecmp+0x48>
800027f8:	00054783          	lbu	a5,0(a0)
800027fc:	0005c703          	lbu	a4,0(a1)
80002800:	fc0796e3          	bnez	a5,800027cc <strcasecmp+0x10>
   }
   return *(const unsigned char*)s1 - *(const unsigned char*)s2;
}
80002804:	40e78533          	sub	a0,a5,a4
80002808:	00008067          	ret

8000280c <strstr>:

char *strstr(const char *haystack, const char *substring) {
   char *string = (char *)haystack;
   char *a, *b;
   b = (char *)substring;
   if (*b == 0) 
8000280c:	0005c803          	lbu	a6,0(a1)
80002810:	02080063          	beqz	a6,80002830 <strstr+0x24>
	   return string;
   for (; *string != 0; string += 1) {
80002814:	00054783          	lbu	a5,0(a0)
80002818:	00078a63          	beqz	a5,8000282c <strstr+0x20>
	   if (*string != *b)
8000281c:	00f80c63          	beq	a6,a5,80002834 <strstr+0x28>
   for (; *string != 0; string += 1) {
80002820:	00150513          	addi	a0,a0,1
80002824:	00054783          	lbu	a5,0(a0)
80002828:	fe079ae3          	bnez	a5,8000281c <strstr+0x10>
         if (*a++ != *b++) 
            break;
      }
      b = (char *)substring;
   }
   return NULL;
8000282c:	00000513          	li	a0,0
}
80002830:	00008067          	ret
80002834:	00058713          	mv	a4,a1
80002838:	00050793          	mv	a5,a0
8000283c:	00080693          	mv	a3,a6
         if (*a++ != *b++) 
80002840:	00178793          	addi	a5,a5,1
80002844:	fff7c603          	lbu	a2,-1(a5)
80002848:	00170713          	addi	a4,a4,1
8000284c:	fcd61ae3          	bne	a2,a3,80002820 <strstr+0x14>
         if (*b == 0) 
80002850:	00074683          	lbu	a3,0(a4)
80002854:	fe0696e3          	bnez	a3,80002840 <strstr+0x34>
}
80002858:	00008067          	ret

8000285c <strcasestr>:

char *strcasestr(char *string, char *substring) {
   char *a, *b;
   b = substring;
   if (*b == 0) 
8000285c:	0005ce03          	lbu	t3,0(a1)
80002860:	040e0263          	beqz	t3,800028a4 <strcasestr+0x48>
	   return string;
   for (; *string != 0; string += 1) {
80002864:	00054783          	lbu	a5,0(a0)
80002868:	02078a63          	beqz	a5,8000289c <strcasestr+0x40>
    if (c >= 'A' && c <= 'Z')
8000286c:	fbfe0713          	addi	a4,t3,-65
80002870:	01900693          	li	a3,25
        return c + ('a' - 'A');
80002874:	020e0e93          	addi	t4,t3,32
80002878:	06e6e863          	bltu	a3,a4,800028e8 <strcasestr+0x8c>
    if (c >= 'A' && c <= 'Z')
8000287c:	01900813          	li	a6,25
80002880:	fbf78713          	addi	a4,a5,-65
80002884:	00e86463          	bltu	a6,a4,8000288c <strcasestr+0x30>
        return c + ('a' - 'A');
80002888:	02078793          	addi	a5,a5,32
	   if (tolower(*string) != tolower(*b))
8000288c:	00fe8e63          	beq	t4,a5,800028a8 <strcasestr+0x4c>
   for (; *string != 0; string += 1) {
80002890:	00150513          	addi	a0,a0,1
80002894:	00054783          	lbu	a5,0(a0)
80002898:	fe0794e3          	bnez	a5,80002880 <strcasestr+0x24>
         if (tolower(*a++) != tolower(*b++)) 
            break;
      }
      b = substring;
   }
   return NULL;
8000289c:	00000513          	li	a0,0
800028a0:	00008067          	ret
}
800028a4:	00008067          	ret
800028a8:	00058613          	mv	a2,a1
800028ac:	00050693          	mv	a3,a0
800028b0:	000e0793          	mv	a5,t3
         if (tolower(*a++) != tolower(*b++)) 
800028b4:	00168693          	addi	a3,a3,1
800028b8:	fff6c703          	lbu	a4,-1(a3)
    if (c >= 'A' && c <= 'Z')
800028bc:	fbf78893          	addi	a7,a5,-65
800028c0:	fbf70313          	addi	t1,a4,-65
800028c4:	00686463          	bltu	a6,t1,800028cc <strcasestr+0x70>
        return c + ('a' - 'A');
800028c8:	02070713          	addi	a4,a4,32
800028cc:	00160613          	addi	a2,a2,1
    if (c >= 'A' && c <= 'Z')
800028d0:	01186463          	bltu	a6,a7,800028d8 <strcasestr+0x7c>
        return c + ('a' - 'A');
800028d4:	02078793          	addi	a5,a5,32
800028d8:	fae79ce3          	bne	a5,a4,80002890 <strcasestr+0x34>
         if (*b == 0) 
800028dc:	00064783          	lbu	a5,0(a2)
800028e0:	fc079ae3          	bnez	a5,800028b4 <strcasestr+0x58>
800028e4:	00008067          	ret
	   if (tolower(*string) != tolower(*b))
800028e8:	000e0e93          	mv	t4,t3
800028ec:	f91ff06f          	j	8000287c <strcasestr+0x20>

800028f0 <strcat>:

char *strcat(char *dest, const char *src) {
   char *rdest = dest;

   while (*dest)
800028f0:	00054783          	lbu	a5,0(a0)
800028f4:	02078663          	beqz	a5,80002920 <strcat+0x30>
800028f8:	00050793          	mv	a5,a0
      dest++;
800028fc:	00178793          	addi	a5,a5,1
   while (*dest)
80002900:	0007c703          	lbu	a4,0(a5)
80002904:	fe071ce3          	bnez	a4,800028fc <strcat+0xc>
   while ((*dest++ = *src++))
80002908:	00158593          	addi	a1,a1,1
8000290c:	fff5c703          	lbu	a4,-1(a1)
80002910:	00178793          	addi	a5,a5,1
80002914:	fee78fa3          	sb	a4,-1(a5)
80002918:	fe0718e3          	bnez	a4,80002908 <strcat+0x18>
      ;
   return rdest;
}
8000291c:	00008067          	ret
   while ((*dest++ = *src++))
80002920:	00158593          	addi	a1,a1,1
80002924:	fff5c703          	lbu	a4,-1(a1)
   while (*dest)
80002928:	00050793          	mv	a5,a0
   while ((*dest++ = *src++))
8000292c:	00178793          	addi	a5,a5,1
80002930:	fee78fa3          	sb	a4,-1(a5)
80002934:	fc071ae3          	bnez	a4,80002908 <strcat+0x18>
80002938:	fe5ff06f          	j	8000291c <strcat+0x2c>

8000293c <strncat>:

char* strncat(char* destination, const char* source, size_t num)
{
   int i, j;
   for (i = 0; destination[i] != '\0'; i++);
8000293c:	00054783          	lbu	a5,0(a0)
80002940:	06078463          	beqz	a5,800029a8 <strncat+0x6c>
80002944:	00150713          	addi	a4,a0,1
80002948:	00000793          	li	a5,0
8000294c:	00070813          	mv	a6,a4
80002950:	00170713          	addi	a4,a4,1
80002954:	fff74683          	lbu	a3,-1(a4)
80002958:	00178793          	addi	a5,a5,1
8000295c:	fe0698e3          	bnez	a3,8000294c <strncat+0x10>
   for (j = 0; source[j] != '\0' && j < num; j++) {
80002960:	0005c683          	lbu	a3,0(a1)
80002964:	02068e63          	beqz	a3,800029a0 <strncat+0x64>
80002968:	02060c63          	beqz	a2,800029a0 <strncat+0x64>
8000296c:	00178793          	addi	a5,a5,1
80002970:	00160613          	addi	a2,a2,1
80002974:	00158713          	addi	a4,a1,1
80002978:	00f507b3          	add	a5,a0,a5
8000297c:	00c585b3          	add	a1,a1,a2
80002980:	00c0006f          	j	8000298c <strncat+0x50>
80002984:	00178793          	addi	a5,a5,1
80002988:	00b70c63          	beq	a4,a1,800029a0 <strncat+0x64>
      destination[i + j] = source[j];
8000298c:	fed78fa3          	sb	a3,-1(a5)
   for (j = 0; source[j] != '\0' && j < num; j++) {
80002990:	00074683          	lbu	a3,0(a4)
80002994:	00078813          	mv	a6,a5
80002998:	00170713          	addi	a4,a4,1
8000299c:	fe0694e3          	bnez	a3,80002984 <strncat+0x48>
   }
   destination[i + j] = '\0';
800029a0:	00080023          	sb	zero,0(a6)
   return destination;
}
800029a4:	00008067          	ret
   for (i = 0; destination[i] != '\0'; i++);
800029a8:	00050813          	mv	a6,a0
800029ac:	00000793          	li	a5,0
800029b0:	fb1ff06f          	j	80002960 <strncat+0x24>

800029b4 <strcpy>:

char * strcpy(char *strDest, const char *strSrc) {
   //  assert(strDest!=NULL && strSrc!=NULL);
    char *temp = strDest;
    while ((*strDest++ = *strSrc++))
800029b4:	00050793          	mv	a5,a0
800029b8:	00158593          	addi	a1,a1,1
800029bc:	fff5c703          	lbu	a4,-1(a1)
800029c0:	00178793          	addi	a5,a5,1
800029c4:	fee78fa3          	sb	a4,-1(a5)
800029c8:	fe0718e3          	bnez	a4,800029b8 <strcpy+0x4>
		;
    return temp;
}
800029cc:	00008067          	ret

800029d0 <strncpy>:

char *strncpy(char* _dst, const char* _src, size_t _n) {
   size_t i = 0;
   char *r = _dst;
   while(i++ != _n && (*_dst++ = *_src++));
800029d0:	00c50633          	add	a2,a0,a2
800029d4:	00050793          	mv	a5,a0
800029d8:	0140006f          	j	800029ec <strncpy+0x1c>
800029dc:	fff5c703          	lbu	a4,-1(a1)
800029e0:	00178793          	addi	a5,a5,1
800029e4:	fee78fa3          	sb	a4,-1(a5)
800029e8:	00070663          	beqz	a4,800029f4 <strncpy+0x24>
800029ec:	00158593          	addi	a1,a1,1
800029f0:	fec796e3          	bne	a5,a2,800029dc <strncpy+0xc>
   return r;
}
800029f4:	00008067          	ret

800029f8 <strchr>:

char *strchr(const char *s, int c) {
   while (*s) {
800029f8:	00054783          	lbu	a5,0(a0)
800029fc:	00078e63          	beqz	a5,80002a18 <strchr+0x20>
      if (*s == c)
80002a00:	00f59663          	bne	a1,a5,80002a0c <strchr+0x14>
80002a04:	01c0006f          	j	80002a20 <strchr+0x28>
80002a08:	00b78a63          	beq	a5,a1,80002a1c <strchr+0x24>
         return (char *)s;
      s++;
80002a0c:	00150513          	addi	a0,a0,1
   while (*s) {
80002a10:	00054783          	lbu	a5,0(a0)
80002a14:	fe079ae3          	bnez	a5,80002a08 <strchr+0x10>
   }
   return (char *)0;
80002a18:	00000513          	li	a0,0
}
80002a1c:	00008067          	ret
80002a20:	00008067          	ret

80002a24 <strrchr>:

char *strrchr(const char *s, int c) {
80002a24:	00050793          	mv	a5,a0
   char *r = 0;
80002a28:	00000513          	li	a0,0
   do {
      if (*s == c)
80002a2c:	0007c703          	lbu	a4,0(a5)
80002a30:	00b71463          	bne	a4,a1,80002a38 <strrchr+0x14>
80002a34:	00078513          	mv	a0,a5
         r = (char*) s;
   } while (*s++);
80002a38:	00178793          	addi	a5,a5,1
80002a3c:	fe0718e3          	bnez	a4,80002a2c <strrchr+0x8>
   return r;
}
80002a40:	00008067          	ret

80002a44 <strlen>:

size_t strlen(const char *s) {
   size_t r = 0;
   while (*s != '\0') {
80002a44:	00054783          	lbu	a5,0(a0)
80002a48:	02078063          	beqz	a5,80002a68 <strlen+0x24>
   size_t r = 0;
80002a4c:	00000793          	li	a5,0
      r++;
80002a50:	00178793          	addi	a5,a5,1
   while (*s != '\0') {
80002a54:	00f50733          	add	a4,a0,a5
80002a58:	00074703          	lbu	a4,0(a4)
80002a5c:	fe071ae3          	bnez	a4,80002a50 <strlen+0xc>
      s++;
   }
   return r;
}
80002a60:	00078513          	mv	a0,a5
80002a64:	00008067          	ret
   size_t r = 0;
80002a68:	00000793          	li	a5,0
}
80002a6c:	00078513          	mv	a0,a5
80002a70:	00008067          	ret

80002a74 <isspace>:

int isspace(int c) {
	return (c == '\t' || c == '\n' ||
	    c == '\v' || c == '\f' || c == '\r' || c == ' ' ? 1 : 0);
80002a74:	ff750713          	addi	a4,a0,-9
80002a78:	00400793          	li	a5,4
80002a7c:	00e7f863          	bgeu	a5,a4,80002a8c <isspace+0x18>
80002a80:	fe050513          	addi	a0,a0,-32
80002a84:	00153513          	seqz	a0,a0
80002a88:	00008067          	ret
80002a8c:	00100513          	li	a0,1
}
80002a90:	00008067          	ret

80002a94 <trimwhitespace>:
	    c == '\v' || c == '\f' || c == '\r' || c == ' ' ? 1 : 0);
80002a94:	00400693          	li	a3,4
80002a98:	02000613          	li	a2,32

char *trimwhitespace(char *str) {
   char *end;
   // Trim leading space
   while(isspace((unsigned char)*str)) str++;
80002a9c:	00054783          	lbu	a5,0(a0)
	    c == '\v' || c == '\f' || c == '\r' || c == ' ' ? 1 : 0);
80002aa0:	ff778713          	addi	a4,a5,-9
80002aa4:	06e6f063          	bgeu	a3,a4,80002b04 <trimwhitespace+0x70>
80002aa8:	04c78e63          	beq	a5,a2,80002b04 <trimwhitespace+0x70>

   if(*str == 0)  // All spaces?
80002aac:	04078263          	beqz	a5,80002af0 <trimwhitespace+0x5c>
   size_t r = 0;
80002ab0:	00000793          	li	a5,0
80002ab4:	0080006f          	j	80002abc <trimwhitespace+0x28>
      r++;
80002ab8:	00070793          	mv	a5,a4
80002abc:	00178713          	addi	a4,a5,1
   while (*s != '\0') {
80002ac0:	00e506b3          	add	a3,a0,a4
80002ac4:	0006c683          	lbu	a3,0(a3)
80002ac8:	fe0698e3          	bnez	a3,80002ab8 <trimwhitespace+0x24>
      return str;

   // Trim trailing space
   end = str + strlen(str) - 1;
80002acc:	00f507b3          	add	a5,a0,a5
	    c == '\v' || c == '\f' || c == '\r' || c == ' ' ? 1 : 0);
80002ad0:	00400613          	li	a2,4
80002ad4:	02000593          	li	a1,32
   while(end > str && isspace((unsigned char)*end)) end--;
80002ad8:	00f57a63          	bgeu	a0,a5,80002aec <trimwhitespace+0x58>
80002adc:	0007c703          	lbu	a4,0(a5)
	    c == '\v' || c == '\f' || c == '\r' || c == ' ' ? 1 : 0);
80002ae0:	ff770693          	addi	a3,a4,-9
80002ae4:	00d67863          	bgeu	a2,a3,80002af4 <trimwhitespace+0x60>
80002ae8:	00b70663          	beq	a4,a1,80002af4 <trimwhitespace+0x60>

   // Write new null terminator character
   end[1] = '\0';
80002aec:	000780a3          	sb	zero,1(a5)

   return str;
}
80002af0:	00008067          	ret
   while(end > str && isspace((unsigned char)*end)) end--;
80002af4:	fff78793          	addi	a5,a5,-1
80002af8:	fef512e3          	bne	a0,a5,80002adc <trimwhitespace+0x48>
   end[1] = '\0';
80002afc:	000780a3          	sb	zero,1(a5)
   return str;
80002b00:	ff1ff06f          	j	80002af0 <trimwhitespace+0x5c>
   while(isspace((unsigned char)*str)) str++;
80002b04:	00150513          	addi	a0,a0,1
80002b08:	f95ff06f          	j	80002a9c <trimwhitespace+0x8>

80002b0c <atoi>:

int atoi(const char *str) {
   int sign = 1, base = 0, i = 0;
 
   // if whitespaces then ignore.
   while (str[i] == ' ') {
80002b0c:	00054783          	lbu	a5,0(a0)
80002b10:	02000713          	li	a4,32
80002b14:	10e79c63          	bne	a5,a4,80002c2c <atoi+0x120>
   int sign = 1, base = 0, i = 0;
80002b18:	00000713          	li	a4,0
   while (str[i] == ' ') {
80002b1c:	02000693          	li	a3,32
      i++;
80002b20:	00170713          	addi	a4,a4,1
   while (str[i] == ' ') {
80002b24:	00e507b3          	add	a5,a0,a4
80002b28:	0007c783          	lbu	a5,0(a5)
80002b2c:	fed78ae3          	beq	a5,a3,80002b20 <atoi+0x14>
   }
 
   // sign of number
   if (str[i] == '-' || str[i] == '+') {
80002b30:	02d00693          	li	a3,45
80002b34:	0cd78463          	beq	a5,a3,80002bfc <atoi+0xf0>
80002b38:	02b00693          	li	a3,43
80002b3c:	0ad78c63          	beq	a5,a3,80002bf4 <atoi+0xe8>
         sign = -1;
      i++;
   }
 
   // checking for valid input
   while (str[i] >= '0' && str[i] <= '9') {
80002b40:	00e507b3          	add	a5,a0,a4
80002b44:	0007c603          	lbu	a2,0(a5)
80002b48:	00900793          	li	a5,9
   int sign = 1, base = 0, i = 0;
80002b4c:	00100e13          	li	t3,1
   while (str[i] >= '0' && str[i] <= '9') {
80002b50:	fd060593          	addi	a1,a2,-48
80002b54:	0ff5f693          	andi	a3,a1,255
80002b58:	0cd7ee63          	bltu	a5,a3,80002c34 <atoi+0x128>
      // handling overflow test case
      if (base > INT_MAX / 10
80002b5c:	0cccd837          	lui	a6,0xcccd
   int sign = 1, base = 0, i = 0;
80002b60:	00000793          	li	a5,0
   while (str[i] >= '0' && str[i] <= '9') {
80002b64:	00900313          	li	t1,9
      if (base > INT_MAX / 10
80002b68:	ccc80813          	addi	a6,a6,-820 # ccccccc <crtStart-0x73333334>
80002b6c:	0080006f          	j	80002b74 <atoi+0x68>
         if (sign == 1)
            return INT_MAX;
         else
            return INT_MIN;
      }
      base = 10 * base + (str[i++] - '0');
80002b70:	00088713          	mv	a4,a7
80002b74:	00170893          	addi	a7,a4,1
   while (str[i] >= '0' && str[i] <= '9') {
80002b78:	01150633          	add	a2,a0,a7
      base = 10 * base + (str[i++] - '0');
80002b7c:	00279693          	slli	a3,a5,0x2
   while (str[i] >= '0' && str[i] <= '9') {
80002b80:	00064603          	lbu	a2,0(a2)
      base = 10 * base + (str[i++] - '0');
80002b84:	00f687b3          	add	a5,a3,a5
80002b88:	00179793          	slli	a5,a5,0x1
80002b8c:	00f587b3          	add	a5,a1,a5
   while (str[i] >= '0' && str[i] <= '9') {
80002b90:	fd060593          	addi	a1,a2,-48
80002b94:	0ff5f693          	andi	a3,a1,255
80002b98:	02d36a63          	bltu	t1,a3,80002bcc <atoi+0xc0>
      if (base > INT_MAX / 10
80002b9c:	04f84063          	blt	a6,a5,80002bdc <atoi+0xd0>
         || (base == INT_MAX / 10 && str[i] - '0' > 7)) {
80002ba0:	fd0798e3          	bne	a5,a6,80002b70 <atoi+0x64>
80002ba4:	03700793          	li	a5,55
80002ba8:	02c7ea63          	bltu	a5,a2,80002bdc <atoi+0xd0>
   while (str[i] >= '0' && str[i] <= '9') {
80002bac:	00e50533          	add	a0,a0,a4
80002bb0:	00254703          	lbu	a4,2(a0)
      base = 10 * base + (str[i++] - '0');
80002bb4:	800007b7          	lui	a5,0x80000
80002bb8:	fc87c793          	xori	a5,a5,-56
   while (str[i] >= '0' && str[i] <= '9') {
80002bbc:	fd070713          	addi	a4,a4,-48
80002bc0:	0ff77713          	andi	a4,a4,255
      base = 10 * base + (str[i++] - '0');
80002bc4:	00f607b3          	add	a5,a2,a5
   while (str[i] >= '0' && str[i] <= '9') {
80002bc8:	00e37a63          	bgeu	t1,a4,80002bdc <atoi+0xd0>
   }
   return sign == -1 ? -base : base;
80002bcc:	fff00713          	li	a4,-1
80002bd0:	04ee0863          	beq	t3,a4,80002c20 <atoi+0x114>
}
80002bd4:	00078513          	mv	a0,a5
80002bd8:	00008067          	ret
            return INT_MAX;
80002bdc:	800007b7          	lui	a5,0x80000
         if (sign == 1)
80002be0:	00100713          	li	a4,1
            return INT_MAX;
80002be4:	fff7c793          	not	a5,a5
         if (sign == 1)
80002be8:	feee06e3          	beq	t3,a4,80002bd4 <atoi+0xc8>
            return INT_MIN;
80002bec:	800007b7          	lui	a5,0x80000
80002bf0:	fe5ff06f          	j	80002bd4 <atoi+0xc8>
      i++;
80002bf4:	00170713          	addi	a4,a4,1
80002bf8:	f49ff06f          	j	80002b40 <atoi+0x34>
80002bfc:	00170713          	addi	a4,a4,1
   while (str[i] >= '0' && str[i] <= '9') {
80002c00:	00e507b3          	add	a5,a0,a4
80002c04:	0007c603          	lbu	a2,0(a5) # 80000000 <STACK_TOP+0xfffe0000>
80002c08:	00900793          	li	a5,9
         sign = -1;
80002c0c:	fff00e13          	li	t3,-1
   while (str[i] >= '0' && str[i] <= '9') {
80002c10:	fd060593          	addi	a1,a2,-48
80002c14:	0ff5f693          	andi	a3,a1,255
80002c18:	f4d7f2e3          	bgeu	a5,a3,80002b5c <atoi+0x50>
80002c1c:	00000793          	li	a5,0
   return sign == -1 ? -base : base;
80002c20:	40f007b3          	neg	a5,a5
}
80002c24:	00078513          	mv	a0,a5
80002c28:	00008067          	ret
   int sign = 1, base = 0, i = 0;
80002c2c:	00000713          	li	a4,0
80002c30:	f01ff06f          	j	80002b30 <atoi+0x24>
   while (str[i] >= '0' && str[i] <= '9') {
80002c34:	00000793          	li	a5,0
80002c38:	f9dff06f          	j	80002bd4 <atoi+0xc8>

80002c3c <spi_send>:
// SD over SPI: https://onlinedocs.microchip.com/pr/GUID-F9FE1ABC-D4DD-4988-87CE-2AFD74DEA334-en-US-3/index.html?GUID-48879CB2-9C60-4279-8B98-E17C499B12AF
// http://www.dejazzer.com/ee379/lecture_notes/lec12_sd_card.pdf
// https://electronics.stackexchange.com/questions/77417/what-is-the-correct-command-sequence-for-microsd-card-initialization-in-spi
// send and receive a byte over SPI to sd card
uint8_t spi_send(uint8_t x) {
	reg_spimaster_byte = x;			// send
80002c3c:	020007b7          	lui	a5,0x2000
80002c40:	02a7a023          	sw	a0,32(a5) # 2000020 <crtStart-0x7dffffe0>
	return reg_spimaster_byte;		// receive
80002c44:	0207a503          	lw	a0,32(a5)
}
80002c48:	0ff57513          	andi	a0,a0,255
80002c4c:	00008067          	ret

80002c50 <spi_send_word>:

uint32_t spi_send_word(uint32_t x) {
    reg_spimaster_word = x;
80002c50:	020007b7          	lui	a5,0x2000
80002c54:	02a7a223          	sw	a0,36(a5) # 2000024 <crtStart-0x7dffffdc>
    return reg_spimaster_word;
80002c58:	0247a503          	lw	a0,36(a5)
}
80002c5c:	00008067          	ret

80002c60 <spi_receive>:
	reg_spimaster_byte = x;			// send
80002c60:	020007b7          	lui	a5,0x2000
80002c64:	0ff00713          	li	a4,255
80002c68:	02e7a023          	sw	a4,32(a5) # 2000020 <crtStart-0x7dffffe0>
	return reg_spimaster_byte;		// receive
80002c6c:	0207a503          	lw	a0,32(a5)

uint8_t spi_receive() {
    return spi_send(0xff);
}
80002c70:	0ff57513          	andi	a0,a0,255
80002c74:	00008067          	ret

80002c78 <spi_receive_word>:
    reg_spimaster_word = x;
80002c78:	020007b7          	lui	a5,0x2000
80002c7c:	fff00713          	li	a4,-1
80002c80:	02e7a223          	sw	a4,36(a5) # 2000024 <crtStart-0x7dffffdc>
    return reg_spimaster_word;
80002c84:	0247a503          	lw	a0,36(a5)

uint32_t spi_receive_word() {
    return spi_send_word(0xFFFFFFFF);
}
80002c88:	00008067          	ret

80002c8c <spi_sendrecv>:
	reg_spimaster_byte = x;			// send
80002c8c:	020007b7          	lui	a5,0x2000
80002c90:	02a7a023          	sw	a0,32(a5) # 2000020 <crtStart-0x7dffffe0>
	return reg_spimaster_byte;		// receive
80002c94:	0207a703          	lw	a4,32(a5)
	reg_spimaster_byte = x;			// send
80002c98:	0ff00713          	li	a4,255
80002c9c:	02e7a023          	sw	a4,32(a5)
	return reg_spimaster_byte;		// receive
80002ca0:	0207a503          	lw	a0,32(a5)

uint8_t spi_sendrecv(uint8_t x) {
    spi_send(x);
    return spi_receive();
}
80002ca4:	0ff57513          	andi	a0,a0,255
80002ca8:	00008067          	ret

80002cac <spi_readblock>:

void spi_readblock(uint8_t *ptr, int length) {
    int i = 0;
    if ((((uint32_t)ptr) & 3) == 0) {   // aligned on word boundaries
80002cac:	00357713          	andi	a4,a0,3
    int i = 0;
80002cb0:	00000793          	li	a5,0
    if ((((uint32_t)ptr) & 3) == 0) {   // aligned on word boundaries
80002cb4:	04071263          	bnez	a4,80002cf8 <spi_readblock+0x4c>
        // transfer in 4-byte words. this is about twice as fast
        for (; i+4<=length; i+=4) {
80002cb8:	00300713          	li	a4,3
80002cbc:	02b75e63          	bge	a4,a1,80002cf8 <spi_readblock+0x4c>
80002cc0:	ffc58793          	addi	a5,a1,-4
80002cc4:	0027d793          	srli	a5,a5,0x2
80002cc8:	00178693          	addi	a3,a5,1
80002ccc:	00269613          	slli	a2,a3,0x2
    reg_spimaster_word = x;
80002cd0:	020007b7          	lui	a5,0x2000
80002cd4:	00c50633          	add	a2,a0,a2
80002cd8:	02478793          	addi	a5,a5,36 # 2000024 <crtStart-0x7dffffdc>
80002cdc:	fff00813          	li	a6,-1
80002ce0:	0107a023          	sw	a6,0(a5)
    return reg_spimaster_word;
80002ce4:	0007a703          	lw	a4,0(a5)
            *(uint32_t *)ptr = spi_receive_word();
            ptr+=4;
80002ce8:	00450513          	addi	a0,a0,4
            *(uint32_t *)ptr = spi_receive_word();
80002cec:	fee52e23          	sw	a4,-4(a0)
        for (; i+4<=length; i+=4) {
80002cf0:	fec518e3          	bne	a0,a2,80002ce0 <spi_readblock+0x34>
80002cf4:	00269793          	slli	a5,a3,0x2
        }
    }
    for (; i<length; i++) {
80002cf8:	02b7d663          	bge	a5,a1,80002d24 <spi_readblock+0x78>
80002cfc:	40f585b3          	sub	a1,a1,a5
	reg_spimaster_byte = x;			// send
80002d00:	020007b7          	lui	a5,0x2000
80002d04:	00b505b3          	add	a1,a0,a1
80002d08:	02078793          	addi	a5,a5,32 # 2000020 <crtStart-0x7dffffe0>
80002d0c:	0ff00693          	li	a3,255
80002d10:	00d7a023          	sw	a3,0(a5)
	return reg_spimaster_byte;		// receive
80002d14:	0007a703          	lw	a4,0(a5)
        *ptr++ = spi_receive();
80002d18:	00150513          	addi	a0,a0,1
	return reg_spimaster_byte;		// receive
80002d1c:	fee50fa3          	sb	a4,-1(a0)
    for (; i<length; i++) {
80002d20:	feb518e3          	bne	a0,a1,80002d10 <spi_readblock+0x64>
    }
}
80002d24:	00008067          	ret

80002d28 <spi_writeblock>:

void spi_writeblock(const uint8_t *ptr, int length) {
    int i = 0;
    if ((((uint32_t)ptr) & 3) == 0) {   // aligned on word boundaries
80002d28:	00357713          	andi	a4,a0,3
    int i = 0;
80002d2c:	00000793          	li	a5,0
    if ((((uint32_t)ptr) & 3) == 0) {   // aligned on word boundaries
80002d30:	02071e63          	bnez	a4,80002d6c <spi_writeblock+0x44>
        for (; i+4<=length; i+=4) {
80002d34:	00300713          	li	a4,3
80002d38:	02b75a63          	bge	a4,a1,80002d6c <spi_writeblock+0x44>
80002d3c:	ffc58793          	addi	a5,a1,-4
80002d40:	0027d793          	srli	a5,a5,0x2
80002d44:	00178693          	addi	a3,a5,1
80002d48:	00269613          	slli	a2,a3,0x2
80002d4c:	00c50633          	add	a2,a0,a2
    reg_spimaster_word = x;
80002d50:	020007b7          	lui	a5,0x2000
            spi_send_word(*(uint32_t *)ptr);
80002d54:	00052703          	lw	a4,0(a0)
            ptr += 4;
80002d58:	00450513          	addi	a0,a0,4
    reg_spimaster_word = x;
80002d5c:	02e7a223          	sw	a4,36(a5) # 2000024 <crtStart-0x7dffffdc>
    return reg_spimaster_word;
80002d60:	0247a703          	lw	a4,36(a5)
        for (; i+4<=length; i+=4) {
80002d64:	fec518e3          	bne	a0,a2,80002d54 <spi_writeblock+0x2c>
80002d68:	00269793          	slli	a5,a3,0x2
        }
    }
    for (; i<length; i++) {
80002d6c:	02b7d263          	bge	a5,a1,80002d90 <spi_writeblock+0x68>
80002d70:	40f585b3          	sub	a1,a1,a5
80002d74:	00b505b3          	add	a1,a0,a1
	reg_spimaster_byte = x;			// send
80002d78:	020007b7          	lui	a5,0x2000
        spi_send(*ptr++);
80002d7c:	00150513          	addi	a0,a0,1
	reg_spimaster_byte = x;			// send
80002d80:	fff54703          	lbu	a4,-1(a0)
80002d84:	02e7a023          	sw	a4,32(a5) # 2000020 <crtStart-0x7dffffe0>
	return reg_spimaster_byte;		// receive
80002d88:	0207a703          	lw	a4,32(a5)
    for (; i<length; i++) {
80002d8c:	feb518e3          	bne	a0,a1,80002d7c <spi_writeblock+0x54>
    }
}
80002d90:	00008067          	ret

80002d94 <sd_send_command>:
uint8_t sd_send_command(uint8_t cmd, uint32_t arg) {
    uint8_t response = 0xFF;
    uint8_t status;

    // If non-SDHC card, use byte addressing rather than block (512) addressing
    if(!sdhc_card) {
80002d94:	c6c1a783          	lw	a5,-916(gp) # 8000efdc <sdhc_card>
80002d98:	00079a63          	bnez	a5,80002dac <sd_send_command+0x18>
        switch (cmd) {
80002d9c:	fef50793          	addi	a5,a0,-17
80002da0:	0ff7f793          	andi	a5,a5,255
80002da4:	01000713          	li	a4,16
80002da8:	0cf77663          	bgeu	a4,a5,80002e74 <sd_send_command+0xe0>
	reg_spimaster_byte = x;			// send
80002dac:	020007b7          	lui	a5,0x2000
80002db0:	04056713          	ori	a4,a0,64
80002db4:	02e7a023          	sw	a4,32(a5) # 2000020 <crtStart-0x7dffffe0>
        }
    }

    spi_send(cmd | CMD_START_BITS);
    spi_send((arg >> 24));
    spi_send((arg >> 16));
80002db8:	0105d693          	srli	a3,a1,0x10
    spi_send((arg >> 24));
80002dbc:	0185d713          	srli	a4,a1,0x18
	return reg_spimaster_byte;		// receive
80002dc0:	0207a603          	lw	a2,32(a5)
	reg_spimaster_byte = x;			// send
80002dc4:	0ff6f693          	andi	a3,a3,255
80002dc8:	02e7a023          	sw	a4,32(a5)
    spi_send((arg >> 8));
80002dcc:	0085d713          	srli	a4,a1,0x8
	return reg_spimaster_byte;		// receive
80002dd0:	0207a603          	lw	a2,32(a5)
	reg_spimaster_byte = x;			// send
80002dd4:	0ff77713          	andi	a4,a4,255
80002dd8:	02d7a023          	sw	a3,32(a5)
	return reg_spimaster_byte;		// receive
80002ddc:	0207a683          	lw	a3,32(a5)
	reg_spimaster_byte = x;			// send
80002de0:	0ff5f593          	andi	a1,a1,255
80002de4:	02e7a023          	sw	a4,32(a5)
	return reg_spimaster_byte;		// receive
80002de8:	0207a703          	lw	a4,32(a5)
	reg_spimaster_byte = x;			// send
80002dec:	02b7a023          	sw	a1,32(a5)
	return reg_spimaster_byte;		// receive
80002df0:	0207a703          	lw	a4,32(a5)
    spi_send((arg >> 0));    

    // CRC required for CMD8 (0x87) & CMD0 (0x95) - default to CMD0
    spi_send((cmd == CMD8_SEND_IF_COND) ? CMD8_CRC : CMD0_CRC);    
80002df4:	00800713          	li	a4,8
80002df8:	08e50e63          	beq	a0,a4,80002e94 <sd_send_command+0x100>
	reg_spimaster_byte = x;			// send
80002dfc:	09500713          	li	a4,149
80002e00:	02e7a023          	sw	a4,32(a5)
80002e04:	0ff00713          	li	a4,255
	return reg_spimaster_byte;		// receive
80002e08:	0207a683          	lw	a3,32(a5)
	reg_spimaster_byte = x;			// send
80002e0c:	02e7a023          	sw	a4,32(a5)
	return reg_spimaster_byte;		// receive
80002e10:	0207a783          	lw	a5,32(a5)
80002e14:	0ff7f793          	andi	a5,a5,255

    // Wait for response (i.e MISO not held high)
    int count = 0;
    while((response = spi_receive()) == 0xff) {
80002e18:	0ce79863          	bne	a5,a4,80002ee8 <sd_send_command+0x154>
	reg_spimaster_byte = x;			// send
80002e1c:	020006b7          	lui	a3,0x2000
uint8_t sd_send_command(uint8_t cmd, uint32_t arg) {
80002e20:	1f500713          	li	a4,501
	reg_spimaster_byte = x;			// send
80002e24:	02068693          	addi	a3,a3,32 # 2000020 <crtStart-0x7dffffe0>
80002e28:	0ff00593          	li	a1,255
80002e2c:	0ff00613          	li	a2,255
80002e30:	0080006f          	j	80002e38 <sd_send_command+0xa4>
        if(count > 500) {
80002e34:	02070463          	beqz	a4,80002e5c <sd_send_command+0xc8>
	reg_spimaster_byte = x;			// send
80002e38:	00c6a023          	sw	a2,0(a3)
	return reg_spimaster_byte;		// receive
80002e3c:	0006a783          	lw	a5,0(a3)
80002e40:	fff70713          	addi	a4,a4,-1
80002e44:	0ff7f793          	andi	a5,a5,255
    while((response = spi_receive()) == 0xff) {
80002e48:	feb786e3          	beq	a5,a1,80002e34 <sd_send_command+0xa0>
        }
        ++count;   
    }

    // CMD58 has a R3 response
    if(cmd == CMD58_READ_OCR && response == 0x00) {
80002e4c:	03a00713          	li	a4,58
80002e50:	0ae50063          	beq	a0,a4,80002ef0 <sd_send_command+0x15c>
        }
        // Ignore other response bytes for now
        spi_receive();
        spi_receive();
        spi_receive();
    } else if (cmd == CMD8_SEND_IF_COND && response == CMD_OK) {
80002e54:	00800713          	li	a4,8
80002e58:	04e50e63          	beq	a0,a4,80002eb4 <sd_send_command+0x120>
	reg_spimaster_byte = x;			// send
80002e5c:	02000737          	lui	a4,0x2000
80002e60:	0ff00693          	li	a3,255
80002e64:	02d72023          	sw	a3,32(a4) # 2000020 <crtStart-0x7dffffe0>
	return reg_spimaster_byte;		// receive
80002e68:	02072703          	lw	a4,32(a4)

    // Additional 8 clock cycles over SPI
    spi_send(0xFF);

    return response;
}
80002e6c:	00078513          	mv	a0,a5
80002e70:	00008067          	ret
80002e74:	00100713          	li	a4,1
80002e78:	00f717b3          	sll	a5,a4,a5
80002e7c:	00018737          	lui	a4,0x18
80002e80:	08170713          	addi	a4,a4,129 # 18081 <crtStart-0x7ffe7f7f>
80002e84:	00e7f7b3          	and	a5,a5,a4
80002e88:	f20782e3          	beqz	a5,80002dac <sd_send_command+0x18>
		        arg *= 512;
80002e8c:	00959593          	slli	a1,a1,0x9
		        break;
80002e90:	f1dff06f          	j	80002dac <sd_send_command+0x18>
	reg_spimaster_byte = x;			// send
80002e94:	08700713          	li	a4,135
80002e98:	02e7a023          	sw	a4,32(a5)
80002e9c:	0ff00713          	li	a4,255
	return reg_spimaster_byte;		// receive
80002ea0:	0207a683          	lw	a3,32(a5)
	reg_spimaster_byte = x;			// send
80002ea4:	02e7a023          	sw	a4,32(a5)
	return reg_spimaster_byte;		// receive
80002ea8:	0207a783          	lw	a5,32(a5)
80002eac:	0ff7f793          	andi	a5,a5,255
    while((response = spi_receive()) == 0xff) {
80002eb0:	f6e786e3          	beq	a5,a4,80002e1c <sd_send_command+0x88>
    } else if (cmd == CMD8_SEND_IF_COND && response == CMD_OK) {
80002eb4:	00100713          	li	a4,1
80002eb8:	fae792e3          	bne	a5,a4,80002e5c <sd_send_command+0xc8>
	reg_spimaster_byte = x;			// send
80002ebc:	02000737          	lui	a4,0x2000
80002ec0:	0ff00693          	li	a3,255
80002ec4:	02d72023          	sw	a3,32(a4) # 2000020 <crtStart-0x7dffffe0>
	return reg_spimaster_byte;		// receive
80002ec8:	02072603          	lw	a2,32(a4)
	reg_spimaster_byte = x;			// send
80002ecc:	02d72023          	sw	a3,32(a4)
	return reg_spimaster_byte;		// receive
80002ed0:	02072603          	lw	a2,32(a4)
	reg_spimaster_byte = x;			// send
80002ed4:	02d72023          	sw	a3,32(a4)
	return reg_spimaster_byte;		// receive
80002ed8:	02072603          	lw	a2,32(a4)
	reg_spimaster_byte = x;			// send
80002edc:	02d72023          	sw	a3,32(a4)
	return reg_spimaster_byte;		// receive
80002ee0:	02072703          	lw	a4,32(a4)
80002ee4:	f79ff06f          	j	80002e5c <sd_send_command+0xc8>
    if(cmd == CMD58_READ_OCR && response == 0x00) {
80002ee8:	03a00713          	li	a4,58
80002eec:	f6e518e3          	bne	a0,a4,80002e5c <sd_send_command+0xc8>
80002ef0:	f60796e3          	bnez	a5,80002e5c <sd_send_command+0xc8>
	reg_spimaster_byte = x;			// send
80002ef4:	02000737          	lui	a4,0x2000
80002ef8:	0ff00613          	li	a2,255
80002efc:	02c72023          	sw	a2,32(a4) # 2000020 <crtStart-0x7dffffe0>
	return reg_spimaster_byte;		// receive
80002f00:	02072683          	lw	a3,32(a4)
}
80002f04:	00078513          	mv	a0,a5
        if(status & OCR_SHDC_FLAG) {
80002f08:	0066d693          	srli	a3,a3,0x6
80002f0c:	0016f693          	andi	a3,a3,1
80002f10:	c6d1a623          	sw	a3,-916(gp) # 8000efdc <sdhc_card>
	reg_spimaster_byte = x;			// send
80002f14:	02c72023          	sw	a2,32(a4)
	return reg_spimaster_byte;		// receive
80002f18:	02072683          	lw	a3,32(a4)
	reg_spimaster_byte = x;			// send
80002f1c:	02c72023          	sw	a2,32(a4)
	return reg_spimaster_byte;		// receive
80002f20:	02072683          	lw	a3,32(a4)
	reg_spimaster_byte = x;			// send
80002f24:	02c72023          	sw	a2,32(a4)
	return reg_spimaster_byte;		// receive
80002f28:	02072703          	lw	a4,32(a4)
	reg_spimaster_byte = x;			// send
80002f2c:	0ff00693          	li	a3,255
80002f30:	02000737          	lui	a4,0x2000
80002f34:	02d72023          	sw	a3,32(a4) # 2000020 <crtStart-0x7dffffe0>
	return reg_spimaster_byte;		// receive
80002f38:	02072703          	lw	a4,32(a4)
}
80002f3c:	00008067          	ret

80002f40 <sd_init>:

int flag;

int sd_init() {
80002f40:	ff010113          	addi	sp,sp,-16
	reg_spimaster_byte = x;			// send
80002f44:	02000737          	lui	a4,0x2000
int sd_init() {
80002f48:	00112623          	sw	ra,12(sp)
80002f4c:	00812423          	sw	s0,8(sp)
80002f50:	00912223          	sw	s1,4(sp)
80002f54:	01212023          	sw	s2,0(sp)
80002f58:	00a00793          	li	a5,10
	reg_spimaster_byte = x;			// send
80002f5c:	02070713          	addi	a4,a4,32 # 2000020 <crtStart-0x7dffffe0>
80002f60:	0ff00693          	li	a3,255
80002f64:	00d72023          	sw	a3,0(a4)
	return reg_spimaster_byte;		// receive
80002f68:	00072603          	lw	a2,0(a4)
80002f6c:	fff78793          	addi	a5,a5,-1
    int retries = 0;
    uint8_t response = 0xFF;
    uint8_t sd_version;

    // 74 or more clock pulses to SCLK
    for (int i = 0; i < 10; i++)
80002f70:	fe079ae3          	bnez	a5,80002f64 <sd_init+0x24>
        spi_send(0xff);

    retries = 0;
    do {
        response = sd_send_command(CMD0_GO_IDLE_STATE, 0);
80002f74:	00000593          	li	a1,0
80002f78:	00000513          	li	a0,0
80002f7c:	e19ff0ef          	jal	ra,80002d94 <sd_send_command>
80002f80:	00050493          	mv	s1,a0
80002f84:	00900413          	li	s0,9
        if(retries++ > 8) {
            DEBUG("SD init failure: CMD0\n");
            return -1;
        }
    } while(response != CMD_OK);
80002f88:	00100913          	li	s2,1
        response = sd_send_command(CMD0_GO_IDLE_STATE, 0);
80002f8c:	00000593          	li	a1,0
80002f90:	00000513          	li	a0,0
80002f94:	fff40413          	addi	s0,s0,-1
    } while(response != CMD_OK);
80002f98:	03248c63          	beq	s1,s2,80002fd0 <sd_init+0x90>
        response = sd_send_command(CMD0_GO_IDLE_STATE, 0);
80002f9c:	df9ff0ef          	jal	ra,80002d94 <sd_send_command>
80002fa0:	00050493          	mv	s1,a0
        if(retries++ > 8) {
80002fa4:	fe0414e3          	bnez	s0,80002f8c <sd_init+0x4c>
            DEBUG("SD init failure: CMD0\n");
80002fa8:	8000e537          	lui	a0,0x8000e
80002fac:	27050513          	addi	a0,a0,624 # 8000e270 <STACK_TOP+0xfffee270>
80002fb0:	c88ff0ef          	jal	ra,80002438 <uart_printf>
            return -1;
80002fb4:	fff00513          	li	a0,-1
       sdhc_card = 0;
    }

    DEBUG("SD init complete. sdhc_card=%d, sd_version=%d\n", sdhc_card, sd_version);
    return 0;
}
80002fb8:	00c12083          	lw	ra,12(sp)
80002fbc:	00812403          	lw	s0,8(sp)
80002fc0:	00412483          	lw	s1,4(sp)
80002fc4:	00012903          	lw	s2,0(sp)
80002fc8:	01010113          	addi	sp,sp,16
80002fcc:	00008067          	ret
	reg_spimaster_byte = x;			// send
80002fd0:	020007b7          	lui	a5,0x2000
80002fd4:	0ff00713          	li	a4,255
80002fd8:	02e7a023          	sw	a4,32(a5) # 2000020 <crtStart-0x7dffffe0>
	return reg_spimaster_byte;		// receive
80002fdc:	0207a683          	lw	a3,32(a5)
	reg_spimaster_byte = x;			// send
80002fe0:	02e7a023          	sw	a4,32(a5)
	return reg_spimaster_byte;		// receive
80002fe4:	0207a783          	lw	a5,32(a5)
        response = sd_send_command(CMD8_SEND_IF_COND, CMD8_3V3_MODE_ARG);
80002fe8:	1aa00593          	li	a1,426
    flag = 1;
80002fec:	800117b7          	lui	a5,0x80011
        response = sd_send_command(CMD8_SEND_IF_COND, CMD8_3V3_MODE_ARG);
80002ff0:	00800513          	li	a0,8
    flag = 1;
80002ff4:	6097a623          	sw	s1,1548(a5) # 8001160c <STACK_TOP+0xffff160c>
        response = sd_send_command(CMD8_SEND_IF_COND, CMD8_3V3_MODE_ARG);
80002ff8:	d9dff0ef          	jal	ra,80002d94 <sd_send_command>
80002ffc:	00900413          	li	s0,9
    } while(response != CMD_OK);
80003000:	00100913          	li	s2,1
        response = sd_send_command(CMD8_SEND_IF_COND, CMD8_3V3_MODE_ARG);
80003004:	00050793          	mv	a5,a0
80003008:	1aa00593          	li	a1,426
8000300c:	00800513          	li	a0,8
80003010:	fff40413          	addi	s0,s0,-1
    } while(response != CMD_OK);
80003014:	0f278263          	beq	a5,s2,800030f8 <sd_init+0x1b8>
        response = sd_send_command(CMD8_SEND_IF_COND, CMD8_3V3_MODE_ARG);
80003018:	d7dff0ef          	jal	ra,80002d94 <sd_send_command>
8000301c:	00050793          	mv	a5,a0
        if(retries++ > 8) {
80003020:	fe0414e3          	bnez	s0,80003008 <sd_init+0xc8>
        response = sd_send_command(CMD55_APP_CMD,0);
80003024:	00000593          	li	a1,0
80003028:	03700513          	li	a0,55
8000302c:	d69ff0ef          	jal	ra,80002d94 <sd_send_command>
        response = sd_send_command(ACMD41_SD_SEND_OP_COND, ACMD41_HOST_SUPPORTS_SDHC);
80003030:	400005b7          	lui	a1,0x40000
80003034:	02900513          	li	a0,41
80003038:	d5dff0ef          	jal	ra,80002d94 <sd_send_command>
8000303c:	00050793          	mv	a5,a0
        if(retries++ > 128) {
80003040:	00100413          	li	s0,1
80003044:	08200913          	li	s2,130
80003048:	0200006f          	j	80003068 <sd_init+0x128>
        response = sd_send_command(CMD55_APP_CMD,0);
8000304c:	d49ff0ef          	jal	ra,80002d94 <sd_send_command>
        response = sd_send_command(ACMD41_SD_SEND_OP_COND, ACMD41_HOST_SUPPORTS_SDHC);
80003050:	400005b7          	lui	a1,0x40000
80003054:	02900513          	li	a0,41
80003058:	d3dff0ef          	jal	ra,80002d94 <sd_send_command>
        if(retries++ > 128) {
8000305c:	00140413          	addi	s0,s0,1
        response = sd_send_command(ACMD41_SD_SEND_OP_COND, ACMD41_HOST_SUPPORTS_SDHC);
80003060:	00050793          	mv	a5,a0
        if(retries++ > 128) {
80003064:	09240e63          	beq	s0,s2,80003100 <sd_init+0x1c0>
        response = sd_send_command(CMD55_APP_CMD,0);
80003068:	00000593          	li	a1,0
8000306c:	03700513          	li	a0,55
    } while(response != 0x00);
80003070:	fc079ee3          	bnez	a5,8000304c <sd_init+0x10c>
    DEBUG("ACMD41 succeeded after %d tries.\n", retries);
80003074:	8000e537          	lui	a0,0x8000e
80003078:	00040593          	mv	a1,s0
8000307c:	2a850513          	addi	a0,a0,680 # 8000e2a8 <STACK_TOP+0xfffee2a8>
80003080:	bb8ff0ef          	jal	ra,80002438 <uart_printf>
    if (sd_version == 2) {
80003084:	00200793          	li	a5,2
80003088:	02f48c63          	beq	s1,a5,800030c0 <sd_init+0x180>
       sdhc_card = 0;
8000308c:	c601a623          	sw	zero,-916(gp) # 8000efdc <sdhc_card>
80003090:	00000593          	li	a1,0
    DEBUG("SD init complete. sdhc_card=%d, sd_version=%d\n", sdhc_card, sd_version);
80003094:	8000e537          	lui	a0,0x8000e
80003098:	00048613          	mv	a2,s1
8000309c:	2cc50513          	addi	a0,a0,716 # 8000e2cc <STACK_TOP+0xfffee2cc>
800030a0:	b98ff0ef          	jal	ra,80002438 <uart_printf>
}
800030a4:	00c12083          	lw	ra,12(sp)
800030a8:	00812403          	lw	s0,8(sp)
800030ac:	00412483          	lw	s1,4(sp)
800030b0:	00012903          	lw	s2,0(sp)
    return 0;
800030b4:	00000513          	li	a0,0
}
800030b8:	01010113          	addi	sp,sp,16
800030bc:	00008067          	ret
	        response = sd_send_command(CMD58_READ_OCR, 0);
800030c0:	00000593          	li	a1,0
800030c4:	03a00513          	li	a0,58
800030c8:	ccdff0ef          	jal	ra,80002d94 <sd_send_command>
800030cc:	00050793          	mv	a5,a0
800030d0:	00900413          	li	s0,9
800030d4:	00000593          	li	a1,0
800030d8:	03a00513          	li	a0,58
800030dc:	fff40413          	addi	s0,s0,-1
        } while(response != 0x00);
800030e0:	00078863          	beqz	a5,800030f0 <sd_init+0x1b0>
	        response = sd_send_command(CMD58_READ_OCR, 0);
800030e4:	cb1ff0ef          	jal	ra,80002d94 <sd_send_command>
800030e8:	00050793          	mv	a5,a0
	        if(retries++ > 8)
800030ec:	fe0414e3          	bnez	s0,800030d4 <sd_init+0x194>
800030f0:	c6c1a583          	lw	a1,-916(gp) # 8000efdc <sdhc_card>
800030f4:	fa1ff06f          	j	80003094 <sd_init+0x154>
    sd_version = 2; 
800030f8:	00200493          	li	s1,2
800030fc:	f29ff06f          	j	80003024 <sd_init+0xe4>
            DEBUG("SD init failure: ACMD41, %d\n", response);
80003100:	00050593          	mv	a1,a0
80003104:	8000e537          	lui	a0,0x8000e
80003108:	28850513          	addi	a0,a0,648 # 8000e288 <STACK_TOP+0xfffee288>
8000310c:	b2cff0ef          	jal	ra,80002438 <uart_printf>
	        return -2;
80003110:	ffe00513          	li	a0,-2
80003114:	ea5ff06f          	j	80002fb8 <sd_init+0x78>

80003118 <debug_print_buf>:

void debug_print_buf(uint8_t *buf, int len) {
80003118:	ff010113          	addi	sp,sp,-16
8000311c:	00112623          	sw	ra,12(sp)
80003120:	00812423          	sw	s0,8(sp)
80003124:	00912223          	sw	s1,4(sp)
80003128:	00050413          	mv	s0,a0
        }
        uart_print(" ");
        uart_print_hex_digits(buf[i], 2);
    }
#else 
    uart_print_hex_digits(buf[0], 2);
8000312c:	00054503          	lbu	a0,0(a0)
80003130:	00200593          	li	a1,2
    uart_print(" ");
80003134:	8000e4b7          	lui	s1,0x8000e
    uart_print_hex_digits(buf[0], 2);
80003138:	d69fe0ef          	jal	ra,80001ea0 <uart_print_hex_digits>
    uart_print(" ");
8000313c:	30048513          	addi	a0,s1,768 # 8000e300 <STACK_TOP+0xfffee300>
80003140:	ad4ff0ef          	jal	ra,80002414 <uart_print>
    uart_print_hex_digits(buf[1], 2);
80003144:	00144503          	lbu	a0,1(s0)
80003148:	00200593          	li	a1,2
8000314c:	d55fe0ef          	jal	ra,80001ea0 <uart_print_hex_digits>
    uart_print(" ... ");
80003150:	8000e537          	lui	a0,0x8000e
80003154:	2fc50513          	addi	a0,a0,764 # 8000e2fc <STACK_TOP+0xfffee2fc>
80003158:	abcff0ef          	jal	ra,80002414 <uart_print>
    uart_print_hex_digits(buf[510], 2);
8000315c:	1fe44503          	lbu	a0,510(s0)
80003160:	00200593          	li	a1,2
80003164:	d3dfe0ef          	jal	ra,80001ea0 <uart_print_hex_digits>
    uart_print(" ");
80003168:	30048513          	addi	a0,s1,768
8000316c:	aa8ff0ef          	jal	ra,80002414 <uart_print>
    uart_print_hex_digits(buf[511], 2);
80003170:	1ff44503          	lbu	a0,511(s0)
80003174:	00200593          	li	a1,2
80003178:	d29fe0ef          	jal	ra,80001ea0 <uart_print_hex_digits>
#endif
    uart_print("\n");
}
8000317c:	00812403          	lw	s0,8(sp)
80003180:	00c12083          	lw	ra,12(sp)
80003184:	00412483          	lw	s1,4(sp)
    uart_print("\n");
80003188:	8000e537          	lui	a0,0x8000e
8000318c:	0b050513          	addi	a0,a0,176 # 8000e0b0 <STACK_TOP+0xfffee0b0>
}
80003190:	01010113          	addi	sp,sp,16
    uart_print("\n");
80003194:	a80ff06f          	j	80002414 <uart_print>

80003198 <sd_readsector>:
int sd_readsector(uint32_t start_block, uint8_t *buffer, uint32_t sector_count) {
    uint8_t response;
    int retries = 0;

    // DEBUG("sd_readsector: %d %d\n", start_block, sector_count);
    if (sector_count == 0)
80003198:	10060e63          	beqz	a2,800032b4 <sd_readsector+0x11c>
int sd_readsector(uint32_t start_block, uint8_t *buffer, uint32_t sector_count) {
8000319c:	fd010113          	addi	sp,sp,-48
800031a0:	02912223          	sw	s1,36(sp)
        }

        // Wait for start of block indicator
        while(spi_receive() != CMD_START_OF_BLOCK) {
            // Timeout
            if(retries > 5000) {
800031a4:	000014b7          	lui	s1,0x1
int sd_readsector(uint32_t start_block, uint8_t *buffer, uint32_t sector_count) {
800031a8:	02812423          	sw	s0,40(sp)
800031ac:	03212023          	sw	s2,32(sp)
800031b0:	01312e23          	sw	s3,28(sp)
800031b4:	01412c23          	sw	s4,24(sp)
800031b8:	01512a23          	sw	s5,20(sp)
800031bc:	01612823          	sw	s6,16(sp)
800031c0:	01712623          	sw	s7,12(sp)
800031c4:	01812423          	sw	s8,8(sp)
800031c8:	01912223          	sw	s9,4(sp)
            if(retries > 5000) {
800031cc:	38848b13          	addi	s6,s1,904 # 1388 <crtStart-0x7fffec78>
int sd_readsector(uint32_t start_block, uint8_t *buffer, uint32_t sector_count) {
800031d0:	02112623          	sw	ra,44(sp)
800031d4:	00050b93          	mv	s7,a0
800031d8:	00058a93          	mv	s5,a1
800031dc:	00a60a33          	add	s4,a2,a0
    int retries = 0;
800031e0:	00000413          	li	s0,0
	reg_spimaster_byte = x;			// send
800031e4:	02000c37          	lui	s8,0x2000
800031e8:	0ff00c93          	li	s9,255
        while(spi_receive() != CMD_START_OF_BLOCK) {
800031ec:	0fe00913          	li	s2,254
	reg_spimaster_byte = x;			// send
800031f0:	0ff00993          	li	s3,255
            if(retries > 5000) {
800031f4:	38948493          	addi	s1,s1,905
        response = sd_send_command(CMD17_READ_SINGLE_BLOCK, start_block++);
800031f8:	000b8593          	mv	a1,s7
800031fc:	01100513          	li	a0,17
80003200:	001b8b93          	addi	s7,s7,1
80003204:	b91ff0ef          	jal	ra,80002d94 <sd_send_command>
        if(response != 0x00) {
80003208:	06051a63          	bnez	a0,8000327c <sd_readsector+0xe4>
	reg_spimaster_byte = x;			// send
8000320c:	039c2023          	sw	s9,32(s8) # 2000020 <crtStart-0x7dffffe0>
	return reg_spimaster_byte;		// receive
80003210:	020c2783          	lw	a5,32(s8)
	reg_spimaster_byte = x;			// send
80003214:	020c0713          	addi	a4,s8,32
        while(spi_receive() != CMD_START_OF_BLOCK) {
80003218:	0ff7f793          	andi	a5,a5,255
8000321c:	03278263          	beq	a5,s2,80003240 <sd_readsector+0xa8>
            if(retries > 5000) {
80003220:	008b5663          	bge	s6,s0,8000322c <sd_readsector+0x94>
80003224:	0580006f          	j	8000327c <sd_readsector+0xe4>
80003228:	04940a63          	beq	s0,s1,8000327c <sd_readsector+0xe4>
	reg_spimaster_byte = x;			// send
8000322c:	01372023          	sw	s3,0(a4)
	return reg_spimaster_byte;		// receive
80003230:	00072783          	lw	a5,0(a4)
                // DEBUG("sd_readsector: Timeout\n");
                return 0;
            }
            ++retries;
80003234:	00140413          	addi	s0,s0,1
        while(spi_receive() != CMD_START_OF_BLOCK) {
80003238:	0ff7f793          	andi	a5,a5,255
8000323c:	ff2796e3          	bne	a5,s2,80003228 <sd_readsector+0x90>
        }

        // Perform block read (512 bytes)
        spi_readblock(buffer, 512);
80003240:	000a8513          	mv	a0,s5
80003244:	20000593          	li	a1,512
80003248:	a65ff0ef          	jal	ra,80002cac <spi_readblock>
	reg_spimaster_byte = x;			// send
8000324c:	039c2023          	sw	s9,32(s8)
	return reg_spimaster_byte;		// receive
80003250:	020c2783          	lw	a5,32(s8)
	reg_spimaster_byte = x;			// send
80003254:	039c2023          	sw	s9,32(s8)
	return reg_spimaster_byte;		// receive
80003258:	020c2783          	lw	a5,32(s8)
	reg_spimaster_byte = x;			// send
8000325c:	039c2023          	sw	s9,32(s8)
	return reg_spimaster_byte;		// receive
80003260:	020c2783          	lw	a5,32(s8)
	reg_spimaster_byte = x;			// send
80003264:	039c2023          	sw	s9,32(s8)
	return reg_spimaster_byte;		// receive
80003268:	020c2783          	lw	a5,32(s8)

        // DEBUG("sector: %d\n", start_block-1);
        // debug_print_buf(buffer, 512);

        buffer += 512;
8000326c:	200a8a93          	addi	s5,s5,512
    while (sector_count--) {
80003270:	f94b94e3          	bne	s7,s4,800031f8 <sd_readsector+0x60>
        // Additional 8 SPI clocks
        spi_sendrecv(0xFF);
        // DEBUG("sd_readsector: additional 8 spi clocks over\n");
    }
    // DEBUG("sd_readsector: return\n");
    return 1;
80003274:	00100513          	li	a0,1
80003278:	0080006f          	j	80003280 <sd_readsector+0xe8>
        return 0;
8000327c:	00000513          	li	a0,0
}
80003280:	02c12083          	lw	ra,44(sp)
80003284:	02812403          	lw	s0,40(sp)
80003288:	02412483          	lw	s1,36(sp)
8000328c:	02012903          	lw	s2,32(sp)
80003290:	01c12983          	lw	s3,28(sp)
80003294:	01812a03          	lw	s4,24(sp)
80003298:	01412a83          	lw	s5,20(sp)
8000329c:	01012b03          	lw	s6,16(sp)
800032a0:	00c12b83          	lw	s7,12(sp)
800032a4:	00812c03          	lw	s8,8(sp)
800032a8:	00412c83          	lw	s9,4(sp)
800032ac:	03010113          	addi	sp,sp,48
800032b0:	00008067          	ret
        return 0;
800032b4:	00000513          	li	a0,0
}
800032b8:	00008067          	ret

800032bc <sd_writesector>:

int sd_writesector(uint32_t start_block, const uint8_t *buffer, uint32_t sector_count) {
800032bc:	fd010113          	addi	sp,sp,-48
800032c0:	03212023          	sw	s2,32(sp)
800032c4:	00050913          	mv	s2,a0
    uint8_t response;
    int retries = 0;

    DEBUG("sd_writesector: %d %d\n", start_block, sector_count);
800032c8:	8000e537          	lui	a0,0x8000e
int sd_writesector(uint32_t start_block, const uint8_t *buffer, uint32_t sector_count) {
800032cc:	01312e23          	sw	s3,28(sp)
800032d0:	01412c23          	sw	s4,24(sp)
800032d4:	01712623          	sw	s7,12(sp)
800032d8:	00060993          	mv	s3,a2
        }

        // Wait for data write complete
        while(spi_sendrecv(0xFF) == 0) {
            // Timeout
	        if(retries > 5000) {
800032dc:	00001bb7          	lui	s7,0x1
int sd_writesector(uint32_t start_block, const uint8_t *buffer, uint32_t sector_count) {
800032e0:	00058a13          	mv	s4,a1
    DEBUG("sd_writesector: %d %d\n", start_block, sector_count);
800032e4:	30450513          	addi	a0,a0,772 # 8000e304 <STACK_TOP+0xfffee304>
800032e8:	00090593          	mv	a1,s2
int sd_writesector(uint32_t start_block, const uint8_t *buffer, uint32_t sector_count) {
800032ec:	02812423          	sw	s0,40(sp)
800032f0:	02912223          	sw	s1,36(sp)
800032f4:	01512a23          	sw	s5,20(sp)
800032f8:	01612823          	sw	s6,16(sp)
800032fc:	01812423          	sw	s8,8(sp)
80003300:	01912223          	sw	s9,4(sp)
80003304:	02112623          	sw	ra,44(sp)
	        if(retries > 5000) {
80003308:	388b8b13          	addi	s6,s7,904 # 1388 <crtStart-0x7fffec78>
    DEBUG("sd_writesector: %d %d\n", start_block, sector_count);
8000330c:	92cff0ef          	jal	ra,80002438 <uart_printf>
    while (sector_count--) {
80003310:	013909b3          	add	s3,s2,s3
    int retries = 0;
80003314:	00000413          	li	s0,0
	reg_spimaster_byte = x;			// send
80003318:	02000c37          	lui	s8,0x2000
8000331c:	0fe00a93          	li	s5,254
80003320:	0ff00c93          	li	s9,255
80003324:	0ff00493          	li	s1,255
	        if(retries > 5000) {
80003328:	389b8b93          	addi	s7,s7,905
    while (sector_count--) {
8000332c:	13390663          	beq	s2,s3,80003458 <sd_writesector+0x19c>
        response = sd_send_command(CMD24_WRITE_SINGLE_BLOCK, start_block++);
80003330:	00090593          	mv	a1,s2
80003334:	01800513          	li	a0,24
80003338:	a5dff0ef          	jal	ra,80002d94 <sd_send_command>
        if(response != 0x00) {
8000333c:	12051263          	bnez	a0,80003460 <sd_writesector+0x1a4>
	reg_spimaster_byte = x;			// send
80003340:	035c2023          	sw	s5,32(s8) # 2000020 <crtStart-0x7dffffe0>
	return reg_spimaster_byte;		// receive
80003344:	020c2783          	lw	a5,32(s8)
        spi_writeblock(buffer, 512);
80003348:	20000593          	li	a1,512
8000334c:	000a0513          	mv	a0,s4
80003350:	9d9ff0ef          	jal	ra,80002d28 <spi_writeblock>
	reg_spimaster_byte = x;			// send
80003354:	039c2023          	sw	s9,32(s8)
	return reg_spimaster_byte;		// receive
80003358:	020c2783          	lw	a5,32(s8)
	reg_spimaster_byte = x;			// send
8000335c:	039c2023          	sw	s9,32(s8)
	return reg_spimaster_byte;		// receive
80003360:	020c2783          	lw	a5,32(s8)
        response = spi_receive(0xFF);
80003364:	0ff00513          	li	a0,255
80003368:	8f9ff0ef          	jal	ra,80002c60 <spi_receive>
        if((response & 0x1f) != CMD_DATA_ACCEPTED) {
8000336c:	01f57693          	andi	a3,a0,31
80003370:	00500713          	li	a4,5
	reg_spimaster_byte = x;			// send
80003374:	020c0793          	addi	a5,s8,32
        if((response & 0x1f) != CMD_DATA_ACCEPTED) {
80003378:	10e69063          	bne	a3,a4,80003478 <sd_writesector+0x1bc>
	reg_spimaster_byte = x;			// send
8000337c:	039c2023          	sw	s9,32(s8)
	return reg_spimaster_byte;		// receive
80003380:	020c2703          	lw	a4,32(s8)
	reg_spimaster_byte = x;			// send
80003384:	039c2023          	sw	s9,32(s8)
	return reg_spimaster_byte;		// receive
80003388:	020c2703          	lw	a4,32(s8)
        while(spi_sendrecv(0xFF) == 0) {
8000338c:	0ff77713          	andi	a4,a4,255
80003390:	02071663          	bnez	a4,800033bc <sd_writesector+0x100>
	        if(retries > 5000) {
80003394:	008b5663          	bge	s6,s0,800033a0 <sd_writesector+0xe4>
80003398:	07c0006f          	j	80003414 <sd_writesector+0x158>
8000339c:	07740c63          	beq	s0,s7,80003414 <sd_writesector+0x158>
	reg_spimaster_byte = x;			// send
800033a0:	0097a023          	sw	s1,0(a5)
	return reg_spimaster_byte;		// receive
800033a4:	0007a703          	lw	a4,0(a5)
	reg_spimaster_byte = x;			// send
800033a8:	0097a023          	sw	s1,0(a5)
	return reg_spimaster_byte;		// receive
800033ac:	0007a703          	lw	a4,0(a5)
                DEBUG("sd_writesector: Timeout\n");
                return 0;
            }
	        ++retries;
800033b0:	00140413          	addi	s0,s0,1
        while(spi_sendrecv(0xFF) == 0) {
800033b4:	0ff77713          	andi	a4,a4,255
800033b8:	fe0702e3          	beqz	a4,8000339c <sd_writesector+0xe0>
	reg_spimaster_byte = x;			// send
800033bc:	039c2023          	sw	s9,32(s8)
	return reg_spimaster_byte;		// receive
800033c0:	020c2783          	lw	a5,32(s8)
	reg_spimaster_byte = x;			// send
800033c4:	039c2023          	sw	s9,32(s8)
	return reg_spimaster_byte;		// receive
800033c8:	020c2783          	lw	a5,32(s8)
	reg_spimaster_byte = x;			// send
800033cc:	039c2023          	sw	s9,32(s8)
	return reg_spimaster_byte;		// receive
800033d0:	020c2703          	lw	a4,32(s8)
	reg_spimaster_byte = x;			// send
800033d4:	020c0793          	addi	a5,s8,32
        }

        // Additional 8 SPI clocks
        spi_send(0xff);

	    retries = 0;
800033d8:	00000413          	li	s0,0
	
        // Wait for data write complete
        while(spi_sendrecv(0xFF) == 0) {
800033dc:	0ff77713          	andi	a4,a4,255
800033e0:	00070663          	beqz	a4,800033ec <sd_writesector+0x130>
800033e4:	0240006f          	j	80003408 <sd_writesector+0x14c>
            // Timeout
            if(retries > 5000) {
800033e8:	03740663          	beq	s0,s7,80003414 <sd_writesector+0x158>
	reg_spimaster_byte = x;			// send
800033ec:	0097a023          	sw	s1,0(a5)
	return reg_spimaster_byte;		// receive
800033f0:	0007a703          	lw	a4,0(a5)
	reg_spimaster_byte = x;			// send
800033f4:	0097a023          	sw	s1,0(a5)
	return reg_spimaster_byte;		// receive
800033f8:	0007a703          	lw	a4,0(a5)
                DEBUG("sd_writesector: Timeout\n");
                return 0;
            }
            ++retries;
800033fc:	00140413          	addi	s0,s0,1
        while(spi_sendrecv(0xFF) == 0) {
80003400:	0ff77713          	andi	a4,a4,255
80003404:	fe0702e3          	beqz	a4,800033e8 <sd_writesector+0x12c>
        response = sd_send_command(CMD24_WRITE_SINGLE_BLOCK, start_block++);
80003408:	00190913          	addi	s2,s2,1
        buffer += 512;
8000340c:	200a0a13          	addi	s4,s4,512
80003410:	f1dff06f          	j	8000332c <sd_writesector+0x70>
                DEBUG("sd_writesector: Timeout\n");
80003414:	8000e537          	lui	a0,0x8000e
80003418:	36450513          	addi	a0,a0,868 # 8000e364 <STACK_TOP+0xfffee364>
8000341c:	81cff0ef          	jal	ra,80002438 <uart_printf>
                return 0;
80003420:	00000513          	li	a0,0
        }
    }
    return 1;
}
80003424:	02c12083          	lw	ra,44(sp)
80003428:	02812403          	lw	s0,40(sp)
8000342c:	02412483          	lw	s1,36(sp)
80003430:	02012903          	lw	s2,32(sp)
80003434:	01c12983          	lw	s3,28(sp)
80003438:	01812a03          	lw	s4,24(sp)
8000343c:	01412a83          	lw	s5,20(sp)
80003440:	01012b03          	lw	s6,16(sp)
80003444:	00c12b83          	lw	s7,12(sp)
80003448:	00812c03          	lw	s8,8(sp)
8000344c:	00412c83          	lw	s9,4(sp)
80003450:	03010113          	addi	sp,sp,48
80003454:	00008067          	ret
    return 1;
80003458:	00100513          	li	a0,1
8000345c:	fc9ff06f          	j	80003424 <sd_writesector+0x168>
            DEBUG("sd_writesector: Bad response %x\n", response);
80003460:	00050593          	mv	a1,a0
80003464:	8000e537          	lui	a0,0x8000e
80003468:	31c50513          	addi	a0,a0,796 # 8000e31c <STACK_TOP+0xfffee31c>
8000346c:	fcdfe0ef          	jal	ra,80002438 <uart_printf>
            return 0;
80003470:	00000513          	li	a0,0
80003474:	fb1ff06f          	j	80003424 <sd_writesector+0x168>
            DEBUG("sd_writesector: Data rejected %x\n", response);
80003478:	00050593          	mv	a1,a0
8000347c:	8000e537          	lui	a0,0x8000e
80003480:	34050513          	addi	a0,a0,832 # 8000e340 <STACK_TOP+0xfffee340>
80003484:	fb5fe0ef          	jal	ra,80002438 <uart_printf>
            return 0;
80003488:	00000513          	li	a0,0
8000348c:	f99ff06f          	j	80003424 <sd_writesector+0x168>

80003490 <disk_status>:

DSTATUS disk_status (
	BYTE pdrv		/* Physical drive nmuber to identify the drive */
)
{
	switch (pdrv) {
80003490:	00051863          	bnez	a0,800034a0 <disk_status+0x10>
	case DEV_SD :
		if (sd_initialized)
80003494:	c701a503          	lw	a0,-912(gp) # 8000efe0 <sd_initialized>
			return 0;		// success
80003498:	00153513          	seqz	a0,a0
8000349c:	00008067          	ret
		else
			return STA_NOINIT;
	}
	return STA_NOINIT;
800034a0:	00100513          	li	a0,1
}
800034a4:	00008067          	ret

800034a8 <disk_initialize>:
	BYTE pdrv				/* Physical drive nmuber to identify the drive */
)
{
	// print("disk_initialize\n");

	switch (pdrv) {
800034a8:	00050663          	beqz	a0,800034b4 <disk_initialize+0xc>
			print("Cannot initialize sd\n");
			sd_initialized = 0;
			return STA_NOINIT;
		}
	}
	return STA_NOINIT;
800034ac:	00100513          	li	a0,1
}
800034b0:	00008067          	ret
{
800034b4:	ff010113          	addi	sp,sp,-16
800034b8:	00112623          	sw	ra,12(sp)
		if (sd_init() == 0) {
800034bc:	a85ff0ef          	jal	ra,80002f40 <sd_init>
800034c0:	00051c63          	bnez	a0,800034d8 <disk_initialize+0x30>
}
800034c4:	00c12083          	lw	ra,12(sp)
			sd_initialized = 1;
800034c8:	00100713          	li	a4,1
800034cc:	c6e1a823          	sw	a4,-912(gp) # 8000efe0 <sd_initialized>
}
800034d0:	01010113          	addi	sp,sp,16
800034d4:	00008067          	ret
			print("Cannot initialize sd\n");
800034d8:	8000e537          	lui	a0,0x8000e
800034dc:	38050513          	addi	a0,a0,896 # 8000e380 <STACK_TOP+0xfffee380>
800034e0:	829fe0ef          	jal	ra,80001d08 <print>
}
800034e4:	00c12083          	lw	ra,12(sp)
			sd_initialized = 0;
800034e8:	c601a823          	sw	zero,-912(gp) # 8000efe0 <sd_initialized>
			return STA_NOINIT;
800034ec:	00100513          	li	a0,1
}
800034f0:	01010113          	addi	sp,sp,16
800034f4:	00008067          	ret

800034f8 <disk_read>:
	BYTE *buff,		/* Data buffer to store read data */
	LBA_t sector,	/* Start sector in LBA */
	UINT count		/* Number of sectors to read */
)
{
	switch (pdrv) {
800034f8:	02051c63          	bnez	a0,80003530 <disk_read+0x38>
	case DEV_SD :
		if (!sd_initialized)
800034fc:	c701a783          	lw	a5,-912(gp) # 8000efe0 <sd_initialized>
			return RES_NOTRDY;
80003500:	00300513          	li	a0,3
		if (!sd_initialized)
80003504:	02078463          	beqz	a5,8000352c <disk_read+0x34>
{
80003508:	ff010113          	addi	sp,sp,-16
8000350c:	00060513          	mv	a0,a2
		if (sd_readsector(sector, buff, count))
80003510:	00068613          	mv	a2,a3
{
80003514:	00112623          	sw	ra,12(sp)
		if (sd_readsector(sector, buff, count))
80003518:	c81ff0ef          	jal	ra,80003198 <sd_readsector>
			return RES_OK;		// return 1 for success
		else
			return RES_ERROR;
	}
	return RES_PARERR;
}
8000351c:	00c12083          	lw	ra,12(sp)
		if (sd_readsector(sector, buff, count))
80003520:	00153513          	seqz	a0,a0
}
80003524:	01010113          	addi	sp,sp,16
80003528:	00008067          	ret
8000352c:	00008067          	ret
	return RES_PARERR;
80003530:	00400513          	li	a0,4
80003534:	00008067          	ret

80003538 <disk_write>:
	const BYTE *buff,	/* Data to be written */
	LBA_t sector,		/* Start sector in LBA */
	UINT count			/* Number of sectors to write */
)
{
	switch (pdrv) {
80003538:	02051c63          	bnez	a0,80003570 <disk_write+0x38>
	case DEV_SD :
		if (!sd_initialized)
8000353c:	c701a783          	lw	a5,-912(gp) # 8000efe0 <sd_initialized>
			return RES_NOTRDY;
80003540:	00300513          	li	a0,3
		if (!sd_initialized)
80003544:	02078463          	beqz	a5,8000356c <disk_write+0x34>
{
80003548:	ff010113          	addi	sp,sp,-16
8000354c:	00060513          	mv	a0,a2
		if (sd_writesector(sector, buff, count))
80003550:	00068613          	mv	a2,a3
{
80003554:	00112623          	sw	ra,12(sp)
		if (sd_writesector(sector, buff, count))
80003558:	d65ff0ef          	jal	ra,800032bc <sd_writesector>
		else
			return RES_ERROR;
	}

	return RES_PARERR;
}
8000355c:	00c12083          	lw	ra,12(sp)
		if (sd_writesector(sector, buff, count))
80003560:	00153513          	seqz	a0,a0
}
80003564:	01010113          	addi	sp,sp,16
80003568:	00008067          	ret
8000356c:	00008067          	ret
	return RES_PARERR;
80003570:	00400513          	li	a0,4
80003574:	00008067          	ret

80003578 <disk_ioctl>:
	BYTE pdrv,		/* Physical drive nmuber (0..) */
	BYTE cmd,		/* Control code */
	void *buff		/* Buffer to send/receive control data */
)
{
	switch (pdrv) {
80003578:	00051c63          	bnez	a0,80003590 <disk_ioctl+0x18>
	case DEV_SD :
		if (cmd == GET_SECTOR_SIZE)
8000357c:	00200793          	li	a5,2
80003580:	00f58c63          	beq	a1,a5,80003598 <disk_ioctl+0x20>
			return 512;
		else if (cmd == GET_BLOCK_SIZE)
80003584:	ffd58593          	addi	a1,a1,-3 # 3ffffffd <crtStart-0x40000003>
80003588:	0015b513          	seqz	a0,a1
8000358c:	00008067          	ret
			return 1;
		return 0;
	}
	return RES_PARERR;
80003590:	00400513          	li	a0,4
80003594:	00008067          	ret
			return 512;
80003598:	20000513          	li	a0,512
}
8000359c:	00008067          	ret

800035a0 <get_ldnumber>:
	char c;
#endif

	// print("get_ldnumber\n");

	tt = tp = *path;
800035a0:	00052583          	lw	a1,0(a0)
	if (!tp) return vol;	/* Invalid path name? */
800035a4:	02058c63          	beqz	a1,800035dc <get_ldnumber+0x3c>
800035a8:	00058793          	mv	a5,a1
	do {					/* Find a colon in the path */
		tc = *tt++;
	} while (!IsTerminator(tc) && tc != ':');
800035ac:	01f00693          	li	a3,31
800035b0:	03a00613          	li	a2,58
800035b4:	0080006f          	j	800035bc <get_ldnumber+0x1c>
800035b8:	00c70e63          	beq	a4,a2,800035d4 <get_ldnumber+0x34>
		tc = *tt++;
800035bc:	00178793          	addi	a5,a5,1
800035c0:	fff7c703          	lbu	a4,-1(a5)
	} while (!IsTerminator(tc) && tc != ':');
800035c4:	fee6eae3          	bltu	a3,a4,800035b8 <get_ldnumber+0x18>
#if FF_FS_RPATH != 0
	vol = CurrVol;	/* Default drive is current drive */
#else
	vol = 0;		/* Default drive is 0 */
#endif
	return vol;		/* Return the default drive */
800035c8:	00000713          	li	a4,0
}
800035cc:	00070513          	mv	a0,a4
800035d0:	00008067          	ret
		if (IsDigit(*tp) && tp + 2 == tt) {	/* Is there a numeric volume ID + colon? */
800035d4:	00258713          	addi	a4,a1,2
800035d8:	00e78863          	beq	a5,a4,800035e8 <get_ldnumber+0x48>
	if (!tp) return vol;	/* Invalid path name? */
800035dc:	fff00713          	li	a4,-1
}
800035e0:	00070513          	mv	a0,a4
800035e4:	00008067          	ret
		if (i < FF_VOLUMES) {	/* If a volume ID is found, get the drive number and strip it */
800035e8:	0005c603          	lbu	a2,0(a1)
800035ec:	03000693          	li	a3,48
	if (!tp) return vol;	/* Invalid path name? */
800035f0:	fff00713          	li	a4,-1
		if (i < FF_VOLUMES) {	/* If a volume ID is found, get the drive number and strip it */
800035f4:	fcd61ce3          	bne	a2,a3,800035cc <get_ldnumber+0x2c>
			*path = tt;		/* Snip the drive prefix off */
800035f8:	00f52023          	sw	a5,0(a0)
			i = (int)*tp - '0';	/* Get the LD number */
800035fc:	00000713          	li	a4,0
80003600:	fcdff06f          	j	800035cc <get_ldnumber+0x2c>

80003604 <validate>:
)
{
	FRESULT res = FR_INVALID_OBJECT;


	if (obj && obj->fs && obj->fs->fs_type && obj->id == obj->fs->id) {	/* Test if the object is valid */
80003604:	06050663          	beqz	a0,80003670 <validate+0x6c>
80003608:	00052783          	lw	a5,0(a0)
{
8000360c:	fe010113          	addi	sp,sp,-32
80003610:	00812c23          	sw	s0,24(sp)
80003614:	00112e23          	sw	ra,28(sp)
80003618:	00050413          	mv	s0,a0
	if (obj && obj->fs && obj->fs->fs_type && obj->id == obj->fs->id) {	/* Test if the object is valid */
8000361c:	00078c63          	beqz	a5,80003634 <validate+0x30>
80003620:	0007c703          	lbu	a4,0(a5)
80003624:	00070863          	beqz	a4,80003634 <validate+0x30>
80003628:	00455683          	lhu	a3,4(a0)
8000362c:	0067d703          	lhu	a4,6(a5)
80003630:	02e68063          	beq	a3,a4,80003650 <validate+0x4c>
	FRESULT res = FR_INVALID_OBJECT;
80003634:	00900513          	li	a0,9
		if (!(disk_status(obj->fs->pdrv) & STA_NOINIT)) { /* Test if the hosting phsical drive is kept initialized */
			res = FR_OK;
		}
#endif
	}
	*rfs = (res == FR_OK) ? obj->fs : 0;	/* Return corresponding filesystem object if it is valid */
80003638:	00000793          	li	a5,0
	return res;
}
8000363c:	01c12083          	lw	ra,28(sp)
80003640:	01812403          	lw	s0,24(sp)
	*rfs = (res == FR_OK) ? obj->fs : 0;	/* Return corresponding filesystem object if it is valid */
80003644:	00f5a023          	sw	a5,0(a1)
}
80003648:	02010113          	addi	sp,sp,32
8000364c:	00008067          	ret
		if (!(disk_status(obj->fs->pdrv) & STA_NOINIT)) { /* Test if the hosting phsical drive is kept initialized */
80003650:	0017c503          	lbu	a0,1(a5)
80003654:	00b12623          	sw	a1,12(sp)
80003658:	e39ff0ef          	jal	ra,80003490 <disk_status>
8000365c:	00157513          	andi	a0,a0,1
80003660:	00c12583          	lw	a1,12(sp)
80003664:	fc0518e3          	bnez	a0,80003634 <validate+0x30>
	*rfs = (res == FR_OK) ? obj->fs : 0;	/* Return corresponding filesystem object if it is valid */
80003668:	00042783          	lw	a5,0(s0)
8000366c:	fd1ff06f          	j	8000363c <validate+0x38>
80003670:	00000793          	li	a5,0
	FRESULT res = FR_INVALID_OBJECT;
80003674:	00900513          	li	a0,9
	*rfs = (res == FR_OK) ? obj->fs : 0;	/* Return corresponding filesystem object if it is valid */
80003678:	00f5a023          	sw	a5,0(a1)
}
8000367c:	00008067          	ret

80003680 <put_utf>:
{
80003680:	ff010113          	addi	sp,sp,-16
80003684:	00912223          	sw	s1,4(sp)
80003688:	00058493          	mv	s1,a1
	wc = ff_uni2oem(chr, CODEPAGE);
8000368c:	1b500593          	li	a1,437
{
80003690:	00812423          	sw	s0,8(sp)
80003694:	00112623          	sw	ra,12(sp)
80003698:	00060413          	mv	s0,a2
	wc = ff_uni2oem(chr, CODEPAGE);
8000369c:	4a4070ef          	jal	ra,8000ab40 <ff_uni2oem>
	if (wc >= 0x100) {	/* Is this a DBC? */
800036a0:	0ff00713          	li	a4,255
	wc = ff_uni2oem(chr, CODEPAGE);
800036a4:	00050793          	mv	a5,a0
	if (wc >= 0x100) {	/* Is this a DBC? */
800036a8:	04a77463          	bgeu	a4,a0,800036f0 <put_utf+0x70>
		if (szb < 2) return 0;
800036ac:	00100713          	li	a4,1
800036b0:	00000513          	li	a0,0
800036b4:	00876c63          	bltu	a4,s0,800036cc <put_utf+0x4c>
}
800036b8:	00c12083          	lw	ra,12(sp)
800036bc:	00812403          	lw	s0,8(sp)
800036c0:	00412483          	lw	s1,4(sp)
800036c4:	01010113          	addi	sp,sp,16
800036c8:	00008067          	ret
		*buf++ = (char)(wc >> 8);	/* Store DBC 1st byte */
800036cc:	0087d713          	srli	a4,a5,0x8
800036d0:	00e48023          	sb	a4,0(s1)
		*buf++ = (TCHAR)wc;			/* Store DBC 2nd byte */
800036d4:	00f480a3          	sb	a5,1(s1)
}
800036d8:	00c12083          	lw	ra,12(sp)
800036dc:	00812403          	lw	s0,8(sp)
800036e0:	00412483          	lw	s1,4(sp)
		return 2;
800036e4:	00200513          	li	a0,2
}
800036e8:	01010113          	addi	sp,sp,16
800036ec:	00008067          	ret
		if (szb < 2) return 0;
800036f0:	00000513          	li	a0,0
	if (wc == 0 || szb < 1) return 0;	/* Invalid char or buffer overflow? */
800036f4:	fc0782e3          	beqz	a5,800036b8 <put_utf+0x38>
800036f8:	fc0400e3          	beqz	s0,800036b8 <put_utf+0x38>
	*buf++ = (TCHAR)wc;					/* Store the character */
800036fc:	00f48023          	sb	a5,0(s1)
}
80003700:	00c12083          	lw	ra,12(sp)
80003704:	00812403          	lw	s0,8(sp)
80003708:	00412483          	lw	s1,4(sp)
	return 1;
8000370c:	00100513          	li	a0,1
}
80003710:	01010113          	addi	sp,sp,16
80003714:	00008067          	ret

80003718 <get_fileinfo>:
{
80003718:	fd010113          	addi	sp,sp,-48
8000371c:	03212023          	sw	s2,32(sp)
80003720:	02112623          	sw	ra,44(sp)
80003724:	02812423          	sw	s0,40(sp)
80003728:	02912223          	sw	s1,36(sp)
8000372c:	01312e23          	sw	s3,28(sp)
80003730:	01412c23          	sw	s4,24(sp)
80003734:	01512a23          	sw	s5,20(sp)
80003738:	01612823          	sw	s6,16(sp)
8000373c:	01712623          	sw	s7,12(sp)
80003740:	01812423          	sw	s8,8(sp)
	FATFS *fs = dp->obj.fs;
80003744:	00052903          	lw	s2,0(a0)
	fno->fname[0] = 0;			/* Invaidate file info */
80003748:	00058d23          	sb	zero,26(a1)
	if (dp->sect == 0) return;	/* Exit if read pointer has reached end of directory */
8000374c:	03852783          	lw	a5,56(a0)
80003750:	16078c63          	beqz	a5,800038c8 <get_fileinfo+0x1b0>
	if (fs->fs_type == FS_EXFAT) {	/* exFAT volume */
80003754:	00094703          	lbu	a4,0(s2)
80003758:	00400793          	li	a5,4
8000375c:	00058413          	mv	s0,a1
80003760:	00050993          	mv	s3,a0
80003764:	26f70063          	beq	a4,a5,800039c4 <get_fileinfo+0x2ac>
		if (dp->blk_ofs != 0xFFFFFFFF) {	/* Get LFN if available */
80003768:	04c52703          	lw	a4,76(a0)
8000376c:	fff00793          	li	a5,-1
80003770:	00000f13          	li	t5,0
80003774:	08f70863          	beq	a4,a5,80003804 <get_fileinfo+0xec>
80003778:	00c92683          	lw	a3,12(s2)
				if (hs == 0 && IsSurrogate(wc)) {	/* Is it a surrogate? */
8000377c:	00003a37          	lui	s4,0x3
		if (dp->blk_ofs != 0xFFFFFFFF) {	/* Get LFN if available */
80003780:	00000c13          	li	s8,0
			hs = 0;
80003784:	00000b93          	li	s7,0
			si = di = 0;
80003788:	00000493          	li	s1,0
				nw = put_utf((DWORD)hs << 16 | wc, &fno->fname[di], FF_LFN_BUF - di);	/* Store it in API encoding */
8000378c:	0ff00a93          	li	s5,255
				if (hs == 0 && IsSurrogate(wc)) {	/* Is it a surrogate? */
80003790:	800a0a13          	addi	s4,s4,-2048 # 2800 <crtStart-0x7fffd800>
80003794:	7ff00b13          	li	s6,2047
			while (fs->lfnbuf[si] != 0) {
80003798:	018687b3          	add	a5,a3,s8
8000379c:	0007d783          	lhu	a5,0(a5)
				nw = put_utf((DWORD)hs << 16 | wc, &fno->fname[di], FF_LFN_BUF - di);	/* Store it in API encoding */
800037a0:	01a48593          	addi	a1,s1,26
800037a4:	010b9513          	slli	a0,s7,0x10
				if (hs == 0 && IsSurrogate(wc)) {	/* Is it a surrogate? */
800037a8:	01478733          	add	a4,a5,s4
800037ac:	01071713          	slli	a4,a4,0x10
				nw = put_utf((DWORD)hs << 16 | wc, &fno->fname[di], FF_LFN_BUF - di);	/* Store it in API encoding */
800037b0:	409a8633          	sub	a2,s5,s1
800037b4:	00b405b3          	add	a1,s0,a1
800037b8:	00f56533          	or	a0,a0,a5
				if (hs == 0 && IsSurrogate(wc)) {	/* Is it a surrogate? */
800037bc:	01075713          	srli	a4,a4,0x10
			while (fs->lfnbuf[si] != 0) {
800037c0:	02078663          	beqz	a5,800037ec <get_fileinfo+0xd4>
				if (hs == 0 && IsSurrogate(wc)) {	/* Is it a surrogate? */
800037c4:	000b9463          	bnez	s7,800037cc <get_fileinfo+0xb4>
800037c8:	1ceb7663          	bgeu	s6,a4,80003994 <get_fileinfo+0x27c>
				nw = put_utf((DWORD)hs << 16 | wc, &fno->fname[di], FF_LFN_BUF - di);	/* Store it in API encoding */
800037cc:	eb5ff0ef          	jal	ra,80003680 <put_utf>
				if (nw == 0) {				/* Buffer overflow or wrong char? */
800037d0:	00050c63          	beqz	a0,800037e8 <get_fileinfo+0xd0>
				di += nw;
800037d4:	00a484b3          	add	s1,s1,a0
				hs = 0;
800037d8:	00c92683          	lw	a3,12(s2)
800037dc:	00000b93          	li	s7,0
800037e0:	002c0c13          	addi	s8,s8,2
800037e4:	fb5ff06f          	j	80003798 <get_fileinfo+0x80>
					di = 0; break;
800037e8:	00000493          	li	s1,0
			if (hs != 0) di = 0;	/* Broken surrogate pair? */
800037ec:	001bbb93          	seqz	s7,s7
800037f0:	41700bb3          	neg	s7,s7
800037f4:	0174f4b3          	and	s1,s1,s7
			fno->fname[di] = 0;		/* Terminate the LFN (null string means LFN is invalid) */
800037f8:	009404b3          	add	s1,s0,s1
800037fc:	00048d23          	sb	zero,26(s1)
80003800:	01a44f03          	lbu	t5,26(s0)
		wc = dp->dir[si++];			/* Get a char */
80003804:	03c9a583          	lw	a1,60(s3)
80003808:	00000793          	li	a5,0
8000380c:	00000713          	li	a4,0
		if (wc == ' ') continue;	/* Skip padding spaces */
80003810:	02000893          	li	a7,32
		if (wc == RDDEM) wc = DDEM;	/* Restore replaced DDEM character */
80003814:	00500e13          	li	t3,5
		if (si == 9 && di < FF_SFN_BUF) fno->altname[di++] = '.';	/* Insert a . if extension is exist */
80003818:	00900313          	li	t1,9
8000381c:	00b00813          	li	a6,11
80003820:	02e00f93          	li	t6,46
		wc = dp->dir[si++];			/* Get a char */
80003824:	00170713          	addi	a4,a4,1
80003828:	00e586b3          	add	a3,a1,a4
8000382c:	fff6c683          	lbu	a3,-1(a3)
80003830:	00178513          	addi	a0,a5,1
80003834:	01069613          	slli	a2,a3,0x10
80003838:	01065613          	srli	a2,a2,0x10
		if (wc == ' ') continue;	/* Skip padding spaces */
8000383c:	01160c63          	beq	a2,a7,80003854 <get_fileinfo+0x13c>
		if (wc == RDDEM) wc = DDEM;	/* Restore replaced DDEM character */
80003840:	0bc60c63          	beq	a2,t3,800038f8 <get_fileinfo+0x1e0>
		if (si == 9 && di < FF_SFN_BUF) fno->altname[di++] = '.';	/* Insert a . if extension is exist */
80003844:	0a670e63          	beq	a4,t1,80003900 <get_fileinfo+0x1e8>
		fno->altname[di++] = (TCHAR)wc;	/* Store it without any conversion */
80003848:	00f407b3          	add	a5,s0,a5
8000384c:	00d786a3          	sb	a3,13(a5)
80003850:	00050793          	mv	a5,a0
	while (si < 11) {		/* Get SFN from SFN entry */
80003854:	fd0718e3          	bne	a4,a6,80003824 <get_fileinfo+0x10c>
	fno->altname[di] = 0;	/* Terminate the SFN  (null string means SFN is invalid) */
80003858:	00f40733          	add	a4,s0,a5
8000385c:	000706a3          	sb	zero,13(a4)
	if (fno->fname[0] == 0) {	/* If LFN is invalid, altname[] needs to be copied to fname[] */
80003860:	0a0f0e63          	beqz	t5,8000391c <get_fileinfo+0x204>
	fno->fattrib = dp->dir[DIR_Attr] & AM_MASK;			/* Attribute */
80003864:	00b5c783          	lbu	a5,11(a1)
80003868:	03f7f793          	andi	a5,a5,63
8000386c:	00f40623          	sb	a5,12(s0)
	rv = rv << 8 | ptr[2];
80003870:	01f5c783          	lbu	a5,31(a1)
80003874:	01e5c683          	lbu	a3,30(a1)
	rv = rv << 8 | ptr[1];
80003878:	01d5c703          	lbu	a4,29(a1)
	rv = rv << 8 | ptr[2];
8000387c:	00879793          	slli	a5,a5,0x8
80003880:	00d7e7b3          	or	a5,a5,a3
	rv = rv << 8 | ptr[1];
80003884:	00879793          	slli	a5,a5,0x8
	rv = rv << 8 | ptr[0];
80003888:	01c5c683          	lbu	a3,28(a1)
	rv = rv << 8 | ptr[1];
8000388c:	00f767b3          	or	a5,a4,a5
	rv = rv << 8 | ptr[0];
80003890:	00879793          	slli	a5,a5,0x8
80003894:	00f6e7b3          	or	a5,a3,a5
	fno->fsize = ld_dword(dp->dir + DIR_FileSize);		/* Size */
80003898:	00f42023          	sw	a5,0(s0)
8000389c:	00042223          	sw	zero,4(s0)
	rv = rv << 8 | ptr[0];
800038a0:	0175c783          	lbu	a5,23(a1)
800038a4:	0165c703          	lbu	a4,22(a1)
800038a8:	00879793          	slli	a5,a5,0x8
800038ac:	00e7e7b3          	or	a5,a5,a4
	fno->ftime = ld_word(dp->dir + DIR_ModTime + 0);	/* Time */
800038b0:	00f41523          	sh	a5,10(s0)
	rv = rv << 8 | ptr[0];
800038b4:	0195c783          	lbu	a5,25(a1)
800038b8:	0185c703          	lbu	a4,24(a1)
800038bc:	00879793          	slli	a5,a5,0x8
800038c0:	00e7e7b3          	or	a5,a5,a4
	fno->fdate = ld_word(dp->dir + DIR_ModTime + 2);	/* Date */
800038c4:	00f41423          	sh	a5,8(s0)
}
800038c8:	02c12083          	lw	ra,44(sp)
800038cc:	02812403          	lw	s0,40(sp)
800038d0:	02412483          	lw	s1,36(sp)
800038d4:	02012903          	lw	s2,32(sp)
800038d8:	01c12983          	lw	s3,28(sp)
800038dc:	01812a03          	lw	s4,24(sp)
800038e0:	01412a83          	lw	s5,20(sp)
800038e4:	01012b03          	lw	s6,16(sp)
800038e8:	00c12b83          	lw	s7,12(sp)
800038ec:	00812c03          	lw	s8,8(sp)
800038f0:	03010113          	addi	sp,sp,48
800038f4:	00008067          	ret
800038f8:	0e500693          	li	a3,229
		if (si == 9 && di < FF_SFN_BUF) fno->altname[di++] = '.';	/* Insert a . if extension is exist */
800038fc:	f46716e3          	bne	a4,t1,80003848 <get_fileinfo+0x130>
80003900:	00f40eb3          	add	t4,s0,a5
80003904:	00278613          	addi	a2,a5,2
80003908:	f4f860e3          	bltu	a6,a5,80003848 <get_fileinfo+0x130>
8000390c:	00050793          	mv	a5,a0
80003910:	01fe86a3          	sb	t6,13(t4)
80003914:	00060513          	mv	a0,a2
80003918:	f31ff06f          	j	80003848 <get_fileinfo+0x130>
		if (di == 0) {	/* If LFN and SFN both are invalid, this object is inaccessible */
8000391c:	08078263          	beqz	a5,800039a0 <get_fileinfo+0x288>
			for (si = di = 0, lcf = NS_BODY; fno->altname[si]; si++, di++) {	/* Copy altname[] to fname[] with case information */
80003920:	00d44783          	lbu	a5,13(s0)
80003924:	00e40713          	addi	a4,s0,14
80003928:	00800893          	li	a7,8
8000392c:	24078463          	beqz	a5,80003b74 <get_fileinfo+0x45c>
80003930:	ff300513          	li	a0,-13
				if (wc == '.') lcf = NS_EXT;
80003934:	02e00813          	li	a6,46
				if (IsUpper(wc) && (dp->dir[DIR_NTres] & lcf)) wc += 0x20;
80003938:	01900313          	li	t1,25
8000393c:	40850533          	sub	a0,a0,s0
80003940:	0300006f          	j	80003970 <get_fileinfo+0x258>
80003944:	00d36c63          	bltu	t1,a3,8000395c <get_fileinfo+0x244>
80003948:	00c5c683          	lbu	a3,12(a1)
8000394c:	02078613          	addi	a2,a5,32
80003950:	00d8f6b3          	and	a3,a7,a3
80003954:	00068463          	beqz	a3,8000395c <get_fileinfo+0x244>
80003958:	0ff67793          	andi	a5,a2,255
				fno->fname[di] = (TCHAR)wc;
8000395c:	00f70623          	sb	a5,12(a4)
80003960:	00e506b3          	add	a3,a0,a4
80003964:	00170713          	addi	a4,a4,1
			for (si = di = 0, lcf = NS_BODY; fno->altname[si]; si++, di++) {	/* Copy altname[] to fname[] with case information */
80003968:	fff74783          	lbu	a5,-1(a4)
8000396c:	04078063          	beqz	a5,800039ac <get_fileinfo+0x294>
				wc = (WCHAR)fno->altname[si];
80003970:	01079613          	slli	a2,a5,0x10
80003974:	01065613          	srli	a2,a2,0x10
				if (IsUpper(wc) && (dp->dir[DIR_NTres] & lcf)) wc += 0x20;
80003978:	fbf60693          	addi	a3,a2,-65
8000397c:	01069693          	slli	a3,a3,0x10
80003980:	0106d693          	srli	a3,a3,0x10
				if (wc == '.') lcf = NS_EXT;
80003984:	fd0610e3          	bne	a2,a6,80003944 <get_fileinfo+0x22c>
80003988:	02e00793          	li	a5,46
8000398c:	01000893          	li	a7,16
80003990:	fcdff06f          	j	8000395c <get_fileinfo+0x244>
80003994:	00078b93          	mv	s7,a5
80003998:	002c0c13          	addi	s8,s8,2
8000399c:	dfdff06f          	j	80003798 <get_fileinfo+0x80>
			fno->fname[di++] = '\?';
800039a0:	03f00793          	li	a5,63
800039a4:	00f40d23          	sb	a5,26(s0)
800039a8:	00100693          	li	a3,1
		fno->fname[di] = 0;	/* Terminate the LFN */
800039ac:	00d406b3          	add	a3,s0,a3
800039b0:	00068d23          	sb	zero,26(a3)
		if (!dp->dir[DIR_NTres]) fno->altname[0] = 0;	/* Altname is not needed if neither LFN nor case info is exist. */
800039b4:	00c5c783          	lbu	a5,12(a1)
800039b8:	ea0796e3          	bnez	a5,80003864 <get_fileinfo+0x14c>
800039bc:	000406a3          	sb	zero,13(s0)
800039c0:	ea5ff06f          	j	80003864 <get_fileinfo+0x14c>
800039c4:	01092683          	lw	a3,16(s2)
			if (hs == 0 && IsSurrogate(wc)) {	/* Is it a surrogate? */
800039c8:	000034b7          	lui	s1,0x3
		UINT nc = 0;
800039cc:	00000b93          	li	s7,0
800039d0:	0236c303          	lbu	t1,35(a3)
		hs = 0;
800039d4:	00000813          	li	a6,0
		si = SZDIRE * 2; di = 0;	/* 1st C1 entry in the entry block */
800039d8:	00000b13          	li	s6,0
800039dc:	04000793          	li	a5,64
			if (si >= MAXDIRB(FF_MAX_LFN)) {	/* Truncated directory block? */
800039e0:	25f00a13          	li	s4,607
			nw = put_utf((DWORD)hs << 16 | wc, &fno->fname[di], FF_LFN_BUF - di);	/* Store it in API encoding */
800039e4:	0ff00993          	li	s3,255
			if (hs == 0 && IsSurrogate(wc)) {	/* Is it a surrogate? */
800039e8:	80048493          	addi	s1,s1,-2048 # 2800 <crtStart-0x7fffd800>
800039ec:	7ff00a93          	li	s5,2047
			nw = put_utf((DWORD)hs << 16 | wc, &fno->fname[di], FF_LFN_BUF - di);	/* Store it in API encoding */
800039f0:	01ab0593          	addi	a1,s6,26
800039f4:	01081513          	slli	a0,a6,0x10
800039f8:	41698633          	sub	a2,s3,s6
800039fc:	00b405b3          	add	a1,s0,a1
			if ((si % SZDIRE) == 0) si += 2;	/* Skip entry type field */
80003a00:	01f7f713          	andi	a4,a5,31
80003a04:	00478893          	addi	a7,a5,4
		while (nc < fs->dirbuf[XDIR_NumName]) {
80003a08:	066bfa63          	bgeu	s7,t1,80003a7c <get_fileinfo+0x364>
			if (si >= MAXDIRB(FF_MAX_LFN)) {	/* Truncated directory block? */
80003a0c:	06fa6a63          	bltu	s4,a5,80003a80 <get_fileinfo+0x368>
80003a10:	00278c13          	addi	s8,a5,2
			if ((si % SZDIRE) == 0) si += 2;	/* Skip entry type field */
80003a14:	00071663          	bnez	a4,80003a20 <get_fileinfo+0x308>
80003a18:	000c0793          	mv	a5,s8
80003a1c:	00088c13          	mv	s8,a7
			wc = ld_word(fs->dirbuf + si); si += 2; nc++;	/* Get a character */
80003a20:	00f687b3          	add	a5,a3,a5
	rv = rv << 8 | ptr[0];
80003a24:	0017c703          	lbu	a4,1(a5)
80003a28:	0007c883          	lbu	a7,0(a5)
			wc = ld_word(fs->dirbuf + si); si += 2; nc++;	/* Get a character */
80003a2c:	001b8b93          	addi	s7,s7,1
	rv = rv << 8 | ptr[0];
80003a30:	00871793          	slli	a5,a4,0x8
80003a34:	0117e7b3          	or	a5,a5,a7
			if (hs == 0 && IsSurrogate(wc)) {	/* Is it a surrogate? */
80003a38:	00978733          	add	a4,a5,s1
80003a3c:	01071713          	slli	a4,a4,0x10
			nw = put_utf((DWORD)hs << 16 | wc, &fno->fname[di], FF_LFN_BUF - di);	/* Store it in API encoding */
80003a40:	00f56533          	or	a0,a0,a5
			if (hs == 0 && IsSurrogate(wc)) {	/* Is it a surrogate? */
80003a44:	01075713          	srli	a4,a4,0x10
80003a48:	00081463          	bnez	a6,80003a50 <get_fileinfo+0x338>
80003a4c:	02eaf263          	bgeu	s5,a4,80003a70 <get_fileinfo+0x358>
			nw = put_utf((DWORD)hs << 16 | wc, &fno->fname[di], FF_LFN_BUF - di);	/* Store it in API encoding */
80003a50:	c31ff0ef          	jal	ra,80003680 <put_utf>
			if (nw == 0) {						/* Buffer overflow or wrong char? */
80003a54:	01092683          	lw	a3,16(s2)
80003a58:	02050463          	beqz	a0,80003a80 <get_fileinfo+0x368>
			di += nw;
80003a5c:	00ab0b33          	add	s6,s6,a0
			hs = 0;
80003a60:	00000813          	li	a6,0
80003a64:	0236c303          	lbu	t1,35(a3)
80003a68:	000c0793          	mv	a5,s8
80003a6c:	f85ff06f          	j	800039f0 <get_fileinfo+0x2d8>
80003a70:	00078813          	mv	a6,a5
80003a74:	000c0793          	mv	a5,s8
80003a78:	f79ff06f          	j	800039f0 <get_fileinfo+0x2d8>
		if (hs != 0) di = 0;					/* Broken surrogate pair? */
80003a7c:	0e080863          	beqz	a6,80003b6c <get_fileinfo+0x454>
		if (di == 0) fno->fname[di++] = '\?';	/* Inaccessible object name? */
80003a80:	03f00793          	li	a5,63
80003a84:	00f40d23          	sb	a5,26(s0)
80003a88:	00100b13          	li	s6,1
		fno->fname[di] = 0;						/* Terminate the name */
80003a8c:	01640b33          	add	s6,s0,s6
80003a90:	000b0d23          	sb	zero,26(s6)
		fno->altname[0] = 0;					/* exFAT does not support SFN */
80003a94:	000406a3          	sb	zero,13(s0)
		fno->fattrib = fs->dirbuf[XDIR_Attr] & AM_MASKX;		/* Attribute */
80003a98:	0046c783          	lbu	a5,4(a3)
80003a9c:	0377f713          	andi	a4,a5,55
80003aa0:	00e40623          	sb	a4,12(s0)
		fno->fsize = (fno->fattrib & AM_DIR) ? 0 : ld_qword(fs->dirbuf + XDIR_FileSize);	/* Size */
80003aa4:	0107f793          	andi	a5,a5,16
80003aa8:	0a079c63          	bnez	a5,80003b60 <get_fileinfo+0x448>
	rv = rv << 8 | ptr[4];
80003aac:	03d6c703          	lbu	a4,61(a3)
80003ab0:	03c6c583          	lbu	a1,60(a3)
80003ab4:	03e6c603          	lbu	a2,62(a3)
80003ab8:	03f6c783          	lbu	a5,63(a3)
80003abc:	00871713          	slli	a4,a4,0x8
80003ac0:	00b76733          	or	a4,a4,a1
80003ac4:	01061613          	slli	a2,a2,0x10
80003ac8:	00e66633          	or	a2,a2,a4
80003acc:	01879793          	slli	a5,a5,0x18
	rv = rv << 8 | ptr[3];
80003ad0:	03b6c703          	lbu	a4,59(a3)
	rv = rv << 8 | ptr[4];
80003ad4:	00c7e7b3          	or	a5,a5,a2
	rv = rv << 8 | ptr[3];
80003ad8:	00879593          	slli	a1,a5,0x8
	rv = rv << 8 | ptr[2];
80003adc:	03a6c603          	lbu	a2,58(a3)
	rv = rv << 8 | ptr[3];
80003ae0:	00b76733          	or	a4,a4,a1
80003ae4:	0187d793          	srli	a5,a5,0x18
	rv = rv << 8 | ptr[2];
80003ae8:	01875513          	srli	a0,a4,0x18
80003aec:	00871593          	slli	a1,a4,0x8
80003af0:	00879793          	slli	a5,a5,0x8
	rv = rv << 8 | ptr[1];
80003af4:	0396c703          	lbu	a4,57(a3)
	rv = rv << 8 | ptr[2];
80003af8:	00b66633          	or	a2,a2,a1
80003afc:	00f567b3          	or	a5,a0,a5
	rv = rv << 8 | ptr[1];
80003b00:	00879793          	slli	a5,a5,0x8
80003b04:	01865513          	srli	a0,a2,0x18
	rv = rv << 8 | ptr[0];
80003b08:	0386c583          	lbu	a1,56(a3)
	rv = rv << 8 | ptr[1];
80003b0c:	00861613          	slli	a2,a2,0x8
80003b10:	00c76733          	or	a4,a4,a2
80003b14:	00f567b3          	or	a5,a0,a5
	rv = rv << 8 | ptr[0];
80003b18:	01875613          	srli	a2,a4,0x18
80003b1c:	00879793          	slli	a5,a5,0x8
80003b20:	00871713          	slli	a4,a4,0x8
80003b24:	00e5e733          	or	a4,a1,a4
80003b28:	00f667b3          	or	a5,a2,a5
		fno->fsize = (fno->fattrib & AM_DIR) ? 0 : ld_qword(fs->dirbuf + XDIR_FileSize);	/* Size */
80003b2c:	00e42023          	sw	a4,0(s0)
80003b30:	00f42223          	sw	a5,4(s0)
	rv = rv << 8 | ptr[0];
80003b34:	00d6c783          	lbu	a5,13(a3)
80003b38:	00c6c703          	lbu	a4,12(a3)
80003b3c:	00879793          	slli	a5,a5,0x8
80003b40:	00e7e7b3          	or	a5,a5,a4
		fno->ftime = ld_word(fs->dirbuf + XDIR_ModTime + 0);	/* Time */
80003b44:	00f41523          	sh	a5,10(s0)
	rv = rv << 8 | ptr[0];
80003b48:	00f6c783          	lbu	a5,15(a3)
80003b4c:	00e6c703          	lbu	a4,14(a3)
80003b50:	00879793          	slli	a5,a5,0x8
80003b54:	00e7e7b3          	or	a5,a5,a4
		fno->fdate = ld_word(fs->dirbuf + XDIR_ModTime + 2);	/* Date */
80003b58:	00f41423          	sh	a5,8(s0)
		return;
80003b5c:	d6dff06f          	j	800038c8 <get_fileinfo+0x1b0>
		fno->fsize = (fno->fattrib & AM_DIR) ? 0 : ld_qword(fs->dirbuf + XDIR_FileSize);	/* Size */
80003b60:	00000713          	li	a4,0
80003b64:	00000793          	li	a5,0
80003b68:	fc5ff06f          	j	80003b2c <get_fileinfo+0x414>
		if (di == 0) fno->fname[di++] = '\?';	/* Inaccessible object name? */
80003b6c:	f20b10e3          	bnez	s6,80003a8c <get_fileinfo+0x374>
80003b70:	f11ff06f          	j	80003a80 <get_fileinfo+0x368>
			for (si = di = 0, lcf = NS_BODY; fno->altname[si]; si++, di++) {	/* Copy altname[] to fname[] with case information */
80003b74:	00000693          	li	a3,0
80003b78:	e35ff06f          	j	800039ac <get_fileinfo+0x294>

80003b7c <xname_sum>:
{
80003b7c:	ff010113          	addi	sp,sp,-16
80003b80:	00912223          	sw	s1,4(sp)
80003b84:	00050493          	mv	s1,a0
	while ((chr = *name++) != 0) {
80003b88:	00055503          	lhu	a0,0(a0)
{
80003b8c:	00112623          	sw	ra,12(sp)
80003b90:	00812423          	sw	s0,8(sp)
	while ((chr = *name++) != 0) {
80003b94:	06050a63          	beqz	a0,80003c08 <xname_sum+0x8c>
80003b98:	00248493          	addi	s1,s1,2
	WORD sum = 0;
80003b9c:	00000413          	li	s0,0
		chr = (WCHAR)ff_wtoupper(chr);		/* File name needs to be up-case converted */
80003ba0:	04c070ef          	jal	ra,8000abec <ff_wtoupper>
80003ba4:	01051513          	slli	a0,a0,0x10
80003ba8:	01055513          	srli	a0,a0,0x10
		sum = ((sum & 1) ? 0x8000 : 0) + (sum >> 1) + (chr & 0xFF);
80003bac:	0ff57713          	andi	a4,a0,255
80003bb0:	00145793          	srli	a5,s0,0x1
80003bb4:	00e787b3          	add	a5,a5,a4
80003bb8:	00f41413          	slli	s0,s0,0xf
80003bbc:	00f40433          	add	s0,s0,a5
80003bc0:	01041413          	slli	s0,s0,0x10
80003bc4:	01045413          	srli	s0,s0,0x10
		sum = ((sum & 1) ? 0x8000 : 0) + (sum >> 1) + (chr >> 8);
80003bc8:	00145713          	srli	a4,s0,0x1
80003bcc:	00855793          	srli	a5,a0,0x8
	while ((chr = *name++) != 0) {
80003bd0:	00248493          	addi	s1,s1,2
		sum = ((sum & 1) ? 0x8000 : 0) + (sum >> 1) + (chr >> 8);
80003bd4:	00f41413          	slli	s0,s0,0xf
80003bd8:	00f707b3          	add	a5,a4,a5
	while ((chr = *name++) != 0) {
80003bdc:	ffe4d503          	lhu	a0,-2(s1)
		sum = ((sum & 1) ? 0x8000 : 0) + (sum >> 1) + (chr >> 8);
80003be0:	00f40433          	add	s0,s0,a5
80003be4:	01041413          	slli	s0,s0,0x10
80003be8:	01045413          	srli	s0,s0,0x10
	while ((chr = *name++) != 0) {
80003bec:	fa051ae3          	bnez	a0,80003ba0 <xname_sum+0x24>
}
80003bf0:	00040513          	mv	a0,s0
80003bf4:	00c12083          	lw	ra,12(sp)
80003bf8:	00812403          	lw	s0,8(sp)
80003bfc:	00412483          	lw	s1,4(sp)
80003c00:	01010113          	addi	sp,sp,16
80003c04:	00008067          	ret
	WORD sum = 0;
80003c08:	00000413          	li	s0,0
}
80003c0c:	00040513          	mv	a0,s0
80003c10:	00c12083          	lw	ra,12(sp)
80003c14:	00812403          	lw	s0,8(sp)
80003c18:	00412483          	lw	s1,4(sp)
80003c1c:	01010113          	addi	sp,sp,16
80003c20:	00008067          	ret

80003c24 <init_alloc_info.isra.4>:
	rv = rv << 8 | ptr[2];
80003c24:	03754783          	lbu	a5,55(a0)
80003c28:	03654683          	lbu	a3,54(a0)
	rv = rv << 8 | ptr[1];
80003c2c:	03554703          	lbu	a4,53(a0)
	rv = rv << 8 | ptr[2];
80003c30:	00879793          	slli	a5,a5,0x8
80003c34:	00d7e7b3          	or	a5,a5,a3
	rv = rv << 8 | ptr[1];
80003c38:	00879793          	slli	a5,a5,0x8
	rv = rv << 8 | ptr[0];
80003c3c:	03454683          	lbu	a3,52(a0)
	rv = rv << 8 | ptr[1];
80003c40:	00f767b3          	or	a5,a4,a5
	rv = rv << 8 | ptr[0];
80003c44:	00879793          	slli	a5,a5,0x8
80003c48:	00f6e7b3          	or	a5,a3,a5
	obj->sclust = ld_dword(fs->dirbuf + XDIR_FstClus);		/* Start cluster */
80003c4c:	00f5a423          	sw	a5,8(a1)
	rv = rv << 8 | ptr[4];
80003c50:	03d54603          	lbu	a2,61(a0)
80003c54:	03c54703          	lbu	a4,60(a0)
80003c58:	03e54683          	lbu	a3,62(a0)
80003c5c:	03f54783          	lbu	a5,63(a0)
80003c60:	00861613          	slli	a2,a2,0x8
80003c64:	00e66633          	or	a2,a2,a4
80003c68:	01069693          	slli	a3,a3,0x10
	rv = rv << 8 | ptr[3];
80003c6c:	03b54703          	lbu	a4,59(a0)
	rv = rv << 8 | ptr[4];
80003c70:	00c6e6b3          	or	a3,a3,a2
80003c74:	01879793          	slli	a5,a5,0x18
80003c78:	00d7e7b3          	or	a5,a5,a3
	rv = rv << 8 | ptr[2];
80003c7c:	03a54603          	lbu	a2,58(a0)
	rv = rv << 8 | ptr[3];
80003c80:	00879693          	slli	a3,a5,0x8
80003c84:	00d76733          	or	a4,a4,a3
80003c88:	0187d793          	srli	a5,a5,0x18
	rv = rv << 8 | ptr[1];
80003c8c:	03954683          	lbu	a3,57(a0)
	rv = rv << 8 | ptr[2];
80003c90:	01875813          	srli	a6,a4,0x18
80003c94:	00879793          	slli	a5,a5,0x8
80003c98:	00871713          	slli	a4,a4,0x8
80003c9c:	00e66633          	or	a2,a2,a4
80003ca0:	00f867b3          	or	a5,a6,a5
	rv = rv << 8 | ptr[1];
80003ca4:	01865893          	srli	a7,a2,0x18
	rv = rv << 8 | ptr[0];
80003ca8:	03854803          	lbu	a6,56(a0)
	rv = rv << 8 | ptr[1];
80003cac:	00879793          	slli	a5,a5,0x8
80003cb0:	00861613          	slli	a2,a2,0x8
80003cb4:	00c6e733          	or	a4,a3,a2
80003cb8:	00f8e7b3          	or	a5,a7,a5
	rv = rv << 8 | ptr[0];
80003cbc:	01875693          	srli	a3,a4,0x18
80003cc0:	00879793          	slli	a5,a5,0x8
80003cc4:	00871713          	slli	a4,a4,0x8
80003cc8:	00f6e7b3          	or	a5,a3,a5
80003ccc:	00e86733          	or	a4,a6,a4
80003cd0:	00e5a823          	sw	a4,16(a1)
80003cd4:	00f5aa23          	sw	a5,20(a1)
	obj->stat = fs->dirbuf[XDIR_GenFlags] & 2;				/* Allocation status */
80003cd8:	02154783          	lbu	a5,33(a0)
	obj->n_frag = 0;										/* No last fragment info */
80003cdc:	0005ae23          	sw	zero,28(a1)
	obj->stat = fs->dirbuf[XDIR_GenFlags] & 2;				/* Allocation status */
80003ce0:	0027f793          	andi	a5,a5,2
80003ce4:	00f583a3          	sb	a5,7(a1)
}
80003ce8:	00008067          	ret

80003cec <sync_window.part.5>:
static FRESULT sync_window (	/* Returns FR_OK or FR_DISK_ERR */
80003cec:	ff010113          	addi	sp,sp,-16
80003cf0:	00812423          	sw	s0,8(sp)
80003cf4:	00912223          	sw	s1,4(sp)
80003cf8:	01212023          	sw	s2,0(sp)
80003cfc:	00112623          	sw	ra,12(sp)
80003d00:	00050413          	mv	s0,a0
		if (disk_write(fs->pdrv, fs->win, fs->winsect, 1) == RES_OK) {	/* Write it back into the volume */
80003d04:	03852603          	lw	a2,56(a0)
80003d08:	00154503          	lbu	a0,1(a0)
80003d0c:	03c40913          	addi	s2,s0,60
80003d10:	00100693          	li	a3,1
80003d14:	00090593          	mv	a1,s2
80003d18:	821ff0ef          	jal	ra,80003538 <disk_write>
			res = FR_DISK_ERR;
80003d1c:	00100493          	li	s1,1
		if (disk_write(fs->pdrv, fs->win, fs->winsect, 1) == RES_OK) {	/* Write it back into the volume */
80003d20:	02051663          	bnez	a0,80003d4c <sync_window.part.5+0x60>
			if (fs->winsect - fs->fatbase < fs->fsize) {	/* Is it in the 1st FAT? */
80003d24:	03842603          	lw	a2,56(s0)
80003d28:	02842783          	lw	a5,40(s0)
80003d2c:	02042703          	lw	a4,32(s0)
			fs->wflag = 0;	/* Clear window dirty flag */
80003d30:	00040223          	sb	zero,4(s0)
			if (fs->winsect - fs->fatbase < fs->fsize) {	/* Is it in the 1st FAT? */
80003d34:	40f607b3          	sub	a5,a2,a5
80003d38:	00050493          	mv	s1,a0
80003d3c:	00e7f863          	bgeu	a5,a4,80003d4c <sync_window.part.5+0x60>
				if (fs->n_fats == 2) disk_write(fs->pdrv, fs->win, fs->winsect + fs->fsize, 1);	/* Reflect it to 2nd FAT if needed */
80003d40:	00344683          	lbu	a3,3(s0)
80003d44:	00200793          	li	a5,2
80003d48:	02f68063          	beq	a3,a5,80003d68 <sync_window.part.5+0x7c>
}
80003d4c:	00c12083          	lw	ra,12(sp)
80003d50:	00812403          	lw	s0,8(sp)
80003d54:	00048513          	mv	a0,s1
80003d58:	00012903          	lw	s2,0(sp)
80003d5c:	00412483          	lw	s1,4(sp)
80003d60:	01010113          	addi	sp,sp,16
80003d64:	00008067          	ret
				if (fs->n_fats == 2) disk_write(fs->pdrv, fs->win, fs->winsect + fs->fsize, 1);	/* Reflect it to 2nd FAT if needed */
80003d68:	00144503          	lbu	a0,1(s0)
80003d6c:	00100693          	li	a3,1
80003d70:	00e60633          	add	a2,a2,a4
80003d74:	00090593          	mv	a1,s2
80003d78:	fc0ff0ef          	jal	ra,80003538 <disk_write>
80003d7c:	fd1ff06f          	j	80003d4c <sync_window.part.5+0x60>

80003d80 <dir_clear>:
{
80003d80:	fd010113          	addi	sp,sp,-48
80003d84:	02912223          	sw	s1,36(sp)
80003d88:	02112623          	sw	ra,44(sp)
80003d8c:	02812423          	sw	s0,40(sp)
80003d90:	03212023          	sw	s2,32(sp)
80003d94:	01312e23          	sw	s3,28(sp)
	if (fs->wflag) {	/* Is the disk access window dirty? */
80003d98:	00454783          	lbu	a5,4(a0)
{
80003d9c:	00050493          	mv	s1,a0
	if (fs->wflag) {	/* Is the disk access window dirty? */
80003da0:	08079e63          	bnez	a5,80003e3c <dir_clear+0xbc>
	if (clst >= fs->n_fatent - 2) return 0;		/* Is it invalid cluster number? */
80003da4:	01c4a783          	lw	a5,28(s1)
	clst -= 2;		/* Cluster number is origin from 2 */
80003da8:	ffe58593          	addi	a1,a1,-2
	if (clst >= fs->n_fatent - 2) return 0;		/* Is it invalid cluster number? */
80003dac:	00000913          	li	s2,0
80003db0:	ffe78793          	addi	a5,a5,-2
80003db4:	00f5fa63          	bgeu	a1,a5,80003dc8 <dir_clear+0x48>
	return fs->database + (LBA_t)fs->csize * clst;	/* Start sector number of the cluster */
80003db8:	00a4d503          	lhu	a0,10(s1)
80003dbc:	3e9090ef          	jal	ra,8000d9a4 <__mulsi3>
80003dc0:	0304a903          	lw	s2,48(s1)
80003dc4:	01250933          	add	s2,a0,s2
	memset(fs->win, 0, sizeof fs->win);	/* Clear window buffer */
80003dc8:	03c48993          	addi	s3,s1,60
	fs->winsect = sect;				/* Set window to top of the cluster */
80003dcc:	0324ac23          	sw	s2,56(s1)
	memset(fs->win, 0, sizeof fs->win);	/* Clear window buffer */
80003dd0:	20000613          	li	a2,512
80003dd4:	00000593          	li	a1,0
80003dd8:	00098513          	mv	a0,s3
80003ddc:	945fe0ef          	jal	ra,80002720 <memset>
		for (n = 0; n < fs->csize && disk_write(fs->pdrv, ibuf, sect + n, szb) == RES_OK; n += szb) ;	/* Fill the cluster with 0 */
80003de0:	00a4d783          	lhu	a5,10(s1)
80003de4:	00000413          	li	s0,0
80003de8:	00079863          	bnez	a5,80003df8 <dir_clear+0x78>
80003dec:	0280006f          	j	80003e14 <dir_clear+0x94>
80003df0:	00140413          	addi	s0,s0,1
80003df4:	02f47063          	bgeu	s0,a5,80003e14 <dir_clear+0x94>
80003df8:	0014c503          	lbu	a0,1(s1)
80003dfc:	00890633          	add	a2,s2,s0
80003e00:	00100693          	li	a3,1
80003e04:	00098593          	mv	a1,s3
80003e08:	f30ff0ef          	jal	ra,80003538 <disk_write>
80003e0c:	00a4d783          	lhu	a5,10(s1)
80003e10:	fe0500e3          	beqz	a0,80003df0 <dir_clear+0x70>
	return (n == fs->csize) ? FR_OK : FR_DISK_ERR;
80003e14:	40f40433          	sub	s0,s0,a5
80003e18:	00803433          	snez	s0,s0
}
80003e1c:	00040513          	mv	a0,s0
80003e20:	02c12083          	lw	ra,44(sp)
80003e24:	02812403          	lw	s0,40(sp)
80003e28:	02412483          	lw	s1,36(sp)
80003e2c:	02012903          	lw	s2,32(sp)
80003e30:	01c12983          	lw	s3,28(sp)
80003e34:	03010113          	addi	sp,sp,48
80003e38:	00008067          	ret
80003e3c:	00b12623          	sw	a1,12(sp)
80003e40:	eadff0ef          	jal	ra,80003cec <sync_window.part.5>
	if (sync_window(fs) != FR_OK) return FR_DISK_ERR;	/* Flush disk access window */
80003e44:	00100413          	li	s0,1
80003e48:	00c12583          	lw	a1,12(sp)
80003e4c:	f4050ce3          	beqz	a0,80003da4 <dir_clear+0x24>
}
80003e50:	00040513          	mv	a0,s0
80003e54:	02c12083          	lw	ra,44(sp)
80003e58:	02812403          	lw	s0,40(sp)
80003e5c:	02412483          	lw	s1,36(sp)
80003e60:	02012903          	lw	s2,32(sp)
80003e64:	01c12983          	lw	s3,28(sp)
80003e68:	03010113          	addi	sp,sp,48
80003e6c:	00008067          	ret

80003e70 <sync_fs>:
{
80003e70:	ff010113          	addi	sp,sp,-16
80003e74:	00812423          	sw	s0,8(sp)
80003e78:	00112623          	sw	ra,12(sp)
80003e7c:	00912223          	sw	s1,4(sp)
	if (fs->wflag) {	/* Is the disk access window dirty? */
80003e80:	00454783          	lbu	a5,4(a0)
{
80003e84:	00050413          	mv	s0,a0
	if (fs->wflag) {	/* Is the disk access window dirty? */
80003e88:	02079c63          	bnez	a5,80003ec0 <sync_fs+0x50>
		if (fs->fs_type == FS_FAT32 && fs->fsi_flag == 1) {	/* FAT32: Update FSInfo sector if needed */
80003e8c:	00044703          	lbu	a4,0(s0)
80003e90:	00300793          	li	a5,3
80003e94:	04f70063          	beq	a4,a5,80003ed4 <sync_fs+0x64>
		if (disk_ioctl(fs->pdrv, CTRL_SYNC, 0) != RES_OK) res = FR_DISK_ERR;
80003e98:	00144503          	lbu	a0,1(s0)
80003e9c:	00000613          	li	a2,0
80003ea0:	00000593          	li	a1,0
80003ea4:	ed4ff0ef          	jal	ra,80003578 <disk_ioctl>
80003ea8:	00a03533          	snez	a0,a0
}
80003eac:	00c12083          	lw	ra,12(sp)
80003eb0:	00812403          	lw	s0,8(sp)
80003eb4:	00412483          	lw	s1,4(sp)
80003eb8:	01010113          	addi	sp,sp,16
80003ebc:	00008067          	ret
80003ec0:	e2dff0ef          	jal	ra,80003cec <sync_window.part.5>
	if (res == FR_OK) {
80003ec4:	fe0514e3          	bnez	a0,80003eac <sync_fs+0x3c>
		if (fs->fs_type == FS_FAT32 && fs->fsi_flag == 1) {	/* FAT32: Update FSInfo sector if needed */
80003ec8:	00044703          	lbu	a4,0(s0)
80003ecc:	00300793          	li	a5,3
80003ed0:	fcf714e3          	bne	a4,a5,80003e98 <sync_fs+0x28>
80003ed4:	00544703          	lbu	a4,5(s0)
80003ed8:	00100793          	li	a5,1
80003edc:	faf71ee3          	bne	a4,a5,80003e98 <sync_fs+0x28>
			memset(fs->win, 0, sizeof fs->win);
80003ee0:	03c40493          	addi	s1,s0,60
80003ee4:	20000613          	li	a2,512
80003ee8:	00000593          	li	a1,0
80003eec:	00048513          	mv	a0,s1
80003ef0:	831fe0ef          	jal	ra,80002720 <memset>
			st_dword(fs->win + FSI_Free_Count, fs->free_clst);	/* Number of free clusters */
80003ef4:	01842703          	lw	a4,24(s0)
			st_dword(fs->win + FSI_Nxt_Free, fs->last_clst);	/* Last allocated culuster */
80003ef8:	01442783          	lw	a5,20(s0)
			fs->winsect = fs->volbase + 1;						/* Write it into the FSInfo sector (Next to VBR) */
80003efc:	02442603          	lw	a2,36(s0)
	*ptr++ = (BYTE)val; val >>= 8;
80003f00:	05500393          	li	t2,85
			disk_write(fs->pdrv, fs->win, fs->winsect, 1);
80003f04:	00144503          	lbu	a0,1(s0)
	*ptr++ = (BYTE)val; val >>= 8;
80003f08:	05200893          	li	a7,82
	*ptr++ = (BYTE)val; val >>= 8;
80003f0c:	06100693          	li	a3,97
	*ptr++ = (BYTE)val;
80003f10:	04100593          	li	a1,65
	*ptr++ = (BYTE)val; val >>= 8;
80003f14:	07200813          	li	a6,114
			fs->winsect = fs->volbase + 1;						/* Write it into the FSInfo sector (Next to VBR) */
80003f18:	00160613          	addi	a2,a2,1
	*ptr++ = (BYTE)val; val >>= 8;
80003f1c:	00875293          	srli	t0,a4,0x8
	*ptr++ = (BYTE)val; val >>= 8;
80003f20:	01075f93          	srli	t6,a4,0x10
	*ptr++ = (BYTE)val; val >>= 8;
80003f24:	01875f13          	srli	t5,a4,0x18
	*ptr++ = (BYTE)val; val >>= 8;
80003f28:	0087de93          	srli	t4,a5,0x8
	*ptr++ = (BYTE)val; val >>= 8;
80003f2c:	0107de13          	srli	t3,a5,0x10
	*ptr++ = (BYTE)val; val >>= 8;
80003f30:	0187d313          	srli	t1,a5,0x18
	*ptr++ = (BYTE)val; val >>= 8;
80003f34:	22740d23          	sb	t2,570(s0)
	*ptr++ = (BYTE)val;
80003f38:	faa00393          	li	t2,-86
	*ptr++ = (BYTE)val; val >>= 8;
80003f3c:	02d40f23          	sb	a3,62(s0)
	*ptr++ = (BYTE)val;
80003f40:	02b40fa3          	sb	a1,63(s0)
	*ptr++ = (BYTE)val; val >>= 8;
80003f44:	22b40123          	sb	a1,546(s0)
	*ptr++ = (BYTE)val;
80003f48:	22d401a3          	sb	a3,547(s0)
	*ptr++ = (BYTE)val;
80003f4c:	22740da3          	sb	t2,571(s0)
	*ptr++ = (BYTE)val; val >>= 8;
80003f50:	03140e23          	sb	a7,60(s0)
	*ptr++ = (BYTE)val; val >>= 8;
80003f54:	03140ea3          	sb	a7,61(s0)
	*ptr++ = (BYTE)val; val >>= 8;
80003f58:	23040023          	sb	a6,544(s0)
	*ptr++ = (BYTE)val; val >>= 8;
80003f5c:	230400a3          	sb	a6,545(s0)
	*ptr++ = (BYTE)val; val >>= 8;
80003f60:	22e40223          	sb	a4,548(s0)
	*ptr++ = (BYTE)val; val >>= 8;
80003f64:	225402a3          	sb	t0,549(s0)
	*ptr++ = (BYTE)val; val >>= 8;
80003f68:	23f40323          	sb	t6,550(s0)
	*ptr++ = (BYTE)val;
80003f6c:	23e403a3          	sb	t5,551(s0)
	*ptr++ = (BYTE)val; val >>= 8;
80003f70:	22f40423          	sb	a5,552(s0)
	*ptr++ = (BYTE)val; val >>= 8;
80003f74:	23d404a3          	sb	t4,553(s0)
	*ptr++ = (BYTE)val; val >>= 8;
80003f78:	23c40523          	sb	t3,554(s0)
	*ptr++ = (BYTE)val;
80003f7c:	226405a3          	sb	t1,555(s0)
			fs->winsect = fs->volbase + 1;						/* Write it into the FSInfo sector (Next to VBR) */
80003f80:	02c42c23          	sw	a2,56(s0)
			disk_write(fs->pdrv, fs->win, fs->winsect, 1);
80003f84:	00100693          	li	a3,1
80003f88:	00048593          	mv	a1,s1
80003f8c:	dacff0ef          	jal	ra,80003538 <disk_write>
			fs->fsi_flag = 0;
80003f90:	000402a3          	sb	zero,5(s0)
80003f94:	f05ff06f          	j	80003e98 <sync_fs+0x28>

80003f98 <move_window.part.6>:
static FRESULT move_window (	/* Returns FR_OK or FR_DISK_ERR */
80003f98:	ff010113          	addi	sp,sp,-16
80003f9c:	00812423          	sw	s0,8(sp)
80003fa0:	00912223          	sw	s1,4(sp)
80003fa4:	00112623          	sw	ra,12(sp)
	if (fs->wflag) {	/* Is the disk access window dirty? */
80003fa8:	00454783          	lbu	a5,4(a0)
static FRESULT move_window (	/* Returns FR_OK or FR_DISK_ERR */
80003fac:	00050413          	mv	s0,a0
80003fb0:	00058493          	mv	s1,a1
	if (fs->wflag) {	/* Is the disk access window dirty? */
80003fb4:	04079063          	bnez	a5,80003ff4 <move_window.part.6+0x5c>
			int dres = disk_read(fs->pdrv, fs->win, sect, 1);
80003fb8:	00144503          	lbu	a0,1(s0)
80003fbc:	00100693          	li	a3,1
80003fc0:	00048613          	mv	a2,s1
80003fc4:	03c40593          	addi	a1,s0,60
80003fc8:	d30ff0ef          	jal	ra,800034f8 <disk_read>
			if (dres != RES_OK) {
80003fcc:	00051e63          	bnez	a0,80003fe8 <move_window.part.6+0x50>
			fs->winsect = sect;
80003fd0:	02942c23          	sw	s1,56(s0)
}
80003fd4:	00c12083          	lw	ra,12(sp)
80003fd8:	00812403          	lw	s0,8(sp)
80003fdc:	00412483          	lw	s1,4(sp)
80003fe0:	01010113          	addi	sp,sp,16
80003fe4:	00008067          	ret
				res = FR_DISK_ERR;
80003fe8:	00100513          	li	a0,1
				sect = (LBA_t)0 - 1;	/* Invalidate window if read data is not valid */
80003fec:	fff00493          	li	s1,-1
80003ff0:	fe1ff06f          	j	80003fd0 <move_window.part.6+0x38>
80003ff4:	cf9ff0ef          	jal	ra,80003cec <sync_window.part.5>
		if (res == FR_OK) {			/* Fill sector window with new data */
80003ff8:	fc0500e3          	beqz	a0,80003fb8 <move_window.part.6+0x20>
}
80003ffc:	00c12083          	lw	ra,12(sp)
80004000:	00812403          	lw	s0,8(sp)
80004004:	00412483          	lw	s1,4(sp)
80004008:	01010113          	addi	sp,sp,16
8000400c:	00008067          	ret

80004010 <check_fs>:
{
80004010:	ff010113          	addi	sp,sp,-16
80004014:	00812423          	sw	s0,8(sp)
80004018:	00112623          	sw	ra,12(sp)
8000401c:	00912223          	sw	s1,4(sp)
	fs->wflag = 0; fs->winsect = (LBA_t)0 - 1;		/* Invaidate window */
80004020:	fff00793          	li	a5,-1
80004024:	00050223          	sb	zero,4(a0)
80004028:	02f52c23          	sw	a5,56(a0)
{
8000402c:	00050413          	mv	s0,a0
	if (sect != fs->winsect) {	/* Window offset changed? */
80004030:	00f58863          	beq	a1,a5,80004040 <check_fs+0x30>
80004034:	f65ff0ef          	jal	ra,80003f98 <move_window.part.6>
	if (move_window(fs, sect) != FR_OK) return 4;	/* Load the boot sector */
80004038:	00400793          	li	a5,4
8000403c:	02051e63          	bnez	a0,80004078 <check_fs+0x68>
	rv = rv << 8 | ptr[0];
80004040:	23b44483          	lbu	s1,571(s0)
80004044:	23a44783          	lbu	a5,570(s0)
80004048:	00849493          	slli	s1,s1,0x8
8000404c:	00f4e4b3          	or	s1,s1,a5
	if (sign == 0xAA55 && !memcmp(fs->win + BS_JmpBoot, "\xEB\x76\x90" "EXFAT   ", 11)) return 1;	/* It is an exFAT VBR */
80004050:	0000b7b7          	lui	a5,0xb
80004054:	a5578793          	addi	a5,a5,-1451 # aa55 <crtStart-0x7fff55ab>
80004058:	08f48463          	beq	s1,a5,800040e0 <check_fs+0xd0>
	b = fs->win[BS_JmpBoot];
8000405c:	03c44783          	lbu	a5,60(s0)
	if (b == 0xEB || b == 0xE9 || b == 0xE8) {	/* Valid JumpBoot code? (short jump, near jump or near call) */
80004060:	0e900713          	li	a4,233
80004064:	0fd7f693          	andi	a3,a5,253
80004068:	02e68463          	beq	a3,a4,80004090 <check_fs+0x80>
8000406c:	0e800713          	li	a4,232
80004070:	02e78063          	beq	a5,a4,80004090 <check_fs+0x80>
	return sign == 0xAA55 ? 2 : 3;	/* Not an FAT VBR (valid or invalid BS) */
80004074:	00300793          	li	a5,3
}
80004078:	00c12083          	lw	ra,12(sp)
8000407c:	00812403          	lw	s0,8(sp)
80004080:	00412483          	lw	s1,4(sp)
80004084:	00078513          	mv	a0,a5
80004088:	01010113          	addi	sp,sp,16
8000408c:	00008067          	ret
	rv = rv << 8 | ptr[0];
80004090:	04844783          	lbu	a5,72(s0)
80004094:	04744703          	lbu	a4,71(s0)
80004098:	00879793          	slli	a5,a5,0x8
8000409c:	00e7e7b3          	or	a5,a5,a4
		if ((w & (w - 1)) == 0 && w >= FF_MIN_SS && w <= FF_MAX_SS	/* Properness of sector size (512-4096 and 2^n) */
800040a0:	fff78713          	addi	a4,a5,-1
800040a4:	00f77733          	and	a4,a4,a5
800040a8:	fc0716e3          	bnez	a4,80004074 <check_fs+0x64>
800040ac:	20000713          	li	a4,512
		b = fs->win[BPB_SecPerClus];
800040b0:	04944683          	lbu	a3,73(s0)
		if ((w & (w - 1)) == 0 && w >= FF_MIN_SS && w <= FF_MAX_SS	/* Properness of sector size (512-4096 and 2^n) */
800040b4:	0ae78063          	beq	a5,a4,80004154 <check_fs+0x144>
	return sign == 0xAA55 ? 2 : 3;	/* Not an FAT VBR (valid or invalid BS) */
800040b8:	0000b7b7          	lui	a5,0xb
800040bc:	a5578793          	addi	a5,a5,-1451 # aa55 <crtStart-0x7fff55ab>
800040c0:	faf49ae3          	bne	s1,a5,80004074 <check_fs+0x64>
}
800040c4:	00c12083          	lw	ra,12(sp)
800040c8:	00812403          	lw	s0,8(sp)
	return sign == 0xAA55 ? 2 : 3;	/* Not an FAT VBR (valid or invalid BS) */
800040cc:	00200793          	li	a5,2
}
800040d0:	00412483          	lw	s1,4(sp)
800040d4:	00078513          	mv	a0,a5
800040d8:	01010113          	addi	sp,sp,16
800040dc:	00008067          	ret
	if (sign == 0xAA55 && !memcmp(fs->win + BS_JmpBoot, "\xEB\x76\x90" "EXFAT   ", 11)) return 1;	/* It is an exFAT VBR */
800040e0:	8000e5b7          	lui	a1,0x8000e
800040e4:	00b00613          	li	a2,11
800040e8:	39858593          	addi	a1,a1,920 # 8000e398 <STACK_TOP+0xfffee398>
800040ec:	03c40513          	addi	a0,s0,60
800040f0:	e50fe0ef          	jal	ra,80002740 <memcmp>
800040f4:	00100793          	li	a5,1
800040f8:	f80500e3          	beqz	a0,80004078 <check_fs+0x68>
	b = fs->win[BS_JmpBoot];
800040fc:	03c44783          	lbu	a5,60(s0)
	if (b == 0xEB || b == 0xE9 || b == 0xE8) {	/* Valid JumpBoot code? (short jump, near jump or near call) */
80004100:	0e900713          	li	a4,233
80004104:	0fd7f693          	andi	a3,a5,253
80004108:	00e68663          	beq	a3,a4,80004114 <check_fs+0x104>
8000410c:	0e800713          	li	a4,232
80004110:	fae79ae3          	bne	a5,a4,800040c4 <check_fs+0xb4>
		if (sign == 0xAA55 && !memcmp(fs->win + BS_FilSysType32, "FAT32   ", 8)) {
80004114:	8000e5b7          	lui	a1,0x8000e
80004118:	00800613          	li	a2,8
8000411c:	3a458593          	addi	a1,a1,932 # 8000e3a4 <STACK_TOP+0xfffee3a4>
80004120:	08e40513          	addi	a0,s0,142
80004124:	e1cfe0ef          	jal	ra,80002740 <memcmp>
80004128:	0c050863          	beqz	a0,800041f8 <check_fs+0x1e8>
	rv = rv << 8 | ptr[0];
8000412c:	04844783          	lbu	a5,72(s0)
80004130:	04744703          	lbu	a4,71(s0)
80004134:	00879793          	slli	a5,a5,0x8
80004138:	00e7e7b3          	or	a5,a5,a4
		if ((w & (w - 1)) == 0 && w >= FF_MIN_SS && w <= FF_MAX_SS	/* Properness of sector size (512-4096 and 2^n) */
8000413c:	fff78713          	addi	a4,a5,-1
80004140:	00f77733          	and	a4,a4,a5
80004144:	f80710e3          	bnez	a4,800040c4 <check_fs+0xb4>
80004148:	20000713          	li	a4,512
		b = fs->win[BPB_SecPerClus];
8000414c:	04944683          	lbu	a3,73(s0)
		if ((w & (w - 1)) == 0 && w >= FF_MIN_SS && w <= FF_MAX_SS	/* Properness of sector size (512-4096 and 2^n) */
80004150:	f6e79ae3          	bne	a5,a4,800040c4 <check_fs+0xb4>
			&& b != 0 && (b & (b - 1)) == 0				/* Properness of cluster size (2^n) */
80004154:	f60682e3          	beqz	a3,800040b8 <check_fs+0xa8>
80004158:	fff68793          	addi	a5,a3,-1
8000415c:	00d7f6b3          	and	a3,a5,a3
80004160:	f4069ce3          	bnez	a3,800040b8 <check_fs+0xa8>
	rv = rv << 8 | ptr[0];
80004164:	04b44783          	lbu	a5,75(s0)
80004168:	04a44703          	lbu	a4,74(s0)
8000416c:	00879793          	slli	a5,a5,0x8
80004170:	00e7e7b3          	or	a5,a5,a4
			&& ld_word(fs->win + BPB_RsvdSecCnt) != 0	/* Properness of reserved sectors (MNBZ) */
80004174:	f40782e3          	beqz	a5,800040b8 <check_fs+0xa8>
			&& (UINT)fs->win[BPB_NumFATs] - 1 <= 1		/* Properness of FATs (1 or 2) */
80004178:	04c44783          	lbu	a5,76(s0)
8000417c:	00100713          	li	a4,1
80004180:	fff78793          	addi	a5,a5,-1
80004184:	f2f76ae3          	bltu	a4,a5,800040b8 <check_fs+0xa8>
	rv = rv << 8 | ptr[0];
80004188:	04e44783          	lbu	a5,78(s0)
8000418c:	04d44703          	lbu	a4,77(s0)
80004190:	00879793          	slli	a5,a5,0x8
80004194:	00e7e7b3          	or	a5,a5,a4
			&& ld_word(fs->win + BPB_RootEntCnt) != 0	/* Properness of root dir entries (MNBZ) */
80004198:	f20780e3          	beqz	a5,800040b8 <check_fs+0xa8>
	rv = rv << 8 | ptr[0];
8000419c:	05044783          	lbu	a5,80(s0)
800041a0:	04f44683          	lbu	a3,79(s0)
			&& (ld_word(fs->win + BPB_TotSec16) >= 128 || ld_dword(fs->win + BPB_TotSec32) >= 0x10000)	/* Properness of volume sectors (>=128) */
800041a4:	07f00713          	li	a4,127
	rv = rv << 8 | ptr[0];
800041a8:	00879793          	slli	a5,a5,0x8
			&& (ld_word(fs->win + BPB_TotSec16) >= 128 || ld_dword(fs->win + BPB_TotSec32) >= 0x10000)	/* Properness of volume sectors (>=128) */
800041ac:	00d7e7b3          	or	a5,a5,a3
800041b0:	02f76a63          	bltu	a4,a5,800041e4 <check_fs+0x1d4>
	rv = rv << 8 | ptr[2];
800041b4:	05f44783          	lbu	a5,95(s0)
800041b8:	05e44683          	lbu	a3,94(s0)
	rv = rv << 8 | ptr[1];
800041bc:	05d44703          	lbu	a4,93(s0)
	rv = rv << 8 | ptr[2];
800041c0:	00879793          	slli	a5,a5,0x8
800041c4:	00d7e7b3          	or	a5,a5,a3
	rv = rv << 8 | ptr[1];
800041c8:	00879793          	slli	a5,a5,0x8
	rv = rv << 8 | ptr[0];
800041cc:	05c44683          	lbu	a3,92(s0)
	rv = rv << 8 | ptr[1];
800041d0:	00f767b3          	or	a5,a4,a5
	rv = rv << 8 | ptr[0];
800041d4:	00879793          	slli	a5,a5,0x8
800041d8:	00f6e7b3          	or	a5,a3,a5
			&& (ld_word(fs->win + BPB_TotSec16) >= 128 || ld_dword(fs->win + BPB_TotSec32) >= 0x10000)	/* Properness of volume sectors (>=128) */
800041dc:	00010737          	lui	a4,0x10
800041e0:	ece7ece3          	bltu	a5,a4,800040b8 <check_fs+0xa8>
	rv = rv << 8 | ptr[0];
800041e4:	05344783          	lbu	a5,83(s0)
800041e8:	05244703          	lbu	a4,82(s0)
800041ec:	00879793          	slli	a5,a5,0x8
800041f0:	00e7e7b3          	or	a5,a5,a4
			&& ld_word(fs->win + BPB_FATSz16) != 0) {	/* Properness of FAT size (MNBZ) */
800041f4:	ec0782e3          	beqz	a5,800040b8 <check_fs+0xa8>
			return 0;	/* It is an FAT32 VBR */
800041f8:	00000793          	li	a5,0
800041fc:	e7dff06f          	j	80004078 <check_fs+0x68>

80004200 <change_bitmap>:
{
80004200:	fd010113          	addi	sp,sp,-48
	clst -= 2;	/* The first bit corresponds to cluster #2 */
80004204:	ffe58593          	addi	a1,a1,-2
	sect = fs->bitbase + clst / 8 / SS(fs);	/* Sector address */
80004208:	03452783          	lw	a5,52(a0)
{
8000420c:	02812423          	sw	s0,40(sp)
	bm = 1 << (clst % 8);					/* Bit mask in the byte */
80004210:	0075f713          	andi	a4,a1,7
80004214:	00100413          	li	s0,1
{
80004218:	03212023          	sw	s2,32(sp)
8000421c:	01712623          	sw	s7,12(sp)
	i = clst / 8 % SS(fs);					/* Byte offset in the sector */
80004220:	0035d913          	srli	s2,a1,0x3
	sect = fs->bitbase + clst / 8 / SS(fs);	/* Sector address */
80004224:	00c5db93          	srli	s7,a1,0xc
	bm = 1 << (clst % 8);					/* Bit mask in the byte */
80004228:	00e41433          	sll	s0,s0,a4
{
8000422c:	02912223          	sw	s1,36(sp)
80004230:	01312e23          	sw	s3,28(sp)
80004234:	01412c23          	sw	s4,24(sp)
80004238:	01512a23          	sw	s5,20(sp)
8000423c:	01612823          	sw	s6,16(sp)
80004240:	02112623          	sw	ra,44(sp)
80004244:	00050993          	mv	s3,a0
80004248:	00060493          	mv	s1,a2
8000424c:	00068a13          	mv	s4,a3
	sect = fs->bitbase + clst / 8 / SS(fs);	/* Sector address */
80004250:	00fb8bb3          	add	s7,s7,a5
	i = clst / 8 % SS(fs);					/* Byte offset in the sector */
80004254:	1ff97913          	andi	s2,s2,511
	bm = 1 << (clst % 8);					/* Bit mask in the byte */
80004258:	0ff47413          	andi	s0,s0,255
				fs->wflag = 1;
8000425c:	00100a93          	li	s5,1
		} while (++i < SS(fs));		/* Next byte */
80004260:	20000b13          	li	s6,512
	if (sect != fs->winsect) {	/* Window offset changed? */
80004264:	0389a783          	lw	a5,56(s3)
80004268:	01778a63          	beq	a5,s7,8000427c <change_bitmap+0x7c>
8000426c:	000b8593          	mv	a1,s7
80004270:	00098513          	mv	a0,s3
80004274:	d25ff0ef          	jal	ra,80003f98 <move_window.part.6>
		if (move_window(fs, sect++) != FR_OK) return FR_DISK_ERR;
80004278:	0a051863          	bnez	a0,80004328 <change_bitmap+0x128>
8000427c:	01298633          	add	a2,s3,s2
80004280:	03c64783          	lbu	a5,60(a2)
				if (bv == (int)((fs->win[i] & bm) != 0)) return FR_INT_ERR;	/* Is the bit expected value? */
80004284:	00f47733          	and	a4,s0,a5
80004288:	00e03733          	snez	a4,a4
				fs->win[i] ^= bm;	/* Flip the bit */
8000428c:	00f447b3          	xor	a5,s0,a5
			} while (bm <<= 1);		/* Next bit */
80004290:	00141413          	slli	s0,s0,0x1
				if (--ncl == 0) return FR_OK;	/* All bits processed? */
80004294:	fff48493          	addi	s1,s1,-1
			} while (bm <<= 1);		/* Next bit */
80004298:	0ff47413          	andi	s0,s0,255
				if (bv == (int)((fs->win[i] & bm) != 0)) return FR_INT_ERR;	/* Is the bit expected value? */
8000429c:	05470263          	beq	a4,s4,800042e0 <change_bitmap+0xe0>
				fs->win[i] ^= bm;	/* Flip the bit */
800042a0:	02f60e23          	sb	a5,60(a2)
				fs->wflag = 1;
800042a4:	01598223          	sb	s5,4(s3)
				if (--ncl == 0) return FR_OK;	/* All bits processed? */
800042a8:	06048463          	beqz	s1,80004310 <change_bitmap+0x110>
			} while (bm <<= 1);		/* Next bit */
800042ac:	fc041ce3          	bnez	s0,80004284 <change_bitmap+0x84>
		} while (++i < SS(fs));		/* Next byte */
800042b0:	00190913          	addi	s2,s2,1
800042b4:	01298633          	add	a2,s3,s2
800042b8:	07690063          	beq	s2,s6,80004318 <change_bitmap+0x118>
800042bc:	03c64783          	lbu	a5,60(a2)
			bm = 1;
800042c0:	00100413          	li	s0,1
				if (--ncl == 0) return FR_OK;	/* All bits processed? */
800042c4:	fff48493          	addi	s1,s1,-1
				if (bv == (int)((fs->win[i] & bm) != 0)) return FR_INT_ERR;	/* Is the bit expected value? */
800042c8:	00f47733          	and	a4,s0,a5
800042cc:	00e03733          	snez	a4,a4
				fs->win[i] ^= bm;	/* Flip the bit */
800042d0:	00f447b3          	xor	a5,s0,a5
			} while (bm <<= 1);		/* Next bit */
800042d4:	00141413          	slli	s0,s0,0x1
800042d8:	0ff47413          	andi	s0,s0,255
				if (bv == (int)((fs->win[i] & bm) != 0)) return FR_INT_ERR;	/* Is the bit expected value? */
800042dc:	fd4712e3          	bne	a4,s4,800042a0 <change_bitmap+0xa0>
800042e0:	00200513          	li	a0,2
}
800042e4:	02c12083          	lw	ra,44(sp)
800042e8:	02812403          	lw	s0,40(sp)
800042ec:	02412483          	lw	s1,36(sp)
800042f0:	02012903          	lw	s2,32(sp)
800042f4:	01c12983          	lw	s3,28(sp)
800042f8:	01812a03          	lw	s4,24(sp)
800042fc:	01412a83          	lw	s5,20(sp)
80004300:	01012b03          	lw	s6,16(sp)
80004304:	00c12b83          	lw	s7,12(sp)
80004308:	03010113          	addi	sp,sp,48
8000430c:	00008067          	ret
				if (--ncl == 0) return FR_OK;	/* All bits processed? */
80004310:	00000513          	li	a0,0
80004314:	fd1ff06f          	j	800042e4 <change_bitmap+0xe4>
80004318:	001b8b93          	addi	s7,s7,1
			bm = 1;
8000431c:	00100413          	li	s0,1
		i = 0;
80004320:	00000913          	li	s2,0
80004324:	f41ff06f          	j	80004264 <change_bitmap+0x64>
		if (move_window(fs, sect++) != FR_OK) return FR_DISK_ERR;
80004328:	00100513          	li	a0,1
8000432c:	fb9ff06f          	j	800042e4 <change_bitmap+0xe4>

80004330 <get_fat>:
{
80004330:	fe010113          	addi	sp,sp,-32
80004334:	00112e23          	sw	ra,28(sp)
80004338:	00812c23          	sw	s0,24(sp)
8000433c:	00912a23          	sw	s1,20(sp)
80004340:	01212823          	sw	s2,16(sp)
80004344:	01312623          	sw	s3,12(sp)
	if (clst < 2 || clst >= fs->n_fatent) {	/* Check if in valid range */
80004348:	00100793          	li	a5,1
8000434c:	16b7f063          	bgeu	a5,a1,800044ac <get_fat+0x17c>
	FATFS *fs = obj->fs;
80004350:	00052903          	lw	s2,0(a0)
		val = 1;	/* Internal error */
80004354:	00100413          	li	s0,1
	if (clst < 2 || clst >= fs->n_fatent) {	/* Check if in valid range */
80004358:	01c92783          	lw	a5,28(s2)
8000435c:	0af5f463          	bgeu	a1,a5,80004404 <get_fat+0xd4>
		switch (fs->fs_type) {
80004360:	00094783          	lbu	a5,0(s2)
80004364:	00200713          	li	a4,2
80004368:	00058493          	mv	s1,a1
8000436c:	1ce78463          	beq	a5,a4,80004534 <get_fat+0x204>
80004370:	0af77a63          	bgeu	a4,a5,80004424 <get_fat+0xf4>
80004374:	00300693          	li	a3,3
80004378:	14d78c63          	beq	a5,a3,800044d0 <get_fat+0x1a0>
8000437c:	00400613          	li	a2,4
80004380:	08c79263          	bne	a5,a2,80004404 <get_fat+0xd4>
			if ((obj->objsize != 0 && obj->sclust != 0) || obj->stat == 0) {	/* Object except root dir must have valid data length */
80004384:	01052783          	lw	a5,16(a0)
80004388:	01452803          	lw	a6,20(a0)
8000438c:	00754603          	lbu	a2,7(a0)
80004390:	0107e5b3          	or	a1,a5,a6
80004394:	1e059263          	bnez	a1,80004578 <get_fat+0x248>
80004398:	10061a63          	bnez	a2,800044ac <get_fat+0x17c>
					if (obj->n_frag != 0) {	/* Is it on the growing edge? */
8000439c:	01c52783          	lw	a5,28(a0)
800043a0:	22079863          	bnez	a5,800045d0 <get_fat+0x2a0>
						if (move_window(fs, fs->fatbase + (clst / (SS(fs) / 4))) != FR_OK) break;
800043a4:	02892703          	lw	a4,40(s2)
	if (sect != fs->winsect) {	/* Window offset changed? */
800043a8:	03892783          	lw	a5,56(s2)
						if (move_window(fs, fs->fatbase + (clst / (SS(fs) / 4))) != FR_OK) break;
800043ac:	0074d593          	srli	a1,s1,0x7
800043b0:	00e585b3          	add	a1,a1,a4
	if (sect != fs->winsect) {	/* Window offset changed? */
800043b4:	00f58863          	beq	a1,a5,800043c4 <get_fat+0x94>
800043b8:	00090513          	mv	a0,s2
800043bc:	bddff0ef          	jal	ra,80003f98 <move_window.part.6>
						if (move_window(fs, fs->fatbase + (clst / (SS(fs) / 4))) != FR_OK) break;
800043c0:	1c051e63          	bnez	a0,8000459c <get_fat+0x26c>
						val = ld_dword(fs->win + clst * 4 % SS(fs)) & 0x7FFFFFFF;
800043c4:	00249793          	slli	a5,s1,0x2
800043c8:	1fc7f793          	andi	a5,a5,508
800043cc:	03c90713          	addi	a4,s2,60
800043d0:	00f70733          	add	a4,a4,a5
	rv = rv << 8 | ptr[2];
800043d4:	00374783          	lbu	a5,3(a4) # 10003 <crtStart-0x7ffefffd>
800043d8:	00274603          	lbu	a2,2(a4)
	rv = rv << 8 | ptr[1];
800043dc:	00174683          	lbu	a3,1(a4)
	rv = rv << 8 | ptr[2];
800043e0:	00879793          	slli	a5,a5,0x8
800043e4:	00c7e7b3          	or	a5,a5,a2
	rv = rv << 8 | ptr[0];
800043e8:	00074403          	lbu	s0,0(a4)
	rv = rv << 8 | ptr[1];
800043ec:	00879793          	slli	a5,a5,0x8
800043f0:	00f6e7b3          	or	a5,a3,a5
	rv = rv << 8 | ptr[0];
800043f4:	00879793          	slli	a5,a5,0x8
800043f8:	00f467b3          	or	a5,s0,a5
						val = ld_dword(fs->win + clst * 4 % SS(fs)) & 0x7FFFFFFF;
800043fc:	00179413          	slli	s0,a5,0x1
80004400:	00145413          	srli	s0,s0,0x1
}
80004404:	00040513          	mv	a0,s0
80004408:	01c12083          	lw	ra,28(sp)
8000440c:	01812403          	lw	s0,24(sp)
80004410:	01412483          	lw	s1,20(sp)
80004414:	01012903          	lw	s2,16(sp)
80004418:	00c12983          	lw	s3,12(sp)
8000441c:	02010113          	addi	sp,sp,32
80004420:	00008067          	ret
		switch (fs->fs_type) {
80004424:	fe8790e3          	bne	a5,s0,80004404 <get_fat+0xd4>
			bc = (UINT)clst; bc += bc / 2;
80004428:	0015d413          	srli	s0,a1,0x1
			if (move_window(fs, fs->fatbase + (bc / SS(fs))) != FR_OK) break;
8000442c:	02892783          	lw	a5,40(s2)
			bc = (UINT)clst; bc += bc / 2;
80004430:	00b40433          	add	s0,s0,a1
	if (sect != fs->winsect) {	/* Window offset changed? */
80004434:	03892703          	lw	a4,56(s2)
			if (move_window(fs, fs->fatbase + (bc / SS(fs))) != FR_OK) break;
80004438:	00945593          	srli	a1,s0,0x9
8000443c:	00f585b3          	add	a1,a1,a5
	if (sect != fs->winsect) {	/* Window offset changed? */
80004440:	00e58c63          	beq	a1,a4,80004458 <get_fat+0x128>
80004444:	00090513          	mv	a0,s2
80004448:	b51ff0ef          	jal	ra,80003f98 <move_window.part.6>
			if (move_window(fs, fs->fatbase + (bc / SS(fs))) != FR_OK) break;
8000444c:	14051863          	bnez	a0,8000459c <get_fat+0x26c>
80004450:	02892783          	lw	a5,40(s2)
80004454:	03892703          	lw	a4,56(s2)
			wc = fs->win[bc++ % SS(fs)];		/* Get 1st byte of the entry */
80004458:	00140993          	addi	s3,s0,1
			if (move_window(fs, fs->fatbase + (bc / SS(fs))) != FR_OK) break;
8000445c:	0099d593          	srli	a1,s3,0x9
			wc = fs->win[bc++ % SS(fs)];		/* Get 1st byte of the entry */
80004460:	1ff47413          	andi	s0,s0,511
80004464:	00890433          	add	s0,s2,s0
			if (move_window(fs, fs->fatbase + (bc / SS(fs))) != FR_OK) break;
80004468:	00f585b3          	add	a1,a1,a5
			wc = fs->win[bc++ % SS(fs)];		/* Get 1st byte of the entry */
8000446c:	03c44403          	lbu	s0,60(s0)
	if (sect != fs->winsect) {	/* Window offset changed? */
80004470:	00e58863          	beq	a1,a4,80004480 <get_fat+0x150>
80004474:	00090513          	mv	a0,s2
80004478:	b21ff0ef          	jal	ra,80003f98 <move_window.part.6>
			if (move_window(fs, fs->fatbase + (bc / SS(fs))) != FR_OK) break;
8000447c:	12051063          	bnez	a0,8000459c <get_fat+0x26c>
			wc |= fs->win[bc % SS(fs)] << 8;	/* Merge 2nd byte of the entry */
80004480:	1ff9f993          	andi	s3,s3,511
80004484:	01390933          	add	s2,s2,s3
80004488:	03c94783          	lbu	a5,60(s2)
			val = (clst & 1) ? (wc >> 4) : (wc & 0xFFF);	/* Adjust bit position */
8000448c:	0014f593          	andi	a1,s1,1
			wc |= fs->win[bc % SS(fs)] << 8;	/* Merge 2nd byte of the entry */
80004490:	00879793          	slli	a5,a5,0x8
80004494:	0087e7b3          	or	a5,a5,s0
			val = (clst & 1) ? (wc >> 4) : (wc & 0xFFF);	/* Adjust bit position */
80004498:	0047d413          	srli	s0,a5,0x4
8000449c:	f60594e3          	bnez	a1,80004404 <get_fat+0xd4>
800044a0:	01479413          	slli	s0,a5,0x14
800044a4:	01445413          	srli	s0,s0,0x14
800044a8:	f5dff06f          	j	80004404 <get_fat+0xd4>
		val = 1;	/* Internal error */
800044ac:	00100413          	li	s0,1
}
800044b0:	00040513          	mv	a0,s0
800044b4:	01c12083          	lw	ra,28(sp)
800044b8:	01812403          	lw	s0,24(sp)
800044bc:	01412483          	lw	s1,20(sp)
800044c0:	01012903          	lw	s2,16(sp)
800044c4:	00c12983          	lw	s3,12(sp)
800044c8:	02010113          	addi	sp,sp,32
800044cc:	00008067          	ret
			if (move_window(fs, fs->fatbase + (clst / (SS(fs) / 4))) != FR_OK) break;
800044d0:	02892703          	lw	a4,40(s2)
	if (sect != fs->winsect) {	/* Window offset changed? */
800044d4:	03892783          	lw	a5,56(s2)
			if (move_window(fs, fs->fatbase + (clst / (SS(fs) / 4))) != FR_OK) break;
800044d8:	0075d593          	srli	a1,a1,0x7
800044dc:	00e585b3          	add	a1,a1,a4
	if (sect != fs->winsect) {	/* Window offset changed? */
800044e0:	00f58863          	beq	a1,a5,800044f0 <get_fat+0x1c0>
800044e4:	00090513          	mv	a0,s2
800044e8:	ab1ff0ef          	jal	ra,80003f98 <move_window.part.6>
			if (move_window(fs, fs->fatbase + (clst / (SS(fs) / 4))) != FR_OK) break;
800044ec:	0a051863          	bnez	a0,8000459c <get_fat+0x26c>
			val = ld_dword(fs->win + clst * 4 % SS(fs)) & 0x0FFFFFFF;	/* Simple DWORD array but mask out upper 4 bits */
800044f0:	00249593          	slli	a1,s1,0x2
800044f4:	03c90913          	addi	s2,s2,60
800044f8:	1fc5f593          	andi	a1,a1,508
800044fc:	00b90933          	add	s2,s2,a1
	rv = rv << 8 | ptr[2];
80004500:	00394783          	lbu	a5,3(s2)
80004504:	00294683          	lbu	a3,2(s2)
	rv = rv << 8 | ptr[1];
80004508:	00194703          	lbu	a4,1(s2)
	rv = rv << 8 | ptr[2];
8000450c:	00879793          	slli	a5,a5,0x8
80004510:	00d7e7b3          	or	a5,a5,a3
	rv = rv << 8 | ptr[0];
80004514:	00094403          	lbu	s0,0(s2)
	rv = rv << 8 | ptr[1];
80004518:	00879793          	slli	a5,a5,0x8
8000451c:	00f767b3          	or	a5,a4,a5
	rv = rv << 8 | ptr[0];
80004520:	00879793          	slli	a5,a5,0x8
80004524:	00f467b3          	or	a5,s0,a5
			val = ld_dword(fs->win + clst * 4 % SS(fs)) & 0x0FFFFFFF;	/* Simple DWORD array but mask out upper 4 bits */
80004528:	00479413          	slli	s0,a5,0x4
8000452c:	00445413          	srli	s0,s0,0x4
			break;
80004530:	ed5ff06f          	j	80004404 <get_fat+0xd4>
			if (move_window(fs, fs->fatbase + (clst / (SS(fs) / 2))) != FR_OK) break;
80004534:	02892703          	lw	a4,40(s2)
	if (sect != fs->winsect) {	/* Window offset changed? */
80004538:	03892783          	lw	a5,56(s2)
			if (move_window(fs, fs->fatbase + (clst / (SS(fs) / 2))) != FR_OK) break;
8000453c:	0085d593          	srli	a1,a1,0x8
80004540:	00e585b3          	add	a1,a1,a4
	if (sect != fs->winsect) {	/* Window offset changed? */
80004544:	00f58863          	beq	a1,a5,80004554 <get_fat+0x224>
80004548:	00090513          	mv	a0,s2
8000454c:	a4dff0ef          	jal	ra,80003f98 <move_window.part.6>
			if (move_window(fs, fs->fatbase + (clst / (SS(fs) / 2))) != FR_OK) break;
80004550:	04051663          	bnez	a0,8000459c <get_fat+0x26c>
			val = ld_word(fs->win + clst * 2 % SS(fs));		/* Simple WORD array */
80004554:	00149593          	slli	a1,s1,0x1
80004558:	03c90913          	addi	s2,s2,60
8000455c:	1fe5f593          	andi	a1,a1,510
80004560:	00b90933          	add	s2,s2,a1
	rv = rv << 8 | ptr[0];
80004564:	00194403          	lbu	s0,1(s2)
80004568:	00094783          	lbu	a5,0(s2)
8000456c:	00841413          	slli	s0,s0,0x8
			val = ld_word(fs->win + clst * 2 % SS(fs));		/* Simple WORD array */
80004570:	00f46433          	or	s0,s0,a5
			break;
80004574:	e91ff06f          	j	80004404 <get_fat+0xd4>
			if ((obj->objsize != 0 && obj->sclust != 0) || obj->stat == 0) {	/* Object except root dir must have valid data length */
80004578:	00852583          	lw	a1,8(a0)
8000457c:	e0058ee3          	beqz	a1,80004398 <get_fat+0x68>
				DWORD cofs = clst - obj->sclust;	/* Offset from start cluster */
80004580:	40b489b3          	sub	s3,s1,a1
				if (obj->stat == 2 && cofs <= clen) {	/* Is it a contiguous chain? */
80004584:	02e60063          	beq	a2,a4,800045a4 <get_fat+0x274>
				if (obj->stat == 3 && cofs < obj->n_cont) {	/* Is it in the 1st fragment? */
80004588:	e0d61ae3          	bne	a2,a3,8000439c <get_fat+0x6c>
8000458c:	01852783          	lw	a5,24(a0)
80004590:	e0f9f6e3          	bgeu	s3,a5,8000439c <get_fat+0x6c>
					val = (cofs == clen) ? 0x7FFFFFFF : clst + 1;	/* No data on the FAT, generate the value */
80004594:	00148413          	addi	s0,s1,1
80004598:	e6dff06f          	j	80004404 <get_fat+0xd4>
		val = 0xFFFFFFFF;	/* Default value falls on disk error */
8000459c:	fff00413          	li	s0,-1
800045a0:	e65ff06f          	j	80004404 <get_fat+0xd4>
				DWORD clen = (DWORD)((LBA_t)((obj->objsize - 1) / SS(fs)) / fs->csize);	/* Number of clusters - 1 */
800045a4:	fff78713          	addi	a4,a5,-1
800045a8:	00f737b3          	sltu	a5,a4,a5
800045ac:	fff80813          	addi	a6,a6,-1
800045b0:	010787b3          	add	a5,a5,a6
800045b4:	00a95583          	lhu	a1,10(s2)
800045b8:	01779793          	slli	a5,a5,0x17
800045bc:	00975713          	srli	a4,a4,0x9
800045c0:	00e7e533          	or	a0,a5,a4
800045c4:	40c090ef          	jal	ra,8000d9d0 <__udivsi3>
				if (obj->stat == 2 && cofs <= clen) {	/* Is it a contiguous chain? */
800045c8:	e3356ee3          	bltu	a0,s3,80004404 <get_fat+0xd4>
					val = (cofs == clen) ? 0x7FFFFFFF : clst + 1;	/* No data on the FAT, generate the value */
800045cc:	fca994e3          	bne	s3,a0,80004594 <get_fat+0x264>
800045d0:	80000437          	lui	s0,0x80000
800045d4:	fff44413          	not	s0,s0
	return val;
800045d8:	e2dff06f          	j	80004404 <get_fat+0xd4>

800045dc <dir_sdi>:
{
800045dc:	fd010113          	addi	sp,sp,-48
800045e0:	01312e23          	sw	s3,28(sp)
	FATFS *fs = dp->obj.fs;
800045e4:	00052983          	lw	s3,0(a0)
{
800045e8:	02912223          	sw	s1,36(sp)
800045ec:	03212023          	sw	s2,32(sp)
800045f0:	02112623          	sw	ra,44(sp)
800045f4:	02812423          	sw	s0,40(sp)
800045f8:	01412c23          	sw	s4,24(sp)
800045fc:	01512a23          	sw	s5,20(sp)
80004600:	01612823          	sw	s6,16(sp)
80004604:	01712623          	sw	s7,12(sp)
	if (ofs >= (DWORD)((FF_FS_EXFAT && fs->fs_type == FS_EXFAT) ? MAX_DIR_EX : MAX_DIR) || ofs % SZDIRE) {	/* Check range of offset and alignment */
80004608:	0009c703          	lbu	a4,0(s3)
8000460c:	00400693          	li	a3,4
{
80004610:	00050913          	mv	s2,a0
80004614:	00058493          	mv	s1,a1
	if (ofs >= (DWORD)((FF_FS_EXFAT && fs->fs_type == FS_EXFAT) ? MAX_DIR_EX : MAX_DIR) || ofs % SZDIRE) {	/* Check range of offset and alignment */
80004618:	002007b7          	lui	a5,0x200
8000461c:	0ad70063          	beq	a4,a3,800046bc <dir_sdi+0xe0>
80004620:	06f4f463          	bgeu	s1,a5,80004688 <dir_sdi+0xac>
80004624:	01f4fa93          	andi	s5,s1,31
80004628:	060a9063          	bnez	s5,80004688 <dir_sdi+0xac>
	clst = dp->obj.sclust;		/* Table start cluster (0:root) */
8000462c:	00892403          	lw	s0,8(s2)
	dp->dptr = ofs;				/* Set current offset */
80004630:	02992823          	sw	s1,48(s2)
	if (clst == 0 && fs->fs_type >= FS_FAT32) {	/* Replace cluster# 0 with root cluster# */
80004634:	08040863          	beqz	s0,800046c4 <dir_sdi+0xe8>
		csz = (DWORD)fs->csize * SS(fs);	/* Bytes per cluster */
80004638:	00a9da03          	lhu	s4,10(s3)
8000463c:	009a1a13          	slli	s4,s4,0x9
		while (ofs >= csz) {				/* Follow cluster chain */
80004640:	0d44ee63          	bltu	s1,s4,8000471c <dir_sdi+0x140>
			if (clst == 0xFFFFFFFF) return FR_DISK_ERR;	/* Disk error */
80004644:	fff00b13          	li	s6,-1
			if (clst < 2 || clst >= fs->n_fatent) return FR_INT_ERR;	/* Reached to end of table or internal error */
80004648:	00100b93          	li	s7,1
8000464c:	0140006f          	j	80004660 <dir_sdi+0x84>
80004650:	02abfc63          	bgeu	s7,a0,80004688 <dir_sdi+0xac>
80004654:	01c9a783          	lw	a5,28(s3)
80004658:	02f57863          	bgeu	a0,a5,80004688 <dir_sdi+0xac>
		while (ofs >= csz) {				/* Follow cluster chain */
8000465c:	0d44e263          	bltu	s1,s4,80004720 <dir_sdi+0x144>
			clst = get_fat(&dp->obj, clst);				/* Get next cluster */
80004660:	00040593          	mv	a1,s0
80004664:	00090513          	mv	a0,s2
80004668:	cc9ff0ef          	jal	ra,80004330 <get_fat>
8000466c:	00050413          	mv	s0,a0
			ofs -= csz;
80004670:	414484b3          	sub	s1,s1,s4
			if (clst == 0xFFFFFFFF) return FR_DISK_ERR;	/* Disk error */
80004674:	fd651ee3          	bne	a0,s6,80004650 <dir_sdi+0x74>
80004678:	00100a93          	li	s5,1
8000467c:	0100006f          	j	8000468c <dir_sdi+0xb0>
		dp->sect = clst2sect(fs, clst);
80004680:	02092c23          	sw	zero,56(s2)
	dp->clust = clst;					/* Current cluster# */
80004684:	02892a23          	sw	s0,52(s2)
		return FR_INT_ERR;
80004688:	00200a93          	li	s5,2
}
8000468c:	02c12083          	lw	ra,44(sp)
80004690:	02812403          	lw	s0,40(sp)
80004694:	000a8513          	mv	a0,s5
80004698:	02412483          	lw	s1,36(sp)
8000469c:	02012903          	lw	s2,32(sp)
800046a0:	01c12983          	lw	s3,28(sp)
800046a4:	01812a03          	lw	s4,24(sp)
800046a8:	01412a83          	lw	s5,20(sp)
800046ac:	01012b03          	lw	s6,16(sp)
800046b0:	00c12b83          	lw	s7,12(sp)
800046b4:	03010113          	addi	sp,sp,48
800046b8:	00008067          	ret
800046bc:	100007b7          	lui	a5,0x10000
800046c0:	f61ff06f          	j	80004620 <dir_sdi+0x44>
	if (clst == 0 && fs->fs_type >= FS_FAT32) {	/* Replace cluster# 0 with root cluster# */
800046c4:	00200793          	li	a5,2
800046c8:	04e7e063          	bltu	a5,a4,80004708 <dir_sdi+0x12c>
		if (ofs / SZDIRE >= fs->n_rootdir) return FR_INT_ERR;	/* Is index out of range? */
800046cc:	0089d783          	lhu	a5,8(s3)
800046d0:	0054d713          	srli	a4,s1,0x5
800046d4:	faf77ae3          	bgeu	a4,a5,80004688 <dir_sdi+0xac>
		dp->sect = fs->dirbase;
800046d8:	02c9a503          	lw	a0,44(s3)
800046dc:	02a92c23          	sw	a0,56(s2)
	dp->clust = clst;					/* Current cluster# */
800046e0:	02892a23          	sw	s0,52(s2)
	if (dp->sect == 0) return FR_INT_ERR;
800046e4:	fa0502e3          	beqz	a0,80004688 <dir_sdi+0xac>
	dp->sect += ofs / SS(fs);			/* Sector# of the directory entry */
800046e8:	0094d793          	srli	a5,s1,0x9
	dp->dir = fs->win + (ofs % SS(fs));	/* Pointer to the entry in the win[] */
800046ec:	03c98993          	addi	s3,s3,60
800046f0:	1ff4f493          	andi	s1,s1,511
	dp->sect += ofs / SS(fs);			/* Sector# of the directory entry */
800046f4:	00a78533          	add	a0,a5,a0
	dp->dir = fs->win + (ofs % SS(fs));	/* Pointer to the entry in the win[] */
800046f8:	009984b3          	add	s1,s3,s1
	dp->sect += ofs / SS(fs);			/* Sector# of the directory entry */
800046fc:	02a92c23          	sw	a0,56(s2)
	dp->dir = fs->win + (ofs % SS(fs));	/* Pointer to the entry in the win[] */
80004700:	02992e23          	sw	s1,60(s2)
	return FR_OK;
80004704:	f89ff06f          	j	8000468c <dir_sdi+0xb0>
		clst = (DWORD)fs->dirbase;
80004708:	02c9a783          	lw	a5,44(s3)
		if (FF_FS_EXFAT) dp->obj.stat = 0;	/* exFAT: Root dir has an FAT chain */
8000470c:	000903a3          	sb	zero,7(s2)
	if (clst == 0) {	/* Static table (root-directory on the FAT volume) */
80004710:	fa078ee3          	beqz	a5,800046cc <dir_sdi+0xf0>
80004714:	00078413          	mv	s0,a5
80004718:	f21ff06f          	j	80004638 <dir_sdi+0x5c>
8000471c:	01c9a783          	lw	a5,28(s3)
	clst -= 2;		/* Cluster number is origin from 2 */
80004720:	ffe40593          	addi	a1,s0,-2 # 7ffffffe <STACK_TOP+0xfffdfffe>
	if (clst >= fs->n_fatent - 2) return 0;		/* Is it invalid cluster number? */
80004724:	ffe78793          	addi	a5,a5,-2 # ffffffe <crtStart-0x70000002>
80004728:	f4f5fce3          	bgeu	a1,a5,80004680 <dir_sdi+0xa4>
	return fs->database + (LBA_t)fs->csize * clst;	/* Start sector number of the cluster */
8000472c:	00a9d503          	lhu	a0,10(s3)
80004730:	274090ef          	jal	ra,8000d9a4 <__mulsi3>
80004734:	0309a783          	lw	a5,48(s3)
80004738:	00f50533          	add	a0,a0,a5
		dp->sect = clst2sect(fs, clst);
8000473c:	02a92c23          	sw	a0,56(s2)
80004740:	fa1ff06f          	j	800046e0 <dir_sdi+0x104>

80004744 <put_fat.part.7>:
static FRESULT put_fat (	/* FR_OK(0):succeeded, !=0:error */
80004744:	fe010113          	addi	sp,sp,-32
80004748:	00812c23          	sw	s0,24(sp)
8000474c:	00912a23          	sw	s1,20(sp)
80004750:	01212823          	sw	s2,16(sp)
80004754:	00112e23          	sw	ra,28(sp)
80004758:	01312623          	sw	s3,12(sp)
8000475c:	01412423          	sw	s4,8(sp)
80004760:	01512223          	sw	s5,4(sp)
		switch (fs->fs_type) {
80004764:	00054783          	lbu	a5,0(a0)
80004768:	00200713          	li	a4,2
static FRESULT put_fat (	/* FR_OK(0):succeeded, !=0:error */
8000476c:	00050413          	mv	s0,a0
80004770:	00058493          	mv	s1,a1
80004774:	00060913          	mv	s2,a2
		switch (fs->fs_type) {
80004778:	16e78a63          	beq	a5,a4,800048ec <put_fat.part.7+0x1a8>
8000477c:	0cf76063          	bltu	a4,a5,8000483c <put_fat.part.7+0xf8>
80004780:	00100713          	li	a4,1
80004784:	16e79063          	bne	a5,a4,800048e4 <put_fat.part.7+0x1a0>
			bc = (UINT)clst; bc += bc / 2;	/* bc: byte offset of the entry */
80004788:	0015d993          	srli	s3,a1,0x1
			res = move_window(fs, fs->fatbase + (bc / SS(fs)));
8000478c:	02852703          	lw	a4,40(a0)
			bc = (UINT)clst; bc += bc / 2;	/* bc: byte offset of the entry */
80004790:	00b989b3          	add	s3,s3,a1
	if (sect != fs->winsect) {	/* Window offset changed? */
80004794:	03852783          	lw	a5,56(a0)
			res = move_window(fs, fs->fatbase + (bc / SS(fs)));
80004798:	0099d593          	srli	a1,s3,0x9
8000479c:	00e585b3          	add	a1,a1,a4
	if (sect != fs->winsect) {	/* Window offset changed? */
800047a0:	00f58863          	beq	a1,a5,800047b0 <put_fat.part.7+0x6c>
800047a4:	ff4ff0ef          	jal	ra,80003f98 <move_window.part.6>
800047a8:	00050713          	mv	a4,a0
			if (res != FR_OK) break;
800047ac:	06051463          	bnez	a0,80004814 <put_fat.part.7+0xd0>
			p = fs->win + bc++ % SS(fs);
800047b0:	00198a13          	addi	s4,s3,1
800047b4:	03c40a93          	addi	s5,s0,60
800047b8:	1ff9f993          	andi	s3,s3,511
			*p = (clst & 1) ? ((*p & 0x0F) | ((BYTE)val << 4)) : (BYTE)val;	/* Update 1st byte */
800047bc:	0014f493          	andi	s1,s1,1
			p = fs->win + bc++ % SS(fs);
800047c0:	013a89b3          	add	s3,s5,s3
			*p = (clst & 1) ? ((*p & 0x0F) | ((BYTE)val << 4)) : (BYTE)val;	/* Update 1st byte */
800047c4:	009a5593          	srli	a1,s4,0x9
800047c8:	18048e63          	beqz	s1,80004964 <put_fat.part.7+0x220>
800047cc:	0009c703          	lbu	a4,0(s3)
800047d0:	000016b7          	lui	a3,0x1
800047d4:	ff068693          	addi	a3,a3,-16 # ff0 <crtStart-0x7ffff010>
800047d8:	00491793          	slli	a5,s2,0x4
800047dc:	00f77713          	andi	a4,a4,15
800047e0:	00d7f7b3          	and	a5,a5,a3
800047e4:	00f767b3          	or	a5,a4,a5
800047e8:	00f98023          	sb	a5,0(s3)
			res = move_window(fs, fs->fatbase + (bc / SS(fs)));
800047ec:	02842703          	lw	a4,40(s0)
	if (sect != fs->winsect) {	/* Window offset changed? */
800047f0:	03842783          	lw	a5,56(s0)
			fs->wflag = 1;
800047f4:	00100693          	li	a3,1
800047f8:	00d40223          	sb	a3,4(s0)
			res = move_window(fs, fs->fatbase + (bc / SS(fs)));
800047fc:	00e585b3          	add	a1,a1,a4
	if (sect != fs->winsect) {	/* Window offset changed? */
80004800:	14f58063          	beq	a1,a5,80004940 <put_fat.part.7+0x1fc>
80004804:	00040513          	mv	a0,s0
80004808:	f90ff0ef          	jal	ra,80003f98 <move_window.part.6>
8000480c:	00050713          	mv	a4,a0
			if (res != FR_OK) break;
80004810:	12050863          	beqz	a0,80004940 <put_fat.part.7+0x1fc>
}
80004814:	01c12083          	lw	ra,28(sp)
80004818:	01812403          	lw	s0,24(sp)
8000481c:	01412483          	lw	s1,20(sp)
80004820:	01012903          	lw	s2,16(sp)
80004824:	00c12983          	lw	s3,12(sp)
80004828:	00812a03          	lw	s4,8(sp)
8000482c:	00412a83          	lw	s5,4(sp)
80004830:	00070513          	mv	a0,a4
80004834:	02010113          	addi	sp,sp,32
80004838:	00008067          	ret
		switch (fs->fs_type) {
8000483c:	00400693          	li	a3,4
	FRESULT res = FR_INT_ERR;
80004840:	00200713          	li	a4,2
		switch (fs->fs_type) {
80004844:	fcf6e8e3          	bltu	a3,a5,80004814 <put_fat.part.7+0xd0>
			res = move_window(fs, fs->fatbase + (clst / (SS(fs) / 4)));
80004848:	02852683          	lw	a3,40(a0)
	if (sect != fs->winsect) {	/* Window offset changed? */
8000484c:	03852703          	lw	a4,56(a0)
			res = move_window(fs, fs->fatbase + (clst / (SS(fs) / 4)));
80004850:	0075d593          	srli	a1,a1,0x7
80004854:	00d585b3          	add	a1,a1,a3
	if (sect != fs->winsect) {	/* Window offset changed? */
80004858:	00e58a63          	beq	a1,a4,8000486c <put_fat.part.7+0x128>
8000485c:	f3cff0ef          	jal	ra,80003f98 <move_window.part.6>
80004860:	00050713          	mv	a4,a0
			if (res != FR_OK) break;
80004864:	fa0518e3          	bnez	a0,80004814 <put_fat.part.7+0xd0>
80004868:	00044783          	lbu	a5,0(s0)
			if (!FF_FS_EXFAT || fs->fs_type != FS_EXFAT) {
8000486c:	00249493          	slli	s1,s1,0x2
80004870:	03c40713          	addi	a4,s0,60
80004874:	1fc4f493          	andi	s1,s1,508
80004878:	00400693          	li	a3,4
8000487c:	009704b3          	add	s1,a4,s1
80004880:	02d78c63          	beq	a5,a3,800048b8 <put_fat.part.7+0x174>
	rv = rv << 8 | ptr[2];
80004884:	0034c703          	lbu	a4,3(s1)
80004888:	0024c683          	lbu	a3,2(s1)
	rv = rv << 8 | ptr[1];
8000488c:	0014c783          	lbu	a5,1(s1)
	rv = rv << 8 | ptr[2];
80004890:	00871713          	slli	a4,a4,0x8
80004894:	00d76733          	or	a4,a4,a3
	rv = rv << 8 | ptr[1];
80004898:	00871713          	slli	a4,a4,0x8
8000489c:	00e7e7b3          	or	a5,a5,a4
				val = (val & 0x0FFFFFFF) | (ld_dword(fs->win + clst * 4 % SS(fs)) & 0xF0000000);
800048a0:	00491913          	slli	s2,s2,0x4
	rv = rv << 8 | ptr[0];
800048a4:	00879793          	slli	a5,a5,0x8
				val = (val & 0x0FFFFFFF) | (ld_dword(fs->win + clst * 4 % SS(fs)) & 0xF0000000);
800048a8:	f0000637          	lui	a2,0xf0000
800048ac:	00495913          	srli	s2,s2,0x4
800048b0:	00c7f7b3          	and	a5,a5,a2
800048b4:	0127e933          	or	s2,a5,s2
	*ptr++ = (BYTE)val; val >>= 8;
800048b8:	01095713          	srli	a4,s2,0x10
	*ptr++ = (BYTE)val; val >>= 8;
800048bc:	01895793          	srli	a5,s2,0x18
	*ptr++ = (BYTE)val; val >>= 8;
800048c0:	00895693          	srli	a3,s2,0x8
	*ptr++ = (BYTE)val; val >>= 8;
800048c4:	00e48123          	sb	a4,2(s1)
	*ptr++ = (BYTE)val;
800048c8:	00f481a3          	sb	a5,3(s1)
	*ptr++ = (BYTE)val; val >>= 8;
800048cc:	01248023          	sb	s2,0(s1)
	*ptr++ = (BYTE)val; val >>= 8;
800048d0:	00d480a3          	sb	a3,1(s1)
			fs->wflag = 1;
800048d4:	00100793          	li	a5,1
800048d8:	00f40223          	sb	a5,4(s0)
800048dc:	00000713          	li	a4,0
800048e0:	f35ff06f          	j	80004814 <put_fat.part.7+0xd0>
	FRESULT res = FR_INT_ERR;
800048e4:	00200713          	li	a4,2
800048e8:	f2dff06f          	j	80004814 <put_fat.part.7+0xd0>
			res = move_window(fs, fs->fatbase + (clst / (SS(fs) / 2)));
800048ec:	02852703          	lw	a4,40(a0)
	if (sect != fs->winsect) {	/* Window offset changed? */
800048f0:	03852783          	lw	a5,56(a0)
			res = move_window(fs, fs->fatbase + (clst / (SS(fs) / 2)));
800048f4:	0085d593          	srli	a1,a1,0x8
800048f8:	00e585b3          	add	a1,a1,a4
	if (sect != fs->winsect) {	/* Window offset changed? */
800048fc:	00f58863          	beq	a1,a5,8000490c <put_fat.part.7+0x1c8>
80004900:	e98ff0ef          	jal	ra,80003f98 <move_window.part.6>
80004904:	00050713          	mv	a4,a0
			if (res != FR_OK) break;
80004908:	f00516e3          	bnez	a0,80004814 <put_fat.part.7+0xd0>
			st_word(fs->win + clst * 2 % SS(fs), (WORD)val);	/* Simple WORD array */
8000490c:	00149493          	slli	s1,s1,0x1
	*ptr++ = (BYTE)val; val >>= 8;
80004910:	01091713          	slli	a4,s2,0x10
			st_word(fs->win + clst * 2 % SS(fs), (WORD)val);	/* Simple WORD array */
80004914:	03c40793          	addi	a5,s0,60
	*ptr++ = (BYTE)val; val >>= 8;
80004918:	01075713          	srli	a4,a4,0x10
			st_word(fs->win + clst * 2 % SS(fs), (WORD)val);	/* Simple WORD array */
8000491c:	1fe4f493          	andi	s1,s1,510
80004920:	009784b3          	add	s1,a5,s1
	*ptr++ = (BYTE)val; val >>= 8;
80004924:	00875793          	srli	a5,a4,0x8
	*ptr++ = (BYTE)val;
80004928:	00f480a3          	sb	a5,1(s1)
	*ptr++ = (BYTE)val; val >>= 8;
8000492c:	01248023          	sb	s2,0(s1)
			fs->wflag = 1;
80004930:	00100793          	li	a5,1
80004934:	00f40223          	sb	a5,4(s0)
80004938:	00000713          	li	a4,0
8000493c:	ed9ff06f          	j	80004814 <put_fat.part.7+0xd0>
			p = fs->win + bc % SS(fs);
80004940:	1ffa7a13          	andi	s4,s4,511
			*p = (clst & 1) ? (BYTE)(val >> 4) : ((*p & 0xF0) | ((BYTE)(val >> 8) & 0x0F));	/* Update 2nd byte */
80004944:	00495913          	srli	s2,s2,0x4
			p = fs->win + bc % SS(fs);
80004948:	014a8a33          	add	s4,s5,s4
			*p = (clst & 1) ? (BYTE)(val >> 4) : ((*p & 0xF0) | ((BYTE)(val >> 8) & 0x0F));	/* Update 2nd byte */
8000494c:	0ff97913          	andi	s2,s2,255
80004950:	012a0023          	sb	s2,0(s4)
			fs->wflag = 1;
80004954:	00100793          	li	a5,1
80004958:	00f40223          	sb	a5,4(s0)
8000495c:	00000713          	li	a4,0
80004960:	eb5ff06f          	j	80004814 <put_fat.part.7+0xd0>
			*p = (clst & 1) ? ((*p & 0x0F) | ((BYTE)val << 4)) : (BYTE)val;	/* Update 1st byte */
80004964:	01298023          	sb	s2,0(s3)
			res = move_window(fs, fs->fatbase + (bc / SS(fs)));
80004968:	02842703          	lw	a4,40(s0)
	if (sect != fs->winsect) {	/* Window offset changed? */
8000496c:	03842783          	lw	a5,56(s0)
			fs->wflag = 1;
80004970:	00100693          	li	a3,1
80004974:	00d40223          	sb	a3,4(s0)
			res = move_window(fs, fs->fatbase + (bc / SS(fs)));
80004978:	00e585b3          	add	a1,a1,a4
	if (sect != fs->winsect) {	/* Window offset changed? */
8000497c:	00f58a63          	beq	a1,a5,80004990 <put_fat.part.7+0x24c>
80004980:	00040513          	mv	a0,s0
80004984:	e14ff0ef          	jal	ra,80003f98 <move_window.part.6>
80004988:	00050713          	mv	a4,a0
			if (res != FR_OK) break;
8000498c:	e80514e3          	bnez	a0,80004814 <put_fat.part.7+0xd0>
			p = fs->win + bc % SS(fs);
80004990:	1ffa7a13          	andi	s4,s4,511
80004994:	014a8a33          	add	s4,s5,s4
			*p = (clst & 1) ? (BYTE)(val >> 4) : ((*p & 0xF0) | ((BYTE)(val >> 8) & 0x0F));	/* Update 2nd byte */
80004998:	000a4783          	lbu	a5,0(s4)
8000499c:	00895913          	srli	s2,s2,0x8
800049a0:	00f97913          	andi	s2,s2,15
800049a4:	ff07f793          	andi	a5,a5,-16
800049a8:	0127e933          	or	s2,a5,s2
800049ac:	fa5ff06f          	j	80004950 <put_fat.part.7+0x20c>

800049b0 <remove_chain>:
{
800049b0:	fd010113          	addi	sp,sp,-48
800049b4:	01812423          	sw	s8,8(sp)
800049b8:	02112623          	sw	ra,44(sp)
800049bc:	02812423          	sw	s0,40(sp)
800049c0:	02912223          	sw	s1,36(sp)
800049c4:	03212023          	sw	s2,32(sp)
800049c8:	01312e23          	sw	s3,28(sp)
800049cc:	01412c23          	sw	s4,24(sp)
800049d0:	01512a23          	sw	s5,20(sp)
800049d4:	01612823          	sw	s6,16(sp)
800049d8:	01712623          	sw	s7,12(sp)
	if (clst < 2 || clst >= fs->n_fatent) return FR_INT_ERR;	/* Check if in valid range */
800049dc:	00100793          	li	a5,1
	FATFS *fs = obj->fs;
800049e0:	00052c03          	lw	s8,0(a0)
	if (clst < 2 || clst >= fs->n_fatent) return FR_INT_ERR;	/* Check if in valid range */
800049e4:	0cb7fe63          	bgeu	a5,a1,80004ac0 <remove_chain+0x110>
800049e8:	01cc2783          	lw	a5,28(s8)
800049ec:	00058413          	mv	s0,a1
800049f0:	0cf5f863          	bgeu	a1,a5,80004ac0 <remove_chain+0x110>
800049f4:	00050913          	mv	s2,a0
800049f8:	00060993          	mv	s3,a2
	if (pclst != 0 && (!FF_FS_EXFAT || fs->fs_type != FS_EXFAT || obj->stat != 2)) {
800049fc:	0a061663          	bnez	a2,80004aa8 <remove_chain+0xf8>
{
80004a00:	00040b93          	mv	s7,s0
		if (nxt == 1) return FR_INT_ERR;	/* Internal error? */
80004a04:	00100a13          	li	s4,1
		if (nxt == 0xFFFFFFFF) return FR_DISK_ERR;	/* Disk error? */
80004a08:	fff00b13          	li	s6,-1
		if (!FF_FS_EXFAT || fs->fs_type != FS_EXFAT) {
80004a0c:	00400a93          	li	s5,4
		nxt = get_fat(obj, clst);			/* Get cluster status */
80004a10:	00040593          	mv	a1,s0
80004a14:	00090513          	mv	a0,s2
80004a18:	919ff0ef          	jal	ra,80004330 <get_fat>
80004a1c:	00050493          	mv	s1,a0
		if (nxt == 0) break;				/* Empty cluster? */
80004a20:	06050a63          	beqz	a0,80004a94 <remove_chain+0xe4>
		if (nxt == 1) return FR_INT_ERR;	/* Internal error? */
80004a24:	09450e63          	beq	a0,s4,80004ac0 <remove_chain+0x110>
		if (nxt == 0xFFFFFFFF) return FR_DISK_ERR;	/* Disk error? */
80004a28:	13650463          	beq	a0,s6,80004b50 <remove_chain+0x1a0>
		if (!FF_FS_EXFAT || fs->fs_type != FS_EXFAT) {
80004a2c:	000c4783          	lbu	a5,0(s8)
80004a30:	03578263          	beq	a5,s5,80004a54 <remove_chain+0xa4>
	if (clst >= 2 && clst < fs->n_fatent) {	/* Check if in valid range */
80004a34:	088a7663          	bgeu	s4,s0,80004ac0 <remove_chain+0x110>
80004a38:	01cc2783          	lw	a5,28(s8)
80004a3c:	08f47263          	bgeu	s0,a5,80004ac0 <remove_chain+0x110>
80004a40:	00000613          	li	a2,0
80004a44:	00040593          	mv	a1,s0
80004a48:	000c0513          	mv	a0,s8
80004a4c:	cf9ff0ef          	jal	ra,80004744 <put_fat.part.7>
			if (res != FR_OK) return res;
80004a50:	06051a63          	bnez	a0,80004ac4 <remove_chain+0x114>
		if (fs->free_clst < fs->n_fatent - 2) {	/* Update FSINFO */
80004a54:	01cc2703          	lw	a4,28(s8)
80004a58:	018c2783          	lw	a5,24(s8)
80004a5c:	ffe70693          	addi	a3,a4,-2
80004a60:	00d7fc63          	bgeu	a5,a3,80004a78 <remove_chain+0xc8>
			fs->fsi_flag |= 1;
80004a64:	005c4683          	lbu	a3,5(s8)
			fs->free_clst++;
80004a68:	00178793          	addi	a5,a5,1
80004a6c:	00fc2c23          	sw	a5,24(s8)
			fs->fsi_flag |= 1;
80004a70:	0016e793          	ori	a5,a3,1
80004a74:	00fc02a3          	sb	a5,5(s8)
		if (ecl + 1 == nxt) {	/* Is next cluster contiguous? */
80004a78:	00140413          	addi	s0,s0,1
80004a7c:	00940863          	beq	s0,s1,80004a8c <remove_chain+0xdc>
			if (fs->fs_type == FS_EXFAT) {
80004a80:	000c4783          	lbu	a5,0(s8)
80004a84:	09578c63          	beq	a5,s5,80004b1c <remove_chain+0x16c>
80004a88:	00048b93          	mv	s7,s1
		clst = nxt;					/* Next cluster */
80004a8c:	00048413          	mv	s0,s1
	} while (clst < fs->n_fatent);	/* Repeat while not the last link */
80004a90:	f8e4e0e3          	bltu	s1,a4,80004a10 <remove_chain+0x60>
	if (fs->fs_type == FS_EXFAT) {
80004a94:	000c4703          	lbu	a4,0(s8)
80004a98:	00400793          	li	a5,4
80004a9c:	0af70263          	beq	a4,a5,80004b40 <remove_chain+0x190>
	return FR_OK;
80004aa0:	00000513          	li	a0,0
80004aa4:	0200006f          	j	80004ac4 <remove_chain+0x114>
	if (pclst != 0 && (!FF_FS_EXFAT || fs->fs_type != FS_EXFAT || obj->stat != 2)) {
80004aa8:	000c4683          	lbu	a3,0(s8)
80004aac:	00400713          	li	a4,4
80004ab0:	04e68e63          	beq	a3,a4,80004b0c <remove_chain+0x15c>
	if (clst >= 2 && clst < fs->n_fatent) {	/* Check if in valid range */
80004ab4:	00100713          	li	a4,1
80004ab8:	01377463          	bgeu	a4,s3,80004ac0 <remove_chain+0x110>
80004abc:	02f9ec63          	bltu	s3,a5,80004af4 <remove_chain+0x144>
	if (clst < 2 || clst >= fs->n_fatent) return FR_INT_ERR;	/* Check if in valid range */
80004ac0:	00200513          	li	a0,2
}
80004ac4:	02c12083          	lw	ra,44(sp)
80004ac8:	02812403          	lw	s0,40(sp)
80004acc:	02412483          	lw	s1,36(sp)
80004ad0:	02012903          	lw	s2,32(sp)
80004ad4:	01c12983          	lw	s3,28(sp)
80004ad8:	01812a03          	lw	s4,24(sp)
80004adc:	01412a83          	lw	s5,20(sp)
80004ae0:	01012b03          	lw	s6,16(sp)
80004ae4:	00c12b83          	lw	s7,12(sp)
80004ae8:	00812c03          	lw	s8,8(sp)
80004aec:	03010113          	addi	sp,sp,48
80004af0:	00008067          	ret
80004af4:	fff00613          	li	a2,-1
80004af8:	00098593          	mv	a1,s3
80004afc:	000c0513          	mv	a0,s8
80004b00:	c45ff0ef          	jal	ra,80004744 <put_fat.part.7>
		if (res != FR_OK) return res;
80004b04:	ee050ee3          	beqz	a0,80004a00 <remove_chain+0x50>
80004b08:	fbdff06f          	j	80004ac4 <remove_chain+0x114>
	if (pclst != 0 && (!FF_FS_EXFAT || fs->fs_type != FS_EXFAT || obj->stat != 2)) {
80004b0c:	00754683          	lbu	a3,7(a0)
80004b10:	00200713          	li	a4,2
80004b14:	fae690e3          	bne	a3,a4,80004ab4 <remove_chain+0x104>
80004b18:	ee9ff06f          	j	80004a00 <remove_chain+0x50>
				res = change_bitmap(fs, scl, ecl - scl + 1, 0);	/* Mark the cluster block 'free' on the bitmap */
80004b1c:	00000693          	li	a3,0
80004b20:	41740633          	sub	a2,s0,s7
80004b24:	000b8593          	mv	a1,s7
80004b28:	000c0513          	mv	a0,s8
80004b2c:	ed4ff0ef          	jal	ra,80004200 <change_bitmap>
				if (res != FR_OK) return res;
80004b30:	f8051ae3          	bnez	a0,80004ac4 <remove_chain+0x114>
80004b34:	01cc2703          	lw	a4,28(s8)
80004b38:	00048b93          	mv	s7,s1
80004b3c:	f51ff06f          	j	80004a8c <remove_chain+0xdc>
		if (pclst == 0) {	/* Has the entire chain been removed? */
80004b40:	00099c63          	bnez	s3,80004b58 <remove_chain+0x1a8>
			obj->stat = 0;		/* Change the chain status 'initial' */
80004b44:	000903a3          	sb	zero,7(s2)
	return FR_OK;
80004b48:	00000513          	li	a0,0
80004b4c:	f79ff06f          	j	80004ac4 <remove_chain+0x114>
		if (nxt == 0xFFFFFFFF) return FR_DISK_ERR;	/* Disk error? */
80004b50:	00100513          	li	a0,1
80004b54:	f71ff06f          	j	80004ac4 <remove_chain+0x114>
			if (obj->stat == 0) {	/* Is it a fragmented chain from the beginning of this session? */
80004b58:	00794783          	lbu	a5,7(s2)
80004b5c:	04079063          	bnez	a5,80004b9c <remove_chain+0x1ec>
				clst = obj->sclust;		/* Follow the chain to check if it gets contiguous */
80004b60:	00892403          	lw	s0,8(s2)
				while (clst != pclst) {
80004b64:	04898a63          	beq	s3,s0,80004bb8 <remove_chain+0x208>
					if (nxt < 2) return FR_INT_ERR;
80004b68:	00100493          	li	s1,1
					if (nxt == 0xFFFFFFFF) return FR_DISK_ERR;
80004b6c:	fff00a13          	li	s4,-1
80004b70:	0100006f          	j	80004b80 <remove_chain+0x1d0>
80004b74:	fd450ee3          	beq	a0,s4,80004b50 <remove_chain+0x1a0>
					if (nxt != clst + 1) break;	/* Not contiguous? */
80004b78:	f2a794e3          	bne	a5,a0,80004aa0 <remove_chain+0xf0>
				while (clst != pclst) {
80004b7c:	02f98e63          	beq	s3,a5,80004bb8 <remove_chain+0x208>
					nxt = get_fat(obj, clst);
80004b80:	00040593          	mv	a1,s0
80004b84:	00090513          	mv	a0,s2
80004b88:	fa8ff0ef          	jal	ra,80004330 <get_fat>
					if (nxt != clst + 1) break;	/* Not contiguous? */
80004b8c:	00140793          	addi	a5,s0,1
80004b90:	00078413          	mv	s0,a5
					if (nxt < 2) return FR_INT_ERR;
80004b94:	fea4e0e3          	bltu	s1,a0,80004b74 <remove_chain+0x1c4>
80004b98:	f29ff06f          	j	80004ac0 <remove_chain+0x110>
				if (obj->stat == 3 && pclst >= obj->sclust && pclst <= obj->sclust + obj->n_cont) {	/* Was the chain fragmented in this session and got contiguous again? */
80004b9c:	00300713          	li	a4,3
80004ba0:	f0e790e3          	bne	a5,a4,80004aa0 <remove_chain+0xf0>
80004ba4:	00892783          	lw	a5,8(s2)
80004ba8:	eef9ece3          	bltu	s3,a5,80004aa0 <remove_chain+0xf0>
80004bac:	01892703          	lw	a4,24(s2)
80004bb0:	00e787b3          	add	a5,a5,a4
80004bb4:	ef37e6e3          	bltu	a5,s3,80004aa0 <remove_chain+0xf0>
					obj->stat = 2;	/* Change the chain status 'contiguous' */
80004bb8:	00200793          	li	a5,2
80004bbc:	00f903a3          	sb	a5,7(s2)
	return FR_OK;
80004bc0:	00000513          	li	a0,0
80004bc4:	f01ff06f          	j	80004ac4 <remove_chain+0x114>

80004bc8 <fill_last_frag.isra.8.part.9>:
	while (obj->n_frag > 0) {	/* Create the chain of last fragment */
80004bc8:	0005a783          	lw	a5,0(a1)
80004bcc:	0a078e63          	beqz	a5,80004c88 <fill_last_frag.isra.8.part.9+0xc0>
static FRESULT fill_last_frag (
80004bd0:	fe010113          	addi	sp,sp,-32
80004bd4:	00812c23          	sw	s0,24(sp)
80004bd8:	00912a23          	sw	s1,20(sp)
80004bdc:	01212823          	sw	s2,16(sp)
80004be0:	01312623          	sw	s3,12(sp)
80004be4:	01412423          	sw	s4,8(sp)
80004be8:	00112e23          	sw	ra,28(sp)
80004bec:	00068913          	mv	s2,a3
80004bf0:	00060493          	mv	s1,a2
80004bf4:	00050a13          	mv	s4,a0
80004bf8:	00058413          	mv	s0,a1
		res = put_fat(obj->fs, lcl - obj->n_frag + 1, (obj->n_frag > 1) ? lcl - obj->n_frag + 2 : term);
80004bfc:	00100993          	li	s3,1
80004c00:	40f486b3          	sub	a3,s1,a5
80004c04:	00168713          	addi	a4,a3,1
80004c08:	00070593          	mv	a1,a4
80004c0c:	00090613          	mv	a2,s2
80004c10:	00f9f463          	bgeu	s3,a5,80004c18 <fill_last_frag.isra.8.part.9+0x50>
80004c14:	00268613          	addi	a2,a3,2
	if (clst >= 2 && clst < fs->n_fatent) {	/* Check if in valid range */
80004c18:	04e9f663          	bgeu	s3,a4,80004c64 <fill_last_frag.isra.8.part.9+0x9c>
		res = put_fat(obj->fs, lcl - obj->n_frag + 1, (obj->n_frag > 1) ? lcl - obj->n_frag + 2 : term);
80004c1c:	000a2503          	lw	a0,0(s4)
	if (clst >= 2 && clst < fs->n_fatent) {	/* Check if in valid range */
80004c20:	01c52783          	lw	a5,28(a0)
80004c24:	04f77063          	bgeu	a4,a5,80004c64 <fill_last_frag.isra.8.part.9+0x9c>
80004c28:	b1dff0ef          	jal	ra,80004744 <put_fat.part.7>
		if (res != FR_OK) return res;
80004c2c:	00051c63          	bnez	a0,80004c44 <fill_last_frag.isra.8.part.9+0x7c>
		obj->n_frag--;
80004c30:	00042783          	lw	a5,0(s0)
80004c34:	fff78793          	addi	a5,a5,-1
80004c38:	00f42023          	sw	a5,0(s0)
	while (obj->n_frag > 0) {	/* Create the chain of last fragment */
80004c3c:	fc0792e3          	bnez	a5,80004c00 <fill_last_frag.isra.8.part.9+0x38>
	return FR_OK;
80004c40:	00000513          	li	a0,0
}
80004c44:	01c12083          	lw	ra,28(sp)
80004c48:	01812403          	lw	s0,24(sp)
80004c4c:	01412483          	lw	s1,20(sp)
80004c50:	01012903          	lw	s2,16(sp)
80004c54:	00c12983          	lw	s3,12(sp)
80004c58:	00812a03          	lw	s4,8(sp)
80004c5c:	02010113          	addi	sp,sp,32
80004c60:	00008067          	ret
80004c64:	01c12083          	lw	ra,28(sp)
80004c68:	01812403          	lw	s0,24(sp)
80004c6c:	01412483          	lw	s1,20(sp)
80004c70:	01012903          	lw	s2,16(sp)
80004c74:	00c12983          	lw	s3,12(sp)
80004c78:	00812a03          	lw	s4,8(sp)
	FRESULT res = FR_INT_ERR;
80004c7c:	00200513          	li	a0,2
}
80004c80:	02010113          	addi	sp,sp,32
80004c84:	00008067          	ret
	return FR_OK;
80004c88:	00000513          	li	a0,0
}
80004c8c:	00008067          	ret

80004c90 <fill_first_frag.part.10>:
static FRESULT fill_first_frag (
80004c90:	fe010113          	addi	sp,sp,-32
80004c94:	00912a23          	sw	s1,20(sp)
		for (cl = obj->sclust, n = obj->n_cont; n; cl++, n--) {	/* Create cluster chain on the FAT */
80004c98:	01852483          	lw	s1,24(a0)
static FRESULT fill_first_frag (
80004c9c:	01212823          	sw	s2,16(sp)
80004ca0:	00112e23          	sw	ra,28(sp)
80004ca4:	00812c23          	sw	s0,24(sp)
80004ca8:	01312623          	sw	s3,12(sp)
80004cac:	00050913          	mv	s2,a0
		for (cl = obj->sclust, n = obj->n_cont; n; cl++, n--) {	/* Create cluster chain on the FAT */
80004cb0:	00852783          	lw	a5,8(a0)
80004cb4:	08048263          	beqz	s1,80004d38 <fill_first_frag.part.10+0xa8>
	if (clst >= 2 && clst < fs->n_fatent) {	/* Check if in valid range */
80004cb8:	00100713          	li	a4,1
80004cbc:	04f77e63          	bgeu	a4,a5,80004d18 <fill_first_frag.part.10+0x88>
			res = put_fat(obj->fs, cl, cl + 1);
80004cc0:	00052503          	lw	a0,0(a0)
	if (clst >= 2 && clst < fs->n_fatent) {	/* Check if in valid range */
80004cc4:	01c52703          	lw	a4,28(a0)
80004cc8:	04e7f863          	bgeu	a5,a4,80004d18 <fill_first_frag.part.10+0x88>
			res = put_fat(obj->fs, cl, cl + 1);
80004ccc:	00178413          	addi	s0,a5,1
80004cd0:	00040613          	mv	a2,s0
80004cd4:	fff40593          	addi	a1,s0,-1
80004cd8:	009784b3          	add	s1,a5,s1
	if (clst >= 2 && clst < fs->n_fatent) {	/* Check if in valid range */
80004cdc:	00100993          	li	s3,1
80004ce0:	a65ff0ef          	jal	ra,80004744 <put_fat.part.7>
			if (res != FR_OK) return res;
80004ce4:	02051c63          	bnez	a0,80004d1c <fill_first_frag.part.10+0x8c>
		for (cl = obj->sclust, n = obj->n_cont; n; cl++, n--) {	/* Create cluster chain on the FAT */
80004ce8:	04940863          	beq	s0,s1,80004d38 <fill_first_frag.part.10+0xa8>
	if (clst >= 2 && clst < fs->n_fatent) {	/* Check if in valid range */
80004cec:	0289f663          	bgeu	s3,s0,80004d18 <fill_first_frag.part.10+0x88>
			res = put_fat(obj->fs, cl, cl + 1);
80004cf0:	00092503          	lw	a0,0(s2)
80004cf4:	00140713          	addi	a4,s0,1
	if (clst >= 2 && clst < fs->n_fatent) {	/* Check if in valid range */
80004cf8:	01c52783          	lw	a5,28(a0)
80004cfc:	00f47e63          	bgeu	s0,a5,80004d18 <fill_first_frag.part.10+0x88>
80004d00:	00070413          	mv	s0,a4
80004d04:	00040613          	mv	a2,s0
80004d08:	fff40593          	addi	a1,s0,-1
80004d0c:	a39ff0ef          	jal	ra,80004744 <put_fat.part.7>
			if (res != FR_OK) return res;
80004d10:	fc050ce3          	beqz	a0,80004ce8 <fill_first_frag.part.10+0x58>
80004d14:	0080006f          	j	80004d1c <fill_first_frag.part.10+0x8c>
	FRESULT res = FR_INT_ERR;
80004d18:	00200513          	li	a0,2
}
80004d1c:	01c12083          	lw	ra,28(sp)
80004d20:	01812403          	lw	s0,24(sp)
80004d24:	01412483          	lw	s1,20(sp)
80004d28:	01012903          	lw	s2,16(sp)
80004d2c:	00c12983          	lw	s3,12(sp)
80004d30:	02010113          	addi	sp,sp,32
80004d34:	00008067          	ret
		obj->stat = 0;	/* Change status 'FAT chain is valid' */
80004d38:	000903a3          	sb	zero,7(s2)
	return FR_OK;
80004d3c:	00000513          	li	a0,0
80004d40:	fddff06f          	j	80004d1c <fill_first_frag.part.10+0x8c>

80004d44 <mount_volume>:
{
80004d44:	fc010113          	addi	sp,sp,-64
80004d48:	02912a23          	sw	s1,52(sp)
80004d4c:	03212823          	sw	s2,48(sp)
80004d50:	02112e23          	sw	ra,60(sp)
80004d54:	02812c23          	sw	s0,56(sp)
80004d58:	03312623          	sw	s3,44(sp)
80004d5c:	03412423          	sw	s4,40(sp)
80004d60:	03512223          	sw	s5,36(sp)
80004d64:	03612023          	sw	s6,32(sp)
80004d68:	01712e23          	sw	s7,28(sp)
80004d6c:	01812c23          	sw	s8,24(sp)
80004d70:	01912a23          	sw	s9,20(sp)
	*rfs = 0;
80004d74:	0005a023          	sw	zero,0(a1)
{
80004d78:	00058913          	mv	s2,a1
80004d7c:	00060493          	mv	s1,a2
	vol = get_ldnumber(path);
80004d80:	821fe0ef          	jal	ra,800035a0 <get_ldnumber>
	if (vol < 0) return FR_INVALID_DRIVE;
80004d84:	36054463          	bltz	a0,800050ec <mount_volume+0x3a8>
	fs = FatFs[vol];					/* Get pointer to the filesystem object */
80004d88:	00251513          	slli	a0,a0,0x2
80004d8c:	c7818793          	addi	a5,gp,-904 # 8000efe8 <FatFs>
80004d90:	00f50533          	add	a0,a0,a5
80004d94:	00052403          	lw	s0,0(a0)
	if (!fs) return FR_NOT_ENABLED;		/* Is the filesystem object available? */
80004d98:	34040e63          	beqz	s0,800050f4 <mount_volume+0x3b0>
	*rfs = fs;							/* Return pointer to the filesystem object */
80004d9c:	00892023          	sw	s0,0(s2)
	if (fs->fs_type != 0) {				/* If the volume has been mounted */
80004da0:	00044783          	lbu	a5,0(s0)
	mode &= (BYTE)~FA_READ;				/* Desired access mode, write access or not */
80004da4:	0fe4f493          	andi	s1,s1,254
	if (fs->fs_type != 0) {				/* If the volume has been mounted */
80004da8:	00144503          	lbu	a0,1(s0)
80004dac:	04078e63          	beqz	a5,80004e08 <mount_volume+0xc4>
		stat = disk_status(fs->pdrv);
80004db0:	ee0fe0ef          	jal	ra,80003490 <disk_status>
		if (!(stat & STA_NOINIT)) {		/* and the physical drive is kept initialized */
80004db4:	00157713          	andi	a4,a0,1
		stat = disk_status(fs->pdrv);
80004db8:	00050793          	mv	a5,a0
		if (!(stat & STA_NOINIT)) {		/* and the physical drive is kept initialized */
80004dbc:	04071463          	bnez	a4,80004e04 <mount_volume+0xc0>
			return FR_OK;				/* The filesystem object is already valid */
80004dc0:	00000513          	li	a0,0
			if (!FF_FS_READONLY && mode && (stat & STA_PROTECT)) {	/* Check write protection if needed */
80004dc4:	00048663          	beqz	s1,80004dd0 <mount_volume+0x8c>
80004dc8:	0047f793          	andi	a5,a5,4
80004dcc:	2e079863          	bnez	a5,800050bc <mount_volume+0x378>
}
80004dd0:	03c12083          	lw	ra,60(sp)
80004dd4:	03812403          	lw	s0,56(sp)
80004dd8:	03412483          	lw	s1,52(sp)
80004ddc:	03012903          	lw	s2,48(sp)
80004de0:	02c12983          	lw	s3,44(sp)
80004de4:	02812a03          	lw	s4,40(sp)
80004de8:	02412a83          	lw	s5,36(sp)
80004dec:	02012b03          	lw	s6,32(sp)
80004df0:	01c12b83          	lw	s7,28(sp)
80004df4:	01812c03          	lw	s8,24(sp)
80004df8:	01412c83          	lw	s9,20(sp)
80004dfc:	04010113          	addi	sp,sp,64
80004e00:	00008067          	ret
80004e04:	00144503          	lbu	a0,1(s0)
	fs->fs_type = 0;					/* Invalidate the filesystem object */
80004e08:	00040023          	sb	zero,0(s0)
	stat = disk_initialize(fs->pdrv);	/* Initialize the volume hosting physical drive */
80004e0c:	e9cfe0ef          	jal	ra,800034a8 <disk_initialize>
	if (stat & STA_NOINIT) { 			/* Check if the initialization succeeded */
80004e10:	00157713          	andi	a4,a0,1
	stat = disk_initialize(fs->pdrv);	/* Initialize the volume hosting physical drive */
80004e14:	00050793          	mv	a5,a0
		return FR_NOT_READY;			/* Failed to initialize due to no medium or hard error */
80004e18:	00300513          	li	a0,3
	if (stat & STA_NOINIT) { 			/* Check if the initialization succeeded */
80004e1c:	fa071ae3          	bnez	a4,80004dd0 <mount_volume+0x8c>
	if (!FF_FS_READONLY && mode && (stat & STA_PROTECT)) { /* Check disk write protection if needed */
80004e20:	00048663          	beqz	s1,80004e2c <mount_volume+0xe8>
80004e24:	0047f793          	andi	a5,a5,4
80004e28:	28079a63          	bnez	a5,800050bc <mount_volume+0x378>
	fmt = check_fs(fs, 0);				/* Load sector 0 and check if it is an FAT VBR as SFD format */
80004e2c:	00000593          	li	a1,0
80004e30:	00040513          	mv	a0,s0
80004e34:	9dcff0ef          	jal	ra,80004010 <check_fs>
	if (fmt != 2 && (fmt >= 3 || part == 0)) return fmt;	/* Returns if it is an FAT VBR as auto scan, not a BS or disk error */
80004e38:	00200793          	li	a5,2
80004e3c:	20f50063          	beq	a0,a5,8000503c <mount_volume+0x2f8>
	if (fmt == 4) return FR_DISK_ERR;		/* An error occurred in the disk I/O layer */
80004e40:	00400793          	li	a5,4
80004e44:	26f50863          	beq	a0,a5,800050b4 <mount_volume+0x370>
	if (fmt >= 2) return FR_NO_FILESYSTEM;	/* No FAT volume is found */
80004e48:	00100793          	li	a5,1
80004e4c:	28a7ec63          	bltu	a5,a0,800050e4 <mount_volume+0x3a0>
	if (fmt == 1) {
80004e50:	00100793          	li	a5,1
	bsect = fs->winsect;					/* Volume offset in the hosting physical drive */
80004e54:	03842903          	lw	s2,56(s0)
	if (fmt == 1) {
80004e58:	04744703          	lbu	a4,71(s0)
80004e5c:	2af50063          	beq	a0,a5,800050fc <mount_volume+0x3b8>
	rv = rv << 8 | ptr[0];
80004e60:	04844783          	lbu	a5,72(s0)
		if (ld_word(fs->win + BPB_BytsPerSec) != SS(fs)) return FR_NO_FILESYSTEM;	/* (BPB_BytsPerSec must be equal to the physical sector size) */
80004e64:	20000693          	li	a3,512
	rv = rv << 8 | ptr[0];
80004e68:	00879793          	slli	a5,a5,0x8
80004e6c:	00e7e733          	or	a4,a5,a4
		if (ld_word(fs->win + BPB_BytsPerSec) != SS(fs)) return FR_NO_FILESYSTEM;	/* (BPB_BytsPerSec must be equal to the physical sector size) */
80004e70:	01071713          	slli	a4,a4,0x10
80004e74:	41075713          	srai	a4,a4,0x10
80004e78:	26d71663          	bne	a4,a3,800050e4 <mount_volume+0x3a0>
	rv = rv << 8 | ptr[0];
80004e7c:	05344583          	lbu	a1,83(s0)
80004e80:	05244783          	lbu	a5,82(s0)
80004e84:	00859593          	slli	a1,a1,0x8
80004e88:	00f5e5b3          	or	a1,a1,a5
		fasize = ld_word(fs->win + BPB_FATSz16);		/* Number of sectors per FAT */
80004e8c:	00058493          	mv	s1,a1
		if (fasize == 0) fasize = ld_dword(fs->win + BPB_FATSz32);
80004e90:	28058463          	beqz	a1,80005118 <mount_volume+0x3d4>
		fs->n_fats = fs->win[BPB_NumFATs];				/* Number of FATs */
80004e94:	04c44503          	lbu	a0,76(s0)
		fs->fsize = fasize;
80004e98:	02942023          	sw	s1,32(s0)
		if (fs->n_fats != 1 && fs->n_fats != 2) return FR_NO_FILESYSTEM;	/* (Must be 1 or 2) */
80004e9c:	00100713          	li	a4,1
80004ea0:	fff50793          	addi	a5,a0,-1
		fs->n_fats = fs->win[BPB_NumFATs];				/* Number of FATs */
80004ea4:	00a401a3          	sb	a0,3(s0)
		if (fs->n_fats != 1 && fs->n_fats != 2) return FR_NO_FILESYSTEM;	/* (Must be 1 or 2) */
80004ea8:	0ff7f793          	andi	a5,a5,255
80004eac:	22f76c63          	bltu	a4,a5,800050e4 <mount_volume+0x3a0>
		fs->csize = fs->win[BPB_SecPerClus];			/* Cluster size */
80004eb0:	04944a83          	lbu	s5,73(s0)
80004eb4:	010a9793          	slli	a5,s5,0x10
80004eb8:	0107d793          	srli	a5,a5,0x10
80004ebc:	00f41523          	sh	a5,10(s0)
		if (fs->csize == 0 || (fs->csize & (fs->csize - 1))) return FR_NO_FILESYSTEM;	/* (Must be power of 2) */
80004ec0:	22078263          	beqz	a5,800050e4 <mount_volume+0x3a0>
80004ec4:	fffa8793          	addi	a5,s5,-1
80004ec8:	0157f7b3          	and	a5,a5,s5
80004ecc:	20079c63          	bnez	a5,800050e4 <mount_volume+0x3a0>
	rv = rv << 8 | ptr[0];
80004ed0:	04e44a03          	lbu	s4,78(s0)
80004ed4:	04d44783          	lbu	a5,77(s0)
80004ed8:	008a1a13          	slli	s4,s4,0x8
80004edc:	00fa6a33          	or	s4,s4,a5
80004ee0:	010a1a13          	slli	s4,s4,0x10
80004ee4:	410a5a13          	srai	s4,s4,0x10
80004ee8:	010a1c13          	slli	s8,s4,0x10
80004eec:	010c5c13          	srli	s8,s8,0x10
		fs->n_rootdir = ld_word(fs->win + BPB_RootEntCnt);	/* Number of root directory entries */
80004ef0:	01841423          	sh	s8,8(s0)
		if (fs->n_rootdir % (SS(fs) / SZDIRE)) return FR_NO_FILESYSTEM;	/* (Must be sector aligned) */
80004ef4:	00fc7793          	andi	a5,s8,15
80004ef8:	1e079663          	bnez	a5,800050e4 <mount_volume+0x3a0>
	rv = rv << 8 | ptr[0];
80004efc:	05044783          	lbu	a5,80(s0)
80004f00:	04f44703          	lbu	a4,79(s0)
80004f04:	00879793          	slli	a5,a5,0x8
80004f08:	00e7e7b3          	or	a5,a5,a4
		tsect = ld_word(fs->win + BPB_TotSec16);		/* Number of sectors on the volume */
80004f0c:	00078993          	mv	s3,a5
		if (tsect == 0) tsect = ld_dword(fs->win + BPB_TotSec32);
80004f10:	02079663          	bnez	a5,80004f3c <mount_volume+0x1f8>
	rv = rv << 8 | ptr[2];
80004f14:	05f44703          	lbu	a4,95(s0)
80004f18:	05e44783          	lbu	a5,94(s0)
	rv = rv << 8 | ptr[1];
80004f1c:	05d44983          	lbu	s3,93(s0)
	rv = rv << 8 | ptr[2];
80004f20:	00871713          	slli	a4,a4,0x8
80004f24:	00f76733          	or	a4,a4,a5
	rv = rv << 8 | ptr[1];
80004f28:	00871713          	slli	a4,a4,0x8
	rv = rv << 8 | ptr[0];
80004f2c:	05c44783          	lbu	a5,92(s0)
	rv = rv << 8 | ptr[1];
80004f30:	00e9e9b3          	or	s3,s3,a4
	rv = rv << 8 | ptr[0];
80004f34:	00899993          	slli	s3,s3,0x8
80004f38:	0137e9b3          	or	s3,a5,s3
	rv = rv << 8 | ptr[0];
80004f3c:	04b44b03          	lbu	s6,75(s0)
80004f40:	04a44783          	lbu	a5,74(s0)
80004f44:	008b1b13          	slli	s6,s6,0x8
80004f48:	00fb6b33          	or	s6,s6,a5
		if (nrsv == 0) return FR_NO_FILESYSTEM;			/* (Must not be 0) */
80004f4c:	180b0c63          	beqz	s6,800050e4 <mount_volume+0x3a0>
		fasize *= fs->n_fats;							/* Number of sectors for FAT area */
80004f50:	00048593          	mv	a1,s1
		sysect = nrsv + fasize + fs->n_rootdir / (SS(fs) / SZDIRE);	/* RSV + FAT + DIR */
80004f54:	004c5b93          	srli	s7,s8,0x4
		fasize *= fs->n_fats;							/* Number of sectors for FAT area */
80004f58:	24d080ef          	jal	ra,8000d9a4 <__mulsi3>
		sysect = nrsv + fasize + fs->n_rootdir / (SS(fs) / SZDIRE);	/* RSV + FAT + DIR */
80004f5c:	016b8bb3          	add	s7,s7,s6
80004f60:	00ab8bb3          	add	s7,s7,a0
		fasize *= fs->n_fats;							/* Number of sectors for FAT area */
80004f64:	00050c93          	mv	s9,a0
		if (tsect < sysect) return FR_NO_FILESYSTEM;	/* (Invalid volume size) */
80004f68:	1779ee63          	bltu	s3,s7,800050e4 <mount_volume+0x3a0>
		nclst = (tsect - sysect) / fs->csize;			/* Number of clusters */
80004f6c:	417989b3          	sub	s3,s3,s7
80004f70:	000a8593          	mv	a1,s5
80004f74:	00098513          	mv	a0,s3
80004f78:	259080ef          	jal	ra,8000d9d0 <__udivsi3>
		if (nclst == 0) return FR_NO_FILESYSTEM;		/* (Invalid volume size) */
80004f7c:	1759e463          	bltu	s3,s5,800050e4 <mount_volume+0x3a0>
		if (nclst <= MAX_FAT32) fmt = FS_FAT32;
80004f80:	100007b7          	lui	a5,0x10000
80004f84:	ff578793          	addi	a5,a5,-11 # ffffff5 <crtStart-0x7000000b>
80004f88:	14a7ee63          	bltu	a5,a0,800050e4 <mount_volume+0x3a0>
		if (nclst <= MAX_FAT16) fmt = FS_FAT16;
80004f8c:	000107b7          	lui	a5,0x10
80004f90:	ff578793          	addi	a5,a5,-11 # fff5 <crtStart-0x7fff000b>
80004f94:	00250713          	addi	a4,a0,2
80004f98:	012b0b33          	add	s6,s6,s2
80004f9c:	01790bb3          	add	s7,s2,s7
80004fa0:	3ea7ea63          	bltu	a5,a0,80005394 <mount_volume+0x650>
		if (nclst <= MAX_FAT12) fmt = FS_FAT12;
80004fa4:	000017b7          	lui	a5,0x1
80004fa8:	ff578793          	addi	a5,a5,-11 # ff5 <crtStart-0x7ffff00b>
		fs->n_fatent = nclst + 2;						/* Number of FAT entries */
80004fac:	00e42e23          	sw	a4,28(s0)
		fs->volbase = bsect;							/* Volume start sector */
80004fb0:	03242223          	sw	s2,36(s0)
		fs->fatbase = bsect + nrsv; 					/* FAT start sector */
80004fb4:	03642423          	sw	s6,40(s0)
		fs->database = bsect + sysect;					/* Data start sector */
80004fb8:	03742823          	sw	s7,48(s0)
		if (nclst <= MAX_FAT12) fmt = FS_FAT12;
80004fbc:	64a7ec63          	bltu	a5,a0,80005614 <mount_volume+0x8d0>
			if (fs->n_rootdir == 0)	return FR_NO_FILESYSTEM;	/* (BPB_RootEntCnt must not be 0) */
80004fc0:	120c0263          	beqz	s8,800050e4 <mount_volume+0x3a0>
				fs->n_fatent * 2 : fs->n_fatent * 3 / 2 + (fs->n_fatent & 1);
80004fc4:	00171793          	slli	a5,a4,0x1
80004fc8:	00e787b3          	add	a5,a5,a4
			fs->dirbase = fs->fatbase + fasize;			/* Root directory start sector */
80004fcc:	016c8b33          	add	s6,s9,s6
				fs->n_fatent * 2 : fs->n_fatent * 3 / 2 + (fs->n_fatent & 1);
80004fd0:	0017d793          	srli	a5,a5,0x1
80004fd4:	00177713          	andi	a4,a4,1
			fs->dirbase = fs->fatbase + fasize;			/* Root directory start sector */
80004fd8:	03642623          	sw	s6,44(s0)
				fs->n_fatent * 2 : fs->n_fatent * 3 / 2 + (fs->n_fatent & 1);
80004fdc:	00e787b3          	add	a5,a5,a4
80004fe0:	00100693          	li	a3,1
		if (fs->fsize < (szbfat + (SS(fs) - 1)) / SS(fs)) return FR_NO_FILESYSTEM;	/* (BPB_FATSz must not be less than the size needed) */
80004fe4:	1ff78793          	addi	a5,a5,511
80004fe8:	0097d793          	srli	a5,a5,0x9
80004fec:	0ef4ec63          	bltu	s1,a5,800050e4 <mount_volume+0x3a0>
		fs->last_clst = fs->free_clst = 0xFFFFFFFF;		/* Initialize cluster allocation information */
80004ff0:	fff00793          	li	a5,-1
80004ff4:	00f42c23          	sw	a5,24(s0)
80004ff8:	00f42a23          	sw	a5,20(s0)
		fs->fsi_flag = 0x80;
80004ffc:	f8000793          	li	a5,-128
80005000:	00f402a3          	sb	a5,5(s0)
		if (fmt == FS_FAT32				/* Allow to update FSInfo only if BPB_FSInfo32 == 1 */
80005004:	0ff6f693          	andi	a3,a3,255
	fs->id = ++Fsid;		/* Volume mount ID */
80005008:	c741d783          	lhu	a5,-908(gp) # 8000efe4 <Fsid>
	fs->lfnbuf = LfnBuf;	/* Static LFN working buffer */
8000500c:	80818713          	addi	a4,gp,-2040 # 8000eb78 <_edata>
	fs->id = ++Fsid;		/* Volume mount ID */
80005010:	00178793          	addi	a5,a5,1
80005014:	01079793          	slli	a5,a5,0x10
80005018:	0107d793          	srli	a5,a5,0x10
	fs->dirbuf = DirBuf;	/* Static directory block scratchpad buuffer */
8000501c:	20070593          	addi	a1,a4,512
	fs->fs_type = (BYTE)fmt;/* FAT sub-type (the filesystem object gets valid) */
80005020:	00d40023          	sb	a3,0(s0)
	fs->id = ++Fsid;		/* Volume mount ID */
80005024:	c6f19a23          	sh	a5,-908(gp) # 8000efe4 <Fsid>
80005028:	00f41323          	sh	a5,6(s0)
	fs->lfnbuf = LfnBuf;	/* Static LFN working buffer */
8000502c:	00e42623          	sw	a4,12(s0)
	fs->dirbuf = DirBuf;	/* Static directory block scratchpad buuffer */
80005030:	00b42823          	sw	a1,16(s0)
	return FR_OK;
80005034:	00000513          	li	a0,0
80005038:	d99ff06f          	j	80004dd0 <mount_volume+0x8c>
8000503c:	00010493          	mv	s1,sp
80005040:	20240713          	addi	a4,s0,514
80005044:	24240513          	addi	a0,s0,578
	if (fmt != 2 && (fmt >= 3 || part == 0)) return fmt;	/* Returns if it is an FAT VBR as auto scan, not a BS or disk error */
80005048:	00048593          	mv	a1,s1
	rv = rv << 8 | ptr[2];
8000504c:	00374783          	lbu	a5,3(a4)
80005050:	00274603          	lbu	a2,2(a4)
	rv = rv << 8 | ptr[1];
80005054:	00174683          	lbu	a3,1(a4)
	rv = rv << 8 | ptr[2];
80005058:	00879793          	slli	a5,a5,0x8
8000505c:	00c7e7b3          	or	a5,a5,a2
	rv = rv << 8 | ptr[1];
80005060:	00879793          	slli	a5,a5,0x8
	rv = rv << 8 | ptr[0];
80005064:	00074603          	lbu	a2,0(a4)
	rv = rv << 8 | ptr[1];
80005068:	00f6e7b3          	or	a5,a3,a5
	rv = rv << 8 | ptr[0];
8000506c:	00879793          	slli	a5,a5,0x8
80005070:	00f667b3          	or	a5,a2,a5
		mbr_pt[i] = ld_dword(fs->win + MBR_Table + i * SZ_PTE + PTE_StLba);
80005074:	00f5a023          	sw	a5,0(a1)
80005078:	01070713          	addi	a4,a4,16
8000507c:	00458593          	addi	a1,a1,4
	for (i = 0; i < 4; i++) {		/* Load partition offset in the MBR */
80005080:	fce516e3          	bne	a0,a4,8000504c <mount_volume+0x308>
80005084:	01048913          	addi	s2,s1,16
	} while (part == 0 && fmt >= 2 && ++i < 4);
80005088:	00100993          	li	s3,1
		fmt = mbr_pt[i] ? check_fs(fs, mbr_pt[i]) : 3;	/* Check if the partition is FAT */
8000508c:	0004a583          	lw	a1,0(s1)
80005090:	00300513          	li	a0,3
80005094:	00448493          	addi	s1,s1,4
80005098:	00058863          	beqz	a1,800050a8 <mount_volume+0x364>
8000509c:	00040513          	mv	a0,s0
800050a0:	f71fe0ef          	jal	ra,80004010 <check_fs>
	} while (part == 0 && fmt >= 2 && ++i < 4);
800050a4:	daa9f6e3          	bgeu	s3,a0,80004e50 <mount_volume+0x10c>
800050a8:	fe9912e3          	bne	s2,s1,8000508c <mount_volume+0x348>
	if (fmt == 4) return FR_DISK_ERR;		/* An error occurred in the disk I/O layer */
800050ac:	00400793          	li	a5,4
800050b0:	02f51a63          	bne	a0,a5,800050e4 <mount_volume+0x3a0>
800050b4:	00100513          	li	a0,1
800050b8:	d19ff06f          	j	80004dd0 <mount_volume+0x8c>
				return FR_WRITE_PROTECTED;
800050bc:	00a00513          	li	a0,10
800050c0:	d11ff06f          	j	80004dd0 <mount_volume+0x8c>
	rv = rv << 8 | ptr[0];
800050c4:	0a544783          	lbu	a5,165(s0)
800050c8:	0a444683          	lbu	a3,164(s0)
		if (ld_word(fs->win + BPB_FSVerEx) != 0x100) return FR_NO_FILESYSTEM;	/* Check exFAT version (must be version 1.0) */
800050cc:	10000713          	li	a4,256
	rv = rv << 8 | ptr[0];
800050d0:	00879793          	slli	a5,a5,0x8
800050d4:	00d7e7b3          	or	a5,a5,a3
		if (ld_word(fs->win + BPB_FSVerEx) != 0x100) return FR_NO_FILESYSTEM;	/* Check exFAT version (must be version 1.0) */
800050d8:	01079793          	slli	a5,a5,0x10
800050dc:	4107d793          	srai	a5,a5,0x10
800050e0:	06e78263          	beq	a5,a4,80005144 <mount_volume+0x400>
	if (fmt >= 2) return FR_NO_FILESYSTEM;	/* No FAT volume is found */
800050e4:	00d00513          	li	a0,13
800050e8:	ce9ff06f          	j	80004dd0 <mount_volume+0x8c>
	if (vol < 0) return FR_INVALID_DRIVE;
800050ec:	00b00513          	li	a0,11
800050f0:	ce1ff06f          	j	80004dd0 <mount_volume+0x8c>
	if (!fs) return FR_NOT_ENABLED;		/* Is the filesystem object available? */
800050f4:	00c00513          	li	a0,12
800050f8:	cd9ff06f          	j	80004dd0 <mount_volume+0x8c>
800050fc:	04840793          	addi	a5,s0,72
80005100:	07c40693          	addi	a3,s0,124
		for (i = BPB_ZeroedEx; i < BPB_ZeroedEx + 53 && fs->win[i] == 0; i++) ;	/* Check zero filler */
80005104:	fe0710e3          	bnez	a4,800050e4 <mount_volume+0x3a0>
80005108:	fad78ee3          	beq	a5,a3,800050c4 <mount_volume+0x380>
8000510c:	0007c703          	lbu	a4,0(a5)
80005110:	00178793          	addi	a5,a5,1
80005114:	ff1ff06f          	j	80005104 <mount_volume+0x3c0>
	rv = rv << 8 | ptr[2];
80005118:	06344783          	lbu	a5,99(s0)
8000511c:	06244683          	lbu	a3,98(s0)
	rv = rv << 8 | ptr[1];
80005120:	06144703          	lbu	a4,97(s0)
	rv = rv << 8 | ptr[2];
80005124:	00879793          	slli	a5,a5,0x8
80005128:	00d7e7b3          	or	a5,a5,a3
	rv = rv << 8 | ptr[1];
8000512c:	00879793          	slli	a5,a5,0x8
	rv = rv << 8 | ptr[0];
80005130:	06044583          	lbu	a1,96(s0)
	rv = rv << 8 | ptr[1];
80005134:	00f767b3          	or	a5,a4,a5
	rv = rv << 8 | ptr[0];
80005138:	00879793          	slli	a5,a5,0x8
8000513c:	00f5e4b3          	or	s1,a1,a5
	return rv;
80005140:	d55ff06f          	j	80004e94 <mount_volume+0x150>
		if (1 << fs->win[BPB_BytsPerSecEx] != SS(fs)) {	/* (BPB_BytsPerSecEx must be equal to the physical sector size) */
80005144:	0a844703          	lbu	a4,168(s0)
80005148:	00900793          	li	a5,9
8000514c:	f8f71ce3          	bne	a4,a5,800050e4 <mount_volume+0x3a0>
	rv = rv << 8 | ptr[4];
80005150:	08944703          	lbu	a4,137(s0)
80005154:	08844603          	lbu	a2,136(s0)
80005158:	08a44683          	lbu	a3,138(s0)
8000515c:	08b44783          	lbu	a5,139(s0)
80005160:	00871713          	slli	a4,a4,0x8
80005164:	00c76733          	or	a4,a4,a2
80005168:	01069693          	slli	a3,a3,0x10
8000516c:	00e6e6b3          	or	a3,a3,a4
80005170:	01879793          	slli	a5,a5,0x18
	rv = rv << 8 | ptr[3];
80005174:	08744703          	lbu	a4,135(s0)
	rv = rv << 8 | ptr[4];
80005178:	00d7e7b3          	or	a5,a5,a3
	rv = rv << 8 | ptr[3];
8000517c:	00879693          	slli	a3,a5,0x8
	rv = rv << 8 | ptr[2];
80005180:	08644603          	lbu	a2,134(s0)
	rv = rv << 8 | ptr[3];
80005184:	00d76733          	or	a4,a4,a3
	rv = rv << 8 | ptr[2];
80005188:	00871593          	slli	a1,a4,0x8
	rv = rv << 8 | ptr[1];
8000518c:	08544683          	lbu	a3,133(s0)
	rv = rv << 8 | ptr[2];
80005190:	00b66633          	or	a2,a2,a1
	rv = rv << 8 | ptr[3];
80005194:	0187d793          	srli	a5,a5,0x18
	rv = rv << 8 | ptr[2];
80005198:	01875593          	srli	a1,a4,0x18
	rv = rv << 8 | ptr[1];
8000519c:	00861513          	slli	a0,a2,0x8
	rv = rv << 8 | ptr[2];
800051a0:	00879793          	slli	a5,a5,0x8
	rv = rv << 8 | ptr[0];
800051a4:	08444703          	lbu	a4,132(s0)
	rv = rv << 8 | ptr[1];
800051a8:	00a6e6b3          	or	a3,a3,a0
	rv = rv << 8 | ptr[2];
800051ac:	00f5e7b3          	or	a5,a1,a5
	rv = rv << 8 | ptr[1];
800051b0:	01865613          	srli	a2,a2,0x18
	rv = rv << 8 | ptr[0];
800051b4:	00869593          	slli	a1,a3,0x8
	rv = rv << 8 | ptr[1];
800051b8:	00879793          	slli	a5,a5,0x8
	rv = rv << 8 | ptr[0];
800051bc:	00b76733          	or	a4,a4,a1
	rv = rv << 8 | ptr[1];
800051c0:	00f667b3          	or	a5,a2,a5
	rv = rv << 8 | ptr[0];
800051c4:	0186d693          	srli	a3,a3,0x18
800051c8:	00879793          	slli	a5,a5,0x8
		maxlba = ld_qword(fs->win + BPB_TotSecEx) + bsect;	/* Last LBA of the volume + 1 */
800051cc:	012709b3          	add	s3,a4,s2
	rv = rv << 8 | ptr[0];
800051d0:	00f6e7b3          	or	a5,a3,a5
		maxlba = ld_qword(fs->win + BPB_TotSecEx) + bsect;	/* Last LBA of the volume + 1 */
800051d4:	00e9b733          	sltu	a4,s3,a4
800051d8:	00f707b3          	add	a5,a4,a5
		if (!FF_LBA64 && maxlba >= 0x100000000) return FR_NO_FILESYSTEM;	/* (It cannot be accessed in 32-bit LBA) */
800051dc:	f00794e3          	bnez	a5,800050e4 <mount_volume+0x3a0>
	rv = rv << 8 | ptr[2];
800051e0:	09344783          	lbu	a5,147(s0)
800051e4:	09244683          	lbu	a3,146(s0)
	rv = rv << 8 | ptr[1];
800051e8:	09144703          	lbu	a4,145(s0)
	rv = rv << 8 | ptr[2];
800051ec:	00879793          	slli	a5,a5,0x8
800051f0:	00d7e7b3          	or	a5,a5,a3
	rv = rv << 8 | ptr[1];
800051f4:	00879793          	slli	a5,a5,0x8
	rv = rv << 8 | ptr[0];
800051f8:	09044683          	lbu	a3,144(s0)
	rv = rv << 8 | ptr[1];
800051fc:	00f767b3          	or	a5,a4,a5
		fs->n_fats = fs->win[BPB_NumFATsEx];			/* Number of FATs */
80005200:	0aa44703          	lbu	a4,170(s0)
	rv = rv << 8 | ptr[0];
80005204:	00879793          	slli	a5,a5,0x8
80005208:	00f6e7b3          	or	a5,a3,a5
		fs->fsize = ld_dword(fs->win + BPB_FatSzEx);	/* Number of sectors per FAT */
8000520c:	02f42023          	sw	a5,32(s0)
		fs->n_fats = fs->win[BPB_NumFATsEx];			/* Number of FATs */
80005210:	00e401a3          	sb	a4,3(s0)
		if (fs->n_fats != 1) return FR_NO_FILESYSTEM;	/* (Supports only 1 FAT) */
80005214:	00100793          	li	a5,1
80005218:	ecf716e3          	bne	a4,a5,800050e4 <mount_volume+0x3a0>
		fs->csize = 1 << fs->win[BPB_SecPerClusEx];		/* Cluster size */
8000521c:	0a944783          	lbu	a5,169(s0)
80005220:	00f71733          	sll	a4,a4,a5
80005224:	01071793          	slli	a5,a4,0x10
80005228:	0107d793          	srli	a5,a5,0x10
8000522c:	00f41523          	sh	a5,10(s0)
		if (fs->csize == 0)	return FR_NO_FILESYSTEM;	/* (Must be 1..32768 sectors) */
80005230:	ea078ae3          	beqz	a5,800050e4 <mount_volume+0x3a0>
	rv = rv << 8 | ptr[2];
80005234:	09b44783          	lbu	a5,155(s0)
80005238:	09a44603          	lbu	a2,154(s0)
	rv = rv << 8 | ptr[1];
8000523c:	09944683          	lbu	a3,153(s0)
	rv = rv << 8 | ptr[2];
80005240:	00879793          	slli	a5,a5,0x8
80005244:	00c7e7b3          	or	a5,a5,a2
	rv = rv << 8 | ptr[1];
80005248:	00879793          	slli	a5,a5,0x8
	rv = rv << 8 | ptr[0];
8000524c:	09844583          	lbu	a1,152(s0)
	rv = rv << 8 | ptr[1];
80005250:	00f6e7b3          	or	a5,a3,a5
	rv = rv << 8 | ptr[0];
80005254:	00879793          	slli	a5,a5,0x8
80005258:	00f5e5b3          	or	a1,a1,a5
		if (nclst > MAX_EXFAT) return FR_NO_FILESYSTEM;	/* (Too many clusters) */
8000525c:	800007b7          	lui	a5,0x80000
80005260:	ffd7c793          	xori	a5,a5,-3
80005264:	e8b7e0e3          	bltu	a5,a1,800050e4 <mount_volume+0x3a0>
	rv = rv << 8 | ptr[2];
80005268:	09744683          	lbu	a3,151(s0)
8000526c:	08f44783          	lbu	a5,143(s0)
80005270:	09644883          	lbu	a7,150(s0)
80005274:	08e44603          	lbu	a2,142(s0)
	rv = rv << 8 | ptr[1];
80005278:	09544803          	lbu	a6,149(s0)
8000527c:	08d44503          	lbu	a0,141(s0)
	rv = rv << 8 | ptr[2];
80005280:	00869693          	slli	a3,a3,0x8
80005284:	00879793          	slli	a5,a5,0x8
80005288:	0116e6b3          	or	a3,a3,a7
8000528c:	00c7e7b3          	or	a5,a5,a2
	rv = rv << 8 | ptr[1];
80005290:	00869693          	slli	a3,a3,0x8
	rv = rv << 8 | ptr[0];
80005294:	08c44603          	lbu	a2,140(s0)
	rv = rv << 8 | ptr[1];
80005298:	00879793          	slli	a5,a5,0x8
	rv = rv << 8 | ptr[0];
8000529c:	09444483          	lbu	s1,148(s0)
	rv = rv << 8 | ptr[1];
800052a0:	00d866b3          	or	a3,a6,a3
800052a4:	00f567b3          	or	a5,a0,a5
	rv = rv << 8 | ptr[0];
800052a8:	00869693          	slli	a3,a3,0x8
800052ac:	00879793          	slli	a5,a5,0x8
800052b0:	00d4e4b3          	or	s1,s1,a3
800052b4:	00f667b3          	or	a5,a2,a5
		fs->database = bsect + ld_dword(fs->win + BPB_DataOfsEx);
800052b8:	012484b3          	add	s1,s1,s2
		fs->n_fatent = nclst + 2;
800052bc:	00258693          	addi	a3,a1,2
		fs->fatbase = bsect + ld_dword(fs->win + BPB_FatOfsEx);
800052c0:	012787b3          	add	a5,a5,s2
		if (maxlba < (QWORD)fs->database + nclst * fs->csize) return FR_NO_FILESYSTEM;	/* (Volume size must not be smaller than the size required) */
800052c4:	01071513          	slli	a0,a4,0x10
		fs->database = bsect + ld_dword(fs->win + BPB_DataOfsEx);
800052c8:	02942823          	sw	s1,48(s0)
		fs->n_fatent = nclst + 2;
800052cc:	00d42e23          	sw	a3,28(s0)
		fs->volbase = bsect;
800052d0:	03242223          	sw	s2,36(s0)
		fs->fatbase = bsect + ld_dword(fs->win + BPB_FatOfsEx);
800052d4:	02f42423          	sw	a5,40(s0)
		if (maxlba < (QWORD)fs->database + nclst * fs->csize) return FR_NO_FILESYSTEM;	/* (Volume size must not be smaller than the size required) */
800052d8:	01055513          	srli	a0,a0,0x10
800052dc:	6c8080ef          	jal	ra,8000d9a4 <__mulsi3>
800052e0:	009504b3          	add	s1,a0,s1
800052e4:	e0a4e0e3          	bltu	s1,a0,800050e4 <mount_volume+0x3a0>
800052e8:	de99eee3          	bltu	s3,s1,800050e4 <mount_volume+0x3a0>
	rv = rv << 8 | ptr[2];
800052ec:	09f44783          	lbu	a5,159(s0)
800052f0:	09e44683          	lbu	a3,158(s0)
	rv = rv << 8 | ptr[1];
800052f4:	09d44703          	lbu	a4,157(s0)
	rv = rv << 8 | ptr[2];
800052f8:	00879793          	slli	a5,a5,0x8
800052fc:	00d7e7b3          	or	a5,a5,a3
	rv = rv << 8 | ptr[1];
80005300:	00879793          	slli	a5,a5,0x8
	rv = rv << 8 | ptr[0];
80005304:	09c44683          	lbu	a3,156(s0)
	rv = rv << 8 | ptr[1];
80005308:	00f767b3          	or	a5,a4,a5
	rv = rv << 8 | ptr[0];
8000530c:	00879793          	slli	a5,a5,0x8
80005310:	00f6e7b3          	or	a5,a3,a5
		fs->dirbase = ld_dword(fs->win + BPB_RootClusEx);
80005314:	02f42623          	sw	a5,44(s0)
		so = i = 0;
80005318:	00000493          	li	s1,0
8000531c:	00000913          	li	s2,0
			if (fs->win[i] == ET_BITMAP) break;			/* Is it a bitmap entry? */
80005320:	08100993          	li	s3,129
			if (i == 0) {
80005324:	04049c63          	bnez	s1,8000537c <mount_volume+0x638>
				if (so >= fs->csize) return FR_NO_FILESYSTEM;	/* Not found? */
80005328:	00a45703          	lhu	a4,10(s0)
	if (clst >= fs->n_fatent - 2) return 0;		/* Is it invalid cluster number? */
8000532c:	00090793          	mv	a5,s2
	return fs->database + (LBA_t)fs->csize * clst;	/* Start sector number of the cluster */
80005330:	00070513          	mv	a0,a4
				if (so >= fs->csize) return FR_NO_FILESYSTEM;	/* Not found? */
80005334:	dae978e3          	bgeu	s2,a4,800050e4 <mount_volume+0x3a0>
	clst -= 2;		/* Cluster number is origin from 2 */
80005338:	02c42703          	lw	a4,44(s0)
	if (clst >= fs->n_fatent - 2) return 0;		/* Is it invalid cluster number? */
8000533c:	01c42683          	lw	a3,28(s0)
	clst -= 2;		/* Cluster number is origin from 2 */
80005340:	ffe70713          	addi	a4,a4,-2
	if (clst >= fs->n_fatent - 2) return 0;		/* Is it invalid cluster number? */
80005344:	ffe68693          	addi	a3,a3,-2
	return fs->database + (LBA_t)fs->csize * clst;	/* Start sector number of the cluster */
80005348:	00070593          	mv	a1,a4
	if (clst >= fs->n_fatent - 2) return 0;		/* Is it invalid cluster number? */
8000534c:	00d77a63          	bgeu	a4,a3,80005360 <mount_volume+0x61c>
	return fs->database + (LBA_t)fs->csize * clst;	/* Start sector number of the cluster */
80005350:	654080ef          	jal	ra,8000d9a4 <__mulsi3>
80005354:	03042783          	lw	a5,48(s0)
80005358:	00f507b3          	add	a5,a0,a5
8000535c:	012787b3          	add	a5,a5,s2
	if (sect != fs->winsect) {	/* Window offset changed? */
80005360:	03842703          	lw	a4,56(s0)
80005364:	00078593          	mv	a1,a5
80005368:	00040513          	mv	a0,s0
8000536c:	00f70663          	beq	a4,a5,80005378 <mount_volume+0x634>
80005370:	c29fe0ef          	jal	ra,80003f98 <move_window.part.6>
				if (move_window(fs, clst2sect(fs, (DWORD)fs->dirbase) + so) != FR_OK) return FR_DISK_ERR;
80005374:	d40510e3          	bnez	a0,800050b4 <mount_volume+0x370>
				so++;
80005378:	00190913          	addi	s2,s2,1
			if (fs->win[i] == ET_BITMAP) break;			/* Is it a bitmap entry? */
8000537c:	009407b3          	add	a5,s0,s1
80005380:	03c7c783          	lbu	a5,60(a5) # 8000003c <STACK_TOP+0xfffe003c>
			i = (i + SZDIRE) % SS(fs);	/* Next entry */
80005384:	02048713          	addi	a4,s1,32
			if (fs->win[i] == ET_BITMAP) break;			/* Is it a bitmap entry? */
80005388:	1b378a63          	beq	a5,s3,8000553c <mount_volume+0x7f8>
			i = (i + SZDIRE) % SS(fs);	/* Next entry */
8000538c:	1ff77493          	andi	s1,a4,511
			if (i == 0) {
80005390:	f95ff06f          	j	80005324 <mount_volume+0x5e0>
	rv = rv << 8 | ptr[0];
80005394:	06744783          	lbu	a5,103(s0)
80005398:	06644683          	lbu	a3,102(s0)
		fs->n_fatent = nclst + 2;						/* Number of FAT entries */
8000539c:	00e42e23          	sw	a4,28(s0)
	rv = rv << 8 | ptr[0];
800053a0:	00879793          	slli	a5,a5,0x8
800053a4:	00d7e7b3          	or	a5,a5,a3
			if (ld_word(fs->win + BPB_FSVer32) != 0) return FR_NO_FILESYSTEM;	/* (Must be FAT32 revision 0.0) */
800053a8:	00fa67b3          	or	a5,s4,a5
800053ac:	01079793          	slli	a5,a5,0x10
		fs->volbase = bsect;							/* Volume start sector */
800053b0:	03242223          	sw	s2,36(s0)
		fs->fatbase = bsect + nrsv; 					/* FAT start sector */
800053b4:	03642423          	sw	s6,40(s0)
		fs->database = bsect + sysect;					/* Data start sector */
800053b8:	03742823          	sw	s7,48(s0)
			if (ld_word(fs->win + BPB_FSVer32) != 0) return FR_NO_FILESYSTEM;	/* (Must be FAT32 revision 0.0) */
800053bc:	4107d793          	srai	a5,a5,0x10
800053c0:	d20792e3          	bnez	a5,800050e4 <mount_volume+0x3a0>
	rv = rv << 8 | ptr[2];
800053c4:	06b44783          	lbu	a5,107(s0)
800053c8:	06a44603          	lbu	a2,106(s0)
	rv = rv << 8 | ptr[1];
800053cc:	06944683          	lbu	a3,105(s0)
	rv = rv << 8 | ptr[2];
800053d0:	00879793          	slli	a5,a5,0x8
800053d4:	00c7e7b3          	or	a5,a5,a2
	rv = rv << 8 | ptr[1];
800053d8:	00879793          	slli	a5,a5,0x8
	rv = rv << 8 | ptr[0];
800053dc:	06844603          	lbu	a2,104(s0)
	rv = rv << 8 | ptr[1];
800053e0:	00f6e7b3          	or	a5,a3,a5
	rv = rv << 8 | ptr[0];
800053e4:	00879693          	slli	a3,a5,0x8
			szbfat = fs->n_fatent * 4;					/* (Needed FAT size) */
800053e8:	00271793          	slli	a5,a4,0x2
	rv = rv << 8 | ptr[0];
800053ec:	00d666b3          	or	a3,a2,a3
		if (fs->fsize < (szbfat + (SS(fs) - 1)) / SS(fs)) return FR_NO_FILESYSTEM;	/* (BPB_FATSz must not be less than the size needed) */
800053f0:	1ff78793          	addi	a5,a5,511
			fs->dirbase = ld_dword(fs->win + BPB_RootClus32);	/* Root directory start cluster */
800053f4:	02d42623          	sw	a3,44(s0)
		if (fs->fsize < (szbfat + (SS(fs) - 1)) / SS(fs)) return FR_NO_FILESYSTEM;	/* (BPB_FATSz must not be less than the size needed) */
800053f8:	0097d793          	srli	a5,a5,0x9
800053fc:	cef4e4e3          	bltu	s1,a5,800050e4 <mount_volume+0x3a0>
	rv = rv << 8 | ptr[0];
80005400:	06d44783          	lbu	a5,109(s0)
80005404:	06c44683          	lbu	a3,108(s0)
		fs->last_clst = fs->free_clst = 0xFFFFFFFF;		/* Initialize cluster allocation information */
80005408:	fff00713          	li	a4,-1
	rv = rv << 8 | ptr[0];
8000540c:	00879793          	slli	a5,a5,0x8
80005410:	00d7e7b3          	or	a5,a5,a3
		fs->last_clst = fs->free_clst = 0xFFFFFFFF;		/* Initialize cluster allocation information */
80005414:	00e42c23          	sw	a4,24(s0)
80005418:	00e42a23          	sw	a4,20(s0)
			&& ld_word(fs->win + BPB_FSInfo32) == 1
8000541c:	01079793          	slli	a5,a5,0x10
		fs->fsi_flag = 0x80;
80005420:	f8000713          	li	a4,-128
80005424:	00e402a3          	sb	a4,5(s0)
			&& ld_word(fs->win + BPB_FSInfo32) == 1
80005428:	4107d793          	srai	a5,a5,0x10
8000542c:	00100713          	li	a4,1
80005430:	00e78663          	beq	a5,a4,8000543c <mount_volume+0x6f8>
				fs->last_clst = ld_dword(fs->win + FSI_Nxt_Free);
80005434:	00300693          	li	a3,3
80005438:	bd1ff06f          	j	80005008 <mount_volume+0x2c4>
	if (sect != fs->winsect) {	/* Window offset changed? */
8000543c:	00190593          	addi	a1,s2,1
80005440:	00040513          	mv	a0,s0
80005444:	b55fe0ef          	jal	ra,80003f98 <move_window.part.6>
			&& move_window(fs, bsect + 1) == FR_OK)
80005448:	fe0516e3          	bnez	a0,80005434 <mount_volume+0x6f0>
	rv = rv << 8 | ptr[0];
8000544c:	23b44783          	lbu	a5,571(s0)
80005450:	23a44703          	lbu	a4,570(s0)
			fs->fsi_flag = 0;
80005454:	000402a3          	sb	zero,5(s0)
	rv = rv << 8 | ptr[0];
80005458:	00879793          	slli	a5,a5,0x8
8000545c:	00e7e7b3          	or	a5,a5,a4
			if (ld_word(fs->win + BS_55AA) == 0xAA55	/* Load FSInfo data if available */
80005460:	01079793          	slli	a5,a5,0x10
80005464:	ffffb737          	lui	a4,0xffffb
80005468:	4107d793          	srai	a5,a5,0x10
8000546c:	a5570713          	addi	a4,a4,-1451 # ffffaa55 <STACK_TOP+0x7ffdaa55>
80005470:	fce792e3          	bne	a5,a4,80005434 <mount_volume+0x6f0>
	rv = rv << 8 | ptr[2];
80005474:	03f44783          	lbu	a5,63(s0)
80005478:	03e44683          	lbu	a3,62(s0)
	rv = rv << 8 | ptr[1];
8000547c:	03d44703          	lbu	a4,61(s0)
	rv = rv << 8 | ptr[2];
80005480:	00879793          	slli	a5,a5,0x8
80005484:	00d7e7b3          	or	a5,a5,a3
	rv = rv << 8 | ptr[1];
80005488:	00879793          	slli	a5,a5,0x8
	rv = rv << 8 | ptr[0];
8000548c:	03c44683          	lbu	a3,60(s0)
	rv = rv << 8 | ptr[1];
80005490:	00f767b3          	or	a5,a4,a5
	rv = rv << 8 | ptr[0];
80005494:	00879793          	slli	a5,a5,0x8
80005498:	00f6e733          	or	a4,a3,a5
				&& ld_dword(fs->win + FSI_LeadSig) == 0x41615252
8000549c:	416157b7          	lui	a5,0x41615
800054a0:	25278793          	addi	a5,a5,594 # 41615252 <crtStart-0x3e9eadae>
800054a4:	f8f718e3          	bne	a4,a5,80005434 <mount_volume+0x6f0>
	rv = rv << 8 | ptr[2];
800054a8:	22344783          	lbu	a5,547(s0)
800054ac:	22244683          	lbu	a3,546(s0)
	rv = rv << 8 | ptr[1];
800054b0:	22144703          	lbu	a4,545(s0)
	rv = rv << 8 | ptr[2];
800054b4:	00879793          	slli	a5,a5,0x8
800054b8:	00d7e7b3          	or	a5,a5,a3
	rv = rv << 8 | ptr[1];
800054bc:	00879793          	slli	a5,a5,0x8
	rv = rv << 8 | ptr[0];
800054c0:	22044683          	lbu	a3,544(s0)
	rv = rv << 8 | ptr[1];
800054c4:	00f767b3          	or	a5,a4,a5
	rv = rv << 8 | ptr[0];
800054c8:	00879793          	slli	a5,a5,0x8
800054cc:	00f6e733          	or	a4,a3,a5
				&& ld_dword(fs->win + FSI_StrucSig) == 0x61417272)
800054d0:	614177b7          	lui	a5,0x61417
800054d4:	27278793          	addi	a5,a5,626 # 61417272 <crtStart-0x1ebe8d8e>
800054d8:	f4f71ee3          	bne	a4,a5,80005434 <mount_volume+0x6f0>
	rv = rv << 8 | ptr[2];
800054dc:	22744703          	lbu	a4,551(s0)
800054e0:	22b44783          	lbu	a5,555(s0)
800054e4:	22644503          	lbu	a0,550(s0)
800054e8:	22a44583          	lbu	a1,554(s0)
	rv = rv << 8 | ptr[1];
800054ec:	22944683          	lbu	a3,553(s0)
	rv = rv << 8 | ptr[2];
800054f0:	00871713          	slli	a4,a4,0x8
	rv = rv << 8 | ptr[1];
800054f4:	22544603          	lbu	a2,549(s0)
	rv = rv << 8 | ptr[2];
800054f8:	00879793          	slli	a5,a5,0x8
800054fc:	00a76733          	or	a4,a4,a0
80005500:	00b7e7b3          	or	a5,a5,a1
	rv = rv << 8 | ptr[1];
80005504:	00871713          	slli	a4,a4,0x8
	rv = rv << 8 | ptr[0];
80005508:	22444503          	lbu	a0,548(s0)
	rv = rv << 8 | ptr[1];
8000550c:	00879793          	slli	a5,a5,0x8
	rv = rv << 8 | ptr[0];
80005510:	22844583          	lbu	a1,552(s0)
	rv = rv << 8 | ptr[1];
80005514:	00f6e7b3          	or	a5,a3,a5
80005518:	00e66733          	or	a4,a2,a4
	rv = rv << 8 | ptr[0];
8000551c:	00871713          	slli	a4,a4,0x8
80005520:	00879793          	slli	a5,a5,0x8
80005524:	00e56733          	or	a4,a0,a4
80005528:	00f5e7b3          	or	a5,a1,a5
				fs->free_clst = ld_dword(fs->win + FSI_Free_Count);
8000552c:	00e42c23          	sw	a4,24(s0)
				fs->last_clst = ld_dword(fs->win + FSI_Nxt_Free);
80005530:	00f42a23          	sw	a5,20(s0)
80005534:	00300693          	li	a3,3
80005538:	ad1ff06f          	j	80005008 <mount_volume+0x2c4>
		bcl = ld_dword(fs->win + i + 20);				/* Bitmap cluster */
8000553c:	03c40913          	addi	s2,s0,60
80005540:	01448793          	addi	a5,s1,20
80005544:	00f907b3          	add	a5,s2,a5
	rv = rv << 8 | ptr[2];
80005548:	0037c703          	lbu	a4,3(a5)
8000554c:	0027c603          	lbu	a2,2(a5)
	rv = rv << 8 | ptr[1];
80005550:	0017c683          	lbu	a3,1(a5)
	rv = rv << 8 | ptr[2];
80005554:	00871713          	slli	a4,a4,0x8
80005558:	00c76733          	or	a4,a4,a2
	rv = rv << 8 | ptr[0];
8000555c:	0007c983          	lbu	s3,0(a5)
	rv = rv << 8 | ptr[1];
80005560:	00871713          	slli	a4,a4,0x8
80005564:	00e6e7b3          	or	a5,a3,a4
	rv = rv << 8 | ptr[0];
80005568:	00879793          	slli	a5,a5,0x8
8000556c:	00f9e9b3          	or	s3,s3,a5
		if (bcl < 2 || bcl >= fs->n_fatent) return FR_NO_FILESYSTEM;	/* (Wrong cluster#) */
80005570:	00100793          	li	a5,1
80005574:	b737f8e3          	bgeu	a5,s3,800050e4 <mount_volume+0x3a0>
80005578:	01c42783          	lw	a5,28(s0)
8000557c:	b6f9f4e3          	bgeu	s3,a5,800050e4 <mount_volume+0x3a0>
		fs->bitbase = fs->database + fs->csize * (bcl - 2);	/* Bitmap sector */
80005580:	00a45503          	lhu	a0,10(s0)
80005584:	ffe98593          	addi	a1,s3,-2
			if (cv == 0xFFFFFFFF) break;				/* Last link? */
80005588:	fff00493          	li	s1,-1
		fs->bitbase = fs->database + fs->csize * (bcl - 2);	/* Bitmap sector */
8000558c:	418080ef          	jal	ra,8000d9a4 <__mulsi3>
80005590:	03042783          	lw	a5,48(s0)
80005594:	00f507b3          	add	a5,a0,a5
80005598:	02f42a23          	sw	a5,52(s0)
8000559c:	0080006f          	j	800055a4 <mount_volume+0x860>
			if (cv != ++bcl) return FR_NO_FILESYSTEM;	/* Fragmented bitmap? */
800055a0:	b4e992e3          	bne	s3,a4,800050e4 <mount_volume+0x3a0>
			if (move_window(fs, fs->fatbase + bcl / (SS(fs) / 4)) != FR_OK) return FR_DISK_ERR;
800055a4:	02842683          	lw	a3,40(s0)
	if (sect != fs->winsect) {	/* Window offset changed? */
800055a8:	03842703          	lw	a4,56(s0)
			if (move_window(fs, fs->fatbase + bcl / (SS(fs) / 4)) != FR_OK) return FR_DISK_ERR;
800055ac:	0079d793          	srli	a5,s3,0x7
800055b0:	00d787b3          	add	a5,a5,a3
	if (sect != fs->winsect) {	/* Window offset changed? */
800055b4:	00040513          	mv	a0,s0
800055b8:	00078593          	mv	a1,a5
800055bc:	00e78663          	beq	a5,a4,800055c8 <mount_volume+0x884>
800055c0:	9d9fe0ef          	jal	ra,80003f98 <move_window.part.6>
			if (move_window(fs, fs->fatbase + bcl / (SS(fs) / 4)) != FR_OK) return FR_DISK_ERR;
800055c4:	ae0518e3          	bnez	a0,800050b4 <mount_volume+0x370>
			cv = ld_dword(fs->win + bcl % (SS(fs) / 4) * 4);
800055c8:	07f9f793          	andi	a5,s3,127
800055cc:	00279793          	slli	a5,a5,0x2
800055d0:	00f907b3          	add	a5,s2,a5
	rv = rv << 8 | ptr[2];
800055d4:	0037c703          	lbu	a4,3(a5)
800055d8:	0027c603          	lbu	a2,2(a5)
	rv = rv << 8 | ptr[1];
800055dc:	0017c683          	lbu	a3,1(a5)
	rv = rv << 8 | ptr[2];
800055e0:	00871713          	slli	a4,a4,0x8
800055e4:	00c76733          	or	a4,a4,a2
	rv = rv << 8 | ptr[1];
800055e8:	00871713          	slli	a4,a4,0x8
	rv = rv << 8 | ptr[0];
800055ec:	0007c783          	lbu	a5,0(a5)
	rv = rv << 8 | ptr[1];
800055f0:	00e6e733          	or	a4,a3,a4
	rv = rv << 8 | ptr[0];
800055f4:	00871713          	slli	a4,a4,0x8
800055f8:	00e7e733          	or	a4,a5,a4
			if (cv != ++bcl) return FR_NO_FILESYSTEM;	/* Fragmented bitmap? */
800055fc:	00198993          	addi	s3,s3,1
			if (cv == 0xFFFFFFFF) break;				/* Last link? */
80005600:	fa9710e3          	bne	a4,s1,800055a0 <mount_volume+0x85c>
		fs->last_clst = fs->free_clst = 0xFFFFFFFF;		/* Initialize cluster allocation information */
80005604:	00942c23          	sw	s1,24(s0)
80005608:	00942a23          	sw	s1,20(s0)
		fmt = FS_EXFAT;			/* FAT sub-type */
8000560c:	00400693          	li	a3,4
80005610:	9f9ff06f          	j	80005008 <mount_volume+0x2c4>
			if (fs->n_rootdir == 0)	return FR_NO_FILESYSTEM;	/* (BPB_RootEntCnt must not be 0) */
80005614:	ac0c08e3          	beqz	s8,800050e4 <mount_volume+0x3a0>
			fs->dirbase = fs->fatbase + fasize;			/* Root directory start sector */
80005618:	016c8b33          	add	s6,s9,s6
8000561c:	03642623          	sw	s6,44(s0)
				fs->n_fatent * 2 : fs->n_fatent * 3 / 2 + (fs->n_fatent & 1);
80005620:	00171793          	slli	a5,a4,0x1
80005624:	00200693          	li	a3,2
80005628:	9bdff06f          	j	80004fe4 <mount_volume+0x2a0>

8000562c <create_chain>:
{
8000562c:	fd010113          	addi	sp,sp,-48
80005630:	03212023          	sw	s2,32(sp)
80005634:	01312e23          	sw	s3,28(sp)
80005638:	01412c23          	sw	s4,24(sp)
8000563c:	02112623          	sw	ra,44(sp)
80005640:	02812423          	sw	s0,40(sp)
80005644:	02912223          	sw	s1,36(sp)
80005648:	01512a23          	sw	s5,20(sp)
8000564c:	01612823          	sw	s6,16(sp)
80005650:	01712623          	sw	s7,12(sp)
80005654:	00050913          	mv	s2,a0
80005658:	00058993          	mv	s3,a1
	FATFS *fs = obj->fs;
8000565c:	00052a03          	lw	s4,0(a0)
	if (clst == 0) {	/* Create a new chain */
80005660:	12059463          	bnez	a1,80005788 <create_chain+0x15c>
		scl = fs->last_clst;				/* Suggested cluster to start to find */
80005664:	014a2a83          	lw	s5,20(s4)
		if (scl == 0 || scl >= fs->n_fatent) scl = 1;
80005668:	0c0a9e63          	bnez	s5,80005744 <create_chain+0x118>
8000566c:	00100a93          	li	s5,1
	if (fs->free_clst == 0) return 0;		/* No free cluster */
80005670:	018a2783          	lw	a5,24(s4)
80005674:	0e078063          	beqz	a5,80005754 <create_chain+0x128>
	if (fs->fs_type == FS_EXFAT) {	/* On the exFAT volume */
80005678:	01ca2803          	lw	a6,28(s4)
8000567c:	000a4683          	lbu	a3,0(s4)
80005680:	00400713          	li	a4,4
80005684:	00080793          	mv	a5,a6
80005688:	12e68c63          	beq	a3,a4,800057c0 <create_chain+0x194>
		if (scl == clst) {						/* Stretching an existing chain? */
8000568c:	233a8c63          	beq	s5,s3,800058c4 <create_chain+0x298>
				if (cs >= 2 && cs < fs->n_fatent) scl = cs;
80005690:	000a8413          	mv	s0,s5
					if (ncl > scl) return 0;	/* No free cluster found? */
80005694:	00100493          	li	s1,1
				if (cs == 1 || cs == 0xFFFFFFFF) return cs;	/* Test for error */
80005698:	fff00b13          	li	s6,-1
8000569c:	0140006f          	j	800056b0 <create_chain+0x84>
800056a0:	10950c63          	beq	a0,s1,800057b8 <create_chain+0x18c>
800056a4:	21650c63          	beq	a0,s6,800058bc <create_chain+0x290>
				if (ncl == scl) return 0;		/* No free cluster found? */
800056a8:	0b540663          	beq	s0,s5,80005754 <create_chain+0x128>
800056ac:	01ca2783          	lw	a5,28(s4)
				ncl++;							/* Next cluster */
800056b0:	00140413          	addi	s0,s0,1
				cs = get_fat(obj, ncl);			/* Get the cluster status */
800056b4:	00090513          	mv	a0,s2
				if (ncl >= fs->n_fatent) {		/* Check wrap-around */
800056b8:	00f46663          	bltu	s0,a5,800056c4 <create_chain+0x98>
					if (ncl > scl) return 0;	/* No free cluster found? */
800056bc:	0954fc63          	bgeu	s1,s5,80005754 <create_chain+0x128>
					ncl = 2;
800056c0:	00200413          	li	s0,2
				cs = get_fat(obj, ncl);			/* Get the cluster status */
800056c4:	00040593          	mv	a1,s0
800056c8:	c69fe0ef          	jal	ra,80004330 <get_fat>
				if (cs == 0) break;				/* Found a free cluster? */
800056cc:	fc051ae3          	bnez	a0,800056a0 <create_chain+0x74>
	if (clst >= 2 && clst < fs->n_fatent) {	/* Check if in valid range */
800056d0:	00100493          	li	s1,1
800056d4:	0e84f263          	bgeu	s1,s0,800057b8 <create_chain+0x18c>
800056d8:	01ca2783          	lw	a5,28(s4)
800056dc:	0cf47e63          	bgeu	s0,a5,800057b8 <create_chain+0x18c>
800056e0:	fff00613          	li	a2,-1
800056e4:	00040593          	mv	a1,s0
800056e8:	000a0513          	mv	a0,s4
800056ec:	858ff0ef          	jal	ra,80004744 <put_fat.part.7>
		if (res == FR_OK && clst != 0) {
800056f0:	0c051063          	bnez	a0,800057b0 <create_chain+0x184>
800056f4:	02098263          	beqz	s3,80005718 <create_chain+0xec>
	if (clst >= 2 && clst < fs->n_fatent) {	/* Check if in valid range */
800056f8:	0d34f063          	bgeu	s1,s3,800057b8 <create_chain+0x18c>
800056fc:	01ca2783          	lw	a5,28(s4)
80005700:	0af9fc63          	bgeu	s3,a5,800057b8 <create_chain+0x18c>
80005704:	00040613          	mv	a2,s0
80005708:	00098593          	mv	a1,s3
8000570c:	000a0513          	mv	a0,s4
80005710:	834ff0ef          	jal	ra,80004744 <put_fat.part.7>
	if (res == FR_OK) {			/* Update FSINFO if function succeeded. */
80005714:	08051e63          	bnez	a0,800057b0 <create_chain+0x184>
		if (fs->free_clst <= fs->n_fatent - 2) fs->free_clst--;
80005718:	01ca2783          	lw	a5,28(s4)
8000571c:	018a2703          	lw	a4,24(s4)
		fs->last_clst = ncl;
80005720:	008a2a23          	sw	s0,20(s4)
		if (fs->free_clst <= fs->n_fatent - 2) fs->free_clst--;
80005724:	ffe78793          	addi	a5,a5,-2
80005728:	00e7e663          	bltu	a5,a4,80005734 <create_chain+0x108>
8000572c:	fff70713          	addi	a4,a4,-1
80005730:	00ea2c23          	sw	a4,24(s4)
		fs->fsi_flag |= 1;
80005734:	005a4783          	lbu	a5,5(s4)
80005738:	0017e793          	ori	a5,a5,1
8000573c:	00fa02a3          	sb	a5,5(s4)
80005740:	0180006f          	j	80005758 <create_chain+0x12c>
		if (scl == 0 || scl >= fs->n_fatent) scl = 1;
80005744:	01ca2783          	lw	a5,28(s4)
80005748:	f2faf2e3          	bgeu	s5,a5,8000566c <create_chain+0x40>
	if (fs->free_clst == 0) return 0;		/* No free cluster */
8000574c:	018a2783          	lw	a5,24(s4)
80005750:	f20794e3          	bnez	a5,80005678 <create_chain+0x4c>
80005754:	00000413          	li	s0,0
}
80005758:	00040513          	mv	a0,s0
8000575c:	02c12083          	lw	ra,44(sp)
80005760:	02812403          	lw	s0,40(sp)
80005764:	02412483          	lw	s1,36(sp)
80005768:	02012903          	lw	s2,32(sp)
8000576c:	01c12983          	lw	s3,28(sp)
80005770:	01812a03          	lw	s4,24(sp)
80005774:	01412a83          	lw	s5,20(sp)
80005778:	01012b03          	lw	s6,16(sp)
8000577c:	00c12b83          	lw	s7,12(sp)
80005780:	03010113          	addi	sp,sp,48
80005784:	00008067          	ret
		cs = get_fat(obj, clst);			/* Check the cluster status */
80005788:	ba9fe0ef          	jal	ra,80004330 <get_fat>
		if (cs < 2) return 1;				/* Test for insanity */
8000578c:	00100793          	li	a5,1
		cs = get_fat(obj, clst);			/* Check the cluster status */
80005790:	00050413          	mv	s0,a0
		if (cs < 2) return 1;				/* Test for insanity */
80005794:	02a7f263          	bgeu	a5,a0,800057b8 <create_chain+0x18c>
		if (cs == 0xFFFFFFFF) return cs;	/* Test for disk error */
80005798:	fff00793          	li	a5,-1
8000579c:	12f50063          	beq	a0,a5,800058bc <create_chain+0x290>
		if (cs < fs->n_fatent) return cs;	/* It is already followed by next cluster */
800057a0:	01ca2783          	lw	a5,28(s4)
800057a4:	00098a93          	mv	s5,s3
800057a8:	ecf574e3          	bgeu	a0,a5,80005670 <create_chain+0x44>
800057ac:	fadff06f          	j	80005758 <create_chain+0x12c>
		ncl = (res == FR_DISK_ERR) ? 0xFFFFFFFF : 1;	/* Failed. Generate error status */
800057b0:	00100793          	li	a5,1
800057b4:	10f50463          	beq	a0,a5,800058bc <create_chain+0x290>
		if (cs < 2) return 1;				/* Test for insanity */
800057b8:	00100413          	li	s0,1
800057bc:	f9dff06f          	j	80005758 <create_chain+0x12c>
	clst -= 2;	/* The first bit in the bitmap corresponds to cluster #2 */
800057c0:	ffea8493          	addi	s1,s5,-2
	if (clst >= fs->n_fatent - 2) clst = 0;
800057c4:	ffe80793          	addi	a5,a6,-2
800057c8:	00f4b7b3          	sltu	a5,s1,a5
800057cc:	40f007b3          	neg	a5,a5
800057d0:	00f4f4b3          	and	s1,s1,a5
	scl = val = clst; ctr = 0;
800057d4:	00048413          	mv	s0,s1
		i = val / 8 % SS(fs); bm = 1 << (val % 8);
800057d8:	00100b93          	li	s7,1
		} while (++i < SS(fs));
800057dc:	20000b13          	li	s6,512
		if (move_window(fs, fs->bitbase + val / 8 / SS(fs)) != FR_OK) return 0xFFFFFFFF;
800057e0:	034a2703          	lw	a4,52(s4)
	if (sect != fs->winsect) {	/* Window offset changed? */
800057e4:	038a2783          	lw	a5,56(s4)
		if (move_window(fs, fs->bitbase + val / 8 / SS(fs)) != FR_OK) return 0xFFFFFFFF;
800057e8:	00c45593          	srli	a1,s0,0xc
800057ec:	00e585b3          	add	a1,a1,a4
	if (sect != fs->winsect) {	/* Window offset changed? */
800057f0:	00f58a63          	beq	a1,a5,80005804 <create_chain+0x1d8>
800057f4:	000a0513          	mv	a0,s4
800057f8:	fa0fe0ef          	jal	ra,80003f98 <move_window.part.6>
		if (move_window(fs, fs->bitbase + val / 8 / SS(fs)) != FR_OK) return 0xFFFFFFFF;
800057fc:	0c051063          	bnez	a0,800058bc <create_chain+0x290>
80005800:	01ca2803          	lw	a6,28(s4)
		i = val / 8 % SS(fs); bm = 1 << (val % 8);
80005804:	00345693          	srli	a3,s0,0x3
80005808:	1ff6f693          	andi	a3,a3,511
8000580c:	00da0733          	add	a4,s4,a3
80005810:	00747793          	andi	a5,s0,7
80005814:	03c74583          	lbu	a1,60(a4)
80005818:	00fb97b3          	sll	a5,s7,a5
8000581c:	0ff7f793          	andi	a5,a5,255
				if (++val >= fs->n_fatent - 2) {	/* Next cluster (with wrap-around) */
80005820:	ffe80513          	addi	a0,a6,-2
80005824:	00140713          	addi	a4,s0,1
				bv = fs->win[i] & bm; bm <<= 1;		/* Get bit value */
80005828:	00b7f633          	and	a2,a5,a1
				if (++val >= fs->n_fatent - 2) {	/* Next cluster (with wrap-around) */
8000582c:	04a76663          	bltu	a4,a0,80005878 <create_chain+0x24c>
				if (bv == 0) {	/* Is it a free cluster? */
80005830:	08061063          	bnez	a2,800058b0 <create_chain+0x284>
		if (ncl == 0 || ncl == 0xFFFFFFFF) return ncl;	/* No free cluster or hard error? */
80005834:	ffd00793          	li	a5,-3
					if (++ctr == ncl) return scl + 2;	/* Check if run length is sufficient for required */
80005838:	00240413          	addi	s0,s0,2
		if (ncl == 0 || ncl == 0xFFFFFFFF) return ncl;	/* No free cluster or hard error? */
8000583c:	f0e7eee3          	bltu	a5,a4,80005758 <create_chain+0x12c>
		res = change_bitmap(fs, ncl, 1, 1);			/* Mark the cluster 'in use' */
80005840:	00100693          	li	a3,1
80005844:	00100613          	li	a2,1
80005848:	00040593          	mv	a1,s0
8000584c:	000a0513          	mv	a0,s4
80005850:	9b1fe0ef          	jal	ra,80004200 <change_bitmap>
		if (res == FR_INT_ERR) return 1;
80005854:	00200793          	li	a5,2
80005858:	f6f500e3          	beq	a0,a5,800057b8 <create_chain+0x18c>
		if (res == FR_DISK_ERR) return 0xFFFFFFFF;
8000585c:	00100713          	li	a4,1
80005860:	04e50e63          	beq	a0,a4,800058bc <create_chain+0x290>
		if (clst == 0) {							/* Is it a new chain? */
80005864:	0a099863          	bnez	s3,80005914 <create_chain+0x2e8>
			obj->stat = 2;							/* Set status 'contiguous' */
80005868:	00f903a3          	sb	a5,7(s2)
	if (res == FR_OK) {			/* Update FSINFO if function succeeded. */
8000586c:	ea0506e3          	beqz	a0,80005718 <create_chain+0xec>
		if (cs < 2) return 1;				/* Test for insanity */
80005870:	00100413          	li	s0,1
80005874:	ee5ff06f          	j	80005758 <create_chain+0x12c>
				bv = fs->win[i] & bm; bm <<= 1;		/* Get bit value */
80005878:	00179793          	slli	a5,a5,0x1
8000587c:	0ff7f793          	andi	a5,a5,255
				if (bv == 0) {	/* Is it a free cluster? */
80005880:	fa060ae3          	beqz	a2,80005834 <create_chain+0x208>
				if (val == clst) return 0;	/* All cluster scanned? */
80005884:	ec9708e3          	beq	a4,s1,80005754 <create_chain+0x128>
			} while (bm != 0);
80005888:	00078663          	beqz	a5,80005894 <create_chain+0x268>
			bm = 1;
8000588c:	00070413          	mv	s0,a4
80005890:	f95ff06f          	j	80005824 <create_chain+0x1f8>
		} while (++i < SS(fs));
80005894:	00168693          	addi	a3,a3,1
80005898:	00da07b3          	add	a5,s4,a3
8000589c:	0f668a63          	beq	a3,s6,80005990 <create_chain+0x364>
800058a0:	03c7c583          	lbu	a1,60(a5)
			bm = 1;
800058a4:	00070413          	mv	s0,a4
800058a8:	00100793          	li	a5,1
800058ac:	f79ff06f          	j	80005824 <create_chain+0x1f8>
				if (val == clst) return 0;	/* All cluster scanned? */
800058b0:	ea0482e3          	beqz	s1,80005754 <create_chain+0x128>
800058b4:	00000413          	li	s0,0
800058b8:	f29ff06f          	j	800057e0 <create_chain+0x1b4>
		ncl = (res == FR_DISK_ERR) ? 0xFFFFFFFF : 1;	/* Failed. Generate error status */
800058bc:	fff00413          	li	s0,-1
800058c0:	e99ff06f          	j	80005758 <create_chain+0x12c>
800058c4:	001a8413          	addi	s0,s5,1
			if (ncl >= fs->n_fatent) ncl = 2;
800058c8:	01046463          	bltu	s0,a6,800058d0 <create_chain+0x2a4>
800058cc:	00200413          	li	s0,2
			cs = get_fat(obj, ncl);				/* Get next cluster status */
800058d0:	00040593          	mv	a1,s0
800058d4:	00090513          	mv	a0,s2
800058d8:	a59fe0ef          	jal	ra,80004330 <get_fat>
			if (cs == 1 || cs == 0xFFFFFFFF) return cs;	/* Test for error */
800058dc:	00100713          	li	a4,1
800058e0:	ece50ce3          	beq	a0,a4,800057b8 <create_chain+0x18c>
800058e4:	fff00793          	li	a5,-1
800058e8:	fcf50ae3          	beq	a0,a5,800058bc <create_chain+0x290>
			if (cs != 0) {						/* Not free? */
800058ec:	00050e63          	beqz	a0,80005908 <create_chain+0x2dc>
				cs = fs->last_clst;				/* Start at suggested cluster if it is valid */
800058f0:	014a2683          	lw	a3,20(s4)
				if (cs >= 2 && cs < fs->n_fatent) scl = cs;
800058f4:	01ca2783          	lw	a5,28(s4)
800058f8:	d8d77ce3          	bgeu	a4,a3,80005690 <create_chain+0x64>
800058fc:	d8f6fae3          	bgeu	a3,a5,80005690 <create_chain+0x64>
80005900:	00068a93          	mv	s5,a3
80005904:	d8dff06f          	j	80005690 <create_chain+0x64>
		if (ncl == 0) {	/* The new cluster cannot be contiguous and find another fragment */
80005908:	dc0414e3          	bnez	s0,800056d0 <create_chain+0xa4>
8000590c:	01ca2783          	lw	a5,28(s4)
80005910:	d81ff06f          	j	80005690 <create_chain+0x64>
			if (obj->stat == 2 && ncl != scl + 1) {	/* Is the chain got fragmented? */
80005914:	00794703          	lbu	a4,7(s2)
80005918:	04f70c63          	beq	a4,a5,80005970 <create_chain+0x344>
			if (ncl == clst + 1) {	/* Is the cluster next to previous one? */
8000591c:	00198793          	addi	a5,s3,1
80005920:	01c92703          	lw	a4,28(s2)
80005924:	02878a63          	beq	a5,s0,80005958 <create_chain+0x32c>
				if (obj->n_frag == 0) obj->n_frag = 1;
80005928:	00071663          	bnez	a4,80005934 <create_chain+0x308>
8000592c:	00100793          	li	a5,1
80005930:	00f92e23          	sw	a5,28(s2)
	while (obj->n_frag > 0) {	/* Create the chain of last fragment */
80005934:	00040693          	mv	a3,s0
80005938:	00098613          	mv	a2,s3
8000593c:	01c90593          	addi	a1,s2,28
80005940:	00090513          	mv	a0,s2
80005944:	a84ff0ef          	jal	ra,80004bc8 <fill_last_frag.isra.8.part.9>
				if (res == FR_OK) obj->n_frag = 1;
80005948:	e60514e3          	bnez	a0,800057b0 <create_chain+0x184>
8000594c:	00100793          	li	a5,1
80005950:	00f92e23          	sw	a5,28(s2)
	if (res == FR_OK) {			/* Update FSINFO if function succeeded. */
80005954:	dc5ff06f          	j	80005718 <create_chain+0xec>
				obj->n_frag = obj->n_frag ? obj->n_frag + 1 : 2;	/* Increment size of last framgent */
80005958:	00200793          	li	a5,2
8000595c:	00070463          	beqz	a4,80005964 <create_chain+0x338>
80005960:	00170793          	addi	a5,a4,1
80005964:	00f92e23          	sw	a5,28(s2)
	if (res == FR_OK) {			/* Update FSINFO if function succeeded. */
80005968:	da0508e3          	beqz	a0,80005718 <create_chain+0xec>
8000596c:	f05ff06f          	j	80005870 <create_chain+0x244>
			if (obj->stat == 2 && ncl != scl + 1) {	/* Is the chain got fragmented? */
80005970:	001a8793          	addi	a5,s5,1
80005974:	ee878ce3          	beq	a5,s0,8000586c <create_chain+0x240>
				obj->n_cont = scl - obj->sclust;	/* Set size of the contiguous part */
80005978:	00892783          	lw	a5,8(s2)
				obj->stat = 3;						/* Change status 'just fragmented' */
8000597c:	00300713          	li	a4,3
80005980:	00e903a3          	sb	a4,7(s2)
				obj->n_cont = scl - obj->sclust;	/* Set size of the contiguous part */
80005984:	40fa8ab3          	sub	s5,s5,a5
80005988:	01592c23          	sw	s5,24(s2)
				obj->stat = 3;						/* Change status 'just fragmented' */
8000598c:	f91ff06f          	j	8000591c <create_chain+0x2f0>
				if (++val >= fs->n_fatent - 2) {	/* Next cluster (with wrap-around) */
80005990:	00070413          	mv	s0,a4
80005994:	e4dff06f          	j	800057e0 <create_chain+0x1b4>

80005998 <dir_next>:
{
80005998:	fe010113          	addi	sp,sp,-32
8000599c:	00912a23          	sw	s1,20(sp)
	FATFS *fs = dp->obj.fs;
800059a0:	00052483          	lw	s1,0(a0)
{
800059a4:	00812c23          	sw	s0,24(sp)
800059a8:	01212823          	sw	s2,16(sp)
800059ac:	01512223          	sw	s5,4(sp)
800059b0:	00112e23          	sw	ra,28(sp)
800059b4:	01312623          	sw	s3,12(sp)
800059b8:	01412423          	sw	s4,8(sp)
800059bc:	01612023          	sw	s6,0(sp)
	ofs = dp->dptr + SZDIRE;	/* Next entry */
800059c0:	03052903          	lw	s2,48(a0)
	if (ofs >= (DWORD)((FF_FS_EXFAT && fs->fs_type == FS_EXFAT) ? MAX_DIR_EX : MAX_DIR)) dp->sect = 0;	/* Disable it if the offset reached the max value */
800059c4:	0004c683          	lbu	a3,0(s1)
800059c8:	00400713          	li	a4,4
{
800059cc:	00050413          	mv	s0,a0
800059d0:	00058a93          	mv	s5,a1
	ofs = dp->dptr + SZDIRE;	/* Next entry */
800059d4:	02090913          	addi	s2,s2,32
	if (ofs >= (DWORD)((FF_FS_EXFAT && fs->fs_type == FS_EXFAT) ? MAX_DIR_EX : MAX_DIR)) dp->sect = 0;	/* Disable it if the offset reached the max value */
800059d8:	002007b7          	lui	a5,0x200
800059dc:	10e68c63          	beq	a3,a4,80005af4 <dir_next+0x15c>
800059e0:	02f96a63          	bltu	s2,a5,80005a14 <dir_next+0x7c>
800059e4:	02042c23          	sw	zero,56(s0)
	if (dp->sect == 0) return FR_NO_FILE;	/* Report EOT if it has been disabled */
800059e8:	00400513          	li	a0,4
}
800059ec:	01c12083          	lw	ra,28(sp)
800059f0:	01812403          	lw	s0,24(sp)
800059f4:	01412483          	lw	s1,20(sp)
800059f8:	01012903          	lw	s2,16(sp)
800059fc:	00c12983          	lw	s3,12(sp)
80005a00:	00812a03          	lw	s4,8(sp)
80005a04:	00412a83          	lw	s5,4(sp)
80005a08:	00012b03          	lw	s6,0(sp)
80005a0c:	02010113          	addi	sp,sp,32
80005a10:	00008067          	ret
	if (dp->sect == 0) return FR_NO_FILE;	/* Report EOT if it has been disabled */
80005a14:	03842783          	lw	a5,56(s0)
80005a18:	10078c63          	beqz	a5,80005b30 <dir_next+0x198>
	if (ofs % SS(fs) == 0) {	/* Sector changed? */
80005a1c:	1ff97993          	andi	s3,s2,511
80005a20:	0a099e63          	bnez	s3,80005adc <dir_next+0x144>
		if (dp->clust == 0) {	/* Static table */
80005a24:	03442583          	lw	a1,52(s0)
		dp->sect++;				/* Next sector */
80005a28:	00178793          	addi	a5,a5,1 # 200001 <crtStart-0x7fdfffff>
80005a2c:	02f42c23          	sw	a5,56(s0)
		if (dp->clust == 0) {	/* Static table */
80005a30:	0c058663          	beqz	a1,80005afc <dir_next+0x164>
			if ((ofs / SS(fs) & (fs->csize - 1)) == 0) {	/* Cluster changed? */
80005a34:	00a4d783          	lhu	a5,10(s1)
80005a38:	00995a13          	srli	s4,s2,0x9
80005a3c:	fff78793          	addi	a5,a5,-1
80005a40:	0147fa33          	and	s4,a5,s4
80005a44:	080a1c63          	bnez	s4,80005adc <dir_next+0x144>
				clst = get_fat(&dp->obj, dp->clust);		/* Get next cluster */
80005a48:	00040513          	mv	a0,s0
80005a4c:	8e5fe0ef          	jal	ra,80004330 <get_fat>
				if (clst <= 1) return FR_INT_ERR;			/* Internal error */
80005a50:	00100793          	li	a5,1
				clst = get_fat(&dp->obj, dp->clust);		/* Get next cluster */
80005a54:	00050b13          	mv	s6,a0
				if (clst <= 1) return FR_INT_ERR;			/* Internal error */
80005a58:	0ca7f863          	bgeu	a5,a0,80005b28 <dir_next+0x190>
				if (clst == 0xFFFFFFFF) return FR_DISK_ERR;	/* Disk error */
80005a5c:	fff00793          	li	a5,-1
80005a60:	0cf50063          	beq	a0,a5,80005b20 <dir_next+0x188>
				if (clst >= fs->n_fatent) {					/* It reached end of dynamic table */
80005a64:	01c4a783          	lw	a5,28(s1)
80005a68:	04f56863          	bltu	a0,a5,80005ab8 <dir_next+0x120>
					if (!stretch) {								/* If no stretch, report EOT */
80005a6c:	f60a8ce3          	beqz	s5,800059e4 <dir_next+0x4c>
					clst = create_chain(&dp->obj, dp->clust);	/* Allocate a cluster */
80005a70:	03442583          	lw	a1,52(s0)
80005a74:	00040513          	mv	a0,s0
80005a78:	bb5ff0ef          	jal	ra,8000562c <create_chain>
80005a7c:	00050b13          	mv	s6,a0
					if (clst == 0) return FR_DENIED;			/* No free cluster */
80005a80:	00700513          	li	a0,7
80005a84:	f60b04e3          	beqz	s6,800059ec <dir_next+0x54>
					if (clst == 1) return FR_INT_ERR;			/* Internal error */
80005a88:	00100793          	li	a5,1
80005a8c:	08fb0e63          	beq	s6,a5,80005b28 <dir_next+0x190>
					if (clst == 0xFFFFFFFF) return FR_DISK_ERR;	/* Disk error */
80005a90:	fff00793          	li	a5,-1
80005a94:	08fb0663          	beq	s6,a5,80005b20 <dir_next+0x188>
					if (dir_clear(fs, clst) != FR_OK) return FR_DISK_ERR;	/* Clean up the stretched table */
80005a98:	000b0593          	mv	a1,s6
80005a9c:	00048513          	mv	a0,s1
80005aa0:	ae0fe0ef          	jal	ra,80003d80 <dir_clear>
80005aa4:	06051e63          	bnez	a0,80005b20 <dir_next+0x188>
					if (FF_FS_EXFAT) dp->obj.stat |= 4;			/* exFAT: The directory has been stretched */
80005aa8:	00744783          	lbu	a5,7(s0)
80005aac:	0047e793          	ori	a5,a5,4
80005ab0:	00f403a3          	sb	a5,7(s0)
80005ab4:	01c4a783          	lw	a5,28(s1)
				dp->clust = clst;		/* Initialize data for new cluster */
80005ab8:	03642a23          	sw	s6,52(s0)
	clst -= 2;		/* Cluster number is origin from 2 */
80005abc:	ffeb0593          	addi	a1,s6,-2
	if (clst >= fs->n_fatent - 2) return 0;		/* Is it invalid cluster number? */
80005ac0:	ffe78793          	addi	a5,a5,-2
80005ac4:	00f5fa63          	bgeu	a1,a5,80005ad8 <dir_next+0x140>
	return fs->database + (LBA_t)fs->csize * clst;	/* Start sector number of the cluster */
80005ac8:	00a4d503          	lhu	a0,10(s1)
80005acc:	6d9070ef          	jal	ra,8000d9a4 <__mulsi3>
80005ad0:	0304aa03          	lw	s4,48(s1)
80005ad4:	01450a33          	add	s4,a0,s4
				dp->sect = clst2sect(fs, clst);
80005ad8:	03442c23          	sw	s4,56(s0)
	dp->dir = fs->win + ofs % SS(fs);	/* Pointer to the entry in the win[] */
80005adc:	03c48493          	addi	s1,s1,60
80005ae0:	013484b3          	add	s1,s1,s3
	dp->dptr = ofs;						/* Current entry */
80005ae4:	03242823          	sw	s2,48(s0)
	dp->dir = fs->win + ofs % SS(fs);	/* Pointer to the entry in the win[] */
80005ae8:	02942e23          	sw	s1,60(s0)
	return FR_OK;
80005aec:	00000513          	li	a0,0
80005af0:	efdff06f          	j	800059ec <dir_next+0x54>
80005af4:	100007b7          	lui	a5,0x10000
80005af8:	ee9ff06f          	j	800059e0 <dir_next+0x48>
			if (ofs / SZDIRE >= fs->n_rootdir) {	/* Report EOT if it reached end of static table */
80005afc:	0084d783          	lhu	a5,8(s1)
80005b00:	00595713          	srli	a4,s2,0x5
80005b04:	eef770e3          	bgeu	a4,a5,800059e4 <dir_next+0x4c>
	dp->dir = fs->win + ofs % SS(fs);	/* Pointer to the entry in the win[] */
80005b08:	03c48493          	addi	s1,s1,60
80005b0c:	013484b3          	add	s1,s1,s3
	dp->dptr = ofs;						/* Current entry */
80005b10:	03242823          	sw	s2,48(s0)
	dp->dir = fs->win + ofs % SS(fs);	/* Pointer to the entry in the win[] */
80005b14:	02942e23          	sw	s1,60(s0)
	return FR_OK;
80005b18:	00000513          	li	a0,0
80005b1c:	ed1ff06f          	j	800059ec <dir_next+0x54>
				if (clst == 0xFFFFFFFF) return FR_DISK_ERR;	/* Disk error */
80005b20:	00100513          	li	a0,1
80005b24:	ec9ff06f          	j	800059ec <dir_next+0x54>
				if (clst <= 1) return FR_INT_ERR;			/* Internal error */
80005b28:	00200513          	li	a0,2
80005b2c:	ec1ff06f          	j	800059ec <dir_next+0x54>
	if (dp->sect == 0) return FR_NO_FILE;	/* Report EOT if it has been disabled */
80005b30:	00400513          	li	a0,4
80005b34:	eb9ff06f          	j	800059ec <dir_next+0x54>

80005b38 <dir_alloc>:
{
80005b38:	fe010113          	addi	sp,sp,-32
80005b3c:	01412423          	sw	s4,8(sp)
80005b40:	00058a13          	mv	s4,a1
	res = dir_sdi(dp, 0);
80005b44:	00000593          	li	a1,0
{
80005b48:	00812c23          	sw	s0,24(sp)
80005b4c:	00912a23          	sw	s1,20(sp)
80005b50:	01512223          	sw	s5,4(sp)
80005b54:	00112e23          	sw	ra,28(sp)
80005b58:	01212823          	sw	s2,16(sp)
80005b5c:	01312623          	sw	s3,12(sp)
80005b60:	01612023          	sw	s6,0(sp)
80005b64:	00050413          	mv	s0,a0
	FATFS *fs = dp->obj.fs;
80005b68:	00052483          	lw	s1,0(a0)
	res = dir_sdi(dp, 0);
80005b6c:	a71fe0ef          	jal	ra,800045dc <dir_sdi>
80005b70:	00050a93          	mv	s5,a0
	if (res == FR_OK) {
80005b74:	06051063          	bnez	a0,80005bd4 <dir_alloc+0x9c>
		n = 0;
80005b78:	00000913          	li	s2,0
			if ((fs->fs_type == FS_EXFAT) ? (int)((dp->dir[XDIR_Type] & 0x80) == 0) : (int)(dp->dir[DIR_Name] == DDEM || dp->dir[DIR_Name] == 0)) {	/* Is the entry free? */
80005b7c:	00400993          	li	s3,4
80005b80:	0e500b13          	li	s6,229
			res = move_window(fs, dp->sect);
80005b84:	03842583          	lw	a1,56(s0)
	if (sect != fs->winsect) {	/* Window offset changed? */
80005b88:	0384a783          	lw	a5,56(s1)
80005b8c:	00f58863          	beq	a1,a5,80005b9c <dir_alloc+0x64>
80005b90:	00048513          	mv	a0,s1
80005b94:	c04fe0ef          	jal	ra,80003f98 <move_window.part.6>
			if (res != FR_OK) break;
80005b98:	02051c63          	bnez	a0,80005bd0 <dir_alloc+0x98>
			if ((fs->fs_type == FS_EXFAT) ? (int)((dp->dir[XDIR_Type] & 0x80) == 0) : (int)(dp->dir[DIR_Name] == DDEM || dp->dir[DIR_Name] == 0)) {	/* Is the entry free? */
80005b9c:	03c42783          	lw	a5,60(s0)
80005ba0:	0004c703          	lbu	a4,0(s1)
80005ba4:	0007c783          	lbu	a5,0(a5) # 10000000 <crtStart-0x70000000>
80005ba8:	07370463          	beq	a4,s3,80005c10 <dir_alloc+0xd8>
80005bac:	01678663          	beq	a5,s6,80005bb8 <dir_alloc+0x80>
80005bb0:	0017b793          	seqz	a5,a5
80005bb4:	04078a63          	beqz	a5,80005c08 <dir_alloc+0xd0>
				if (++n == n_ent) break;	/* Is a block of contiguous free entries found? */
80005bb8:	00190913          	addi	s2,s2,1
80005bbc:	03490063          	beq	s2,s4,80005bdc <dir_alloc+0xa4>
			res = dir_next(dp, 1);	/* Next entry with table stretch enabled */
80005bc0:	00100593          	li	a1,1
80005bc4:	00040513          	mv	a0,s0
80005bc8:	dd1ff0ef          	jal	ra,80005998 <dir_next>
		} while (res == FR_OK);
80005bcc:	fa050ce3          	beqz	a0,80005b84 <dir_alloc+0x4c>
80005bd0:	00050a93          	mv	s5,a0
	if (res == FR_NO_FILE) res = FR_DENIED;	/* No directory entry to allocate */
80005bd4:	00400793          	li	a5,4
80005bd8:	04fa8263          	beq	s5,a5,80005c1c <dir_alloc+0xe4>
}
80005bdc:	01c12083          	lw	ra,28(sp)
80005be0:	01812403          	lw	s0,24(sp)
80005be4:	000a8513          	mv	a0,s5
80005be8:	01412483          	lw	s1,20(sp)
80005bec:	01012903          	lw	s2,16(sp)
80005bf0:	00c12983          	lw	s3,12(sp)
80005bf4:	00812a03          	lw	s4,8(sp)
80005bf8:	00412a83          	lw	s5,4(sp)
80005bfc:	00012b03          	lw	s6,0(sp)
80005c00:	02010113          	addi	sp,sp,32
80005c04:	00008067          	ret
				n = 0;				/* Not a free entry, restart to search */
80005c08:	00000913          	li	s2,0
80005c0c:	fb5ff06f          	j	80005bc0 <dir_alloc+0x88>
			if ((fs->fs_type == FS_EXFAT) ? (int)((dp->dir[XDIR_Type] & 0x80) == 0) : (int)(dp->dir[DIR_Name] == DDEM || dp->dir[DIR_Name] == 0)) {	/* Is the entry free? */
80005c10:	0807c793          	xori	a5,a5,128
80005c14:	0077d793          	srli	a5,a5,0x7
80005c18:	f9dff06f          	j	80005bb4 <dir_alloc+0x7c>
	if (res == FR_NO_FILE) res = FR_DENIED;	/* No directory entry to allocate */
80005c1c:	00700a93          	li	s5,7
	return res;
80005c20:	fbdff06f          	j	80005bdc <dir_alloc+0xa4>

80005c24 <dir_remove>:
	res = (dp->blk_ofs == 0xFFFFFFFF) ? FR_OK : dir_sdi(dp, dp->blk_ofs);	/* Goto top of the entry block if LFN is exist */
80005c24:	04c52583          	lw	a1,76(a0)
{
80005c28:	fe010113          	addi	sp,sp,-32
80005c2c:	00812c23          	sw	s0,24(sp)
80005c30:	00912a23          	sw	s1,20(sp)
80005c34:	01212823          	sw	s2,16(sp)
80005c38:	00112e23          	sw	ra,28(sp)
80005c3c:	01312623          	sw	s3,12(sp)
80005c40:	01412423          	sw	s4,8(sp)
80005c44:	01512223          	sw	s5,4(sp)
	res = (dp->blk_ofs == 0xFFFFFFFF) ? FR_OK : dir_sdi(dp, dp->blk_ofs);	/* Goto top of the entry block if LFN is exist */
80005c48:	fff00793          	li	a5,-1
{
80005c4c:	00050413          	mv	s0,a0
	FATFS *fs = dp->obj.fs;
80005c50:	00052483          	lw	s1,0(a0)
	DWORD last = dp->dptr;
80005c54:	03052903          	lw	s2,48(a0)
	res = (dp->blk_ofs == 0xFFFFFFFF) ? FR_OK : dir_sdi(dp, dp->blk_ofs);	/* Goto top of the entry block if LFN is exist */
80005c58:	08f59263          	bne	a1,a5,80005cdc <dir_remove+0xb8>
			if (FF_FS_EXFAT && fs->fs_type == FS_EXFAT) {	/* On the exFAT volume */
80005c5c:	00400a13          	li	s4,4
				dp->dir[DIR_Name] = DDEM;	/* Mark the entry 'deleted'. */
80005c60:	fe500a93          	li	s5,-27
			fs->wflag = 1;
80005c64:	00100993          	li	s3,1
80005c68:	0240006f          	j	80005c8c <dir_remove+0x68>
				dp->dir[DIR_Name] = DDEM;	/* Mark the entry 'deleted'. */
80005c6c:	01578023          	sb	s5,0(a5)
			fs->wflag = 1;
80005c70:	01348223          	sb	s3,4(s1)
			if (dp->dptr >= last) break;	/* If reached last entry then all entries of the object has been deleted. */
80005c74:	03042783          	lw	a5,48(s0)
			res = dir_next(dp, 0);	/* Next entry */
80005c78:	00000593          	li	a1,0
80005c7c:	00040513          	mv	a0,s0
			if (dp->dptr >= last) break;	/* If reached last entry then all entries of the object has been deleted. */
80005c80:	0527fa63          	bgeu	a5,s2,80005cd4 <dir_remove+0xb0>
			res = dir_next(dp, 0);	/* Next entry */
80005c84:	d15ff0ef          	jal	ra,80005998 <dir_next>
		} while (res == FR_OK);
80005c88:	08051063          	bnez	a0,80005d08 <dir_remove+0xe4>
			res = move_window(fs, dp->sect);
80005c8c:	03842783          	lw	a5,56(s0)
	if (sect != fs->winsect) {	/* Window offset changed? */
80005c90:	0384a703          	lw	a4,56(s1)
80005c94:	00048513          	mv	a0,s1
80005c98:	00078593          	mv	a1,a5
80005c9c:	00e78663          	beq	a5,a4,80005ca8 <dir_remove+0x84>
80005ca0:	af8fe0ef          	jal	ra,80003f98 <move_window.part.6>
			if (res != FR_OK) break;
80005ca4:	06051263          	bnez	a0,80005d08 <dir_remove+0xe4>
			if (FF_FS_EXFAT && fs->fs_type == FS_EXFAT) {	/* On the exFAT volume */
80005ca8:	0004c703          	lbu	a4,0(s1)
80005cac:	03c42783          	lw	a5,60(s0)
80005cb0:	fb471ee3          	bne	a4,s4,80005c6c <dir_remove+0x48>
				dp->dir[XDIR_Type] &= 0x7F;	/* Clear the entry InUse flag. */
80005cb4:	0007c703          	lbu	a4,0(a5)
			res = dir_next(dp, 0);	/* Next entry */
80005cb8:	00000593          	li	a1,0
80005cbc:	00040513          	mv	a0,s0
				dp->dir[XDIR_Type] &= 0x7F;	/* Clear the entry InUse flag. */
80005cc0:	07f77713          	andi	a4,a4,127
80005cc4:	00e78023          	sb	a4,0(a5)
			fs->wflag = 1;
80005cc8:	01348223          	sb	s3,4(s1)
			if (dp->dptr >= last) break;	/* If reached last entry then all entries of the object has been deleted. */
80005ccc:	03042783          	lw	a5,48(s0)
80005cd0:	fb27eae3          	bltu	a5,s2,80005c84 <dir_remove+0x60>
80005cd4:	00000513          	li	a0,0
	return res;
80005cd8:	00c0006f          	j	80005ce4 <dir_remove+0xc0>
	res = (dp->blk_ofs == 0xFFFFFFFF) ? FR_OK : dir_sdi(dp, dp->blk_ofs);	/* Goto top of the entry block if LFN is exist */
80005cdc:	901fe0ef          	jal	ra,800045dc <dir_sdi>
	if (res == FR_OK) {
80005ce0:	f6050ee3          	beqz	a0,80005c5c <dir_remove+0x38>
}
80005ce4:	01c12083          	lw	ra,28(sp)
80005ce8:	01812403          	lw	s0,24(sp)
80005cec:	01412483          	lw	s1,20(sp)
80005cf0:	01012903          	lw	s2,16(sp)
80005cf4:	00c12983          	lw	s3,12(sp)
80005cf8:	00812a03          	lw	s4,8(sp)
80005cfc:	00412a83          	lw	s5,4(sp)
80005d00:	02010113          	addi	sp,sp,32
80005d04:	00008067          	ret
		if (res == FR_NO_FILE) res = FR_INT_ERR;
80005d08:	00400793          	li	a5,4
80005d0c:	fcf51ce3          	bne	a0,a5,80005ce4 <dir_remove+0xc0>
80005d10:	00200513          	li	a0,2
80005d14:	fd1ff06f          	j	80005ce4 <dir_remove+0xc0>

80005d18 <load_xdir>:
{
80005d18:	fd010113          	addi	sp,sp,-48
80005d1c:	02812423          	sw	s0,40(sp)
80005d20:	00050413          	mv	s0,a0
	BYTE *dirb = dp->obj.fs->dirbuf;	/* Pointer to the on-memory directory entry block 85+C0+C1s */
80005d24:	00052503          	lw	a0,0(a0)
	res = move_window(dp->obj.fs, dp->sect);
80005d28:	03842583          	lw	a1,56(s0)
{
80005d2c:	01412c23          	sw	s4,24(sp)
	if (sect != fs->winsect) {	/* Window offset changed? */
80005d30:	03852783          	lw	a5,56(a0)
{
80005d34:	02112623          	sw	ra,44(sp)
80005d38:	02912223          	sw	s1,36(sp)
80005d3c:	03212023          	sw	s2,32(sp)
80005d40:	01312e23          	sw	s3,28(sp)
80005d44:	01512a23          	sw	s5,20(sp)
80005d48:	01612823          	sw	s6,16(sp)
80005d4c:	01712623          	sw	s7,12(sp)
	BYTE *dirb = dp->obj.fs->dirbuf;	/* Pointer to the on-memory directory entry block 85+C0+C1s */
80005d50:	01052a03          	lw	s4,16(a0)
	if (sect != fs->winsect) {	/* Window offset changed? */
80005d54:	00f58863          	beq	a1,a5,80005d64 <load_xdir+0x4c>
80005d58:	a40fe0ef          	jal	ra,80003f98 <move_window.part.6>
80005d5c:	00050493          	mv	s1,a0
	if (res != FR_OK) return res;
80005d60:	00051c63          	bnez	a0,80005d78 <load_xdir+0x60>
	if (dp->dir[XDIR_Type] != ET_FILEDIR) return FR_INT_ERR;	/* Invalid order */
80005d64:	03c42583          	lw	a1,60(s0)
80005d68:	08500793          	li	a5,133
80005d6c:	0005c703          	lbu	a4,0(a1)
80005d70:	02f70c63          	beq	a4,a5,80005da8 <load_xdir+0x90>
80005d74:	00200493          	li	s1,2
}
80005d78:	02c12083          	lw	ra,44(sp)
80005d7c:	02812403          	lw	s0,40(sp)
80005d80:	00048513          	mv	a0,s1
80005d84:	02012903          	lw	s2,32(sp)
80005d88:	02412483          	lw	s1,36(sp)
80005d8c:	01c12983          	lw	s3,28(sp)
80005d90:	01812a03          	lw	s4,24(sp)
80005d94:	01412a83          	lw	s5,20(sp)
80005d98:	01012b03          	lw	s6,16(sp)
80005d9c:	00c12b83          	lw	s7,12(sp)
80005da0:	03010113          	addi	sp,sp,48
80005da4:	00008067          	ret
	memcpy(dirb + 0 * SZDIRE, dp->dir, SZDIRE);
80005da8:	02000613          	li	a2,32
80005dac:	000a0513          	mv	a0,s4
80005db0:	8f9fc0ef          	jal	ra,800026a8 <memcpy>
	sz_ent = (dirb[XDIR_NumSec] + 1) * SZDIRE;
80005db4:	001a4903          	lbu	s2,1(s4)
	if (sz_ent < 3 * SZDIRE || sz_ent > 19 * SZDIRE) return FR_INT_ERR;
80005db8:	20000793          	li	a5,512
	sz_ent = (dirb[XDIR_NumSec] + 1) * SZDIRE;
80005dbc:	00190913          	addi	s2,s2,1
80005dc0:	00591913          	slli	s2,s2,0x5
	if (sz_ent < 3 * SZDIRE || sz_ent > 19 * SZDIRE) return FR_INT_ERR;
80005dc4:	fa090713          	addi	a4,s2,-96
80005dc8:	fae7e6e3          	bltu	a5,a4,80005d74 <load_xdir+0x5c>
	res = dir_next(dp, 0);
80005dcc:	00000593          	li	a1,0
80005dd0:	00040513          	mv	a0,s0
80005dd4:	bc5ff0ef          	jal	ra,80005998 <dir_next>
	if (res == FR_NO_FILE) res = FR_INT_ERR;	/* It cannot be */
80005dd8:	00400793          	li	a5,4
	res = dir_next(dp, 0);
80005ddc:	00050493          	mv	s1,a0
	if (res == FR_NO_FILE) res = FR_INT_ERR;	/* It cannot be */
80005de0:	f8f50ae3          	beq	a0,a5,80005d74 <load_xdir+0x5c>
	if (res != FR_OK) return res;
80005de4:	f8051ae3          	bnez	a0,80005d78 <load_xdir+0x60>
	res = move_window(dp->obj.fs, dp->sect);
80005de8:	00042503          	lw	a0,0(s0)
80005dec:	03842583          	lw	a1,56(s0)
	if (sect != fs->winsect) {	/* Window offset changed? */
80005df0:	03852783          	lw	a5,56(a0)
80005df4:	00f58863          	beq	a1,a5,80005e04 <load_xdir+0xec>
80005df8:	9a0fe0ef          	jal	ra,80003f98 <move_window.part.6>
80005dfc:	00050493          	mv	s1,a0
	if (res != FR_OK) return res;
80005e00:	f6051ce3          	bnez	a0,80005d78 <load_xdir+0x60>
	if (dp->dir[XDIR_Type] != ET_STREAM) return FR_INT_ERR;	/* Invalid order */
80005e04:	03c42583          	lw	a1,60(s0)
80005e08:	0c000793          	li	a5,192
80005e0c:	0005c703          	lbu	a4,0(a1)
80005e10:	f6f712e3          	bne	a4,a5,80005d74 <load_xdir+0x5c>
	memcpy(dirb + 1 * SZDIRE, dp->dir, SZDIRE);
80005e14:	02000613          	li	a2,32
80005e18:	020a0513          	addi	a0,s4,32
80005e1c:	88dfc0ef          	jal	ra,800026a8 <memcpy>
	if (MAXDIRB(dirb[XDIR_NumName]) > sz_ent) return FR_INT_ERR;
80005e20:	023a4503          	lbu	a0,35(s4)
80005e24:	00f00593          	li	a1,15
80005e28:	02c50513          	addi	a0,a0,44
80005e2c:	3a5070ef          	jal	ra,8000d9d0 <__udivsi3>
80005e30:	00551513          	slli	a0,a0,0x5
80005e34:	f4a960e3          	bltu	s2,a0,80005d74 <load_xdir+0x5c>
	i = 2 * SZDIRE;	/* Name offset to load */
80005e38:	04000993          	li	s3,64
		if (res == FR_NO_FILE) res = FR_INT_ERR;	/* It cannot be */
80005e3c:	00400a93          	li	s5,4
		if (dp->dir[XDIR_Type] != ET_FILENAME) return FR_INT_ERR;	/* Invalid order */
80005e40:	0c100b13          	li	s6,193
		if (i < MAXDIRB(FF_MAX_LFN)) memcpy(dirb + i, dp->dir, SZDIRE);
80005e44:	25f00b93          	li	s7,607
80005e48:	00c0006f          	j	80005e54 <load_xdir+0x13c>
	} while ((i += SZDIRE) < sz_ent);
80005e4c:	02098993          	addi	s3,s3,32
80005e50:	0529fc63          	bgeu	s3,s2,80005ea8 <load_xdir+0x190>
		res = dir_next(dp, 0);
80005e54:	00000593          	li	a1,0
80005e58:	00040513          	mv	a0,s0
80005e5c:	b3dff0ef          	jal	ra,80005998 <dir_next>
80005e60:	00050493          	mv	s1,a0
		if (res == FR_NO_FILE) res = FR_INT_ERR;	/* It cannot be */
80005e64:	f15508e3          	beq	a0,s5,80005d74 <load_xdir+0x5c>
		if (res != FR_OK) return res;
80005e68:	f00518e3          	bnez	a0,80005d78 <load_xdir+0x60>
		res = move_window(dp->obj.fs, dp->sect);
80005e6c:	00042503          	lw	a0,0(s0)
80005e70:	03842783          	lw	a5,56(s0)
	if (sect != fs->winsect) {	/* Window offset changed? */
80005e74:	03852703          	lw	a4,56(a0)
80005e78:	00078593          	mv	a1,a5
80005e7c:	00e78663          	beq	a5,a4,80005e88 <load_xdir+0x170>
80005e80:	918fe0ef          	jal	ra,80003f98 <move_window.part.6>
		if (res != FR_OK) return res;
80005e84:	0a051a63          	bnez	a0,80005f38 <load_xdir+0x220>
		if (dp->dir[XDIR_Type] != ET_FILENAME) return FR_INT_ERR;	/* Invalid order */
80005e88:	03c42583          	lw	a1,60(s0)
80005e8c:	0005c783          	lbu	a5,0(a1)
80005e90:	ef6792e3          	bne	a5,s6,80005d74 <load_xdir+0x5c>
		if (i < MAXDIRB(FF_MAX_LFN)) memcpy(dirb + i, dp->dir, SZDIRE);
80005e94:	fb3bece3          	bltu	s7,s3,80005e4c <load_xdir+0x134>
80005e98:	013a0533          	add	a0,s4,s3
80005e9c:	02000613          	li	a2,32
80005ea0:	809fc0ef          	jal	ra,800026a8 <memcpy>
80005ea4:	fa9ff06f          	j	80005e4c <load_xdir+0x134>
	if (i <= MAXDIRB(FF_MAX_LFN)) {
80005ea8:	26000793          	li	a5,608
80005eac:	ed37e6e3          	bltu	a5,s3,80005d78 <load_xdir+0x60>
	szblk = (dir[XDIR_NumSec] + 1) * SZDIRE;	/* Number of bytes of the entry block */
80005eb0:	001a4583          	lbu	a1,1(s4)
	for (i = sum = 0; i < szblk; i++) {
80005eb4:	00000693          	li	a3,0
80005eb8:	00000793          	li	a5,0
	szblk = (dir[XDIR_NumSec] + 1) * SZDIRE;	/* Number of bytes of the entry block */
80005ebc:	00158593          	addi	a1,a1,1
80005ec0:	00559593          	slli	a1,a1,0x5
		if (i == XDIR_SetSum) {	/* Skip 2-byte sum field */
80005ec4:	00200513          	li	a0,2
80005ec8:	00f79713          	slli	a4,a5,0xf
80005ecc:	0017d613          	srli	a2,a5,0x1
80005ed0:	02a69463          	bne	a3,a0,80005ef8 <load_xdir+0x1e0>
			sum = ((sum & 1) ? 0x8000 : 0) + (sum >> 1) + dir[i];
80005ed4:	004a4783          	lbu	a5,4(s4)
	for (i = sum = 0; i < szblk; i++) {
80005ed8:	00500693          	li	a3,5
80005edc:	00f707b3          	add	a5,a4,a5
			sum = ((sum & 1) ? 0x8000 : 0) + (sum >> 1) + dir[i];
80005ee0:	00c787b3          	add	a5,a5,a2
80005ee4:	01079793          	slli	a5,a5,0x10
80005ee8:	0107d793          	srli	a5,a5,0x10
		if (i == XDIR_SetSum) {	/* Skip 2-byte sum field */
80005eec:	00f79713          	slli	a4,a5,0xf
80005ef0:	0017d613          	srli	a2,a5,0x1
80005ef4:	fea680e3          	beq	a3,a0,80005ed4 <load_xdir+0x1bc>
			sum = ((sum & 1) ? 0x8000 : 0) + (sum >> 1) + dir[i];
80005ef8:	00da0733          	add	a4,s4,a3
80005efc:	00074603          	lbu	a2,0(a4)
80005f00:	00f79713          	slli	a4,a5,0xf
80005f04:	0017d793          	srli	a5,a5,0x1
80005f08:	00c70733          	add	a4,a4,a2
80005f0c:	00f707b3          	add	a5,a4,a5
80005f10:	01079793          	slli	a5,a5,0x10
	for (i = sum = 0; i < szblk; i++) {
80005f14:	00168693          	addi	a3,a3,1
			sum = ((sum & 1) ? 0x8000 : 0) + (sum >> 1) + dir[i];
80005f18:	0107d793          	srli	a5,a5,0x10
	for (i = sum = 0; i < szblk; i++) {
80005f1c:	fab6e6e3          	bltu	a3,a1,80005ec8 <load_xdir+0x1b0>
	rv = rv << 8 | ptr[0];
80005f20:	003a4703          	lbu	a4,3(s4)
80005f24:	002a4683          	lbu	a3,2(s4)
80005f28:	00871713          	slli	a4,a4,0x8
		if (xdir_sum(dirb) != ld_word(dirb + XDIR_SetSum)) return FR_INT_ERR;
80005f2c:	00d76733          	or	a4,a4,a3
80005f30:	e4f704e3          	beq	a4,a5,80005d78 <load_xdir+0x60>
80005f34:	e41ff06f          	j	80005d74 <load_xdir+0x5c>
80005f38:	00050493          	mv	s1,a0
80005f3c:	e3dff06f          	j	80005d78 <load_xdir+0x60>

80005f40 <store_xdir>:
	BYTE *dirb = dp->obj.fs->dirbuf;	/* Pointer to the directory entry block 85+C0+C1s */
80005f40:	00052683          	lw	a3,0(a0)
{
80005f44:	fe010113          	addi	sp,sp,-32
80005f48:	01212823          	sw	s2,16(sp)
	BYTE *dirb = dp->obj.fs->dirbuf;	/* Pointer to the directory entry block 85+C0+C1s */
80005f4c:	0106a903          	lw	s2,16(a3)
{
80005f50:	00812c23          	sw	s0,24(sp)
80005f54:	01312623          	sw	s3,12(sp)
80005f58:	00112e23          	sw	ra,28(sp)
80005f5c:	00912a23          	sw	s1,20(sp)
	szblk = (dir[XDIR_NumSec] + 1) * SZDIRE;	/* Number of bytes of the entry block */
80005f60:	00194483          	lbu	s1,1(s2)
{
80005f64:	00050413          	mv	s0,a0
	for (i = sum = 0; i < szblk; i++) {
80005f68:	00000793          	li	a5,0
	szblk = (dir[XDIR_NumSec] + 1) * SZDIRE;	/* Number of bytes of the entry block */
80005f6c:	00148493          	addi	s1,s1,1
	for (i = sum = 0; i < szblk; i++) {
80005f70:	00000713          	li	a4,0
		if (i == XDIR_SetSum) {	/* Skip 2-byte sum field */
80005f74:	00200993          	li	s3,2
	szblk = (dir[XDIR_NumSec] + 1) * SZDIRE;	/* Number of bytes of the entry block */
80005f78:	00549593          	slli	a1,s1,0x5
		if (i == XDIR_SetSum) {	/* Skip 2-byte sum field */
80005f7c:	00f79693          	slli	a3,a5,0xf
80005f80:	0017d613          	srli	a2,a5,0x1
80005f84:	03371463          	bne	a4,s3,80005fac <store_xdir+0x6c>
			sum = ((sum & 1) ? 0x8000 : 0) + (sum >> 1) + dir[i];
80005f88:	00494783          	lbu	a5,4(s2)
	for (i = sum = 0; i < szblk; i++) {
80005f8c:	00500713          	li	a4,5
80005f90:	00f687b3          	add	a5,a3,a5
			sum = ((sum & 1) ? 0x8000 : 0) + (sum >> 1) + dir[i];
80005f94:	00c787b3          	add	a5,a5,a2
80005f98:	01079793          	slli	a5,a5,0x10
80005f9c:	0107d793          	srli	a5,a5,0x10
		if (i == XDIR_SetSum) {	/* Skip 2-byte sum field */
80005fa0:	00f79693          	slli	a3,a5,0xf
80005fa4:	0017d613          	srli	a2,a5,0x1
80005fa8:	ff3700e3          	beq	a4,s3,80005f88 <store_xdir+0x48>
			sum = ((sum & 1) ? 0x8000 : 0) + (sum >> 1) + dir[i];
80005fac:	00e906b3          	add	a3,s2,a4
80005fb0:	0006c603          	lbu	a2,0(a3)
80005fb4:	00f79693          	slli	a3,a5,0xf
80005fb8:	0017d793          	srli	a5,a5,0x1
80005fbc:	00c686b3          	add	a3,a3,a2
80005fc0:	00f687b3          	add	a5,a3,a5
80005fc4:	01079793          	slli	a5,a5,0x10
	for (i = sum = 0; i < szblk; i++) {
80005fc8:	00170713          	addi	a4,a4,1
			sum = ((sum & 1) ? 0x8000 : 0) + (sum >> 1) + dir[i];
80005fcc:	0107d793          	srli	a5,a5,0x10
	for (i = sum = 0; i < szblk; i++) {
80005fd0:	fab766e3          	bltu	a4,a1,80005f7c <store_xdir+0x3c>
	*ptr++ = (BYTE)val; val >>= 8;
80005fd4:	0087d713          	srli	a4,a5,0x8
80005fd8:	00f90123          	sb	a5,2(s2)
	*ptr++ = (BYTE)val;
80005fdc:	00e901a3          	sb	a4,3(s2)
	res = dir_sdi(dp, dp->blk_ofs);
80005fe0:	04c42583          	lw	a1,76(s0)
80005fe4:	00040513          	mv	a0,s0
80005fe8:	df4fe0ef          	jal	ra,800045dc <dir_sdi>
	while (res == FR_OK) {
80005fec:	0a051663          	bnez	a0,80006098 <store_xdir+0x158>
		dp->obj.fs->wflag = 1;
80005ff0:	00100993          	li	s3,1
80005ff4:	0100006f          	j	80006004 <store_xdir+0xc4>
		res = dir_next(dp, 0);
80005ff8:	9a1ff0ef          	jal	ra,80005998 <dir_next>
		dirb += SZDIRE;
80005ffc:	02090913          	addi	s2,s2,32
	while (res == FR_OK) {
80006000:	06051463          	bnez	a0,80006068 <store_xdir+0x128>
		res = move_window(dp->obj.fs, dp->sect);
80006004:	00042503          	lw	a0,0(s0)
80006008:	03842783          	lw	a5,56(s0)
		if (--nent == 0) break;
8000600c:	fff48493          	addi	s1,s1,-1
	if (sect != fs->winsect) {	/* Window offset changed? */
80006010:	03852703          	lw	a4,56(a0)
80006014:	00078593          	mv	a1,a5
80006018:	00e78663          	beq	a5,a4,80006024 <store_xdir+0xe4>
8000601c:	f7dfd0ef          	jal	ra,80003f98 <move_window.part.6>
		if (res != FR_OK) break;
80006020:	04051463          	bnez	a0,80006068 <store_xdir+0x128>
		memcpy(dp->dir, dirb, SZDIRE);
80006024:	03c42503          	lw	a0,60(s0)
80006028:	00090593          	mv	a1,s2
8000602c:	02000613          	li	a2,32
80006030:	e78fc0ef          	jal	ra,800026a8 <memcpy>
		dp->obj.fs->wflag = 1;
80006034:	00042783          	lw	a5,0(s0)
		res = dir_next(dp, 0);
80006038:	00000593          	li	a1,0
8000603c:	00040513          	mv	a0,s0
		dp->obj.fs->wflag = 1;
80006040:	01378223          	sb	s3,4(a5)
		if (--nent == 0) break;
80006044:	fa049ae3          	bnez	s1,80005ff8 <store_xdir+0xb8>
}
80006048:	01c12083          	lw	ra,28(sp)
8000604c:	01812403          	lw	s0,24(sp)
80006050:	00048513          	mv	a0,s1
80006054:	01012903          	lw	s2,16(sp)
80006058:	01412483          	lw	s1,20(sp)
8000605c:	00c12983          	lw	s3,12(sp)
80006060:	02010113          	addi	sp,sp,32
80006064:	00008067          	ret
80006068:	00200793          	li	a5,2
8000606c:	00050493          	mv	s1,a0
80006070:	fca7fce3          	bgeu	a5,a0,80006048 <store_xdir+0x108>
80006074:	01c12083          	lw	ra,28(sp)
80006078:	01812403          	lw	s0,24(sp)
8000607c:	00200493          	li	s1,2
80006080:	00048513          	mv	a0,s1
80006084:	01012903          	lw	s2,16(sp)
80006088:	01412483          	lw	s1,20(sp)
8000608c:	00c12983          	lw	s3,12(sp)
80006090:	02010113          	addi	sp,sp,32
80006094:	00008067          	ret
80006098:	00050493          	mv	s1,a0
8000609c:	faa9f6e3          	bgeu	s3,a0,80006048 <store_xdir+0x108>
800060a0:	fd5ff06f          	j	80006074 <store_xdir+0x134>

800060a4 <dir_read.constprop.12>:
static FRESULT dir_read (
800060a4:	fd010113          	addi	sp,sp,-48
800060a8:	03212023          	sw	s2,32(sp)
800060ac:	8000e937          	lui	s2,0x8000e
800060b0:	01312e23          	sw	s3,28(sp)
800060b4:	4b490913          	addi	s2,s2,1204 # 8000e4b4 <STACK_TOP+0xfffee4b4>
			if (uc != 0xFFFF) return 0;		/* Check filler */
800060b8:	000109b7          	lui	s3,0x10
static FRESULT dir_read (
800060bc:	02812423          	sw	s0,40(sp)
800060c0:	02912223          	sw	s1,36(sp)
800060c4:	01412c23          	sw	s4,24(sp)
800060c8:	01512a23          	sw	s5,20(sp)
800060cc:	01612823          	sw	s6,16(sp)
800060d0:	01712623          	sw	s7,12(sp)
800060d4:	00050413          	mv	s0,a0
	FATFS *fs = dp->obj.fs;
800060d8:	00052b83          	lw	s7,0(a0)
static FRESULT dir_read (
800060dc:	02112623          	sw	ra,44(sp)
	BYTE ord = 0xFF, sum = 0xFF;
800060e0:	0ff00a13          	li	s4,255
800060e4:	0ff00493          	li	s1,255
	FRESULT res = FR_NO_FILE;
800060e8:	00400513          	li	a0,4
				ord = 0xFF;
800060ec:	0ff00b13          	li	s6,255
800060f0:	00d90a93          	addi	s5,s2,13
			if (uc != 0xFFFF) return 0;		/* Check filler */
800060f4:	fff98993          	addi	s3,s3,-1 # ffff <crtStart-0x7fff0001>
	while (dp->sect) {
800060f8:	03842583          	lw	a1,56(s0)
800060fc:	1a058063          	beqz	a1,8000629c <dir_read.constprop.12+0x1f8>
	if (sect != fs->winsect) {	/* Window offset changed? */
80006100:	038ba783          	lw	a5,56(s7)
80006104:	00b78863          	beq	a5,a1,80006114 <dir_read.constprop.12+0x70>
80006108:	000b8513          	mv	a0,s7
8000610c:	e8dfd0ef          	jal	ra,80003f98 <move_window.part.6>
		if (res != FR_OK) break;
80006110:	04051c63          	bnez	a0,80006168 <dir_read.constprop.12+0xc4>
		b = dp->dir[DIR_Name];	/* Test for the entry type */
80006114:	03c42683          	lw	a3,60(s0)
80006118:	0006c783          	lbu	a5,0(a3)
		if (b == 0) {
8000611c:	18078663          	beqz	a5,800062a8 <dir_read.constprop.12+0x204>
		if (fs->fs_type == FS_EXFAT) {	/* On the exFAT volume */
80006120:	000bc603          	lbu	a2,0(s7)
80006124:	00400713          	li	a4,4
80006128:	12e60e63          	beq	a2,a4,80006264 <dir_read.constprop.12+0x1c0>
			dp->obj.attr = attr = dp->dir[DIR_Attr] & AM_MASK;	/* Get attribute */
8000612c:	00b6c703          	lbu	a4,11(a3)
			if (b == DDEM || b == '.' || (int)((attr & ~AM_ARC) == AM_VOL) != vol) {	/* An entry without valid data */
80006130:	0e500613          	li	a2,229
			dp->obj.attr = attr = dp->dir[DIR_Attr] & AM_MASK;	/* Get attribute */
80006134:	03f77713          	andi	a4,a4,63
80006138:	00e40323          	sb	a4,6(s0)
			if (b == DDEM || b == '.' || (int)((attr & ~AM_ARC) == AM_VOL) != vol) {	/* An entry without valid data */
8000613c:	00c78c63          	beq	a5,a2,80006154 <dir_read.constprop.12+0xb0>
80006140:	02e00613          	li	a2,46
80006144:	00c78863          	beq	a5,a2,80006154 <dir_read.constprop.12+0xb0>
80006148:	fdf77613          	andi	a2,a4,-33
8000614c:	00800593          	li	a1,8
80006150:	04b61463          	bne	a2,a1,80006198 <dir_read.constprop.12+0xf4>
					ord = (b == ord && sum == dp->dir[LDIR_Chksum] && pick_lfn(fs->lfnbuf, dp->dir)) ? ord - 1 : 0xFF;
80006154:	0ff00493          	li	s1,255
		res = dir_next(dp, 0);		/* Next entry */
80006158:	00000593          	li	a1,0
8000615c:	00040513          	mv	a0,s0
80006160:	839ff0ef          	jal	ra,80005998 <dir_next>
		if (res != FR_OK) break;
80006164:	f8050ae3          	beqz	a0,800060f8 <dir_read.constprop.12+0x54>
	if (res != FR_OK) dp->sect = 0;		/* Terminate the read operation on error or EOT */
80006168:	02042c23          	sw	zero,56(s0)
}
8000616c:	02c12083          	lw	ra,44(sp)
80006170:	02812403          	lw	s0,40(sp)
80006174:	02412483          	lw	s1,36(sp)
80006178:	02012903          	lw	s2,32(sp)
8000617c:	01c12983          	lw	s3,28(sp)
80006180:	01812a03          	lw	s4,24(sp)
80006184:	01412a83          	lw	s5,20(sp)
80006188:	01012b03          	lw	s6,16(sp)
8000618c:	00c12b83          	lw	s7,12(sp)
80006190:	03010113          	addi	sp,sp,48
80006194:	00008067          	ret
				if (attr == AM_LFN) {	/* An LFN entry is found */
80006198:	00f00613          	li	a2,15
8000619c:	14c71063          	bne	a4,a2,800062dc <dir_read.constprop.12+0x238>
					if (b & LLEF) {		/* Is it start of an LFN sequence? */
800061a0:	0407f713          	andi	a4,a5,64
800061a4:	0e070863          	beqz	a4,80006294 <dir_read.constprop.12+0x1f0>
						dp->blk_ofs = dp->dptr;
800061a8:	03042703          	lw	a4,48(s0)
						sum = dp->dir[LDIR_Chksum];
800061ac:	00d6ca03          	lbu	s4,13(a3)
						b &= (BYTE)~LLEF; ord = b;
800061b0:	0bf7f493          	andi	s1,a5,191
						dp->blk_ofs = dp->dptr;
800061b4:	04e42623          	sw	a4,76(s0)
					ord = (b == ord && sum == dp->dir[LDIR_Chksum] && pick_lfn(fs->lfnbuf, dp->dir)) ? ord - 1 : 0xFF;
800061b8:	00d6c783          	lbu	a5,13(a3)
800061bc:	f9479ce3          	bne	a5,s4,80006154 <dir_read.constprop.12+0xb0>
	rv = rv << 8 | ptr[0];
800061c0:	01b6c783          	lbu	a5,27(a3)
800061c4:	01a6c703          	lbu	a4,26(a3)
800061c8:	00879793          	slli	a5,a5,0x8
800061cc:	00e7e7b3          	or	a5,a5,a4
	if (ld_word(dir + LDIR_FstClusLO) != 0) return 0;	/* Check LDIR_FstClusLO is 0 */
800061d0:	f80792e3          	bnez	a5,80006154 <dir_read.constprop.12+0xb0>
	i = ((dir[LDIR_Ord] & ~LLEF) - 1) * 13;	/* Offset in the LFN buffer */
800061d4:	0006c783          	lbu	a5,0(a3)
800061d8:	00100713          	li	a4,1
		uc = ld_word(dir + LfnOfs[s]);		/* Pick an LFN character */
800061dc:	00e68733          	add	a4,a3,a4
	i = ((dir[LDIR_Ord] & ~LLEF) - 1) * 13;	/* Offset in the LFN buffer */
800061e0:	fbf7f793          	andi	a5,a5,-65
800061e4:	fff78793          	addi	a5,a5,-1
800061e8:	00179593          	slli	a1,a5,0x1
800061ec:	00f585b3          	add	a1,a1,a5
800061f0:	00259593          	slli	a1,a1,0x2
800061f4:	00f585b3          	add	a1,a1,a5
	rv = rv << 8 | ptr[0];
800061f8:	00174783          	lbu	a5,1(a4)
800061fc:	00074503          	lbu	a0,0(a4)
					ord = (b == ord && sum == dp->dir[LDIR_Chksum] && pick_lfn(fs->lfnbuf, dp->dir)) ? ord - 1 : 0xFF;
80006200:	00cba883          	lw	a7,12(s7)
			lfnbuf[i++] = wc = uc;			/* Store it */
80006204:	00159713          	slli	a4,a1,0x1
	rv = rv << 8 | ptr[0];
80006208:	00879793          	slli	a5,a5,0x8
	for (wc = 1, s = 0; s < 13; s++) {		/* Process all characters in the entry */
8000620c:	00100813          	li	a6,1
80006210:	00190613          	addi	a2,s2,1
			lfnbuf[i++] = wc = uc;			/* Store it */
80006214:	00e88733          	add	a4,a7,a4
	rv = rv << 8 | ptr[0];
80006218:	00a7e7b3          	or	a5,a5,a0
		if (wc != 0) {
8000621c:	04080063          	beqz	a6,8000625c <dir_read.constprop.12+0x1b8>
			if (i >= FF_MAX_LFN + 1) return 0;	/* Buffer overflow? */
80006220:	f2bb6ae3          	bltu	s6,a1,80006154 <dir_read.constprop.12+0xb0>
			lfnbuf[i++] = wc = uc;			/* Store it */
80006224:	00f71023          	sh	a5,0(a4)
	rv = rv << 8 | ptr[0];
80006228:	00078813          	mv	a6,a5
			lfnbuf[i++] = wc = uc;			/* Store it */
8000622c:	00158593          	addi	a1,a1,1
	for (wc = 1, s = 0; s < 13; s++) {		/* Process all characters in the entry */
80006230:	08ca8063          	beq	s5,a2,800062b0 <dir_read.constprop.12+0x20c>
80006234:	00064703          	lbu	a4,0(a2) # f0000000 <STACK_TOP+0x6ffe0000>
80006238:	00160613          	addi	a2,a2,1
		uc = ld_word(dir + LfnOfs[s]);		/* Pick an LFN character */
8000623c:	00e68733          	add	a4,a3,a4
	rv = rv << 8 | ptr[0];
80006240:	00174783          	lbu	a5,1(a4)
80006244:	00074503          	lbu	a0,0(a4)
			lfnbuf[i++] = wc = uc;			/* Store it */
80006248:	00159713          	slli	a4,a1,0x1
	rv = rv << 8 | ptr[0];
8000624c:	00879793          	slli	a5,a5,0x8
			lfnbuf[i++] = wc = uc;			/* Store it */
80006250:	00e88733          	add	a4,a7,a4
	rv = rv << 8 | ptr[0];
80006254:	00a7e7b3          	or	a5,a5,a0
		if (wc != 0) {
80006258:	fc0814e3          	bnez	a6,80006220 <dir_read.constprop.12+0x17c>
			if (uc != 0xFFFF) return 0;		/* Check filler */
8000625c:	fd378ae3          	beq	a5,s3,80006230 <dir_read.constprop.12+0x18c>
80006260:	ef5ff06f          	j	80006154 <dir_read.constprop.12+0xb0>
				if (b == ET_FILEDIR) {		/* Start of the file entry block? */
80006264:	08500713          	li	a4,133
80006268:	eee798e3          	bne	a5,a4,80006158 <dir_read.constprop.12+0xb4>
					dp->blk_ofs = dp->dptr;	/* Get location of the block */
8000626c:	03042783          	lw	a5,48(s0)
					res = load_xdir(dp);	/* Load the entry block */
80006270:	00040513          	mv	a0,s0
					dp->blk_ofs = dp->dptr;	/* Get location of the block */
80006274:	04f42623          	sw	a5,76(s0)
					res = load_xdir(dp);	/* Load the entry block */
80006278:	aa1ff0ef          	jal	ra,80005d18 <load_xdir>
					if (res == FR_OK) {
8000627c:	ee0516e3          	bnez	a0,80006168 <dir_read.constprop.12+0xc4>
						dp->obj.attr = fs->dirbuf[XDIR_Attr] & AM_MASK;	/* Get attribute */
80006280:	010ba783          	lw	a5,16(s7)
80006284:	0047c783          	lbu	a5,4(a5)
80006288:	03f7f793          	andi	a5,a5,63
8000628c:	00f40323          	sb	a5,6(s0)
	if (res != FR_OK) dp->sect = 0;		/* Terminate the read operation on error or EOT */
80006290:	eddff06f          	j	8000616c <dir_read.constprop.12+0xc8>
					ord = (b == ord && sum == dp->dir[LDIR_Chksum] && pick_lfn(fs->lfnbuf, dp->dir)) ? ord - 1 : 0xFF;
80006294:	ec9790e3          	bne	a5,s1,80006154 <dir_read.constprop.12+0xb0>
80006298:	f21ff06f          	j	800061b8 <dir_read.constprop.12+0x114>
	if (res != FR_OK) dp->sect = 0;		/* Terminate the read operation on error or EOT */
8000629c:	ec0516e3          	bnez	a0,80006168 <dir_read.constprop.12+0xc4>
						dp->blk_ofs = 0xFFFFFFFF;	/* It has no LFN. */
800062a0:	00000513          	li	a0,0
800062a4:	ec9ff06f          	j	8000616c <dir_read.constprop.12+0xc8>
			res = FR_NO_FILE; break; /* Reached to end of the directory */
800062a8:	00400513          	li	a0,4
800062ac:	ebdff06f          	j	80006168 <dir_read.constprop.12+0xc4>
	if (dir[LDIR_Ord] & LLEF && wc != 0) {	/* Put terminator if it is the last LFN part and not terminated */
800062b0:	0006c783          	lbu	a5,0(a3)
800062b4:	0407f793          	andi	a5,a5,64
800062b8:	00078c63          	beqz	a5,800062d0 <dir_read.constprop.12+0x22c>
800062bc:	00080a63          	beqz	a6,800062d0 <dir_read.constprop.12+0x22c>
		if (i >= FF_MAX_LFN + 1) return 0;	/* Buffer overflow? */
800062c0:	e8bb6ae3          	bltu	s6,a1,80006154 <dir_read.constprop.12+0xb0>
		lfnbuf[i] = 0;
800062c4:	00159593          	slli	a1,a1,0x1
800062c8:	00b885b3          	add	a1,a7,a1
800062cc:	00059023          	sh	zero,0(a1)
					ord = (b == ord && sum == dp->dir[LDIR_Chksum] && pick_lfn(fs->lfnbuf, dp->dir)) ? ord - 1 : 0xFF;
800062d0:	fff48493          	addi	s1,s1,-1
800062d4:	0ff4f493          	andi	s1,s1,255
800062d8:	e81ff06f          	j	80006158 <dir_read.constprop.12+0xb4>
					if (ord != 0 || sum != sum_sfn(dp->dir)) {	/* Is there a valid LFN? */
800062dc:	02049663          	bnez	s1,80006308 <dir_read.constprop.12+0x264>
800062e0:	00b68613          	addi	a2,a3,11
		sum = (sum >> 1) + (sum << 7) + *dir++;
800062e4:	00168693          	addi	a3,a3,1
800062e8:	fff6c703          	lbu	a4,-1(a3)
800062ec:	0014d793          	srli	a5,s1,0x1
800062f0:	00749493          	slli	s1,s1,0x7
800062f4:	0097e4b3          	or	s1,a5,s1
800062f8:	00e484b3          	add	s1,s1,a4
800062fc:	0ff4f493          	andi	s1,s1,255
	} while (--n);
80006300:	fec692e3          	bne	a3,a2,800062e4 <dir_read.constprop.12+0x240>
					if (ord != 0 || sum != sum_sfn(dp->dir)) {	/* Is there a valid LFN? */
80006304:	f9448ee3          	beq	s1,s4,800062a0 <dir_read.constprop.12+0x1fc>
						dp->blk_ofs = 0xFFFFFFFF;	/* It has no LFN. */
80006308:	fff00793          	li	a5,-1
8000630c:	04f42623          	sw	a5,76(s0)
80006310:	00000513          	li	a0,0
80006314:	e59ff06f          	j	8000616c <dir_read.constprop.12+0xc8>

80006318 <dir_find>:
{
80006318:	fb010113          	addi	sp,sp,-80
	res = dir_sdi(dp, 0);			/* Rewind directory object */
8000631c:	00000593          	li	a1,0
{
80006320:	04812423          	sw	s0,72(sp)
80006324:	05212023          	sw	s2,64(sp)
80006328:	03312e23          	sw	s3,60(sp)
8000632c:	04112623          	sw	ra,76(sp)
80006330:	04912223          	sw	s1,68(sp)
80006334:	03412c23          	sw	s4,56(sp)
80006338:	03512a23          	sw	s5,52(sp)
8000633c:	03612823          	sw	s6,48(sp)
80006340:	03712623          	sw	s7,44(sp)
80006344:	03812423          	sw	s8,40(sp)
80006348:	03912223          	sw	s9,36(sp)
8000634c:	03a12023          	sw	s10,32(sp)
80006350:	01b12e23          	sw	s11,28(sp)
80006354:	00050413          	mv	s0,a0
	FATFS *fs = dp->obj.fs;
80006358:	00052903          	lw	s2,0(a0)
	res = dir_sdi(dp, 0);			/* Rewind directory object */
8000635c:	a80fe0ef          	jal	ra,800045dc <dir_sdi>
80006360:	00050993          	mv	s3,a0
	if (res != FR_OK) return res;
80006364:	0c051663          	bnez	a0,80006430 <dir_find+0x118>
	if (fs->fs_type == FS_EXFAT) {	/* On the exFAT volume */
80006368:	00094703          	lbu	a4,0(s2)
8000636c:	00400793          	li	a5,4
80006370:	22f70e63          	beq	a4,a5,800065ac <dir_find+0x294>
	ord = sum = 0xFF; dp->blk_ofs = 0xFFFFFFFF;	/* Reset LFN sequence */
80006374:	8000ea37          	lui	s4,0x8000e
80006378:	4b4a0a13          	addi	s4,s4,1204 # 8000e4b4 <STACK_TOP+0xfffee4b4>
8000637c:	fff00793          	li	a5,-1
			if (uc != 0xFFFF) return 0;		/* Check filler */
80006380:	00010ab7          	lui	s5,0x10
	ord = sum = 0xFF; dp->blk_ofs = 0xFFFFFFFF;	/* Reset LFN sequence */
80006384:	04f42623          	sw	a5,76(s0)
80006388:	0ff00b13          	li	s6,255
8000638c:	0ff00493          	li	s1,255
			ord = 0xFF; dp->blk_ofs = 0xFFFFFFFF;	/* Reset LFN sequence */
80006390:	0ff00c13          	li	s8,255
80006394:	00da0b93          	addi	s7,s4,13
			if (uc != 0xFFFF) return 0;		/* Check filler */
80006398:	fffa8a93          	addi	s5,s5,-1 # ffff <crtStart-0x7fff0001>
8000639c:	0280006f          	j	800063c4 <dir_find+0xac>
		if (c == DDEM || ((a & AM_VOL) && a != AM_LFN)) {	/* An entry without valid data */
800063a0:	00f00793          	li	a5,15
800063a4:	0cf70663          	beq	a4,a5,80006470 <dir_find+0x158>
				ord = 0xFF; dp->blk_ofs = 0xFFFFFFFF;	/* Reset LFN sequence */
800063a8:	fff00793          	li	a5,-1
800063ac:	04f42623          	sw	a5,76(s0)
800063b0:	0ff00493          	li	s1,255
		res = dir_next(dp, 0);	/* Next entry */
800063b4:	00000593          	li	a1,0
800063b8:	00040513          	mv	a0,s0
800063bc:	ddcff0ef          	jal	ra,80005998 <dir_next>
	} while (res == FR_OK);
800063c0:	1c051e63          	bnez	a0,8000659c <dir_find+0x284>
		res = move_window(fs, dp->sect);
800063c4:	03842583          	lw	a1,56(s0)
	if (sect != fs->winsect) {	/* Window offset changed? */
800063c8:	03892783          	lw	a5,56(s2)
800063cc:	00f58863          	beq	a1,a5,800063dc <dir_find+0xc4>
800063d0:	00090513          	mv	a0,s2
800063d4:	bc5fd0ef          	jal	ra,80003f98 <move_window.part.6>
		if (res != FR_OK) break;
800063d8:	1c051263          	bnez	a0,8000659c <dir_find+0x284>
		c = dp->dir[DIR_Name];
800063dc:	03c42d03          	lw	s10,60(s0)
800063e0:	000d4c83          	lbu	s9,0(s10)
		if (c == 0) { res = FR_NO_FILE; break; }	/* Reached to end of table */
800063e4:	1c0c8063          	beqz	s9,800065a4 <dir_find+0x28c>
		dp->obj.attr = a = dp->dir[DIR_Attr] & AM_MASK;
800063e8:	00bd4783          	lbu	a5,11(s10)
		if (c == DDEM || ((a & AM_VOL) && a != AM_LFN)) {	/* An entry without valid data */
800063ec:	0e500693          	li	a3,229
		dp->obj.attr = a = dp->dir[DIR_Attr] & AM_MASK;
800063f0:	03f7f713          	andi	a4,a5,63
800063f4:	00e40323          	sb	a4,6(s0)
		if (c == DDEM || ((a & AM_VOL) && a != AM_LFN)) {	/* An entry without valid data */
800063f8:	fadc88e3          	beq	s9,a3,800063a8 <dir_find+0x90>
800063fc:	0087f793          	andi	a5,a5,8
80006400:	fa0790e3          	bnez	a5,800063a0 <dir_find+0x88>
			if (a == AM_LFN) {			/* An LFN entry is found */
80006404:	00f00793          	li	a5,15
80006408:	06f70463          	beq	a4,a5,80006470 <dir_find+0x158>
				if (ord == 0 && sum == sum_sfn(dp->dir)) break;	/* LFN matched? */
8000640c:	14048463          	beqz	s1,80006554 <dir_find+0x23c>
				if (!(dp->fn[NSFLAG] & NS_LOSS) && !memcmp(dp->dir, dp->fn, 11)) break;	/* SFN matched? */
80006410:	04b44783          	lbu	a5,75(s0)
80006414:	0017f793          	andi	a5,a5,1
80006418:	f80798e3          	bnez	a5,800063a8 <dir_find+0x90>
8000641c:	00b00613          	li	a2,11
80006420:	04040593          	addi	a1,s0,64
80006424:	000d0513          	mv	a0,s10
80006428:	b18fc0ef          	jal	ra,80002740 <memcmp>
8000642c:	f6051ee3          	bnez	a0,800063a8 <dir_find+0x90>
}
80006430:	04c12083          	lw	ra,76(sp)
80006434:	04812403          	lw	s0,72(sp)
80006438:	00098513          	mv	a0,s3
8000643c:	04412483          	lw	s1,68(sp)
80006440:	04012903          	lw	s2,64(sp)
80006444:	03c12983          	lw	s3,60(sp)
80006448:	03812a03          	lw	s4,56(sp)
8000644c:	03412a83          	lw	s5,52(sp)
80006450:	03012b03          	lw	s6,48(sp)
80006454:	02c12b83          	lw	s7,44(sp)
80006458:	02812c03          	lw	s8,40(sp)
8000645c:	02412c83          	lw	s9,36(sp)
80006460:	02012d03          	lw	s10,32(sp)
80006464:	01c12d83          	lw	s11,28(sp)
80006468:	05010113          	addi	sp,sp,80
8000646c:	00008067          	ret
				if (!(dp->fn[NSFLAG] & NS_NOLFN)) {
80006470:	04b44783          	lbu	a5,75(s0)
80006474:	0407f793          	andi	a5,a5,64
80006478:	f2079ee3          	bnez	a5,800063b4 <dir_find+0x9c>
					if (c & LLEF) {		/* Is it start of LFN sequence? */
8000647c:	040cf793          	andi	a5,s9,64
80006480:	10078263          	beqz	a5,80006584 <dir_find+0x26c>
						dp->blk_ofs = dp->dptr;	/* Start offset of LFN */
80006484:	03042783          	lw	a5,48(s0)
						sum = dp->dir[LDIR_Chksum];
80006488:	00dd4b03          	lbu	s6,13(s10)
						c &= (BYTE)~LLEF; ord = c;	/* LFN start order */
8000648c:	0bfcfc93          	andi	s9,s9,191
						dp->blk_ofs = dp->dptr;	/* Start offset of LFN */
80006490:	04f42623          	sw	a5,76(s0)
					ord = (c == ord && sum == dp->dir[LDIR_Chksum] && cmp_lfn(fs->lfnbuf, dp->dir)) ? ord - 1 : 0xFF;
80006494:	00dd4783          	lbu	a5,13(s10)
80006498:	0ff00493          	li	s1,255
8000649c:	f1679ce3          	bne	a5,s6,800063b4 <dir_find+0x9c>
	rv = rv << 8 | ptr[0];
800064a0:	01bd4783          	lbu	a5,27(s10)
800064a4:	01ad4703          	lbu	a4,26(s10)
800064a8:	00879793          	slli	a5,a5,0x8
800064ac:	00e7e7b3          	or	a5,a5,a4
	if (ld_word(dir + LDIR_FstClusLO) != 0) return 0;	/* Check LDIR_FstClusLO */
800064b0:	f00792e3          	bnez	a5,800063b4 <dir_find+0x9c>
	i = ((dir[LDIR_Ord] & 0x3F) - 1) * 13;	/* Offset in the LFN buffer */
800064b4:	000d4783          	lbu	a5,0(s10)
					ord = (c == ord && sum == dp->dir[LDIR_Chksum] && cmp_lfn(fs->lfnbuf, dp->dir)) ? ord - 1 : 0xFF;
800064b8:	00c92703          	lw	a4,12(s2)
800064bc:	001a0693          	addi	a3,s4,1
	i = ((dir[LDIR_Ord] & 0x3F) - 1) * 13;	/* Offset in the LFN buffer */
800064c0:	03f7f793          	andi	a5,a5,63
					ord = (c == ord && sum == dp->dir[LDIR_Chksum] && cmp_lfn(fs->lfnbuf, dp->dir)) ? ord - 1 : 0xFF;
800064c4:	00e12623          	sw	a4,12(sp)
	i = ((dir[LDIR_Ord] & 0x3F) - 1) * 13;	/* Offset in the LFN buffer */
800064c8:	fff78713          	addi	a4,a5,-1
800064cc:	00171793          	slli	a5,a4,0x1
800064d0:	00e787b3          	add	a5,a5,a4
800064d4:	00279793          	slli	a5,a5,0x2
800064d8:	00e78db3          	add	s11,a5,a4
	for (wc = 1, s = 0; s < 13; s++) {		/* Process all characters in the entry */
800064dc:	00100613          	li	a2,1
	i = ((dir[LDIR_Ord] & 0x3F) - 1) * 13;	/* Offset in the LFN buffer */
800064e0:	00100713          	li	a4,1
		uc = ld_word(dir + LfnOfs[s]);		/* Pick an LFN character */
800064e4:	00ed0733          	add	a4,s10,a4
	rv = rv << 8 | ptr[0];
800064e8:	00174483          	lbu	s1,1(a4)
800064ec:	00074703          	lbu	a4,0(a4)
			if (i >= FF_MAX_LFN + 1 || ff_wtoupper(uc) != ff_wtoupper(lfnbuf[i++])) {	/* Compare it */
800064f0:	001d8593          	addi	a1,s11,1
	rv = rv << 8 | ptr[0];
800064f4:	00849493          	slli	s1,s1,0x8
800064f8:	00e4e4b3          	or	s1,s1,a4
			if (i >= FF_MAX_LFN + 1 || ff_wtoupper(uc) != ff_wtoupper(lfnbuf[i++])) {	/* Compare it */
800064fc:	00b12023          	sw	a1,0(sp)
80006500:	00048513          	mv	a0,s1
		if (wc != 0) {
80006504:	16060663          	beqz	a2,80006670 <dir_find+0x358>
80006508:	00d12223          	sw	a3,4(sp)
			if (i >= FF_MAX_LFN + 1 || ff_wtoupper(uc) != ff_wtoupper(lfnbuf[i++])) {	/* Compare it */
8000650c:	07bc6e63          	bltu	s8,s11,80006588 <dir_find+0x270>
80006510:	6dc040ef          	jal	ra,8000abec <ff_wtoupper>
80006514:	00c12703          	lw	a4,12(sp)
80006518:	001d9793          	slli	a5,s11,0x1
8000651c:	00a12423          	sw	a0,8(sp)
80006520:	00f707b3          	add	a5,a4,a5
80006524:	00012583          	lw	a1,0(sp)
80006528:	0007d503          	lhu	a0,0(a5)
8000652c:	00058d93          	mv	s11,a1
80006530:	6bc040ef          	jal	ra,8000abec <ff_wtoupper>
80006534:	00812703          	lw	a4,8(sp)
80006538:	04a71863          	bne	a4,a0,80006588 <dir_find+0x270>
8000653c:	00412683          	lw	a3,4(sp)
	rv = rv << 8 | ptr[0];
80006540:	00048613          	mv	a2,s1
	for (wc = 1, s = 0; s < 13; s++) {		/* Process all characters in the entry */
80006544:	12db8c63          	beq	s7,a3,8000667c <dir_find+0x364>
80006548:	0006c703          	lbu	a4,0(a3)
8000654c:	00168693          	addi	a3,a3,1
80006550:	f95ff06f          	j	800064e4 <dir_find+0x1cc>
80006554:	00bd0613          	addi	a2,s10,11
				if (ord == 0 && sum == sum_sfn(dp->dir)) break;	/* LFN matched? */
80006558:	000d0713          	mv	a4,s10
		sum = (sum >> 1) + (sum << 7) + *dir++;
8000655c:	00170713          	addi	a4,a4,1
80006560:	fff74683          	lbu	a3,-1(a4)
80006564:	0014d793          	srli	a5,s1,0x1
80006568:	00749493          	slli	s1,s1,0x7
8000656c:	0097e4b3          	or	s1,a5,s1
80006570:	00d484b3          	add	s1,s1,a3
80006574:	0ff4f493          	andi	s1,s1,255
	} while (--n);
80006578:	fec712e3          	bne	a4,a2,8000655c <dir_find+0x244>
				if (ord == 0 && sum == sum_sfn(dp->dir)) break;	/* LFN matched? */
8000657c:	e89b1ae3          	bne	s6,s1,80006410 <dir_find+0xf8>
80006580:	eb1ff06f          	j	80006430 <dir_find+0x118>
					ord = (c == ord && sum == dp->dir[LDIR_Chksum] && cmp_lfn(fs->lfnbuf, dp->dir)) ? ord - 1 : 0xFF;
80006584:	f19488e3          	beq	s1,s9,80006494 <dir_find+0x17c>
80006588:	0ff00493          	li	s1,255
		res = dir_next(dp, 0);	/* Next entry */
8000658c:	00000593          	li	a1,0
80006590:	00040513          	mv	a0,s0
80006594:	c04ff0ef          	jal	ra,80005998 <dir_next>
	} while (res == FR_OK);
80006598:	e20506e3          	beqz	a0,800063c4 <dir_find+0xac>
8000659c:	00050993          	mv	s3,a0
800065a0:	e91ff06f          	j	80006430 <dir_find+0x118>
		if (c == 0) { res = FR_NO_FILE; break; }	/* Reached to end of table */
800065a4:	00400993          	li	s3,4
800065a8:	e89ff06f          	j	80006430 <dir_find+0x118>
		WORD hash = xname_sum(fs->lfnbuf);		/* Hash value of the name to find */
800065ac:	00c92503          	lw	a0,12(s2)
800065b0:	dccfd0ef          	jal	ra,80003b7c <xname_sum>
800065b4:	00050b13          	mv	s6,a0
		while ((res = DIR_READ_FILE(dp)) == FR_OK) {	/* Read an item */
800065b8:	00040513          	mv	a0,s0
800065bc:	ae9ff0ef          	jal	ra,800060a4 <dir_read.constprop.12>
800065c0:	00050a13          	mv	s4,a0
800065c4:	0a051263          	bnez	a0,80006668 <dir_find+0x350>
			if (ld_word(fs->dirbuf + XDIR_NameHash) != hash) continue;	/* Skip comparison if hash mismatched */
800065c8:	01092783          	lw	a5,16(s2)
	rv = rv << 8 | ptr[0];
800065cc:	0257c703          	lbu	a4,37(a5)
800065d0:	0247c683          	lbu	a3,36(a5)
800065d4:	00871713          	slli	a4,a4,0x8
			if (ld_word(fs->dirbuf + XDIR_NameHash) != hash) continue;	/* Skip comparison if hash mismatched */
800065d8:	00d76733          	or	a4,a4,a3
800065dc:	fceb1ee3          	bne	s6,a4,800065b8 <dir_find+0x2a0>
			for (nc = fs->dirbuf[XDIR_NumName], di = SZDIRE * 2, ni = 0; nc; nc--, di += 2, ni++) {	/* Compare the name */
800065e0:	0237ca83          	lbu	s5,35(a5)
800065e4:	060a8863          	beqz	s5,80006654 <dir_find+0x33c>
800065e8:	fffa8a93          	addi	s5,s5,-1
800065ec:	0ffafa93          	andi	s5,s5,255
800065f0:	001a8b93          	addi	s7,s5,1
800065f4:	04000493          	li	s1,64
800065f8:	00c0006f          	j	80006604 <dir_find+0x2ec>
800065fc:	01092783          	lw	a5,16(s2)
80006600:	00070a13          	mv	s4,a4
				if ((di % SZDIRE) == 0) di += 2;
80006604:	01f4f713          	andi	a4,s1,31
80006608:	00071463          	bnez	a4,80006610 <dir_find+0x2f8>
8000660c:	00248493          	addi	s1,s1,2
				if (ff_wtoupper(ld_word(fs->dirbuf + di)) != ff_wtoupper(fs->lfnbuf[ni])) break;
80006610:	009787b3          	add	a5,a5,s1
	rv = rv << 8 | ptr[0];
80006614:	0017c703          	lbu	a4,1(a5)
80006618:	0007c503          	lbu	a0,0(a5)
			for (nc = fs->dirbuf[XDIR_NumName], di = SZDIRE * 2, ni = 0; nc; nc--, di += 2, ni++) {	/* Compare the name */
8000661c:	00248493          	addi	s1,s1,2
	rv = rv << 8 | ptr[0];
80006620:	00871713          	slli	a4,a4,0x8
				if (ff_wtoupper(ld_word(fs->dirbuf + di)) != ff_wtoupper(fs->lfnbuf[ni])) break;
80006624:	00a76533          	or	a0,a4,a0
80006628:	5c4040ef          	jal	ra,8000abec <ff_wtoupper>
8000662c:	00c92783          	lw	a5,12(s2)
80006630:	001a1713          	slli	a4,s4,0x1
80006634:	00050c13          	mv	s8,a0
80006638:	00e787b3          	add	a5,a5,a4
8000663c:	0007d503          	lhu	a0,0(a5)
80006640:	5ac040ef          	jal	ra,8000abec <ff_wtoupper>
80006644:	f6ac1ae3          	bne	s8,a0,800065b8 <dir_find+0x2a0>
			for (nc = fs->dirbuf[XDIR_NumName], di = SZDIRE * 2, ni = 0; nc; nc--, di += 2, ni++) {	/* Compare the name */
80006648:	001a0713          	addi	a4,s4,1
8000664c:	fb5a18e3          	bne	s4,s5,800065fc <dir_find+0x2e4>
80006650:	001b9a13          	slli	s4,s7,0x1
			if (nc == 0 && !fs->lfnbuf[ni]) break;	/* Name matched? */
80006654:	00c92783          	lw	a5,12(s2)
80006658:	01478a33          	add	s4,a5,s4
8000665c:	000a5783          	lhu	a5,0(s4)
80006660:	f4079ce3          	bnez	a5,800065b8 <dir_find+0x2a0>
80006664:	dcdff06f          	j	80006430 <dir_find+0x118>
80006668:	00050993          	mv	s3,a0
8000666c:	dc5ff06f          	j	80006430 <dir_find+0x118>
			if (uc != 0xFFFF) return 0;		/* Check filler */
80006670:	ed548ae3          	beq	s1,s5,80006544 <dir_find+0x22c>
					ord = (c == ord && sum == dp->dir[LDIR_Chksum] && cmp_lfn(fs->lfnbuf, dp->dir)) ? ord - 1 : 0xFF;
80006674:	0ff00493          	li	s1,255
80006678:	f15ff06f          	j	8000658c <dir_find+0x274>
	if ((dir[LDIR_Ord] & LLEF) && wc && lfnbuf[i]) return 0;	/* Last segment matched but different length */
8000667c:	000d4703          	lbu	a4,0(s10)
80006680:	04077713          	andi	a4,a4,64
80006684:	02070063          	beqz	a4,800066a4 <dir_find+0x38c>
80006688:	00060e63          	beqz	a2,800066a4 <dir_find+0x38c>
8000668c:	00c12703          	lw	a4,12(sp)
80006690:	001d9793          	slli	a5,s11,0x1
					ord = (c == ord && sum == dp->dir[LDIR_Chksum] && cmp_lfn(fs->lfnbuf, dp->dir)) ? ord - 1 : 0xFF;
80006694:	0ff00493          	li	s1,255
	if ((dir[LDIR_Ord] & LLEF) && wc && lfnbuf[i]) return 0;	/* Last segment matched but different length */
80006698:	00f707b3          	add	a5,a4,a5
8000669c:	0007d783          	lhu	a5,0(a5)
800066a0:	d0079ae3          	bnez	a5,800063b4 <dir_find+0x9c>
					ord = (c == ord && sum == dp->dir[LDIR_Chksum] && cmp_lfn(fs->lfnbuf, dp->dir)) ? ord - 1 : 0xFF;
800066a4:	fffc8493          	addi	s1,s9,-1
800066a8:	0ff4f493          	andi	s1,s1,255
800066ac:	d09ff06f          	j	800063b4 <dir_find+0x9c>

800066b0 <follow_path>:
	FATFS *fs = dp->obj.fs;
800066b0:	00052783          	lw	a5,0(a0)
{
800066b4:	fb010113          	addi	sp,sp,-80
800066b8:	04812423          	sw	s0,72(sp)
800066bc:	01b12e23          	sw	s11,28(sp)
800066c0:	04112623          	sw	ra,76(sp)
800066c4:	04912223          	sw	s1,68(sp)
800066c8:	05212023          	sw	s2,64(sp)
800066cc:	03312e23          	sw	s3,60(sp)
800066d0:	03412c23          	sw	s4,56(sp)
800066d4:	03512a23          	sw	s5,52(sp)
800066d8:	03612823          	sw	s6,48(sp)
800066dc:	03712623          	sw	s7,44(sp)
800066e0:	03812423          	sw	s8,40(sp)
800066e4:	03912223          	sw	s9,36(sp)
800066e8:	03a12023          	sw	s10,32(sp)
800066ec:	00050413          	mv	s0,a0
800066f0:	00058d93          	mv	s11,a1
	FATFS *fs = dp->obj.fs;
800066f4:	00f12023          	sw	a5,0(sp)
		while (IsSeparator(*path)) path++;	/* Strip separators */
800066f8:	02f00693          	li	a3,47
800066fc:	05c00613          	li	a2,92
80006700:	000dc783          	lbu	a5,0(s11)
80006704:	00d78463          	beq	a5,a3,8000670c <follow_path+0x5c>
80006708:	00c79663          	bne	a5,a2,80006714 <follow_path+0x64>
8000670c:	001d8d93          	addi	s11,s11,1
80006710:	ff1ff06f          	j	80006700 <follow_path+0x50>
		dp->obj.sclust = 0;					/* Start from the root directory */
80006714:	00042423          	sw	zero,8(s0)
	dp->obj.n_frag = 0;	/* Invalidate last fragment counter of the object */
80006718:	00042e23          	sw	zero,28(s0)
	if ((UINT)*path < ' ') {				/* Null path name is the origin directory itself */
8000671c:	000dc503          	lbu	a0,0(s11)
80006720:	01f00693          	li	a3,31
	FATFS *fs = dp->obj.fs;
80006724:	00012783          	lw	a5,0(sp)
	if ((UINT)*path < ' ') {				/* Null path name is the origin directory itself */
80006728:	46a6fa63          	bgeu	a3,a0,80006b9c <follow_path+0x4ec>
	memset(dp->fn, ' ', 11);
8000672c:	04040713          	addi	a4,s0,64
			if (wc & 0x80) wc = ExCvt[wc & 0x7F];	/* Convert extended character to upper (SBCS) */
80006730:	8000e6b7          	lui	a3,0x8000e
	memset(dp->fn, ' ', 11);
80006734:	00e12223          	sw	a4,4(sp)
			if (wc & 0x80) wc = ExCvt[wc & 0x7F];	/* Convert extended character to upper (SBCS) */
80006738:	4b468713          	addi	a4,a3,1204 # 8000e4b4 <STACK_TOP+0xfffee4b4>
		if (wc < 0x80 && strchr("*:<>|\"\?\x7F", (int)wc)) return FR_INVALID_NAME;	/* Reject illegal characters for LFN */
8000673c:	8000ec37          	lui	s8,0x8000e
			if (wc & 0x80) wc = ExCvt[wc & 0x7F];	/* Convert extended character to upper (SBCS) */
80006740:	00e12623          	sw	a4,12(sp)
	p = *path; lfn = dp->obj.fs->lfnbuf; di = 0;
80006744:	00c7a903          	lw	s2,12(a5)
80006748:	00000d13          	li	s10,0
		if (wc < ' ' || IsSeparator(wc)) break;	/* Break if end of the path or a separator is found */
8000674c:	01f00b93          	li	s7,31
80006750:	00090493          	mv	s1,s2
80006754:	02f00b13          	li	s6,47
80006758:	05c00a93          	li	s5,92
		if (wc < 0x80 && strchr("*:<>|\"\?\x7F", (int)wc)) return FR_INVALID_NAME;	/* Reject illegal characters for LFN */
8000675c:	07f00a13          	li	s4,127
		if (di >= FF_MAX_LFN) return FR_INVALID_NAME;	/* Reject too long name */
80006760:	0ff00993          	li	s3,255
	wc = (BYTE)*p++;			/* Get a byte */
80006764:	01051513          	slli	a0,a0,0x10
80006768:	01055513          	srli	a0,a0,0x10
8000676c:	001d8d93          	addi	s11,s11,1
	if (wc != 0) {
80006770:	06051c63          	bnez	a0,800067e8 <follow_path+0x138>
		cf = NS_LAST;			/* Last segment */
80006774:	00400493          	li	s1,4
	while (di) {					/* Snip off trailing spaces and dots if exist */
80006778:	020d0663          	beqz	s10,800067a4 <follow_path+0xf4>
8000677c:	001d1693          	slli	a3,s10,0x1
80006780:	00d906b3          	add	a3,s2,a3
		if (wc != ' ' && wc != '.') break;
80006784:	02000513          	li	a0,32
80006788:	02e00593          	li	a1,46
		wc = lfn[di - 1];
8000678c:	ffe6d603          	lhu	a2,-2(a3)
		if (wc != ' ' && wc != '.') break;
80006790:	ffe68693          	addi	a3,a3,-2
80006794:	00a60463          	beq	a2,a0,8000679c <follow_path+0xec>
80006798:	0cb61263          	bne	a2,a1,8000685c <follow_path+0x1ac>
		di--;
8000679c:	fffd0d13          	addi	s10,s10,-1
	while (di) {					/* Snip off trailing spaces and dots if exist */
800067a0:	fe0d16e3          	bnez	s10,8000678c <follow_path+0xdc>
	lfn[di] = 0;							/* LFN is created into the working buffer */
800067a4:	00091023          	sh	zero,0(s2)
	if (di == 0) return FR_INVALID_NAME;	/* Reject null name */
800067a8:	00600513          	li	a0,6
}
800067ac:	04c12083          	lw	ra,76(sp)
800067b0:	04812403          	lw	s0,72(sp)
800067b4:	04412483          	lw	s1,68(sp)
800067b8:	04012903          	lw	s2,64(sp)
800067bc:	03c12983          	lw	s3,60(sp)
800067c0:	03812a03          	lw	s4,56(sp)
800067c4:	03412a83          	lw	s5,52(sp)
800067c8:	03012b03          	lw	s6,48(sp)
800067cc:	02c12b83          	lw	s7,44(sp)
800067d0:	02812c03          	lw	s8,40(sp)
800067d4:	02412c83          	lw	s9,36(sp)
800067d8:	02012d03          	lw	s10,32(sp)
800067dc:	01c12d83          	lw	s11,28(sp)
800067e0:	05010113          	addi	sp,sp,80
800067e4:	00008067          	ret
		wc = ff_oem2uni(wc, CODEPAGE);	/* ANSI/OEM ==> Unicode */
800067e8:	1b500593          	li	a1,437
800067ec:	3c8040ef          	jal	ra,8000abb4 <ff_oem2uni>
800067f0:	00050c93          	mv	s9,a0
		if (wc == 0) return 0xFFFFFFFF;	/* Invalid code? */
800067f4:	fa050ae3          	beqz	a0,800067a8 <follow_path+0xf8>
		if (wc < ' ' || IsSeparator(wc)) break;	/* Break if end of the path or a separator is found */
800067f8:	f6abfee3          	bgeu	s7,a0,80006774 <follow_path+0xc4>
800067fc:	03650c63          	beq	a0,s6,80006834 <follow_path+0x184>
80006800:	03550a63          	beq	a0,s5,80006834 <follow_path+0x184>
		if (wc < 0x80 && strchr("*:<>|\"\?\x7F", (int)wc)) return FR_INVALID_NAME;	/* Reject illegal characters for LFN */
80006804:	00aa7e63          	bgeu	s4,a0,80006820 <follow_path+0x170>
		if (di >= FF_MAX_LFN) return FR_INVALID_NAME;	/* Reject too long name */
80006808:	fb3d00e3          	beq	s10,s3,800067a8 <follow_path+0xf8>
		lfn[di++] = wc;				/* Store the Unicode character */
8000680c:	01949023          	sh	s9,0(s1)
80006810:	001d0d13          	addi	s10,s10,1
80006814:	000dc503          	lbu	a0,0(s11)
80006818:	00248493          	addi	s1,s1,2
8000681c:	f49ff06f          	j	80006764 <follow_path+0xb4>
		if (wc < 0x80 && strchr("*:<>|\"\?\x7F", (int)wc)) return FR_INVALID_NAME;	/* Reject illegal characters for LFN */
80006820:	00050593          	mv	a1,a0
80006824:	3b0c0513          	addi	a0,s8,944 # 8000e3b0 <STACK_TOP+0xfffee3b0>
80006828:	9d0fc0ef          	jal	ra,800029f8 <strchr>
8000682c:	fc050ee3          	beqz	a0,80006808 <follow_path+0x158>
80006830:	f79ff06f          	j	800067a8 <follow_path+0xf8>
		while (IsSeparator(*p)) p++;	/* Skip duplicated separators if exist */
80006834:	02f00613          	li	a2,47
80006838:	05c00693          	li	a3,92
8000683c:	000dc483          	lbu	s1,0(s11)
80006840:	00c48463          	beq	s1,a2,80006848 <follow_path+0x198>
80006844:	00d49663          	bne	s1,a3,80006850 <follow_path+0x1a0>
80006848:	001d8d93          	addi	s11,s11,1
8000684c:	ff1ff06f          	j	8000683c <follow_path+0x18c>
		if (IsTerminator(*p)) cf = NS_LAST;	/* Ignore terminating separator */
80006850:	0204b493          	sltiu	s1,s1,32
80006854:	00249493          	slli	s1,s1,0x2
80006858:	f21ff06f          	j	80006778 <follow_path+0xc8>
	lfn[di] = 0;							/* LFN is created into the working buffer */
8000685c:	001d1693          	slli	a3,s10,0x1
80006860:	00d906b3          	add	a3,s2,a3
80006864:	00069023          	sh	zero,0(a3)
	for (si = 0; lfn[si] == ' '; si++) ;	/* Remove leading spaces */
80006868:	00095883          	lhu	a7,0(s2)
8000686c:	00290613          	addi	a2,s2,2
80006870:	00000993          	li	s3,0
80006874:	02000813          	li	a6,32
80006878:	22a89463          	bne	a7,a0,80006aa0 <follow_path+0x3f0>
8000687c:	00260613          	addi	a2,a2,2
80006880:	ffe65583          	lhu	a1,-2(a2)
80006884:	00198993          	addi	s3,s3,1
80006888:	ff058ae3          	beq	a1,a6,8000687c <follow_path+0x1cc>
	if (si > 0 || lfn[si] == '.') cf |= NS_LOSS | NS_LFN;	/* Is there any leading space or dot? */
8000688c:	0034e493          	ori	s1,s1,3
80006890:	0ff4f493          	andi	s1,s1,255
	while (di > 0 && lfn[di - 1] != '.') di--;	/* Find last dot (di<=si: no extension) */
80006894:	02e00593          	li	a1,46
80006898:	ffe6d603          	lhu	a2,-2(a3)
8000689c:	ffe68693          	addi	a3,a3,-2
800068a0:	00b60663          	beq	a2,a1,800068ac <follow_path+0x1fc>
800068a4:	fffd0d13          	addi	s10,s10,-1
800068a8:	fe0d18e3          	bnez	s10,80006898 <follow_path+0x1e8>
	memset(dp->fn, ' ', 11);
800068ac:	00412503          	lw	a0,4(sp)
800068b0:	00b00613          	li	a2,11
800068b4:	02000593          	li	a1,32
800068b8:	e69fb0ef          	jal	ra,80002720 <memset>
	i = b = 0; ni = 8;
800068bc:	00800b93          	li	s7,8
800068c0:	00000b13          	li	s6,0
800068c4:	00000a93          	li	s5,0
		if (wc == ' ' || (wc == '.' && si != di)) {	/* Remove embedded spaces and dots */
800068c8:	02000613          	li	a2,32
800068cc:	02e00813          	li	a6,46
			if (ni == 11) {				/* Name extension overflow? */
800068d0:	00b00893          	li	a7,11
		if (wc >= 0x80) {	/* Is this an extended character? */
800068d4:	07f00313          	li	t1,127
		wc = lfn[si++];					/* Get an LFN character */
800068d8:	00199693          	slli	a3,s3,0x1
800068dc:	00d906b3          	add	a3,s2,a3
800068e0:	0006da03          	lhu	s4,0(a3)
800068e4:	00198993          	addi	s3,s3,1
		if (wc == 0) break;				/* Break on end of the LFN */
800068e8:	060a0263          	beqz	s4,8000694c <follow_path+0x29c>
		if (wc == ' ' || (wc == '.' && si != di)) {	/* Remove embedded spaces and dots */
800068ec:	04ca0263          	beq	s4,a2,80006930 <follow_path+0x280>
800068f0:	030a0e63          	beq	s4,a6,8000692c <follow_path+0x27c>
		if (i >= ni || si == di) {		/* End of field? */
800068f4:	177b7063          	bgeu	s6,s7,80006a54 <follow_path+0x3a4>
800068f8:	153d0063          	beq	s10,s3,80006a38 <follow_path+0x388>
		if (wc >= 0x80) {	/* Is this an extended character? */
800068fc:	21436663          	bltu	t1,s4,80006b08 <follow_path+0x458>
			if (wc == 0 || strchr("+,;=[]", (int)wc)) {	/* Replace illegal characters for SFN */
80006900:	8000e7b7          	lui	a5,0x8000e
80006904:	000a0593          	mv	a1,s4
80006908:	3bc78513          	addi	a0,a5,956 # 8000e3bc <STACK_TOP+0xfffee3bc>
8000690c:	8ecfc0ef          	jal	ra,800029f8 <strchr>
80006910:	02000613          	li	a2,32
80006914:	02e00813          	li	a6,46
80006918:	00b00893          	li	a7,11
8000691c:	07f00313          	li	t1,127
80006920:	2c050c63          	beqz	a0,80006bf8 <follow_path+0x548>
80006924:	00048693          	mv	a3,s1
80006928:	22c0006f          	j	80006b54 <follow_path+0x4a4>
		if (wc == ' ' || (wc == '.' && si != di)) {	/* Remove embedded spaces and dots */
8000692c:	113d0663          	beq	s10,s3,80006a38 <follow_path+0x388>
		wc = lfn[si++];					/* Get an LFN character */
80006930:	00199693          	slli	a3,s3,0x1
80006934:	00d906b3          	add	a3,s2,a3
80006938:	0006da03          	lhu	s4,0(a3)
			cf |= NS_LOSS | NS_LFN;
8000693c:	0034e493          	ori	s1,s1,3
80006940:	0ff4f493          	andi	s1,s1,255
		wc = lfn[si++];					/* Get an LFN character */
80006944:	00198993          	addi	s3,s3,1
		if (wc == 0) break;				/* Break on end of the LFN */
80006948:	fa0a12e3          	bnez	s4,800068ec <follow_path+0x23c>
	if (dp->fn[0] == DDEM) dp->fn[0] = RDDEM;	/* If the first character collides with DDEM, replace it with RDDEM */
8000694c:	04044683          	lbu	a3,64(s0)
80006950:	0e500793          	li	a5,229
80006954:	00f69663          	bne	a3,a5,80006960 <follow_path+0x2b0>
80006958:	00500793          	li	a5,5
8000695c:	04f40023          	sb	a5,64(s0)
	if (ni == 8) b <<= 2;				/* Shift capital flags if no extension */
80006960:	00800793          	li	a5,8
80006964:	18fb8263          	beq	s7,a5,80006ae8 <follow_path+0x438>
	if ((b & 0x0C) == 0x0C || (b & 0x03) == 0x03) cf |= NS_LFN;	/* LFN entry needs to be created if composite capitals */
80006968:	00caf793          	andi	a5,s5,12
8000696c:	00c00693          	li	a3,12
80006970:	0ed78e63          	beq	a5,a3,80006a6c <follow_path+0x3bc>
80006974:	003af793          	andi	a5,s5,3
80006978:	00300693          	li	a3,3
8000697c:	0ed78863          	beq	a5,a3,80006a6c <follow_path+0x3bc>
	if (!(cf & NS_LFN)) {				/* When LFN is in 8.3 format without extended character, NT flags are created */
80006980:	0024f793          	andi	a5,s1,2
80006984:	02079263          	bnez	a5,800069a8 <follow_path+0x2f8>
		if (b & 0x01) cf |= NS_EXT;		/* NT flag (Extension has small capital letters only) */
80006988:	001af793          	andi	a5,s5,1
8000698c:	00078663          	beqz	a5,80006998 <follow_path+0x2e8>
80006990:	0104e493          	ori	s1,s1,16
80006994:	0ff4f493          	andi	s1,s1,255
		if (b & 0x04) cf |= NS_BODY;	/* NT flag (Body has small capital letters only) */
80006998:	004afa93          	andi	s5,s5,4
8000699c:	000a8663          	beqz	s5,800069a8 <follow_path+0x2f8>
800069a0:	0084e493          	ori	s1,s1,8
800069a4:	0ff4f493          	andi	s1,s1,255
	dp->fn[NSFLAG] = cf;	/* SFN is created into dp->fn[] */
800069a8:	049405a3          	sb	s1,75(s0)
			res = dir_find(dp);				/* Find an object with the segment name */
800069ac:	00040513          	mv	a0,s0
800069b0:	969ff0ef          	jal	ra,80006318 <dir_find>
			ns = dp->fn[NSFLAG];
800069b4:	04b44783          	lbu	a5,75(s0)
			if (res != FR_OK) {				/* Failed to find the object */
800069b8:	0c051863          	bnez	a0,80006a88 <follow_path+0x3d8>
			if (ns & NS_LAST) break;		/* Last segment matched. Function completed. */
800069bc:	0047f793          	andi	a5,a5,4
800069c0:	de0796e3          	bnez	a5,800067ac <follow_path+0xfc>
			if (!(dp->obj.attr & AM_DIR)) {	/* It is not a sub-directory and cannot follow */
800069c4:	00644783          	lbu	a5,6(s0)
800069c8:	0107f793          	andi	a5,a5,16
800069cc:	0c078663          	beqz	a5,80006a98 <follow_path+0x3e8>
			if (fs->fs_type == FS_EXFAT) {	/* Save containing directory information for next dir */
800069d0:	00012783          	lw	a5,0(sp)
800069d4:	0007c603          	lbu	a2,0(a5)
800069d8:	00400793          	li	a5,4
800069dc:	0cf60a63          	beq	a2,a5,80006ab0 <follow_path+0x400>
				dp->obj.sclust = ld_clust(fs, fs->win + dp->dptr % SS(fs));	/* Open next directory */
800069e0:	03042683          	lw	a3,48(s0)
800069e4:	00012783          	lw	a5,0(sp)
	if (fs->fs_type == FS_FAT32) {
800069e8:	00300593          	li	a1,3
				dp->obj.sclust = ld_clust(fs, fs->win + dp->dptr % SS(fs));	/* Open next directory */
800069ec:	1ff6f693          	andi	a3,a3,511
800069f0:	03c78793          	addi	a5,a5,60
800069f4:	00d787b3          	add	a5,a5,a3
	rv = rv << 8 | ptr[0];
800069f8:	01b7c683          	lbu	a3,27(a5)
800069fc:	01a7c503          	lbu	a0,26(a5)
80006a00:	00869693          	slli	a3,a3,0x8
	cl = ld_word(dir + DIR_FstClusLO);
80006a04:	00a6e6b3          	or	a3,a3,a0
	if (fs->fs_type == FS_FAT32) {
80006a08:	00b60a63          	beq	a2,a1,80006a1c <follow_path+0x36c>
				dp->obj.sclust = ld_clust(fs, fs->win + dp->dptr % SS(fs));	/* Open next directory */
80006a0c:	00d42423          	sw	a3,8(s0)
80006a10:	00042783          	lw	a5,0(s0)
80006a14:	000dc503          	lbu	a0,0(s11)
80006a18:	d2dff06f          	j	80006744 <follow_path+0x94>
	rv = rv << 8 | ptr[0];
80006a1c:	0157c603          	lbu	a2,21(a5)
80006a20:	0147c583          	lbu	a1,20(a5)
80006a24:	00861793          	slli	a5,a2,0x8
		cl |= (DWORD)ld_word(dir + DIR_FstClusHI) << 16;
80006a28:	00b7e7b3          	or	a5,a5,a1
80006a2c:	01079793          	slli	a5,a5,0x10
80006a30:	00f6e6b3          	or	a3,a3,a5
80006a34:	fd9ff06f          	j	80006a0c <follow_path+0x35c>
			if (ni == 11) {				/* Name extension overflow? */
80006a38:	1f1b8a63          	beq	s7,a7,80006c2c <follow_path+0x57c>
			si = di; i = 8; ni = 11; b <<= 2;		/* Enter name extension */
80006a3c:	002a9a93          	slli	s5,s5,0x2
80006a40:	0ffafa93          	andi	s5,s5,255
80006a44:	000d0993          	mv	s3,s10
80006a48:	00b00b93          	li	s7,11
80006a4c:	00800b13          	li	s6,8
80006a50:	e89ff06f          	j	800068d8 <follow_path+0x228>
			if (ni == 11) {				/* Name extension overflow? */
80006a54:	1d1b8c63          	beq	s7,a7,80006c2c <follow_path+0x57c>
			if (si != di) cf |= NS_LOSS | NS_LFN;	/* Name body overflow? */
80006a58:	ff3d02e3          	beq	s10,s3,80006a3c <follow_path+0x38c>
80006a5c:	0034e493          	ori	s1,s1,3
80006a60:	0ff4f493          	andi	s1,s1,255
			if (si > di) break;						/* No name extension? */
80006a64:	ef3d64e3          	bltu	s10,s3,8000694c <follow_path+0x29c>
80006a68:	fd5ff06f          	j	80006a3c <follow_path+0x38c>
	if ((b & 0x0C) == 0x0C || (b & 0x03) == 0x03) cf |= NS_LFN;	/* LFN entry needs to be created if composite capitals */
80006a6c:	0024e493          	ori	s1,s1,2
80006a70:	0ff4f493          	andi	s1,s1,255
	dp->fn[NSFLAG] = cf;	/* SFN is created into dp->fn[] */
80006a74:	049405a3          	sb	s1,75(s0)
			res = dir_find(dp);				/* Find an object with the segment name */
80006a78:	00040513          	mv	a0,s0
80006a7c:	89dff0ef          	jal	ra,80006318 <dir_find>
			ns = dp->fn[NSFLAG];
80006a80:	04b44783          	lbu	a5,75(s0)
			if (res != FR_OK) {				/* Failed to find the object */
80006a84:	f2050ce3          	beqz	a0,800069bc <follow_path+0x30c>
				if (res == FR_NO_FILE) {	/* Object is not found */
80006a88:	00400713          	li	a4,4
80006a8c:	d2e510e3          	bne	a0,a4,800067ac <follow_path+0xfc>
						if (!(ns & NS_LAST)) res = FR_NO_PATH;	/* Adjust error code if not last segment */
80006a90:	0047f793          	andi	a5,a5,4
80006a94:	d0079ce3          	bnez	a5,800067ac <follow_path+0xfc>
80006a98:	00500513          	li	a0,5
	return res;
80006a9c:	d11ff06f          	j	800067ac <follow_path+0xfc>
	if (si > 0 || lfn[si] == '.') cf |= NS_LOSS | NS_LFN;	/* Is there any leading space or dot? */
80006aa0:	deb89ae3          	bne	a7,a1,80006894 <follow_path+0x1e4>
80006aa4:	0034e493          	ori	s1,s1,3
80006aa8:	0ff4f493          	andi	s1,s1,255
80006aac:	de9ff06f          	j	80006894 <follow_path+0x1e4>
				dp->obj.c_size = ((DWORD)dp->obj.objsize & 0xFFFFFF00) | dp->obj.stat;
80006ab0:	01042783          	lw	a5,16(s0)
				init_alloc_info(fs, &dp->obj);	/* Open next directory */
80006ab4:	00012703          	lw	a4,0(sp)
				dp->obj.c_size = ((DWORD)dp->obj.objsize & 0xFFFFFF00) | dp->obj.stat;
80006ab8:	00744583          	lbu	a1,7(s0)
				dp->obj.c_scl = dp->obj.sclust;
80006abc:	00842603          	lw	a2,8(s0)
				dp->obj.c_ofs = dp->blk_ofs;
80006ac0:	04c42683          	lw	a3,76(s0)
				init_alloc_info(fs, &dp->obj);	/* Open next directory */
80006ac4:	01072503          	lw	a0,16(a4)
				dp->obj.c_size = ((DWORD)dp->obj.objsize & 0xFFFFFF00) | dp->obj.stat;
80006ac8:	f007f793          	andi	a5,a5,-256
80006acc:	00b7e7b3          	or	a5,a5,a1
				dp->obj.c_scl = dp->obj.sclust;
80006ad0:	02c42023          	sw	a2,32(s0)
				dp->obj.c_size = ((DWORD)dp->obj.objsize & 0xFFFFFF00) | dp->obj.stat;
80006ad4:	02f42223          	sw	a5,36(s0)
				dp->obj.c_ofs = dp->blk_ofs;
80006ad8:	02d42423          	sw	a3,40(s0)
				init_alloc_info(fs, &dp->obj);	/* Open next directory */
80006adc:	00040593          	mv	a1,s0
80006ae0:	944fd0ef          	jal	ra,80003c24 <init_alloc_info.isra.4>
80006ae4:	f2dff06f          	j	80006a10 <follow_path+0x360>
	if (ni == 8) b <<= 2;				/* Shift capital flags if no extension */
80006ae8:	002a9a93          	slli	s5,s5,0x2
80006aec:	0ffafa93          	andi	s5,s5,255
	if ((b & 0x0C) == 0x0C || (b & 0x03) == 0x03) cf |= NS_LFN;	/* LFN entry needs to be created if composite capitals */
80006af0:	00caf693          	andi	a3,s5,12
80006af4:	00c00793          	li	a5,12
80006af8:	f6f68ae3          	beq	a3,a5,80006a6c <follow_path+0x3bc>
	if (!(cf & NS_LFN)) {				/* When LFN is in 8.3 format without extended character, NT flags are created */
80006afc:	0024f793          	andi	a5,s1,2
80006b00:	e8078ce3          	beqz	a5,80006998 <follow_path+0x2e8>
80006b04:	ea5ff06f          	j	800069a8 <follow_path+0x2f8>
			cf |= NS_LFN;	/* LFN entry needs to be created */
80006b08:	0024e693          	ori	a3,s1,2
80006b0c:	0ff6f693          	andi	a3,a3,255
			wc = ff_uni2oem(wc, CODEPAGE);			/* Unicode ==> ANSI/OEM code */
80006b10:	1b500593          	li	a1,437
80006b14:	000a0513          	mv	a0,s4
			cf |= NS_LFN;	/* LFN entry needs to be created */
80006b18:	00d12423          	sw	a3,8(sp)
			wc = ff_uni2oem(wc, CODEPAGE);			/* Unicode ==> ANSI/OEM code */
80006b1c:	024040ef          	jal	ra,8000ab40 <ff_uni2oem>
			if (wc & 0x80) wc = ExCvt[wc & 0x7F];	/* Convert extended character to upper (SBCS) */
80006b20:	08057593          	andi	a1,a0,128
			wc = ff_uni2oem(wc, CODEPAGE);			/* Unicode ==> ANSI/OEM code */
80006b24:	00050a13          	mv	s4,a0
			if (wc & 0x80) wc = ExCvt[wc & 0x7F];	/* Convert extended character to upper (SBCS) */
80006b28:	00812683          	lw	a3,8(sp)
80006b2c:	02000613          	li	a2,32
80006b30:	02e00813          	li	a6,46
80006b34:	00b00893          	li	a7,11
80006b38:	07f00313          	li	t1,127
80006b3c:	02058a63          	beqz	a1,80006b70 <follow_path+0x4c0>
80006b40:	00c12783          	lw	a5,12(sp)
80006b44:	07f57a13          	andi	s4,a0,127
80006b48:	01478a33          	add	s4,a5,s4
80006b4c:	010a4a03          	lbu	s4,16(s4)
			if (wc == 0 || strchr("+,;=[]", (int)wc)) {	/* Replace illegal characters for SFN */
80006b50:	100a1463          	bnez	s4,80006c58 <follow_path+0x5a8>
				wc = '_'; cf |= NS_LOSS | NS_LFN;/* Lossy conversion */
80006b54:	0036e493          	ori	s1,a3,3
80006b58:	0ff4f493          	andi	s1,s1,255
80006b5c:	05f00a13          	li	s4,95
		dp->fn[i++] = (BYTE)wc;
80006b60:	016406b3          	add	a3,s0,s6
80006b64:	05468023          	sb	s4,64(a3)
80006b68:	001b0b13          	addi	s6,s6,1
80006b6c:	d6dff06f          	j	800068d8 <follow_path+0x228>
		if (wc >= 0x100) {				/* Is this a DBC? */
80006b70:	0ff00593          	li	a1,255
80006b74:	fca5fee3          	bgeu	a1,a0,80006b50 <follow_path+0x4a0>
			if (i >= ni - 1) {			/* Field overflow? */
80006b78:	fffb8593          	addi	a1,s7,-1
80006b7c:	06bb7663          	bgeu	s6,a1,80006be8 <follow_path+0x538>
			dp->fn[i++] = (BYTE)(wc >> 8);	/* Put 1st byte */
80006b80:	016405b3          	add	a1,s0,s6
80006b84:	00855513          	srli	a0,a0,0x8
80006b88:	001b0b13          	addi	s6,s6,1
80006b8c:	04a58023          	sb	a0,64(a1)
80006b90:	0ffa7a13          	andi	s4,s4,255
80006b94:	00068493          	mv	s1,a3
80006b98:	fc9ff06f          	j	80006b60 <follow_path+0x4b0>
		dp->fn[NSFLAG] = NS_NONAME;
80006b9c:	f8000793          	li	a5,-128
80006ba0:	04f405a3          	sb	a5,75(s0)
		res = dir_sdi(dp, 0);
80006ba4:	00040513          	mv	a0,s0
}
80006ba8:	04812403          	lw	s0,72(sp)
80006bac:	04c12083          	lw	ra,76(sp)
80006bb0:	04412483          	lw	s1,68(sp)
80006bb4:	04012903          	lw	s2,64(sp)
80006bb8:	03c12983          	lw	s3,60(sp)
80006bbc:	03812a03          	lw	s4,56(sp)
80006bc0:	03412a83          	lw	s5,52(sp)
80006bc4:	03012b03          	lw	s6,48(sp)
80006bc8:	02c12b83          	lw	s7,44(sp)
80006bcc:	02812c03          	lw	s8,40(sp)
80006bd0:	02412c83          	lw	s9,36(sp)
80006bd4:	02012d03          	lw	s10,32(sp)
80006bd8:	01c12d83          	lw	s11,28(sp)
		res = dir_sdi(dp, 0);
80006bdc:	00000593          	li	a1,0
}
80006be0:	05010113          	addi	sp,sp,80
		res = dir_sdi(dp, 0);
80006be4:	9f9fd06f          	j	800045dc <dir_sdi>
				cf |= NS_LOSS | NS_LFN;
80006be8:	0034e493          	ori	s1,s1,3
80006bec:	0ff4f493          	andi	s1,s1,255
80006bf0:	000b8b13          	mv	s6,s7
80006bf4:	ce5ff06f          	j	800068d8 <follow_path+0x228>
				if (IsUpper(wc)) {		/* ASCII upper case? */
80006bf8:	fbfa0693          	addi	a3,s4,-65
80006bfc:	01069693          	slli	a3,a3,0x10
80006c00:	0106d693          	srli	a3,a3,0x10
80006c04:	01900593          	li	a1,25
80006c08:	04d5f263          	bgeu	a1,a3,80006c4c <follow_path+0x59c>
				if (IsLower(wc)) {		/* ASCII lower case? */
80006c0c:	f9fa0693          	addi	a3,s4,-97
80006c10:	01069693          	slli	a3,a3,0x10
80006c14:	0106d693          	srli	a3,a3,0x10
80006c18:	00d5e663          	bltu	a1,a3,80006c24 <follow_path+0x574>
					b |= 1; wc -= 0x20;
80006c1c:	fe0a0a13          	addi	s4,s4,-32
80006c20:	001aea93          	ori	s5,s5,1
80006c24:	0ffa7a13          	andi	s4,s4,255
80006c28:	f39ff06f          	j	80006b60 <follow_path+0x4b0>
	if (dp->fn[0] == DDEM) dp->fn[0] = RDDEM;	/* If the first character collides with DDEM, replace it with RDDEM */
80006c2c:	04044683          	lbu	a3,64(s0)
				cf |= NS_LOSS | NS_LFN;
80006c30:	0034e493          	ori	s1,s1,3
	if (dp->fn[0] == DDEM) dp->fn[0] = RDDEM;	/* If the first character collides with DDEM, replace it with RDDEM */
80006c34:	0e500793          	li	a5,229
				cf |= NS_LOSS | NS_LFN;
80006c38:	0ff4f493          	andi	s1,s1,255
	if (dp->fn[0] == DDEM) dp->fn[0] = RDDEM;	/* If the first character collides with DDEM, replace it with RDDEM */
80006c3c:	d2f696e3          	bne	a3,a5,80006968 <follow_path+0x2b8>
80006c40:	00500793          	li	a5,5
80006c44:	04f40023          	sb	a5,64(s0)
	if (ni == 8) b <<= 2;				/* Shift capital flags if no extension */
80006c48:	d21ff06f          	j	80006968 <follow_path+0x2b8>
					b |= 2;
80006c4c:	002aea93          	ori	s5,s5,2
				if (IsLower(wc)) {		/* ASCII lower case? */
80006c50:	0ffa7a13          	andi	s4,s4,255
80006c54:	f0dff06f          	j	80006b60 <follow_path+0x4b0>
			if (wc == 0 || strchr("+,;=[]", (int)wc)) {	/* Replace illegal characters for SFN */
80006c58:	00068493          	mv	s1,a3
80006c5c:	ca5ff06f          	j	80006900 <follow_path+0x250>

80006c60 <dir_register>:
{
80006c60:	f7010113          	addi	sp,sp,-144
80006c64:	07812423          	sw	s8,104(sp)
80006c68:	08112623          	sw	ra,140(sp)
80006c6c:	08812423          	sw	s0,136(sp)
80006c70:	08912223          	sw	s1,132(sp)
80006c74:	09212023          	sw	s2,128(sp)
80006c78:	07312e23          	sw	s3,124(sp)
80006c7c:	07412c23          	sw	s4,120(sp)
80006c80:	07512a23          	sw	s5,116(sp)
80006c84:	07612823          	sw	s6,112(sp)
80006c88:	07712623          	sw	s7,108(sp)
80006c8c:	07912223          	sw	s9,100(sp)
80006c90:	07a12023          	sw	s10,96(sp)
80006c94:	04b54b03          	lbu	s6,75(a0)
	if (dp->fn[NSFLAG] & (NS_DOT | NS_NONAME)) return FR_INVALID_NAME;	/* Check name validity */
80006c98:	00600c13          	li	s8,6
80006c9c:	0a0b7b13          	andi	s6,s6,160
80006ca0:	1e0b1e63          	bnez	s6,80006e9c <dir_register+0x23c>
	FATFS *fs = dp->obj.fs;
80006ca4:	00052983          	lw	s3,0(a0)
	for (len = 0; fs->lfnbuf[len]; len++) ;	/* Get lfn length */
80006ca8:	00c9a783          	lw	a5,12(s3)
80006cac:	0007d703          	lhu	a4,0(a5)
80006cb0:	56070a63          	beqz	a4,80007224 <dir_register+0x5c4>
80006cb4:	00278793          	addi	a5,a5,2
80006cb8:	00000413          	li	s0,0
80006cbc:	00278793          	addi	a5,a5,2
80006cc0:	ffe7d703          	lhu	a4,-2(a5)
80006cc4:	00140413          	addi	s0,s0,1
80006cc8:	fe071ae3          	bnez	a4,80006cbc <dir_register+0x5c>
	if (fs->fs_type == FS_EXFAT) {	/* On the exFAT volume */
80006ccc:	0009c703          	lbu	a4,0(s3)
80006cd0:	00400793          	li	a5,4
80006cd4:	00050c93          	mv	s9,a0
80006cd8:	22f70e63          	beq	a4,a5,80006f14 <dir_register+0x2b4>
	memcpy(sn, dp->fn, 12);
80006cdc:	04050b93          	addi	s7,a0,64
80006ce0:	00c00613          	li	a2,12
80006ce4:	000b8593          	mv	a1,s7
80006ce8:	01010513          	addi	a0,sp,16
80006cec:	9bdfb0ef          	jal	ra,800026a8 <memcpy>
	if (sn[NSFLAG] & NS_LOSS) {			/* When LFN is out of 8.3 format, generate a numbered name */
80006cf0:	01b14783          	lbu	a5,27(sp)
80006cf4:	0017f713          	andi	a4,a5,1
80006cf8:	12070863          	beqz	a4,80006e28 <dir_register+0x1c8>
		dp->fn[NSFLAG] = NS_NOLFN;		/* Find only SFN */
80006cfc:	04000793          	li	a5,64
80006d00:	04fc85a3          	sb	a5,75(s9)
	memcpy(dst, src, 11);	/* Prepare the SFN to be modified */
80006d04:	00b00613          	li	a2,11
80006d08:	01010593          	addi	a1,sp,16
80006d0c:	000b8513          	mv	a0,s7
80006d10:	999fb0ef          	jal	ra,800026a8 <memcpy>
				if (sreg & 0x10000) sreg ^= 0x11021;
80006d14:	00011937          	lui	s2,0x11
		for (n = 1; n < 100; n++) {
80006d18:	00100d13          	li	s10,1
80006d1c:	00100793          	li	a5,1
80006d20:	008c8a93          	addi	s5,s9,8
		if (c > '9') c += 7;
80006d24:	03900a13          	li	s4,57
	for (j = 0; j < i && dst[j] != ' '; j++) {	/* Find the offset to append */
80006d28:	02000493          	li	s1,32
				if (sreg & 0x10000) sreg ^= 0x11021;
80006d2c:	02190913          	addi	s2,s2,33 # 11021 <crtStart-0x7ffeefdf>
		for (n = 1; n < 100; n++) {
80006d30:	00700713          	li	a4,7
	} while (i && seq);
80006d34:	00f00813          	li	a6,15
80006d38:	00c0006f          	j	80006d44 <dir_register+0xe4>
80006d3c:	18f87e63          	bgeu	a6,a5,80006ed8 <dir_register+0x278>
		c = (BYTE)((seq % 16) + '0'); seq /= 16;
80006d40:	00058793          	mv	a5,a1
		ns[i--] = c;
80006d44:	00810693          	addi	a3,sp,8
80006d48:	fff70713          	addi	a4,a4,-1
		c = (BYTE)((seq % 16) + '0'); seq /= 16;
80006d4c:	00f7f613          	andi	a2,a5,15
		ns[i--] = c;
80006d50:	00e68533          	add	a0,a3,a4
		c = (BYTE)((seq % 16) + '0'); seq /= 16;
80006d54:	03060693          	addi	a3,a2,48
80006d58:	0047d593          	srli	a1,a5,0x4
		if (c > '9') c += 7;
80006d5c:	00da7463          	bgeu	s4,a3,80006d64 <dir_register+0x104>
80006d60:	03760693          	addi	a3,a2,55
		ns[i--] = c;
80006d64:	00d500a3          	sb	a3,1(a0)
	} while (i && seq);
80006d68:	fc071ae3          	bnez	a4,80006d3c <dir_register+0xdc>
	ns[i] = '~';
80006d6c:	07e00793          	li	a5,126
80006d70:	00f10423          	sb	a5,8(sp)
	for (j = 0; j < i && dst[j] != ' '; j++) {	/* Find the offset to append */
80006d74:	000c8793          	mv	a5,s9
		dst[j++] = (i < 8) ? ns[i++] : ' ';
80006d78:	00700593          	li	a1,7
80006d7c:	06010693          	addi	a3,sp,96
80006d80:	00e68633          	add	a2,a3,a4
80006d84:	02000693          	li	a3,32
80006d88:	00e5e663          	bltu	a1,a4,80006d94 <dir_register+0x134>
80006d8c:	fa864683          	lbu	a3,-88(a2)
80006d90:	00170713          	addi	a4,a4,1
80006d94:	00178793          	addi	a5,a5,1
80006d98:	02d78fa3          	sb	a3,63(a5)
	} while (j < 8);
80006d9c:	fefa90e3          	bne	s5,a5,80006d7c <dir_register+0x11c>
			res = dir_find(dp);				/* Check if the name collides with existing SFN */
80006da0:	000c8513          	mv	a0,s9
80006da4:	d74ff0ef          	jal	ra,80006318 <dir_find>
80006da8:	00050c13          	mv	s8,a0
			if (res != FR_OK) break;
80006dac:	06051663          	bnez	a0,80006e18 <dir_register+0x1b8>
		for (n = 1; n < 100; n++) {
80006db0:	001d0d13          	addi	s10,s10,1
80006db4:	06400793          	li	a5,100
80006db8:	5afd0a63          	beq	s10,a5,8000736c <dir_register+0x70c>
	memcpy(dst, src, 11);	/* Prepare the SFN to be modified */
80006dbc:	01010593          	addi	a1,sp,16
80006dc0:	00b00613          	li	a2,11
80006dc4:	000b8513          	mv	a0,s7
			gen_numname(dp->fn, sn, fs->lfnbuf, n);	/* Generate a numbered name */
80006dc8:	00c9ac03          	lw	s8,12(s3)
	memcpy(dst, src, 11);	/* Prepare the SFN to be modified */
80006dcc:	8ddfb0ef          	jal	ra,800026a8 <memcpy>
	if (seq > 5) {	/* In case of many collisions, generate a hash number instead of sequential number */
80006dd0:	00500713          	li	a4,5
80006dd4:	000d0793          	mv	a5,s10
				if (sreg & 0x10000) sreg ^= 0x11021;
80006dd8:	000105b7          	lui	a1,0x10
	if (seq > 5) {	/* In case of many collisions, generate a hash number instead of sequential number */
80006ddc:	f5a77ae3          	bgeu	a4,s10,80006d30 <dir_register+0xd0>
		while (*lfn) {	/* Create a CRC as hash value */
80006de0:	000c5703          	lhu	a4,0(s8)
80006de4:	f40706e3          	beqz	a4,80006d30 <dir_register+0xd0>
			wc = *lfn++;
80006de8:	002c0c13          	addi	s8,s8,2
80006dec:	01000693          	li	a3,16
				sreg = (sreg << 1) + (wc & 1);
80006df0:	00177613          	andi	a2,a4,1
80006df4:	00179793          	slli	a5,a5,0x1
80006df8:	00f607b3          	add	a5,a2,a5
				if (sreg & 0x10000) sreg ^= 0x11021;
80006dfc:	00b7f633          	and	a2,a5,a1
80006e00:	fff68693          	addi	a3,a3,-1
				wc >>= 1;
80006e04:	00175713          	srli	a4,a4,0x1
				if (sreg & 0x10000) sreg ^= 0x11021;
80006e08:	00060463          	beqz	a2,80006e10 <dir_register+0x1b0>
80006e0c:	0127c7b3          	xor	a5,a5,s2
			for (i = 0; i < 16; i++) {
80006e10:	fe0690e3          	bnez	a3,80006df0 <dir_register+0x190>
80006e14:	fcdff06f          	j	80006de0 <dir_register+0x180>
		if (res != FR_NO_FILE) return res;	/* Abort if the result is other than 'not collided' */
80006e18:	00400793          	li	a5,4
80006e1c:	08f51063          	bne	a0,a5,80006e9c <dir_register+0x23c>
		dp->fn[NSFLAG] = sn[NSFLAG];
80006e20:	01b14783          	lbu	a5,27(sp)
80006e24:	04fc85a3          	sb	a5,75(s9)
	n_ent = (sn[NSFLAG] & NS_LFN) ? (len + 12) / 13 + 1 : 1;	/* Number of entries to allocate */
80006e28:	0027f793          	andi	a5,a5,2
80006e2c:	22079c63          	bnez	a5,80007064 <dir_register+0x404>
	res = dir_alloc(dp, n_ent);		/* Allocate entries */
80006e30:	00100593          	li	a1,1
80006e34:	000c8513          	mv	a0,s9
80006e38:	d01fe0ef          	jal	ra,80005b38 <dir_alloc>
80006e3c:	00050c13          	mv	s8,a0
	if (res == FR_OK && --n_ent) {	/* Set LFN entry if needed */
80006e40:	04051e63          	bnez	a0,80006e9c <dir_register+0x23c>
		res = move_window(fs, dp->sect);
80006e44:	038ca583          	lw	a1,56(s9)
	if (sect != fs->winsect) {	/* Window offset changed? */
80006e48:	0389a783          	lw	a5,56(s3)
80006e4c:	00f58a63          	beq	a1,a5,80006e60 <dir_register+0x200>
80006e50:	00098513          	mv	a0,s3
80006e54:	944fd0ef          	jal	ra,80003f98 <move_window.part.6>
80006e58:	00050c13          	mv	s8,a0
		if (res == FR_OK) {
80006e5c:	04051063          	bnez	a0,80006e9c <dir_register+0x23c>
			memset(dp->dir, 0, SZDIRE);	/* Clean the entry */
80006e60:	03cca503          	lw	a0,60(s9)
80006e64:	02000613          	li	a2,32
80006e68:	00000593          	li	a1,0
80006e6c:	8b5fb0ef          	jal	ra,80002720 <memset>
			memcpy(dp->dir + DIR_Name, dp->fn, 11);	/* Put SFN */
80006e70:	03cca503          	lw	a0,60(s9)
80006e74:	00b00613          	li	a2,11
80006e78:	000b8593          	mv	a1,s7
80006e7c:	82dfb0ef          	jal	ra,800026a8 <memcpy>
			dp->dir[DIR_NTres] = dp->fn[NSFLAG] & (NS_BODY | NS_EXT);	/* Put NT flag */
80006e80:	04bcc783          	lbu	a5,75(s9)
80006e84:	03cca703          	lw	a4,60(s9)
			fs->wflag = 1;
80006e88:	00000c13          	li	s8,0
			dp->dir[DIR_NTres] = dp->fn[NSFLAG] & (NS_BODY | NS_EXT);	/* Put NT flag */
80006e8c:	0187f793          	andi	a5,a5,24
80006e90:	00f70623          	sb	a5,12(a4)
			fs->wflag = 1;
80006e94:	00100793          	li	a5,1
80006e98:	00f98223          	sb	a5,4(s3)
}
80006e9c:	08c12083          	lw	ra,140(sp)
80006ea0:	08812403          	lw	s0,136(sp)
80006ea4:	000c0513          	mv	a0,s8
80006ea8:	08412483          	lw	s1,132(sp)
80006eac:	08012903          	lw	s2,128(sp)
80006eb0:	07c12983          	lw	s3,124(sp)
80006eb4:	07812a03          	lw	s4,120(sp)
80006eb8:	07412a83          	lw	s5,116(sp)
80006ebc:	07012b03          	lw	s6,112(sp)
80006ec0:	06c12b83          	lw	s7,108(sp)
80006ec4:	06812c03          	lw	s8,104(sp)
80006ec8:	06412c83          	lw	s9,100(sp)
80006ecc:	06012d03          	lw	s10,96(sp)
80006ed0:	09010113          	addi	sp,sp,144
80006ed4:	00008067          	ret
	ns[i] = '~';
80006ed8:	06010793          	addi	a5,sp,96
	for (j = 0; j < i && dst[j] != ' '; j++) {	/* Find the offset to append */
80006edc:	040cc603          	lbu	a2,64(s9)
	ns[i] = '~';
80006ee0:	07e00693          	li	a3,126
80006ee4:	00e787b3          	add	a5,a5,a4
80006ee8:	fad78423          	sb	a3,-88(a5)
	for (j = 0; j < i && dst[j] != ' '; j++) {	/* Find the offset to append */
80006eec:	00000693          	li	a3,0
80006ef0:	000c8793          	mv	a5,s9
80006ef4:	00961863          	bne	a2,s1,80006f04 <dir_register+0x2a4>
80006ef8:	e81ff06f          	j	80006d78 <dir_register+0x118>
80006efc:	0407c603          	lbu	a2,64(a5)
80006f00:	e6960ce3          	beq	a2,s1,80006d78 <dir_register+0x118>
80006f04:	00168693          	addi	a3,a3,1
80006f08:	00dc87b3          	add	a5,s9,a3
80006f0c:	fee6e8e3          	bltu	a3,a4,80006efc <dir_register+0x29c>
80006f10:	e69ff06f          	j	80006d78 <dir_register+0x118>
		n_ent = (len + 14) / 15 + 2;	/* Number of entries to allocate (85+C0+C1s) */
80006f14:	00f00593          	li	a1,15
80006f18:	00e40513          	addi	a0,s0,14
80006f1c:	2b5060ef          	jal	ra,8000d9d0 <__udivsi3>
		res = dir_alloc(dp, n_ent);		/* Allocate directory entries */
80006f20:	00250593          	addi	a1,a0,2
		n_ent = (len + 14) / 15 + 2;	/* Number of entries to allocate (85+C0+C1s) */
80006f24:	00050413          	mv	s0,a0
		res = dir_alloc(dp, n_ent);		/* Allocate directory entries */
80006f28:	000c8513          	mv	a0,s9
80006f2c:	c0dfe0ef          	jal	ra,80005b38 <dir_alloc>
80006f30:	00050c13          	mv	s8,a0
		if (res != FR_OK) return res;
80006f34:	f60514e3          	bnez	a0,80006e9c <dir_register+0x23c>
		dp->blk_ofs = dp->dptr - SZDIRE * (n_ent - 1);	/* Set the allocated entry block offset */
80006f38:	030ca703          	lw	a4,48(s9)
80006f3c:	00541413          	slli	s0,s0,0x5
		if (dp->obj.stat & 4) {			/* Has the directory been stretched by new allocation? */
80006f40:	007cc783          	lbu	a5,7(s9)
		dp->blk_ofs = dp->dptr - SZDIRE * (n_ent - 1);	/* Set the allocated entry block offset */
80006f44:	02040413          	addi	s0,s0,32
80006f48:	40870433          	sub	s0,a4,s0
80006f4c:	048ca623          	sw	s0,76(s9)
		if (dp->obj.stat & 4) {			/* Has the directory been stretched by new allocation? */
80006f50:	0047f713          	andi	a4,a5,4
80006f54:	02070c63          	beqz	a4,80006f8c <dir_register+0x32c>
			dp->obj.stat &= ~4;
80006f58:	0fb7f793          	andi	a5,a5,251
80006f5c:	00fc83a3          	sb	a5,7(s9)
	if (obj->stat == 3) {	/* Has the object been changed 'fragmented' in this session? */
80006f60:	00300713          	li	a4,3
80006f64:	3ee78a63          	beq	a5,a4,80007358 <dir_register+0x6f8>
	while (obj->n_frag > 0) {	/* Create the chain of last fragment */
80006f68:	034ca603          	lw	a2,52(s9)
80006f6c:	fff00693          	li	a3,-1
80006f70:	01cc8593          	addi	a1,s9,28
80006f74:	000c8513          	mv	a0,s9
80006f78:	c51fd0ef          	jal	ra,80004bc8 <fill_last_frag.isra.8.part.9>
80006f7c:	00050c13          	mv	s8,a0
			if (res != FR_OK) return res;
80006f80:	f0051ee3          	bnez	a0,80006e9c <dir_register+0x23c>
			if (dp->obj.sclust != 0) {		/* Is it a sub-directory? */
80006f84:	008ca783          	lw	a5,8(s9)
80006f88:	2a079263          	bnez	a5,8000722c <dir_register+0x5cc>
		create_xdir(fs->dirbuf, fs->lfnbuf);	/* Create on-memory directory block to be written later */
80006f8c:	0109a483          	lw	s1,16(s3)
	memset(dirb, 0, 2 * SZDIRE);
80006f90:	04000613          	li	a2,64
80006f94:	00000593          	li	a1,0
80006f98:	00048513          	mv	a0,s1
		create_xdir(fs->dirbuf, fs->lfnbuf);	/* Create on-memory directory block to be written later */
80006f9c:	00c9a403          	lw	s0,12(s3)
	memset(dirb, 0, 2 * SZDIRE);
80006fa0:	f80fb0ef          	jal	ra,80002720 <memset>
	dirb[0 * SZDIRE + XDIR_Type] = ET_FILEDIR;
80006fa4:	f8500793          	li	a5,-123
80006fa8:	00f48023          	sb	a5,0(s1)
	dirb[1 * SZDIRE + XDIR_Type] = ET_STREAM;
80006fac:	00200893          	li	a7,2
80006fb0:	fc000793          	li	a5,-64
80006fb4:	02f48023          	sb	a5,32(s1)
	nlen = nc1 = 0; wc = 1;
80006fb8:	00000313          	li	t1,0
80006fbc:	00000e13          	li	t3,0
80006fc0:	00100713          	li	a4,1
	i = SZDIRE * 2;	/* Top of file_name entries */
80006fc4:	04000693          	li	a3,64
80006fc8:	00000813          	li	a6,0
		dirb[i++] = ET_FILENAME; dirb[i++] = 0;
80006fcc:	fc100e93          	li	t4,-63
80006fd0:	409888b3          	sub	a7,a7,s1
80006fd4:	00d48633          	add	a2,s1,a3
80006fd8:	00268793          	addi	a5,a3,2
80006fdc:	01d60023          	sb	t4,0(a2)
80006fe0:	000600a3          	sb	zero,1(a2)
80006fe4:	00f487b3          	add	a5,s1,a5
80006fe8:	03c0006f          	j	80007024 <dir_register+0x3c4>
			if (wc != 0 && (wc = lfn[nlen]) != 0) nlen++;	/* Get a character if exist */
80006fec:	00055703          	lhu	a4,0(a0)
80006ff0:	00130693          	addi	a3,t1,1
80006ff4:	0ff77613          	andi	a2,a4,255
80006ff8:	00875593          	srli	a1,a4,0x8
80006ffc:	1e070e63          	beqz	a4,800071f8 <dir_register+0x598>
80007000:	0ff6f313          	andi	t1,a3,255
80007004:	00131813          	slli	a6,t1,0x1
80007008:	01040533          	add	a0,s0,a6
	*ptr++ = (BYTE)val; val >>= 8;
8000700c:	00f886b3          	add	a3,a7,a5
80007010:	00c78023          	sb	a2,0(a5)
	*ptr++ = (BYTE)val;
80007014:	00b780a3          	sb	a1,1(a5)
		} while (i % SZDIRE != 0);
80007018:	01f6fc13          	andi	s8,a3,31
8000701c:	00278793          	addi	a5,a5,2
80007020:	020c0663          	beqz	s8,8000704c <dir_register+0x3ec>
			if (wc != 0 && (wc = lfn[nlen]) != 0) nlen++;	/* Get a character if exist */
80007024:	01040533          	add	a0,s0,a6
80007028:	fc0712e3          	bnez	a4,80006fec <dir_register+0x38c>
8000702c:	00f886b3          	add	a3,a7,a5
80007030:	00000593          	li	a1,0
80007034:	00000613          	li	a2,0
	*ptr++ = (BYTE)val; val >>= 8;
80007038:	00c78023          	sb	a2,0(a5)
	*ptr++ = (BYTE)val;
8000703c:	00b780a3          	sb	a1,1(a5)
		} while (i % SZDIRE != 0);
80007040:	01f6fc13          	andi	s8,a3,31
80007044:	00278793          	addi	a5,a5,2
80007048:	fc0c1ee3          	bnez	s8,80007024 <dir_register+0x3c4>
	} while (lfn[nlen]);	/* Fill next entry if any char follows */
8000704c:	00055603          	lhu	a2,0(a0)
		nc1++;
80007050:	001e0793          	addi	a5,t3,1
80007054:	0ff7f793          	andi	a5,a5,255
	} while (lfn[nlen]);	/* Fill next entry if any char follows */
80007058:	1a060463          	beqz	a2,80007200 <dir_register+0x5a0>
		nc1++;
8000705c:	00078e13          	mv	t3,a5
80007060:	f75ff06f          	j	80006fd4 <dir_register+0x374>
	n_ent = (sn[NSFLAG] & NS_LFN) ? (len + 12) / 13 + 1 : 1;	/* Number of entries to allocate */
80007064:	00c40413          	addi	s0,s0,12
80007068:	00d00593          	li	a1,13
8000706c:	00040513          	mv	a0,s0
80007070:	161060ef          	jal	ra,8000d9d0 <__udivsi3>
	res = dir_alloc(dp, n_ent);		/* Allocate entries */
80007074:	00150593          	addi	a1,a0,1
	n_ent = (sn[NSFLAG] & NS_LFN) ? (len + 12) / 13 + 1 : 1;	/* Number of entries to allocate */
80007078:	00050913          	mv	s2,a0
	res = dir_alloc(dp, n_ent);		/* Allocate entries */
8000707c:	000c8513          	mv	a0,s9
80007080:	ab9fe0ef          	jal	ra,80005b38 <dir_alloc>
80007084:	00050c13          	mv	s8,a0
	if (res == FR_OK && --n_ent) {	/* Set LFN entry if needed */
80007088:	e0051ae3          	bnez	a0,80006e9c <dir_register+0x23c>
8000708c:	00c00793          	li	a5,12
80007090:	daf40ae3          	beq	s0,a5,80006e44 <dir_register+0x1e4>
		res = dir_sdi(dp, dp->dptr - n_ent * SZDIRE);
80007094:	030ca583          	lw	a1,48(s9)
80007098:	00591793          	slli	a5,s2,0x5
8000709c:	000c8513          	mv	a0,s9
800070a0:	40f585b3          	sub	a1,a1,a5
800070a4:	d38fd0ef          	jal	ra,800045dc <dir_sdi>
800070a8:	00050c13          	mv	s8,a0
		if (res == FR_OK) {
800070ac:	de0518e3          	bnez	a0,80006e9c <dir_register+0x23c>
800070b0:	04bc8613          	addi	a2,s9,75
800070b4:	000b8713          	mv	a4,s7
		sum = (sum >> 1) + (sum << 7) + *dir++;
800070b8:	00170713          	addi	a4,a4,1
800070bc:	fff74683          	lbu	a3,-1(a4)
800070c0:	001b5793          	srli	a5,s6,0x1
800070c4:	007b1b13          	slli	s6,s6,0x7
800070c8:	0167eb33          	or	s6,a5,s6
800070cc:	00db0b33          	add	s6,s6,a3
800070d0:	0ffb7b13          	andi	s6,s6,255
	} while (--n);
800070d4:	fec712e3          	bne	a4,a2,800070b8 <dir_register+0x458>
		if (wc != 0xFFFF) wc = lfn[i++];	/* Get an effective character */
800070d8:	000104b7          	lui	s1,0x10
		st_word(dir + LfnOfs[s], wc);		/* Put it */
800070dc:	8000ea37          	lui	s4,0x8000e
	dir[LDIR_Attr] = AM_LFN;		/* Set attribute. LFN entry */
800070e0:	00f00413          	li	s0,15
		if (wc != 0xFFFF) wc = lfn[i++];	/* Get an effective character */
800070e4:	fff48493          	addi	s1,s1,-1 # ffff <crtStart-0x7fff0001>
		st_word(dir + LfnOfs[s], wc);		/* Put it */
800070e8:	4b4a0a13          	addi	s4,s4,1204 # 8000e4b4 <STACK_TOP+0xfffee4b4>
				res = move_window(fs, dp->sect);
800070ec:	038ca583          	lw	a1,56(s9)
	if (sect != fs->winsect) {	/* Window offset changed? */
800070f0:	0389a783          	lw	a5,56(s3)
800070f4:	00f58863          	beq	a1,a5,80007104 <dir_register+0x4a4>
800070f8:	00098513          	mv	a0,s3
800070fc:	e9dfc0ef          	jal	ra,80003f98 <move_window.part.6>
				if (res != FR_OK) break;
80007100:	26051a63          	bnez	a0,80007374 <dir_register+0x714>
	i = (ord - 1) * 13;				/* Get offset in the LFN working buffer */
80007104:	0ff97713          	andi	a4,s2,255
80007108:	fff70793          	addi	a5,a4,-1
				put_lfn(fs->lfnbuf, dp->dir, (BYTE)n_ent, sum);
8000710c:	03cca803          	lw	a6,60(s9)
	i = (ord - 1) * 13;				/* Get offset in the LFN working buffer */
80007110:	00179713          	slli	a4,a5,0x1
80007114:	00f70733          	add	a4,a4,a5
80007118:	00271713          	slli	a4,a4,0x2
				put_lfn(fs->lfnbuf, dp->dir, (BYTE)n_ent, sum);
8000711c:	00c9ae83          	lw	t4,12(s3)
	i = (ord - 1) * 13;				/* Get offset in the LFN working buffer */
80007120:	00f70733          	add	a4,a4,a5
80007124:	0ff97f13          	andi	t5,s2,255
	dir[LDIR_Chksum] = sum;			/* Set checksum */
80007128:	016806a3          	sb	s6,13(a6)
	dir[LDIR_Attr] = AM_LFN;		/* Set attribute. LFN entry */
8000712c:	008805a3          	sb	s0,11(a6)
	dir[LDIR_Type] = 0;
80007130:	00080623          	sb	zero,12(a6)
	*ptr++ = (BYTE)val; val >>= 8;
80007134:	00080d23          	sb	zero,26(a6)
	*ptr++ = (BYTE)val;
80007138:	00080da3          	sb	zero,27(a6)
	s = wc = 0;
8000713c:	00000693          	li	a3,0
	i = (ord - 1) * 13;				/* Get offset in the LFN working buffer */
80007140:	00100613          	li	a2,1
	s = wc = 0;
80007144:	00000793          	li	a5,0
	*ptr++ = (BYTE)val; val >>= 8;
80007148:	fff00893          	li	a7,-1
	} while (++s < 13);
8000714c:	00c00313          	li	t1,12
80007150:	0280006f          	j	80007178 <dir_register+0x518>
80007154:	06a36c63          	bltu	t1,a0,800071cc <dir_register+0x56c>
		st_word(dir + LfnOfs[s], wc);		/* Put it */
80007158:	000e4603          	lbu	a2,0(t3)
		if (wc == 0) wc = 0xFFFF;			/* Padding characters for following items */
8000715c:	00048793          	mv	a5,s1
		st_word(dir + LfnOfs[s], wc);		/* Put it */
80007160:	00c80633          	add	a2,a6,a2
	*ptr++ = (BYTE)val; val >>= 8;
80007164:	01160023          	sb	a7,0(a2)
	*ptr++ = (BYTE)val;
80007168:	011600a3          	sb	a7,1(a2)
		if (wc == 0) wc = 0xFFFF;			/* Padding characters for following items */
8000716c:	00da0633          	add	a2,s4,a3
	} while (++s < 13);
80007170:	04d36463          	bltu	t1,a3,800071b8 <dir_register+0x558>
80007174:	00064603          	lbu	a2,0(a2)
		if (wc != 0xFFFF) wc = lfn[i++];	/* Get an effective character */
80007178:	00171593          	slli	a1,a4,0x1
8000717c:	00168513          	addi	a0,a3,1
80007180:	00be85b3          	add	a1,t4,a1
80007184:	00c80633          	add	a2,a6,a2
		st_word(dir + LfnOfs[s], wc);		/* Put it */
80007188:	00aa0e33          	add	t3,s4,a0
		if (wc != 0xFFFF) wc = lfn[i++];	/* Get an effective character */
8000718c:	1a978e63          	beq	a5,s1,80007348 <dir_register+0x6e8>
80007190:	0005d783          	lhu	a5,0(a1) # 10000 <crtStart-0x7fff0000>
80007194:	00170713          	addi	a4,a4,1
		st_word(dir + LfnOfs[s], wc);		/* Put it */
80007198:	00268693          	addi	a3,a3,2
	*ptr++ = (BYTE)val; val >>= 8;
8000719c:	0087d593          	srli	a1,a5,0x8
800071a0:	00f60023          	sb	a5,0(a2)
	*ptr++ = (BYTE)val;
800071a4:	00b600a3          	sb	a1,1(a2)
		if (wc == 0) wc = 0xFFFF;			/* Padding characters for following items */
800071a8:	fa0786e3          	beqz	a5,80007154 <dir_register+0x4f4>
800071ac:	00050693          	mv	a3,a0
800071b0:	00da0633          	add	a2,s4,a3
	} while (++s < 13);
800071b4:	fcd370e3          	bgeu	t1,a3,80007174 <dir_register+0x514>
	if (wc == 0xFFFF || !lfn[i]) ord |= LLEF;	/* Last LFN part is the start of LFN sequence */
800071b8:	00978a63          	beq	a5,s1,800071cc <dir_register+0x56c>
800071bc:	00171713          	slli	a4,a4,0x1
800071c0:	00ee8733          	add	a4,t4,a4
800071c4:	00075783          	lhu	a5,0(a4)
800071c8:	00079463          	bnez	a5,800071d0 <dir_register+0x570>
800071cc:	040f6f13          	ori	t5,t5,64
	dir[LDIR_Ord] = ord;			/* Set the LFN order */
800071d0:	01e80023          	sb	t5,0(a6)
				fs->wflag = 1;
800071d4:	00100793          	li	a5,1
800071d8:	00f98223          	sb	a5,4(s3)
				res = dir_next(dp, 0);	/* Next entry */
800071dc:	00000593          	li	a1,0
800071e0:	000c8513          	mv	a0,s9
800071e4:	fb4fe0ef          	jal	ra,80005998 <dir_next>
			} while (res == FR_OK && --n_ent);
800071e8:	18051663          	bnez	a0,80007374 <dir_register+0x714>
800071ec:	fff90913          	addi	s2,s2,-1
800071f0:	ee091ee3          	bnez	s2,800070ec <dir_register+0x48c>
800071f4:	c51ff06f          	j	80006e44 <dir_register+0x1e4>
			if (wc != 0 && (wc = lfn[nlen]) != 0) nlen++;	/* Get a character if exist */
800071f8:	00000613          	li	a2,0
800071fc:	e11ff06f          	j	8000700c <dir_register+0x3ac>
	dirb[XDIR_NumSec] = 1 + nc1;	/* Set secondary count (C0 + C1s) */
80007200:	002e0e13          	addi	t3,t3,2
	dirb[XDIR_NumName] = nlen;		/* Set name length */
80007204:	026481a3          	sb	t1,35(s1)
	dirb[XDIR_NumSec] = 1 + nc1;	/* Set secondary count (C0 + C1s) */
80007208:	01c480a3          	sb	t3,1(s1)
	st_word(dirb + XDIR_NameHash, xname_sum(lfn));	/* Set name hash */
8000720c:	00040513          	mv	a0,s0
80007210:	96dfc0ef          	jal	ra,80003b7c <xname_sum>
	*ptr++ = (BYTE)val; val >>= 8;
80007214:	00855793          	srli	a5,a0,0x8
80007218:	02a48223          	sb	a0,36(s1)
	*ptr++ = (BYTE)val;
8000721c:	02f482a3          	sb	a5,37(s1)
80007220:	c7dff06f          	j	80006e9c <dir_register+0x23c>
	for (len = 0; fs->lfnbuf[len]; len++) ;	/* Get lfn length */
80007224:	00000413          	li	s0,0
80007228:	aa5ff06f          	j	80006ccc <dir_register+0x6c>
	dp->obj.stat = (BYTE)obj->c_size;
8000722c:	024ca703          	lw	a4,36(s9)
	dp->blk_ofs = obj->c_ofs;
80007230:	028ca783          	lw	a5,40(s9)
	dp->obj.fs = obj->fs;
80007234:	000ca803          	lw	a6,0(s9)
	dp->obj.sclust = obj->c_scl;
80007238:	020ca603          	lw	a2,32(s9)
	dp->obj.objsize = obj->c_size & 0xFFFFFF00;
8000723c:	f0077693          	andi	a3,a4,-256
	res = dir_sdi(dp, dp->blk_ofs);	/* Goto object's entry block */
80007240:	00078593          	mv	a1,a5
80007244:	01010513          	addi	a0,sp,16
	dp->obj.fs = obj->fs;
80007248:	01012823          	sw	a6,16(sp)
	dp->obj.sclust = obj->c_scl;
8000724c:	00c12c23          	sw	a2,24(sp)
	dp->obj.stat = (BYTE)obj->c_size;
80007250:	00e10ba3          	sb	a4,23(sp)
	dp->obj.objsize = obj->c_size & 0xFFFFFF00;
80007254:	02d12023          	sw	a3,32(sp)
80007258:	02012223          	sw	zero,36(sp)
	dp->obj.n_frag = 0;
8000725c:	02012623          	sw	zero,44(sp)
	dp->blk_ofs = obj->c_ofs;
80007260:	04f12e23          	sw	a5,92(sp)
	res = dir_sdi(dp, dp->blk_ofs);	/* Goto object's entry block */
80007264:	b78fd0ef          	jal	ra,800045dc <dir_sdi>
80007268:	00050c13          	mv	s8,a0
	if (res == FR_OK) {
8000726c:	c20518e3          	bnez	a0,80006e9c <dir_register+0x23c>
		res = load_xdir(dp);		/* Load the object's entry block */
80007270:	01010513          	addi	a0,sp,16
80007274:	aa5fe0ef          	jal	ra,80005d18 <load_xdir>
80007278:	00050c13          	mv	s8,a0
				if (res != FR_OK) return res;
8000727c:	c20510e3          	bnez	a0,80006e9c <dir_register+0x23c>
				dp->obj.objsize += (DWORD)fs->csize * SS(fs);		/* Increase the directory size by cluster size */
80007280:	00a9d783          	lhu	a5,10(s3)
80007284:	010ca683          	lw	a3,16(s9)
80007288:	014ca603          	lw	a2,20(s9)
8000728c:	00979793          	slli	a5,a5,0x9
80007290:	00d786b3          	add	a3,a5,a3
				st_qword(fs->dirbuf + XDIR_FileSize, dp->obj.objsize);
80007294:	0109a703          	lw	a4,16(s3)
				dp->obj.objsize += (DWORD)fs->csize * SS(fs);		/* Increase the directory size by cluster size */
80007298:	00f6b7b3          	sltu	a5,a3,a5
8000729c:	00c787b3          	add	a5,a5,a2
800072a0:	00fcaa23          	sw	a5,20(s9)
800072a4:	00dca823          	sw	a3,16(s9)
	*ptr++ = (BYTE)val; val >>= 8;
800072a8:	0086d313          	srli	t1,a3,0x8
	*ptr++ = (BYTE)val; val >>= 8;
800072ac:	0106d893          	srli	a7,a3,0x10
	*ptr++ = (BYTE)val; val >>= 8;
800072b0:	0186d813          	srli	a6,a3,0x18
	*ptr++ = (BYTE)val; val >>= 8;
800072b4:	0087d513          	srli	a0,a5,0x8
	*ptr++ = (BYTE)val; val >>= 8;
800072b8:	0107d593          	srli	a1,a5,0x10
	*ptr++ = (BYTE)val; val >>= 8;
800072bc:	0187d613          	srli	a2,a5,0x18
	*ptr++ = (BYTE)val; val >>= 8;
800072c0:	02670ca3          	sb	t1,57(a4)
	*ptr++ = (BYTE)val; val >>= 8;
800072c4:	03170d23          	sb	a7,58(a4)
	*ptr++ = (BYTE)val; val >>= 8;
800072c8:	03070da3          	sb	a6,59(a4)
	*ptr++ = (BYTE)val; val >>= 8;
800072cc:	02a70ea3          	sb	a0,61(a4)
	*ptr++ = (BYTE)val; val >>= 8;
800072d0:	02b70f23          	sb	a1,62(a4)
	*ptr++ = (BYTE)val;
800072d4:	02c70fa3          	sb	a2,63(a4)
	*ptr++ = (BYTE)val; val >>= 8;
800072d8:	02d70c23          	sb	a3,56(a4)
	*ptr++ = (BYTE)val; val >>= 8;
800072dc:	02f70e23          	sb	a5,60(a4)
				st_qword(fs->dirbuf + XDIR_ValidFileSize, dp->obj.objsize);
800072e0:	014ca703          	lw	a4,20(s9)
800072e4:	010ca683          	lw	a3,16(s9)
800072e8:	0109a783          	lw	a5,16(s3)
	*ptr++ = (BYTE)val; val >>= 8;
800072ec:	00875513          	srli	a0,a4,0x8
	*ptr++ = (BYTE)val; val >>= 8;
800072f0:	01075593          	srli	a1,a4,0x10
	*ptr++ = (BYTE)val; val >>= 8;
800072f4:	01875613          	srli	a2,a4,0x18
	*ptr++ = (BYTE)val; val >>= 8;
800072f8:	0086d313          	srli	t1,a3,0x8
	*ptr++ = (BYTE)val; val >>= 8;
800072fc:	0106d893          	srli	a7,a3,0x10
	*ptr++ = (BYTE)val; val >>= 8;
80007300:	0186d813          	srli	a6,a3,0x18
	*ptr++ = (BYTE)val; val >>= 8;
80007304:	02a786a3          	sb	a0,45(a5)
	*ptr++ = (BYTE)val; val >>= 8;
80007308:	02d78423          	sb	a3,40(a5)
	*ptr++ = (BYTE)val; val >>= 8;
8000730c:	026784a3          	sb	t1,41(a5)
	*ptr++ = (BYTE)val; val >>= 8;
80007310:	03178523          	sb	a7,42(a5)
	*ptr++ = (BYTE)val; val >>= 8;
80007314:	030785a3          	sb	a6,43(a5)
	*ptr++ = (BYTE)val; val >>= 8;
80007318:	02e78623          	sb	a4,44(a5)
	*ptr++ = (BYTE)val; val >>= 8;
8000731c:	02b78723          	sb	a1,46(a5)
	*ptr++ = (BYTE)val;
80007320:	02c787a3          	sb	a2,47(a5)
				fs->dirbuf[XDIR_GenFlags] = dp->obj.stat | 1;		/* Update the allocation status */
80007324:	007cc783          	lbu	a5,7(s9)
80007328:	0109a703          	lw	a4,16(s3)
				res = store_xdir(&dj);				/* Store the object status */
8000732c:	01010513          	addi	a0,sp,16
				fs->dirbuf[XDIR_GenFlags] = dp->obj.stat | 1;		/* Update the allocation status */
80007330:	0017e793          	ori	a5,a5,1
80007334:	02f700a3          	sb	a5,33(a4)
				res = store_xdir(&dj);				/* Store the object status */
80007338:	c09fe0ef          	jal	ra,80005f40 <store_xdir>
8000733c:	00050c13          	mv	s8,a0
				if (res != FR_OK) return res;
80007340:	b4051ee3          	bnez	a0,80006e9c <dir_register+0x23c>
80007344:	c49ff06f          	j	80006f8c <dir_register+0x32c>
	*ptr++ = (BYTE)val; val >>= 8;
80007348:	01160023          	sb	a7,0(a2)
	*ptr++ = (BYTE)val;
8000734c:	011600a3          	sb	a7,1(a2)
80007350:	00050693          	mv	a3,a0
80007354:	e19ff06f          	j	8000716c <dir_register+0x50c>
80007358:	000c8513          	mv	a0,s9
8000735c:	935fd0ef          	jal	ra,80004c90 <fill_first_frag.part.10>
80007360:	00050c13          	mv	s8,a0
			if (res != FR_OK) return res;
80007364:	c00502e3          	beqz	a0,80006f68 <dir_register+0x308>
80007368:	b35ff06f          	j	80006e9c <dir_register+0x23c>
		if (n == 100) return FR_DENIED;		/* Abort if too many collisions */
8000736c:	00700c13          	li	s8,7
80007370:	b2dff06f          	j	80006e9c <dir_register+0x23c>
80007374:	00050c13          	mv	s8,a0
80007378:	b25ff06f          	j	80006e9c <dir_register+0x23c>

8000737c <f_mount>:
FRESULT f_mount (
	FATFS* fs,			/* Pointer to the filesystem object to be registered (NULL:unmount)*/
	const TCHAR* path,	/* Logical drive number to be mounted/unmounted */
	BYTE opt			/* Mount option: 0=Do not mount (delayed mount), 1=Mount immediately */
)
{
8000737c:	fd010113          	addi	sp,sp,-48
80007380:	00a12623          	sw	a0,12(sp)
	FRESULT res;
	const TCHAR *rp = path;


	/* Get volume ID (logical drive number) */
	vol = get_ldnumber(&rp);
80007384:	01c10513          	addi	a0,sp,28
{
80007388:	02812423          	sw	s0,40(sp)
8000738c:	02112623          	sw	ra,44(sp)
80007390:	00b12423          	sw	a1,8(sp)
80007394:	00060413          	mv	s0,a2
	const TCHAR *rp = path;
80007398:	00b12e23          	sw	a1,28(sp)
	vol = get_ldnumber(&rp);
8000739c:	a04fc0ef          	jal	ra,800035a0 <get_ldnumber>
	// printf("vol=%d\n", vol);
	if (vol < 0) return FR_INVALID_DRIVE;
800073a0:	06054863          	bltz	a0,80007410 <f_mount+0x94>
	cfs = FatFs[vol];			/* Pointer to the filesystem object of the volume */
800073a4:	00251693          	slli	a3,a0,0x2
800073a8:	c7818793          	addi	a5,gp,-904 # 8000efe8 <FatFs>
800073ac:	00d785b3          	add	a1,a5,a3
800073b0:	0005a703          	lw	a4,0(a1)
	// printf("cfs=%d\n", cfs);

	if (cfs) {					/* Unregister current filesystem object if regsitered */
800073b4:	00070663          	beqz	a4,800073c0 <f_mount+0x44>
		FatFs[vol] = 0;
800073b8:	0005a023          	sw	zero,0(a1)
		clear_share(cfs);
#endif
#if FF_FS_REENTRANT				/* Discard mutex of the current volume */
		ff_mutex_delete(vol);
#endif
		cfs->fs_type = 0;		/* Invalidate the filesystem object to be unregistered */
800073bc:	00070023          	sb	zero,0(a4)
	}

	if (fs) {					/* Register new filesystem object */
800073c0:	00c12703          	lw	a4,12(sp)
800073c4:	00070a63          	beqz	a4,800073d8 <f_mount+0x5c>
		fs->pdrv = LD2PD(vol);	/* Volume hosting physical drive */
800073c8:	00a700a3          	sb	a0,1(a4)
			}
			SysLock = 1;		/* System mutex is ready */
		}
#endif
#endif
		fs->fs_type = 0;		/* Invalidate the new filesystem object */
800073cc:	00070023          	sb	zero,0(a4)
		FatFs[vol] = fs;		/* Register new fs object */
800073d0:	00d787b3          	add	a5,a5,a3
800073d4:	00e7a023          	sw	a4,0(a5)
	}
	// print("Done registering fs\n");

	if (opt == 0) return FR_OK;	/* Do not mount now, it will be mounted in subsequent file functions */
800073d8:	00000513          	li	a0,0
800073dc:	00041a63          	bnez	s0,800073f0 <f_mount+0x74>

	res = mount_volume(&path, &fs, 0);	/* Force mounted the volume */
	LEAVE_FF(fs, res);
}
800073e0:	02c12083          	lw	ra,44(sp)
800073e4:	02812403          	lw	s0,40(sp)
800073e8:	03010113          	addi	sp,sp,48
800073ec:	00008067          	ret
	res = mount_volume(&path, &fs, 0);	/* Force mounted the volume */
800073f0:	00c10593          	addi	a1,sp,12
800073f4:	00810513          	addi	a0,sp,8
800073f8:	00000613          	li	a2,0
800073fc:	949fd0ef          	jal	ra,80004d44 <mount_volume>
}
80007400:	02c12083          	lw	ra,44(sp)
80007404:	02812403          	lw	s0,40(sp)
80007408:	03010113          	addi	sp,sp,48
8000740c:	00008067          	ret
80007410:	02c12083          	lw	ra,44(sp)
80007414:	02812403          	lw	s0,40(sp)
	if (vol < 0) return FR_INVALID_DRIVE;
80007418:	00b00513          	li	a0,11
}
8000741c:	03010113          	addi	sp,sp,48
80007420:	00008067          	ret

80007424 <f_open>:
FRESULT f_open (
	FIL* fp,			/* Pointer to the blank file object */
	const TCHAR* path,	/* Pointer to the file name */
	BYTE mode			/* Access mode and open mode flags */
)
{
80007424:	f6010113          	addi	sp,sp,-160
80007428:	08112e23          	sw	ra,156(sp)
8000742c:	08812c23          	sw	s0,152(sp)
80007430:	08912a23          	sw	s1,148(sp)
80007434:	09212823          	sw	s2,144(sp)
80007438:	09312623          	sw	s3,140(sp)
8000743c:	09412423          	sw	s4,136(sp)
80007440:	09512223          	sw	s5,132(sp)
80007444:	09612023          	sw	s6,128(sp)
80007448:	07712e23          	sw	s7,124(sp)
8000744c:	00b12623          	sw	a1,12(sp)
	FSIZE_t ofs;
#endif
	DEF_NAMBUF


	if (!fp) return FR_INVALID_OBJECT;
80007450:	20050663          	beqz	a0,8000765c <f_open+0x238>

	/* Get logical drive number */
	mode &= FF_FS_READONLY ? FA_READ : FA_READ | FA_WRITE | FA_CREATE_ALWAYS | FA_CREATE_NEW | FA_OPEN_ALWAYS | FA_OPEN_APPEND;
80007454:	03f67993          	andi	s3,a2,63
	res = mount_volume(&path, &fs, mode);
80007458:	00060493          	mv	s1,a2
8000745c:	00050413          	mv	s0,a0
80007460:	00098613          	mv	a2,s3
80007464:	01c10593          	addi	a1,sp,28
80007468:	00c10513          	addi	a0,sp,12
8000746c:	8d9fd0ef          	jal	ra,80004d44 <mount_volume>
80007470:	00050913          	mv	s2,a0
	if (res == FR_OK) {
80007474:	02050c63          	beqz	a0,800074ac <f_open+0x88>
		}

		FREE_NAMBUF();
	}

	if (res != FR_OK) fp->obj.fs = 0;	/* Invalidate file object on error */
80007478:	00042023          	sw	zero,0(s0)

	LEAVE_FF(fs, res);
}
8000747c:	09c12083          	lw	ra,156(sp)
80007480:	09812403          	lw	s0,152(sp)
80007484:	00090513          	mv	a0,s2
80007488:	09412483          	lw	s1,148(sp)
8000748c:	09012903          	lw	s2,144(sp)
80007490:	08c12983          	lw	s3,140(sp)
80007494:	08812a03          	lw	s4,136(sp)
80007498:	08412a83          	lw	s5,132(sp)
8000749c:	08012b03          	lw	s6,128(sp)
800074a0:	07c12b83          	lw	s7,124(sp)
800074a4:	0a010113          	addi	sp,sp,160
800074a8:	00008067          	ret
		dj.obj.fs = fs;
800074ac:	01c12783          	lw	a5,28(sp)
		res = follow_path(&dj, path);	/* Follow the file path */
800074b0:	00c12583          	lw	a1,12(sp)
800074b4:	02010513          	addi	a0,sp,32
		dj.obj.fs = fs;
800074b8:	02f12023          	sw	a5,32(sp)
		res = follow_path(&dj, path);	/* Follow the file path */
800074bc:	9f4ff0ef          	jal	ra,800066b0 <follow_path>
		if (res == FR_OK) {
800074c0:	01c4f793          	andi	a5,s1,28
800074c4:	02051663          	bnez	a0,800074f0 <f_open+0xcc>
			if (dj.fn[NSFLAG] & NS_NONAME) {	/* Origin directory itself? */
800074c8:	06b10703          	lb	a4,107(sp)
800074cc:	18074c63          	bltz	a4,80007664 <f_open+0x240>
		if (mode & (FA_CREATE_ALWAYS | FA_OPEN_ALWAYS | FA_CREATE_NEW)) {
800074d0:	02614703          	lbu	a4,38(sp)
800074d4:	02078863          	beqz	a5,80007504 <f_open+0xe0>
				if (dj.obj.attr & (AM_RDO | AM_DIR)) {	/* Cannot overwrite it (R/O or DIR) */
800074d8:	01177713          	andi	a4,a4,17
800074dc:	18071863          	bnez	a4,8000766c <f_open+0x248>
					if (mode & FA_CREATE_NEW) res = FR_EXIST;	/* Cannot create as new file */
800074e0:	0044f793          	andi	a5,s1,4
800074e4:	2e078c63          	beqz	a5,800077dc <f_open+0x3b8>
800074e8:	00800913          	li	s2,8
800074ec:	f8dff06f          	j	80007478 <f_open+0x54>
		if (mode & (FA_CREATE_ALWAYS | FA_OPEN_ALWAYS | FA_CREATE_NEW)) {
800074f0:	00078663          	beqz	a5,800074fc <f_open+0xd8>
				if (res == FR_NO_FILE) {		/* There is no file to open, create a new entry */
800074f4:	00400793          	li	a5,4
800074f8:	18f50263          	beq	a0,a5,8000767c <f_open+0x258>
800074fc:	00050913          	mv	s2,a0
80007500:	f79ff06f          	j	80007478 <f_open+0x54>
				if (dj.obj.attr & AM_DIR) {		/* File open against a directory */
80007504:	01077793          	andi	a5,a4,16
80007508:	16079663          	bnez	a5,80007674 <f_open+0x250>
					if ((mode & FA_WRITE) && (dj.obj.attr & AM_RDO)) { /* Write mode open against R/O file */
8000750c:	0024f493          	andi	s1,s1,2
80007510:	00048663          	beqz	s1,8000751c <f_open+0xf8>
80007514:	00177713          	andi	a4,a4,1
80007518:	14071a63          	bnez	a4,8000766c <f_open+0x248>
8000751c:	01c12683          	lw	a3,28(sp)
			if (mode & FA_CREATE_ALWAYS) mode |= FA_MODIFIED;	/* Set file change flag if created or overwritten */
80007520:	0089f793          	andi	a5,s3,8
80007524:	00078463          	beqz	a5,8000752c <f_open+0x108>
80007528:	0409e993          	ori	s3,s3,64
			fp->dir_sect = fs->winsect;			/* Pointer to the directory entry */
8000752c:	0386a603          	lw	a2,56(a3)
			fp->dir_ptr = dj.dir;
80007530:	05c12783          	lw	a5,92(sp)
			if (fs->fs_type == FS_EXFAT) {
80007534:	00400713          	li	a4,4
			fp->dir_sect = fs->winsect;			/* Pointer to the directory entry */
80007538:	04c42423          	sw	a2,72(s0)
			fp->dir_ptr = dj.dir;
8000753c:	04f42623          	sw	a5,76(s0)
			if (fs->fs_type == FS_EXFAT) {
80007540:	0006c603          	lbu	a2,0(a3)
80007544:	26e60063          	beq	a2,a4,800077a4 <f_open+0x380>
	rv = rv << 8 | ptr[0];
80007548:	01b7c703          	lbu	a4,27(a5)
8000754c:	01a7c503          	lbu	a0,26(a5)
	if (fs->fs_type == FS_FAT32) {
80007550:	00300593          	li	a1,3
	rv = rv << 8 | ptr[0];
80007554:	00871713          	slli	a4,a4,0x8
	cl = ld_word(dir + DIR_FstClusLO);
80007558:	00a76733          	or	a4,a4,a0
	if (fs->fs_type == FS_FAT32) {
8000755c:	00b61e63          	bne	a2,a1,80007578 <f_open+0x154>
	rv = rv << 8 | ptr[0];
80007560:	0157c603          	lbu	a2,21(a5)
80007564:	0147c583          	lbu	a1,20(a5)
80007568:	00861613          	slli	a2,a2,0x8
		cl |= (DWORD)ld_word(dir + DIR_FstClusHI) << 16;
8000756c:	00b66633          	or	a2,a2,a1
80007570:	01061613          	slli	a2,a2,0x10
80007574:	00c76733          	or	a4,a4,a2
				fp->obj.sclust = ld_clust(fs, dj.dir);					/* Get object allocation info */
80007578:	00e42423          	sw	a4,8(s0)
	rv = rv << 8 | ptr[2];
8000757c:	01f7c703          	lbu	a4,31(a5)
80007580:	01e7c583          	lbu	a1,30(a5)
	rv = rv << 8 | ptr[1];
80007584:	01d7c603          	lbu	a2,29(a5)
	rv = rv << 8 | ptr[2];
80007588:	00871713          	slli	a4,a4,0x8
8000758c:	00b76733          	or	a4,a4,a1
	rv = rv << 8 | ptr[0];
80007590:	01c7c583          	lbu	a1,28(a5)
	rv = rv << 8 | ptr[1];
80007594:	00871793          	slli	a5,a4,0x8
80007598:	00f667b3          	or	a5,a2,a5
	rv = rv << 8 | ptr[0];
8000759c:	00879793          	slli	a5,a5,0x8
800075a0:	00f5e7b3          	or	a5,a1,a5
				fp->obj.objsize = ld_dword(dj.dir + DIR_FileSize);
800075a4:	00f42823          	sw	a5,16(s0)
800075a8:	00042a23          	sw	zero,20(s0)
			fp->obj.id = fs->id;
800075ac:	0066d783          	lhu	a5,6(a3)
			fp->fptr = 0;		/* Set file pointer top of the file */
800075b0:	00000813          	li	a6,0
			memset(fp->buf, 0, sizeof fp->buf);	/* Clear sector buffer */
800075b4:	05040a13          	addi	s4,s0,80
			fp->obj.id = fs->id;
800075b8:	00f41223          	sh	a5,4(s0)
			fp->fptr = 0;		/* Set file pointer top of the file */
800075bc:	00000793          	li	a5,0
			fp->flag = mode;	/* Set file access mode */
800075c0:	03340823          	sb	s3,48(s0)
			fp->obj.fs = fs;	/* Validate the file object */
800075c4:	00d42023          	sw	a3,0(s0)
			fp->err = 0;		/* Clear error flag */
800075c8:	020408a3          	sb	zero,49(s0)
			fp->sect = 0;		/* Invalidate current data sector */
800075cc:	04042223          	sw	zero,68(s0)
			fp->fptr = 0;		/* Set file pointer top of the file */
800075d0:	02f42c23          	sw	a5,56(s0)
800075d4:	03042e23          	sw	a6,60(s0)
			memset(fp->buf, 0, sizeof fp->buf);	/* Clear sector buffer */
800075d8:	20000613          	li	a2,512
800075dc:	00000593          	li	a1,0
800075e0:	000a0513          	mv	a0,s4
			if ((mode & FA_SEEKEND) && fp->obj.objsize > 0) {	/* Seek to end of file if FA_OPEN_APPEND is specified */
800075e4:	0209f993          	andi	s3,s3,32
			memset(fp->buf, 0, sizeof fp->buf);	/* Clear sector buffer */
800075e8:	938fb0ef          	jal	ra,80002720 <memset>
			if ((mode & FA_SEEKEND) && fp->obj.objsize > 0) {	/* Seek to end of file if FA_OPEN_APPEND is specified */
800075ec:	e80988e3          	beqz	s3,8000747c <f_open+0x58>
800075f0:	01042483          	lw	s1,16(s0)
800075f4:	01442983          	lw	s3,20(s0)
800075f8:	0134e7b3          	or	a5,s1,s3
800075fc:	e80780e3          	beqz	a5,8000747c <f_open+0x58>
				bcs = (DWORD)fs->csize * SS(fs);	/* Cluster size in byte */
80007600:	01c12783          	lw	a5,28(sp)
				fp->fptr = fp->obj.objsize;			/* Offset to seek */
80007604:	02942c23          	sw	s1,56(s0)
80007608:	03342e23          	sw	s3,60(s0)
				bcs = (DWORD)fs->csize * SS(fs);	/* Cluster size in byte */
8000760c:	00a7db03          	lhu	s6,10(a5)
				clst = fp->obj.sclust;				/* Follow the cluster chain */
80007610:	00842583          	lw	a1,8(s0)
				bcs = (DWORD)fs->csize * SS(fs);	/* Cluster size in byte */
80007614:	009b1b13          	slli	s6,s6,0x9
				for (ofs = fp->obj.objsize; res == FR_OK && ofs > bcs; ofs -= bcs) {
80007618:	2e098a63          	beqz	s3,8000790c <f_open+0x4e8>
					if (clst <= 1) res = FR_INT_ERR;
8000761c:	00100a93          	li	s5,1
					if (clst == 0xFFFFFFFF) res = FR_DISK_ERR;
80007620:	fff00b93          	li	s7,-1
80007624:	01c0006f          	j	80007640 <f_open+0x21c>
				for (ofs = fp->obj.objsize; res == FR_OK && ofs > bcs; ofs -= bcs) {
80007628:	416487b3          	sub	a5,s1,s6
8000762c:	00f4b4b3          	sltu	s1,s1,a5
80007630:	409989b3          	sub	s3,s3,s1
					if (clst == 0xFFFFFFFF) res = FR_DISK_ERR;
80007634:	17750263          	beq	a0,s7,80007798 <f_open+0x374>
				for (ofs = fp->obj.objsize; res == FR_OK && ofs > bcs; ofs -= bcs) {
80007638:	00078493          	mv	s1,a5
8000763c:	1a098a63          	beqz	s3,800077f0 <f_open+0x3cc>
					clst = get_fat(&fp->obj, clst);
80007640:	00040513          	mv	a0,s0
80007644:	cedfc0ef          	jal	ra,80004330 <get_fat>
80007648:	00050593          	mv	a1,a0
					if (clst <= 1) res = FR_INT_ERR;
8000764c:	fcaaeee3          	bltu	s5,a0,80007628 <f_open+0x204>
80007650:	00200913          	li	s2,2
				fp->clust = clst;
80007654:	04b42023          	sw	a1,64(s0)
				if (res == FR_OK && ofs % SS(fs)) {	/* Fill sector buffer if not on the sector boundary */
80007658:	e21ff06f          	j	80007478 <f_open+0x54>
	if (!fp) return FR_INVALID_OBJECT;
8000765c:	00900913          	li	s2,9
80007660:	e1dff06f          	j	8000747c <f_open+0x58>
				res = FR_INVALID_NAME;
80007664:	00600913          	li	s2,6
80007668:	e11ff06f          	j	80007478 <f_open+0x54>
						res = FR_DENIED;
8000766c:	00700913          	li	s2,7
80007670:	e09ff06f          	j	80007478 <f_open+0x54>
					res = FR_NO_FILE;
80007674:	00400913          	li	s2,4
80007678:	e01ff06f          	j	80007478 <f_open+0x54>
					res = dir_register(&dj);
8000767c:	02010513          	addi	a0,sp,32
80007680:	de0ff0ef          	jal	ra,80006c60 <dir_register>
				mode |= FA_CREATE_ALWAYS;		/* File is created */
80007684:	0089e993          	ori	s3,s3,8
			if (res == FR_OK && (mode & FA_CREATE_ALWAYS)) {	/* Truncate the file if overwrite mode */
80007688:	e6051ae3          	bnez	a0,800074fc <f_open+0xd8>
8000768c:	01c12783          	lw	a5,28(sp)
				if (fs->fs_type == FS_EXFAT) {
80007690:	0007c603          	lbu	a2,0(a5)
80007694:	00400713          	li	a4,4
80007698:	00078693          	mv	a3,a5
8000769c:	1ce60263          	beq	a2,a4,80007860 <f_open+0x43c>
					st_dword(dj.dir + DIR_CrtTime, tm);
800076a0:	05c12703          	lw	a4,92(sp)
	*ptr++ = (BYTE)val; val >>= 8;
800076a4:	03500593          	li	a1,53
	*ptr++ = (BYTE)val;
800076a8:	05800613          	li	a2,88
	*ptr++ = (BYTE)val; val >>= 8;
800076ac:	00b70823          	sb	a1,16(a4)
	*ptr++ = (BYTE)val; val >>= 8;
800076b0:	00070723          	sb	zero,14(a4)
	*ptr++ = (BYTE)val; val >>= 8;
800076b4:	000707a3          	sb	zero,15(a4)
	*ptr++ = (BYTE)val;
800076b8:	00c708a3          	sb	a2,17(a4)
					st_dword(dj.dir + DIR_ModTime, tm);
800076bc:	05c12703          	lw	a4,92(sp)
	if (fs->fs_type == FS_FAT32) {
800076c0:	00300513          	li	a0,3
	*ptr++ = (BYTE)val; val >>= 8;
800076c4:	00b70c23          	sb	a1,24(a4)
	*ptr++ = (BYTE)val; val >>= 8;
800076c8:	00070b23          	sb	zero,22(a4)
	*ptr++ = (BYTE)val; val >>= 8;
800076cc:	00070ba3          	sb	zero,23(a4)
	*ptr++ = (BYTE)val;
800076d0:	00c70ca3          	sb	a2,25(a4)
					cl = ld_clust(fs, dj.dir);			/* Get current cluster chain */
800076d4:	05c12703          	lw	a4,92(sp)
	if (fs->fs_type == FS_FAT32) {
800076d8:	0007c603          	lbu	a2,0(a5)
	rv = rv << 8 | ptr[0];
800076dc:	01b74483          	lbu	s1,27(a4)
800076e0:	01a74583          	lbu	a1,26(a4)
800076e4:	00849493          	slli	s1,s1,0x8
	cl = ld_word(dir + DIR_FstClusLO);
800076e8:	00b4e4b3          	or	s1,s1,a1
	if (fs->fs_type == FS_FAT32) {
800076ec:	00a61e63          	bne	a2,a0,80007708 <f_open+0x2e4>
	rv = rv << 8 | ptr[0];
800076f0:	01574603          	lbu	a2,21(a4)
800076f4:	01474583          	lbu	a1,20(a4)
800076f8:	00861613          	slli	a2,a2,0x8
		cl |= (DWORD)ld_word(dir + DIR_FstClusHI) << 16;
800076fc:	00b66633          	or	a2,a2,a1
80007700:	01061613          	slli	a2,a2,0x10
80007704:	00c4e4b3          	or	s1,s1,a2
					dj.dir[DIR_Attr] = AM_ARC;			/* Reset attribute */
80007708:	02000613          	li	a2,32
8000770c:	00c705a3          	sb	a2,11(a4)
					st_clust(fs, dj.dir, 0);			/* Reset file allocation info */
80007710:	05c12703          	lw	a4,92(sp)
	if (fs->fs_type == FS_FAT32) {
80007714:	00300613          	li	a2,3
	*ptr++ = (BYTE)val; val >>= 8;
80007718:	00070d23          	sb	zero,26(a4)
	*ptr++ = (BYTE)val;
8000771c:	00070da3          	sb	zero,27(a4)
	if (fs->fs_type == FS_FAT32) {
80007720:	0007c583          	lbu	a1,0(a5)
80007724:	00c59663          	bne	a1,a2,80007730 <f_open+0x30c>
	*ptr++ = (BYTE)val; val >>= 8;
80007728:	00070a23          	sb	zero,20(a4)
	*ptr++ = (BYTE)val;
8000772c:	00070aa3          	sb	zero,21(a4)
					st_dword(dj.dir + DIR_FileSize, 0);
80007730:	05c12703          	lw	a4,92(sp)
	*ptr++ = (BYTE)val; val >>= 8;
80007734:	00070e23          	sb	zero,28(a4)
	*ptr++ = (BYTE)val; val >>= 8;
80007738:	00070ea3          	sb	zero,29(a4)
	*ptr++ = (BYTE)val; val >>= 8;
8000773c:	00070f23          	sb	zero,30(a4)
	*ptr++ = (BYTE)val;
80007740:	00070fa3          	sb	zero,31(a4)
					fs->wflag = 1;
80007744:	00100713          	li	a4,1
80007748:	00e78223          	sb	a4,4(a5)
					if (cl != 0) {						/* Remove the cluster chain if exist */
8000774c:	dc048ae3          	beqz	s1,80007520 <f_open+0xfc>
						res = remove_chain(&dj.obj, cl, 0);
80007750:	00000613          	li	a2,0
80007754:	00048593          	mv	a1,s1
80007758:	02010513          	addi	a0,sp,32
						sc = fs->winsect;
8000775c:	0387aa03          	lw	s4,56(a5)
						res = remove_chain(&dj.obj, cl, 0);
80007760:	a50fd0ef          	jal	ra,800049b0 <remove_chain>
						if (res == FR_OK) {
80007764:	d8051ce3          	bnez	a0,800074fc <f_open+0xd8>
							res = move_window(fs, sc);
80007768:	01c12683          	lw	a3,28(sp)
	if (sect != fs->winsect) {	/* Window offset changed? */
8000776c:	fff48493          	addi	s1,s1,-1
80007770:	0386a783          	lw	a5,56(a3)
80007774:	1afa0063          	beq	s4,a5,80007914 <f_open+0x4f0>
80007778:	000a0593          	mv	a1,s4
8000777c:	00068513          	mv	a0,a3
80007780:	819fc0ef          	jal	ra,80003f98 <move_window.part.6>
							fs->last_clst = cl - 1;		/* Reuse the cluster hole */
80007784:	01c12783          	lw	a5,28(sp)
80007788:	0097aa23          	sw	s1,20(a5)
		if (res == FR_OK) {
8000778c:	d60518e3          	bnez	a0,800074fc <f_open+0xd8>
80007790:	00078693          	mv	a3,a5
80007794:	d8dff06f          	j	80007520 <f_open+0xfc>
					if (clst == 0xFFFFFFFF) res = FR_DISK_ERR;
80007798:	00100913          	li	s2,1
				fp->clust = clst;
8000779c:	04b42023          	sw	a1,64(s0)
				if (res == FR_OK && ofs % SS(fs)) {	/* Fill sector buffer if not on the sector boundary */
800077a0:	cd9ff06f          	j	80007478 <f_open+0x54>
				fp->obj.c_size = ((DWORD)dj.obj.objsize & 0xFFFFFF00) | dj.obj.stat;
800077a4:	03012783          	lw	a5,48(sp)
800077a8:	02714703          	lbu	a4,39(sp)
				init_alloc_info(fs, &fp->obj);
800077ac:	0106a503          	lw	a0,16(a3)
				fp->obj.c_size = ((DWORD)dj.obj.objsize & 0xFFFFFF00) | dj.obj.stat;
800077b0:	f007f793          	andi	a5,a5,-256
800077b4:	00e7e7b3          	or	a5,a5,a4
800077b8:	02f42223          	sw	a5,36(s0)
				fp->obj.c_scl = dj.obj.sclust;							/* Get containing directory info */
800077bc:	02812703          	lw	a4,40(sp)
				fp->obj.c_ofs = dj.blk_ofs;
800077c0:	06c12783          	lw	a5,108(sp)
				init_alloc_info(fs, &fp->obj);
800077c4:	00040593          	mv	a1,s0
				fp->obj.c_scl = dj.obj.sclust;							/* Get containing directory info */
800077c8:	02e42023          	sw	a4,32(s0)
				fp->obj.c_ofs = dj.blk_ofs;
800077cc:	02f42423          	sw	a5,40(s0)
				init_alloc_info(fs, &fp->obj);
800077d0:	c54fc0ef          	jal	ra,80003c24 <init_alloc_info.isra.4>
800077d4:	01c12683          	lw	a3,28(sp)
800077d8:	dd5ff06f          	j	800075ac <f_open+0x188>
			if (res == FR_OK && (mode & FA_CREATE_ALWAYS)) {	/* Truncate the file if overwrite mode */
800077dc:	01c12783          	lw	a5,28(sp)
800077e0:	0084f493          	andi	s1,s1,8
800077e4:	00078693          	mv	a3,a5
800077e8:	d40482e3          	beqz	s1,8000752c <f_open+0x108>
800077ec:	ea5ff06f          	j	80007690 <f_open+0x26c>
				for (ofs = fp->obj.objsize; res == FR_OK && ofs > bcs; ofs -= bcs) {
800077f0:	e4fb68e3          	bltu	s6,a5,80007640 <f_open+0x21c>
				fp->clust = clst;
800077f4:	04b42023          	sw	a1,64(s0)
				if (res == FR_OK && ofs % SS(fs)) {	/* Fill sector buffer if not on the sector boundary */
800077f8:	1ff4f793          	andi	a5,s1,511
800077fc:	c80780e3          	beqz	a5,8000747c <f_open+0x58>
					sc = clst2sect(fs, clst);
80007800:	01c12a83          	lw	s5,28(sp)
	clst -= 2;		/* Cluster number is origin from 2 */
80007804:	ffe58593          	addi	a1,a1,-2
	if (clst >= fs->n_fatent - 2) return 0;		/* Is it invalid cluster number? */
80007808:	01caa783          	lw	a5,28(s5)
8000780c:	ffe78793          	addi	a5,a5,-2
80007810:	00f5fc63          	bgeu	a1,a5,80007828 <f_open+0x404>
	return fs->database + (LBA_t)fs->csize * clst;	/* Start sector number of the cluster */
80007814:	00aad503          	lhu	a0,10(s5)
80007818:	18c060ef          	jal	ra,8000d9a4 <__mulsi3>
8000781c:	030aa783          	lw	a5,48(s5)
80007820:	00f50533          	add	a0,a0,a5
					if (sc == 0) {
80007824:	00051663          	bnez	a0,80007830 <f_open+0x40c>
80007828:	00200913          	li	s2,2
8000782c:	c4dff06f          	j	80007478 <f_open+0x54>
						fp->sect = sc + (DWORD)(ofs / SS(fs));
80007830:	01799993          	slli	s3,s3,0x17
80007834:	0094d493          	srli	s1,s1,0x9
80007838:	0099e4b3          	or	s1,s3,s1
8000783c:	00950633          	add	a2,a0,s1
80007840:	04c42223          	sw	a2,68(s0)
						if (disk_read(fs->pdrv, fp->buf, fp->sect, 1) != RES_OK) res = FR_DISK_ERR;
80007844:	001ac503          	lbu	a0,1(s5)
80007848:	00100693          	li	a3,1
8000784c:	000a0593          	mv	a1,s4
80007850:	ca9fb0ef          	jal	ra,800034f8 <disk_read>
80007854:	c20504e3          	beqz	a0,8000747c <f_open+0x58>
80007858:	00100913          	li	s2,1
8000785c:	c1dff06f          	j	80007478 <f_open+0x54>
					init_alloc_info(fs, &fp->obj);
80007860:	0107a503          	lw	a0,16(a5)
80007864:	00040593          	mv	a1,s0
					fp->obj.fs = fs;
80007868:	00f42023          	sw	a5,0(s0)
					init_alloc_info(fs, &fp->obj);
8000786c:	bb8fc0ef          	jal	ra,80003c24 <init_alloc_info.isra.4>
					memset(fs->dirbuf + 2, 0, 30);	/* Clear 85 entry except for NumSec */
80007870:	01c12783          	lw	a5,28(sp)
80007874:	01e00613          	li	a2,30
80007878:	00000593          	li	a1,0
8000787c:	0107a503          	lw	a0,16(a5)
80007880:	00250513          	addi	a0,a0,2
80007884:	e9dfa0ef          	jal	ra,80002720 <memset>
					memset(fs->dirbuf + 38, 0, 26);	/* Clear C0 entry except for NumName and NameHash */
80007888:	01c12783          	lw	a5,28(sp)
8000788c:	01a00613          	li	a2,26
80007890:	00000593          	li	a1,0
80007894:	0107a503          	lw	a0,16(a5)
80007898:	02650513          	addi	a0,a0,38
8000789c:	e85fa0ef          	jal	ra,80002720 <memset>
					fs->dirbuf[XDIR_Attr] = AM_ARC;
800078a0:	01c12703          	lw	a4,28(sp)
800078a4:	02000693          	li	a3,32
					res = store_xdir(&dj);
800078a8:	02010513          	addi	a0,sp,32
					fs->dirbuf[XDIR_Attr] = AM_ARC;
800078ac:	01072783          	lw	a5,16(a4)
800078b0:	00d78223          	sb	a3,4(a5)
					st_dword(fs->dirbuf + XDIR_CrtTime, GET_FATTIME());
800078b4:	01072783          	lw	a5,16(a4)
	*ptr++ = (BYTE)val; val >>= 8;
800078b8:	03500693          	li	a3,53
800078bc:	00d78523          	sb	a3,10(a5)
	*ptr++ = (BYTE)val;
800078c0:	05800693          	li	a3,88
	*ptr++ = (BYTE)val; val >>= 8;
800078c4:	00078423          	sb	zero,8(a5)
	*ptr++ = (BYTE)val; val >>= 8;
800078c8:	000784a3          	sb	zero,9(a5)
	*ptr++ = (BYTE)val;
800078cc:	00d785a3          	sb	a3,11(a5)
					fs->dirbuf[XDIR_GenFlags] = 1;
800078d0:	01072783          	lw	a5,16(a4)
800078d4:	00100713          	li	a4,1
800078d8:	02e780a3          	sb	a4,33(a5)
					res = store_xdir(&dj);
800078dc:	e64fe0ef          	jal	ra,80005f40 <store_xdir>
					if (res == FR_OK && fp->obj.sclust != 0) {	/* Remove the cluster chain if exist */
800078e0:	c0051ee3          	bnez	a0,800074fc <f_open+0xd8>
800078e4:	00842583          	lw	a1,8(s0)
800078e8:	c2058ae3          	beqz	a1,8000751c <f_open+0xf8>
						res = remove_chain(&fp->obj, fp->obj.sclust, 0);
800078ec:	00000613          	li	a2,0
800078f0:	00040513          	mv	a0,s0
800078f4:	8bcfd0ef          	jal	ra,800049b0 <remove_chain>
						fs->last_clst = fp->obj.sclust - 1;		/* Reuse the cluster hole */
800078f8:	00842703          	lw	a4,8(s0)
800078fc:	01c12783          	lw	a5,28(sp)
80007900:	fff70713          	addi	a4,a4,-1
80007904:	00e7aa23          	sw	a4,20(a5)
80007908:	e85ff06f          	j	8000778c <f_open+0x368>
				for (ofs = fp->obj.objsize; res == FR_OK && ofs > bcs; ofs -= bcs) {
8000790c:	d09b68e3          	bltu	s6,s1,8000761c <f_open+0x1f8>
80007910:	ee5ff06f          	j	800077f4 <f_open+0x3d0>
							fs->last_clst = cl - 1;		/* Reuse the cluster hole */
80007914:	0096aa23          	sw	s1,20(a3)
		if (res == FR_OK) {
80007918:	c09ff06f          	j	80007520 <f_open+0xfc>

8000791c <f_read>:
	FIL* fp, 	/* Open file to be read */
	void* buff,	/* Data buffer to store the read data */
	UINT btr,	/* Number of bytes to read */
	UINT* br	/* Number of bytes read */
)
{
8000791c:	fb010113          	addi	sp,sp,-80
80007920:	04812423          	sw	s0,72(sp)
80007924:	05212023          	sw	s2,64(sp)
80007928:	03312e23          	sw	s3,60(sp)
8000792c:	03812423          	sw	s8,40(sp)
80007930:	03912223          	sw	s9,36(sp)
80007934:	04112623          	sw	ra,76(sp)
80007938:	04912223          	sw	s1,68(sp)
8000793c:	03412c23          	sw	s4,56(sp)
80007940:	03512a23          	sw	s5,52(sp)
80007944:	03612823          	sw	s6,48(sp)
80007948:	03712623          	sw	s7,44(sp)
8000794c:	03a12023          	sw	s10,32(sp)
80007950:	01b12e23          	sw	s11,28(sp)
80007954:	00058993          	mv	s3,a1
	FSIZE_t remain;
	UINT rcnt, cc, csect;
	BYTE *rbuff = (BYTE*)buff;


	*br = 0;	/* Clear read byte counter */
80007958:	0006a023          	sw	zero,0(a3)
	res = validate(&fp->obj, &fs);				/* Check validity of the file object */
8000795c:	00c10593          	addi	a1,sp,12
{
80007960:	00068913          	mv	s2,a3
80007964:	00050413          	mv	s0,a0
80007968:	00060c13          	mv	s8,a2
	res = validate(&fp->obj, &fs);				/* Check validity of the file object */
8000796c:	c99fb0ef          	jal	ra,80003604 <validate>
80007970:	00050c93          	mv	s9,a0
	if (res != FR_OK || (res = (FRESULT)fp->err) != FR_OK) LEAVE_FF(fs, res);	/* Check validity */
80007974:	0e051063          	bnez	a0,80007a54 <f_read+0x138>
80007978:	03144c83          	lbu	s9,49(s0)
8000797c:	0c0c9c63          	bnez	s9,80007a54 <f_read+0x138>
	if (!(fp->flag & FA_READ)) LEAVE_FF(fs, FR_DENIED); /* Check access mode */
80007980:	03044783          	lbu	a5,48(s0)
80007984:	0017f793          	andi	a5,a5,1
80007988:	0c078463          	beqz	a5,80007a50 <f_read+0x134>
	remain = fp->obj.objsize - fp->fptr;
8000798c:	01042683          	lw	a3,16(s0)
80007990:	03842783          	lw	a5,56(s0)
80007994:	03c42703          	lw	a4,60(s0)
80007998:	01442603          	lw	a2,20(s0)
8000799c:	40f685b3          	sub	a1,a3,a5
800079a0:	00b6b6b3          	sltu	a3,a3,a1
800079a4:	40e60633          	sub	a2,a2,a4
	if (btr > remain) btr = (UINT)remain;		/* Truncate btr by remaining bytes */
800079a8:	1ad60c63          	beq	a2,a3,80007b60 <f_read+0x244>

	for ( ; btr > 0; btr -= rcnt, *br += rcnt, rbuff += rcnt, fp->fptr += rcnt) {	/* Repeat until btr bytes read */
800079ac:	0a0c0463          	beqz	s8,80007a54 <f_read+0x138>
				if (disk_read(fs->pdrv, fp->buf, sect, 1) != RES_OK) ABORT(fs, FR_DISK_ERR);	/* Fill sector cache */
			}
#endif
			fp->sect = sect;
		}
		rcnt = SS(fs) - (UINT)fp->fptr % SS(fs);	/* Number of bytes remains in the sector */
800079b0:	20000a93          	li	s5,512
800079b4:	05040a13          	addi	s4,s0,80
		if (fp->fptr % SS(fs) == 0) {			/* On the sector boundary? */
800079b8:	1ff7f593          	andi	a1,a5,511
800079bc:	10059663          	bnez	a1,80007ac8 <f_read+0x1ac>
			csect = (UINT)(fp->fptr / SS(fs) & (fs->csize - 1));	/* Sector offset in the cluster */
800079c0:	00c12d83          	lw	s11,12(sp)
800079c4:	01771613          	slli	a2,a4,0x17
800079c8:	0097d693          	srli	a3,a5,0x9
800079cc:	00addd03          	lhu	s10,10(s11)
800079d0:	00d666b3          	or	a3,a2,a3
800079d4:	fffd0d13          	addi	s10,s10,-1
800079d8:	00dd7d33          	and	s10,s10,a3
			if (csect == 0) {					/* On the cluster boundary? */
800079dc:	140d0063          	beqz	s10,80007b1c <f_read+0x200>
800079e0:	04042503          	lw	a0,64(s0)
	if (clst >= fs->n_fatent - 2) return 0;		/* Is it invalid cluster number? */
800079e4:	01cda783          	lw	a5,28(s11)
	clst -= 2;		/* Cluster number is origin from 2 */
800079e8:	ffe50513          	addi	a0,a0,-2
	if (clst >= fs->n_fatent - 2) return 0;		/* Is it invalid cluster number? */
800079ec:	ffe78793          	addi	a5,a5,-2
800079f0:	16f57063          	bgeu	a0,a5,80007b50 <f_read+0x234>
	return fs->database + (LBA_t)fs->csize * clst;	/* Start sector number of the cluster */
800079f4:	00addb03          	lhu	s6,10(s11)
800079f8:	000b0593          	mv	a1,s6
800079fc:	7a9050ef          	jal	ra,8000d9a4 <__mulsi3>
80007a00:	030da783          	lw	a5,48(s11)
80007a04:	00f50533          	add	a0,a0,a5
			if (sect == 0) ABORT(fs, FR_INT_ERR);
80007a08:	14050463          	beqz	a0,80007b50 <f_read+0x234>
			if (cc > 0) {						/* Read maximum contiguous sectors directly */
80007a0c:	1ff00793          	li	a5,511
			sect += csect;
80007a10:	00ad0bb3          	add	s7,s10,a0
			if (cc > 0) {						/* Read maximum contiguous sectors directly */
80007a14:	0987f063          	bgeu	a5,s8,80007a94 <f_read+0x178>
			cc = btr / SS(fs);					/* When remaining bytes >= sector size, */
80007a18:	009c5493          	srli	s1,s8,0x9
				if (csect + cc > fs->csize) {	/* Clip at cluster boundary */
80007a1c:	009d07b3          	add	a5,s10,s1
80007a20:	00fb7463          	bgeu	s6,a5,80007a28 <f_read+0x10c>
					cc = fs->csize - csect;
80007a24:	41ab04b3          	sub	s1,s6,s10
				if (disk_read(fs->pdrv, rbuff, sect, cc) != RES_OK) ABORT(fs, FR_DISK_ERR);
80007a28:	001dc503          	lbu	a0,1(s11)
80007a2c:	00048693          	mv	a3,s1
80007a30:	000b8613          	mv	a2,s7
80007a34:	00098593          	mv	a1,s3
80007a38:	ac1fb0ef          	jal	ra,800034f8 <disk_read>
80007a3c:	14051863          	bnez	a0,80007b8c <f_read+0x270>
				if ((fp->flag & FA_DIRTY) && fp->sect - sect < cc) {
80007a40:	03040783          	lb	a5,48(s0)
80007a44:	1607c863          	bltz	a5,80007bb4 <f_read+0x298>
				rcnt = SS(fs) * cc;				/* Number of bytes transferred */
80007a48:	00949493          	slli	s1,s1,0x9
				continue;
80007a4c:	0980006f          	j	80007ae4 <f_read+0x1c8>
	if (!(fp->flag & FA_READ)) LEAVE_FF(fs, FR_DENIED); /* Check access mode */
80007a50:	00700c93          	li	s9,7
		memcpy(rbuff, fp->buf + fp->fptr % SS(fs), rcnt);	/* Extract partial sector */
#endif
	}

	LEAVE_FF(fs, FR_OK);
}
80007a54:	04c12083          	lw	ra,76(sp)
80007a58:	04812403          	lw	s0,72(sp)
80007a5c:	000c8513          	mv	a0,s9
80007a60:	04412483          	lw	s1,68(sp)
80007a64:	04012903          	lw	s2,64(sp)
80007a68:	03c12983          	lw	s3,60(sp)
80007a6c:	03812a03          	lw	s4,56(sp)
80007a70:	03412a83          	lw	s5,52(sp)
80007a74:	03012b03          	lw	s6,48(sp)
80007a78:	02c12b83          	lw	s7,44(sp)
80007a7c:	02812c03          	lw	s8,40(sp)
80007a80:	02412c83          	lw	s9,36(sp)
80007a84:	02012d03          	lw	s10,32(sp)
80007a88:	01c12d83          	lw	s11,28(sp)
80007a8c:	05010113          	addi	sp,sp,80
80007a90:	00008067          	ret
			if (fp->sect != sect) {			/* Load data sector if not in cache */
80007a94:	04442603          	lw	a2,68(s0)
80007a98:	03760263          	beq	a2,s7,80007abc <f_read+0x1a0>
				if (fp->flag & FA_DIRTY) {		/* Write-back dirty sector cache */
80007a9c:	03040783          	lb	a5,48(s0)
80007aa0:	001dc503          	lbu	a0,1(s11)
80007aa4:	0c07cc63          	bltz	a5,80007b7c <f_read+0x260>
				if (disk_read(fs->pdrv, fp->buf, sect, 1) != RES_OK) ABORT(fs, FR_DISK_ERR);	/* Fill sector cache */
80007aa8:	00100693          	li	a3,1
80007aac:	000b8613          	mv	a2,s7
80007ab0:	000a0593          	mv	a1,s4
80007ab4:	a45fb0ef          	jal	ra,800034f8 <disk_read>
80007ab8:	0c051a63          	bnez	a0,80007b8c <f_read+0x270>
			fp->sect = sect;
80007abc:	03842783          	lw	a5,56(s0)
80007ac0:	05742223          	sw	s7,68(s0)
80007ac4:	1ff7f593          	andi	a1,a5,511
		rcnt = SS(fs) - (UINT)fp->fptr % SS(fs);	/* Number of bytes remains in the sector */
80007ac8:	40ba84b3          	sub	s1,s5,a1
		if (rcnt > btr) rcnt = btr;					/* Clip it by btr if needed */
80007acc:	009c7463          	bgeu	s8,s1,80007ad4 <f_read+0x1b8>
80007ad0:	000c0493          	mv	s1,s8
		memcpy(rbuff, fp->buf + fp->fptr % SS(fs), rcnt);	/* Extract partial sector */
80007ad4:	00048613          	mv	a2,s1
80007ad8:	00ba05b3          	add	a1,s4,a1
80007adc:	00098513          	mv	a0,s3
80007ae0:	bc9fa0ef          	jal	ra,800026a8 <memcpy>
	for ( ; btr > 0; btr -= rcnt, *br += rcnt, rbuff += rcnt, fp->fptr += rcnt) {	/* Repeat until btr bytes read */
80007ae4:	03842783          	lw	a5,56(s0)
80007ae8:	00092683          	lw	a3,0(s2)
80007aec:	03c42603          	lw	a2,60(s0)
80007af0:	00f487b3          	add	a5,s1,a5
80007af4:	009686b3          	add	a3,a3,s1
80007af8:	0097b733          	sltu	a4,a5,s1
80007afc:	00d92023          	sw	a3,0(s2)
80007b00:	00c70733          	add	a4,a4,a2
80007b04:	409c0c33          	sub	s8,s8,s1
80007b08:	02f42c23          	sw	a5,56(s0)
80007b0c:	02e42e23          	sw	a4,60(s0)
80007b10:	009989b3          	add	s3,s3,s1
80007b14:	ea0c12e3          	bnez	s8,800079b8 <f_read+0x9c>
80007b18:	f3dff06f          	j	80007a54 <f_read+0x138>
				if (fp->fptr == 0) {			/* On the top of the file? */
80007b1c:	00e7e7b3          	or	a5,a5,a4
80007b20:	04079663          	bnez	a5,80007b6c <f_read+0x250>
					clst = fp->obj.sclust;		/* Follow cluster chain from the origin */
80007b24:	00842503          	lw	a0,8(s0)
				if (clst < 2) ABORT(fs, FR_INT_ERR);
80007b28:	00100793          	li	a5,1
80007b2c:	02a7f263          	bgeu	a5,a0,80007b50 <f_read+0x234>
				if (clst == 0xFFFFFFFF) ABORT(fs, FR_DISK_ERR);
80007b30:	fff00793          	li	a5,-1
80007b34:	04f50c63          	beq	a0,a5,80007b8c <f_read+0x270>
				fp->clust = clst;				/* Update current cluster */
80007b38:	00c12d83          	lw	s11,12(sp)
80007b3c:	04a42023          	sw	a0,64(s0)
	clst -= 2;		/* Cluster number is origin from 2 */
80007b40:	ffe50513          	addi	a0,a0,-2
	if (clst >= fs->n_fatent - 2) return 0;		/* Is it invalid cluster number? */
80007b44:	01cda783          	lw	a5,28(s11)
80007b48:	ffe78793          	addi	a5,a5,-2
80007b4c:	eaf564e3          	bltu	a0,a5,800079f4 <f_read+0xd8>
				if (clst < 2) ABORT(fs, FR_INT_ERR);
80007b50:	00200793          	li	a5,2
80007b54:	02f408a3          	sb	a5,49(s0)
80007b58:	00200c93          	li	s9,2
80007b5c:	ef9ff06f          	j	80007a54 <f_read+0x138>
	if (btr > remain) btr = (UINT)remain;		/* Truncate btr by remaining bytes */
80007b60:	e585f6e3          	bgeu	a1,s8,800079ac <f_read+0x90>
80007b64:	00058c13          	mv	s8,a1
80007b68:	e45ff06f          	j	800079ac <f_read+0x90>
						clst = get_fat(&fp->obj, fp->clust);	/* Follow cluster chain on the FAT */
80007b6c:	04042583          	lw	a1,64(s0)
80007b70:	00040513          	mv	a0,s0
80007b74:	fbcfc0ef          	jal	ra,80004330 <get_fat>
80007b78:	fb1ff06f          	j	80007b28 <f_read+0x20c>
					if (disk_write(fs->pdrv, fp->buf, fp->sect, 1) != RES_OK) ABORT(fs, FR_DISK_ERR);
80007b7c:	00100693          	li	a3,1
80007b80:	000a0593          	mv	a1,s4
80007b84:	9b5fb0ef          	jal	ra,80003538 <disk_write>
80007b88:	00050a63          	beqz	a0,80007b9c <f_read+0x280>
				if (clst == 0xFFFFFFFF) ABORT(fs, FR_DISK_ERR);
80007b8c:	00100793          	li	a5,1
80007b90:	02f408a3          	sb	a5,49(s0)
80007b94:	00100c93          	li	s9,1
80007b98:	ebdff06f          	j	80007a54 <f_read+0x138>
					fp->flag &= (BYTE)~FA_DIRTY;
80007b9c:	03044783          	lbu	a5,48(s0)
80007ba0:	07f7f793          	andi	a5,a5,127
80007ba4:	02f40823          	sb	a5,48(s0)
80007ba8:	00c12783          	lw	a5,12(sp)
80007bac:	0017c503          	lbu	a0,1(a5)
80007bb0:	ef9ff06f          	j	80007aa8 <f_read+0x18c>
				if ((fp->flag & FA_DIRTY) && fp->sect - sect < cc) {
80007bb4:	04442503          	lw	a0,68(s0)
80007bb8:	41750533          	sub	a0,a0,s7
80007bbc:	e89576e3          	bgeu	a0,s1,80007a48 <f_read+0x12c>
					memcpy(rbuff + ((fp->sect - sect) * SS(fs)), fp->buf, SS(fs));
80007bc0:	00951513          	slli	a0,a0,0x9
80007bc4:	20000613          	li	a2,512
80007bc8:	000a0593          	mv	a1,s4
80007bcc:	00a98533          	add	a0,s3,a0
80007bd0:	ad9fa0ef          	jal	ra,800026a8 <memcpy>
				rcnt = SS(fs) * cc;				/* Number of bytes transferred */
80007bd4:	00949493          	slli	s1,s1,0x9
				continue;
80007bd8:	f0dff06f          	j	80007ae4 <f_read+0x1c8>

80007bdc <f_write>:
	FIL* fp,			/* Open file to be written */
	const void* buff,	/* Data to be written */
	UINT btw,			/* Number of bytes to write */
	UINT* bw			/* Number of bytes written */
)
{
80007bdc:	fb010113          	addi	sp,sp,-80
80007be0:	04812423          	sw	s0,72(sp)
80007be4:	05212023          	sw	s2,64(sp)
80007be8:	03312e23          	sw	s3,60(sp)
80007bec:	03412c23          	sw	s4,56(sp)
80007bf0:	03912223          	sw	s9,36(sp)
80007bf4:	04112623          	sw	ra,76(sp)
80007bf8:	04912223          	sw	s1,68(sp)
80007bfc:	03512a23          	sw	s5,52(sp)
80007c00:	03612823          	sw	s6,48(sp)
80007c04:	03712623          	sw	s7,44(sp)
80007c08:	03812423          	sw	s8,40(sp)
80007c0c:	03a12023          	sw	s10,32(sp)
80007c10:	01b12e23          	sw	s11,28(sp)
80007c14:	00058a13          	mv	s4,a1
	LBA_t sect;
	UINT wcnt, cc, csect;
	const BYTE *wbuff = (const BYTE*)buff;


	*bw = 0;	/* Clear write byte counter */
80007c18:	0006a023          	sw	zero,0(a3)
	res = validate(&fp->obj, &fs);			/* Check validity of the file object */
80007c1c:	00c10593          	addi	a1,sp,12
{
80007c20:	00068993          	mv	s3,a3
80007c24:	00050413          	mv	s0,a0
80007c28:	00060913          	mv	s2,a2
	res = validate(&fp->obj, &fs);			/* Check validity of the file object */
80007c2c:	9d9fb0ef          	jal	ra,80003604 <validate>
80007c30:	00050c93          	mv	s9,a0
	if (res != FR_OK || (res = (FRESULT)fp->err) != FR_OK) LEAVE_FF(fs, res);	/* Check validity */
80007c34:	12051e63          	bnez	a0,80007d70 <f_write+0x194>
80007c38:	03144c83          	lbu	s9,49(s0)
80007c3c:	120c9a63          	bnez	s9,80007d70 <f_write+0x194>
	if (!(fp->flag & FA_WRITE)) LEAVE_FF(fs, FR_DENIED);	/* Check access mode */
80007c40:	03044783          	lbu	a5,48(s0)
80007c44:	0027f713          	andi	a4,a5,2
80007c48:	26070863          	beqz	a4,80007eb8 <f_write+0x2dc>

	/* Check fptr wrap-around (file size cannot reach 4 GiB at FAT volume) */
	if ((!FF_FS_EXFAT || fs->fs_type != FS_EXFAT) && (DWORD)(fp->fptr + btw) < (DWORD)fp->fptr) {
80007c4c:	00c12683          	lw	a3,12(sp)
80007c50:	00400713          	li	a4,4
80007c54:	0006c683          	lbu	a3,0(a3)
80007c58:	00e68863          	beq	a3,a4,80007c68 <f_write+0x8c>
80007c5c:	03842703          	lw	a4,56(s0)
80007c60:	012706b3          	add	a3,a4,s2
80007c64:	20e6e863          	bltu	a3,a4,80007e74 <f_write+0x298>
		btw = (UINT)(0xFFFFFFFF - (DWORD)fp->fptr);
	}

	for ( ; btw > 0; btw -= wcnt, *bw += wcnt, wbuff += wcnt, fp->fptr += wcnt, fp->obj.objsize = (fp->fptr > fp->obj.objsize) ? fp->fptr : fp->obj.objsize) {	/* Repeat until all data written */
80007c68:	10090063          	beqz	s2,80007d68 <f_write+0x18c>
80007c6c:	03842683          	lw	a3,56(s0)
80007c70:	03c42583          	lw	a1,60(s0)
					ABORT(fs, FR_DISK_ERR);
			}
#endif
			fp->sect = sect;
		}
		wcnt = SS(fs) - (UINT)fp->fptr % SS(fs);	/* Number of bytes remains in the sector */
80007c74:	20000b13          	li	s6,512
80007c78:	05040a93          	addi	s5,s0,80
		if (fp->fptr % SS(fs) == 0) {		/* On the sector boundary? */
80007c7c:	1ff6f513          	andi	a0,a3,511
80007c80:	14051a63          	bnez	a0,80007dd4 <f_write+0x1f8>
			csect = (UINT)(fp->fptr / SS(fs)) & (fs->csize - 1);	/* Sector offset in the cluster */
80007c84:	00c12c03          	lw	s8,12(sp)
80007c88:	01759613          	slli	a2,a1,0x17
80007c8c:	0096d793          	srli	a5,a3,0x9
80007c90:	00ac5d03          	lhu	s10,10(s8)
80007c94:	00f667b3          	or	a5,a2,a5
80007c98:	fffd0d13          	addi	s10,s10,-1
80007c9c:	00fd7d33          	and	s10,s10,a5
			if (csect == 0) {				/* On the cluster boundary? */
80007ca0:	020d1c63          	bnez	s10,80007cd8 <f_write+0xfc>
				if (fp->fptr == 0) {		/* On the top of the file? */
80007ca4:	00b6e6b3          	or	a3,a3,a1
80007ca8:	0a069663          	bnez	a3,80007d54 <f_write+0x178>
					clst = fp->obj.sclust;	/* Follow from the origin */
80007cac:	00842503          	lw	a0,8(s0)
					if (clst == 0) {		/* If no cluster is allocated, */
80007cb0:	20050863          	beqz	a0,80007ec0 <f_write+0x2e4>
				if (clst == 1) ABORT(fs, FR_INT_ERR);
80007cb4:	00100793          	li	a5,1
80007cb8:	1af50663          	beq	a0,a5,80007e64 <f_write+0x288>
				if (clst == 0xFFFFFFFF) ABORT(fs, FR_DISK_ERR);
80007cbc:	fff00793          	li	a5,-1
80007cc0:	1ef50463          	beq	a0,a5,80007ea8 <f_write+0x2cc>
				if (fp->obj.sclust == 0) fp->obj.sclust = clst;	/* Set start cluster if the first write */
80007cc4:	00842783          	lw	a5,8(s0)
				fp->clust = clst;			/* Update current cluster */
80007cc8:	04a42023          	sw	a0,64(s0)
				if (fp->obj.sclust == 0) fp->obj.sclust = clst;	/* Set start cluster if the first write */
80007ccc:	00c12c03          	lw	s8,12(sp)
80007cd0:	00079463          	bnez	a5,80007cd8 <f_write+0xfc>
80007cd4:	00a42423          	sw	a0,8(s0)
			if (fp->flag & FA_DIRTY) {		/* Write-back sector cache */
80007cd8:	03040783          	lb	a5,48(s0)
80007cdc:	1a07c063          	bltz	a5,80007e7c <f_write+0x2a0>
	clst -= 2;		/* Cluster number is origin from 2 */
80007ce0:	04042503          	lw	a0,64(s0)
	if (clst >= fs->n_fatent - 2) return 0;		/* Is it invalid cluster number? */
80007ce4:	01cc2783          	lw	a5,28(s8)
	clst -= 2;		/* Cluster number is origin from 2 */
80007ce8:	ffe50513          	addi	a0,a0,-2
	if (clst >= fs->n_fatent - 2) return 0;		/* Is it invalid cluster number? */
80007cec:	ffe78793          	addi	a5,a5,-2
80007cf0:	16f57a63          	bgeu	a0,a5,80007e64 <f_write+0x288>
	return fs->database + (LBA_t)fs->csize * clst;	/* Start sector number of the cluster */
80007cf4:	00ac5b83          	lhu	s7,10(s8)
80007cf8:	000b8593          	mv	a1,s7
80007cfc:	4a9050ef          	jal	ra,8000d9a4 <__mulsi3>
80007d00:	030c2583          	lw	a1,48(s8)
80007d04:	00b50533          	add	a0,a0,a1
			if (sect == 0) ABORT(fs, FR_INT_ERR);
80007d08:	14050e63          	beqz	a0,80007e64 <f_write+0x288>
			if (cc > 0) {					/* Write maximum contiguous sectors directly */
80007d0c:	1ff00793          	li	a5,511
			sect += csect;
80007d10:	00ad0db3          	add	s11,s10,a0
			if (cc > 0) {					/* Write maximum contiguous sectors directly */
80007d14:	0927fe63          	bgeu	a5,s2,80007db0 <f_write+0x1d4>
			cc = btw / SS(fs);				/* When remaining bytes >= sector size, */
80007d18:	00995493          	srli	s1,s2,0x9
				if (csect + cc > fs->csize) {	/* Clip at cluster boundary */
80007d1c:	009d06b3          	add	a3,s10,s1
80007d20:	00dbf463          	bgeu	s7,a3,80007d28 <f_write+0x14c>
					cc = fs->csize - csect;
80007d24:	41ab84b3          	sub	s1,s7,s10
				if (disk_write(fs->pdrv, wbuff, sect, cc) != RES_OK) ABORT(fs, FR_DISK_ERR);
80007d28:	001c4503          	lbu	a0,1(s8)
80007d2c:	00048693          	mv	a3,s1
80007d30:	000d8613          	mv	a2,s11
80007d34:	000a0593          	mv	a1,s4
80007d38:	801fb0ef          	jal	ra,80003538 <disk_write>
80007d3c:	16051663          	bnez	a0,80007ea8 <f_write+0x2cc>
				if (fp->sect - sect < cc) { /* Refill sector cache if it gets invalidated by the direct write */
80007d40:	04442503          	lw	a0,68(s0)
80007d44:	41b50533          	sub	a0,a0,s11
80007d48:	18956663          	bltu	a0,s1,80007ed4 <f_write+0x2f8>
				wcnt = SS(fs) * cc;		/* Number of bytes transferred */
80007d4c:	00949493          	slli	s1,s1,0x9
				continue;
80007d50:	0ac0006f          	j	80007dfc <f_write+0x220>
						clst = create_chain(&fp->obj, fp->clust);	/* Follow or stretch cluster chain on the FAT */
80007d54:	04042583          	lw	a1,64(s0)
80007d58:	00040513          	mv	a0,s0
80007d5c:	8d1fd0ef          	jal	ra,8000562c <create_chain>
				if (clst == 0) break;		/* Could not allocate a new cluster (disk full) */
80007d60:	f4051ae3          	bnez	a0,80007cb4 <f_write+0xd8>
80007d64:	03044783          	lbu	a5,48(s0)
		memcpy(fp->buf + fp->fptr % SS(fs), wbuff, wcnt);	/* Fit data to the sector */
		fp->flag |= FA_DIRTY;
#endif
	}

	fp->flag |= FA_MODIFIED;				/* Set file change flag */
80007d68:	0407e793          	ori	a5,a5,64
80007d6c:	02f40823          	sb	a5,48(s0)

	LEAVE_FF(fs, FR_OK);
}
80007d70:	04c12083          	lw	ra,76(sp)
80007d74:	04812403          	lw	s0,72(sp)
80007d78:	000c8513          	mv	a0,s9
80007d7c:	04412483          	lw	s1,68(sp)
80007d80:	04012903          	lw	s2,64(sp)
80007d84:	03c12983          	lw	s3,60(sp)
80007d88:	03812a03          	lw	s4,56(sp)
80007d8c:	03412a83          	lw	s5,52(sp)
80007d90:	03012b03          	lw	s6,48(sp)
80007d94:	02c12b83          	lw	s7,44(sp)
80007d98:	02812c03          	lw	s8,40(sp)
80007d9c:	02412c83          	lw	s9,36(sp)
80007da0:	02012d03          	lw	s10,32(sp)
80007da4:	01c12d83          	lw	s11,28(sp)
80007da8:	05010113          	addi	sp,sp,80
80007dac:	00008067          	ret
			if (fp->sect != sect && 		/* Fill sector cache with file data */
80007db0:	04442783          	lw	a5,68(s0)
80007db4:	03842683          	lw	a3,56(s0)
80007db8:	03c42583          	lw	a1,60(s0)
80007dbc:	01b78863          	beq	a5,s11,80007dcc <f_write+0x1f0>
80007dc0:	01442783          	lw	a5,20(s0)
80007dc4:	14f5e063          	bltu	a1,a5,80007f04 <f_write+0x328>
80007dc8:	12b78a63          	beq	a5,a1,80007efc <f_write+0x320>
			fp->sect = sect;
80007dcc:	05b42223          	sw	s11,68(s0)
80007dd0:	1ff6f513          	andi	a0,a3,511
		wcnt = SS(fs) - (UINT)fp->fptr % SS(fs);	/* Number of bytes remains in the sector */
80007dd4:	40ab04b3          	sub	s1,s6,a0
		if (wcnt > btw) wcnt = btw;					/* Clip it by btw if needed */
80007dd8:	00997463          	bgeu	s2,s1,80007de0 <f_write+0x204>
80007ddc:	00090493          	mv	s1,s2
		memcpy(fp->buf + fp->fptr % SS(fs), wbuff, wcnt);	/* Fit data to the sector */
80007de0:	00048613          	mv	a2,s1
80007de4:	000a0593          	mv	a1,s4
80007de8:	00aa8533          	add	a0,s5,a0
80007dec:	8bdfa0ef          	jal	ra,800026a8 <memcpy>
		fp->flag |= FA_DIRTY;
80007df0:	03044783          	lbu	a5,48(s0)
80007df4:	f807e793          	ori	a5,a5,-128
80007df8:	02f40823          	sb	a5,48(s0)
	for ( ; btw > 0; btw -= wcnt, *bw += wcnt, wbuff += wcnt, fp->fptr += wcnt, fp->obj.objsize = (fp->fptr > fp->obj.objsize) ? fp->fptr : fp->obj.objsize) {	/* Repeat until all data written */
80007dfc:	03842703          	lw	a4,56(s0)
80007e00:	0009a683          	lw	a3,0(s3)
80007e04:	03c42583          	lw	a1,60(s0)
80007e08:	00e48733          	add	a4,s1,a4
80007e0c:	009686b3          	add	a3,a3,s1
80007e10:	009737b3          	sltu	a5,a4,s1
80007e14:	01442603          	lw	a2,20(s0)
80007e18:	00b787b3          	add	a5,a5,a1
80007e1c:	00d9a023          	sw	a3,0(s3)
80007e20:	02e42c23          	sw	a4,56(s0)
80007e24:	02f42e23          	sw	a5,60(s0)
80007e28:	40990933          	sub	s2,s2,s1
80007e2c:	009a0a33          	add	s4,s4,s1
80007e30:	00070693          	mv	a3,a4
80007e34:	00078593          	mv	a1,a5
80007e38:	01042503          	lw	a0,16(s0)
80007e3c:	00f66e63          	bltu	a2,a5,80007e58 <f_write+0x27c>
80007e40:	00c78a63          	beq	a5,a2,80007e54 <f_write+0x278>
80007e44:	00a42823          	sw	a0,16(s0)
80007e48:	00c42a23          	sw	a2,20(s0)
80007e4c:	e20918e3          	bnez	s2,80007c7c <f_write+0xa0>
80007e50:	f15ff06f          	j	80007d64 <f_write+0x188>
80007e54:	fee578e3          	bgeu	a0,a4,80007e44 <f_write+0x268>
80007e58:	00070513          	mv	a0,a4
80007e5c:	00078613          	mv	a2,a5
80007e60:	fe5ff06f          	j	80007e44 <f_write+0x268>
				if (clst == 1) ABORT(fs, FR_INT_ERR);
80007e64:	00200793          	li	a5,2
80007e68:	02f408a3          	sb	a5,49(s0)
80007e6c:	00200c93          	li	s9,2
80007e70:	f01ff06f          	j	80007d70 <f_write+0x194>
		btw = (UINT)(0xFFFFFFFF - (DWORD)fp->fptr);
80007e74:	fff74913          	not	s2,a4
80007e78:	df1ff06f          	j	80007c68 <f_write+0x8c>
				if (disk_write(fs->pdrv, fp->buf, fp->sect, 1) != RES_OK) ABORT(fs, FR_DISK_ERR);
80007e7c:	04442603          	lw	a2,68(s0)
80007e80:	001c4503          	lbu	a0,1(s8)
80007e84:	00100693          	li	a3,1
80007e88:	000a8593          	mv	a1,s5
80007e8c:	eacfb0ef          	jal	ra,80003538 <disk_write>
80007e90:	00051c63          	bnez	a0,80007ea8 <f_write+0x2cc>
				fp->flag &= (BYTE)~FA_DIRTY;
80007e94:	03044783          	lbu	a5,48(s0)
80007e98:	00c12c03          	lw	s8,12(sp)
80007e9c:	07f7f793          	andi	a5,a5,127
80007ea0:	02f40823          	sb	a5,48(s0)
80007ea4:	e3dff06f          	j	80007ce0 <f_write+0x104>
				if (clst == 0xFFFFFFFF) ABORT(fs, FR_DISK_ERR);
80007ea8:	00100793          	li	a5,1
80007eac:	02f408a3          	sb	a5,49(s0)
80007eb0:	00100c93          	li	s9,1
80007eb4:	ebdff06f          	j	80007d70 <f_write+0x194>
	if (!(fp->flag & FA_WRITE)) LEAVE_FF(fs, FR_DENIED);	/* Check access mode */
80007eb8:	00700c93          	li	s9,7
80007ebc:	eb5ff06f          	j	80007d70 <f_write+0x194>
						clst = create_chain(&fp->obj, 0);	/* create a new cluster chain */
80007ec0:	00000593          	li	a1,0
80007ec4:	00040513          	mv	a0,s0
80007ec8:	f64fd0ef          	jal	ra,8000562c <create_chain>
				if (clst == 0) break;		/* Could not allocate a new cluster (disk full) */
80007ecc:	de0514e3          	bnez	a0,80007cb4 <f_write+0xd8>
80007ed0:	e95ff06f          	j	80007d64 <f_write+0x188>
					memcpy(fp->buf, wbuff + ((fp->sect - sect) * SS(fs)), SS(fs));
80007ed4:	00951513          	slli	a0,a0,0x9
80007ed8:	00aa05b3          	add	a1,s4,a0
80007edc:	20000613          	li	a2,512
80007ee0:	000a8513          	mv	a0,s5
80007ee4:	fc4fa0ef          	jal	ra,800026a8 <memcpy>
					fp->flag &= (BYTE)~FA_DIRTY;
80007ee8:	03044783          	lbu	a5,48(s0)
				wcnt = SS(fs) * cc;		/* Number of bytes transferred */
80007eec:	00949493          	slli	s1,s1,0x9
					fp->flag &= (BYTE)~FA_DIRTY;
80007ef0:	07f7f793          	andi	a5,a5,127
80007ef4:	02f40823          	sb	a5,48(s0)
				continue;
80007ef8:	f05ff06f          	j	80007dfc <f_write+0x220>
			if (fp->sect != sect && 		/* Fill sector cache with file data */
80007efc:	01042783          	lw	a5,16(s0)
80007f00:	ecf6f6e3          	bgeu	a3,a5,80007dcc <f_write+0x1f0>
				disk_read(fs->pdrv, fp->buf, sect, 1) != RES_OK) {
80007f04:	001c4503          	lbu	a0,1(s8)
80007f08:	00100693          	li	a3,1
80007f0c:	000d8613          	mv	a2,s11
80007f10:	000a8593          	mv	a1,s5
80007f14:	de4fb0ef          	jal	ra,800034f8 <disk_read>
				fp->fptr < fp->obj.objsize &&
80007f18:	f80518e3          	bnez	a0,80007ea8 <f_write+0x2cc>
80007f1c:	03842683          	lw	a3,56(s0)
80007f20:	eadff06f          	j	80007dcc <f_write+0x1f0>

80007f24 <putc_bfd>:


/* Buffered file write with code conversion */

static void putc_bfd (putbuff* pb, TCHAR c)
{
80007f24:	fd010113          	addi	sp,sp,-48
80007f28:	02912223          	sw	s1,36(sp)
80007f2c:	01312e23          	sw	s3,28(sp)
80007f30:	02112623          	sw	ra,44(sp)
80007f34:	02812423          	sw	s0,40(sp)
80007f38:	03212023          	sw	s2,32(sp)
	DWORD dc;
	const TCHAR* tp;
#endif
#endif

	if (FF_USE_STRFUNC == 2 && c == '\n') {	 /* LF -> CRLF conversion */
80007f3c:	00a00793          	li	a5,10
{
80007f40:	00058993          	mv	s3,a1
80007f44:	00050493          	mv	s1,a0
	if (FF_USE_STRFUNC == 2 && c == '\n') {	 /* LF -> CRLF conversion */
80007f48:	06f58a63          	beq	a1,a5,80007fbc <putc_bfd+0x98>
		putc_bfd(pb, '\r');
	}

	i = pb->idx;			/* Write index of pb->buf[] */
80007f4c:	0044a603          	lw	a2,4(s1)
	if (i < 0) return;		/* In write error? */
80007f50:	02064463          	bltz	a2,80007f78 <putc_bfd+0x54>
	}
	pb->buf[i++] = (BYTE)wc;
#endif

#else							/* ANSI/OEM input (without re-encoding) */
	pb->buf[i++] = (BYTE)c;
80007f54:	00c487b3          	add	a5,s1,a2
	nc = pb->nchr;			/* Write unit counter */
80007f58:	0084a903          	lw	s2,8(s1)
	pb->buf[i++] = (BYTE)c;
80007f5c:	00160413          	addi	s0,a2,1
80007f60:	01378623          	sb	s3,12(a5)
#endif

	if (i >= (int)(sizeof pb->buf) - 4) {	/* Write buffered characters to the file */
80007f64:	03b00793          	li	a5,59
80007f68:	0287c663          	blt	a5,s0,80007f94 <putc_bfd+0x70>
		f_write(pb->fp, pb->buf, (UINT)i, &n);
		i = (n == (UINT)i) ? 0 : -1;
	}
	pb->idx = i;
	pb->nchr = nc + 1;
80007f6c:	00190913          	addi	s2,s2,1
	pb->idx = i;
80007f70:	0084a223          	sw	s0,4(s1)
	pb->nchr = nc + 1;
80007f74:	0124a423          	sw	s2,8(s1)
}
80007f78:	02c12083          	lw	ra,44(sp)
80007f7c:	02812403          	lw	s0,40(sp)
80007f80:	02412483          	lw	s1,36(sp)
80007f84:	02012903          	lw	s2,32(sp)
80007f88:	01c12983          	lw	s3,28(sp)
80007f8c:	03010113          	addi	sp,sp,48
80007f90:	00008067          	ret
		f_write(pb->fp, pb->buf, (UINT)i, &n);
80007f94:	0004a503          	lw	a0,0(s1)
80007f98:	00040613          	mv	a2,s0
80007f9c:	00c10693          	addi	a3,sp,12
80007fa0:	00c48593          	addi	a1,s1,12
80007fa4:	c39ff0ef          	jal	ra,80007bdc <f_write>
		i = (n == (UINT)i) ? 0 : -1;
80007fa8:	00c12603          	lw	a2,12(sp)
80007fac:	40860633          	sub	a2,a2,s0
80007fb0:	00c03633          	snez	a2,a2
80007fb4:	40c00433          	neg	s0,a2
80007fb8:	fb5ff06f          	j	80007f6c <putc_bfd+0x48>
		putc_bfd(pb, '\r');
80007fbc:	00d00593          	li	a1,13
80007fc0:	f65ff0ef          	jal	ra,80007f24 <putc_bfd>
80007fc4:	f89ff06f          	j	80007f4c <putc_bfd+0x28>

80007fc8 <putc_flush>:

static int putc_flush (putbuff* pb)
{
	UINT nw;

	if (   pb->idx >= 0	/* Flush buffered characters to the file */
80007fc8:	00452603          	lw	a2,4(a0)
80007fcc:	04064e63          	bltz	a2,80008028 <putc_flush+0x60>
{
80007fd0:	fe010113          	addi	sp,sp,-32
80007fd4:	00812c23          	sw	s0,24(sp)
80007fd8:	00050413          	mv	s0,a0
		&& f_write(pb->fp, pb->buf, (UINT)pb->idx, &nw) == FR_OK
80007fdc:	00052503          	lw	a0,0(a0)
80007fe0:	00c10693          	addi	a3,sp,12
80007fe4:	00c40593          	addi	a1,s0,12
{
80007fe8:	00112e23          	sw	ra,28(sp)
		&& f_write(pb->fp, pb->buf, (UINT)pb->idx, &nw) == FR_OK
80007fec:	bf1ff0ef          	jal	ra,80007bdc <f_write>
80007ff0:	02051263          	bnez	a0,80008014 <putc_flush+0x4c>
		&& (UINT)pb->idx == nw) return pb->nchr;
80007ff4:	00442703          	lw	a4,4(s0)
80007ff8:	00c12783          	lw	a5,12(sp)
80007ffc:	00f71c63          	bne	a4,a5,80008014 <putc_flush+0x4c>
80008000:	00842503          	lw	a0,8(s0)
	return -1;
}
80008004:	01c12083          	lw	ra,28(sp)
80008008:	01812403          	lw	s0,24(sp)
8000800c:	02010113          	addi	sp,sp,32
80008010:	00008067          	ret
80008014:	01c12083          	lw	ra,28(sp)
80008018:	01812403          	lw	s0,24(sp)
	return -1;
8000801c:	fff00513          	li	a0,-1
}
80008020:	02010113          	addi	sp,sp,32
80008024:	00008067          	ret
	return -1;
80008028:	fff00513          	li	a0,-1
}
8000802c:	00008067          	ret

80008030 <f_sync>:
{
80008030:	f9010113          	addi	sp,sp,-112
	res = validate(&fp->obj, &fs);	/* Check validity of the file object */
80008034:	00c10593          	addi	a1,sp,12
{
80008038:	06812423          	sw	s0,104(sp)
8000803c:	06112623          	sw	ra,108(sp)
80008040:	00050413          	mv	s0,a0
	res = validate(&fp->obj, &fs);	/* Check validity of the file object */
80008044:	dc0fb0ef          	jal	ra,80003604 <validate>
80008048:	00050793          	mv	a5,a0
	if (res == FR_OK) {
8000804c:	0e051663          	bnez	a0,80008138 <f_sync+0x108>
		if (fp->flag & FA_MODIFIED) {	/* Is there any change to the file? */
80008050:	03044703          	lbu	a4,48(s0)
80008054:	04077693          	andi	a3,a4,64
80008058:	0e068063          	beqz	a3,80008138 <f_sync+0x108>
			if (fp->flag & FA_DIRTY) {	/* Write-back cached data if needed */
8000805c:	01871713          	slli	a4,a4,0x18
80008060:	41875713          	srai	a4,a4,0x18
80008064:	00c12503          	lw	a0,12(sp)
80008068:	28074063          	bltz	a4,800082e8 <f_sync+0x2b8>
			if (fs->fs_type == FS_EXFAT) {
8000806c:	00054703          	lbu	a4,0(a0)
80008070:	00400793          	li	a5,4
80008074:	0cf70c63          	beq	a4,a5,8000814c <f_sync+0x11c>
				res = move_window(fs, fp->dir_sect);
80008078:	04842583          	lw	a1,72(s0)
	if (sect != fs->winsect) {	/* Window offset changed? */
8000807c:	03852783          	lw	a5,56(a0)
80008080:	00f58a63          	beq	a1,a5,80008094 <f_sync+0x64>
80008084:	f15fb0ef          	jal	ra,80003f98 <move_window.part.6>
80008088:	00050793          	mv	a5,a0
				if (res == FR_OK) {
8000808c:	0a051663          	bnez	a0,80008138 <f_sync+0x108>
80008090:	00c12503          	lw	a0,12(sp)
					dir = fp->dir_ptr;
80008094:	04c42783          	lw	a5,76(s0)
	if (fs->fs_type == FS_FAT32) {
80008098:	00300613          	li	a2,3
					dir[DIR_Attr] |= AM_ARC;						/* Set archive attribute to indicate that the file has been changed */
8000809c:	00b7c703          	lbu	a4,11(a5)
800080a0:	02076713          	ori	a4,a4,32
800080a4:	00e785a3          	sb	a4,11(a5)
					st_clust(fp->obj.fs, dir, fp->obj.sclust);		/* Update file allocation information  */
800080a8:	00842703          	lw	a4,8(s0)
800080ac:	00042583          	lw	a1,0(s0)
	*ptr++ = (BYTE)val; val >>= 8;
800080b0:	01071693          	slli	a3,a4,0x10
800080b4:	0106d693          	srli	a3,a3,0x10
800080b8:	0086d693          	srli	a3,a3,0x8
800080bc:	00e78d23          	sb	a4,26(a5)
	*ptr++ = (BYTE)val;
800080c0:	00d78da3          	sb	a3,27(a5)
	if (fs->fs_type == FS_FAT32) {
800080c4:	0005c683          	lbu	a3,0(a1)
800080c8:	00c69a63          	bne	a3,a2,800080dc <f_sync+0xac>
		st_word(dir + DIR_FstClusHI, (WORD)(cl >> 16));
800080cc:	01075713          	srli	a4,a4,0x10
	*ptr++ = (BYTE)val; val >>= 8;
800080d0:	00875693          	srli	a3,a4,0x8
800080d4:	00e78a23          	sb	a4,20(a5)
	*ptr++ = (BYTE)val;
800080d8:	00d78aa3          	sb	a3,21(a5)
					st_dword(dir + DIR_FileSize, (DWORD)fp->obj.objsize);	/* Update file size */
800080dc:	01042703          	lw	a4,16(s0)
	*ptr++ = (BYTE)val; val >>= 8;
800080e0:	00078b23          	sb	zero,22(a5)
	*ptr++ = (BYTE)val; val >>= 8;
800080e4:	00078ba3          	sb	zero,23(a5)
	*ptr++ = (BYTE)val; val >>= 8;
800080e8:	00e78e23          	sb	a4,28(a5)
800080ec:	00875593          	srli	a1,a4,0x8
	*ptr++ = (BYTE)val; val >>= 8;
800080f0:	01075613          	srli	a2,a4,0x10
	*ptr++ = (BYTE)val; val >>= 8;
800080f4:	01875693          	srli	a3,a4,0x18
800080f8:	03500713          	li	a4,53
800080fc:	00e78c23          	sb	a4,24(a5)
	*ptr++ = (BYTE)val;
80008100:	05800713          	li	a4,88
	*ptr++ = (BYTE)val; val >>= 8;
80008104:	00b78ea3          	sb	a1,29(a5)
	*ptr++ = (BYTE)val; val >>= 8;
80008108:	00c78f23          	sb	a2,30(a5)
	*ptr++ = (BYTE)val;
8000810c:	00d78fa3          	sb	a3,31(a5)
80008110:	00e78ca3          	sb	a4,25(a5)
	*ptr++ = (BYTE)val; val >>= 8;
80008114:	00078923          	sb	zero,18(a5)
	*ptr++ = (BYTE)val;
80008118:	000789a3          	sb	zero,19(a5)
					fs->wflag = 1;
8000811c:	00100793          	li	a5,1
80008120:	00f50223          	sb	a5,4(a0)
					res = sync_fs(fs);					/* Restore it to the directory */
80008124:	d4dfb0ef          	jal	ra,80003e70 <sync_fs>
					fp->flag &= (BYTE)~FA_MODIFIED;
80008128:	03044703          	lbu	a4,48(s0)
					res = sync_fs(fs);					/* Restore it to the directory */
8000812c:	00050793          	mv	a5,a0
					fp->flag &= (BYTE)~FA_MODIFIED;
80008130:	fbf77713          	andi	a4,a4,-65
80008134:	02e40823          	sb	a4,48(s0)
}
80008138:	06c12083          	lw	ra,108(sp)
8000813c:	06812403          	lw	s0,104(sp)
80008140:	00078513          	mv	a0,a5
80008144:	07010113          	addi	sp,sp,112
80008148:	00008067          	ret
	if (obj->stat == 3) {	/* Has the object been changed 'fragmented' in this session? */
8000814c:	00744703          	lbu	a4,7(s0)
80008150:	00300793          	li	a5,3
80008154:	1cf70263          	beq	a4,a5,80008318 <f_sync+0x2e8>
	while (obj->n_frag > 0) {	/* Create the chain of last fragment */
80008158:	04042603          	lw	a2,64(s0)
8000815c:	fff00693          	li	a3,-1
80008160:	01c40593          	addi	a1,s0,28
80008164:	00040513          	mv	a0,s0
80008168:	a61fc0ef          	jal	ra,80004bc8 <fill_last_frag.isra.8.part.9>
8000816c:	00050793          	mv	a5,a0
				if (res == FR_OK) {
80008170:	fc0514e3          	bnez	a0,80008138 <f_sync+0x108>
	dp->blk_ofs = obj->c_ofs;
80008174:	02842783          	lw	a5,40(s0)
	dp->obj.stat = (BYTE)obj->c_size;
80008178:	02442703          	lw	a4,36(s0)
	dp->obj.fs = obj->fs;
8000817c:	00042803          	lw	a6,0(s0)
	dp->obj.sclust = obj->c_scl;
80008180:	02042603          	lw	a2,32(s0)
	dp->obj.objsize = obj->c_size & 0xFFFFFF00;
80008184:	f0077693          	andi	a3,a4,-256
	res = dir_sdi(dp, dp->blk_ofs);	/* Goto object's entry block */
80008188:	00078593          	mv	a1,a5
8000818c:	01010513          	addi	a0,sp,16
	dp->blk_ofs = obj->c_ofs;
80008190:	04f12e23          	sw	a5,92(sp)
	dp->obj.fs = obj->fs;
80008194:	01012823          	sw	a6,16(sp)
	dp->obj.sclust = obj->c_scl;
80008198:	00c12c23          	sw	a2,24(sp)
	dp->obj.stat = (BYTE)obj->c_size;
8000819c:	00e10ba3          	sb	a4,23(sp)
	dp->obj.objsize = obj->c_size & 0xFFFFFF00;
800081a0:	02d12023          	sw	a3,32(sp)
800081a4:	02012223          	sw	zero,36(sp)
	dp->obj.n_frag = 0;
800081a8:	02012623          	sw	zero,44(sp)
	res = dir_sdi(dp, dp->blk_ofs);	/* Goto object's entry block */
800081ac:	c30fc0ef          	jal	ra,800045dc <dir_sdi>
800081b0:	00050793          	mv	a5,a0
	if (res == FR_OK) {
800081b4:	f80512e3          	bnez	a0,80008138 <f_sync+0x108>
		res = load_xdir(dp);		/* Load the object's entry block */
800081b8:	01010513          	addi	a0,sp,16
800081bc:	b5dfd0ef          	jal	ra,80005d18 <load_xdir>
800081c0:	00050793          	mv	a5,a0
					if (res == FR_OK) {
800081c4:	f6051ae3          	bnez	a0,80008138 <f_sync+0x108>
						fs->dirbuf[XDIR_Attr] |= AM_ARC;				/* Set archive attribute to indicate that the file has been changed */
800081c8:	00c12783          	lw	a5,12(sp)
						res = store_xdir(&dj);	/* Restore it to the directory */
800081cc:	01010513          	addi	a0,sp,16
						fs->dirbuf[XDIR_Attr] |= AM_ARC;				/* Set archive attribute to indicate that the file has been changed */
800081d0:	0107a683          	lw	a3,16(a5)
800081d4:	0046c703          	lbu	a4,4(a3)
800081d8:	02076713          	ori	a4,a4,32
800081dc:	00e68223          	sb	a4,4(a3)
						fs->dirbuf[XDIR_GenFlags] = fp->obj.stat | 1;	/* Update file allocation information */
800081e0:	00744703          	lbu	a4,7(s0)
800081e4:	0107a683          	lw	a3,16(a5)
800081e8:	00176713          	ori	a4,a4,1
800081ec:	02e680a3          	sb	a4,33(a3)
						st_dword(fs->dirbuf + XDIR_FstClus, fp->obj.sclust);		/* Update start cluster */
800081f0:	00842683          	lw	a3,8(s0)
800081f4:	0107a703          	lw	a4,16(a5)
	*ptr++ = (BYTE)val; val >>= 8;
800081f8:	0086d813          	srli	a6,a3,0x8
	*ptr++ = (BYTE)val; val >>= 8;
800081fc:	0106d593          	srli	a1,a3,0x10
	*ptr++ = (BYTE)val; val >>= 8;
80008200:	0186d613          	srli	a2,a3,0x18
	*ptr++ = (BYTE)val; val >>= 8;
80008204:	03070aa3          	sb	a6,53(a4)
	*ptr++ = (BYTE)val; val >>= 8;
80008208:	02b70b23          	sb	a1,54(a4)
	*ptr++ = (BYTE)val; val >>= 8;
8000820c:	02d70a23          	sb	a3,52(a4)
	*ptr++ = (BYTE)val;
80008210:	02c70ba3          	sb	a2,55(a4)
						st_qword(fs->dirbuf + XDIR_FileSize, fp->obj.objsize);		/* Update file size */
80008214:	01042603          	lw	a2,16(s0)
80008218:	01442683          	lw	a3,20(s0)
8000821c:	0107a703          	lw	a4,16(a5)
	*ptr++ = (BYTE)val; val >>= 8;
80008220:	00865e93          	srli	t4,a2,0x8
	*ptr++ = (BYTE)val; val >>= 8;
80008224:	01065e13          	srli	t3,a2,0x10
	*ptr++ = (BYTE)val; val >>= 8;
80008228:	01865313          	srli	t1,a2,0x18
	*ptr++ = (BYTE)val; val >>= 8;
8000822c:	0086d893          	srli	a7,a3,0x8
	*ptr++ = (BYTE)val; val >>= 8;
80008230:	0106d813          	srli	a6,a3,0x10
	*ptr++ = (BYTE)val; val >>= 8;
80008234:	0186d593          	srli	a1,a3,0x18
	*ptr++ = (BYTE)val; val >>= 8;
80008238:	03d70ca3          	sb	t4,57(a4)
	*ptr++ = (BYTE)val; val >>= 8;
8000823c:	03c70d23          	sb	t3,58(a4)
	*ptr++ = (BYTE)val; val >>= 8;
80008240:	02670da3          	sb	t1,59(a4)
	*ptr++ = (BYTE)val; val >>= 8;
80008244:	03170ea3          	sb	a7,61(a4)
	*ptr++ = (BYTE)val; val >>= 8;
80008248:	03070f23          	sb	a6,62(a4)
	*ptr++ = (BYTE)val;
8000824c:	02b70fa3          	sb	a1,63(a4)
	*ptr++ = (BYTE)val; val >>= 8;
80008250:	02c70c23          	sb	a2,56(a4)
	*ptr++ = (BYTE)val; val >>= 8;
80008254:	02d70e23          	sb	a3,60(a4)
						st_qword(fs->dirbuf + XDIR_ValidFileSize, fp->obj.objsize);	/* (FatFs does not support Valid File Size feature) */
80008258:	01042603          	lw	a2,16(s0)
8000825c:	0107a703          	lw	a4,16(a5)
80008260:	01442683          	lw	a3,20(s0)
	*ptr++ = (BYTE)val; val >>= 8;
80008264:	00865893          	srli	a7,a2,0x8
	*ptr++ = (BYTE)val; val >>= 8;
80008268:	01065813          	srli	a6,a2,0x10
	*ptr++ = (BYTE)val; val >>= 8;
8000826c:	01865593          	srli	a1,a2,0x18
	*ptr++ = (BYTE)val; val >>= 8;
80008270:	02c70423          	sb	a2,40(a4)
	*ptr++ = (BYTE)val; val >>= 8;
80008274:	031704a3          	sb	a7,41(a4)
	*ptr++ = (BYTE)val; val >>= 8;
80008278:	03070523          	sb	a6,42(a4)
	*ptr++ = (BYTE)val; val >>= 8;
8000827c:	02b705a3          	sb	a1,43(a4)
	*ptr++ = (BYTE)val; val >>= 8;
80008280:	02d70623          	sb	a3,44(a4)
80008284:	0086d593          	srli	a1,a3,0x8
	*ptr++ = (BYTE)val; val >>= 8;
80008288:	0106d613          	srli	a2,a3,0x10
	*ptr++ = (BYTE)val; val >>= 8;
8000828c:	0186d693          	srli	a3,a3,0x18
	*ptr++ = (BYTE)val; val >>= 8;
80008290:	02b706a3          	sb	a1,45(a4)
	*ptr++ = (BYTE)val;
80008294:	02d707a3          	sb	a3,47(a4)
	*ptr++ = (BYTE)val; val >>= 8;
80008298:	02c70723          	sb	a2,46(a4)
						st_dword(fs->dirbuf + XDIR_ModTime, tm);		/* Update modified time */
8000829c:	0107a703          	lw	a4,16(a5)
	*ptr++ = (BYTE)val; val >>= 8;
800082a0:	03500693          	li	a3,53
800082a4:	00d70723          	sb	a3,14(a4)
	*ptr++ = (BYTE)val;
800082a8:	05800693          	li	a3,88
	*ptr++ = (BYTE)val; val >>= 8;
800082ac:	00070623          	sb	zero,12(a4)
	*ptr++ = (BYTE)val; val >>= 8;
800082b0:	000706a3          	sb	zero,13(a4)
	*ptr++ = (BYTE)val;
800082b4:	00d707a3          	sb	a3,15(a4)
						fs->dirbuf[XDIR_ModTime10] = 0;
800082b8:	0107a703          	lw	a4,16(a5)
800082bc:	00070aa3          	sb	zero,21(a4)
						st_dword(fs->dirbuf + XDIR_AccTime, 0);
800082c0:	0107a783          	lw	a5,16(a5)
	*ptr++ = (BYTE)val; val >>= 8;
800082c4:	00078823          	sb	zero,16(a5)
	*ptr++ = (BYTE)val; val >>= 8;
800082c8:	000788a3          	sb	zero,17(a5)
	*ptr++ = (BYTE)val; val >>= 8;
800082cc:	00078923          	sb	zero,18(a5)
	*ptr++ = (BYTE)val;
800082d0:	000789a3          	sb	zero,19(a5)
						res = store_xdir(&dj);	/* Restore it to the directory */
800082d4:	c6dfd0ef          	jal	ra,80005f40 <store_xdir>
800082d8:	00050793          	mv	a5,a0
						if (res == FR_OK) {
800082dc:	e4051ee3          	bnez	a0,80008138 <f_sync+0x108>
							res = sync_fs(fs);
800082e0:	00c12503          	lw	a0,12(sp)
800082e4:	e41ff06f          	j	80008124 <f_sync+0xf4>
				if (disk_write(fs->pdrv, fp->buf, fp->sect, 1) != RES_OK) LEAVE_FF(fs, FR_DISK_ERR);
800082e8:	04442603          	lw	a2,68(s0)
800082ec:	00154503          	lbu	a0,1(a0)
800082f0:	00100693          	li	a3,1
800082f4:	05040593          	addi	a1,s0,80
800082f8:	a40fb0ef          	jal	ra,80003538 <disk_write>
800082fc:	00100793          	li	a5,1
80008300:	e2051ce3          	bnez	a0,80008138 <f_sync+0x108>
				fp->flag &= (BYTE)~FA_DIRTY;
80008304:	03044783          	lbu	a5,48(s0)
80008308:	00c12503          	lw	a0,12(sp)
8000830c:	07f7f793          	andi	a5,a5,127
80008310:	02f40823          	sb	a5,48(s0)
80008314:	d59ff06f          	j	8000806c <f_sync+0x3c>
80008318:	00040513          	mv	a0,s0
8000831c:	975fc0ef          	jal	ra,80004c90 <fill_first_frag.part.10>
80008320:	00050793          	mv	a5,a0
				if (res == FR_OK) {
80008324:	e2050ae3          	beqz	a0,80008158 <f_sync+0x128>
80008328:	e11ff06f          	j	80008138 <f_sync+0x108>

8000832c <f_close>:
{
8000832c:	fe010113          	addi	sp,sp,-32
80008330:	00812c23          	sw	s0,24(sp)
80008334:	00112e23          	sw	ra,28(sp)
80008338:	00050413          	mv	s0,a0
	res = f_sync(fp);					/* Flush cached data */
8000833c:	cf5ff0ef          	jal	ra,80008030 <f_sync>
	if (res == FR_OK)
80008340:	00050a63          	beqz	a0,80008354 <f_close+0x28>
}
80008344:	01c12083          	lw	ra,28(sp)
80008348:	01812403          	lw	s0,24(sp)
8000834c:	02010113          	addi	sp,sp,32
80008350:	00008067          	ret
		res = validate(&fp->obj, &fs);	/* Lock volume */
80008354:	00c10593          	addi	a1,sp,12
80008358:	00040513          	mv	a0,s0
8000835c:	aa8fb0ef          	jal	ra,80003604 <validate>
		if (res == FR_OK) {
80008360:	fe0512e3          	bnez	a0,80008344 <f_close+0x18>
			fp->obj.fs = 0;	/* Invalidate file object */
80008364:	00042023          	sw	zero,0(s0)
}
80008368:	01c12083          	lw	ra,28(sp)
8000836c:	01812403          	lw	s0,24(sp)
80008370:	02010113          	addi	sp,sp,32
80008374:	00008067          	ret

80008378 <f_lseek>:
{
80008378:	fb010113          	addi	sp,sp,-80
8000837c:	03312e23          	sw	s3,60(sp)
80008380:	00058993          	mv	s3,a1
	res = validate(&fp->obj, &fs);		/* Check validity of the file object */
80008384:	00c10593          	addi	a1,sp,12
{
80008388:	04812423          	sw	s0,72(sp)
8000838c:	03512a23          	sw	s5,52(sp)
80008390:	03a12023          	sw	s10,32(sp)
80008394:	04112623          	sw	ra,76(sp)
80008398:	04912223          	sw	s1,68(sp)
8000839c:	05212023          	sw	s2,64(sp)
800083a0:	03412c23          	sw	s4,56(sp)
800083a4:	03612823          	sw	s6,48(sp)
800083a8:	03712623          	sw	s7,44(sp)
800083ac:	03812423          	sw	s8,40(sp)
800083b0:	03912223          	sw	s9,36(sp)
800083b4:	01b12e23          	sw	s11,28(sp)
800083b8:	00050413          	mv	s0,a0
800083bc:	00060a93          	mv	s5,a2
	res = validate(&fp->obj, &fs);		/* Check validity of the file object */
800083c0:	a44fb0ef          	jal	ra,80003604 <validate>
800083c4:	00050d13          	mv	s10,a0
	if (res == FR_OK) res = (FRESULT)fp->err;
800083c8:	22051e63          	bnez	a0,80008604 <f_lseek+0x28c>
800083cc:	03144d03          	lbu	s10,49(s0)
	if (res == FR_OK && fs->fs_type == FS_EXFAT) {
800083d0:	220d1a63          	bnez	s10,80008604 <f_lseek+0x28c>
800083d4:	00c12683          	lw	a3,12(sp)
800083d8:	00400793          	li	a5,4
800083dc:	0006c483          	lbu	s1,0(a3)
800083e0:	2af48063          	beq	s1,a5,80008680 <f_lseek+0x308>
800083e4:	000a8663          	beqz	s5,800083f0 <f_lseek+0x78>
800083e8:	fff00993          	li	s3,-1
800083ec:	00000a93          	li	s5,0
		if (ofs > fp->obj.objsize && (FF_FS_READONLY || !(fp->flag & FA_WRITE))) {	/* In read-only mode, clip offset with the file size */
800083f0:	01442783          	lw	a5,20(s0)
800083f4:	01042603          	lw	a2,16(s0)
800083f8:	2757e863          	bltu	a5,s5,80008668 <f_lseek+0x2f0>
800083fc:	26fa8463          	beq	s5,a5,80008664 <f_lseek+0x2ec>
		fp->fptr = nsect = 0;
80008400:	00000593          	li	a1,0
80008404:	00000613          	li	a2,0
		ifptr = fp->fptr;
80008408:	03842703          	lw	a4,56(s0)
8000840c:	03c42903          	lw	s2,60(s0)
		if (ofs > 0) {
80008410:	0159e7b3          	or	a5,s3,s5
		fp->fptr = nsect = 0;
80008414:	02b42c23          	sw	a1,56(s0)
80008418:	02c42e23          	sw	a2,60(s0)
		if (ofs > 0) {
8000841c:	1e078463          	beqz	a5,80008604 <f_lseek+0x28c>
			bcs = (DWORD)fs->csize * SS(fs);	/* Cluster size (byte) */
80008420:	00a6db03          	lhu	s6,10(a3)
			if (ifptr > 0 &&
80008424:	012767b3          	or	a5,a4,s2
			bcs = (DWORD)fs->csize * SS(fs);	/* Cluster size (byte) */
80008428:	009b1b13          	slli	s6,s6,0x9
			if (ifptr > 0 &&
8000842c:	20078e63          	beqz	a5,80008648 <f_lseek+0x2d0>
				(ofs - 1) / bcs >= (ifptr - 1) / bcs) {	/* When seek to same or following cluster, */
80008430:	fff70493          	addi	s1,a4,-1
80008434:	00e4b733          	sltu	a4,s1,a4
80008438:	fff90913          	addi	s2,s2,-1
8000843c:	01270db3          	add	s11,a4,s2
80008440:	000b0613          	mv	a2,s6
80008444:	00000693          	li	a3,0
80008448:	00048513          	mv	a0,s1
8000844c:	000d8593          	mv	a1,s11
80008450:	101020ef          	jal	ra,8000ad50 <__udivdi3>
80008454:	00050a13          	mv	s4,a0
80008458:	fff98513          	addi	a0,s3,-1
8000845c:	00058b93          	mv	s7,a1
80008460:	013537b3          	sltu	a5,a0,s3
80008464:	fffa8593          	addi	a1,s5,-1
80008468:	000b0613          	mv	a2,s6
8000846c:	00000693          	li	a3,0
80008470:	00b785b3          	add	a1,a5,a1
80008474:	0dd020ef          	jal	ra,8000ad50 <__udivdi3>
			if (ifptr > 0 &&
80008478:	1d75e863          	bltu	a1,s7,80008648 <f_lseek+0x2d0>
8000847c:	1cbb8463          	beq	s7,a1,80008644 <f_lseek+0x2cc>
				fp->fptr = (ifptr - 1) & ~(FSIZE_t)(bcs - 1);	/* start from the current cluster */
80008480:	416007b3          	neg	a5,s6
80008484:	0097f4b3          	and	s1,a5,s1
				clst = fp->clust;
80008488:	04042903          	lw	s2,64(s0)
				ofs -= fp->fptr;
8000848c:	409987b3          	sub	a5,s3,s1
80008490:	00f9b6b3          	sltu	a3,s3,a5
80008494:	41ba8ab3          	sub	s5,s5,s11
				fp->fptr = (ifptr - 1) & ~(FSIZE_t)(bcs - 1);	/* start from the current cluster */
80008498:	02942c23          	sw	s1,56(s0)
8000849c:	03b42e23          	sw	s11,60(s0)
				ofs -= fp->fptr;
800084a0:	00078993          	mv	s3,a5
800084a4:	40da8ab3          	sub	s5,s5,a3
			if (clst != 0) {
800084a8:	10090063          	beqz	s2,800085a8 <f_lseek+0x230>
				while (ofs > bcs) {						/* Cluster following loop */
800084ac:	2a0a8063          	beqz	s5,8000874c <f_lseek+0x3d4>
					if (clst == 0xFFFFFFFF) ABORT(fs, FR_DISK_ERR);
800084b0:	fff00b93          	li	s7,-1
					if (clst <= 1 || clst >= fs->n_fatent) ABORT(fs, FR_INT_ERR);
800084b4:	00100c13          	li	s8,1
					ofs -= bcs; fp->fptr += bcs;
800084b8:	016487b3          	add	a5,s1,s6
					if (fp->flag & FA_WRITE) {			/* Check if in write mode or not */
800084bc:	03044703          	lbu	a4,48(s0)
					ofs -= bcs; fp->fptr += bcs;
800084c0:	41698cb3          	sub	s9,s3,s6
800084c4:	0097b4b3          	sltu	s1,a5,s1
800084c8:	0199b9b3          	sltu	s3,s3,s9
800084cc:	01b484b3          	add	s1,s1,s11
800084d0:	413a8a33          	sub	s4,s5,s3
800084d4:	02f42c23          	sw	a5,56(s0)
800084d8:	02942e23          	sw	s1,60(s0)
					if (fp->flag & FA_WRITE) {			/* Check if in write mode or not */
800084dc:	00277693          	andi	a3,a4,2
					ofs -= bcs; fp->fptr += bcs;
800084e0:	000c8993          	mv	s3,s9
800084e4:	000a0a93          	mv	s5,s4
					if (fp->flag & FA_WRITE) {			/* Check if in write mode or not */
800084e8:	1e068a63          	beqz	a3,800086dc <f_lseek+0x364>
						if (FF_FS_EXFAT && fp->fptr > fp->obj.objsize) {	/* No FAT chain object needs correct objsize to generate FAT value */
800084ec:	01442683          	lw	a3,20(s0)
800084f0:	0096e863          	bltu	a3,s1,80008500 <f_lseek+0x188>
800084f4:	00969e63          	bne	a3,s1,80008510 <f_lseek+0x198>
800084f8:	01042683          	lw	a3,16(s0)
800084fc:	00f6fa63          	bgeu	a3,a5,80008510 <f_lseek+0x198>
							fp->flag |= FA_MODIFIED;
80008500:	04076713          	ori	a4,a4,64
							fp->obj.objsize = fp->fptr;
80008504:	00f42823          	sw	a5,16(s0)
80008508:	00942a23          	sw	s1,20(s0)
							fp->flag |= FA_MODIFIED;
8000850c:	02e40823          	sb	a4,48(s0)
						clst = create_chain(&fp->obj, clst);	/* Follow chain with forceed stretch */
80008510:	00090593          	mv	a1,s2
80008514:	00040513          	mv	a0,s0
80008518:	914fd0ef          	jal	ra,8000562c <create_chain>
8000851c:	00050913          	mv	s2,a0
						if (clst == 0) {				/* Clip file size in case of disk full */
80008520:	20050c63          	beqz	a0,80008738 <f_lseek+0x3c0>
					if (clst == 0xFFFFFFFF) ABORT(fs, FR_DISK_ERR);
80008524:	1d790e63          	beq	s2,s7,80008700 <f_lseek+0x388>
					if (clst <= 1 || clst >= fs->n_fatent) ABORT(fs, FR_INT_ERR);
80008528:	1f2c7463          	bgeu	s8,s2,80008710 <f_lseek+0x398>
8000852c:	00c12783          	lw	a5,12(sp)
80008530:	01c7a783          	lw	a5,28(a5)
80008534:	1cf97e63          	bgeu	s2,a5,80008710 <f_lseek+0x398>
					fp->clust = clst;
80008538:	05242023          	sw	s2,64(s0)
8000853c:	03842483          	lw	s1,56(s0)
80008540:	03c42d83          	lw	s11,60(s0)
				while (ofs > bcs) {						/* Cluster following loop */
80008544:	f60a1ae3          	bnez	s4,800084b8 <f_lseek+0x140>
80008548:	f79b68e3          	bltu	s6,s9,800084b8 <f_lseek+0x140>
				fp->fptr += ofs;
8000854c:	013487b3          	add	a5,s1,s3
80008550:	0097b733          	sltu	a4,a5,s1
80008554:	015d8db3          	add	s11,s11,s5
80008558:	01b70db3          	add	s11,a4,s11
8000855c:	00078493          	mv	s1,a5
80008560:	02f42c23          	sw	a5,56(s0)
80008564:	03b42e23          	sw	s11,60(s0)
				if (ofs % SS(fs)) {
80008568:	1ff9f793          	andi	a5,s3,511
8000856c:	1c078c63          	beqz	a5,80008744 <f_lseek+0x3cc>
					nsect = clst2sect(fs, clst);	/* Current sector */
80008570:	00c12a03          	lw	s4,12(sp)
	clst -= 2;		/* Cluster number is origin from 2 */
80008574:	ffe90593          	addi	a1,s2,-2
	if (clst >= fs->n_fatent - 2) return 0;		/* Is it invalid cluster number? */
80008578:	01ca2783          	lw	a5,28(s4)
8000857c:	ffe78793          	addi	a5,a5,-2
80008580:	18f5f863          	bgeu	a1,a5,80008710 <f_lseek+0x398>
	return fs->database + (LBA_t)fs->csize * clst;	/* Start sector number of the cluster */
80008584:	00aa5503          	lhu	a0,10(s4)
80008588:	41c050ef          	jal	ra,8000d9a4 <__mulsi3>
8000858c:	030a2903          	lw	s2,48(s4)
80008590:	01250933          	add	s2,a0,s2
					if (nsect == 0) ABORT(fs, FR_INT_ERR);
80008594:	16090e63          	beqz	s2,80008710 <f_lseek+0x398>
					nsect += (DWORD)(ofs / SS(fs));
80008598:	017a9a93          	slli	s5,s5,0x17
8000859c:	0099d993          	srli	s3,s3,0x9
800085a0:	013ae9b3          	or	s3,s5,s3
800085a4:	01390933          	add	s2,s2,s3
		if (!FF_FS_READONLY && fp->fptr > fp->obj.objsize) {	/* Set file change flag if the file size is extended */
800085a8:	01442783          	lw	a5,20(s0)
800085ac:	1ff4f693          	andi	a3,s1,511
800085b0:	1bb7f263          	bgeu	a5,s11,80008754 <f_lseek+0x3dc>
			fp->flag |= FA_MODIFIED;
800085b4:	03044783          	lbu	a5,48(s0)
			fp->obj.objsize = fp->fptr;
800085b8:	00942823          	sw	s1,16(s0)
800085bc:	01b42a23          	sw	s11,20(s0)
			fp->flag |= FA_MODIFIED;
800085c0:	0407e793          	ori	a5,a5,64
800085c4:	02f40823          	sb	a5,48(s0)
		if (fp->fptr % SS(fs) && nsect != fp->sect) {	/* Fill sector cache if needed */
800085c8:	02068e63          	beqz	a3,80008604 <f_lseek+0x28c>
800085cc:	04442603          	lw	a2,68(s0)
800085d0:	03260a63          	beq	a2,s2,80008604 <f_lseek+0x28c>
			if (fp->flag & FA_DIRTY) {			/* Write-back dirty sector cache */
800085d4:	00c12703          	lw	a4,12(sp)
800085d8:	03040783          	lb	a5,48(s0)
800085dc:	05040493          	addi	s1,s0,80
800085e0:	00174503          	lbu	a0,1(a4)
800085e4:	1007c663          	bltz	a5,800086f0 <f_lseek+0x378>
			if (disk_read(fs->pdrv, fp->buf, nsect, 1) != RES_OK) ABORT(fs, FR_DISK_ERR);	/* Fill sector cache */
800085e8:	00100693          	li	a3,1
800085ec:	00090613          	mv	a2,s2
800085f0:	00048593          	mv	a1,s1
800085f4:	f05fa0ef          	jal	ra,800034f8 <disk_read>
800085f8:	00050d13          	mv	s10,a0
800085fc:	10051263          	bnez	a0,80008700 <f_lseek+0x388>
			fp->sect = nsect;
80008600:	05242223          	sw	s2,68(s0)
}
80008604:	04c12083          	lw	ra,76(sp)
80008608:	04812403          	lw	s0,72(sp)
8000860c:	000d0513          	mv	a0,s10
80008610:	04412483          	lw	s1,68(sp)
80008614:	04012903          	lw	s2,64(sp)
80008618:	03c12983          	lw	s3,60(sp)
8000861c:	03812a03          	lw	s4,56(sp)
80008620:	03412a83          	lw	s5,52(sp)
80008624:	03012b03          	lw	s6,48(sp)
80008628:	02c12b83          	lw	s7,44(sp)
8000862c:	02812c03          	lw	s8,40(sp)
80008630:	02412c83          	lw	s9,36(sp)
80008634:	02012d03          	lw	s10,32(sp)
80008638:	01c12d83          	lw	s11,28(sp)
8000863c:	05010113          	addi	sp,sp,80
80008640:	00008067          	ret
			if (ifptr > 0 &&
80008644:	e3457ee3          	bgeu	a0,s4,80008480 <f_lseek+0x108>
				clst = fp->obj.sclust;					/* start from the first cluster */
80008648:	00842903          	lw	s2,8(s0)
				if (clst == 0) {						/* If no cluster chain, create a new chain */
8000864c:	00000493          	li	s1,0
80008650:	00000d93          	li	s11,0
80008654:	04090a63          	beqz	s2,800086a8 <f_lseek+0x330>
				fp->clust = clst;
80008658:	05242023          	sw	s2,64(s0)
			if (clst != 0) {
8000865c:	f40906e3          	beqz	s2,800085a8 <f_lseek+0x230>
80008660:	e4dff06f          	j	800084ac <f_lseek+0x134>
		if (ofs > fp->obj.objsize && (FF_FS_READONLY || !(fp->flag & FA_WRITE))) {	/* In read-only mode, clip offset with the file size */
80008664:	d9367ee3          	bgeu	a2,s3,80008400 <f_lseek+0x88>
80008668:	03044703          	lbu	a4,48(s0)
8000866c:	00277713          	andi	a4,a4,2
80008670:	d80718e3          	bnez	a4,80008400 <f_lseek+0x88>
80008674:	00060993          	mv	s3,a2
80008678:	00078a93          	mv	s5,a5
8000867c:	d85ff06f          	j	80008400 <f_lseek+0x88>
	while (obj->n_frag > 0) {	/* Create the chain of last fragment */
80008680:	04042603          	lw	a2,64(s0)
80008684:	fff00693          	li	a3,-1
80008688:	01c40593          	addi	a1,s0,28
8000868c:	00040513          	mv	a0,s0
80008690:	d38fc0ef          	jal	ra,80004bc8 <fill_last_frag.isra.8.part.9>
	if (res != FR_OK) LEAVE_FF(fs, res);
80008694:	0c051863          	bnez	a0,80008764 <f_lseek+0x3ec>
		if (fs->fs_type != FS_EXFAT && ofs >= 0x100000000) ofs = 0xFFFFFFFF;	/* Clip at 4 GiB - 1 if at FATxx */
80008698:	00c12683          	lw	a3,12(sp)
8000869c:	0006c783          	lbu	a5,0(a3)
800086a0:	d49788e3          	beq	a5,s1,800083f0 <f_lseek+0x78>
800086a4:	d41ff06f          	j	800083e4 <f_lseek+0x6c>
					clst = create_chain(&fp->obj, 0);
800086a8:	00000593          	li	a1,0
800086ac:	00040513          	mv	a0,s0
800086b0:	f7dfc0ef          	jal	ra,8000562c <create_chain>
					if (clst == 1) ABORT(fs, FR_INT_ERR);
800086b4:	00100793          	li	a5,1
					clst = create_chain(&fp->obj, 0);
800086b8:	00050913          	mv	s2,a0
					if (clst == 1) ABORT(fs, FR_INT_ERR);
800086bc:	04f50a63          	beq	a0,a5,80008710 <f_lseek+0x398>
					if (clst == 0xFFFFFFFF) ABORT(fs, FR_DISK_ERR);
800086c0:	fff00793          	li	a5,-1
800086c4:	02f50e63          	beq	a0,a5,80008700 <f_lseek+0x388>
					fp->obj.sclust = clst;
800086c8:	03842483          	lw	s1,56(s0)
800086cc:	03c42d83          	lw	s11,60(s0)
800086d0:	00a42423          	sw	a0,8(s0)
				fp->clust = clst;
800086d4:	05242023          	sw	s2,64(s0)
800086d8:	f85ff06f          	j	8000865c <f_lseek+0x2e4>
						clst = get_fat(&fp->obj, clst);	/* Follow cluster chain if not in write mode */
800086dc:	00090593          	mv	a1,s2
800086e0:	00040513          	mv	a0,s0
800086e4:	c4dfb0ef          	jal	ra,80004330 <get_fat>
800086e8:	00050913          	mv	s2,a0
800086ec:	e39ff06f          	j	80008524 <f_lseek+0x1ac>
				if (disk_write(fs->pdrv, fp->buf, fp->sect, 1) != RES_OK) ABORT(fs, FR_DISK_ERR);
800086f0:	00100693          	li	a3,1
800086f4:	00048593          	mv	a1,s1
800086f8:	e41fa0ef          	jal	ra,80003538 <disk_write>
800086fc:	02050263          	beqz	a0,80008720 <f_lseek+0x3a8>
					if (clst == 0xFFFFFFFF) ABORT(fs, FR_DISK_ERR);
80008700:	00100793          	li	a5,1
80008704:	02f408a3          	sb	a5,49(s0)
80008708:	00100d13          	li	s10,1
8000870c:	ef9ff06f          	j	80008604 <f_lseek+0x28c>
					if (clst == 1) ABORT(fs, FR_INT_ERR);
80008710:	00200793          	li	a5,2
80008714:	02f408a3          	sb	a5,49(s0)
80008718:	00200d13          	li	s10,2
8000871c:	ee9ff06f          	j	80008604 <f_lseek+0x28c>
				fp->flag &= (BYTE)~FA_DIRTY;
80008720:	03044783          	lbu	a5,48(s0)
80008724:	07f7f793          	andi	a5,a5,127
80008728:	02f40823          	sb	a5,48(s0)
8000872c:	00c12783          	lw	a5,12(sp)
80008730:	0017c503          	lbu	a0,1(a5)
80008734:	eb5ff06f          	j	800085e8 <f_lseek+0x270>
80008738:	03842483          	lw	s1,56(s0)
8000873c:	03c42d83          	lw	s11,60(s0)
80008740:	e69ff06f          	j	800085a8 <f_lseek+0x230>
		fp->fptr = nsect = 0;
80008744:	00000913          	li	s2,0
80008748:	e61ff06f          	j	800085a8 <f_lseek+0x230>
				while (ofs > bcs) {						/* Cluster following loop */
8000874c:	d73b62e3          	bltu	s6,s3,800084b0 <f_lseek+0x138>
80008750:	dfdff06f          	j	8000854c <f_lseek+0x1d4>
		if (!FF_FS_READONLY && fp->fptr > fp->obj.objsize) {	/* Set file change flag if the file size is extended */
80008754:	e7b79ae3          	bne	a5,s11,800085c8 <f_lseek+0x250>
80008758:	01042783          	lw	a5,16(s0)
8000875c:	e497ece3          	bltu	a5,s1,800085b4 <f_lseek+0x23c>
80008760:	e69ff06f          	j	800085c8 <f_lseek+0x250>
80008764:	00050d13          	mv	s10,a0
80008768:	e9dff06f          	j	80008604 <f_lseek+0x28c>

8000876c <f_opendir>:
{
8000876c:	fd010113          	addi	sp,sp,-48
80008770:	02112623          	sw	ra,44(sp)
80008774:	02812423          	sw	s0,40(sp)
80008778:	00b12623          	sw	a1,12(sp)
	if (!dp) return FR_INVALID_OBJECT;
8000877c:	0c050663          	beqz	a0,80008848 <f_opendir+0xdc>
	res = mount_volume(&path, &fs, 0);
80008780:	00050413          	mv	s0,a0
80008784:	00000613          	li	a2,0
80008788:	01c10593          	addi	a1,sp,28
8000878c:	00c10513          	addi	a0,sp,12
80008790:	db4fc0ef          	jal	ra,80004d44 <mount_volume>
	if (res == FR_OK) {
80008794:	00050c63          	beqz	a0,800087ac <f_opendir+0x40>
	if (res != FR_OK) dp->obj.fs = 0;		/* Invalidate the directory object if function failed */
80008798:	00042023          	sw	zero,0(s0)
}
8000879c:	02c12083          	lw	ra,44(sp)
800087a0:	02812403          	lw	s0,40(sp)
800087a4:	03010113          	addi	sp,sp,48
800087a8:	00008067          	ret
		dp->obj.fs = fs;
800087ac:	01c12783          	lw	a5,28(sp)
		res = follow_path(dp, path);			/* Follow the path to the directory */
800087b0:	00c12583          	lw	a1,12(sp)
800087b4:	00040513          	mv	a0,s0
		dp->obj.fs = fs;
800087b8:	00f42023          	sw	a5,0(s0)
		res = follow_path(dp, path);			/* Follow the path to the directory */
800087bc:	ef5fd0ef          	jal	ra,800066b0 <follow_path>
		if (res == FR_OK) {						/* Follow completed */
800087c0:	06051c63          	bnez	a0,80008838 <f_opendir+0xcc>
			if (!(dp->fn[NSFLAG] & NS_NONAME)) {	/* It is not the origin directory itself */
800087c4:	04b40783          	lb	a5,75(s0)
800087c8:	0e07c063          	bltz	a5,800088a8 <f_opendir+0x13c>
				if (dp->obj.attr & AM_DIR) {		/* This object is a sub-directory */
800087cc:	00644783          	lbu	a5,6(s0)
800087d0:	0107f793          	andi	a5,a5,16
800087d4:	06078663          	beqz	a5,80008840 <f_opendir+0xd4>
					if (fs->fs_type == FS_EXFAT) {
800087d8:	01c12703          	lw	a4,28(sp)
800087dc:	00400793          	li	a5,4
800087e0:	00074603          	lbu	a2,0(a4)
800087e4:	08f60a63          	beq	a2,a5,80008878 <f_opendir+0x10c>
						dp->obj.sclust = ld_clust(fs, dp->dir);	/* Get object allocation info */
800087e8:	03c42683          	lw	a3,60(s0)
	if (fs->fs_type == FS_FAT32) {
800087ec:	00300593          	li	a1,3
	rv = rv << 8 | ptr[0];
800087f0:	01b6c783          	lbu	a5,27(a3)
800087f4:	01a6c503          	lbu	a0,26(a3)
800087f8:	00879793          	slli	a5,a5,0x8
	cl = ld_word(dir + DIR_FstClusLO);
800087fc:	00a7e7b3          	or	a5,a5,a0
	if (fs->fs_type == FS_FAT32) {
80008800:	04b60e63          	beq	a2,a1,8000885c <f_opendir+0xf0>
						dp->obj.sclust = ld_clust(fs, dp->dir);	/* Get object allocation info */
80008804:	00f42423          	sw	a5,8(s0)
				dp->obj.id = fs->id;
80008808:	00675783          	lhu	a5,6(a4)
				res = dir_sdi(dp, 0);			/* Rewind directory */
8000880c:	00000593          	li	a1,0
80008810:	00040513          	mv	a0,s0
				dp->obj.id = fs->id;
80008814:	00f41223          	sh	a5,4(s0)
				res = dir_sdi(dp, 0);			/* Rewind directory */
80008818:	dc5fb0ef          	jal	ra,800045dc <dir_sdi>
		if (res == FR_NO_FILE) res = FR_NO_PATH;
8000881c:	00400793          	li	a5,4
80008820:	02f50063          	beq	a0,a5,80008840 <f_opendir+0xd4>
	if (res != FR_OK) dp->obj.fs = 0;		/* Invalidate the directory object if function failed */
80008824:	f6051ae3          	bnez	a0,80008798 <f_opendir+0x2c>
}
80008828:	02c12083          	lw	ra,44(sp)
8000882c:	02812403          	lw	s0,40(sp)
80008830:	03010113          	addi	sp,sp,48
80008834:	00008067          	ret
		if (res == FR_NO_FILE) res = FR_NO_PATH;
80008838:	00400793          	li	a5,4
8000883c:	f4f51ee3          	bne	a0,a5,80008798 <f_opendir+0x2c>
					res = FR_NO_PATH;
80008840:	00500513          	li	a0,5
80008844:	f55ff06f          	j	80008798 <f_opendir+0x2c>
}
80008848:	02c12083          	lw	ra,44(sp)
8000884c:	02812403          	lw	s0,40(sp)
	if (!dp) return FR_INVALID_OBJECT;
80008850:	00900513          	li	a0,9
}
80008854:	03010113          	addi	sp,sp,48
80008858:	00008067          	ret
	rv = rv << 8 | ptr[0];
8000885c:	0156c603          	lbu	a2,21(a3)
80008860:	0146c583          	lbu	a1,20(a3)
80008864:	00861693          	slli	a3,a2,0x8
		cl |= (DWORD)ld_word(dir + DIR_FstClusHI) << 16;
80008868:	00b6e6b3          	or	a3,a3,a1
8000886c:	01069693          	slli	a3,a3,0x10
80008870:	00d7e7b3          	or	a5,a5,a3
80008874:	f91ff06f          	j	80008804 <f_opendir+0x98>
						dp->obj.c_size = ((DWORD)dp->obj.objsize & 0xFFFFFF00) | dp->obj.stat;
80008878:	01042783          	lw	a5,16(s0)
8000887c:	00744583          	lbu	a1,7(s0)
						dp->obj.c_scl = dp->obj.sclust;	/* Get containing directory inforamation */
80008880:	00842603          	lw	a2,8(s0)
						dp->obj.c_ofs = dp->blk_ofs;
80008884:	04c42683          	lw	a3,76(s0)
						init_alloc_info(fs, &dp->obj);	/* Get object allocation info */
80008888:	01072503          	lw	a0,16(a4)
						dp->obj.c_size = ((DWORD)dp->obj.objsize & 0xFFFFFF00) | dp->obj.stat;
8000888c:	f007f793          	andi	a5,a5,-256
80008890:	00b7e7b3          	or	a5,a5,a1
						dp->obj.c_scl = dp->obj.sclust;	/* Get containing directory inforamation */
80008894:	02c42023          	sw	a2,32(s0)
						dp->obj.c_size = ((DWORD)dp->obj.objsize & 0xFFFFFF00) | dp->obj.stat;
80008898:	02f42223          	sw	a5,36(s0)
						dp->obj.c_ofs = dp->blk_ofs;
8000889c:	02d42423          	sw	a3,40(s0)
						init_alloc_info(fs, &dp->obj);	/* Get object allocation info */
800088a0:	00040593          	mv	a1,s0
800088a4:	b80fb0ef          	jal	ra,80003c24 <init_alloc_info.isra.4>
800088a8:	01c12703          	lw	a4,28(sp)
800088ac:	f5dff06f          	j	80008808 <f_opendir+0x9c>

800088b0 <f_closedir>:
{
800088b0:	fe010113          	addi	sp,sp,-32
	res = validate(&dp->obj, &fs);	/* Check validity of the file object */
800088b4:	00c10593          	addi	a1,sp,12
{
800088b8:	00812c23          	sw	s0,24(sp)
800088bc:	00112e23          	sw	ra,28(sp)
800088c0:	00050413          	mv	s0,a0
	res = validate(&dp->obj, &fs);	/* Check validity of the file object */
800088c4:	d41fa0ef          	jal	ra,80003604 <validate>
	if (res == FR_OK) {
800088c8:	00051463          	bnez	a0,800088d0 <f_closedir+0x20>
		dp->obj.fs = 0;	/* Invalidate directory object */
800088cc:	00042023          	sw	zero,0(s0)
}
800088d0:	01c12083          	lw	ra,28(sp)
800088d4:	01812403          	lw	s0,24(sp)
800088d8:	02010113          	addi	sp,sp,32
800088dc:	00008067          	ret

800088e0 <f_readdir>:
{
800088e0:	fe010113          	addi	sp,sp,-32
800088e4:	00912a23          	sw	s1,20(sp)
800088e8:	00058493          	mv	s1,a1
	res = validate(&dp->obj, &fs);	/* Check validity of the directory object */
800088ec:	00c10593          	addi	a1,sp,12
{
800088f0:	00812c23          	sw	s0,24(sp)
800088f4:	00112e23          	sw	ra,28(sp)
800088f8:	00050413          	mv	s0,a0
	res = validate(&dp->obj, &fs);	/* Check validity of the directory object */
800088fc:	d09fa0ef          	jal	ra,80003604 <validate>
	if (res == FR_OK) {
80008900:	04051063          	bnez	a0,80008940 <f_readdir+0x60>
		if (!fno) {
80008904:	04048863          	beqz	s1,80008954 <f_readdir+0x74>
			res = DIR_READ_FILE(dp);		/* Read an item */
80008908:	00040513          	mv	a0,s0
8000890c:	f98fd0ef          	jal	ra,800060a4 <dir_read.constprop.12>
			if (res == FR_OK) {				/* A valid entry is found */
80008910:	ffb57793          	andi	a5,a0,-5
80008914:	02079663          	bnez	a5,80008940 <f_readdir+0x60>
				get_fileinfo(dp, fno);		/* Get the object information */
80008918:	00048593          	mv	a1,s1
8000891c:	00040513          	mv	a0,s0
80008920:	df9fa0ef          	jal	ra,80003718 <get_fileinfo>
				res = dir_next(dp, 0);		/* Increment index for next */
80008924:	00000593          	li	a1,0
80008928:	00040513          	mv	a0,s0
8000892c:	86cfd0ef          	jal	ra,80005998 <dir_next>
				if (res == FR_NO_FILE) res = FR_OK;	/* Ignore end of directory now */
80008930:	ffc50793          	addi	a5,a0,-4
80008934:	00f037b3          	snez	a5,a5
80008938:	40f007b3          	neg	a5,a5
8000893c:	00f57533          	and	a0,a0,a5
}
80008940:	01c12083          	lw	ra,28(sp)
80008944:	01812403          	lw	s0,24(sp)
80008948:	01412483          	lw	s1,20(sp)
8000894c:	02010113          	addi	sp,sp,32
80008950:	00008067          	ret
			res = dir_sdi(dp, 0);		/* Rewind the directory object */
80008954:	00040513          	mv	a0,s0
80008958:	00000593          	li	a1,0
8000895c:	c81fb0ef          	jal	ra,800045dc <dir_sdi>
}
80008960:	01c12083          	lw	ra,28(sp)
80008964:	01812403          	lw	s0,24(sp)
80008968:	01412483          	lw	s1,20(sp)
8000896c:	02010113          	addi	sp,sp,32
80008970:	00008067          	ret

80008974 <f_stat>:
{
80008974:	f9010113          	addi	sp,sp,-112
80008978:	06912223          	sw	s1,100(sp)
8000897c:	00a12623          	sw	a0,12(sp)
80008980:	00058493          	mv	s1,a1
	res = mount_volume(&path, &dj.obj.fs, 0);
80008984:	00000613          	li	a2,0
80008988:	01010593          	addi	a1,sp,16
8000898c:	00c10513          	addi	a0,sp,12
{
80008990:	06812423          	sw	s0,104(sp)
80008994:	06112623          	sw	ra,108(sp)
	res = mount_volume(&path, &dj.obj.fs, 0);
80008998:	bacfc0ef          	jal	ra,80004d44 <mount_volume>
8000899c:	00050413          	mv	s0,a0
	if (res == FR_OK) {
800089a0:	00050e63          	beqz	a0,800089bc <f_stat+0x48>
}
800089a4:	00040513          	mv	a0,s0
800089a8:	06c12083          	lw	ra,108(sp)
800089ac:	06812403          	lw	s0,104(sp)
800089b0:	06412483          	lw	s1,100(sp)
800089b4:	07010113          	addi	sp,sp,112
800089b8:	00008067          	ret
		res = follow_path(&dj, path);	/* Follow the file path */
800089bc:	00c12583          	lw	a1,12(sp)
800089c0:	01010513          	addi	a0,sp,16
800089c4:	cedfd0ef          	jal	ra,800066b0 <follow_path>
800089c8:	00050413          	mv	s0,a0
		if (res == FR_OK) {				/* Follow completed */
800089cc:	fc051ce3          	bnez	a0,800089a4 <f_stat+0x30>
			if (dj.fn[NSFLAG] & NS_NONAME) {	/* It is origin directory */
800089d0:	05b10783          	lb	a5,91(sp)
800089d4:	0007cc63          	bltz	a5,800089ec <f_stat+0x78>
				if (fno) get_fileinfo(&dj, fno);
800089d8:	fc0486e3          	beqz	s1,800089a4 <f_stat+0x30>
800089dc:	00048593          	mv	a1,s1
800089e0:	01010513          	addi	a0,sp,16
800089e4:	d35fa0ef          	jal	ra,80003718 <get_fileinfo>
800089e8:	fbdff06f          	j	800089a4 <f_stat+0x30>
				res = FR_INVALID_NAME;
800089ec:	00600413          	li	s0,6
	LEAVE_FF(dj.obj.fs, res);
800089f0:	fb5ff06f          	j	800089a4 <f_stat+0x30>

800089f4 <f_getfree>:
{
800089f4:	f8010113          	addi	sp,sp,-128
800089f8:	06812c23          	sw	s0,120(sp)
800089fc:	07212823          	sw	s2,112(sp)
80008a00:	00a12623          	sw	a0,12(sp)
80008a04:	00058913          	mv	s2,a1
80008a08:	00060413          	mv	s0,a2
	res = mount_volume(&path, &fs, 0);
80008a0c:	01c10593          	addi	a1,sp,28
80008a10:	00000613          	li	a2,0
80008a14:	00c10513          	addi	a0,sp,12
{
80008a18:	06912a23          	sw	s1,116(sp)
80008a1c:	06112e23          	sw	ra,124(sp)
80008a20:	07312623          	sw	s3,108(sp)
80008a24:	07412423          	sw	s4,104(sp)
80008a28:	07512223          	sw	s5,100(sp)
80008a2c:	07612023          	sw	s6,96(sp)
80008a30:	05712e23          	sw	s7,92(sp)
	res = mount_volume(&path, &fs, 0);
80008a34:	b10fc0ef          	jal	ra,80004d44 <mount_volume>
80008a38:	00050493          	mv	s1,a0
	if (res == FR_OK) {
80008a3c:	02051063          	bnez	a0,80008a5c <f_getfree+0x68>
		*fatfs = fs;				/* Return ptr to the fs object */
80008a40:	01c12683          	lw	a3,28(sp)
		if (fs->free_clst <= fs->n_fatent - 2) {
80008a44:	01c6aa03          	lw	s4,28(a3)
80008a48:	0186a783          	lw	a5,24(a3)
		*fatfs = fs;				/* Return ptr to the fs object */
80008a4c:	00d42023          	sw	a3,0(s0)
		if (fs->free_clst <= fs->n_fatent - 2) {
80008a50:	ffea0993          	addi	s3,s4,-2
80008a54:	02f9ec63          	bltu	s3,a5,80008a8c <f_getfree+0x98>
			*nclst = fs->free_clst;
80008a58:	00f92023          	sw	a5,0(s2)
}
80008a5c:	07c12083          	lw	ra,124(sp)
80008a60:	07812403          	lw	s0,120(sp)
80008a64:	00048513          	mv	a0,s1
80008a68:	07012903          	lw	s2,112(sp)
80008a6c:	07412483          	lw	s1,116(sp)
80008a70:	06c12983          	lw	s3,108(sp)
80008a74:	06812a03          	lw	s4,104(sp)
80008a78:	06412a83          	lw	s5,100(sp)
80008a7c:	06012b03          	lw	s6,96(sp)
80008a80:	05c12b83          	lw	s7,92(sp)
80008a84:	08010113          	addi	sp,sp,128
80008a88:	00008067          	ret
			if (fs->fs_type == FS_FAT12) {	/* FAT12: Scan bit field FAT entries */
80008a8c:	0006c783          	lbu	a5,0(a3)
80008a90:	00100713          	li	a4,1
80008a94:	0ae78c63          	beq	a5,a4,80008b4c <f_getfree+0x158>
				if (fs->fs_type == FS_EXFAT) {	/* exFAT: Scan allocation bitmap */
80008a98:	00400713          	li	a4,4
80008a9c:	10e78e63          	beq	a5,a4,80008bb8 <f_getfree+0x1c4>
					sect = fs->fatbase;		/* Top of the FAT */
80008aa0:	0286a803          	lw	a6,40(a3)
							if ((ld_dword(fs->win + i) & 0x0FFFFFFF) == 0) nfree++;
80008aa4:	10000b37          	lui	s6,0x10000
					i = 0;					/* Offset in the sector */
80008aa8:	00000993          	li	s3,0
			nfree = 0;
80008aac:	00000413          	li	s0,0
						if (fs->fs_type == FS_FAT16) {
80008ab0:	00200a93          	li	s5,2
							if ((ld_dword(fs->win + i) & 0x0FFFFFFF) == 0) nfree++;
80008ab4:	fffb0b13          	addi	s6,s6,-1 # fffffff <crtStart-0x70000001>
						if (i == 0) {	/* New sector? */
80008ab8:	02099463          	bnez	s3,80008ae0 <f_getfree+0xec>
	if (sect != fs->winsect) {	/* Window offset changed? */
80008abc:	0386a783          	lw	a5,56(a3)
80008ac0:	00080593          	mv	a1,a6
80008ac4:	00068513          	mv	a0,a3
							res = move_window(fs, sect++);
80008ac8:	00180b93          	addi	s7,a6,1
	if (sect != fs->winsect) {	/* Window offset changed? */
80008acc:	0ef80263          	beq	a6,a5,80008bb0 <f_getfree+0x1bc>
80008ad0:	cc8fb0ef          	jal	ra,80003f98 <move_window.part.6>
							if (res != FR_OK) break;
80008ad4:	16051663          	bnez	a0,80008c40 <f_getfree+0x24c>
80008ad8:	01c12683          	lw	a3,28(sp)
							res = move_window(fs, sect++);
80008adc:	000b8813          	mv	a6,s7
						if (fs->fs_type == FS_FAT16) {
80008ae0:	0006c583          	lbu	a1,0(a3)
80008ae4:	03c68713          	addi	a4,a3,60
80008ae8:	01370733          	add	a4,a4,s3
	rv = rv << 8 | ptr[1];
80008aec:	00174783          	lbu	a5,1(a4)
80008af0:	00074603          	lbu	a2,0(a4)
						if (fs->fs_type == FS_FAT16) {
80008af4:	0b558263          	beq	a1,s5,80008b98 <f_getfree+0x1a4>
	rv = rv << 8 | ptr[2];
80008af8:	00374583          	lbu	a1,3(a4)
80008afc:	00274503          	lbu	a0,2(a4)
							i += 4;
80008b00:	00498993          	addi	s3,s3,4
	rv = rv << 8 | ptr[2];
80008b04:	00859713          	slli	a4,a1,0x8
80008b08:	00a76733          	or	a4,a4,a0
	rv = rv << 8 | ptr[1];
80008b0c:	00871713          	slli	a4,a4,0x8
80008b10:	00e7e7b3          	or	a5,a5,a4
	rv = rv << 8 | ptr[0];
80008b14:	00879793          	slli	a5,a5,0x8
80008b18:	00f667b3          	or	a5,a2,a5
							if ((ld_dword(fs->win + i) & 0x0FFFFFFF) == 0) nfree++;
80008b1c:	0167f7b3          	and	a5,a5,s6
80008b20:	0017b793          	seqz	a5,a5
80008b24:	00f40433          	add	s0,s0,a5
					} while (--clst);
80008b28:	fffa0a13          	addi	s4,s4,-1
						i %= SS(fs);
80008b2c:	1ff9f993          	andi	s3,s3,511
					} while (--clst);
80008b30:	f80a14e3          	bnez	s4,80008ab8 <f_getfree+0xc4>
				*nclst = nfree;			/* Return the free clusters */
80008b34:	00892023          	sw	s0,0(s2)
				fs->fsi_flag |= 1;		/* FAT32: FSInfo is to be updated */
80008b38:	0056c783          	lbu	a5,5(a3)
				fs->free_clst = nfree;	/* Now free_clst is valid */
80008b3c:	0086ac23          	sw	s0,24(a3)
				fs->fsi_flag |= 1;		/* FAT32: FSInfo is to be updated */
80008b40:	0017e793          	ori	a5,a5,1
80008b44:	00f682a3          	sb	a5,5(a3)
80008b48:	f15ff06f          	j	80008a5c <f_getfree+0x68>
				clst = 2; obj.fs = fs;
80008b4c:	02d12023          	sw	a3,32(sp)
			nfree = 0;
80008b50:	00000413          	li	s0,0
				clst = 2; obj.fs = fs;
80008b54:	00200993          	li	s3,2
					if (stat == 0xFFFFFFFF) {
80008b58:	fff00a13          	li	s4,-1
					if (stat == 1) {
80008b5c:	00100a93          	li	s5,1
80008b60:	0180006f          	j	80008b78 <f_getfree+0x184>
80008b64:	0f550263          	beq	a0,s5,80008c48 <f_getfree+0x254>
				} while (++clst < fs->n_fatent);
80008b68:	01c12683          	lw	a3,28(sp)
					if (stat == 0) nfree++;
80008b6c:	00f40433          	add	s0,s0,a5
				} while (++clst < fs->n_fatent);
80008b70:	01c6a783          	lw	a5,28(a3)
80008b74:	fcf9f0e3          	bgeu	s3,a5,80008b34 <f_getfree+0x140>
					stat = get_fat(&obj, clst);
80008b78:	00098593          	mv	a1,s3
80008b7c:	02010513          	addi	a0,sp,32
80008b80:	fb0fb0ef          	jal	ra,80004330 <get_fat>
					if (stat == 0) nfree++;
80008b84:	00153793          	seqz	a5,a0
				} while (++clst < fs->n_fatent);
80008b88:	00198993          	addi	s3,s3,1
					if (stat == 0xFFFFFFFF) {
80008b8c:	fd451ce3          	bne	a0,s4,80008b64 <f_getfree+0x170>
						res = FR_DISK_ERR; break;
80008b90:	00100493          	li	s1,1
80008b94:	ec9ff06f          	j	80008a5c <f_getfree+0x68>
	rv = rv << 8 | ptr[0];
80008b98:	00879793          	slli	a5,a5,0x8
80008b9c:	00c7e7b3          	or	a5,a5,a2
							if (ld_word(fs->win + i) == 0) nfree++;
80008ba0:	0017b793          	seqz	a5,a5
80008ba4:	00f40433          	add	s0,s0,a5
							i += 2;
80008ba8:	00298993          	addi	s3,s3,2
80008bac:	f7dff06f          	j	80008b28 <f_getfree+0x134>
							res = move_window(fs, sect++);
80008bb0:	000b8813          	mv	a6,s7
80008bb4:	f2dff06f          	j	80008ae0 <f_getfree+0xec>
					sect = fs->bitbase;			/* Bitmap sector */
80008bb8:	0346a583          	lw	a1,52(a3)
					i = 0;						/* Offset in the sector */
80008bbc:	00000a13          	li	s4,0
			nfree = 0;
80008bc0:	00000413          	li	s0,0
						if (i == 0) {	/* New sector? */
80008bc4:	020a1263          	bnez	s4,80008be8 <f_getfree+0x1f4>
	if (sect != fs->winsect) {	/* Window offset changed? */
80008bc8:	0386a783          	lw	a5,56(a3)
							res = move_window(fs, sect++);
80008bcc:	00158a93          	addi	s5,a1,1
	if (sect != fs->winsect) {	/* Window offset changed? */
80008bd0:	06f58463          	beq	a1,a5,80008c38 <f_getfree+0x244>
80008bd4:	00068513          	mv	a0,a3
80008bd8:	bc0fb0ef          	jal	ra,80003f98 <move_window.part.6>
							if (res != FR_OK) break;
80008bdc:	06051263          	bnez	a0,80008c40 <f_getfree+0x24c>
80008be0:	01c12683          	lw	a3,28(sp)
							res = move_window(fs, sect++);
80008be4:	000a8593          	mv	a1,s5
						for (b = 8, bm = ~fs->win[i]; b && clst; b--, clst--) {
80008be8:	014687b3          	add	a5,a3,s4
80008bec:	03c7c783          	lbu	a5,60(a5)
80008bf0:	fff7c793          	not	a5,a5
80008bf4:	0ff7f793          	andi	a5,a5,255
80008bf8:	f2098ee3          	beqz	s3,80008b34 <f_getfree+0x140>
							nfree += bm & 1;
80008bfc:	0017f613          	andi	a2,a5,1
						for (b = 8, bm = ~fs->win[i]; b && clst; b--, clst--) {
80008c00:	fff98713          	addi	a4,s3,-1
							nfree += bm & 1;
80008c04:	00c40433          	add	s0,s0,a2
							bm >>= 1;
80008c08:	0017d793          	srli	a5,a5,0x1
80008c0c:	ff898993          	addi	s3,s3,-8
							nfree += bm & 1;
80008c10:	0017f613          	andi	a2,a5,1
						for (b = 8, bm = ~fs->win[i]; b && clst; b--, clst--) {
80008c14:	f20700e3          	beqz	a4,80008b34 <f_getfree+0x140>
80008c18:	fff70713          	addi	a4,a4,-1
							nfree += bm & 1;
80008c1c:	00c40433          	add	s0,s0,a2
							bm >>= 1;
80008c20:	0017d793          	srli	a5,a5,0x1
						for (b = 8, bm = ~fs->win[i]; b && clst; b--, clst--) {
80008c24:	fee996e3          	bne	s3,a4,80008c10 <f_getfree+0x21c>
						i = (i + 1) % SS(fs);
80008c28:	001a0a13          	addi	s4,s4,1
80008c2c:	1ffa7a13          	andi	s4,s4,511
					} while (clst);
80008c30:	f8099ae3          	bnez	s3,80008bc4 <f_getfree+0x1d0>
80008c34:	f01ff06f          	j	80008b34 <f_getfree+0x140>
							res = move_window(fs, sect++);
80008c38:	000a8593          	mv	a1,s5
80008c3c:	fadff06f          	j	80008be8 <f_getfree+0x1f4>
80008c40:	00050493          	mv	s1,a0
	LEAVE_FF(fs, res);
80008c44:	e19ff06f          	j	80008a5c <f_getfree+0x68>
						res = FR_INT_ERR; break;
80008c48:	00200493          	li	s1,2
80008c4c:	e11ff06f          	j	80008a5c <f_getfree+0x68>

80008c50 <f_truncate>:
{
80008c50:	fe010113          	addi	sp,sp,-32
	res = validate(&fp->obj, &fs);	/* Check validity of the file object */
80008c54:	00c10593          	addi	a1,sp,12
{
80008c58:	00812c23          	sw	s0,24(sp)
80008c5c:	00912a23          	sw	s1,20(sp)
80008c60:	00112e23          	sw	ra,28(sp)
80008c64:	00050493          	mv	s1,a0
	res = validate(&fp->obj, &fs);	/* Check validity of the file object */
80008c68:	99dfa0ef          	jal	ra,80003604 <validate>
80008c6c:	00050413          	mv	s0,a0
	if (res != FR_OK || (res = (FRESULT)fp->err) != FR_OK) LEAVE_FF(fs, res);
80008c70:	06051863          	bnez	a0,80008ce0 <f_truncate+0x90>
80008c74:	0314c403          	lbu	s0,49(s1)
80008c78:	06041463          	bnez	s0,80008ce0 <f_truncate+0x90>
	if (!(fp->flag & FA_WRITE)) LEAVE_FF(fs, FR_DENIED);	/* Check access mode */
80008c7c:	0304c783          	lbu	a5,48(s1)
80008c80:	0027f793          	andi	a5,a5,2
80008c84:	08078263          	beqz	a5,80008d08 <f_truncate+0xb8>
	if (fp->fptr < fp->obj.objsize) {	/* Process when fptr is not on the eof */
80008c88:	03c4a783          	lw	a5,60(s1)
80008c8c:	0144a683          	lw	a3,20(s1)
80008c90:	0384a703          	lw	a4,56(s1)
80008c94:	06d7f263          	bgeu	a5,a3,80008cf8 <f_truncate+0xa8>
		if (fp->fptr == 0) {	/* When set file size to zero, remove entire cluster chain */
80008c98:	00f767b3          	or	a5,a4,a5
80008c9c:	06079a63          	bnez	a5,80008d10 <f_truncate+0xc0>
			res = remove_chain(&fp->obj, fp->obj.sclust, 0);
80008ca0:	0084a583          	lw	a1,8(s1)
80008ca4:	00000613          	li	a2,0
80008ca8:	00048513          	mv	a0,s1
80008cac:	d05fb0ef          	jal	ra,800049b0 <remove_chain>
			fp->obj.sclust = 0;
80008cb0:	0004a423          	sw	zero,8(s1)
		fp->flag |= FA_MODIFIED;
80008cb4:	0304c783          	lbu	a5,48(s1)
		fp->obj.objsize = fp->fptr;	/* Set file size to current read/write point */
80008cb8:	0384a603          	lw	a2,56(s1)
80008cbc:	03c4a683          	lw	a3,60(s1)
		fp->flag |= FA_MODIFIED;
80008cc0:	0407e793          	ori	a5,a5,64
		fp->obj.objsize = fp->fptr;	/* Set file size to current read/write point */
80008cc4:	00c4a823          	sw	a2,16(s1)
80008cc8:	00d4aa23          	sw	a3,20(s1)
		fp->flag |= FA_MODIFIED;
80008ccc:	02f48823          	sb	a5,48(s1)
		if (res == FR_OK && (fp->flag & FA_DIRTY)) {
80008cd0:	0e051263          	bnez	a0,80008db4 <f_truncate+0x164>
80008cd4:	01879793          	slli	a5,a5,0x18
80008cd8:	4187d793          	srai	a5,a5,0x18
80008cdc:	0607ce63          	bltz	a5,80008d58 <f_truncate+0x108>
}
80008ce0:	00040513          	mv	a0,s0
80008ce4:	01c12083          	lw	ra,28(sp)
80008ce8:	01812403          	lw	s0,24(sp)
80008cec:	01412483          	lw	s1,20(sp)
80008cf0:	02010113          	addi	sp,sp,32
80008cf4:	00008067          	ret
	if (fp->fptr < fp->obj.objsize) {	/* Process when fptr is not on the eof */
80008cf8:	fef694e3          	bne	a3,a5,80008ce0 <f_truncate+0x90>
80008cfc:	0104a683          	lw	a3,16(s1)
80008d00:	fed770e3          	bgeu	a4,a3,80008ce0 <f_truncate+0x90>
80008d04:	f95ff06f          	j	80008c98 <f_truncate+0x48>
	if (!(fp->flag & FA_WRITE)) LEAVE_FF(fs, FR_DENIED);	/* Check access mode */
80008d08:	00700413          	li	s0,7
80008d0c:	fd5ff06f          	j	80008ce0 <f_truncate+0x90>
			ncl = get_fat(&fp->obj, fp->clust);
80008d10:	0404a583          	lw	a1,64(s1)
80008d14:	00048513          	mv	a0,s1
80008d18:	e18fb0ef          	jal	ra,80004330 <get_fat>
			if (ncl == 0xFFFFFFFF) res = FR_DISK_ERR;
80008d1c:	fff00793          	li	a5,-1
80008d20:	0af50263          	beq	a0,a5,80008dc4 <f_truncate+0x174>
			if (ncl == 1) res = FR_INT_ERR;
80008d24:	00100793          	li	a5,1
80008d28:	06f50063          	beq	a0,a5,80008d88 <f_truncate+0x138>
			if (res == FR_OK && ncl < fs->n_fatent) {
80008d2c:	00c12783          	lw	a5,12(sp)
80008d30:	01c7a783          	lw	a5,28(a5)
80008d34:	08f56e63          	bltu	a0,a5,80008dd0 <f_truncate+0x180>
		fp->flag |= FA_MODIFIED;
80008d38:	0304c783          	lbu	a5,48(s1)
		fp->obj.objsize = fp->fptr;	/* Set file size to current read/write point */
80008d3c:	0384a603          	lw	a2,56(s1)
80008d40:	03c4a683          	lw	a3,60(s1)
		fp->flag |= FA_MODIFIED;
80008d44:	0407e793          	ori	a5,a5,64
		fp->obj.objsize = fp->fptr;	/* Set file size to current read/write point */
80008d48:	00c4a823          	sw	a2,16(s1)
80008d4c:	00d4aa23          	sw	a3,20(s1)
		fp->flag |= FA_MODIFIED;
80008d50:	02f48823          	sb	a5,48(s1)
		if (res == FR_OK && (fp->flag & FA_DIRTY)) {
80008d54:	f81ff06f          	j	80008cd4 <f_truncate+0x84>
			if (disk_write(fs->pdrv, fp->buf, fp->sect, 1) != RES_OK) {
80008d58:	00c12783          	lw	a5,12(sp)
80008d5c:	0444a603          	lw	a2,68(s1)
80008d60:	00100693          	li	a3,1
80008d64:	0017c503          	lbu	a0,1(a5)
80008d68:	05048593          	addi	a1,s1,80
80008d6c:	fccfa0ef          	jal	ra,80003538 <disk_write>
80008d70:	00050413          	mv	s0,a0
80008d74:	06051863          	bnez	a0,80008de4 <f_truncate+0x194>
				fp->flag &= (BYTE)~FA_DIRTY;
80008d78:	0304c783          	lbu	a5,48(s1)
80008d7c:	07f7f793          	andi	a5,a5,127
80008d80:	02f48823          	sb	a5,48(s1)
80008d84:	f5dff06f          	j	80008ce0 <f_truncate+0x90>
			if (ncl == 1) res = FR_INT_ERR;
80008d88:	00200793          	li	a5,2
80008d8c:	00200413          	li	s0,2
		fp->flag |= FA_MODIFIED;
80008d90:	0304c703          	lbu	a4,48(s1)
		fp->obj.objsize = fp->fptr;	/* Set file size to current read/write point */
80008d94:	0384a603          	lw	a2,56(s1)
80008d98:	03c4a683          	lw	a3,60(s1)
		fp->flag |= FA_MODIFIED;
80008d9c:	04076713          	ori	a4,a4,64
		fp->obj.objsize = fp->fptr;	/* Set file size to current read/write point */
80008da0:	00c4a823          	sw	a2,16(s1)
80008da4:	00d4aa23          	sw	a3,20(s1)
		fp->flag |= FA_MODIFIED;
80008da8:	02e48823          	sb	a4,48(s1)
		if (res != FR_OK) ABORT(fs, res);
80008dac:	02f488a3          	sb	a5,49(s1)
80008db0:	f31ff06f          	j	80008ce0 <f_truncate+0x90>
80008db4:	0ff57793          	andi	a5,a0,255
		if (res == FR_OK && (fp->flag & FA_DIRTY)) {
80008db8:	00050413          	mv	s0,a0
		if (res != FR_OK) ABORT(fs, res);
80008dbc:	02f488a3          	sb	a5,49(s1)
80008dc0:	f21ff06f          	j	80008ce0 <f_truncate+0x90>
80008dc4:	00100793          	li	a5,1
			if (ncl == 0xFFFFFFFF) res = FR_DISK_ERR;
80008dc8:	00100413          	li	s0,1
80008dcc:	fc5ff06f          	j	80008d90 <f_truncate+0x140>
				res = remove_chain(&fp->obj, ncl, fp->clust);
80008dd0:	0404a603          	lw	a2,64(s1)
80008dd4:	00050593          	mv	a1,a0
80008dd8:	00048513          	mv	a0,s1
80008ddc:	bd5fb0ef          	jal	ra,800049b0 <remove_chain>
80008de0:	ed5ff06f          	j	80008cb4 <f_truncate+0x64>
80008de4:	00100793          	li	a5,1
				res = FR_DISK_ERR;
80008de8:	00100413          	li	s0,1
		if (res != FR_OK) ABORT(fs, res);
80008dec:	02f488a3          	sb	a5,49(s1)
80008df0:	ef1ff06f          	j	80008ce0 <f_truncate+0x90>

80008df4 <f_unlink>:
{
80008df4:	f0010113          	addi	sp,sp,-256
80008df8:	00a12623          	sw	a0,12(sp)
	res = mount_volume(&path, &fs, FA_WRITE);
80008dfc:	00200613          	li	a2,2
80008e00:	01c10593          	addi	a1,sp,28
80008e04:	00c10513          	addi	a0,sp,12
{
80008e08:	0e112e23          	sw	ra,252(sp)
80008e0c:	0e812c23          	sw	s0,248(sp)
	res = mount_volume(&path, &fs, FA_WRITE);
80008e10:	f35fb0ef          	jal	ra,80004d44 <mount_volume>
	if (res == FR_OK) {
80008e14:	00050a63          	beqz	a0,80008e28 <f_unlink+0x34>
}
80008e18:	0fc12083          	lw	ra,252(sp)
80008e1c:	0f812403          	lw	s0,248(sp)
80008e20:	10010113          	addi	sp,sp,256
80008e24:	00008067          	ret
		dj.obj.fs = fs;
80008e28:	01c12783          	lw	a5,28(sp)
		res = follow_path(&dj, path);		/* Follow the file path */
80008e2c:	00c12583          	lw	a1,12(sp)
80008e30:	05010513          	addi	a0,sp,80
		dj.obj.fs = fs;
80008e34:	04f12823          	sw	a5,80(sp)
		res = follow_path(&dj, path);		/* Follow the file path */
80008e38:	879fd0ef          	jal	ra,800066b0 <follow_path>
		if (res == FR_OK) {					/* The object is accessible */
80008e3c:	fc051ee3          	bnez	a0,80008e18 <f_unlink+0x24>
			if (dj.fn[NSFLAG] & NS_NONAME) {
80008e40:	09b10783          	lb	a5,155(sp)
				res = FR_INVALID_NAME;		/* Cannot remove the origin directory */
80008e44:	00600513          	li	a0,6
			if (dj.fn[NSFLAG] & NS_NONAME) {
80008e48:	fc07c8e3          	bltz	a5,80008e18 <f_unlink+0x24>
				if (dj.obj.attr & AM_RDO) {
80008e4c:	05614783          	lbu	a5,86(sp)
80008e50:	0017f713          	andi	a4,a5,1
80008e54:	0c071263          	bnez	a4,80008f18 <f_unlink+0x124>
				obj.fs = fs;
80008e58:	01c12703          	lw	a4,28(sp)
				if (fs->fs_type == FS_EXFAT) {
80008e5c:	00400613          	li	a2,4
				obj.fs = fs;
80008e60:	02e12023          	sw	a4,32(sp)
				if (fs->fs_type == FS_EXFAT) {
80008e64:	00074683          	lbu	a3,0(a4)
80008e68:	0cc68863          	beq	a3,a2,80008f38 <f_unlink+0x144>
					dclst = ld_clust(fs, dj.dir);
80008e6c:	08c12703          	lw	a4,140(sp)
	if (fs->fs_type == FS_FAT32) {
80008e70:	00300613          	li	a2,3
	rv = rv << 8 | ptr[0];
80008e74:	01b74403          	lbu	s0,27(a4)
80008e78:	01a74583          	lbu	a1,26(a4)
80008e7c:	00841413          	slli	s0,s0,0x8
	cl = ld_word(dir + DIR_FstClusLO);
80008e80:	00b46433          	or	s0,s0,a1
	if (fs->fs_type == FS_FAT32) {
80008e84:	00c69e63          	bne	a3,a2,80008ea0 <f_unlink+0xac>
	rv = rv << 8 | ptr[0];
80008e88:	01574683          	lbu	a3,21(a4)
80008e8c:	01474603          	lbu	a2,20(a4)
80008e90:	00869713          	slli	a4,a3,0x8
		cl |= (DWORD)ld_word(dir + DIR_FstClusHI) << 16;
80008e94:	00c76733          	or	a4,a4,a2
80008e98:	01071713          	slli	a4,a4,0x10
80008e9c:	00e46433          	or	s0,s0,a4
				if (dj.obj.attr & AM_DIR) {			/* Is it a sub-directory? */
80008ea0:	0107f793          	andi	a5,a5,16
80008ea4:	04078c63          	beqz	a5,80008efc <f_unlink+0x108>
						sdj.obj.fs = fs;			/* Open the sub-directory */
80008ea8:	01c12783          	lw	a5,28(sp)
						sdj.obj.sclust = dclst;
80008eac:	0a812423          	sw	s0,168(sp)
						if (fs->fs_type == FS_EXFAT) {
80008eb0:	00400713          	li	a4,4
						sdj.obj.fs = fs;			/* Open the sub-directory */
80008eb4:	0af12023          	sw	a5,160(sp)
						if (fs->fs_type == FS_EXFAT) {
80008eb8:	0007c783          	lbu	a5,0(a5)
80008ebc:	00e79e63          	bne	a5,a4,80008ed8 <f_unlink+0xe4>
							sdj.obj.objsize = obj.objsize;
80008ec0:	03412783          	lw	a5,52(sp)
80008ec4:	03012703          	lw	a4,48(sp)
80008ec8:	0af12a23          	sw	a5,180(sp)
							sdj.obj.stat = obj.stat;
80008ecc:	02714783          	lbu	a5,39(sp)
							sdj.obj.objsize = obj.objsize;
80008ed0:	0ae12823          	sw	a4,176(sp)
							sdj.obj.stat = obj.stat;
80008ed4:	0af103a3          	sb	a5,167(sp)
						res = dir_sdi(&sdj, 0);
80008ed8:	00000593          	li	a1,0
80008edc:	0a010513          	addi	a0,sp,160
80008ee0:	efcfb0ef          	jal	ra,800045dc <dir_sdi>
						if (res == FR_OK) {
80008ee4:	f2051ae3          	bnez	a0,80008e18 <f_unlink+0x24>
							res = DIR_READ_FILE(&sdj);			/* Test if the directory is empty */
80008ee8:	0a010513          	addi	a0,sp,160
80008eec:	9b8fd0ef          	jal	ra,800060a4 <dir_read.constprop.12>
							if (res == FR_OK) res = FR_DENIED;	/* Not empty? */
80008ef0:	02050463          	beqz	a0,80008f18 <f_unlink+0x124>
							if (res == FR_NO_FILE) res = FR_OK;	/* Empty? */
80008ef4:	00400793          	li	a5,4
80008ef8:	f2f510e3          	bne	a0,a5,80008e18 <f_unlink+0x24>
				res = dir_remove(&dj);			/* Remove the directory entry */
80008efc:	05010513          	addi	a0,sp,80
80008f00:	d25fc0ef          	jal	ra,80005c24 <dir_remove>
				if (res == FR_OK && dclst != 0) {	/* Remove the cluster chain if exist */
80008f04:	f0051ae3          	bnez	a0,80008e18 <f_unlink+0x24>
80008f08:	00041c63          	bnez	s0,80008f20 <f_unlink+0x12c>
				if (res == FR_OK) res = sync_fs(fs);
80008f0c:	01c12503          	lw	a0,28(sp)
80008f10:	f61fa0ef          	jal	ra,80003e70 <sync_fs>
80008f14:	f05ff06f          	j	80008e18 <f_unlink+0x24>
					res = FR_DENIED;		/* Cannot remove R/O object */
80008f18:	00700513          	li	a0,7
80008f1c:	efdff06f          	j	80008e18 <f_unlink+0x24>
					res = remove_chain(&obj, dclst, 0);
80008f20:	00000613          	li	a2,0
80008f24:	00040593          	mv	a1,s0
80008f28:	02010513          	addi	a0,sp,32
80008f2c:	a85fb0ef          	jal	ra,800049b0 <remove_chain>
				if (res == FR_OK) res = sync_fs(fs);
80008f30:	ee0514e3          	bnez	a0,80008e18 <f_unlink+0x24>
80008f34:	fd9ff06f          	j	80008f0c <f_unlink+0x118>
					init_alloc_info(fs, &obj);
80008f38:	01072503          	lw	a0,16(a4)
80008f3c:	02010593          	addi	a1,sp,32
80008f40:	ce5fa0ef          	jal	ra,80003c24 <init_alloc_info.isra.4>
					dclst = obj.sclust;
80008f44:	05614783          	lbu	a5,86(sp)
80008f48:	02812403          	lw	s0,40(sp)
80008f4c:	f55ff06f          	j	80008ea0 <f_unlink+0xac>

80008f50 <f_mkdir>:
{
80008f50:	f5010113          	addi	sp,sp,-176
80008f54:	00a12623          	sw	a0,12(sp)
	res = mount_volume(&path, &fs, FA_WRITE);	/* Get logical drive */
80008f58:	00200613          	li	a2,2
80008f5c:	01c10593          	addi	a1,sp,28
80008f60:	00c10513          	addi	a0,sp,12
{
80008f64:	0a812423          	sw	s0,168(sp)
80008f68:	0a112623          	sw	ra,172(sp)
80008f6c:	0a912223          	sw	s1,164(sp)
80008f70:	0b212023          	sw	s2,160(sp)
	res = mount_volume(&path, &fs, FA_WRITE);	/* Get logical drive */
80008f74:	dd1fb0ef          	jal	ra,80004d44 <mount_volume>
80008f78:	00050413          	mv	s0,a0
	if (res == FR_OK) {
80008f7c:	02050063          	beqz	a0,80008f9c <f_mkdir+0x4c>
}
80008f80:	00040513          	mv	a0,s0
80008f84:	0ac12083          	lw	ra,172(sp)
80008f88:	0a812403          	lw	s0,168(sp)
80008f8c:	0a412483          	lw	s1,164(sp)
80008f90:	0a012903          	lw	s2,160(sp)
80008f94:	0b010113          	addi	sp,sp,176
80008f98:	00008067          	ret
		dj.obj.fs = fs;
80008f9c:	01c12783          	lw	a5,28(sp)
		res = follow_path(&dj, path);			/* Follow the file path */
80008fa0:	00c12583          	lw	a1,12(sp)
80008fa4:	05010513          	addi	a0,sp,80
		dj.obj.fs = fs;
80008fa8:	04f12823          	sw	a5,80(sp)
		res = follow_path(&dj, path);			/* Follow the file path */
80008fac:	f04fd0ef          	jal	ra,800066b0 <follow_path>
80008fb0:	00050413          	mv	s0,a0
		if (res == FR_OK) res = FR_EXIST;		/* Name collision? */
80008fb4:	1a050a63          	beqz	a0,80009168 <f_mkdir+0x218>
		if (res == FR_NO_FILE) {				/* It is clear to create a new directory */
80008fb8:	00400493          	li	s1,4
80008fbc:	fc9512e3          	bne	a0,s1,80008f80 <f_mkdir+0x30>
			sobj.fs = fs;						/* New object id to create a new chain */
80008fc0:	01c12783          	lw	a5,28(sp)
			dcl = create_chain(&sobj, 0);		/* Allocate a cluster for the new directory */
80008fc4:	00000593          	li	a1,0
80008fc8:	02010513          	addi	a0,sp,32
			sobj.fs = fs;						/* New object id to create a new chain */
80008fcc:	02f12023          	sw	a5,32(sp)
			dcl = create_chain(&sobj, 0);		/* Allocate a cluster for the new directory */
80008fd0:	e5cfc0ef          	jal	ra,8000562c <create_chain>
80008fd4:	00050913          	mv	s2,a0
			if (dcl == 0) res = FR_DENIED;		/* No space to allocate a new cluster? */
80008fd8:	1a050863          	beqz	a0,80009188 <f_mkdir+0x238>
			if (dcl == 1) res = FR_INT_ERR;		/* Any insanity? */
80008fdc:	00100793          	li	a5,1
80008fe0:	1cf50063          	beq	a0,a5,800091a0 <f_mkdir+0x250>
			if (dcl == 0xFFFFFFFF) res = FR_DISK_ERR;	/* Disk error? */
80008fe4:	fff00793          	li	a5,-1
80008fe8:	26f50e63          	beq	a0,a5,80009264 <f_mkdir+0x314>
				res = dir_clear(fs, dcl);		/* Clean up the new table */
80008fec:	01c12503          	lw	a0,28(sp)
80008ff0:	00090593          	mv	a1,s2
80008ff4:	d8dfa0ef          	jal	ra,80003d80 <dir_clear>
80008ff8:	00050413          	mv	s0,a0
				if (res == FR_OK) {
80008ffc:	18051863          	bnez	a0,8000918c <f_mkdir+0x23c>
					if (!FF_FS_EXFAT || fs->fs_type != FS_EXFAT) {	/* Create dot entries (FAT only) */
80009000:	01c12503          	lw	a0,28(sp)
80009004:	00054783          	lbu	a5,0(a0)
80009008:	0c978463          	beq	a5,s1,800090d0 <f_mkdir+0x180>
						memset(fs->win + DIR_Name, ' ', 11);	/* Create "." entry */
8000900c:	02000593          	li	a1,32
80009010:	00b00613          	li	a2,11
80009014:	03c50513          	addi	a0,a0,60
80009018:	f08f90ef          	jal	ra,80002720 <memset>
						fs->win[DIR_Name] = '.';
8000901c:	01c12503          	lw	a0,28(sp)
80009020:	02e00693          	li	a3,46
	*ptr++ = (BYTE)val; val >>= 8;
80009024:	01091793          	slli	a5,s2,0x10
						fs->win[DIR_Name] = '.';
80009028:	02d50e23          	sb	a3,60(a0)
						fs->win[DIR_Attr] = AM_DIR;
8000902c:	01000693          	li	a3,16
	*ptr++ = (BYTE)val; val >>= 8;
80009030:	0107d793          	srli	a5,a5,0x10
						fs->win[DIR_Attr] = AM_DIR;
80009034:	04d503a3          	sb	a3,71(a0)
	if (fs->fs_type == FS_FAT32) {
80009038:	00054703          	lbu	a4,0(a0)
	*ptr++ = (BYTE)val; val >>= 8;
8000903c:	03500693          	li	a3,53
	*ptr++ = (BYTE)val; val >>= 8;
80009040:	0087d793          	srli	a5,a5,0x8
	*ptr++ = (BYTE)val; val >>= 8;
80009044:	04d50a23          	sb	a3,84(a0)
	*ptr++ = (BYTE)val;
80009048:	05800693          	li	a3,88
	*ptr++ = (BYTE)val;
8000904c:	04f50ba3          	sb	a5,87(a0)
	*ptr++ = (BYTE)val; val >>= 8;
80009050:	04050923          	sb	zero,82(a0)
	*ptr++ = (BYTE)val; val >>= 8;
80009054:	040509a3          	sb	zero,83(a0)
	*ptr++ = (BYTE)val;
80009058:	04d50aa3          	sb	a3,85(a0)
	*ptr++ = (BYTE)val; val >>= 8;
8000905c:	05250b23          	sb	s2,86(a0)
	if (fs->fs_type == FS_FAT32) {
80009060:	00300793          	li	a5,3
						st_clust(fs, fs->win, dcl);
80009064:	03c50593          	addi	a1,a0,60
	if (fs->fs_type == FS_FAT32) {
80009068:	00f71a63          	bne	a4,a5,8000907c <f_mkdir+0x12c>
		st_word(dir + DIR_FstClusHI, (WORD)(cl >> 16));
8000906c:	01095793          	srli	a5,s2,0x10
	*ptr++ = (BYTE)val; val >>= 8;
80009070:	0087d713          	srli	a4,a5,0x8
80009074:	04f50823          	sb	a5,80(a0)
	*ptr++ = (BYTE)val;
80009078:	04e508a3          	sb	a4,81(a0)
						memcpy(fs->win + SZDIRE, fs->win, SZDIRE);	/* Create ".." entry */
8000907c:	02000613          	li	a2,32
80009080:	05c50513          	addi	a0,a0,92
80009084:	e24f90ef          	jal	ra,800026a8 <memcpy>
						fs->win[SZDIRE + 1] = '.'; pcl = dj.obj.sclust;
80009088:	05812703          	lw	a4,88(sp)
8000908c:	01c12783          	lw	a5,28(sp)
80009090:	02e00593          	li	a1,46
	*ptr++ = (BYTE)val; val >>= 8;
80009094:	01071693          	slli	a3,a4,0x10
80009098:	0106d693          	srli	a3,a3,0x10
	if (fs->fs_type == FS_FAT32) {
8000909c:	0007c603          	lbu	a2,0(a5)
	*ptr++ = (BYTE)val; val >>= 8;
800090a0:	0086d693          	srli	a3,a3,0x8
	*ptr++ = (BYTE)val;
800090a4:	06d78ba3          	sb	a3,119(a5)
						fs->win[SZDIRE + 1] = '.'; pcl = dj.obj.sclust;
800090a8:	04b78ea3          	sb	a1,93(a5)
	*ptr++ = (BYTE)val; val >>= 8;
800090ac:	06e78b23          	sb	a4,118(a5)
	if (fs->fs_type == FS_FAT32) {
800090b0:	00300693          	li	a3,3
800090b4:	00d61a63          	bne	a2,a3,800090c8 <f_mkdir+0x178>
		st_word(dir + DIR_FstClusHI, (WORD)(cl >> 16));
800090b8:	01075713          	srli	a4,a4,0x10
	*ptr++ = (BYTE)val; val >>= 8;
800090bc:	00875693          	srli	a3,a4,0x8
800090c0:	06e78823          	sb	a4,112(a5)
	*ptr++ = (BYTE)val;
800090c4:	06d788a3          	sb	a3,113(a5)
						fs->wflag = 1;
800090c8:	00100713          	li	a4,1
800090cc:	00e78223          	sb	a4,4(a5)
					res = dir_register(&dj);	/* Register the object to the parent directoy */
800090d0:	05010513          	addi	a0,sp,80
800090d4:	b8dfd0ef          	jal	ra,80006c60 <dir_register>
800090d8:	00050413          	mv	s0,a0
			if (res == FR_OK) {
800090dc:	0a051863          	bnez	a0,8000918c <f_mkdir+0x23c>
				if (fs->fs_type == FS_EXFAT) {	/* Initialize directory entry block */
800090e0:	01c12603          	lw	a2,28(sp)
800090e4:	00400793          	li	a5,4
800090e8:	0ff97693          	andi	a3,s2,255
800090ec:	00064703          	lbu	a4,0(a2)
800090f0:	0af70c63          	beq	a4,a5,800091a8 <f_mkdir+0x258>
					st_dword(dj.dir + DIR_ModTime, tm);	/* Created time */
800090f4:	08c12783          	lw	a5,140(sp)
	*ptr++ = (BYTE)val; val >>= 8;
800090f8:	03500713          	li	a4,53
800090fc:	00e78c23          	sb	a4,24(a5)
	*ptr++ = (BYTE)val;
80009100:	05800713          	li	a4,88
	*ptr++ = (BYTE)val; val >>= 8;
80009104:	00078b23          	sb	zero,22(a5)
	*ptr++ = (BYTE)val; val >>= 8;
80009108:	00078ba3          	sb	zero,23(a5)
	*ptr++ = (BYTE)val;
8000910c:	00e78ca3          	sb	a4,25(a5)
					st_clust(fs, dj.dir, dcl);			/* Table start cluster */
80009110:	08c12703          	lw	a4,140(sp)
	*ptr++ = (BYTE)val; val >>= 8;
80009114:	01091793          	slli	a5,s2,0x10
80009118:	0107d793          	srli	a5,a5,0x10
8000911c:	0087d793          	srli	a5,a5,0x8
	*ptr++ = (BYTE)val;
80009120:	00f70da3          	sb	a5,27(a4)
	*ptr++ = (BYTE)val; val >>= 8;
80009124:	00d70d23          	sb	a3,26(a4)
	if (fs->fs_type == FS_FAT32) {
80009128:	00064683          	lbu	a3,0(a2)
8000912c:	00300793          	li	a5,3
80009130:	00f69a63          	bne	a3,a5,80009144 <f_mkdir+0x1f4>
		st_word(dir + DIR_FstClusHI, (WORD)(cl >> 16));
80009134:	01095913          	srli	s2,s2,0x10
	*ptr++ = (BYTE)val; val >>= 8;
80009138:	00895793          	srli	a5,s2,0x8
8000913c:	01270a23          	sb	s2,20(a4)
	*ptr++ = (BYTE)val;
80009140:	00f70aa3          	sb	a5,21(a4)
					dj.dir[DIR_Attr] = AM_DIR;			/* Attribute */
80009144:	08c12783          	lw	a5,140(sp)
80009148:	01000713          	li	a4,16
8000914c:	00e785a3          	sb	a4,11(a5)
					fs->wflag = 1;
80009150:	00100793          	li	a5,1
80009154:	00f60223          	sb	a5,4(a2)
					res = sync_fs(fs);
80009158:	00060513          	mv	a0,a2
8000915c:	d15fa0ef          	jal	ra,80003e70 <sync_fs>
80009160:	00050413          	mv	s0,a0
80009164:	e1dff06f          	j	80008f80 <f_mkdir+0x30>
		if (res == FR_OK) res = FR_EXIST;		/* Name collision? */
80009168:	00800413          	li	s0,8
}
8000916c:	00040513          	mv	a0,s0
80009170:	0ac12083          	lw	ra,172(sp)
80009174:	0a812403          	lw	s0,168(sp)
80009178:	0a412483          	lw	s1,164(sp)
8000917c:	0a012903          	lw	s2,160(sp)
80009180:	0b010113          	addi	sp,sp,176
80009184:	00008067          	ret
			if (dcl == 0) res = FR_DENIED;		/* No space to allocate a new cluster? */
80009188:	00700413          	li	s0,7
				remove_chain(&sobj, dcl, 0);		/* Could not register, remove the allocated cluster */
8000918c:	00000613          	li	a2,0
80009190:	00090593          	mv	a1,s2
80009194:	02010513          	addi	a0,sp,32
80009198:	819fb0ef          	jal	ra,800049b0 <remove_chain>
8000919c:	de5ff06f          	j	80008f80 <f_mkdir+0x30>
			if (dcl == 1) res = FR_INT_ERR;		/* Any insanity? */
800091a0:	00200413          	li	s0,2
800091a4:	fe9ff06f          	j	8000918c <f_mkdir+0x23c>
					st_dword(fs->dirbuf + XDIR_ModTime, tm);	/* Created time */
800091a8:	01062783          	lw	a5,16(a2)
	*ptr++ = (BYTE)val; val >>= 8;
800091ac:	03500713          	li	a4,53
	*ptr++ = (BYTE)val; val >>= 8;
800091b0:	00895593          	srli	a1,s2,0x8
	*ptr++ = (BYTE)val; val >>= 8;
800091b4:	00e78723          	sb	a4,14(a5)
	*ptr++ = (BYTE)val;
800091b8:	05800713          	li	a4,88
800091bc:	00e787a3          	sb	a4,15(a5)
	*ptr++ = (BYTE)val; val >>= 8;
800091c0:	00078623          	sb	zero,12(a5)
	*ptr++ = (BYTE)val; val >>= 8;
800091c4:	000786a3          	sb	zero,13(a5)
					st_dword(fs->dirbuf + XDIR_FstClus, dcl);	/* Table start cluster */
800091c8:	01062783          	lw	a5,16(a2)
	*ptr++ = (BYTE)val; val >>= 8;
800091cc:	01095713          	srli	a4,s2,0x10
	*ptr++ = (BYTE)val; val >>= 8;
800091d0:	01895913          	srli	s2,s2,0x18
	*ptr++ = (BYTE)val; val >>= 8;
800091d4:	02d78a23          	sb	a3,52(a5)
	*ptr++ = (BYTE)val; val >>= 8;
800091d8:	02b78aa3          	sb	a1,53(a5)
	*ptr++ = (BYTE)val; val >>= 8;
800091dc:	02e78b23          	sb	a4,54(a5)
	*ptr++ = (BYTE)val;
800091e0:	03278ba3          	sb	s2,55(a5)
					st_dword(fs->dirbuf + XDIR_FileSize, (DWORD)fs->csize * SS(fs));	/* Directory size needs to be valid */
800091e4:	00a65783          	lhu	a5,10(a2)
800091e8:	01062703          	lw	a4,16(a2)
					res = store_xdir(&dj);
800091ec:	05010513          	addi	a0,sp,80
					st_dword(fs->dirbuf + XDIR_FileSize, (DWORD)fs->csize * SS(fs));	/* Directory size needs to be valid */
800091f0:	00979793          	slli	a5,a5,0x9
	*ptr++ = (BYTE)val; val >>= 8;
800091f4:	0087d593          	srli	a1,a5,0x8
	*ptr++ = (BYTE)val; val >>= 8;
800091f8:	0107d693          	srli	a3,a5,0x10
	*ptr++ = (BYTE)val; val >>= 8;
800091fc:	0187d793          	srli	a5,a5,0x18
	*ptr++ = (BYTE)val; val >>= 8;
80009200:	02b70ca3          	sb	a1,57(a4)
	*ptr++ = (BYTE)val; val >>= 8;
80009204:	02d70d23          	sb	a3,58(a4)
	*ptr++ = (BYTE)val; val >>= 8;
80009208:	02070c23          	sb	zero,56(a4)
	*ptr++ = (BYTE)val;
8000920c:	02f70da3          	sb	a5,59(a4)
					st_dword(fs->dirbuf + XDIR_ValidFileSize, (DWORD)fs->csize * SS(fs));
80009210:	00a65783          	lhu	a5,10(a2)
80009214:	01062703          	lw	a4,16(a2)
80009218:	00979793          	slli	a5,a5,0x9
	*ptr++ = (BYTE)val; val >>= 8;
8000921c:	0087d593          	srli	a1,a5,0x8
	*ptr++ = (BYTE)val; val >>= 8;
80009220:	0107d693          	srli	a3,a5,0x10
	*ptr++ = (BYTE)val; val >>= 8;
80009224:	0187d793          	srli	a5,a5,0x18
	*ptr++ = (BYTE)val; val >>= 8;
80009228:	02070423          	sb	zero,40(a4)
	*ptr++ = (BYTE)val; val >>= 8;
8000922c:	02b704a3          	sb	a1,41(a4)
	*ptr++ = (BYTE)val; val >>= 8;
80009230:	02d70523          	sb	a3,42(a4)
	*ptr++ = (BYTE)val;
80009234:	02f705a3          	sb	a5,43(a4)
					fs->dirbuf[XDIR_GenFlags] = 3;				/* Initialize the object flag */
80009238:	01062783          	lw	a5,16(a2)
8000923c:	00300713          	li	a4,3
80009240:	02e780a3          	sb	a4,33(a5)
					fs->dirbuf[XDIR_Attr] = AM_DIR;				/* Attribute */
80009244:	01062783          	lw	a5,16(a2)
80009248:	01000713          	li	a4,16
8000924c:	00e78223          	sb	a4,4(a5)
					res = store_xdir(&dj);
80009250:	cf1fc0ef          	jal	ra,80005f40 <store_xdir>
80009254:	00050413          	mv	s0,a0
				if (res == FR_OK) {
80009258:	d20514e3          	bnez	a0,80008f80 <f_mkdir+0x30>
8000925c:	01c12603          	lw	a2,28(sp)
80009260:	ef9ff06f          	j	80009158 <f_mkdir+0x208>
			if (dcl == 0xFFFFFFFF) res = FR_DISK_ERR;	/* Disk error? */
80009264:	00100413          	li	s0,1
80009268:	f25ff06f          	j	8000918c <f_mkdir+0x23c>

8000926c <f_rename>:
{
8000926c:	ee010113          	addi	sp,sp,-288
80009270:	00a12623          	sw	a0,12(sp)
	get_ldnumber(&path_new);						/* Snip the drive number of new name off */
80009274:	00810513          	addi	a0,sp,8
{
80009278:	10112e23          	sw	ra,284(sp)
8000927c:	10812c23          	sw	s0,280(sp)
80009280:	00b12423          	sw	a1,8(sp)
80009284:	10912a23          	sw	s1,276(sp)
80009288:	11212823          	sw	s2,272(sp)
8000928c:	11312623          	sw	s3,268(sp)
	get_ldnumber(&path_new);						/* Snip the drive number of new name off */
80009290:	b10fa0ef          	jal	ra,800035a0 <get_ldnumber>
	res = mount_volume(&path_old, &fs, FA_WRITE);	/* Get logical drive of the old object */
80009294:	00200613          	li	a2,2
80009298:	01c10593          	addi	a1,sp,28
8000929c:	00c10513          	addi	a0,sp,12
800092a0:	aa5fb0ef          	jal	ra,80004d44 <mount_volume>
800092a4:	00050413          	mv	s0,a0
	if (res == FR_OK) {
800092a8:	02050263          	beqz	a0,800092cc <f_rename+0x60>
}
800092ac:	00040513          	mv	a0,s0
800092b0:	11c12083          	lw	ra,284(sp)
800092b4:	11812403          	lw	s0,280(sp)
800092b8:	11412483          	lw	s1,276(sp)
800092bc:	11012903          	lw	s2,272(sp)
800092c0:	10c12983          	lw	s3,268(sp)
800092c4:	12010113          	addi	sp,sp,288
800092c8:	00008067          	ret
		djo.obj.fs = fs;
800092cc:	01c12783          	lw	a5,28(sp)
		res = follow_path(&djo, path_old);			/* Check old object */
800092d0:	00c12583          	lw	a1,12(sp)
800092d4:	06010513          	addi	a0,sp,96
		djo.obj.fs = fs;
800092d8:	06f12023          	sw	a5,96(sp)
		res = follow_path(&djo, path_old);			/* Check old object */
800092dc:	bd4fd0ef          	jal	ra,800066b0 <follow_path>
800092e0:	00050413          	mv	s0,a0
		if (res == FR_OK && (djo.fn[NSFLAG] & (NS_DOT | NS_NONAME))) res = FR_INVALID_NAME;	/* Check validity of name */
800092e4:	fc0514e3          	bnez	a0,800092ac <f_rename+0x40>
800092e8:	0ab14783          	lbu	a5,171(sp)
800092ec:	00600413          	li	s0,6
800092f0:	0a07f793          	andi	a5,a5,160
800092f4:	fa079ce3          	bnez	a5,800092ac <f_rename+0x40>
			if (fs->fs_type == FS_EXFAT) {	/* At exFAT volume */
800092f8:	01c12783          	lw	a5,28(sp)
800092fc:	00400913          	li	s2,4
80009300:	0007c983          	lbu	s3,0(a5)
80009304:	17298463          	beq	s3,s2,8000946c <f_rename+0x200>
				memcpy(buf, djo.dir, SZDIRE);			/* Save directory entry of the object */
80009308:	09c12583          	lw	a1,156(sp)
8000930c:	02000613          	li	a2,32
80009310:	02010513          	addi	a0,sp,32
80009314:	b94f90ef          	jal	ra,800026a8 <memcpy>
				memcpy(&djn, &djo, sizeof (DIR));		/* Duplicate the directory object */
80009318:	0b010493          	addi	s1,sp,176
8000931c:	05000613          	li	a2,80
80009320:	06010593          	addi	a1,sp,96
80009324:	00048513          	mv	a0,s1
80009328:	b80f90ef          	jal	ra,800026a8 <memcpy>
				res = follow_path(&djn, path_new);		/* Make sure if new object name is not in use */
8000932c:	00812583          	lw	a1,8(sp)
80009330:	00048513          	mv	a0,s1
80009334:	b7cfd0ef          	jal	ra,800066b0 <follow_path>
80009338:	00050413          	mv	s0,a0
				if (res == FR_OK) {						/* Is new name already in use by any other object? */
8000933c:	10050463          	beqz	a0,80009444 <f_rename+0x1d8>
				if (res == FR_NO_FILE) { 				/* It is a valid path and no name collision */
80009340:	f72516e3          	bne	a0,s2,800092ac <f_rename+0x40>
					res = dir_register(&djn);			/* Register the new entry */
80009344:	00048513          	mv	a0,s1
80009348:	919fd0ef          	jal	ra,80006c60 <dir_register>
8000934c:	00050413          	mv	s0,a0
					if (res == FR_OK) {
80009350:	f4051ee3          	bnez	a0,800092ac <f_rename+0x40>
						dir = djn.dir;					/* Copy directory entry of the object except name */
80009354:	0ec12403          	lw	s0,236(sp)
						memcpy(dir + 13, buf + 13, SZDIRE - 13);
80009358:	01300613          	li	a2,19
8000935c:	02d10593          	addi	a1,sp,45
80009360:	00d40513          	addi	a0,s0,13
80009364:	b44f90ef          	jal	ra,800026a8 <memcpy>
						dir[DIR_Attr] = buf[DIR_Attr];
80009368:	02b14783          	lbu	a5,43(sp)
						if (!(dir[DIR_Attr] & AM_DIR)) dir[DIR_Attr] |= AM_ARC;	/* Set archive attribute if it is a file */
8000936c:	0107f713          	andi	a4,a5,16
80009370:	00071463          	bnez	a4,80009378 <f_rename+0x10c>
80009374:	0207e793          	ori	a5,a5,32
						fs->wflag = 1;
80009378:	01c12483          	lw	s1,28(sp)
						if (!(dir[DIR_Attr] & AM_DIR)) dir[DIR_Attr] |= AM_ARC;	/* Set archive attribute if it is a file */
8000937c:	00f405a3          	sb	a5,11(s0)
						fs->wflag = 1;
80009380:	00100793          	li	a5,1
80009384:	00f48223          	sb	a5,4(s1)
						if ((dir[DIR_Attr] & AM_DIR) && djo.obj.sclust != djn.obj.sclust) {	/* Update .. entry in the sub-directory if needed */
80009388:	00b44783          	lbu	a5,11(s0)
8000938c:	0107f793          	andi	a5,a5,16
80009390:	08078a63          	beqz	a5,80009424 <f_rename+0x1b8>
80009394:	06812783          	lw	a5,104(sp)
80009398:	0b812903          	lw	s2,184(sp)
8000939c:	09278463          	beq	a5,s2,80009424 <f_rename+0x1b8>
	rv = rv << 8 | ptr[0];
800093a0:	01b44783          	lbu	a5,27(s0)
800093a4:	01a44603          	lbu	a2,26(s0)
	if (fs->fs_type == FS_FAT32) {
800093a8:	0004c683          	lbu	a3,0(s1)
	rv = rv << 8 | ptr[0];
800093ac:	00879793          	slli	a5,a5,0x8
	if (fs->fs_type == FS_FAT32) {
800093b0:	00300713          	li	a4,3
	cl = ld_word(dir + DIR_FstClusLO);
800093b4:	00c7e7b3          	or	a5,a5,a2
	if (fs->fs_type == FS_FAT32) {
800093b8:	00e69e63          	bne	a3,a4,800093d4 <f_rename+0x168>
	rv = rv << 8 | ptr[0];
800093bc:	01544703          	lbu	a4,21(s0)
800093c0:	01444683          	lbu	a3,20(s0)
800093c4:	00871713          	slli	a4,a4,0x8
		cl |= (DWORD)ld_word(dir + DIR_FstClusHI) << 16;
800093c8:	00d76733          	or	a4,a4,a3
800093cc:	01071713          	slli	a4,a4,0x10
800093d0:	00e7e7b3          	or	a5,a5,a4
	if (clst >= fs->n_fatent - 2) return 0;		/* Is it invalid cluster number? */
800093d4:	01c4a703          	lw	a4,28(s1)
	clst -= 2;		/* Cluster number is origin from 2 */
800093d8:	ffe78593          	addi	a1,a5,-2
	if (clst >= fs->n_fatent - 2) return 0;		/* Is it invalid cluster number? */
800093dc:	00200413          	li	s0,2
800093e0:	ffe70793          	addi	a5,a4,-2
800093e4:	ecf5f4e3          	bgeu	a1,a5,800092ac <f_rename+0x40>
	return fs->database + (LBA_t)fs->csize * clst;	/* Start sector number of the cluster */
800093e8:	00a4d503          	lhu	a0,10(s1)
800093ec:	5b8040ef          	jal	ra,8000d9a4 <__mulsi3>
800093f0:	0304a583          	lw	a1,48(s1)
800093f4:	00b505b3          	add	a1,a0,a1
							if (sect == 0) {
800093f8:	ea058ae3          	beqz	a1,800092ac <f_rename+0x40>
	if (sect != fs->winsect) {	/* Window offset changed? */
800093fc:	0384a783          	lw	a5,56(s1)
80009400:	16f58463          	beq	a1,a5,80009568 <f_rename+0x2fc>
80009404:	00048513          	mv	a0,s1
80009408:	b91fa0ef          	jal	ra,80003f98 <move_window.part.6>
8000940c:	00050413          	mv	s0,a0
								if (res == FR_OK && dir[1] == '.') {
80009410:	e8051ee3          	bnez	a0,800092ac <f_rename+0x40>
								dir = fs->win + SZDIRE * 1;	/* Ptr to .. entry */
80009414:	01c12483          	lw	s1,28(sp)
								if (res == FR_OK && dir[1] == '.') {
80009418:	02e00793          	li	a5,46
8000941c:	05d4c703          	lbu	a4,93(s1)
80009420:	18f70863          	beq	a4,a5,800095b0 <f_rename+0x344>
				res = dir_remove(&djo);		/* Remove old entry */
80009424:	06010513          	addi	a0,sp,96
80009428:	ffcfc0ef          	jal	ra,80005c24 <dir_remove>
8000942c:	00050413          	mv	s0,a0
				if (res == FR_OK) {
80009430:	e6051ee3          	bnez	a0,800092ac <f_rename+0x40>
					res = sync_fs(fs);
80009434:	01c12503          	lw	a0,28(sp)
80009438:	a39fa0ef          	jal	ra,80003e70 <sync_fs>
8000943c:	00050413          	mv	s0,a0
80009440:	e6dff06f          	j	800092ac <f_rename+0x40>
					res = (djn.obj.sclust == djo.obj.sclust && djn.dptr == djo.dptr) ? FR_NO_FILE : FR_EXIST;
80009444:	0b812703          	lw	a4,184(sp)
80009448:	06812783          	lw	a5,104(sp)
8000944c:	00f70663          	beq	a4,a5,80009458 <f_rename+0x1ec>
	if (clst >= fs->n_fatent - 2) return 0;		/* Is it invalid cluster number? */
80009450:	00800413          	li	s0,8
80009454:	e59ff06f          	j	800092ac <f_rename+0x40>
					res = (djn.obj.sclust == djo.obj.sclust && djn.dptr == djo.dptr) ? FR_NO_FILE : FR_EXIST;
80009458:	0e012703          	lw	a4,224(sp)
8000945c:	09012783          	lw	a5,144(sp)
80009460:	eef702e3          	beq	a4,a5,80009344 <f_rename+0xd8>
	if (clst >= fs->n_fatent - 2) return 0;		/* Is it invalid cluster number? */
80009464:	00800413          	li	s0,8
80009468:	e45ff06f          	j	800092ac <f_rename+0x40>
				memcpy(buf, fs->dirbuf, SZDIRE * 2);	/* Save 85+C0 entry of old object */
8000946c:	0107a583          	lw	a1,16(a5)
80009470:	04000613          	li	a2,64
80009474:	02010513          	addi	a0,sp,32
80009478:	a30f90ef          	jal	ra,800026a8 <memcpy>
				memcpy(&djn, &djo, sizeof djo);
8000947c:	0b010493          	addi	s1,sp,176
80009480:	05000613          	li	a2,80
80009484:	06010593          	addi	a1,sp,96
80009488:	00048513          	mv	a0,s1
8000948c:	a1cf90ef          	jal	ra,800026a8 <memcpy>
				res = follow_path(&djn, path_new);		/* Make sure if new object name is not in use */
80009490:	00812583          	lw	a1,8(sp)
80009494:	00048513          	mv	a0,s1
80009498:	a18fd0ef          	jal	ra,800066b0 <follow_path>
8000949c:	00050413          	mv	s0,a0
				if (res == FR_OK) {						/* Is new name already in use by any other object? */
800094a0:	0c051063          	bnez	a0,80009560 <f_rename+0x2f4>
					res = (djn.obj.sclust == djo.obj.sclust && djn.dptr == djo.dptr) ? FR_NO_FILE : FR_EXIST;
800094a4:	0b812703          	lw	a4,184(sp)
800094a8:	06812783          	lw	a5,104(sp)
800094ac:	faf712e3          	bne	a4,a5,80009450 <f_rename+0x1e4>
800094b0:	0e012703          	lw	a4,224(sp)
800094b4:	09012783          	lw	a5,144(sp)
800094b8:	f8f71ce3          	bne	a4,a5,80009450 <f_rename+0x1e4>
					res = dir_register(&djn);			/* Register the new entry */
800094bc:	00048513          	mv	a0,s1
800094c0:	fa0fd0ef          	jal	ra,80006c60 <dir_register>
800094c4:	00050413          	mv	s0,a0
					if (res == FR_OK) {
800094c8:	de0512e3          	bnez	a0,800092ac <f_rename+0x40>
						nf = fs->dirbuf[XDIR_NumSec]; nn = fs->dirbuf[XDIR_NumName];
800094cc:	01c12783          	lw	a5,28(sp)
						memcpy(fs->dirbuf, buf, SZDIRE * 2);	/* Restore 85+C0 entry */
800094d0:	04000613          	li	a2,64
800094d4:	02010593          	addi	a1,sp,32
						nf = fs->dirbuf[XDIR_NumSec]; nn = fs->dirbuf[XDIR_NumName];
800094d8:	0107a783          	lw	a5,16(a5)
	rv = rv << 8 | ptr[0];
800094dc:	0257c403          	lbu	s0,37(a5)
800094e0:	0247c703          	lbu	a4,36(a5)
						memcpy(fs->dirbuf, buf, SZDIRE * 2);	/* Restore 85+C0 entry */
800094e4:	00078513          	mv	a0,a5
	rv = rv << 8 | ptr[0];
800094e8:	00841413          	slli	s0,s0,0x8
800094ec:	00e46433          	or	s0,s0,a4
						nf = fs->dirbuf[XDIR_NumSec]; nn = fs->dirbuf[XDIR_NumName];
800094f0:	0017c983          	lbu	s3,1(a5)
800094f4:	0237c903          	lbu	s2,35(a5)
						memcpy(fs->dirbuf, buf, SZDIRE * 2);	/* Restore 85+C0 entry */
800094f8:	9b0f90ef          	jal	ra,800026a8 <memcpy>
						fs->dirbuf[XDIR_NumSec] = nf; fs->dirbuf[XDIR_NumName] = nn;
800094fc:	01c12783          	lw	a5,28(sp)
	rv = rv << 8 | ptr[0];
80009500:	01041413          	slli	s0,s0,0x10
80009504:	41045413          	srai	s0,s0,0x10
						fs->dirbuf[XDIR_NumSec] = nf; fs->dirbuf[XDIR_NumName] = nn;
80009508:	0107a783          	lw	a5,16(a5)
	*ptr++ = (BYTE)val; val >>= 8;
8000950c:	01041713          	slli	a4,s0,0x10
80009510:	01075713          	srli	a4,a4,0x10
						fs->dirbuf[XDIR_NumSec] = nf; fs->dirbuf[XDIR_NumName] = nn;
80009514:	013780a3          	sb	s3,1(a5)
80009518:	01c12783          	lw	a5,28(sp)
	*ptr++ = (BYTE)val; val >>= 8;
8000951c:	00875713          	srli	a4,a4,0x8
						fs->dirbuf[XDIR_NumSec] = nf; fs->dirbuf[XDIR_NumName] = nn;
80009520:	0107a683          	lw	a3,16(a5)
80009524:	032681a3          	sb	s2,35(a3)
						st_word(fs->dirbuf + XDIR_NameHash, nh);
80009528:	0107a683          	lw	a3,16(a5)
	*ptr++ = (BYTE)val; val >>= 8;
8000952c:	02868223          	sb	s0,36(a3)
	*ptr++ = (BYTE)val;
80009530:	02e682a3          	sb	a4,37(a3)
						if (!(fs->dirbuf[XDIR_Attr] & AM_DIR)) fs->dirbuf[XDIR_Attr] |= AM_ARC;	/* Set archive attribute if it is a file */
80009534:	0107a703          	lw	a4,16(a5)
80009538:	00474783          	lbu	a5,4(a4)
8000953c:	0107f693          	andi	a3,a5,16
80009540:	00069663          	bnez	a3,8000954c <f_rename+0x2e0>
80009544:	0207e793          	ori	a5,a5,32
80009548:	00f70223          	sb	a5,4(a4)
						res = store_xdir(&djn);
8000954c:	00048513          	mv	a0,s1
80009550:	9f1fc0ef          	jal	ra,80005f40 <store_xdir>
80009554:	00050413          	mv	s0,a0
			if (res == FR_OK) {
80009558:	ec0506e3          	beqz	a0,80009424 <f_rename+0x1b8>
8000955c:	d51ff06f          	j	800092ac <f_rename+0x40>
				if (res == FR_NO_FILE) { 				/* It is a valid path and no name collision */
80009560:	d53516e3          	bne	a0,s3,800092ac <f_rename+0x40>
80009564:	f59ff06f          	j	800094bc <f_rename+0x250>
								if (res == FR_OK && dir[1] == '.') {
80009568:	05d4c703          	lbu	a4,93(s1)
8000956c:	02e00793          	li	a5,46
80009570:	eaf71ae3          	bne	a4,a5,80009424 <f_rename+0x1b8>
	*ptr++ = (BYTE)val; val >>= 8;
80009574:	01091793          	slli	a5,s2,0x10
80009578:	0107d793          	srli	a5,a5,0x10
	if (fs->fs_type == FS_FAT32) {
8000957c:	0004c703          	lbu	a4,0(s1)
	*ptr++ = (BYTE)val; val >>= 8;
80009580:	0087d793          	srli	a5,a5,0x8
	*ptr++ = (BYTE)val;
80009584:	06f48ba3          	sb	a5,119(s1)
	*ptr++ = (BYTE)val; val >>= 8;
80009588:	07248b23          	sb	s2,118(s1)
	if (fs->fs_type == FS_FAT32) {
8000958c:	00300793          	li	a5,3
80009590:	00f71a63          	bne	a4,a5,800095a4 <f_rename+0x338>
		st_word(dir + DIR_FstClusHI, (WORD)(cl >> 16));
80009594:	01095913          	srli	s2,s2,0x10
	*ptr++ = (BYTE)val; val >>= 8;
80009598:	00895793          	srli	a5,s2,0x8
8000959c:	07248823          	sb	s2,112(s1)
	*ptr++ = (BYTE)val;
800095a0:	06f488a3          	sb	a5,113(s1)
									fs->wflag = 1;
800095a4:	00100793          	li	a5,1
800095a8:	00f48223          	sb	a5,4(s1)
800095ac:	e79ff06f          	j	80009424 <f_rename+0x1b8>
800095b0:	0b812903          	lw	s2,184(sp)
800095b4:	fc1ff06f          	j	80009574 <f_rename+0x308>

800095b8 <f_chmod>:
{
800095b8:	f8010113          	addi	sp,sp,-128
800095bc:	06812c23          	sw	s0,120(sp)
800095c0:	06912a23          	sw	s1,116(sp)
800095c4:	00a12623          	sw	a0,12(sp)
800095c8:	00058493          	mv	s1,a1
800095cc:	00060413          	mv	s0,a2
	res = mount_volume(&path, &fs, FA_WRITE);	/* Get logical drive */
800095d0:	01c10593          	addi	a1,sp,28
800095d4:	00200613          	li	a2,2
800095d8:	00c10513          	addi	a0,sp,12
{
800095dc:	06112e23          	sw	ra,124(sp)
	res = mount_volume(&path, &fs, FA_WRITE);	/* Get logical drive */
800095e0:	f64fb0ef          	jal	ra,80004d44 <mount_volume>
	if (res == FR_OK) {
800095e4:	00050c63          	beqz	a0,800095fc <f_chmod+0x44>
}
800095e8:	07c12083          	lw	ra,124(sp)
800095ec:	07812403          	lw	s0,120(sp)
800095f0:	07412483          	lw	s1,116(sp)
800095f4:	08010113          	addi	sp,sp,128
800095f8:	00008067          	ret
		dj.obj.fs = fs;
800095fc:	01c12783          	lw	a5,28(sp)
		res = follow_path(&dj, path);	/* Follow the file path */
80009600:	00c12583          	lw	a1,12(sp)
80009604:	02010513          	addi	a0,sp,32
		dj.obj.fs = fs;
80009608:	02f12023          	sw	a5,32(sp)
		res = follow_path(&dj, path);	/* Follow the file path */
8000960c:	8a4fd0ef          	jal	ra,800066b0 <follow_path>
		if (res == FR_OK && (dj.fn[NSFLAG] & (NS_DOT | NS_NONAME))) res = FR_INVALID_NAME;	/* Check object validity */
80009610:	fc051ce3          	bnez	a0,800095e8 <f_chmod+0x30>
80009614:	06b14783          	lbu	a5,107(sp)
80009618:	00600513          	li	a0,6
8000961c:	0a07f793          	andi	a5,a5,160
80009620:	fc0794e3          	bnez	a5,800095e8 <f_chmod+0x30>
			if (fs->fs_type == FS_EXFAT) {
80009624:	01c12503          	lw	a0,28(sp)
80009628:	00400793          	li	a5,4
			mask &= AM_RDO|AM_HID|AM_SYS|AM_ARC;	/* Valid attribute mask */
8000962c:	02747413          	andi	s0,s0,39
			if (fs->fs_type == FS_EXFAT) {
80009630:	00054703          	lbu	a4,0(a0)
80009634:	02f70663          	beq	a4,a5,80009660 <f_chmod+0xa8>
				dj.dir[DIR_Attr] = (attr & mask) | (dj.dir[DIR_Attr] & (BYTE)~mask);	/* Apply attribute change */
80009638:	05c12703          	lw	a4,92(sp)
8000963c:	00b74783          	lbu	a5,11(a4)
80009640:	0097c4b3          	xor	s1,a5,s1
80009644:	00947433          	and	s0,s0,s1
80009648:	0087c433          	xor	s0,a5,s0
8000964c:	008705a3          	sb	s0,11(a4)
				fs->wflag = 1;
80009650:	00100793          	li	a5,1
80009654:	00f50223          	sb	a5,4(a0)
				res = sync_fs(fs);
80009658:	819fa0ef          	jal	ra,80003e70 <sync_fs>
8000965c:	f8dff06f          	j	800095e8 <f_chmod+0x30>
				fs->dirbuf[XDIR_Attr] = (attr & mask) | (fs->dirbuf[XDIR_Attr] & (BYTE)~mask);	/* Apply attribute change */
80009660:	01052703          	lw	a4,16(a0)
				res = store_xdir(&dj);
80009664:	02010513          	addi	a0,sp,32
				fs->dirbuf[XDIR_Attr] = (attr & mask) | (fs->dirbuf[XDIR_Attr] & (BYTE)~mask);	/* Apply attribute change */
80009668:	00474783          	lbu	a5,4(a4)
8000966c:	0097c4b3          	xor	s1,a5,s1
80009670:	00947433          	and	s0,s0,s1
80009674:	0087c433          	xor	s0,a5,s0
80009678:	00870223          	sb	s0,4(a4)
				res = store_xdir(&dj);
8000967c:	8c5fc0ef          	jal	ra,80005f40 <store_xdir>
			if (res == FR_OK) {
80009680:	f60514e3          	bnez	a0,800095e8 <f_chmod+0x30>
80009684:	01c12503          	lw	a0,28(sp)
80009688:	fd1ff06f          	j	80009658 <f_chmod+0xa0>

8000968c <f_utime>:
{
8000968c:	f8010113          	addi	sp,sp,-128
80009690:	06812c23          	sw	s0,120(sp)
80009694:	00a12623          	sw	a0,12(sp)
80009698:	00058413          	mv	s0,a1
	res = mount_volume(&path, &fs, FA_WRITE);	/* Get logical drive */
8000969c:	00200613          	li	a2,2
800096a0:	01c10593          	addi	a1,sp,28
800096a4:	00c10513          	addi	a0,sp,12
{
800096a8:	06112e23          	sw	ra,124(sp)
	res = mount_volume(&path, &fs, FA_WRITE);	/* Get logical drive */
800096ac:	e98fb0ef          	jal	ra,80004d44 <mount_volume>
	if (res == FR_OK) {
800096b0:	00050a63          	beqz	a0,800096c4 <f_utime+0x38>
}
800096b4:	07c12083          	lw	ra,124(sp)
800096b8:	07812403          	lw	s0,120(sp)
800096bc:	08010113          	addi	sp,sp,128
800096c0:	00008067          	ret
		dj.obj.fs = fs;
800096c4:	01c12783          	lw	a5,28(sp)
		res = follow_path(&dj, path);	/* Follow the file path */
800096c8:	00c12583          	lw	a1,12(sp)
800096cc:	02010513          	addi	a0,sp,32
		dj.obj.fs = fs;
800096d0:	02f12023          	sw	a5,32(sp)
		res = follow_path(&dj, path);	/* Follow the file path */
800096d4:	fddfc0ef          	jal	ra,800066b0 <follow_path>
		if (res == FR_OK && (dj.fn[NSFLAG] & (NS_DOT | NS_NONAME))) res = FR_INVALID_NAME;	/* Check object validity */
800096d8:	fc051ee3          	bnez	a0,800096b4 <f_utime+0x28>
800096dc:	06b14783          	lbu	a5,107(sp)
800096e0:	00600513          	li	a0,6
800096e4:	0a07f793          	andi	a5,a5,160
800096e8:	fc0796e3          	bnez	a5,800096b4 <f_utime+0x28>
			if (fs->fs_type == FS_EXFAT) {
800096ec:	01c12503          	lw	a0,28(sp)
800096f0:	00845783          	lhu	a5,8(s0)
800096f4:	00a45703          	lhu	a4,10(s0)
800096f8:	00054583          	lbu	a1,0(a0)
800096fc:	01079793          	slli	a5,a5,0x10
80009700:	00e7e7b3          	or	a5,a5,a4
80009704:	0087d693          	srli	a3,a5,0x8
80009708:	0107d713          	srli	a4,a5,0x10
8000970c:	00400613          	li	a2,4
80009710:	0ff7f813          	andi	a6,a5,255
80009714:	0ff6f693          	andi	a3,a3,255
80009718:	0ff77713          	andi	a4,a4,255
8000971c:	0187d793          	srli	a5,a5,0x18
80009720:	02c58463          	beq	a1,a2,80009748 <f_utime+0xbc>
				st_dword(dj.dir + DIR_ModTime, (DWORD)fno->fdate << 16 | fno->ftime);
80009724:	05c12603          	lw	a2,92(sp)
	*ptr++ = (BYTE)val;
80009728:	00f60ca3          	sb	a5,25(a2)
	*ptr++ = (BYTE)val; val >>= 8;
8000972c:	01060b23          	sb	a6,22(a2)
	*ptr++ = (BYTE)val; val >>= 8;
80009730:	00d60ba3          	sb	a3,23(a2)
	*ptr++ = (BYTE)val; val >>= 8;
80009734:	00e60c23          	sb	a4,24(a2)
				fs->wflag = 1;
80009738:	00100793          	li	a5,1
8000973c:	00f50223          	sb	a5,4(a0)
				res = sync_fs(fs);
80009740:	f30fa0ef          	jal	ra,80003e70 <sync_fs>
80009744:	f71ff06f          	j	800096b4 <f_utime+0x28>
				st_dword(fs->dirbuf + XDIR_ModTime, (DWORD)fno->fdate << 16 | fno->ftime);
80009748:	01052603          	lw	a2,16(a0)
				res = store_xdir(&dj);
8000974c:	02010513          	addi	a0,sp,32
	*ptr++ = (BYTE)val; val >>= 8;
80009750:	01060623          	sb	a6,12(a2)
	*ptr++ = (BYTE)val; val >>= 8;
80009754:	00d606a3          	sb	a3,13(a2)
	*ptr++ = (BYTE)val; val >>= 8;
80009758:	00e60723          	sb	a4,14(a2)
	*ptr++ = (BYTE)val;
8000975c:	00f607a3          	sb	a5,15(a2)
				res = store_xdir(&dj);
80009760:	fe0fc0ef          	jal	ra,80005f40 <store_xdir>
			if (res == FR_OK) {
80009764:	f40518e3          	bnez	a0,800096b4 <f_utime+0x28>
80009768:	01c12503          	lw	a0,28(sp)
8000976c:	fd5ff06f          	j	80009740 <f_utime+0xb4>

80009770 <f_gets>:
{
80009770:	fd010113          	addi	sp,sp,-48
80009774:	02812423          	sw	s0,40(sp)
80009778:	02912223          	sw	s1,36(sp)
8000977c:	03212023          	sw	s2,32(sp)
80009780:	01312e23          	sw	s3,28(sp)
80009784:	01412c23          	sw	s4,24(sp)
80009788:	01512a23          	sw	s5,20(sp)
8000978c:	01612823          	sw	s6,16(sp)
80009790:	02112623          	sw	ra,44(sp)
80009794:	00050b13          	mv	s6,a0
80009798:	00060913          	mv	s2,a2
	len -= 1;	/* Make a room for the terminator */
8000979c:	fff58a13          	addi	s4,a1,-1
	TCHAR *p = buff;
800097a0:	00050493          	mv	s1,a0
	int nc = 0;
800097a4:	00000413          	li	s0,0
		if (FF_USE_STRFUNC == 2 && dc == '\r') continue;
800097a8:	00d00993          	li	s3,13
		if (dc == '\n') break;
800097ac:	00a00a93          	li	s5,10
	while (nc < len) {
800097b0:	05445263          	bge	s0,s4,800097f4 <f_gets+0x84>
		f_read(fp, s, 1, &rc);	/* Get a byte */
800097b4:	00c10693          	addi	a3,sp,12
800097b8:	00100613          	li	a2,1
800097bc:	00810593          	addi	a1,sp,8
800097c0:	00090513          	mv	a0,s2
800097c4:	958fe0ef          	jal	ra,8000791c <f_read>
		if (rc != 1) break;		/* EOF? */
800097c8:	00c12703          	lw	a4,12(sp)
800097cc:	00100793          	li	a5,1
800097d0:	02f71263          	bne	a4,a5,800097f4 <f_gets+0x84>
		dc = s[0];
800097d4:	00814783          	lbu	a5,8(sp)
		if (FF_USE_STRFUNC == 2 && dc == '\r') continue;
800097d8:	fd378ee3          	beq	a5,s3,800097b4 <f_gets+0x44>
		*p++ = (TCHAR)dc; nc++;
800097dc:	00148493          	addi	s1,s1,1
800097e0:	fef48fa3          	sb	a5,-1(s1)
800097e4:	00140413          	addi	s0,s0,1
		if (dc == '\n') break;
800097e8:	fd5794e3          	bne	a5,s5,800097b0 <f_gets+0x40>
	*p = 0;		/* Terminate the string */
800097ec:	00048023          	sb	zero,0(s1)
	return nc ? buff : 0;	/* When no data read due to EOF or error, return with error. */
800097f0:	0140006f          	j	80009804 <f_gets+0x94>
800097f4:	00803433          	snez	s0,s0
800097f8:	40800433          	neg	s0,s0
	*p = 0;		/* Terminate the string */
800097fc:	00048023          	sb	zero,0(s1)
	return nc ? buff : 0;	/* When no data read due to EOF or error, return with error. */
80009800:	008b7b33          	and	s6,s6,s0
}
80009804:	02c12083          	lw	ra,44(sp)
80009808:	02812403          	lw	s0,40(sp)
8000980c:	000b0513          	mv	a0,s6
80009810:	02412483          	lw	s1,36(sp)
80009814:	02012903          	lw	s2,32(sp)
80009818:	01c12983          	lw	s3,28(sp)
8000981c:	01812a03          	lw	s4,24(sp)
80009820:	01412a83          	lw	s5,20(sp)
80009824:	01012b03          	lw	s6,16(sp)
80009828:	03010113          	addi	sp,sp,48
8000982c:	00008067          	ret

80009830 <f_putc>:

int f_putc (
	TCHAR c,	/* A character to be output */
	FIL* fp		/* Pointer to the file object */
)
{
80009830:	fa010113          	addi	sp,sp,-96
80009834:	04812c23          	sw	s0,88(sp)
80009838:	04912a23          	sw	s1,84(sp)
8000983c:	00058413          	mv	s0,a1
80009840:	00050493          	mv	s1,a0
	memset(pb, 0, sizeof (putbuff));
80009844:	04c00613          	li	a2,76
80009848:	00000593          	li	a1,0
8000984c:	00410513          	addi	a0,sp,4
{
80009850:	04112e23          	sw	ra,92(sp)
	memset(pb, 0, sizeof (putbuff));
80009854:	ecdf80ef          	jal	ra,80002720 <memset>
	putbuff pb;


	putc_init(&pb, fp);
	putc_bfd(&pb, c);	/* Put the character */
80009858:	00048593          	mv	a1,s1
8000985c:	00410513          	addi	a0,sp,4
	pb->fp = fp;
80009860:	00812223          	sw	s0,4(sp)
	putc_bfd(&pb, c);	/* Put the character */
80009864:	ec0fe0ef          	jal	ra,80007f24 <putc_bfd>
	return putc_flush(&pb);
80009868:	00410513          	addi	a0,sp,4
8000986c:	f5cfe0ef          	jal	ra,80007fc8 <putc_flush>
}
80009870:	05c12083          	lw	ra,92(sp)
80009874:	05812403          	lw	s0,88(sp)
80009878:	05412483          	lw	s1,84(sp)
8000987c:	06010113          	addi	sp,sp,96
80009880:	00008067          	ret

80009884 <f_puts>:

int f_puts (
	const TCHAR* str,	/* Pointer to the string to be output */
	FIL* fp				/* Pointer to the file object */
)
{
80009884:	fa010113          	addi	sp,sp,-96
80009888:	04812c23          	sw	s0,88(sp)
8000988c:	04912a23          	sw	s1,84(sp)
80009890:	00050413          	mv	s0,a0
80009894:	00058493          	mv	s1,a1
	memset(pb, 0, sizeof (putbuff));
80009898:	04c00613          	li	a2,76
8000989c:	00000593          	li	a1,0
800098a0:	00410513          	addi	a0,sp,4
{
800098a4:	04112e23          	sw	ra,92(sp)
	memset(pb, 0, sizeof (putbuff));
800098a8:	e79f80ef          	jal	ra,80002720 <memset>
	putbuff pb;


	putc_init(&pb, fp);
	while (*str) putc_bfd(&pb, *str++);		/* Put the string */
800098ac:	00044583          	lbu	a1,0(s0)
	pb->fp = fp;
800098b0:	00912223          	sw	s1,4(sp)
	while (*str) putc_bfd(&pb, *str++);		/* Put the string */
800098b4:	00058c63          	beqz	a1,800098cc <f_puts+0x48>
800098b8:	00410513          	addi	a0,sp,4
800098bc:	00140413          	addi	s0,s0,1
800098c0:	e64fe0ef          	jal	ra,80007f24 <putc_bfd>
800098c4:	00044583          	lbu	a1,0(s0)
800098c8:	fe0598e3          	bnez	a1,800098b8 <f_puts+0x34>
	return putc_flush(&pb);
800098cc:	00410513          	addi	a0,sp,4
800098d0:	ef8fe0ef          	jal	ra,80007fc8 <putc_flush>
}
800098d4:	05c12083          	lw	ra,92(sp)
800098d8:	05812403          	lw	s0,88(sp)
800098dc:	05412483          	lw	s1,84(sp)
800098e0:	06010113          	addi	sp,sp,96
800098e4:	00008067          	ret

800098e8 <f_printf>:
int f_printf (
	FIL* fp,			/* Pointer to the file object */
	const TCHAR* fmt,	/* Pointer to the format string */
	...					/* Optional arguments... */
)
{
800098e8:	ec010113          	addi	sp,sp,-320
800098ec:	10812c23          	sw	s0,280(sp)
800098f0:	0f912a23          	sw	s9,244(sp)
800098f4:	00050413          	mv	s0,a0
800098f8:	12c12423          	sw	a2,296(sp)
800098fc:	00058c93          	mv	s9,a1
	memset(pb, 0, sizeof (putbuff));
80009900:	04c00613          	li	a2,76
80009904:	00000593          	li	a1,0
80009908:	09410513          	addi	a0,sp,148
{
8000990c:	12d12623          	sw	a3,300(sp)
80009910:	12e12823          	sw	a4,304(sp)
80009914:	12f12a23          	sw	a5,308(sp)
80009918:	13012c23          	sw	a6,312(sp)
8000991c:	10112e23          	sw	ra,284(sp)
80009920:	10912a23          	sw	s1,276(sp)
80009924:	11212823          	sw	s2,272(sp)
80009928:	11312623          	sw	s3,268(sp)
8000992c:	11412423          	sw	s4,264(sp)
80009930:	11512223          	sw	s5,260(sp)
80009934:	11612023          	sw	s6,256(sp)
80009938:	0f712e23          	sw	s7,252(sp)
8000993c:	0f812c23          	sw	s8,248(sp)
80009940:	0fa12823          	sw	s10,240(sp)
80009944:	0fb12623          	sw	s11,236(sp)
80009948:	13112e23          	sw	a7,316(sp)
#else
	DWORD v;
#endif
	TCHAR *tp;
	TCHAR tc, pad;
	TCHAR nul = 0;
8000994c:	060107a3          	sb	zero,111(sp)
	memset(pb, 0, sizeof (putbuff));
80009950:	dd1f80ef          	jal	ra,80002720 <memset>
			rv /= 10; n++;
80009954:	8000f7b7          	lui	a5,0x8000f
80009958:	ab07a703          	lw	a4,-1360(a5) # 8000eab0 <STACK_TOP+0xfffeeab0>
8000995c:	ab47a683          	lw	a3,-1356(a5)
		if (isinf(val)) {		/* Infinite? */
80009960:	8000f7b7          	lui	a5,0x8000f
80009964:	aa47a803          	lw	a6,-1372(a5) # 8000eaa4 <STACK_TOP+0xfffeeaa4>
80009968:	aa07a783          	lw	a5,-1376(a5)
			rv /= 10; n++;
8000996c:	02e12823          	sw	a4,48(sp)
80009970:	02d12a23          	sw	a3,52(sp)
		if (isinf(val)) {		/* Infinite? */
80009974:	02f12423          	sw	a5,40(sp)
	char d, str[SZ_NUM_BUF];


	putc_init(&pb, fp);

	va_start(arp, fmt);
80009978:	12810793          	addi	a5,sp,296
		if (isinf(val)) {		/* Infinite? */
8000997c:	03012623          	sw	a6,44(sp)
	pb->fp = fp;
80009980:	08812a23          	sw	s0,148(sp)
	va_start(arp, fmt);
80009984:	06f12823          	sw	a5,112(sp)
			rv *= 10; n--;
80009988:	02e12c23          	sw	a4,56(sp)
8000998c:	02d12e23          	sw	a3,60(sp)

	for (;;) {
		tc = *fmt++;
80009990:	000cc583          	lbu	a1,0(s9)
		if (tc == 0) break;			/* End of format string */
80009994:	0a058463          	beqz	a1,80009a3c <f_printf+0x154>
		if (tc != '%') {			/* Not an escape character (pass-through) */
80009998:	02500793          	li	a5,37
8000999c:	5af59c63          	bne	a1,a5,80009f54 <f_printf+0x66c>
			putc_bfd(&pb, tc);
			continue;
		}
		f = w = 0; pad = ' '; prec = -1;	/* Initialize parms */
		tc = *fmt++;
800099a0:	001ccd83          	lbu	s11,1(s9)
		if (tc == '0') {			/* Flag: '0' padded */
800099a4:	03000713          	li	a4,48
800099a8:	62ed8c63          	beq	s11,a4,80009fe0 <f_printf+0x6f8>
			pad = '0'; tc = *fmt++;
		} else if (tc == '-') {		/* Flag: Left aligned */
800099ac:	02d00713          	li	a4,45
800099b0:	64ed8263          	beq	s11,a4,80009ff4 <f_printf+0x70c>
		tc = *fmt++;
800099b4:	002c8c93          	addi	s9,s9,2
		f = w = 0; pad = ' '; prec = -1;	/* Initialize parms */
800099b8:	02000913          	li	s2,32
800099bc:	00012223          	sw	zero,4(sp)
			f = 2; tc = *fmt++;
		}
		if (tc == '*') {			/* Minimum width from an argument */
800099c0:	02a00713          	li	a4,42
800099c4:	5aed9063          	bne	s11,a4,80009f64 <f_printf+0x67c>
			w = va_arg(arp, int);
800099c8:	07012703          	lw	a4,112(sp)
			tc = *fmt++;
800099cc:	000ccd83          	lbu	s11,0(s9)
800099d0:	001c8c93          	addi	s9,s9,1
			w = va_arg(arp, int);
800099d4:	00072403          	lw	s0,0(a4)
800099d8:	00470693          	addi	a3,a4,4
800099dc:	06d12823          	sw	a3,112(sp)
			while (IsDigit(tc)) {	/* Minimum width */
				w = w * 10 + tc - '0';
				tc = *fmt++;
			}
		}
		if (tc == '.') {			/* Precision */
800099e0:	02e00713          	li	a4,46
		f = w = 0; pad = ' '; prec = -1;	/* Initialize parms */
800099e4:	fff00493          	li	s1,-1
		if (tc == '.') {			/* Precision */
800099e8:	5ced8863          	beq	s11,a4,80009fb8 <f_printf+0x6d0>
					prec = prec * 10 + tc - '0';
					tc = *fmt++;
				}
			}
		}
		if (tc == 'l') {			/* Size: long int */
800099ec:	06c00713          	li	a4,108
800099f0:	02ed8863          	beq	s11,a4,80009a20 <f_printf+0x138>
			if (tc == 'l') {		/* Size: long long int */
				f |= 8; tc = *fmt++;
			}
#endif
		}
		if (tc == 0) break;			/* End of format string */
800099f4:	040d8463          	beqz	s11,80009a3c <f_printf+0x154>
		switch (tc) {				/* Atgument type is... */
800099f8:	fbbd8713          	addi	a4,s11,-69
800099fc:	0ff77713          	andi	a4,a4,255
80009a00:	03300693          	li	a3,51
80009a04:	54e6e063          	bltu	a3,a4,80009f44 <f_printf+0x65c>
80009a08:	8000e6b7          	lui	a3,0x8000e
80009a0c:	00271713          	slli	a4,a4,0x2
80009a10:	3e468693          	addi	a3,a3,996 # 8000e3e4 <STACK_TOP+0xfffee3e4>
80009a14:	00d70733          	add	a4,a4,a3
80009a18:	00072703          	lw	a4,0(a4)
80009a1c:	00070067          	jr	a4
			f |= 4; tc = *fmt++;
80009a20:	000ccd83          	lbu	s11,0(s9)
			if (tc == 'l') {		/* Size: long long int */
80009a24:	6aed8e63          	beq	s11,a4,8000a0e0 <f_printf+0x7f8>
			f |= 4; tc = *fmt++;
80009a28:	00412783          	lw	a5,4(sp)
80009a2c:	001c8c93          	addi	s9,s9,1
80009a30:	0047e793          	ori	a5,a5,4
80009a34:	00f12223          	sw	a5,4(sp)
		if (tc == 0) break;			/* End of format string */
80009a38:	fc0d90e3          	bnez	s11,800099f8 <f_printf+0x110>
		}
	}

	va_end(arp);

	return putc_flush(&pb);
80009a3c:	09410513          	addi	a0,sp,148
80009a40:	d88fe0ef          	jal	ra,80007fc8 <putc_flush>
}
80009a44:	11c12083          	lw	ra,284(sp)
80009a48:	11812403          	lw	s0,280(sp)
80009a4c:	11412483          	lw	s1,276(sp)
80009a50:	11012903          	lw	s2,272(sp)
80009a54:	10c12983          	lw	s3,268(sp)
80009a58:	10812a03          	lw	s4,264(sp)
80009a5c:	10412a83          	lw	s5,260(sp)
80009a60:	10012b03          	lw	s6,256(sp)
80009a64:	0fc12b83          	lw	s7,252(sp)
80009a68:	0f812c03          	lw	s8,248(sp)
80009a6c:	0f412c83          	lw	s9,244(sp)
80009a70:	0f012d03          	lw	s10,240(sp)
80009a74:	0ec12d83          	lw	s11,236(sp)
80009a78:	14010113          	addi	sp,sp,320
80009a7c:	00008067          	ret
		if (f & 8) {		/* long long argument? */
80009a80:	00412783          	lw	a5,4(sp)
		switch (tc) {				/* Atgument type is... */
80009a84:	00800a93          	li	s5,8
80009a88:	00000b13          	li	s6,0
		if (f & 8) {		/* long long argument? */
80009a8c:	0087f693          	andi	a3,a5,8
80009a90:	07012703          	lw	a4,112(sp)
80009a94:	14068a63          	beqz	a3,80009be8 <f_printf+0x300>
			v = (QWORD)va_arg(arp, long long);
80009a98:	00770713          	addi	a4,a4,7
80009a9c:	ff877713          	andi	a4,a4,-8
80009aa0:	00072a03          	lw	s4,0(a4)
80009aa4:	00472d03          	lw	s10,4(a4)
80009aa8:	00870693          	addi	a3,a4,8
80009aac:	06d12823          	sw	a3,112(sp)
		if (tc == 'd' && (v & 0x8000000000000000)) {	/* Negative value? */
80009ab0:	00412783          	lw	a5,4(sp)
80009ab4:	0017f793          	andi	a5,a5,1
80009ab8:	00f12823          	sw	a5,16(sp)
		i = 0;
80009abc:	07800713          	li	a4,120
80009ac0:	00700793          	li	a5,7
80009ac4:	00ed9463          	bne	s11,a4,80009acc <f_printf+0x1e4>
80009ac8:	02700793          	li	a5,39
80009acc:	0ff7fd93          	andi	s11,a5,255
80009ad0:	00000993          	li	s3,0
80009ad4:	07410493          	addi	s1,sp,116
			if (d > 9) d += (tc == 'x') ? 0x27 : 0x07;
80009ad8:	00900b93          	li	s7,9
80009adc:	0180006f          	j	80009af4 <f_printf+0x20c>
		} while (v && i < SZ_NUM_BUF);
80009ae0:	02000713          	li	a4,32
			d = (char)(v % r); v /= r;
80009ae4:	00050a13          	mv	s4,a0
80009ae8:	00058d13          	mv	s10,a1
		} while (v && i < SZ_NUM_BUF);
80009aec:	52e78063          	beq	a5,a4,8000a00c <f_printf+0x724>
80009af0:	00078993          	mv	s3,a5
			d = (char)(v % r); v /= r;
80009af4:	000a8613          	mv	a2,s5
80009af8:	00000693          	li	a3,0
80009afc:	000a0513          	mv	a0,s4
80009b00:	000d0593          	mv	a1,s10
80009b04:	021010ef          	jal	ra,8000b324 <__umoddi3>
80009b08:	0ff57c13          	andi	s8,a0,255
80009b0c:	000a8613          	mv	a2,s5
80009b10:	00000693          	li	a3,0
80009b14:	000a0513          	mv	a0,s4
80009b18:	000d0593          	mv	a1,s10
80009b1c:	234010ef          	jal	ra,8000ad50 <__udivdi3>
			if (d > 9) d += (tc == 'x') ? 0x27 : 0x07;
80009b20:	018bf663          	bgeu	s7,s8,80009b2c <f_printf+0x244>
80009b24:	018d8c33          	add	s8,s11,s8
80009b28:	0ffc7c13          	andi	s8,s8,255
			str[i++] = d + '0';
80009b2c:	00198793          	addi	a5,s3,1
80009b30:	00f48733          	add	a4,s1,a5
80009b34:	030c0c13          	addi	s8,s8,48
80009b38:	ff870fa3          	sb	s8,-1(a4)
		} while (v && i < SZ_NUM_BUF);
80009b3c:	fbab12e3          	bne	s6,s10,80009ae0 <f_printf+0x1f8>
80009b40:	fb5a70e3          	bgeu	s4,s5,80009ae0 <f_printf+0x1f8>
80009b44:	00078d93          	mv	s11,a5
80009b48:	4cc0006f          	j	8000a014 <f_printf+0x72c>
		switch (tc) {				/* Atgument type is... */
80009b4c:	00a00a93          	li	s5,10
80009b50:	00000b13          	li	s6,0
		if (f & 8) {		/* long long argument? */
80009b54:	00412783          	lw	a5,4(sp)
80009b58:	07012703          	lw	a4,112(sp)
80009b5c:	0087f693          	andi	a3,a5,8
80009b60:	08068463          	beqz	a3,80009be8 <f_printf+0x300>
			v = (QWORD)va_arg(arp, long long);
80009b64:	00770713          	addi	a4,a4,7
80009b68:	ff877713          	andi	a4,a4,-8
80009b6c:	00472683          	lw	a3,4(a4)
80009b70:	00870613          	addi	a2,a4,8
80009b74:	06c12823          	sw	a2,112(sp)
		if (tc == 'd' && (v & 0x8000000000000000)) {	/* Negative value? */
80009b78:	06400613          	li	a2,100
			v = (QWORD)va_arg(arp, long long);
80009b7c:	00072a03          	lw	s4,0(a4)
80009b80:	00068d13          	mv	s10,a3
		if (tc == 'd' && (v & 0x8000000000000000)) {	/* Negative value? */
80009b84:	f2cd96e3          	bne	s11,a2,80009ab0 <f_printf+0x1c8>
80009b88:	f206d4e3          	bgez	a3,80009ab0 <f_printf+0x1c8>
			v = 0 - v; f |= 1;
80009b8c:	00412783          	lw	a5,4(sp)
80009b90:	41400a33          	neg	s4,s4
80009b94:	01403733          	snez	a4,s4
80009b98:	0017e793          	ori	a5,a5,1
80009b9c:	41a00833          	neg	a6,s10
80009ba0:	00f12223          	sw	a5,4(sp)
80009ba4:	00100793          	li	a5,1
80009ba8:	40e80d33          	sub	s10,a6,a4
80009bac:	00f12823          	sw	a5,16(sp)
80009bb0:	f0dff06f          	j	80009abc <f_printf+0x1d4>
			putc_bfd(&pb, (TCHAR)va_arg(arp, int));
80009bb4:	07012783          	lw	a5,112(sp)
80009bb8:	09410513          	addi	a0,sp,148
80009bbc:	0007c583          	lbu	a1,0(a5)
80009bc0:	00478793          	addi	a5,a5,4
80009bc4:	06f12823          	sw	a5,112(sp)
80009bc8:	b5cfe0ef          	jal	ra,80007f24 <putc_bfd>
			continue;
80009bcc:	dc5ff06f          	j	80009990 <f_printf+0xa8>
		if (f & 8) {		/* long long argument? */
80009bd0:	00412783          	lw	a5,4(sp)
		switch (tc) {				/* Atgument type is... */
80009bd4:	00200a93          	li	s5,2
80009bd8:	00000b13          	li	s6,0
		if (f & 8) {		/* long long argument? */
80009bdc:	0087f693          	andi	a3,a5,8
80009be0:	07012703          	lw	a4,112(sp)
80009be4:	ea069ae3          	bnez	a3,80009a98 <f_printf+0x1b0>
			v = (tc == 'd') ? (QWORD)(long long)va_arg(arp, int) : (QWORD)va_arg(arp, unsigned int);
80009be8:	06400693          	li	a3,100
80009bec:	00470613          	addi	a2,a4,4
80009bf0:	50dd8463          	beq	s11,a3,8000a0f8 <f_printf+0x810>
80009bf4:	06c12823          	sw	a2,112(sp)
80009bf8:	00072a03          	lw	s4,0(a4)
80009bfc:	00000d13          	li	s10,0
80009c00:	eb1ff06f          	j	80009ab0 <f_printf+0x1c8>
		switch (tc) {				/* Atgument type is... */
80009c04:	01000a93          	li	s5,16
80009c08:	00000b13          	li	s6,0
80009c0c:	f49ff06f          	j	80009b54 <f_printf+0x26c>
			tp = va_arg(arp, TCHAR*);	/* Get a pointer argument */
80009c10:	07012783          	lw	a5,112(sp)
80009c14:	0007aa83          	lw	s5,0(a5)
80009c18:	00478793          	addi	a5,a5,4
80009c1c:	06f12823          	sw	a5,112(sp)
			if (!tp) tp = &nul;		/* Null ptr generates a null string */
80009c20:	600a8063          	beqz	s5,8000a220 <f_printf+0x938>
			for (j = 0; tp[j]; j++) ;	/* j = tcslen(tp) */
80009c24:	000ac583          	lbu	a1,0(s5)
80009c28:	00000a13          	li	s4,0
80009c2c:	00058a63          	beqz	a1,80009c40 <f_printf+0x358>
80009c30:	001a0a13          	addi	s4,s4,1
80009c34:	014a87b3          	add	a5,s5,s4
80009c38:	0007c783          	lbu	a5,0(a5)
80009c3c:	fe079ae3          	bnez	a5,80009c30 <f_printf+0x348>
			if (prec >= 0 && j > (UINT)prec) j = prec;	/* Limited length of string body */
80009c40:	0004c663          	bltz	s1,80009c4c <f_printf+0x364>
80009c44:	0144f463          	bgeu	s1,s4,80009c4c <f_printf+0x364>
80009c48:	00048a13          	mv	s4,s1
			for ( ; !(f & 2) && j < w; j++) putc_bfd(&pb, pad);	/* Left pads */
80009c4c:	00412783          	lw	a5,4(sp)
80009c50:	0027f993          	andi	s3,a5,2
80009c54:	50099063          	bnez	s3,8000a154 <f_printf+0x86c>
80009c58:	008a7e63          	bgeu	s4,s0,80009c74 <f_printf+0x38c>
80009c5c:	001a0a13          	addi	s4,s4,1
80009c60:	00090593          	mv	a1,s2
80009c64:	09410513          	addi	a0,sp,148
80009c68:	abcfe0ef          	jal	ra,80007f24 <putc_bfd>
80009c6c:	ff4418e3          	bne	s0,s4,80009c5c <f_printf+0x374>
80009c70:	000ac583          	lbu	a1,0(s5)
			while (*tp && prec--) putc_bfd(&pb, *tp++);	/* Body */
80009c74:	d0058ee3          	beqz	a1,80009990 <f_printf+0xa8>
80009c78:	000a8913          	mv	s2,s5
80009c7c:	00049863          	bnez	s1,80009c8c <f_printf+0x3a4>
80009c80:	0200006f          	j	80009ca0 <f_printf+0x3b8>
80009c84:	409907b3          	sub	a5,s2,s1
80009c88:	01578c63          	beq	a5,s5,80009ca0 <f_printf+0x3b8>
80009c8c:	09410513          	addi	a0,sp,148
80009c90:	00190913          	addi	s2,s2,1
80009c94:	a90fe0ef          	jal	ra,80007f24 <putc_bfd>
80009c98:	00094583          	lbu	a1,0(s2)
80009c9c:	fe0594e3          	bnez	a1,80009c84 <f_printf+0x39c>
			while (j++ < w) putc_bfd(&pb, ' ');			/* Right pads */
80009ca0:	001a0493          	addi	s1,s4,1
80009ca4:	008a6663          	bltu	s4,s0,80009cb0 <f_printf+0x3c8>
80009ca8:	ce9ff06f          	j	80009990 <f_printf+0xa8>
80009cac:	00078493          	mv	s1,a5
80009cb0:	02000593          	li	a1,32
80009cb4:	09410513          	addi	a0,sp,148
80009cb8:	a6cfe0ef          	jal	ra,80007f24 <putc_bfd>
80009cbc:	00148793          	addi	a5,s1,1
80009cc0:	fe9416e3          	bne	s0,s1,80009cac <f_printf+0x3c4>
80009cc4:	ccdff06f          	j	80009990 <f_printf+0xa8>
			ftoa(str, va_arg(arp, double), prec, tc);	/* Make a floating point string */
80009cc8:	07012703          	lw	a4,112(sp)
80009ccc:	00770713          	addi	a4,a4,7
80009cd0:	ff877713          	andi	a4,a4,-8
80009cd4:	00072a03          	lw	s4,0(a4)
80009cd8:	00472a83          	lw	s5,4(a4)
80009cdc:	00870713          	addi	a4,a4,8
	if (isnan(val)) {			/* Not a number? */
80009ce0:	000a0613          	mv	a2,s4
80009ce4:	000a0513          	mv	a0,s4
80009ce8:	000a8693          	mv	a3,s5
80009cec:	000a8593          	mv	a1,s5
			ftoa(str, va_arg(arp, double), prec, tc);	/* Make a floating point string */
80009cf0:	06e12823          	sw	a4,112(sp)
	if (isnan(val)) {			/* Not a number? */
80009cf4:	339030ef          	jal	ra,8000d82c <__unorddf2>
80009cf8:	52051ce3          	bnez	a0,8000aa30 <f_printf+0x1148>
		if (prec < 0) prec = 6;	/* Default precision? (6 fractional digits) */
80009cfc:	4004ca63          	bltz	s1,8000a110 <f_printf+0x828>
		if (val < 0) {			/* Negative? */
80009d00:	000a0513          	mv	a0,s4
80009d04:	000a8593          	mv	a1,s5
80009d08:	00000613          	li	a2,0
80009d0c:	00000693          	li	a3,0
80009d10:	405020ef          	jal	ra,8000c914 <__ledf2>
80009d14:	40054c63          	bltz	a0,8000a12c <f_printf+0x844>
			sign = '+';
80009d18:	02b00793          	li	a5,43
80009d1c:	00f12823          	sw	a5,16(sp)
		if (isinf(val)) {		/* Infinite? */
80009d20:	02812b83          	lw	s7,40(sp)
80009d24:	02c12c03          	lw	s8,44(sp)
80009d28:	001a9b13          	slli	s6,s5,0x1
80009d2c:	001b5b13          	srli	s6,s6,0x1
80009d30:	000a0513          	mv	a0,s4
80009d34:	000b0593          	mv	a1,s6
80009d38:	000b8613          	mv	a2,s7
80009d3c:	000c0693          	mv	a3,s8
80009d40:	2ed030ef          	jal	ra,8000d82c <__unorddf2>
80009d44:	00051e63          	bnez	a0,80009d60 <f_printf+0x478>
80009d48:	000a0513          	mv	a0,s4
80009d4c:	000b0593          	mv	a1,s6
80009d50:	000b8613          	mv	a2,s7
80009d54:	000c0693          	mv	a3,s8
80009d58:	3bd020ef          	jal	ra,8000c914 <__ledf2>
80009d5c:	40a04063          	bgtz	a0,8000a15c <f_printf+0x874>
			if (fmt == 'f') {	/* Decimal notation? */
80009d60:	06600713          	li	a4,102
80009d64:	72ed8063          	beq	s11,a4,8000a484 <f_printf+0xb9c>
				if (val != 0) {		/* Not a true zero? */
80009d68:	000a0513          	mv	a0,s4
80009d6c:	000a8593          	mv	a1,s5
80009d70:	00000613          	li	a2,0
80009d74:	00000693          	li	a3,0
80009d78:	22d020ef          	jal	ra,8000c7a4 <__eqdf2>
80009d7c:	4a050663          	beqz	a0,8000a228 <f_printf+0x940>
	while (n >= 10) {	/* Decimate digit in right shift */
80009d80:	8000f7b7          	lui	a5,0x8000f
80009d84:	ab47ab03          	lw	s6,-1356(a5) # 8000eab4 <STACK_TOP+0xfffeeab4>
80009d88:	ab07ab83          	lw	s7,-1360(a5)
80009d8c:	000a0513          	mv	a0,s4
80009d90:	000b0693          	mv	a3,s6
80009d94:	000b8613          	mv	a2,s7
80009d98:	000a8593          	mv	a1,s5
80009d9c:	295020ef          	jal	ra,8000c830 <__gedf2>
80009da0:	400546e3          	bltz	a0,8000a9ac <f_printf+0x10c4>
			n /= 10; rv++;
80009da4:	000b8713          	mv	a4,s7
80009da8:	000b0793          	mv	a5,s6
	while (n >= 10) {	/* Decimate digit in right shift */
80009dac:	000a8b93          	mv	s7,s5
80009db0:	01212423          	sw	s2,8(sp)
80009db4:	00812a23          	sw	s0,20(sp)
80009db8:	000a0913          	mv	s2,s4
80009dbc:	00048a93          	mv	s5,s1
80009dc0:	000a0b13          	mv	s6,s4
	int rv = 0;
80009dc4:	00000c13          	li	s8,0
	while (n >= 10) {	/* Decimate digit in right shift */
80009dc8:	00070993          	mv	s3,a4
80009dcc:	00078d13          	mv	s10,a5
80009dd0:	00070413          	mv	s0,a4
80009dd4:	00078493          	mv	s1,a5
80009dd8:	000b8a13          	mv	s4,s7
80009ddc:	0400006f          	j	80009e1c <f_printf+0x534>
			n /= 100000; rv += 5;
80009de0:	8000f7b7          	lui	a5,0x8000f
80009de4:	aa87a603          	lw	a2,-1368(a5) # 8000eaa8 <STACK_TOP+0xfffeeaa8>
80009de8:	aac7a683          	lw	a3,-1364(a5)
80009dec:	00090513          	mv	a0,s2
80009df0:	000a0593          	mv	a1,s4
80009df4:	1e0020ef          	jal	ra,8000bfd4 <__divdf3>
80009df8:	00050913          	mv	s2,a0
80009dfc:	00058a13          	mv	s4,a1
	while (n >= 10) {	/* Decimate digit in right shift */
80009e00:	00098613          	mv	a2,s3
80009e04:	00090513          	mv	a0,s2
80009e08:	000d0693          	mv	a3,s10
80009e0c:	000a0593          	mv	a1,s4
			n /= 100000; rv += 5;
80009e10:	005c0c13          	addi	s8,s8,5
	while (n >= 10) {	/* Decimate digit in right shift */
80009e14:	21d020ef          	jal	ra,8000c830 <__gedf2>
80009e18:	04054c63          	bltz	a0,80009e70 <f_printf+0x588>
		if (n >= 100000) {
80009e1c:	8000f7b7          	lui	a5,0x8000f
80009e20:	aa87a603          	lw	a2,-1368(a5) # 8000eaa8 <STACK_TOP+0xfffeeaa8>
80009e24:	aac7a683          	lw	a3,-1364(a5)
80009e28:	00090513          	mv	a0,s2
80009e2c:	000a0593          	mv	a1,s4
80009e30:	201020ef          	jal	ra,8000c830 <__gedf2>
80009e34:	fa0556e3          	bgez	a0,80009de0 <f_printf+0x4f8>
			n /= 10; rv++;
80009e38:	00040613          	mv	a2,s0
80009e3c:	00090513          	mv	a0,s2
80009e40:	00048693          	mv	a3,s1
80009e44:	000a0593          	mv	a1,s4
80009e48:	18c020ef          	jal	ra,8000bfd4 <__divdf3>
80009e4c:	00050913          	mv	s2,a0
80009e50:	00058a13          	mv	s4,a1
	while (n >= 10) {	/* Decimate digit in right shift */
80009e54:	00098613          	mv	a2,s3
80009e58:	00090513          	mv	a0,s2
80009e5c:	000d0693          	mv	a3,s10
80009e60:	000a0593          	mv	a1,s4
			n /= 10; rv++;
80009e64:	001c0c13          	addi	s8,s8,1
	while (n >= 10) {	/* Decimate digit in right shift */
80009e68:	1c9020ef          	jal	ra,8000c830 <__gedf2>
80009e6c:	fa0558e3          	bgez	a0,80009e1c <f_printf+0x534>
80009e70:	000a0793          	mv	a5,s4
80009e74:	000b0a13          	mv	s4,s6
80009e78:	00078b13          	mv	s6,a5
	while (n < 1) {		/* Decimate digit in left shift */
80009e7c:	8000f7b7          	lui	a5,0x8000f
80009e80:	a907a603          	lw	a2,-1392(a5) # 8000ea90 <STACK_TOP+0xfffeea90>
80009e84:	a947a683          	lw	a3,-1388(a5)
80009e88:	000a8493          	mv	s1,s5
80009e8c:	000b8a93          	mv	s5,s7
80009e90:	00090b93          	mv	s7,s2
80009e94:	000b8513          	mv	a0,s7
80009e98:	000b0593          	mv	a1,s6
80009e9c:	01412403          	lw	s0,20(sp)
80009ea0:	00812903          	lw	s2,8(sp)
80009ea4:	271020ef          	jal	ra,8000c914 <__ledf2>
80009ea8:	060550e3          	bgez	a0,8000a708 <f_printf+0xe20>
80009eac:	8000f6b7          	lui	a3,0x8000f
		if (n < 0.00001) {
80009eb0:	ab86a783          	lw	a5,-1352(a3) # 8000eab8 <STACK_TOP+0xfffeeab8>
80009eb4:	abc6a803          	lw	a6,-1348(a3)
80009eb8:	00f12423          	sw	a5,8(sp)
80009ebc:	01012623          	sw	a6,12(sp)
80009ec0:	0440006f          	j	80009f04 <f_printf+0x61c>
			n *= 100000; rv -= 5;
80009ec4:	8000f7b7          	lui	a5,0x8000f
80009ec8:	aa87a603          	lw	a2,-1368(a5) # 8000eaa8 <STACK_TOP+0xfffeeaa8>
80009ecc:	aac7a683          	lw	a3,-1364(a5)
80009ed0:	000b8513          	mv	a0,s7
80009ed4:	000b0593          	mv	a1,s6
80009ed8:	321020ef          	jal	ra,8000c9f8 <__muldf3>
80009edc:	00050b93          	mv	s7,a0
80009ee0:	00058b13          	mv	s6,a1
80009ee4:	ffbc0c13          	addi	s8,s8,-5
	while (n < 1) {		/* Decimate digit in left shift */
80009ee8:	8000f7b7          	lui	a5,0x8000f
80009eec:	a907a603          	lw	a2,-1392(a5) # 8000ea90 <STACK_TOP+0xfffeea90>
80009ef0:	a947a683          	lw	a3,-1388(a5)
80009ef4:	000b8513          	mv	a0,s7
80009ef8:	000b0593          	mv	a1,s6
80009efc:	219020ef          	jal	ra,8000c914 <__ledf2>
80009f00:	000554e3          	bgez	a0,8000a708 <f_printf+0xe20>
		if (n < 0.00001) {
80009f04:	00812603          	lw	a2,8(sp)
80009f08:	00c12683          	lw	a3,12(sp)
80009f0c:	000b8513          	mv	a0,s7
80009f10:	000b0593          	mv	a1,s6
80009f14:	201020ef          	jal	ra,8000c914 <__ledf2>
80009f18:	fa0546e3          	bltz	a0,80009ec4 <f_printf+0x5dc>
			n *= 10; rv--;
80009f1c:	8000f7b7          	lui	a5,0x8000f
80009f20:	ab07a603          	lw	a2,-1360(a5) # 8000eab0 <STACK_TOP+0xfffeeab0>
80009f24:	ab47a683          	lw	a3,-1356(a5)
80009f28:	000b8513          	mv	a0,s7
80009f2c:	000b0593          	mv	a1,s6
80009f30:	2c9020ef          	jal	ra,8000c9f8 <__muldf3>
80009f34:	00050b93          	mv	s7,a0
80009f38:	00058b13          	mv	s6,a1
80009f3c:	fffc0c13          	addi	s8,s8,-1
80009f40:	fa9ff06f          	j	80009ee8 <f_printf+0x600>
			putc_bfd(&pb, tc); continue;
80009f44:	000d8593          	mv	a1,s11
80009f48:	09410513          	addi	a0,sp,148
80009f4c:	fd9fd0ef          	jal	ra,80007f24 <putc_bfd>
80009f50:	a41ff06f          	j	80009990 <f_printf+0xa8>
			putc_bfd(&pb, tc);
80009f54:	09410513          	addi	a0,sp,148
		tc = *fmt++;
80009f58:	001c8c93          	addi	s9,s9,1
			putc_bfd(&pb, tc);
80009f5c:	fc9fd0ef          	jal	ra,80007f24 <putc_bfd>
			continue;
80009f60:	a31ff06f          	j	80009990 <f_printf+0xa8>
			while (IsDigit(tc)) {	/* Minimum width */
80009f64:	fd0d8713          	addi	a4,s11,-48
80009f68:	0ff77713          	andi	a4,a4,255
80009f6c:	00900613          	li	a2,9
		f = w = 0; pad = ' '; prec = -1;	/* Initialize parms */
80009f70:	00000413          	li	s0,0
			while (IsDigit(tc)) {	/* Minimum width */
80009f74:	00900693          	li	a3,9
80009f78:	a6e664e3          	bltu	a2,a4,800099e0 <f_printf+0xf8>
80009f7c:	00040713          	mv	a4,s0
				w = w * 10 + tc - '0';
80009f80:	00271413          	slli	s0,a4,0x2
80009f84:	00e40433          	add	s0,s0,a4
80009f88:	00141413          	slli	s0,s0,0x1
				tc = *fmt++;
80009f8c:	001c8c93          	addi	s9,s9,1
				w = w * 10 + tc - '0';
80009f90:	01b40433          	add	s0,s0,s11
				tc = *fmt++;
80009f94:	fffccd83          	lbu	s11,-1(s9)
				w = w * 10 + tc - '0';
80009f98:	fd040713          	addi	a4,s0,-48
			while (IsDigit(tc)) {	/* Minimum width */
80009f9c:	fd0d8793          	addi	a5,s11,-48
80009fa0:	0ff7f793          	andi	a5,a5,255
80009fa4:	fcf6fee3          	bgeu	a3,a5,80009f80 <f_printf+0x698>
80009fa8:	00070413          	mv	s0,a4
		if (tc == '.') {			/* Precision */
80009fac:	02e00713          	li	a4,46
		f = w = 0; pad = ' '; prec = -1;	/* Initialize parms */
80009fb0:	fff00493          	li	s1,-1
		if (tc == '.') {			/* Precision */
80009fb4:	a2ed9ce3          	bne	s11,a4,800099ec <f_printf+0x104>
			tc = *fmt++;
80009fb8:	000ccd83          	lbu	s11,0(s9)
			if (tc == '*') {		/* Precision from an argument */
80009fbc:	02a00713          	li	a4,42
80009fc0:	0ced9c63          	bne	s11,a4,8000a098 <f_printf+0x7b0>
				prec = va_arg(arp, int);
80009fc4:	07012703          	lw	a4,112(sp)
				tc = *fmt++;
80009fc8:	001ccd83          	lbu	s11,1(s9)
80009fcc:	002c8c93          	addi	s9,s9,2
				prec = va_arg(arp, int);
80009fd0:	00470693          	addi	a3,a4,4
80009fd4:	06d12823          	sw	a3,112(sp)
80009fd8:	00072483          	lw	s1,0(a4)
				tc = *fmt++;
80009fdc:	a11ff06f          	j	800099ec <f_printf+0x104>
			pad = '0'; tc = *fmt++;
80009fe0:	002ccd83          	lbu	s11,2(s9)
80009fe4:	03000913          	li	s2,48
80009fe8:	003c8c93          	addi	s9,s9,3
		f = w = 0; pad = ' '; prec = -1;	/* Initialize parms */
80009fec:	00012223          	sw	zero,4(sp)
80009ff0:	9d1ff06f          	j	800099c0 <f_printf+0xd8>
			f = 2; tc = *fmt++;
80009ff4:	00200793          	li	a5,2
80009ff8:	002ccd83          	lbu	s11,2(s9)
		f = w = 0; pad = ' '; prec = -1;	/* Initialize parms */
80009ffc:	02000913          	li	s2,32
			f = 2; tc = *fmt++;
8000a000:	003c8c93          	addi	s9,s9,3
8000a004:	00f12223          	sw	a5,4(sp)
8000a008:	9b9ff06f          	j	800099c0 <f_printf+0xd8>
8000a00c:	00078d93          	mv	s11,a5
8000a010:	01f00993          	li	s3,31
		if (f & 1) str[i++] = '-';	/* Sign */
8000a014:	01012783          	lw	a5,16(sp)
8000a018:	00078c63          	beqz	a5,8000a030 <f_printf+0x748>
8000a01c:	0e010793          	addi	a5,sp,224
8000a020:	01b787b3          	add	a5,a5,s11
8000a024:	02d00713          	li	a4,45
8000a028:	f8e78a23          	sb	a4,-108(a5)
8000a02c:	00298d93          	addi	s11,s3,2
		for (j = i; !(f & 2) && j < w; j++) {	/* Left pads */
8000a030:	00412783          	lw	a5,4(sp)
8000a034:	0027f993          	andi	s3,a5,2
8000a038:	44099263          	bnez	s3,8000a47c <f_printf+0xb94>
8000a03c:	000d8993          	mv	s3,s11
8000a040:	008dfc63          	bgeu	s11,s0,8000a058 <f_printf+0x770>
8000a044:	00198993          	addi	s3,s3,1
			putc_bfd(&pb, pad);
8000a048:	00090593          	mv	a1,s2
8000a04c:	09410513          	addi	a0,sp,148
8000a050:	ed5fd0ef          	jal	ra,80007f24 <putc_bfd>
		for (j = i; !(f & 2) && j < w; j++) {	/* Left pads */
8000a054:	ff3418e3          	bne	s0,s3,8000a044 <f_printf+0x75c>
8000a058:	01b48933          	add	s2,s1,s11
			putc_bfd(&pb, (TCHAR)str[--i]);
8000a05c:	fff94583          	lbu	a1,-1(s2)
8000a060:	09410513          	addi	a0,sp,148
8000a064:	fff90913          	addi	s2,s2,-1
8000a068:	ebdfd0ef          	jal	ra,80007f24 <putc_bfd>
		} while (i);
8000a06c:	ff2498e3          	bne	s1,s2,8000a05c <f_printf+0x774>
		while (j++ < w) {	/* Right pads */
8000a070:	00198493          	addi	s1,s3,1
8000a074:	0089e663          	bltu	s3,s0,8000a080 <f_printf+0x798>
8000a078:	919ff06f          	j	80009990 <f_printf+0xa8>
8000a07c:	00078493          	mv	s1,a5
			putc_bfd(&pb, ' ');
8000a080:	02000593          	li	a1,32
8000a084:	09410513          	addi	a0,sp,148
8000a088:	e9dfd0ef          	jal	ra,80007f24 <putc_bfd>
		while (j++ < w) {	/* Right pads */
8000a08c:	00148793          	addi	a5,s1,1
8000a090:	fe9416e3          	bne	s0,s1,8000a07c <f_printf+0x794>
8000a094:	8fdff06f          	j	80009990 <f_printf+0xa8>
				while (IsDigit(tc)) {	/* Precision */
8000a098:	fd0d8713          	addi	a4,s11,-48
8000a09c:	0ff77713          	andi	a4,a4,255
8000a0a0:	00900613          	li	a2,9
			tc = *fmt++;
8000a0a4:	001c8c93          	addi	s9,s9,1
				prec = 0;
8000a0a8:	00000493          	li	s1,0
				while (IsDigit(tc)) {	/* Precision */
8000a0ac:	00900693          	li	a3,9
8000a0b0:	92e66ee3          	bltu	a2,a4,800099ec <f_printf+0x104>
					prec = prec * 10 + tc - '0';
8000a0b4:	00249793          	slli	a5,s1,0x2
8000a0b8:	009787b3          	add	a5,a5,s1
8000a0bc:	00179793          	slli	a5,a5,0x1
					tc = *fmt++;
8000a0c0:	001c8c93          	addi	s9,s9,1
					prec = prec * 10 + tc - '0';
8000a0c4:	01b787b3          	add	a5,a5,s11
					tc = *fmt++;
8000a0c8:	fffccd83          	lbu	s11,-1(s9)
					prec = prec * 10 + tc - '0';
8000a0cc:	fd078493          	addi	s1,a5,-48
				while (IsDigit(tc)) {	/* Precision */
8000a0d0:	fd0d8713          	addi	a4,s11,-48
8000a0d4:	0ff77713          	andi	a4,a4,255
8000a0d8:	fce6fee3          	bgeu	a3,a4,8000a0b4 <f_printf+0x7cc>
8000a0dc:	911ff06f          	j	800099ec <f_printf+0x104>
				f |= 8; tc = *fmt++;
8000a0e0:	00412783          	lw	a5,4(sp)
8000a0e4:	001ccd83          	lbu	s11,1(s9)
8000a0e8:	002c8c93          	addi	s9,s9,2
8000a0ec:	00c7e793          	ori	a5,a5,12
8000a0f0:	00f12223          	sw	a5,4(sp)
8000a0f4:	901ff06f          	j	800099f4 <f_printf+0x10c>
			v = (tc == 'd') ? (QWORD)(long long)va_arg(arp, int) : (QWORD)va_arg(arp, unsigned int);
8000a0f8:	00072a03          	lw	s4,0(a4)
8000a0fc:	06c12823          	sw	a2,112(sp)
8000a100:	41fa5d13          	srai	s10,s4,0x1f
		if (tc == 'd' && (v & 0x8000000000000000)) {	/* Negative value? */
8000a104:	000d0693          	mv	a3,s10
8000a108:	9a06d4e3          	bgez	a3,80009ab0 <f_printf+0x1c8>
8000a10c:	a81ff06f          	j	80009b8c <f_printf+0x2a4>
		if (val < 0) {			/* Negative? */
8000a110:	000a0513          	mv	a0,s4
8000a114:	000a8593          	mv	a1,s5
8000a118:	00000613          	li	a2,0
8000a11c:	00000693          	li	a3,0
		if (prec < 0) prec = 6;	/* Default precision? (6 fractional digits) */
8000a120:	00600493          	li	s1,6
		if (val < 0) {			/* Negative? */
8000a124:	7f0020ef          	jal	ra,8000c914 <__ledf2>
8000a128:	be0558e3          	bgez	a0,80009d18 <f_printf+0x430>
			val = 0 - val; sign = '-';
8000a12c:	000a0613          	mv	a2,s4
8000a130:	000a8693          	mv	a3,s5
8000a134:	00000513          	li	a0,0
8000a138:	00000593          	li	a1,0
8000a13c:	72d020ef          	jal	ra,8000d068 <__subdf3>
8000a140:	02d00793          	li	a5,45
8000a144:	00050a13          	mv	s4,a0
8000a148:	00058a93          	mv	s5,a1
8000a14c:	00f12823          	sw	a5,16(sp)
8000a150:	bd1ff06f          	j	80009d20 <f_printf+0x438>
			while (*tp && prec--) putc_bfd(&pb, *tp++);	/* Body */
8000a154:	b20592e3          	bnez	a1,80009c78 <f_printf+0x390>
8000a158:	b49ff06f          	j	80009ca0 <f_printf+0x3b8>
			er = "INF";
8000a15c:	8000e7b7          	lui	a5,0x8000e
		if (isinf(val)) {		/* Infinite? */
8000a160:	04e00713          	li	a4,78
8000a164:	04900693          	li	a3,73
			er = "INF";
8000a168:	3c878793          	addi	a5,a5,968 # 8000e3c8 <STACK_TOP+0xfffee3c8>
		if (sign) *buf++ = sign;		/* Add sign if needed */
8000a16c:	01012603          	lw	a2,16(sp)
8000a170:	07510b13          	addi	s6,sp,117
8000a174:	07410493          	addi	s1,sp,116
8000a178:	06c10a23          	sb	a2,116(sp)
8000a17c:	00c0006f          	j	8000a188 <f_printf+0x8a0>
8000a180:	00070693          	mv	a3,a4
		} while (*er);
8000a184:	0017c703          	lbu	a4,1(a5)
			*buf++ = *er++;
8000a188:	001b0b13          	addi	s6,s6,1
8000a18c:	fedb0fa3          	sb	a3,-1(s6)
8000a190:	00178793          	addi	a5,a5,1
		} while (*er);
8000a194:	fe0716e3          	bnez	a4,8000a180 <f_printf+0x898>
			for (j = strlen(str); !(f & 2) && j < w; j++) putc_bfd(&pb, pad);	/* Left pads */
8000a198:	00048513          	mv	a0,s1
	*buf = 0;	/* Term */
8000a19c:	000b0023          	sb	zero,0(s6)
			for (j = strlen(str); !(f & 2) && j < w; j++) putc_bfd(&pb, pad);	/* Left pads */
8000a1a0:	8a5f80ef          	jal	ra,80002a44 <strlen>
8000a1a4:	00412783          	lw	a5,4(sp)
8000a1a8:	00050493          	mv	s1,a0
8000a1ac:	0027f993          	andi	s3,a5,2
8000a1b0:	06099263          	bnez	s3,8000a214 <f_printf+0x92c>
8000a1b4:	00857c63          	bgeu	a0,s0,8000a1cc <f_printf+0x8e4>
8000a1b8:	00148493          	addi	s1,s1,1
8000a1bc:	00090593          	mv	a1,s2
8000a1c0:	09410513          	addi	a0,sp,148
8000a1c4:	d61fd0ef          	jal	ra,80007f24 <putc_bfd>
8000a1c8:	fe9418e3          	bne	s0,s1,8000a1b8 <f_printf+0x8d0>
			for (i = 0; str[i]; putc_bfd(&pb, str[i++])) ;	/* Body */
8000a1cc:	07414583          	lbu	a1,116(sp)
8000a1d0:	fc058063          	beqz	a1,80009990 <f_printf+0xa8>
8000a1d4:	07510913          	addi	s2,sp,117
8000a1d8:	09410513          	addi	a0,sp,148
8000a1dc:	00190913          	addi	s2,s2,1
8000a1e0:	d45fd0ef          	jal	ra,80007f24 <putc_bfd>
8000a1e4:	fff94583          	lbu	a1,-1(s2)
8000a1e8:	fe0598e3          	bnez	a1,8000a1d8 <f_printf+0x8f0>
			while (j++ < w) putc_bfd(&pb, ' ');	/* Right pads */
8000a1ec:	00148913          	addi	s2,s1,1
8000a1f0:	0084e663          	bltu	s1,s0,8000a1fc <f_printf+0x914>
8000a1f4:	f9cff06f          	j	80009990 <f_printf+0xa8>
8000a1f8:	00078913          	mv	s2,a5
8000a1fc:	02000593          	li	a1,32
8000a200:	09410513          	addi	a0,sp,148
8000a204:	d21fd0ef          	jal	ra,80007f24 <putc_bfd>
8000a208:	00190793          	addi	a5,s2,1
8000a20c:	ff2416e3          	bne	s0,s2,8000a1f8 <f_printf+0x910>
8000a210:	f80ff06f          	j	80009990 <f_printf+0xa8>
			for (i = 0; str[i]; putc_bfd(&pb, str[i++])) ;	/* Body */
8000a214:	07414583          	lbu	a1,116(sp)
8000a218:	fa059ee3          	bnez	a1,8000a1d4 <f_printf+0x8ec>
8000a21c:	fd1ff06f          	j	8000a1ec <f_printf+0x904>
			if (!tp) tp = &nul;		/* Null ptr generates a null string */
8000a220:	06f10a93          	addi	s5,sp,111
8000a224:	a01ff06f          	j	80009c24 <f_printf+0x33c>
8000a228:	409007b3          	neg	a5,s1
8000a22c:	00f12a23          	sw	a5,20(sp)
	int e = 0, m = 0;
8000a230:	00000b93          	li	s7,0
8000a234:	04012023          	sw	zero,64(sp)
			if (sign == '-') *buf++ = sign;	/* Add a - if negative value */
8000a238:	01012783          	lw	a5,16(sp)
8000a23c:	07410493          	addi	s1,sp,116
8000a240:	02d00713          	li	a4,45
8000a244:	00048693          	mv	a3,s1
8000a248:	00e79863          	bne	a5,a4,8000a258 <f_printf+0x970>
8000a24c:	06f10a23          	sb	a5,116(sp)
8000a250:	07510793          	addi	a5,sp,117
8000a254:	00078693          	mv	a3,a5
	while (n < 0) {		/* Right shift */
8000a258:	8000f737          	lui	a4,0x8000f
8000a25c:	a9072783          	lw	a5,-1392(a4) # 8000ea90 <STACK_TOP+0xfffeea90>
8000a260:	a9472703          	lw	a4,-1388(a4)
8000a264:	05212423          	sw	s2,72(sp)
8000a268:	00f12c23          	sw	a5,24(sp)
	double rv = 1;
8000a26c:	04f12c23          	sw	a5,88(sp)
8000a270:	02f12023          	sw	a5,32(sp)
8000a274:	04812623          	sw	s0,76(sp)
8000a278:	05912823          	sw	s9,80(sp)
8000a27c:	04912a23          	sw	s1,84(sp)
8000a280:	00068c93          	mv	s9,a3
	while (n < 0) {		/* Right shift */
8000a284:	00e12e23          	sw	a4,28(sp)
	double rv = 1;
8000a288:	04e12e23          	sw	a4,92(sp)
8000a28c:	02e12223          	sw	a4,36(sp)
8000a290:	05b12223          	sw	s11,68(sp)
				if (m == -1) *buf++ = ds;	/* Insert a decimal separator when get into fractional part */
8000a294:	fff00793          	li	a5,-1
		if (n <= -5) {
8000a298:	ffc00d13          	li	s10,-4
		if (n >= 5) {
8000a29c:	00400c13          	li	s8,4
8000a2a0:	03012403          	lw	s0,48(sp)
8000a2a4:	03412483          	lw	s1,52(sp)
8000a2a8:	03812903          	lw	s2,56(sp)
8000a2ac:	03c12983          	lw	s3,60(sp)
				if (m == -1) *buf++ = ds;	/* Insert a decimal separator when get into fractional part */
8000a2b0:	001c8b13          	addi	s6,s9,1
8000a2b4:	0afb8e63          	beq	s7,a5,8000a370 <f_printf+0xa88>
	while (n > 0) {		/* Left shift */
8000a2b8:	13705663          	blez	s7,8000a3e4 <f_printf+0xafc>
	double rv = 1;
8000a2bc:	02012703          	lw	a4,32(sp)
8000a2c0:	02412783          	lw	a5,36(sp)
	while (n > 0) {		/* Left shift */
8000a2c4:	000b8d93          	mv	s11,s7
	double rv = 1;
8000a2c8:	00070513          	mv	a0,a4
8000a2cc:	00078593          	mv	a1,a5
		if (n >= 5) {
8000a2d0:	11bc5063          	bge	s8,s11,8000a3d0 <f_printf+0xae8>
			rv *= 100000; n -= 5;
8000a2d4:	8000f6b7          	lui	a3,0x8000f
8000a2d8:	aa86a603          	lw	a2,-1368(a3) # 8000eaa8 <STACK_TOP+0xfffeeaa8>
8000a2dc:	aac6a683          	lw	a3,-1364(a3)
8000a2e0:	ffbd8d93          	addi	s11,s11,-5
8000a2e4:	714020ef          	jal	ra,8000c9f8 <__muldf3>
	while (n > 0) {		/* Left shift */
8000a2e8:	fe0d94e3          	bnez	s11,8000a2d0 <f_printf+0x9e8>
8000a2ec:	00050713          	mv	a4,a0
8000a2f0:	00058793          	mv	a5,a1
				d = (int)(val / w); val -= d * w;
8000a2f4:	00070613          	mv	a2,a4
8000a2f8:	00078693          	mv	a3,a5
8000a2fc:	000a0513          	mv	a0,s4
8000a300:	000a8593          	mv	a1,s5
8000a304:	00e12423          	sw	a4,8(sp)
8000a308:	00f12823          	sw	a5,16(sp)
8000a30c:	4c9010ef          	jal	ra,8000bfd4 <__divdf3>
8000a310:	568030ef          	jal	ra,8000d878 <__fixdfsi>
8000a314:	00050d93          	mv	s11,a0
8000a318:	5e0030ef          	jal	ra,8000d8f8 <__floatsidf>
8000a31c:	01012783          	lw	a5,16(sp)
8000a320:	00812703          	lw	a4,8(sp)
			} while (--m >= -prec);			/* Output all digits specified by prec */
8000a324:	fffb8b93          	addi	s7,s7,-1
				d = (int)(val / w); val -= d * w;
8000a328:	00078693          	mv	a3,a5
8000a32c:	00070613          	mv	a2,a4
8000a330:	6c8020ef          	jal	ra,8000c9f8 <__muldf3>
8000a334:	00050613          	mv	a2,a0
8000a338:	00058693          	mv	a3,a1
8000a33c:	000a0513          	mv	a0,s4
8000a340:	000a8593          	mv	a1,s5
8000a344:	525020ef          	jal	ra,8000d068 <__subdf3>
			} while (--m >= -prec);			/* Output all digits specified by prec */
8000a348:	01412783          	lw	a5,20(sp)
				*buf++ = (char)('0' + d);	/* Put the digit */
8000a34c:	030d8813          	addi	a6,s11,48
8000a350:	010c8023          	sb	a6,0(s9)
				d = (int)(val / w); val -= d * w;
8000a354:	00050a13          	mv	s4,a0
8000a358:	00058a93          	mv	s5,a1
			} while (--m >= -prec);			/* Output all digits specified by prec */
8000a35c:	0afbc263          	blt	s7,a5,8000a400 <f_printf+0xb18>
8000a360:	000b0c93          	mv	s9,s6
				if (m == -1) *buf++ = ds;	/* Insert a decimal separator when get into fractional part */
8000a364:	fff00793          	li	a5,-1
8000a368:	001c8b13          	addi	s6,s9,1
8000a36c:	f4fb96e3          	bne	s7,a5,8000a2b8 <f_printf+0x9d0>
8000a370:	002c8793          	addi	a5,s9,2
8000a374:	02e00713          	li	a4,46
8000a378:	00ec8023          	sb	a4,0(s9)
8000a37c:	000b0c93          	mv	s9,s6
	while (n < 0) {		/* Right shift */
8000a380:	01812703          	lw	a4,24(sp)
				if (m == -1) *buf++ = ds;	/* Insert a decimal separator when get into fractional part */
8000a384:	00078b13          	mv	s6,a5
	while (n < 0) {		/* Right shift */
8000a388:	01c12783          	lw	a5,28(sp)
				if (m == -1) *buf++ = ds;	/* Insert a decimal separator when get into fractional part */
8000a38c:	fff00d93          	li	s11,-1
	while (n < 0) {		/* Right shift */
8000a390:	00070513          	mv	a0,a4
8000a394:	00078593          	mv	a1,a5
		if (n <= -5) {
8000a398:	03add063          	bge	s11,s10,8000a3b8 <f_printf+0xad0>
			rv /= 100000; n += 5;
8000a39c:	8000f6b7          	lui	a3,0x8000f
8000a3a0:	aa86a603          	lw	a2,-1368(a3) # 8000eaa8 <STACK_TOP+0xfffeeaa8>
8000a3a4:	aac6a683          	lw	a3,-1364(a3)
8000a3a8:	005d8d93          	addi	s11,s11,5
8000a3ac:	429010ef          	jal	ra,8000bfd4 <__divdf3>
	while (n < 0) {		/* Right shift */
8000a3b0:	f20d8ee3          	beqz	s11,8000a2ec <f_printf+0xa04>
		if (n <= -5) {
8000a3b4:	ffadc4e3          	blt	s11,s10,8000a39c <f_printf+0xab4>
			rv /= 10; n++;
8000a3b8:	00040613          	mv	a2,s0
8000a3bc:	00048693          	mv	a3,s1
8000a3c0:	001d8d93          	addi	s11,s11,1
8000a3c4:	411010ef          	jal	ra,8000bfd4 <__divdf3>
	while (n < 0) {		/* Right shift */
8000a3c8:	fe0d96e3          	bnez	s11,8000a3b4 <f_printf+0xacc>
8000a3cc:	f21ff06f          	j	8000a2ec <f_printf+0xa04>
			rv *= 10; n--;
8000a3d0:	00090613          	mv	a2,s2
8000a3d4:	00098693          	mv	a3,s3
8000a3d8:	620020ef          	jal	ra,8000c9f8 <__muldf3>
8000a3dc:	fffd8d93          	addi	s11,s11,-1
8000a3e0:	f09ff06f          	j	8000a2e8 <f_printf+0xa00>
	while (n < 0) {		/* Right shift */
8000a3e4:	740b8863          	beqz	s7,8000ab34 <f_printf+0x124c>
8000a3e8:	01812703          	lw	a4,24(sp)
8000a3ec:	01c12783          	lw	a5,28(sp)
8000a3f0:	000b8d93          	mv	s11,s7
8000a3f4:	00070513          	mv	a0,a4
8000a3f8:	00078593          	mv	a1,a5
8000a3fc:	f9dff06f          	j	8000a398 <f_printf+0xab0>
8000a400:	04412d83          	lw	s11,68(sp)
			if (fmt != 'f') {	/* Put exponent if needed */
8000a404:	06600713          	li	a4,102
8000a408:	000c8793          	mv	a5,s9
8000a40c:	000c8693          	mv	a3,s9
8000a410:	04812903          	lw	s2,72(sp)
8000a414:	04c12403          	lw	s0,76(sp)
8000a418:	05012c83          	lw	s9,80(sp)
8000a41c:	05412483          	lw	s1,84(sp)
8000a420:	d6ed8ce3          	beq	s11,a4,8000a198 <f_printf+0x8b0>
				if (e < 0) {
8000a424:	04012703          	lw	a4,64(sp)
				*buf++ = (char)fmt;
8000a428:	01b780a3          	sb	s11,1(a5)
					*buf++ = '+';
8000a42c:	02b00793          	li	a5,43
				if (e < 0) {
8000a430:	00075863          	bgez	a4,8000a440 <f_printf+0xb58>
					e = 0 - e; *buf++ = '-';
8000a434:	40e007b3          	neg	a5,a4
8000a438:	04f12023          	sw	a5,64(sp)
8000a43c:	02d00793          	li	a5,45
				*buf++ = (char)('0' + e / 10);
8000a440:	04012a03          	lw	s4,64(sp)
8000a444:	00a00593          	li	a1,10
8000a448:	00f68123          	sb	a5,2(a3)
8000a44c:	000a0513          	mv	a0,s4
8000a450:	00068993          	mv	s3,a3
8000a454:	574030ef          	jal	ra,8000d9c8 <__divsi3>
8000a458:	03050513          	addi	a0,a0,48
8000a45c:	00a981a3          	sb	a0,3(s3)
				*buf++ = (char)('0' + e % 10);
8000a460:	00a00593          	li	a1,10
8000a464:	000a0513          	mv	a0,s4
8000a468:	5e4030ef          	jal	ra,8000da4c <__modsi3>
8000a46c:	03050513          	addi	a0,a0,48
8000a470:	00598b13          	addi	s6,s3,5
8000a474:	00a98223          	sb	a0,4(s3)
	if (er) {	/* Error condition */
8000a478:	d21ff06f          	j	8000a198 <f_printf+0x8b0>
		for (j = i; !(f & 2) && j < w; j++) {	/* Left pads */
8000a47c:	000d8993          	mv	s3,s11
8000a480:	bd9ff06f          	j	8000a058 <f_printf+0x770>
				val += i10x(0 - prec) / 2;	/* Round (nearest) */
8000a484:	409009b3          	neg	s3,s1
8000a488:	01312a23          	sw	s3,20(sp)
	while (n < 0) {		/* Right shift */
8000a48c:	62048e63          	beqz	s1,8000aac8 <f_printf+0x11e0>
	double rv = 1;
8000a490:	8000f7b7          	lui	a5,0x8000f
8000a494:	a907a503          	lw	a0,-1392(a5) # 8000ea90 <STACK_TOP+0xfffeea90>
8000a498:	a947a583          	lw	a1,-1388(a5)
			rv /= 100000; n += 5;
8000a49c:	8000f7b7          	lui	a5,0x8000f
8000a4a0:	aa87ab83          	lw	s7,-1368(a5) # 8000eaa8 <STACK_TOP+0xfffeeaa8>
8000a4a4:	aac7ac03          	lw	s8,-1364(a5)
		if (n <= -5) {
8000a4a8:	ffc00b13          	li	s6,-4
8000a4ac:	2569d263          	bge	s3,s6,8000a6f0 <f_printf+0xe08>
			rv /= 100000; n += 5;
8000a4b0:	000b8613          	mv	a2,s7
8000a4b4:	000c0693          	mv	a3,s8
8000a4b8:	31d010ef          	jal	ra,8000bfd4 <__divdf3>
8000a4bc:	00598993          	addi	s3,s3,5
	while (n < 0) {		/* Right shift */
8000a4c0:	fe0996e3          	bnez	s3,8000a4ac <f_printf+0xbc4>
8000a4c4:	8000f737          	lui	a4,0x8000f
8000a4c8:	a9872603          	lw	a2,-1384(a4) # 8000ea98 <STACK_TOP+0xfffeea98>
8000a4cc:	a9c72683          	lw	a3,-1380(a4)
8000a4d0:	528020ef          	jal	ra,8000c9f8 <__muldf3>
8000a4d4:	00050613          	mv	a2,a0
8000a4d8:	00058693          	mv	a3,a1
				val += i10x(0 - prec) / 2;	/* Round (nearest) */
8000a4dc:	000a0513          	mv	a0,s4
8000a4e0:	000a8593          	mv	a1,s5
8000a4e4:	330010ef          	jal	ra,8000b814 <__adddf3>
	while (n >= 10) {	/* Decimate digit in right shift */
8000a4e8:	8000f7b7          	lui	a5,0x8000f
8000a4ec:	ab47ac03          	lw	s8,-1356(a5) # 8000eab4 <STACK_TOP+0xfffeeab4>
8000a4f0:	ab07ab03          	lw	s6,-1360(a5)
				val += i10x(0 - prec) / 2;	/* Round (nearest) */
8000a4f4:	00050993          	mv	s3,a0
	while (n >= 10) {	/* Decimate digit in right shift */
8000a4f8:	000c0693          	mv	a3,s8
8000a4fc:	000b0613          	mv	a2,s6
				val += i10x(0 - prec) / 2;	/* Round (nearest) */
8000a500:	00058d13          	mv	s10,a1
8000a504:	00050a13          	mv	s4,a0
8000a508:	00058a93          	mv	s5,a1
	while (n >= 10) {	/* Decimate digit in right shift */
8000a50c:	324020ef          	jal	ra,8000c830 <__gedf2>
8000a510:	5a054863          	bltz	a0,8000aac0 <f_printf+0x11d8>
			n /= 10; rv++;
8000a514:	000c0793          	mv	a5,s8
8000a518:	000b0713          	mv	a4,s6
	while (n >= 10) {	/* Decimate digit in right shift */
8000a51c:	000b0c13          	mv	s8,s6
8000a520:	01212423          	sw	s2,8(sp)
8000a524:	00812c23          	sw	s0,24(sp)
8000a528:	00098913          	mv	s2,s3
8000a52c:	000a0a93          	mv	s5,s4
	int rv = 0;
8000a530:	00000b93          	li	s7,0
	while (n >= 10) {	/* Decimate digit in right shift */
8000a534:	00048a13          	mv	s4,s1
8000a538:	00078b13          	mv	s6,a5
8000a53c:	000d0993          	mv	s3,s10
8000a540:	00070413          	mv	s0,a4
8000a544:	00078493          	mv	s1,a5
8000a548:	0400006f          	j	8000a588 <f_printf+0xca0>
			n /= 100000; rv += 5;
8000a54c:	8000f7b7          	lui	a5,0x8000f
8000a550:	aa87a603          	lw	a2,-1368(a5) # 8000eaa8 <STACK_TOP+0xfffeeaa8>
8000a554:	aac7a683          	lw	a3,-1364(a5)
8000a558:	00090513          	mv	a0,s2
8000a55c:	00098593          	mv	a1,s3
8000a560:	275010ef          	jal	ra,8000bfd4 <__divdf3>
8000a564:	00050913          	mv	s2,a0
8000a568:	00058993          	mv	s3,a1
	while (n >= 10) {	/* Decimate digit in right shift */
8000a56c:	000c0613          	mv	a2,s8
8000a570:	00090513          	mv	a0,s2
8000a574:	000b0693          	mv	a3,s6
8000a578:	00098593          	mv	a1,s3
			n /= 100000; rv += 5;
8000a57c:	005b8b93          	addi	s7,s7,5
	while (n >= 10) {	/* Decimate digit in right shift */
8000a580:	2b0020ef          	jal	ra,8000c830 <__gedf2>
8000a584:	04054c63          	bltz	a0,8000a5dc <f_printf+0xcf4>
		if (n >= 100000) {
8000a588:	8000f7b7          	lui	a5,0x8000f
8000a58c:	aa87a603          	lw	a2,-1368(a5) # 8000eaa8 <STACK_TOP+0xfffeeaa8>
8000a590:	aac7a683          	lw	a3,-1364(a5)
8000a594:	00090513          	mv	a0,s2
8000a598:	00098593          	mv	a1,s3
8000a59c:	294020ef          	jal	ra,8000c830 <__gedf2>
8000a5a0:	fa0556e3          	bgez	a0,8000a54c <f_printf+0xc64>
			n /= 10; rv++;
8000a5a4:	00040613          	mv	a2,s0
8000a5a8:	00090513          	mv	a0,s2
8000a5ac:	00048693          	mv	a3,s1
8000a5b0:	00098593          	mv	a1,s3
8000a5b4:	221010ef          	jal	ra,8000bfd4 <__divdf3>
8000a5b8:	00050913          	mv	s2,a0
8000a5bc:	00058993          	mv	s3,a1
	while (n >= 10) {	/* Decimate digit in right shift */
8000a5c0:	000c0613          	mv	a2,s8
8000a5c4:	00090513          	mv	a0,s2
8000a5c8:	000b0693          	mv	a3,s6
8000a5cc:	00098593          	mv	a1,s3
			n /= 10; rv++;
8000a5d0:	001b8b93          	addi	s7,s7,1
	while (n >= 10) {	/* Decimate digit in right shift */
8000a5d4:	25c020ef          	jal	ra,8000c830 <__gedf2>
8000a5d8:	fa0558e3          	bgez	a0,8000a588 <f_printf+0xca0>
8000a5dc:	000a0493          	mv	s1,s4
8000a5e0:	01812403          	lw	s0,24(sp)
8000a5e4:	000a8a13          	mv	s4,s5
8000a5e8:	000d0a93          	mv	s5,s10
8000a5ec:	00098d13          	mv	s10,s3
8000a5f0:	00090993          	mv	s3,s2
8000a5f4:	00812903          	lw	s2,8(sp)
	while (n < 1) {		/* Decimate digit in left shift */
8000a5f8:	8000f7b7          	lui	a5,0x8000f
8000a5fc:	a947ab03          	lw	s6,-1388(a5) # 8000ea94 <STACK_TOP+0xfffeea94>
8000a600:	a907ac03          	lw	s8,-1392(a5)
8000a604:	00098513          	mv	a0,s3
8000a608:	000b0693          	mv	a3,s6
8000a60c:	000c0613          	mv	a2,s8
8000a610:	000d0593          	mv	a1,s10
8000a614:	300020ef          	jal	ra,8000c914 <__ledf2>
8000a618:	8000f6b7          	lui	a3,0x8000f
8000a61c:	0a055463          	bgez	a0,8000a6c4 <f_printf+0xddc>
		if (n < 0.00001) {
8000a620:	ab86a783          	lw	a5,-1352(a3) # 8000eab8 <STACK_TOP+0xfffeeab8>
8000a624:	abc6a803          	lw	a6,-1348(a3)
8000a628:	00f12423          	sw	a5,8(sp)
8000a62c:	01012623          	sw	a6,12(sp)
8000a630:	0400006f          	j	8000a670 <f_printf+0xd88>
			n *= 100000; rv -= 5;
8000a634:	8000f7b7          	lui	a5,0x8000f
8000a638:	aa87a603          	lw	a2,-1368(a5) # 8000eaa8 <STACK_TOP+0xfffeeaa8>
8000a63c:	aac7a683          	lw	a3,-1364(a5)
8000a640:	00098513          	mv	a0,s3
8000a644:	000d0593          	mv	a1,s10
8000a648:	3b0020ef          	jal	ra,8000c9f8 <__muldf3>
8000a64c:	00050993          	mv	s3,a0
8000a650:	00058d13          	mv	s10,a1
	while (n < 1) {		/* Decimate digit in left shift */
8000a654:	000c0613          	mv	a2,s8
8000a658:	00098513          	mv	a0,s3
8000a65c:	000b0693          	mv	a3,s6
8000a660:	000d0593          	mv	a1,s10
			n *= 100000; rv -= 5;
8000a664:	ffbb8b93          	addi	s7,s7,-5
	while (n < 1) {		/* Decimate digit in left shift */
8000a668:	2ac020ef          	jal	ra,8000c914 <__ledf2>
8000a66c:	04055c63          	bgez	a0,8000a6c4 <f_printf+0xddc>
		if (n < 0.00001) {
8000a670:	00812603          	lw	a2,8(sp)
8000a674:	00c12683          	lw	a3,12(sp)
8000a678:	00098513          	mv	a0,s3
8000a67c:	000d0593          	mv	a1,s10
8000a680:	294020ef          	jal	ra,8000c914 <__ledf2>
8000a684:	fa0548e3          	bltz	a0,8000a634 <f_printf+0xd4c>
			n *= 10; rv--;
8000a688:	8000f7b7          	lui	a5,0x8000f
8000a68c:	ab07a603          	lw	a2,-1360(a5) # 8000eab0 <STACK_TOP+0xfffeeab0>
8000a690:	ab47a683          	lw	a3,-1356(a5)
8000a694:	00098513          	mv	a0,s3
8000a698:	000d0593          	mv	a1,s10
8000a69c:	35c020ef          	jal	ra,8000c9f8 <__muldf3>
8000a6a0:	00050993          	mv	s3,a0
8000a6a4:	00058d13          	mv	s10,a1
	while (n < 1) {		/* Decimate digit in left shift */
8000a6a8:	000c0613          	mv	a2,s8
8000a6ac:	00098513          	mv	a0,s3
8000a6b0:	000b0693          	mv	a3,s6
8000a6b4:	000d0593          	mv	a1,s10
			n *= 10; rv--;
8000a6b8:	fffb8b93          	addi	s7,s7,-1
	while (n < 1) {		/* Decimate digit in left shift */
8000a6bc:	258020ef          	jal	ra,8000c914 <__ledf2>
8000a6c0:	fa0548e3          	bltz	a0,8000a670 <f_printf+0xd88>
				if (m < 0) m = 0;
8000a6c4:	fffbc713          	not	a4,s7
8000a6c8:	41f75713          	srai	a4,a4,0x1f
8000a6cc:	00ebfbb3          	and	s7,s7,a4
				if (m + prec + 3 >= SZ_NUM_BUF) er = "OV";	/* Buffer overflow? */
8000a6d0:	009b84b3          	add	s1,s7,s1
8000a6d4:	01c00713          	li	a4,28
8000a6d8:	b4975ee3          	bge	a4,s1,8000a234 <f_printf+0x94c>
8000a6dc:	8000e7b7          	lui	a5,0x8000e
					if (e > 99 || prec + 7 >= SZ_NUM_BUF) {	/* Buffer overflow or E > +99? */
8000a6e0:	05600713          	li	a4,86
8000a6e4:	04f00693          	li	a3,79
				if (m + prec + 3 >= SZ_NUM_BUF) er = "OV";	/* Buffer overflow? */
8000a6e8:	3cc78793          	addi	a5,a5,972 # 8000e3cc <STACK_TOP+0xfffee3cc>
8000a6ec:	a81ff06f          	j	8000a16c <f_printf+0x884>
			rv /= 10; n++;
8000a6f0:	8000f7b7          	lui	a5,0x8000f
8000a6f4:	ab07a603          	lw	a2,-1360(a5) # 8000eab0 <STACK_TOP+0xfffeeab0>
8000a6f8:	ab47a683          	lw	a3,-1356(a5)
8000a6fc:	00198993          	addi	s3,s3,1
8000a700:	0d5010ef          	jal	ra,8000bfd4 <__divdf3>
8000a704:	dbdff06f          	j	8000a4c0 <f_printf+0xbd8>
					val += i10x(ilog10(val) - prec) / 2;	/* Round (nearest) */
8000a708:	409c0c33          	sub	s8,s8,s1
	while (n > 0) {		/* Left shift */
8000a70c:	2d805663          	blez	s8,8000a9d8 <f_printf+0x10f0>
	double rv = 1;
8000a710:	8000f7b7          	lui	a5,0x8000f
8000a714:	a907a503          	lw	a0,-1392(a5) # 8000ea90 <STACK_TOP+0xfffeea90>
8000a718:	a947a583          	lw	a1,-1388(a5)
			rv *= 10; n--;
8000a71c:	8000f7b7          	lui	a5,0x8000f
8000a720:	ab07ab03          	lw	s6,-1360(a5) # 8000eab0 <STACK_TOP+0xfffeeab0>
8000a724:	ab47ab83          	lw	s7,-1356(a5)
		if (n >= 5) {
8000a728:	00400d13          	li	s10,4
8000a72c:	1d8d5e63          	bge	s10,s8,8000a908 <f_printf+0x1020>
			rv *= 100000; n -= 5;
8000a730:	8000f7b7          	lui	a5,0x8000f
8000a734:	aa87a603          	lw	a2,-1368(a5) # 8000eaa8 <STACK_TOP+0xfffeeaa8>
8000a738:	aac7a683          	lw	a3,-1364(a5)
8000a73c:	ffbc0c13          	addi	s8,s8,-5
8000a740:	2b8020ef          	jal	ra,8000c9f8 <__muldf3>
	while (n > 0) {		/* Left shift */
8000a744:	fe0c14e3          	bnez	s8,8000a72c <f_printf+0xe44>
					val += i10x(ilog10(val) - prec) / 2;	/* Round (nearest) */
8000a748:	8000f737          	lui	a4,0x8000f
8000a74c:	a9872603          	lw	a2,-1384(a4) # 8000ea98 <STACK_TOP+0xfffeea98>
8000a750:	a9c72683          	lw	a3,-1380(a4)
8000a754:	2a4020ef          	jal	ra,8000c9f8 <__muldf3>
8000a758:	000a0613          	mv	a2,s4
8000a75c:	000a8693          	mv	a3,s5
8000a760:	0b4010ef          	jal	ra,8000b814 <__adddf3>
	while (n >= 10) {	/* Decimate digit in right shift */
8000a764:	8000f7b7          	lui	a5,0x8000f
8000a768:	ab47a983          	lw	s3,-1356(a5) # 8000eab4 <STACK_TOP+0xfffeeab4>
8000a76c:	ab07ab03          	lw	s6,-1360(a5)
					val += i10x(ilog10(val) - prec) / 2;	/* Round (nearest) */
8000a770:	00050c13          	mv	s8,a0
	while (n >= 10) {	/* Decimate digit in right shift */
8000a774:	00098693          	mv	a3,s3
8000a778:	000b0613          	mv	a2,s6
					val += i10x(ilog10(val) - prec) / 2;	/* Round (nearest) */
8000a77c:	00a12423          	sw	a0,8(sp)
8000a780:	00058b93          	mv	s7,a1
8000a784:	00b12a23          	sw	a1,20(sp)
	while (n >= 10) {	/* Decimate digit in right shift */
8000a788:	0a8020ef          	jal	ra,8000c830 <__gedf2>
8000a78c:	36054263          	bltz	a0,8000aaf0 <f_printf+0x1208>
		if (n >= 100000) {
8000a790:	8000f7b7          	lui	a5,0x8000f
8000a794:	aa87aa03          	lw	s4,-1368(a5) # 8000eaa8 <STACK_TOP+0xfffeeaa8>
8000a798:	aac7aa83          	lw	s5,-1364(a5)
	int rv = 0;
8000a79c:	00000713          	li	a4,0
			n /= 10; rv++;
8000a7a0:	000b0793          	mv	a5,s6
	while (n >= 10) {	/* Decimate digit in right shift */
8000a7a4:	01b12c23          	sw	s11,24(sp)
8000a7a8:	000c0b13          	mv	s6,s8
8000a7ac:	00812e23          	sw	s0,28(sp)
8000a7b0:	00078d13          	mv	s10,a5
8000a7b4:	00098c13          	mv	s8,s3
8000a7b8:	00070d93          	mv	s11,a4
8000a7bc:	00078413          	mv	s0,a5
8000a7c0:	03c0006f          	j	8000a7fc <f_printf+0xf14>
			n /= 100000; rv += 5;
8000a7c4:	000b0513          	mv	a0,s6
8000a7c8:	000b8593          	mv	a1,s7
8000a7cc:	000a0613          	mv	a2,s4
8000a7d0:	000a8693          	mv	a3,s5
8000a7d4:	001010ef          	jal	ra,8000bfd4 <__divdf3>
8000a7d8:	00050b13          	mv	s6,a0
8000a7dc:	00058b93          	mv	s7,a1
	while (n >= 10) {	/* Decimate digit in right shift */
8000a7e0:	000d0613          	mv	a2,s10
8000a7e4:	000b0513          	mv	a0,s6
8000a7e8:	000c0693          	mv	a3,s8
8000a7ec:	000b8593          	mv	a1,s7
			n /= 100000; rv += 5;
8000a7f0:	005d8d93          	addi	s11,s11,5
	while (n >= 10) {	/* Decimate digit in right shift */
8000a7f4:	03c020ef          	jal	ra,8000c830 <__gedf2>
8000a7f8:	04054a63          	bltz	a0,8000a84c <f_printf+0xf64>
		if (n >= 100000) {
8000a7fc:	000b0513          	mv	a0,s6
8000a800:	000b8593          	mv	a1,s7
8000a804:	000a0613          	mv	a2,s4
8000a808:	000a8693          	mv	a3,s5
8000a80c:	024020ef          	jal	ra,8000c830 <__gedf2>
8000a810:	fa055ae3          	bgez	a0,8000a7c4 <f_printf+0xedc>
			n /= 10; rv++;
8000a814:	00040613          	mv	a2,s0
8000a818:	000b0513          	mv	a0,s6
8000a81c:	00098693          	mv	a3,s3
8000a820:	000b8593          	mv	a1,s7
8000a824:	7b0010ef          	jal	ra,8000bfd4 <__divdf3>
8000a828:	00050b13          	mv	s6,a0
8000a82c:	00058b93          	mv	s7,a1
	while (n >= 10) {	/* Decimate digit in right shift */
8000a830:	000d0613          	mv	a2,s10
8000a834:	000b0513          	mv	a0,s6
8000a838:	000c0693          	mv	a3,s8
8000a83c:	000b8593          	mv	a1,s7
			n /= 10; rv++;
8000a840:	001d8d93          	addi	s11,s11,1
	while (n >= 10) {	/* Decimate digit in right shift */
8000a844:	7ed010ef          	jal	ra,8000c830 <__gedf2>
8000a848:	fa055ae3          	bgez	a0,8000a7fc <f_printf+0xf14>
	while (n < 1) {		/* Decimate digit in left shift */
8000a84c:	8000f7b7          	lui	a5,0x8000f
8000a850:	a907a603          	lw	a2,-1392(a5) # 8000ea90 <STACK_TOP+0xfffeea90>
8000a854:	a947a683          	lw	a3,-1388(a5)
8000a858:	000b0513          	mv	a0,s6
8000a85c:	000b8593          	mv	a1,s7
8000a860:	05b12023          	sw	s11,64(sp)
8000a864:	01c12403          	lw	s0,28(sp)
8000a868:	01812d83          	lw	s11,24(sp)
8000a86c:	0a8020ef          	jal	ra,8000c914 <__ledf2>
8000a870:	0a055863          	bgez	a0,8000a920 <f_printf+0x1038>
8000a874:	8000f6b7          	lui	a3,0x8000f
		if (n < 0.00001) {
8000a878:	ab86aa03          	lw	s4,-1352(a3) # 8000eab8 <STACK_TOP+0xfffeeab8>
8000a87c:	abc6aa83          	lw	s5,-1348(a3)
	while (n < 1) {		/* Decimate digit in left shift */
8000a880:	04012983          	lw	s3,64(sp)
8000a884:	0440006f          	j	8000a8c8 <f_printf+0xfe0>
			n *= 100000; rv -= 5;
8000a888:	8000f7b7          	lui	a5,0x8000f
8000a88c:	aa87a603          	lw	a2,-1368(a5) # 8000eaa8 <STACK_TOP+0xfffeeaa8>
8000a890:	aac7a683          	lw	a3,-1364(a5)
8000a894:	000b0513          	mv	a0,s6
8000a898:	000b8593          	mv	a1,s7
8000a89c:	15c020ef          	jal	ra,8000c9f8 <__muldf3>
8000a8a0:	00050b13          	mv	s6,a0
8000a8a4:	00058b93          	mv	s7,a1
8000a8a8:	ffb98993          	addi	s3,s3,-5
	while (n < 1) {		/* Decimate digit in left shift */
8000a8ac:	8000f7b7          	lui	a5,0x8000f
8000a8b0:	a907a603          	lw	a2,-1392(a5) # 8000ea90 <STACK_TOP+0xfffeea90>
8000a8b4:	a947a683          	lw	a3,-1388(a5)
8000a8b8:	000b0513          	mv	a0,s6
8000a8bc:	000b8593          	mv	a1,s7
8000a8c0:	054020ef          	jal	ra,8000c914 <__ledf2>
8000a8c4:	04055c63          	bgez	a0,8000a91c <f_printf+0x1034>
		if (n < 0.00001) {
8000a8c8:	000b0513          	mv	a0,s6
8000a8cc:	000b8593          	mv	a1,s7
8000a8d0:	000a0613          	mv	a2,s4
8000a8d4:	000a8693          	mv	a3,s5
8000a8d8:	03c020ef          	jal	ra,8000c914 <__ledf2>
8000a8dc:	fa0546e3          	bltz	a0,8000a888 <f_printf+0xfa0>
			n *= 10; rv--;
8000a8e0:	8000f7b7          	lui	a5,0x8000f
8000a8e4:	ab07a603          	lw	a2,-1360(a5) # 8000eab0 <STACK_TOP+0xfffeeab0>
8000a8e8:	ab47a683          	lw	a3,-1356(a5)
8000a8ec:	000b0513          	mv	a0,s6
8000a8f0:	000b8593          	mv	a1,s7
8000a8f4:	104020ef          	jal	ra,8000c9f8 <__muldf3>
8000a8f8:	00050b13          	mv	s6,a0
8000a8fc:	00058b93          	mv	s7,a1
8000a900:	fff98993          	addi	s3,s3,-1
8000a904:	fa9ff06f          	j	8000a8ac <f_printf+0xfc4>
			rv *= 10; n--;
8000a908:	000b0613          	mv	a2,s6
8000a90c:	000b8693          	mv	a3,s7
8000a910:	0e8020ef          	jal	ra,8000c9f8 <__muldf3>
8000a914:	fffc0c13          	addi	s8,s8,-1
8000a918:	e2dff06f          	j	8000a744 <f_printf+0xe5c>
8000a91c:	05312023          	sw	s3,64(sp)
					if (e > 99 || prec + 7 >= SZ_NUM_BUF) {	/* Buffer overflow or E > +99? */
8000a920:	04012a83          	lw	s5,64(sp)
8000a924:	06300713          	li	a4,99
8000a928:	db574ae3          	blt	a4,s5,8000a6dc <f_printf+0xdf4>
8000a92c:	01800713          	li	a4,24
8000a930:	da9746e3          	blt	a4,s1,8000a6dc <f_printf+0xdf4>
						if (e < -99) e = -99;
8000a934:	f9d00713          	li	a4,-99
8000a938:	12eac463          	blt	s5,a4,8000aa60 <f_printf+0x1178>
	while (n > 0) {		/* Left shift */
8000a93c:	19505e63          	blez	s5,8000aad8 <f_printf+0x11f0>
	double rv = 1;
8000a940:	8000f7b7          	lui	a5,0x8000f
8000a944:	a907a503          	lw	a0,-1392(a5) # 8000ea90 <STACK_TOP+0xfffeea90>
8000a948:	a947a583          	lw	a1,-1388(a5)
			rv *= 10; n--;
8000a94c:	8000f7b7          	lui	a5,0x8000f
8000a950:	ab07ab03          	lw	s6,-1360(a5) # 8000eab0 <STACK_TOP+0xfffeeab0>
8000a954:	ab47ab83          	lw	s7,-1356(a5)
		if (n >= 5) {
8000a958:	00400a13          	li	s4,4
8000a95c:	0f5a5863          	bge	s4,s5,8000aa4c <f_printf+0x1164>
			rv *= 100000; n -= 5;
8000a960:	8000f6b7          	lui	a3,0x8000f
8000a964:	aa86a603          	lw	a2,-1368(a3) # 8000eaa8 <STACK_TOP+0xfffeeaa8>
8000a968:	aac6a683          	lw	a3,-1364(a3)
8000a96c:	ffba8a93          	addi	s5,s5,-5
8000a970:	088020ef          	jal	ra,8000c9f8 <__muldf3>
	while (n > 0) {		/* Left shift */
8000a974:	fe0a94e3          	bnez	s5,8000a95c <f_printf+0x1074>
						val /= i10x(e);	/* Normalize */
8000a978:	01412883          	lw	a7,20(sp)
8000a97c:	00812803          	lw	a6,8(sp)
8000a980:	00050613          	mv	a2,a0
8000a984:	00058693          	mv	a3,a1
8000a988:	00080513          	mv	a0,a6
8000a98c:	00088593          	mv	a1,a7
8000a990:	644010ef          	jal	ra,8000bfd4 <__divdf3>
8000a994:	409007b3          	neg	a5,s1
8000a998:	00050a13          	mv	s4,a0
8000a99c:	00058a93          	mv	s5,a1
		if (!er) {	/* Not error condition */
8000a9a0:	00f12a23          	sw	a5,20(sp)
	int e = 0, m = 0;
8000a9a4:	00000b93          	li	s7,0
8000a9a8:	891ff06f          	j	8000a238 <f_printf+0x950>
	while (n < 1) {		/* Decimate digit in left shift */
8000a9ac:	8000f7b7          	lui	a5,0x8000f
8000a9b0:	a907a603          	lw	a2,-1392(a5) # 8000ea90 <STACK_TOP+0xfffeea90>
8000a9b4:	a947a683          	lw	a3,-1388(a5)
8000a9b8:	000a0513          	mv	a0,s4
8000a9bc:	000a8593          	mv	a1,s5
8000a9c0:	755010ef          	jal	ra,8000c914 <__ledf2>
8000a9c4:	000a0b93          	mv	s7,s4
8000a9c8:	000a8b13          	mv	s6,s5
	int rv = 0;
8000a9cc:	00000c13          	li	s8,0
	while (n < 1) {		/* Decimate digit in left shift */
8000a9d0:	cc054e63          	bltz	a0,80009eac <f_printf+0x5c4>
					val += i10x(ilog10(val) - prec) / 2;	/* Round (nearest) */
8000a9d4:	40900c33          	neg	s8,s1
	while (n < 0) {		/* Right shift */
8000a9d8:	8000f7b7          	lui	a5,0x8000f
8000a9dc:	a907a503          	lw	a0,-1392(a5) # 8000ea90 <STACK_TOP+0xfffeea90>
8000a9e0:	a947a583          	lw	a1,-1388(a5)
8000a9e4:	d60c02e3          	beqz	s8,8000a748 <f_printf+0xe60>
			rv /= 10; n++;
8000a9e8:	8000f7b7          	lui	a5,0x8000f
		if (n <= -5) {
8000a9ec:	ffc00d13          	li	s10,-4
			rv /= 10; n++;
8000a9f0:	ab07ab03          	lw	s6,-1360(a5) # 8000eab0 <STACK_TOP+0xfffeeab0>
8000a9f4:	ab47ab83          	lw	s7,-1356(a5)
		if (n <= -5) {
8000a9f8:	03ac5063          	bge	s8,s10,8000aa18 <f_printf+0x1130>
			rv /= 100000; n += 5;
8000a9fc:	8000f7b7          	lui	a5,0x8000f
8000aa00:	aa87a603          	lw	a2,-1368(a5) # 8000eaa8 <STACK_TOP+0xfffeeaa8>
8000aa04:	aac7a683          	lw	a3,-1364(a5)
8000aa08:	005c0c13          	addi	s8,s8,5
8000aa0c:	5c8010ef          	jal	ra,8000bfd4 <__divdf3>
	while (n < 0) {		/* Right shift */
8000aa10:	d20c0ce3          	beqz	s8,8000a748 <f_printf+0xe60>
		if (n <= -5) {
8000aa14:	ffac44e3          	blt	s8,s10,8000a9fc <f_printf+0x1114>
			rv /= 10; n++;
8000aa18:	000b0613          	mv	a2,s6
8000aa1c:	000b8693          	mv	a3,s7
8000aa20:	001c0c13          	addi	s8,s8,1
8000aa24:	5b0010ef          	jal	ra,8000bfd4 <__divdf3>
	while (n < 0) {		/* Right shift */
8000aa28:	fe0c16e3          	bnez	s8,8000aa14 <f_printf+0x112c>
8000aa2c:	d1dff06f          	j	8000a748 <f_printf+0xe60>
	if (isnan(val)) {			/* Not a number? */
8000aa30:	07410493          	addi	s1,sp,116
8000aa34:	8000e7b7          	lui	a5,0x8000e
8000aa38:	06100713          	li	a4,97
8000aa3c:	04e00693          	li	a3,78
8000aa40:	3c478793          	addi	a5,a5,964 # 8000e3c4 <STACK_TOP+0xfffee3c4>
8000aa44:	00048b13          	mv	s6,s1
8000aa48:	f40ff06f          	j	8000a188 <f_printf+0x8a0>
			rv *= 10; n--;
8000aa4c:	000b0613          	mv	a2,s6
8000aa50:	000b8693          	mv	a3,s7
8000aa54:	7a5010ef          	jal	ra,8000c9f8 <__muldf3>
8000aa58:	fffa8a93          	addi	s5,s5,-1
8000aa5c:	f19ff06f          	j	8000a974 <f_printf+0x108c>
						if (e < -99) e = -99;
8000aa60:	f9d00793          	li	a5,-99
8000aa64:	04f12023          	sw	a5,64(sp)
8000aa68:	f9d00a93          	li	s5,-99
	while (n < 0) {		/* Right shift */
8000aa6c:	8000f7b7          	lui	a5,0x8000f
8000aa70:	a907a503          	lw	a0,-1392(a5) # 8000ea90 <STACK_TOP+0xfffeea90>
8000aa74:	a947a583          	lw	a1,-1388(a5)
		if (n <= -5) {
8000aa78:	ffc00a13          	li	s4,-4
			rv /= 10; n++;
8000aa7c:	8000f7b7          	lui	a5,0x8000f
8000aa80:	ab07ab03          	lw	s6,-1360(a5) # 8000eab0 <STACK_TOP+0xfffeeab0>
8000aa84:	ab47ab83          	lw	s7,-1356(a5)
		if (n <= -5) {
8000aa88:	034ad063          	bge	s5,s4,8000aaa8 <f_printf+0x11c0>
			rv /= 100000; n += 5;
8000aa8c:	8000f6b7          	lui	a3,0x8000f
8000aa90:	aa86a603          	lw	a2,-1368(a3) # 8000eaa8 <STACK_TOP+0xfffeeaa8>
8000aa94:	aac6a683          	lw	a3,-1364(a3)
8000aa98:	005a8a93          	addi	s5,s5,5
8000aa9c:	538010ef          	jal	ra,8000bfd4 <__divdf3>
	while (n < 0) {		/* Right shift */
8000aaa0:	ec0a8ce3          	beqz	s5,8000a978 <f_printf+0x1090>
		if (n <= -5) {
8000aaa4:	ff4ac4e3          	blt	s5,s4,8000aa8c <f_printf+0x11a4>
			rv /= 10; n++;
8000aaa8:	000b0613          	mv	a2,s6
8000aaac:	000b8693          	mv	a3,s7
8000aab0:	001a8a93          	addi	s5,s5,1
8000aab4:	520010ef          	jal	ra,8000bfd4 <__divdf3>
	while (n < 0) {		/* Right shift */
8000aab8:	fe0a96e3          	bnez	s5,8000aaa4 <f_printf+0x11bc>
8000aabc:	ebdff06f          	j	8000a978 <f_printf+0x1090>
	int rv = 0;
8000aac0:	00000b93          	li	s7,0
8000aac4:	b35ff06f          	j	8000a5f8 <f_printf+0xd10>
	while (n < 0) {		/* Right shift */
8000aac8:	8000f737          	lui	a4,0x8000f
8000aacc:	a9872603          	lw	a2,-1384(a4) # 8000ea98 <STACK_TOP+0xfffeea98>
8000aad0:	a9c72683          	lw	a3,-1380(a4)
8000aad4:	a09ff06f          	j	8000a4dc <f_printf+0xbf4>
8000aad8:	04012a83          	lw	s5,64(sp)
8000aadc:	f80a98e3          	bnez	s5,8000aa6c <f_printf+0x1184>
	double rv = 1;
8000aae0:	8000f7b7          	lui	a5,0x8000f
8000aae4:	a907a503          	lw	a0,-1392(a5) # 8000ea90 <STACK_TOP+0xfffeea90>
8000aae8:	a947a583          	lw	a1,-1388(a5)
8000aaec:	e8dff06f          	j	8000a978 <f_printf+0x1090>
	while (n < 1) {		/* Decimate digit in left shift */
8000aaf0:	8000f7b7          	lui	a5,0x8000f
8000aaf4:	a947aa03          	lw	s4,-1388(a5) # 8000ea94 <STACK_TOP+0xfffeea94>
8000aaf8:	a907aa83          	lw	s5,-1392(a5)
8000aafc:	00812b03          	lw	s6,8(sp)
8000ab00:	01412b83          	lw	s7,20(sp)
8000ab04:	000a8613          	mv	a2,s5
8000ab08:	000b0513          	mv	a0,s6
8000ab0c:	000a0693          	mv	a3,s4
8000ab10:	000b8593          	mv	a1,s7
8000ab14:	601010ef          	jal	ra,8000c914 <__ledf2>
	int rv = 0;
8000ab18:	04012023          	sw	zero,64(sp)
	while (n < 1) {		/* Decimate digit in left shift */
8000ab1c:	d4054ce3          	bltz	a0,8000a874 <f_printf+0xf8c>
					if (e > 99 || prec + 7 >= SZ_NUM_BUF) {	/* Buffer overflow or E > +99? */
8000ab20:	01800713          	li	a4,24
8000ab24:	ba974ce3          	blt	a4,s1,8000a6dc <f_printf+0xdf4>
	double rv = 1;
8000ab28:	000a8513          	mv	a0,s5
8000ab2c:	000a0593          	mv	a1,s4
8000ab30:	e49ff06f          	j	8000a978 <f_printf+0x1090>
8000ab34:	05812703          	lw	a4,88(sp)
8000ab38:	05c12783          	lw	a5,92(sp)
8000ab3c:	fb8ff06f          	j	8000a2f4 <f_printf+0xa0c>

8000ab40 <ff_uni2oem>:
{
	WCHAR c = 0;
	const WCHAR* p = CVTBL(uc, FF_CODE_PAGE);


	if (uni < 0x80) {	/* ASCII? */
8000ab40:	07f00793          	li	a5,127
8000ab44:	00a7ea63          	bltu	a5,a0,8000ab58 <ff_uni2oem+0x18>
		c = (WCHAR)uni;
8000ab48:	01051793          	slli	a5,a0,0x10
8000ab4c:	0107d793          	srli	a5,a5,0x10
			c = (c + 0x80) & 0xFF;
		}
	}

	return c;
}
8000ab50:	00078513          	mv	a0,a5
8000ab54:	00008067          	ret
		if (uni < 0x10000 && cp == FF_CODE_PAGE) {	/* Is it in BMP and valid code page? */
8000ab58:	00010737          	lui	a4,0x10
	WCHAR c = 0;
8000ab5c:	00000793          	li	a5,0
		if (uni < 0x10000 && cp == FF_CODE_PAGE) {	/* Is it in BMP and valid code page? */
8000ab60:	fee578e3          	bgeu	a0,a4,8000ab50 <ff_uni2oem+0x10>
8000ab64:	1b500713          	li	a4,437
8000ab68:	fee594e3          	bne	a1,a4,8000ab50 <ff_uni2oem+0x10>
8000ab6c:	8000e737          	lui	a4,0x8000e
8000ab70:	56a70713          	addi	a4,a4,1386 # 8000e56a <STACK_TOP+0xfffee56a>
8000ab74:	0c700693          	li	a3,199
			for (c = 0; c < 0x80 && uni != p[c]; c++) ;
8000ab78:	08000593          	li	a1,128
8000ab7c:	0180006f          	j	8000ab94 <ff_uni2oem+0x54>
8000ab80:	01061793          	slli	a5,a2,0x10
8000ab84:	0107d793          	srli	a5,a5,0x10
8000ab88:	02b78263          	beq	a5,a1,8000abac <ff_uni2oem+0x6c>
8000ab8c:	00075683          	lhu	a3,0(a4)
8000ab90:	00270713          	addi	a4,a4,2
8000ab94:	00178613          	addi	a2,a5,1
8000ab98:	fea694e3          	bne	a3,a0,8000ab80 <ff_uni2oem+0x40>
8000ab9c:	08078793          	addi	a5,a5,128
8000aba0:	01079793          	slli	a5,a5,0x10
8000aba4:	0107d793          	srli	a5,a5,0x10
8000aba8:	fa9ff06f          	j	8000ab50 <ff_uni2oem+0x10>
8000abac:	00000793          	li	a5,0
			c = (c + 0x80) & 0xFF;
8000abb0:	fa1ff06f          	j	8000ab50 <ff_uni2oem+0x10>

8000abb4 <ff_oem2uni>:
{
	WCHAR c = 0;
	const WCHAR* p = CVTBL(uc, FF_CODE_PAGE);


	if (oem < 0x80) {	/* ASCII? */
8000abb4:	07f00793          	li	a5,127
8000abb8:	00a7f863          	bgeu	a5,a0,8000abc8 <ff_oem2uni+0x14>
		c = oem;

	} else {			/* Extended char */
		if (cp == FF_CODE_PAGE) {	/* Is it a valid code page? */
8000abbc:	1b500793          	li	a5,437
8000abc0:	00f58663          	beq	a1,a5,8000abcc <ff_oem2uni+0x18>
	WCHAR c = 0;
8000abc4:	00000513          	li	a0,0
			if (oem < 0x100) c = p[oem - 0x80];
		}
	}

	return c;
}
8000abc8:	00008067          	ret
			if (oem < 0x100) c = p[oem - 0x80];
8000abcc:	0ff00793          	li	a5,255
8000abd0:	fea7eae3          	bltu	a5,a0,8000abc4 <ff_oem2uni+0x10>
8000abd4:	8000e7b7          	lui	a5,0x8000e
8000abd8:	56878793          	addi	a5,a5,1384 # 8000e568 <STACK_TOP+0xfffee568>
8000abdc:	00151513          	slli	a0,a0,0x1
8000abe0:	00a78533          	add	a0,a5,a0
8000abe4:	f0055503          	lhu	a0,-256(a0)
8000abe8:	00008067          	ret

8000abec <ff_wtoupper>:

		0x0000	/* EOT */
	};


	if (uni < 0x10000) {	/* Is it in BMP? */
8000abec:	000107b7          	lui	a5,0x10
8000abf0:	04f57863          	bgeu	a0,a5,8000ac40 <ff_wtoupper+0x54>
		uc = (WORD)uni;
8000abf4:	01051813          	slli	a6,a0,0x10
		p = uc < 0x1000 ? cvt1 : cvt2;
8000abf8:	000017b7          	lui	a5,0x1
		uc = (WORD)uni;
8000abfc:	01085813          	srli	a6,a6,0x10
		p = uc < 0x1000 ? cvt1 : cvt2;
8000ac00:	04f57263          	bgeu	a0,a5,8000ac44 <ff_wtoupper+0x58>
8000ac04:	8000e737          	lui	a4,0x8000e
8000ac08:	06100693          	li	a3,97
8000ac0c:	66870713          	addi	a4,a4,1640 # 8000e668 <STACK_TOP+0xfffee668>
		for (;;) {
			bc = *p++;								/* Get the block base */
			if (bc == 0 || uc < bc) break;			/* Not matched? */
8000ac10:	02068663          	beqz	a3,8000ac3c <ff_wtoupper+0x50>
8000ac14:	02d86463          	bltu	a6,a3,8000ac3c <ff_wtoupper+0x50>
			nc = *p++; cmd = nc >> 8; nc &= 0xFF;	/* Get processing command and block size */
8000ac18:	00470713          	addi	a4,a4,4
8000ac1c:	ffe75783          	lhu	a5,-2(a4)
8000ac20:	0ff7f613          	andi	a2,a5,255
			if (uc < bc + nc) {	/* In the block? */
8000ac24:	00d605b3          	add	a1,a2,a3
			nc = *p++; cmd = nc >> 8; nc &= 0xFF;	/* Get processing command and block size */
8000ac28:	0087d793          	srli	a5,a5,0x8
			if (uc < bc + nc) {	/* In the block? */
8000ac2c:	02b54e63          	blt	a0,a1,8000ac68 <ff_wtoupper+0x7c>
				case 7: uc -= 80; break;			/* Shift -80 */
				case 8:	uc -= 0x1C60; break;		/* Shift -0x1C60 */
				}
				break;
			}
			if (cmd == 0) p += nc;	/* Skip table if needed */
8000ac30:	02078463          	beqz	a5,8000ac58 <ff_wtoupper+0x6c>
8000ac34:	00075683          	lhu	a3,0(a4)
			if (bc == 0 || uc < bc) break;			/* Not matched? */
8000ac38:	fc069ee3          	bnez	a3,8000ac14 <ff_wtoupper+0x28>
		}
		uni = uc;
8000ac3c:	00080513          	mv	a0,a6
	}

	return uni;
}
8000ac40:	00008067          	ret
		p = uc < 0x1000 ? cvt1 : cvt2;
8000ac44:	000026b7          	lui	a3,0x2
8000ac48:	8000f737          	lui	a4,0x8000f
8000ac4c:	d7d68693          	addi	a3,a3,-643 # 1d7d <crtStart-0x7fffe283>
8000ac50:	85c70713          	addi	a4,a4,-1956 # 8000e85c <STACK_TOP+0xfffee85c>
8000ac54:	fbdff06f          	j	8000ac10 <ff_wtoupper+0x24>
			if (cmd == 0) p += nc;	/* Skip table if needed */
8000ac58:	00161613          	slli	a2,a2,0x1
8000ac5c:	00c70733          	add	a4,a4,a2
8000ac60:	00075683          	lhu	a3,0(a4)
8000ac64:	fd5ff06f          	j	8000ac38 <ff_wtoupper+0x4c>
				switch (cmd) {
8000ac68:	00800613          	li	a2,8
8000ac6c:	fcf668e3          	bltu	a2,a5,8000ac3c <ff_wtoupper+0x50>
8000ac70:	8000e637          	lui	a2,0x8000e
8000ac74:	00279793          	slli	a5,a5,0x2
8000ac78:	54460613          	addi	a2,a2,1348 # 8000e544 <STACK_TOP+0xfffee544>
8000ac7c:	00c787b3          	add	a5,a5,a2
8000ac80:	0007a783          	lw	a5,0(a5) # 1000 <crtStart-0x7ffff000>
8000ac84:	00078067          	jr	a5
				case 7: uc -= 80; break;			/* Shift -80 */
8000ac88:	fb080813          	addi	a6,a6,-80
8000ac8c:	01081813          	slli	a6,a6,0x10
8000ac90:	01085813          	srli	a6,a6,0x10
		uni = uc;
8000ac94:	00080513          	mv	a0,a6
8000ac98:	fa9ff06f          	j	8000ac40 <ff_wtoupper+0x54>
				case 6:	uc += 8; break;				/* Shift +8 */
8000ac9c:	00880813          	addi	a6,a6,8
8000aca0:	01081813          	slli	a6,a6,0x10
8000aca4:	01085813          	srli	a6,a6,0x10
		uni = uc;
8000aca8:	00080513          	mv	a0,a6
8000acac:	f95ff06f          	j	8000ac40 <ff_wtoupper+0x54>
				case 5:	uc -= 26; break;			/* Shift -26 */
8000acb0:	fe680813          	addi	a6,a6,-26
8000acb4:	01081813          	slli	a6,a6,0x10
8000acb8:	01085813          	srli	a6,a6,0x10
		uni = uc;
8000acbc:	00080513          	mv	a0,a6
8000acc0:	f81ff06f          	j	8000ac40 <ff_wtoupper+0x54>
				case 4:	uc -= 48; break;			/* Shift -48 */
8000acc4:	fd080813          	addi	a6,a6,-48
8000acc8:	01081813          	slli	a6,a6,0x10
8000accc:	01085813          	srli	a6,a6,0x10
		uni = uc;
8000acd0:	00080513          	mv	a0,a6
8000acd4:	f6dff06f          	j	8000ac40 <ff_wtoupper+0x54>
				case 3:	uc -= 32; break;			/* Shift -32 */
8000acd8:	fe080813          	addi	a6,a6,-32
8000acdc:	01081813          	slli	a6,a6,0x10
8000ace0:	01085813          	srli	a6,a6,0x10
		uni = uc;
8000ace4:	00080513          	mv	a0,a6
8000ace8:	f59ff06f          	j	8000ac40 <ff_wtoupper+0x54>
				case 2: uc -= 16; break;			/* Shift -16 */
8000acec:	ff080813          	addi	a6,a6,-16
8000acf0:	01081813          	slli	a6,a6,0x10
8000acf4:	01085813          	srli	a6,a6,0x10
		uni = uc;
8000acf8:	00080513          	mv	a0,a6
8000acfc:	f45ff06f          	j	8000ac40 <ff_wtoupper+0x54>
				case 1:	uc -= (uc - bc) & 1; break;	/* Case pairs */
8000ad00:	40d806b3          	sub	a3,a6,a3
8000ad04:	0016f793          	andi	a5,a3,1
8000ad08:	40f80833          	sub	a6,a6,a5
8000ad0c:	01081813          	slli	a6,a6,0x10
8000ad10:	01085813          	srli	a6,a6,0x10
		uni = uc;
8000ad14:	00080513          	mv	a0,a6
8000ad18:	f29ff06f          	j	8000ac40 <ff_wtoupper+0x54>
				case 0:	uc = p[uc - bc]; break;		/* Table conversion */
8000ad1c:	40d507b3          	sub	a5,a0,a3
8000ad20:	00179793          	slli	a5,a5,0x1
8000ad24:	00f70733          	add	a4,a4,a5
8000ad28:	00075803          	lhu	a6,0(a4)
		uni = uc;
8000ad2c:	00080513          	mv	a0,a6
8000ad30:	f11ff06f          	j	8000ac40 <ff_wtoupper+0x54>
				case 8:	uc -= 0x1C60; break;		/* Shift -0x1C60 */
8000ad34:	ffffe7b7          	lui	a5,0xffffe
8000ad38:	3a078793          	addi	a5,a5,928 # ffffe3a0 <STACK_TOP+0x7ffde3a0>
8000ad3c:	00f80833          	add	a6,a6,a5
8000ad40:	01081813          	slli	a6,a6,0x10
8000ad44:	01085813          	srli	a6,a6,0x10
		uni = uc;
8000ad48:	00080513          	mv	a0,a6
8000ad4c:	ef5ff06f          	j	8000ac40 <ff_wtoupper+0x54>

8000ad50 <__udivdi3>:
8000ad50:	fd010113          	addi	sp,sp,-48
8000ad54:	02912223          	sw	s1,36(sp)
8000ad58:	01612823          	sw	s6,16(sp)
8000ad5c:	02112623          	sw	ra,44(sp)
8000ad60:	02812423          	sw	s0,40(sp)
8000ad64:	03212023          	sw	s2,32(sp)
8000ad68:	01312e23          	sw	s3,28(sp)
8000ad6c:	01412c23          	sw	s4,24(sp)
8000ad70:	01512a23          	sw	s5,20(sp)
8000ad74:	01712623          	sw	s7,12(sp)
8000ad78:	01812423          	sw	s8,8(sp)
8000ad7c:	01912223          	sw	s9,4(sp)
8000ad80:	00050b13          	mv	s6,a0
8000ad84:	00058493          	mv	s1,a1
8000ad88:	38069c63          	bnez	a3,8000b120 <__udivdi3+0x3d0>
8000ad8c:	00060413          	mv	s0,a2
8000ad90:	00050993          	mv	s3,a0
8000ad94:	00004917          	auipc	s2,0x4
8000ad98:	bfc90913          	addi	s2,s2,-1028 # 8000e990 <__clz_tab>
8000ad9c:	12c5f863          	bgeu	a1,a2,8000aecc <__udivdi3+0x17c>
8000ada0:	000107b7          	lui	a5,0x10
8000ada4:	00058a93          	mv	s5,a1
8000ada8:	10f67863          	bgeu	a2,a5,8000aeb8 <__udivdi3+0x168>
8000adac:	0ff00693          	li	a3,255
8000adb0:	00c6b6b3          	sltu	a3,a3,a2
8000adb4:	00369693          	slli	a3,a3,0x3
8000adb8:	00d657b3          	srl	a5,a2,a3
8000adbc:	00f90933          	add	s2,s2,a5
8000adc0:	00094703          	lbu	a4,0(s2)
8000adc4:	00d706b3          	add	a3,a4,a3
8000adc8:	02000713          	li	a4,32
8000adcc:	40d70733          	sub	a4,a4,a3
8000add0:	00070c63          	beqz	a4,8000ade8 <__udivdi3+0x98>
8000add4:	00e494b3          	sll	s1,s1,a4
8000add8:	00db56b3          	srl	a3,s6,a3
8000addc:	00e61433          	sll	s0,a2,a4
8000ade0:	0096eab3          	or	s5,a3,s1
8000ade4:	00eb19b3          	sll	s3,s6,a4
8000ade8:	01045b13          	srli	s6,s0,0x10
8000adec:	000b0593          	mv	a1,s6
8000adf0:	000a8513          	mv	a0,s5
8000adf4:	425020ef          	jal	ra,8000da18 <__umodsi3>
8000adf8:	00050913          	mv	s2,a0
8000adfc:	000b0593          	mv	a1,s6
8000ae00:	01041b93          	slli	s7,s0,0x10
8000ae04:	000a8513          	mv	a0,s5
8000ae08:	3c9020ef          	jal	ra,8000d9d0 <__udivsi3>
8000ae0c:	010bdb93          	srli	s7,s7,0x10
8000ae10:	00050493          	mv	s1,a0
8000ae14:	00050593          	mv	a1,a0
8000ae18:	000b8513          	mv	a0,s7
8000ae1c:	389020ef          	jal	ra,8000d9a4 <__mulsi3>
8000ae20:	01091913          	slli	s2,s2,0x10
8000ae24:	0109d713          	srli	a4,s3,0x10
8000ae28:	00e96733          	or	a4,s2,a4
8000ae2c:	00048a13          	mv	s4,s1
8000ae30:	00a77e63          	bgeu	a4,a0,8000ae4c <__udivdi3+0xfc>
8000ae34:	00870733          	add	a4,a4,s0
8000ae38:	fff48a13          	addi	s4,s1,-1
8000ae3c:	00876863          	bltu	a4,s0,8000ae4c <__udivdi3+0xfc>
8000ae40:	00a77663          	bgeu	a4,a0,8000ae4c <__udivdi3+0xfc>
8000ae44:	ffe48a13          	addi	s4,s1,-2
8000ae48:	00870733          	add	a4,a4,s0
8000ae4c:	40a704b3          	sub	s1,a4,a0
8000ae50:	000b0593          	mv	a1,s6
8000ae54:	00048513          	mv	a0,s1
8000ae58:	3c1020ef          	jal	ra,8000da18 <__umodsi3>
8000ae5c:	00050913          	mv	s2,a0
8000ae60:	000b0593          	mv	a1,s6
8000ae64:	00048513          	mv	a0,s1
8000ae68:	369020ef          	jal	ra,8000d9d0 <__udivsi3>
8000ae6c:	01099993          	slli	s3,s3,0x10
8000ae70:	00050493          	mv	s1,a0
8000ae74:	00050593          	mv	a1,a0
8000ae78:	01091913          	slli	s2,s2,0x10
8000ae7c:	000b8513          	mv	a0,s7
8000ae80:	0109d993          	srli	s3,s3,0x10
8000ae84:	321020ef          	jal	ra,8000d9a4 <__mulsi3>
8000ae88:	013969b3          	or	s3,s2,s3
8000ae8c:	00048613          	mv	a2,s1
8000ae90:	00a9fc63          	bgeu	s3,a0,8000aea8 <__udivdi3+0x158>
8000ae94:	013409b3          	add	s3,s0,s3
8000ae98:	fff48613          	addi	a2,s1,-1
8000ae9c:	0089e663          	bltu	s3,s0,8000aea8 <__udivdi3+0x158>
8000aea0:	00a9f463          	bgeu	s3,a0,8000aea8 <__udivdi3+0x158>
8000aea4:	ffe48613          	addi	a2,s1,-2
8000aea8:	010a1793          	slli	a5,s4,0x10
8000aeac:	00c7e7b3          	or	a5,a5,a2
8000aeb0:	00000a13          	li	s4,0
8000aeb4:	1300006f          	j	8000afe4 <__udivdi3+0x294>
8000aeb8:	010007b7          	lui	a5,0x1000
8000aebc:	01000693          	li	a3,16
8000aec0:	eef66ce3          	bltu	a2,a5,8000adb8 <__udivdi3+0x68>
8000aec4:	01800693          	li	a3,24
8000aec8:	ef1ff06f          	j	8000adb8 <__udivdi3+0x68>
8000aecc:	00068a13          	mv	s4,a3
8000aed0:	00061a63          	bnez	a2,8000aee4 <__udivdi3+0x194>
8000aed4:	00000593          	li	a1,0
8000aed8:	00100513          	li	a0,1
8000aedc:	2f5020ef          	jal	ra,8000d9d0 <__udivsi3>
8000aee0:	00050413          	mv	s0,a0
8000aee4:	000107b7          	lui	a5,0x10
8000aee8:	12f47c63          	bgeu	s0,a5,8000b020 <__udivdi3+0x2d0>
8000aeec:	0ff00793          	li	a5,255
8000aef0:	0087f463          	bgeu	a5,s0,8000aef8 <__udivdi3+0x1a8>
8000aef4:	00800a13          	li	s4,8
8000aef8:	014457b3          	srl	a5,s0,s4
8000aefc:	00f90933          	add	s2,s2,a5
8000af00:	00094683          	lbu	a3,0(s2)
8000af04:	02000613          	li	a2,32
8000af08:	014686b3          	add	a3,a3,s4
8000af0c:	40d60633          	sub	a2,a2,a3
8000af10:	12061263          	bnez	a2,8000b034 <__udivdi3+0x2e4>
8000af14:	408484b3          	sub	s1,s1,s0
8000af18:	00100a13          	li	s4,1
8000af1c:	01045b13          	srli	s6,s0,0x10
8000af20:	000b0593          	mv	a1,s6
8000af24:	00048513          	mv	a0,s1
8000af28:	2f1020ef          	jal	ra,8000da18 <__umodsi3>
8000af2c:	00050913          	mv	s2,a0
8000af30:	000b0593          	mv	a1,s6
8000af34:	00048513          	mv	a0,s1
8000af38:	01041b93          	slli	s7,s0,0x10
8000af3c:	295020ef          	jal	ra,8000d9d0 <__udivsi3>
8000af40:	010bdb93          	srli	s7,s7,0x10
8000af44:	00050493          	mv	s1,a0
8000af48:	00050593          	mv	a1,a0
8000af4c:	000b8513          	mv	a0,s7
8000af50:	255020ef          	jal	ra,8000d9a4 <__mulsi3>
8000af54:	01091913          	slli	s2,s2,0x10
8000af58:	0109d713          	srli	a4,s3,0x10
8000af5c:	00e96733          	or	a4,s2,a4
8000af60:	00048a93          	mv	s5,s1
8000af64:	00a77e63          	bgeu	a4,a0,8000af80 <__udivdi3+0x230>
8000af68:	00870733          	add	a4,a4,s0
8000af6c:	fff48a93          	addi	s5,s1,-1
8000af70:	00876863          	bltu	a4,s0,8000af80 <__udivdi3+0x230>
8000af74:	00a77663          	bgeu	a4,a0,8000af80 <__udivdi3+0x230>
8000af78:	ffe48a93          	addi	s5,s1,-2
8000af7c:	00870733          	add	a4,a4,s0
8000af80:	40a704b3          	sub	s1,a4,a0
8000af84:	000b0593          	mv	a1,s6
8000af88:	00048513          	mv	a0,s1
8000af8c:	28d020ef          	jal	ra,8000da18 <__umodsi3>
8000af90:	00050913          	mv	s2,a0
8000af94:	000b0593          	mv	a1,s6
8000af98:	00048513          	mv	a0,s1
8000af9c:	235020ef          	jal	ra,8000d9d0 <__udivsi3>
8000afa0:	01099993          	slli	s3,s3,0x10
8000afa4:	00050493          	mv	s1,a0
8000afa8:	00050593          	mv	a1,a0
8000afac:	01091913          	slli	s2,s2,0x10
8000afb0:	000b8513          	mv	a0,s7
8000afb4:	0109d993          	srli	s3,s3,0x10
8000afb8:	1ed020ef          	jal	ra,8000d9a4 <__mulsi3>
8000afbc:	013969b3          	or	s3,s2,s3
8000afc0:	00048613          	mv	a2,s1
8000afc4:	00a9fc63          	bgeu	s3,a0,8000afdc <__udivdi3+0x28c>
8000afc8:	013409b3          	add	s3,s0,s3
8000afcc:	fff48613          	addi	a2,s1,-1
8000afd0:	0089e663          	bltu	s3,s0,8000afdc <__udivdi3+0x28c>
8000afd4:	00a9f463          	bgeu	s3,a0,8000afdc <__udivdi3+0x28c>
8000afd8:	ffe48613          	addi	a2,s1,-2
8000afdc:	010a9793          	slli	a5,s5,0x10
8000afe0:	00c7e7b3          	or	a5,a5,a2
8000afe4:	00078513          	mv	a0,a5
8000afe8:	000a0593          	mv	a1,s4
8000afec:	02c12083          	lw	ra,44(sp)
8000aff0:	02812403          	lw	s0,40(sp)
8000aff4:	02412483          	lw	s1,36(sp)
8000aff8:	02012903          	lw	s2,32(sp)
8000affc:	01c12983          	lw	s3,28(sp)
8000b000:	01812a03          	lw	s4,24(sp)
8000b004:	01412a83          	lw	s5,20(sp)
8000b008:	01012b03          	lw	s6,16(sp)
8000b00c:	00c12b83          	lw	s7,12(sp)
8000b010:	00812c03          	lw	s8,8(sp)
8000b014:	00412c83          	lw	s9,4(sp)
8000b018:	03010113          	addi	sp,sp,48
8000b01c:	00008067          	ret
8000b020:	010007b7          	lui	a5,0x1000
8000b024:	01000a13          	li	s4,16
8000b028:	ecf468e3          	bltu	s0,a5,8000aef8 <__udivdi3+0x1a8>
8000b02c:	01800a13          	li	s4,24
8000b030:	ec9ff06f          	j	8000aef8 <__udivdi3+0x1a8>
8000b034:	00c41433          	sll	s0,s0,a2
8000b038:	00d4da33          	srl	s4,s1,a3
8000b03c:	00cb19b3          	sll	s3,s6,a2
8000b040:	00db56b3          	srl	a3,s6,a3
8000b044:	01045b13          	srli	s6,s0,0x10
8000b048:	00c494b3          	sll	s1,s1,a2
8000b04c:	000b0593          	mv	a1,s6
8000b050:	000a0513          	mv	a0,s4
8000b054:	0096eab3          	or	s5,a3,s1
8000b058:	1c1020ef          	jal	ra,8000da18 <__umodsi3>
8000b05c:	00050913          	mv	s2,a0
8000b060:	000b0593          	mv	a1,s6
8000b064:	000a0513          	mv	a0,s4
8000b068:	01041b93          	slli	s7,s0,0x10
8000b06c:	165020ef          	jal	ra,8000d9d0 <__udivsi3>
8000b070:	010bdb93          	srli	s7,s7,0x10
8000b074:	00050493          	mv	s1,a0
8000b078:	00050593          	mv	a1,a0
8000b07c:	000b8513          	mv	a0,s7
8000b080:	125020ef          	jal	ra,8000d9a4 <__mulsi3>
8000b084:	01091913          	slli	s2,s2,0x10
8000b088:	010ad713          	srli	a4,s5,0x10
8000b08c:	00e96733          	or	a4,s2,a4
8000b090:	00048a13          	mv	s4,s1
8000b094:	00a77e63          	bgeu	a4,a0,8000b0b0 <__udivdi3+0x360>
8000b098:	00870733          	add	a4,a4,s0
8000b09c:	fff48a13          	addi	s4,s1,-1
8000b0a0:	00876863          	bltu	a4,s0,8000b0b0 <__udivdi3+0x360>
8000b0a4:	00a77663          	bgeu	a4,a0,8000b0b0 <__udivdi3+0x360>
8000b0a8:	ffe48a13          	addi	s4,s1,-2
8000b0ac:	00870733          	add	a4,a4,s0
8000b0b0:	40a704b3          	sub	s1,a4,a0
8000b0b4:	000b0593          	mv	a1,s6
8000b0b8:	00048513          	mv	a0,s1
8000b0bc:	15d020ef          	jal	ra,8000da18 <__umodsi3>
8000b0c0:	00050913          	mv	s2,a0
8000b0c4:	000b0593          	mv	a1,s6
8000b0c8:	00048513          	mv	a0,s1
8000b0cc:	105020ef          	jal	ra,8000d9d0 <__udivsi3>
8000b0d0:	00050493          	mv	s1,a0
8000b0d4:	00050593          	mv	a1,a0
8000b0d8:	000b8513          	mv	a0,s7
8000b0dc:	0c9020ef          	jal	ra,8000d9a4 <__mulsi3>
8000b0e0:	010a9693          	slli	a3,s5,0x10
8000b0e4:	01091913          	slli	s2,s2,0x10
8000b0e8:	0106d693          	srli	a3,a3,0x10
8000b0ec:	00d967b3          	or	a5,s2,a3
8000b0f0:	00048713          	mv	a4,s1
8000b0f4:	00a7fe63          	bgeu	a5,a0,8000b110 <__udivdi3+0x3c0>
8000b0f8:	008787b3          	add	a5,a5,s0
8000b0fc:	fff48713          	addi	a4,s1,-1
8000b100:	0087e863          	bltu	a5,s0,8000b110 <__udivdi3+0x3c0>
8000b104:	00a7f663          	bgeu	a5,a0,8000b110 <__udivdi3+0x3c0>
8000b108:	ffe48713          	addi	a4,s1,-2
8000b10c:	008787b3          	add	a5,a5,s0
8000b110:	010a1a13          	slli	s4,s4,0x10
8000b114:	40a784b3          	sub	s1,a5,a0
8000b118:	00ea6a33          	or	s4,s4,a4
8000b11c:	e01ff06f          	j	8000af1c <__udivdi3+0x1cc>
8000b120:	1ed5ec63          	bltu	a1,a3,8000b318 <__udivdi3+0x5c8>
8000b124:	000107b7          	lui	a5,0x10
8000b128:	04f6f463          	bgeu	a3,a5,8000b170 <__udivdi3+0x420>
8000b12c:	0ff00593          	li	a1,255
8000b130:	00d5b533          	sltu	a0,a1,a3
8000b134:	00351513          	slli	a0,a0,0x3
8000b138:	00a6d733          	srl	a4,a3,a0
8000b13c:	00004797          	auipc	a5,0x4
8000b140:	85478793          	addi	a5,a5,-1964 # 8000e990 <__clz_tab>
8000b144:	00e787b3          	add	a5,a5,a4
8000b148:	0007c583          	lbu	a1,0(a5)
8000b14c:	02000a13          	li	s4,32
8000b150:	00a585b3          	add	a1,a1,a0
8000b154:	40ba0a33          	sub	s4,s4,a1
8000b158:	020a1663          	bnez	s4,8000b184 <__udivdi3+0x434>
8000b15c:	00100793          	li	a5,1
8000b160:	e896e2e3          	bltu	a3,s1,8000afe4 <__udivdi3+0x294>
8000b164:	00cb3633          	sltu	a2,s6,a2
8000b168:	00164793          	xori	a5,a2,1
8000b16c:	e79ff06f          	j	8000afe4 <__udivdi3+0x294>
8000b170:	010007b7          	lui	a5,0x1000
8000b174:	01000513          	li	a0,16
8000b178:	fcf6e0e3          	bltu	a3,a5,8000b138 <__udivdi3+0x3e8>
8000b17c:	01800513          	li	a0,24
8000b180:	fb9ff06f          	j	8000b138 <__udivdi3+0x3e8>
8000b184:	00b65ab3          	srl	s5,a2,a1
8000b188:	014696b3          	sll	a3,a3,s4
8000b18c:	00daeab3          	or	s5,s5,a3
8000b190:	00b4d933          	srl	s2,s1,a1
8000b194:	014497b3          	sll	a5,s1,s4
8000b198:	00bb55b3          	srl	a1,s6,a1
8000b19c:	010adb93          	srli	s7,s5,0x10
8000b1a0:	00f5e4b3          	or	s1,a1,a5
8000b1a4:	00090513          	mv	a0,s2
8000b1a8:	000b8593          	mv	a1,s7
8000b1ac:	014619b3          	sll	s3,a2,s4
8000b1b0:	069020ef          	jal	ra,8000da18 <__umodsi3>
8000b1b4:	00050413          	mv	s0,a0
8000b1b8:	000b8593          	mv	a1,s7
8000b1bc:	00090513          	mv	a0,s2
8000b1c0:	010a9c13          	slli	s8,s5,0x10
8000b1c4:	00d020ef          	jal	ra,8000d9d0 <__udivsi3>
8000b1c8:	010c5c13          	srli	s8,s8,0x10
8000b1cc:	00050913          	mv	s2,a0
8000b1d0:	00050593          	mv	a1,a0
8000b1d4:	000c0513          	mv	a0,s8
8000b1d8:	7cc020ef          	jal	ra,8000d9a4 <__mulsi3>
8000b1dc:	01041413          	slli	s0,s0,0x10
8000b1e0:	0104d713          	srli	a4,s1,0x10
8000b1e4:	00e46733          	or	a4,s0,a4
8000b1e8:	00090c93          	mv	s9,s2
8000b1ec:	00a77e63          	bgeu	a4,a0,8000b208 <__udivdi3+0x4b8>
8000b1f0:	01570733          	add	a4,a4,s5
8000b1f4:	fff90c93          	addi	s9,s2,-1
8000b1f8:	01576863          	bltu	a4,s5,8000b208 <__udivdi3+0x4b8>
8000b1fc:	00a77663          	bgeu	a4,a0,8000b208 <__udivdi3+0x4b8>
8000b200:	ffe90c93          	addi	s9,s2,-2
8000b204:	01570733          	add	a4,a4,s5
8000b208:	40a70933          	sub	s2,a4,a0
8000b20c:	000b8593          	mv	a1,s7
8000b210:	00090513          	mv	a0,s2
8000b214:	005020ef          	jal	ra,8000da18 <__umodsi3>
8000b218:	00050413          	mv	s0,a0
8000b21c:	000b8593          	mv	a1,s7
8000b220:	00090513          	mv	a0,s2
8000b224:	7ac020ef          	jal	ra,8000d9d0 <__udivsi3>
8000b228:	00050913          	mv	s2,a0
8000b22c:	00050593          	mv	a1,a0
8000b230:	000c0513          	mv	a0,s8
8000b234:	770020ef          	jal	ra,8000d9a4 <__mulsi3>
8000b238:	01049793          	slli	a5,s1,0x10
8000b23c:	01041413          	slli	s0,s0,0x10
8000b240:	0107d793          	srli	a5,a5,0x10
8000b244:	00f46733          	or	a4,s0,a5
8000b248:	00090613          	mv	a2,s2
8000b24c:	00a77e63          	bgeu	a4,a0,8000b268 <__udivdi3+0x518>
8000b250:	01570733          	add	a4,a4,s5
8000b254:	fff90613          	addi	a2,s2,-1
8000b258:	01576863          	bltu	a4,s5,8000b268 <__udivdi3+0x518>
8000b25c:	00a77663          	bgeu	a4,a0,8000b268 <__udivdi3+0x518>
8000b260:	ffe90613          	addi	a2,s2,-2
8000b264:	01570733          	add	a4,a4,s5
8000b268:	010c9793          	slli	a5,s9,0x10
8000b26c:	00010e37          	lui	t3,0x10
8000b270:	00c7e7b3          	or	a5,a5,a2
8000b274:	fffe0813          	addi	a6,t3,-1 # ffff <crtStart-0x7fff0001>
8000b278:	0107f333          	and	t1,a5,a6
8000b27c:	0109f833          	and	a6,s3,a6
8000b280:	40a70733          	sub	a4,a4,a0
8000b284:	0107de93          	srli	t4,a5,0x10
8000b288:	0109d993          	srli	s3,s3,0x10
8000b28c:	00030513          	mv	a0,t1
8000b290:	00080593          	mv	a1,a6
8000b294:	710020ef          	jal	ra,8000d9a4 <__mulsi3>
8000b298:	00050893          	mv	a7,a0
8000b29c:	00098593          	mv	a1,s3
8000b2a0:	00030513          	mv	a0,t1
8000b2a4:	700020ef          	jal	ra,8000d9a4 <__mulsi3>
8000b2a8:	00050313          	mv	t1,a0
8000b2ac:	00080593          	mv	a1,a6
8000b2b0:	000e8513          	mv	a0,t4
8000b2b4:	6f0020ef          	jal	ra,8000d9a4 <__mulsi3>
8000b2b8:	00050813          	mv	a6,a0
8000b2bc:	00098593          	mv	a1,s3
8000b2c0:	000e8513          	mv	a0,t4
8000b2c4:	6e0020ef          	jal	ra,8000d9a4 <__mulsi3>
8000b2c8:	0108d693          	srli	a3,a7,0x10
8000b2cc:	01030333          	add	t1,t1,a6
8000b2d0:	006686b3          	add	a3,a3,t1
8000b2d4:	0106f463          	bgeu	a3,a6,8000b2dc <__udivdi3+0x58c>
8000b2d8:	01c50533          	add	a0,a0,t3
8000b2dc:	0106d613          	srli	a2,a3,0x10
8000b2e0:	00a60533          	add	a0,a2,a0
8000b2e4:	02a76663          	bltu	a4,a0,8000b310 <__udivdi3+0x5c0>
8000b2e8:	bca714e3          	bne	a4,a0,8000aeb0 <__udivdi3+0x160>
8000b2ec:	00010737          	lui	a4,0x10
8000b2f0:	fff70713          	addi	a4,a4,-1 # ffff <crtStart-0x7fff0001>
8000b2f4:	00e6f6b3          	and	a3,a3,a4
8000b2f8:	01069693          	slli	a3,a3,0x10
8000b2fc:	00e8f8b3          	and	a7,a7,a4
8000b300:	014b1633          	sll	a2,s6,s4
8000b304:	011686b3          	add	a3,a3,a7
8000b308:	00000a13          	li	s4,0
8000b30c:	ccd67ce3          	bgeu	a2,a3,8000afe4 <__udivdi3+0x294>
8000b310:	fff78793          	addi	a5,a5,-1 # ffffff <crtStart-0x7f000001>
8000b314:	b9dff06f          	j	8000aeb0 <__udivdi3+0x160>
8000b318:	00000a13          	li	s4,0
8000b31c:	00000793          	li	a5,0
8000b320:	cc5ff06f          	j	8000afe4 <__udivdi3+0x294>

8000b324 <__umoddi3>:
8000b324:	fd010113          	addi	sp,sp,-48
8000b328:	02812423          	sw	s0,40(sp)
8000b32c:	02912223          	sw	s1,36(sp)
8000b330:	01312e23          	sw	s3,28(sp)
8000b334:	01612823          	sw	s6,16(sp)
8000b338:	02112623          	sw	ra,44(sp)
8000b33c:	03212023          	sw	s2,32(sp)
8000b340:	01412c23          	sw	s4,24(sp)
8000b344:	01512a23          	sw	s5,20(sp)
8000b348:	01712623          	sw	s7,12(sp)
8000b34c:	01812423          	sw	s8,8(sp)
8000b350:	01912223          	sw	s9,4(sp)
8000b354:	01a12023          	sw	s10,0(sp)
8000b358:	00050b13          	mv	s6,a0
8000b35c:	00058993          	mv	s3,a1
8000b360:	00050413          	mv	s0,a0
8000b364:	00058493          	mv	s1,a1
8000b368:	26069c63          	bnez	a3,8000b5e0 <__umoddi3+0x2bc>
8000b36c:	00060913          	mv	s2,a2
8000b370:	00068a13          	mv	s4,a3
8000b374:	00003a97          	auipc	s5,0x3
8000b378:	61ca8a93          	addi	s5,s5,1564 # 8000e990 <__clz_tab>
8000b37c:	14c5f263          	bgeu	a1,a2,8000b4c0 <__umoddi3+0x19c>
8000b380:	000107b7          	lui	a5,0x10
8000b384:	12f67463          	bgeu	a2,a5,8000b4ac <__umoddi3+0x188>
8000b388:	0ff00793          	li	a5,255
8000b38c:	00c7f463          	bgeu	a5,a2,8000b394 <__umoddi3+0x70>
8000b390:	00800a13          	li	s4,8
8000b394:	014657b3          	srl	a5,a2,s4
8000b398:	00fa8ab3          	add	s5,s5,a5
8000b39c:	000ac703          	lbu	a4,0(s5)
8000b3a0:	02000513          	li	a0,32
8000b3a4:	01470733          	add	a4,a4,s4
8000b3a8:	40e50a33          	sub	s4,a0,a4
8000b3ac:	000a0c63          	beqz	s4,8000b3c4 <__umoddi3+0xa0>
8000b3b0:	014995b3          	sll	a1,s3,s4
8000b3b4:	00eb5733          	srl	a4,s6,a4
8000b3b8:	01461933          	sll	s2,a2,s4
8000b3bc:	00b764b3          	or	s1,a4,a1
8000b3c0:	014b1433          	sll	s0,s6,s4
8000b3c4:	01095a93          	srli	s5,s2,0x10
8000b3c8:	000a8593          	mv	a1,s5
8000b3cc:	00048513          	mv	a0,s1
8000b3d0:	648020ef          	jal	ra,8000da18 <__umodsi3>
8000b3d4:	00050993          	mv	s3,a0
8000b3d8:	000a8593          	mv	a1,s5
8000b3dc:	01091b13          	slli	s6,s2,0x10
8000b3e0:	00048513          	mv	a0,s1
8000b3e4:	5ec020ef          	jal	ra,8000d9d0 <__udivsi3>
8000b3e8:	010b5b13          	srli	s6,s6,0x10
8000b3ec:	00050593          	mv	a1,a0
8000b3f0:	000b0513          	mv	a0,s6
8000b3f4:	5b0020ef          	jal	ra,8000d9a4 <__mulsi3>
8000b3f8:	01099993          	slli	s3,s3,0x10
8000b3fc:	01045793          	srli	a5,s0,0x10
8000b400:	00f9e7b3          	or	a5,s3,a5
8000b404:	00a7fa63          	bgeu	a5,a0,8000b418 <__umoddi3+0xf4>
8000b408:	012787b3          	add	a5,a5,s2
8000b40c:	0127e663          	bltu	a5,s2,8000b418 <__umoddi3+0xf4>
8000b410:	00a7f463          	bgeu	a5,a0,8000b418 <__umoddi3+0xf4>
8000b414:	012787b3          	add	a5,a5,s2
8000b418:	40a784b3          	sub	s1,a5,a0
8000b41c:	000a8593          	mv	a1,s5
8000b420:	00048513          	mv	a0,s1
8000b424:	5f4020ef          	jal	ra,8000da18 <__umodsi3>
8000b428:	00050993          	mv	s3,a0
8000b42c:	000a8593          	mv	a1,s5
8000b430:	00048513          	mv	a0,s1
8000b434:	59c020ef          	jal	ra,8000d9d0 <__udivsi3>
8000b438:	01041413          	slli	s0,s0,0x10
8000b43c:	00050593          	mv	a1,a0
8000b440:	01099993          	slli	s3,s3,0x10
8000b444:	000b0513          	mv	a0,s6
8000b448:	01045413          	srli	s0,s0,0x10
8000b44c:	558020ef          	jal	ra,8000d9a4 <__mulsi3>
8000b450:	0089e433          	or	s0,s3,s0
8000b454:	00a47a63          	bgeu	s0,a0,8000b468 <__umoddi3+0x144>
8000b458:	01240433          	add	s0,s0,s2
8000b45c:	01246663          	bltu	s0,s2,8000b468 <__umoddi3+0x144>
8000b460:	00a47463          	bgeu	s0,a0,8000b468 <__umoddi3+0x144>
8000b464:	01240433          	add	s0,s0,s2
8000b468:	40a40433          	sub	s0,s0,a0
8000b46c:	01445533          	srl	a0,s0,s4
8000b470:	00000593          	li	a1,0
8000b474:	02c12083          	lw	ra,44(sp)
8000b478:	02812403          	lw	s0,40(sp)
8000b47c:	02412483          	lw	s1,36(sp)
8000b480:	02012903          	lw	s2,32(sp)
8000b484:	01c12983          	lw	s3,28(sp)
8000b488:	01812a03          	lw	s4,24(sp)
8000b48c:	01412a83          	lw	s5,20(sp)
8000b490:	01012b03          	lw	s6,16(sp)
8000b494:	00c12b83          	lw	s7,12(sp)
8000b498:	00812c03          	lw	s8,8(sp)
8000b49c:	00412c83          	lw	s9,4(sp)
8000b4a0:	00012d03          	lw	s10,0(sp)
8000b4a4:	03010113          	addi	sp,sp,48
8000b4a8:	00008067          	ret
8000b4ac:	010007b7          	lui	a5,0x1000
8000b4b0:	01000a13          	li	s4,16
8000b4b4:	eef660e3          	bltu	a2,a5,8000b394 <__umoddi3+0x70>
8000b4b8:	01800a13          	li	s4,24
8000b4bc:	ed9ff06f          	j	8000b394 <__umoddi3+0x70>
8000b4c0:	00061a63          	bnez	a2,8000b4d4 <__umoddi3+0x1b0>
8000b4c4:	00000593          	li	a1,0
8000b4c8:	00100513          	li	a0,1
8000b4cc:	504020ef          	jal	ra,8000d9d0 <__udivsi3>
8000b4d0:	00050913          	mv	s2,a0
8000b4d4:	000107b7          	lui	a5,0x10
8000b4d8:	0ef97a63          	bgeu	s2,a5,8000b5cc <__umoddi3+0x2a8>
8000b4dc:	0ff00793          	li	a5,255
8000b4e0:	0127f463          	bgeu	a5,s2,8000b4e8 <__umoddi3+0x1c4>
8000b4e4:	00800a13          	li	s4,8
8000b4e8:	014957b3          	srl	a5,s2,s4
8000b4ec:	00fa8ab3          	add	s5,s5,a5
8000b4f0:	000ac703          	lbu	a4,0(s5)
8000b4f4:	02000513          	li	a0,32
8000b4f8:	412984b3          	sub	s1,s3,s2
8000b4fc:	01470733          	add	a4,a4,s4
8000b500:	40e50a33          	sub	s4,a0,a4
8000b504:	ec0a00e3          	beqz	s4,8000b3c4 <__umoddi3+0xa0>
8000b508:	01491933          	sll	s2,s2,s4
8000b50c:	00e9dab3          	srl	s5,s3,a4
8000b510:	014995b3          	sll	a1,s3,s4
8000b514:	00eb5733          	srl	a4,s6,a4
8000b518:	01095493          	srli	s1,s2,0x10
8000b51c:	00b76bb3          	or	s7,a4,a1
8000b520:	000a8513          	mv	a0,s5
8000b524:	00048593          	mv	a1,s1
8000b528:	4f0020ef          	jal	ra,8000da18 <__umodsi3>
8000b52c:	00050993          	mv	s3,a0
8000b530:	00048593          	mv	a1,s1
8000b534:	014b1433          	sll	s0,s6,s4
8000b538:	000a8513          	mv	a0,s5
8000b53c:	01091b13          	slli	s6,s2,0x10
8000b540:	490020ef          	jal	ra,8000d9d0 <__udivsi3>
8000b544:	010b5b13          	srli	s6,s6,0x10
8000b548:	00050593          	mv	a1,a0
8000b54c:	000b0513          	mv	a0,s6
8000b550:	454020ef          	jal	ra,8000d9a4 <__mulsi3>
8000b554:	01099993          	slli	s3,s3,0x10
8000b558:	010bd793          	srli	a5,s7,0x10
8000b55c:	00f9e7b3          	or	a5,s3,a5
8000b560:	00a7fa63          	bgeu	a5,a0,8000b574 <__umoddi3+0x250>
8000b564:	012787b3          	add	a5,a5,s2
8000b568:	0127e663          	bltu	a5,s2,8000b574 <__umoddi3+0x250>
8000b56c:	00a7f463          	bgeu	a5,a0,8000b574 <__umoddi3+0x250>
8000b570:	012787b3          	add	a5,a5,s2
8000b574:	40a78ab3          	sub	s5,a5,a0
8000b578:	00048593          	mv	a1,s1
8000b57c:	000a8513          	mv	a0,s5
8000b580:	498020ef          	jal	ra,8000da18 <__umodsi3>
8000b584:	00050993          	mv	s3,a0
8000b588:	00048593          	mv	a1,s1
8000b58c:	000a8513          	mv	a0,s5
8000b590:	440020ef          	jal	ra,8000d9d0 <__udivsi3>
8000b594:	00050593          	mv	a1,a0
8000b598:	000b0513          	mv	a0,s6
8000b59c:	408020ef          	jal	ra,8000d9a4 <__mulsi3>
8000b5a0:	010b9593          	slli	a1,s7,0x10
8000b5a4:	01099993          	slli	s3,s3,0x10
8000b5a8:	0105d593          	srli	a1,a1,0x10
8000b5ac:	00b9e5b3          	or	a1,s3,a1
8000b5b0:	00a5fa63          	bgeu	a1,a0,8000b5c4 <__umoddi3+0x2a0>
8000b5b4:	012585b3          	add	a1,a1,s2
8000b5b8:	0125e663          	bltu	a1,s2,8000b5c4 <__umoddi3+0x2a0>
8000b5bc:	00a5f463          	bgeu	a1,a0,8000b5c4 <__umoddi3+0x2a0>
8000b5c0:	012585b3          	add	a1,a1,s2
8000b5c4:	40a584b3          	sub	s1,a1,a0
8000b5c8:	dfdff06f          	j	8000b3c4 <__umoddi3+0xa0>
8000b5cc:	010007b7          	lui	a5,0x1000
8000b5d0:	01000a13          	li	s4,16
8000b5d4:	f0f96ae3          	bltu	s2,a5,8000b4e8 <__umoddi3+0x1c4>
8000b5d8:	01800a13          	li	s4,24
8000b5dc:	f0dff06f          	j	8000b4e8 <__umoddi3+0x1c4>
8000b5e0:	e8d5eae3          	bltu	a1,a3,8000b474 <__umoddi3+0x150>
8000b5e4:	000107b7          	lui	a5,0x10
8000b5e8:	04f6fc63          	bgeu	a3,a5,8000b640 <__umoddi3+0x31c>
8000b5ec:	0ff00a93          	li	s5,255
8000b5f0:	00dab533          	sltu	a0,s5,a3
8000b5f4:	00351513          	slli	a0,a0,0x3
8000b5f8:	00a6d733          	srl	a4,a3,a0
8000b5fc:	00003797          	auipc	a5,0x3
8000b600:	39478793          	addi	a5,a5,916 # 8000e990 <__clz_tab>
8000b604:	00e787b3          	add	a5,a5,a4
8000b608:	0007ca83          	lbu	s5,0(a5)
8000b60c:	02000593          	li	a1,32
8000b610:	00aa8ab3          	add	s5,s5,a0
8000b614:	41558a33          	sub	s4,a1,s5
8000b618:	020a1e63          	bnez	s4,8000b654 <__umoddi3+0x330>
8000b61c:	0136e463          	bltu	a3,s3,8000b624 <__umoddi3+0x300>
8000b620:	00cb6a63          	bltu	s6,a2,8000b634 <__umoddi3+0x310>
8000b624:	40cb0433          	sub	s0,s6,a2
8000b628:	40d986b3          	sub	a3,s3,a3
8000b62c:	008b3b33          	sltu	s6,s6,s0
8000b630:	416684b3          	sub	s1,a3,s6
8000b634:	00040513          	mv	a0,s0
8000b638:	00048593          	mv	a1,s1
8000b63c:	e39ff06f          	j	8000b474 <__umoddi3+0x150>
8000b640:	010007b7          	lui	a5,0x1000
8000b644:	01000513          	li	a0,16
8000b648:	faf6e8e3          	bltu	a3,a5,8000b5f8 <__umoddi3+0x2d4>
8000b64c:	01800513          	li	a0,24
8000b650:	fa9ff06f          	j	8000b5f8 <__umoddi3+0x2d4>
8000b654:	014696b3          	sll	a3,a3,s4
8000b658:	015657b3          	srl	a5,a2,s5
8000b65c:	00d7ebb3          	or	s7,a5,a3
8000b660:	0159d433          	srl	s0,s3,s5
8000b664:	014995b3          	sll	a1,s3,s4
8000b668:	015b54b3          	srl	s1,s6,s5
8000b66c:	010bdc13          	srli	s8,s7,0x10
8000b670:	00b4e4b3          	or	s1,s1,a1
8000b674:	00040513          	mv	a0,s0
8000b678:	000c0593          	mv	a1,s8
8000b67c:	01461d33          	sll	s10,a2,s4
8000b680:	398020ef          	jal	ra,8000da18 <__umodsi3>
8000b684:	00050993          	mv	s3,a0
8000b688:	000c0593          	mv	a1,s8
8000b68c:	00040513          	mv	a0,s0
8000b690:	010b9c93          	slli	s9,s7,0x10
8000b694:	33c020ef          	jal	ra,8000d9d0 <__udivsi3>
8000b698:	010cdc93          	srli	s9,s9,0x10
8000b69c:	00050413          	mv	s0,a0
8000b6a0:	00050593          	mv	a1,a0
8000b6a4:	000c8513          	mv	a0,s9
8000b6a8:	2fc020ef          	jal	ra,8000d9a4 <__mulsi3>
8000b6ac:	01099993          	slli	s3,s3,0x10
8000b6b0:	0104d713          	srli	a4,s1,0x10
8000b6b4:	00e9e733          	or	a4,s3,a4
8000b6b8:	014b1b33          	sll	s6,s6,s4
8000b6bc:	00040993          	mv	s3,s0
8000b6c0:	00a77e63          	bgeu	a4,a0,8000b6dc <__umoddi3+0x3b8>
8000b6c4:	01770733          	add	a4,a4,s7
8000b6c8:	fff40993          	addi	s3,s0,-1
8000b6cc:	01776863          	bltu	a4,s7,8000b6dc <__umoddi3+0x3b8>
8000b6d0:	00a77663          	bgeu	a4,a0,8000b6dc <__umoddi3+0x3b8>
8000b6d4:	ffe40993          	addi	s3,s0,-2
8000b6d8:	01770733          	add	a4,a4,s7
8000b6dc:	40a70933          	sub	s2,a4,a0
8000b6e0:	000c0593          	mv	a1,s8
8000b6e4:	00090513          	mv	a0,s2
8000b6e8:	330020ef          	jal	ra,8000da18 <__umodsi3>
8000b6ec:	00050413          	mv	s0,a0
8000b6f0:	000c0593          	mv	a1,s8
8000b6f4:	00090513          	mv	a0,s2
8000b6f8:	2d8020ef          	jal	ra,8000d9d0 <__udivsi3>
8000b6fc:	00050593          	mv	a1,a0
8000b700:	00050913          	mv	s2,a0
8000b704:	000c8513          	mv	a0,s9
8000b708:	29c020ef          	jal	ra,8000d9a4 <__mulsi3>
8000b70c:	01049593          	slli	a1,s1,0x10
8000b710:	01041413          	slli	s0,s0,0x10
8000b714:	0105d593          	srli	a1,a1,0x10
8000b718:	00b465b3          	or	a1,s0,a1
8000b71c:	00090793          	mv	a5,s2
8000b720:	00a5fe63          	bgeu	a1,a0,8000b73c <__umoddi3+0x418>
8000b724:	017585b3          	add	a1,a1,s7
8000b728:	fff90793          	addi	a5,s2,-1
8000b72c:	0175e863          	bltu	a1,s7,8000b73c <__umoddi3+0x418>
8000b730:	00a5f663          	bgeu	a1,a0,8000b73c <__umoddi3+0x418>
8000b734:	ffe90793          	addi	a5,s2,-2
8000b738:	017585b3          	add	a1,a1,s7
8000b73c:	00010e37          	lui	t3,0x10
8000b740:	01099993          	slli	s3,s3,0x10
8000b744:	00f9e9b3          	or	s3,s3,a5
8000b748:	fffe0813          	addi	a6,t3,-1 # ffff <crtStart-0x7fff0001>
8000b74c:	0109f733          	and	a4,s3,a6
8000b750:	010d7833          	and	a6,s10,a6
8000b754:	40a584b3          	sub	s1,a1,a0
8000b758:	0109d993          	srli	s3,s3,0x10
8000b75c:	010d5893          	srli	a7,s10,0x10
8000b760:	00070513          	mv	a0,a4
8000b764:	00080593          	mv	a1,a6
8000b768:	23c020ef          	jal	ra,8000d9a4 <__mulsi3>
8000b76c:	00050793          	mv	a5,a0
8000b770:	00088593          	mv	a1,a7
8000b774:	00070513          	mv	a0,a4
8000b778:	22c020ef          	jal	ra,8000d9a4 <__mulsi3>
8000b77c:	00050313          	mv	t1,a0
8000b780:	00080593          	mv	a1,a6
8000b784:	00098513          	mv	a0,s3
8000b788:	21c020ef          	jal	ra,8000d9a4 <__mulsi3>
8000b78c:	00050813          	mv	a6,a0
8000b790:	00088593          	mv	a1,a7
8000b794:	00098513          	mv	a0,s3
8000b798:	20c020ef          	jal	ra,8000d9a4 <__mulsi3>
8000b79c:	0107d713          	srli	a4,a5,0x10
8000b7a0:	01030333          	add	t1,t1,a6
8000b7a4:	00670733          	add	a4,a4,t1
8000b7a8:	01077463          	bgeu	a4,a6,8000b7b0 <__umoddi3+0x48c>
8000b7ac:	01c50533          	add	a0,a0,t3
8000b7b0:	000106b7          	lui	a3,0x10
8000b7b4:	fff68693          	addi	a3,a3,-1 # ffff <crtStart-0x7fff0001>
8000b7b8:	01075593          	srli	a1,a4,0x10
8000b7bc:	00d77733          	and	a4,a4,a3
8000b7c0:	01071713          	slli	a4,a4,0x10
8000b7c4:	00d7f7b3          	and	a5,a5,a3
8000b7c8:	00a585b3          	add	a1,a1,a0
8000b7cc:	00f707b3          	add	a5,a4,a5
8000b7d0:	00b4e663          	bltu	s1,a1,8000b7dc <__umoddi3+0x4b8>
8000b7d4:	00b49e63          	bne	s1,a1,8000b7f0 <__umoddi3+0x4cc>
8000b7d8:	00fb7c63          	bgeu	s6,a5,8000b7f0 <__umoddi3+0x4cc>
8000b7dc:	41a78633          	sub	a2,a5,s10
8000b7e0:	00c7b7b3          	sltu	a5,a5,a2
8000b7e4:	017787b3          	add	a5,a5,s7
8000b7e8:	40f585b3          	sub	a1,a1,a5
8000b7ec:	00060793          	mv	a5,a2
8000b7f0:	40fb07b3          	sub	a5,s6,a5
8000b7f4:	00fb3b33          	sltu	s6,s6,a5
8000b7f8:	40b485b3          	sub	a1,s1,a1
8000b7fc:	416585b3          	sub	a1,a1,s6
8000b800:	01559433          	sll	s0,a1,s5
8000b804:	0147d7b3          	srl	a5,a5,s4
8000b808:	00f46533          	or	a0,s0,a5
8000b80c:	0145d5b3          	srl	a1,a1,s4
8000b810:	c65ff06f          	j	8000b474 <__umoddi3+0x150>

8000b814 <__adddf3>:
8000b814:	00100837          	lui	a6,0x100
8000b818:	fff80813          	addi	a6,a6,-1 # fffff <crtStart-0x7ff00001>
8000b81c:	00b878b3          	and	a7,a6,a1
8000b820:	00389893          	slli	a7,a7,0x3
8000b824:	01d55793          	srli	a5,a0,0x1d
8000b828:	fe010113          	addi	sp,sp,-32
8000b82c:	0145d713          	srli	a4,a1,0x14
8000b830:	00d87833          	and	a6,a6,a3
8000b834:	0117e7b3          	or	a5,a5,a7
8000b838:	0146d893          	srli	a7,a3,0x14
8000b83c:	00381813          	slli	a6,a6,0x3
8000b840:	00912a23          	sw	s1,20(sp)
8000b844:	01212823          	sw	s2,16(sp)
8000b848:	7ff77493          	andi	s1,a4,2047
8000b84c:	7ff8f893          	andi	a7,a7,2047
8000b850:	01d65713          	srli	a4,a2,0x1d
8000b854:	00112e23          	sw	ra,28(sp)
8000b858:	00812c23          	sw	s0,24(sp)
8000b85c:	01312623          	sw	s3,12(sp)
8000b860:	01f5d913          	srli	s2,a1,0x1f
8000b864:	01f6d693          	srli	a3,a3,0x1f
8000b868:	01076733          	or	a4,a4,a6
8000b86c:	00351513          	slli	a0,a0,0x3
8000b870:	00361613          	slli	a2,a2,0x3
8000b874:	41148833          	sub	a6,s1,a7
8000b878:	2cd91463          	bne	s2,a3,8000bb40 <__adddf3+0x32c>
8000b87c:	11005e63          	blez	a6,8000b998 <__adddf3+0x184>
8000b880:	04089063          	bnez	a7,8000b8c0 <__adddf3+0xac>
8000b884:	00c766b3          	or	a3,a4,a2
8000b888:	70068063          	beqz	a3,8000bf88 <__adddf3+0x774>
8000b88c:	fff80593          	addi	a1,a6,-1
8000b890:	02059063          	bnez	a1,8000b8b0 <__adddf3+0x9c>
8000b894:	00c50633          	add	a2,a0,a2
8000b898:	00a63533          	sltu	a0,a2,a0
8000b89c:	00e787b3          	add	a5,a5,a4
8000b8a0:	00a787b3          	add	a5,a5,a0
8000b8a4:	00060513          	mv	a0,a2
8000b8a8:	00100493          	li	s1,1
8000b8ac:	0700006f          	j	8000b91c <__adddf3+0x108>
8000b8b0:	7ff00693          	li	a3,2047
8000b8b4:	02d81063          	bne	a6,a3,8000b8d4 <__adddf3+0xc0>
8000b8b8:	7ff00493          	li	s1,2047
8000b8bc:	20c0006f          	j	8000bac8 <__adddf3+0x2b4>
8000b8c0:	7ff00693          	li	a3,2047
8000b8c4:	20d48263          	beq	s1,a3,8000bac8 <__adddf3+0x2b4>
8000b8c8:	008006b7          	lui	a3,0x800
8000b8cc:	00d76733          	or	a4,a4,a3
8000b8d0:	00080593          	mv	a1,a6
8000b8d4:	03800693          	li	a3,56
8000b8d8:	0ab6ca63          	blt	a3,a1,8000b98c <__adddf3+0x178>
8000b8dc:	01f00693          	li	a3,31
8000b8e0:	06b6cc63          	blt	a3,a1,8000b958 <__adddf3+0x144>
8000b8e4:	02000813          	li	a6,32
8000b8e8:	40b80833          	sub	a6,a6,a1
8000b8ec:	010716b3          	sll	a3,a4,a6
8000b8f0:	00b658b3          	srl	a7,a2,a1
8000b8f4:	01061633          	sll	a2,a2,a6
8000b8f8:	0116e6b3          	or	a3,a3,a7
8000b8fc:	00c03633          	snez	a2,a2
8000b900:	00c6e633          	or	a2,a3,a2
8000b904:	00b75733          	srl	a4,a4,a1
8000b908:	00a60633          	add	a2,a2,a0
8000b90c:	00f70733          	add	a4,a4,a5
8000b910:	00a637b3          	sltu	a5,a2,a0
8000b914:	00f707b3          	add	a5,a4,a5
8000b918:	00060513          	mv	a0,a2
8000b91c:	00879713          	slli	a4,a5,0x8
8000b920:	1a075463          	bgez	a4,8000bac8 <__adddf3+0x2b4>
8000b924:	00148493          	addi	s1,s1,1
8000b928:	7ff00713          	li	a4,2047
8000b92c:	5ce48463          	beq	s1,a4,8000bef4 <__adddf3+0x6e0>
8000b930:	ff8006b7          	lui	a3,0xff800
8000b934:	fff68693          	addi	a3,a3,-1 # ff7fffff <STACK_TOP+0x7f7dffff>
8000b938:	00d7f6b3          	and	a3,a5,a3
8000b93c:	00155593          	srli	a1,a0,0x1
8000b940:	00157513          	andi	a0,a0,1
8000b944:	01f69793          	slli	a5,a3,0x1f
8000b948:	00a5e533          	or	a0,a1,a0
8000b94c:	00a7e533          	or	a0,a5,a0
8000b950:	0016d793          	srli	a5,a3,0x1
8000b954:	1740006f          	j	8000bac8 <__adddf3+0x2b4>
8000b958:	fe058693          	addi	a3,a1,-32
8000b95c:	02000893          	li	a7,32
8000b960:	00d756b3          	srl	a3,a4,a3
8000b964:	00000813          	li	a6,0
8000b968:	01158863          	beq	a1,a7,8000b978 <__adddf3+0x164>
8000b96c:	04000813          	li	a6,64
8000b970:	40b805b3          	sub	a1,a6,a1
8000b974:	00b71833          	sll	a6,a4,a1
8000b978:	00c86633          	or	a2,a6,a2
8000b97c:	00c03633          	snez	a2,a2
8000b980:	00c6e633          	or	a2,a3,a2
8000b984:	00000713          	li	a4,0
8000b988:	f81ff06f          	j	8000b908 <__adddf3+0xf4>
8000b98c:	00c76633          	or	a2,a4,a2
8000b990:	00c03633          	snez	a2,a2
8000b994:	ff1ff06f          	j	8000b984 <__adddf3+0x170>
8000b998:	0e080263          	beqz	a6,8000ba7c <__adddf3+0x268>
8000b99c:	409885b3          	sub	a1,a7,s1
8000b9a0:	02049e63          	bnez	s1,8000b9dc <__adddf3+0x1c8>
8000b9a4:	00a7e6b3          	or	a3,a5,a0
8000b9a8:	52068663          	beqz	a3,8000bed4 <__adddf3+0x6c0>
8000b9ac:	fff58693          	addi	a3,a1,-1
8000b9b0:	00069c63          	bnez	a3,8000b9c8 <__adddf3+0x1b4>
8000b9b4:	00c50533          	add	a0,a0,a2
8000b9b8:	00e787b3          	add	a5,a5,a4
8000b9bc:	00c53633          	sltu	a2,a0,a2
8000b9c0:	00c787b3          	add	a5,a5,a2
8000b9c4:	ee5ff06f          	j	8000b8a8 <__adddf3+0x94>
8000b9c8:	7ff00813          	li	a6,2047
8000b9cc:	03059263          	bne	a1,a6,8000b9f0 <__adddf3+0x1dc>
8000b9d0:	00070793          	mv	a5,a4
8000b9d4:	00060513          	mv	a0,a2
8000b9d8:	ee1ff06f          	j	8000b8b8 <__adddf3+0xa4>
8000b9dc:	7ff00693          	li	a3,2047
8000b9e0:	fed888e3          	beq	a7,a3,8000b9d0 <__adddf3+0x1bc>
8000b9e4:	008006b7          	lui	a3,0x800
8000b9e8:	00d7e7b3          	or	a5,a5,a3
8000b9ec:	00058693          	mv	a3,a1
8000b9f0:	03800593          	li	a1,56
8000b9f4:	06d5ce63          	blt	a1,a3,8000ba70 <__adddf3+0x25c>
8000b9f8:	01f00593          	li	a1,31
8000b9fc:	04d5c063          	blt	a1,a3,8000ba3c <__adddf3+0x228>
8000ba00:	02000813          	li	a6,32
8000ba04:	40d80833          	sub	a6,a6,a3
8000ba08:	00d55333          	srl	t1,a0,a3
8000ba0c:	010795b3          	sll	a1,a5,a6
8000ba10:	01051533          	sll	a0,a0,a6
8000ba14:	0065e5b3          	or	a1,a1,t1
8000ba18:	00a03533          	snez	a0,a0
8000ba1c:	00a5e533          	or	a0,a1,a0
8000ba20:	00d7d6b3          	srl	a3,a5,a3
8000ba24:	00c50533          	add	a0,a0,a2
8000ba28:	00e687b3          	add	a5,a3,a4
8000ba2c:	00c53633          	sltu	a2,a0,a2
8000ba30:	00c787b3          	add	a5,a5,a2
8000ba34:	00088493          	mv	s1,a7
8000ba38:	ee5ff06f          	j	8000b91c <__adddf3+0x108>
8000ba3c:	fe068593          	addi	a1,a3,-32 # 7fffe0 <crtStart-0x7f800020>
8000ba40:	02000313          	li	t1,32
8000ba44:	00b7d5b3          	srl	a1,a5,a1
8000ba48:	00000813          	li	a6,0
8000ba4c:	00668863          	beq	a3,t1,8000ba5c <__adddf3+0x248>
8000ba50:	04000813          	li	a6,64
8000ba54:	40d806b3          	sub	a3,a6,a3
8000ba58:	00d79833          	sll	a6,a5,a3
8000ba5c:	00a86533          	or	a0,a6,a0
8000ba60:	00a03533          	snez	a0,a0
8000ba64:	00a5e533          	or	a0,a1,a0
8000ba68:	00000693          	li	a3,0
8000ba6c:	fb9ff06f          	j	8000ba24 <__adddf3+0x210>
8000ba70:	00a7e533          	or	a0,a5,a0
8000ba74:	00a03533          	snez	a0,a0
8000ba78:	ff1ff06f          	j	8000ba68 <__adddf3+0x254>
8000ba7c:	00148693          	addi	a3,s1,1
8000ba80:	7fe6f593          	andi	a1,a3,2046
8000ba84:	08059663          	bnez	a1,8000bb10 <__adddf3+0x2fc>
8000ba88:	00a7e6b3          	or	a3,a5,a0
8000ba8c:	06049263          	bnez	s1,8000baf0 <__adddf3+0x2dc>
8000ba90:	44068a63          	beqz	a3,8000bee4 <__adddf3+0x6d0>
8000ba94:	00c766b3          	or	a3,a4,a2
8000ba98:	02068863          	beqz	a3,8000bac8 <__adddf3+0x2b4>
8000ba9c:	00c50633          	add	a2,a0,a2
8000baa0:	00e787b3          	add	a5,a5,a4
8000baa4:	00a63533          	sltu	a0,a2,a0
8000baa8:	00a787b3          	add	a5,a5,a0
8000baac:	00879713          	slli	a4,a5,0x8
8000bab0:	00060513          	mv	a0,a2
8000bab4:	00075a63          	bgez	a4,8000bac8 <__adddf3+0x2b4>
8000bab8:	ff800737          	lui	a4,0xff800
8000babc:	fff70713          	addi	a4,a4,-1 # ff7fffff <STACK_TOP+0x7f7dffff>
8000bac0:	00e7f7b3          	and	a5,a5,a4
8000bac4:	00100493          	li	s1,1
8000bac8:	00757713          	andi	a4,a0,7
8000bacc:	42070863          	beqz	a4,8000befc <__adddf3+0x6e8>
8000bad0:	00f57713          	andi	a4,a0,15
8000bad4:	00400693          	li	a3,4
8000bad8:	42d70263          	beq	a4,a3,8000befc <__adddf3+0x6e8>
8000badc:	00450693          	addi	a3,a0,4
8000bae0:	00a6b533          	sltu	a0,a3,a0
8000bae4:	00a787b3          	add	a5,a5,a0
8000bae8:	00068513          	mv	a0,a3
8000baec:	4100006f          	j	8000befc <__adddf3+0x6e8>
8000baf0:	ee0680e3          	beqz	a3,8000b9d0 <__adddf3+0x1bc>
8000baf4:	00c76633          	or	a2,a4,a2
8000baf8:	dc0600e3          	beqz	a2,8000b8b8 <__adddf3+0xa4>
8000bafc:	00000913          	li	s2,0
8000bb00:	004007b7          	lui	a5,0x400
8000bb04:	00000513          	li	a0,0
8000bb08:	7ff00493          	li	s1,2047
8000bb0c:	3f00006f          	j	8000befc <__adddf3+0x6e8>
8000bb10:	7ff00593          	li	a1,2047
8000bb14:	3cb68e63          	beq	a3,a1,8000bef0 <__adddf3+0x6dc>
8000bb18:	00c50633          	add	a2,a0,a2
8000bb1c:	00e78733          	add	a4,a5,a4
8000bb20:	00a637b3          	sltu	a5,a2,a0
8000bb24:	00f70733          	add	a4,a4,a5
8000bb28:	01f71513          	slli	a0,a4,0x1f
8000bb2c:	00165613          	srli	a2,a2,0x1
8000bb30:	00c56533          	or	a0,a0,a2
8000bb34:	00175793          	srli	a5,a4,0x1
8000bb38:	00068493          	mv	s1,a3
8000bb3c:	f8dff06f          	j	8000bac8 <__adddf3+0x2b4>
8000bb40:	0f005c63          	blez	a6,8000bc38 <__adddf3+0x424>
8000bb44:	08089e63          	bnez	a7,8000bbe0 <__adddf3+0x3cc>
8000bb48:	00c766b3          	or	a3,a4,a2
8000bb4c:	42068e63          	beqz	a3,8000bf88 <__adddf3+0x774>
8000bb50:	fff80593          	addi	a1,a6,-1
8000bb54:	02059063          	bnez	a1,8000bb74 <__adddf3+0x360>
8000bb58:	40c50633          	sub	a2,a0,a2
8000bb5c:	00c53533          	sltu	a0,a0,a2
8000bb60:	40e787b3          	sub	a5,a5,a4
8000bb64:	40a787b3          	sub	a5,a5,a0
8000bb68:	00060513          	mv	a0,a2
8000bb6c:	00100493          	li	s1,1
8000bb70:	0540006f          	j	8000bbc4 <__adddf3+0x3b0>
8000bb74:	7ff00693          	li	a3,2047
8000bb78:	d4d800e3          	beq	a6,a3,8000b8b8 <__adddf3+0xa4>
8000bb7c:	03800693          	li	a3,56
8000bb80:	0ab6c663          	blt	a3,a1,8000bc2c <__adddf3+0x418>
8000bb84:	01f00693          	li	a3,31
8000bb88:	06b6c863          	blt	a3,a1,8000bbf8 <__adddf3+0x3e4>
8000bb8c:	02000813          	li	a6,32
8000bb90:	40b80833          	sub	a6,a6,a1
8000bb94:	010716b3          	sll	a3,a4,a6
8000bb98:	00b658b3          	srl	a7,a2,a1
8000bb9c:	01061633          	sll	a2,a2,a6
8000bba0:	0116e6b3          	or	a3,a3,a7
8000bba4:	00c03633          	snez	a2,a2
8000bba8:	00c6e633          	or	a2,a3,a2
8000bbac:	00b75733          	srl	a4,a4,a1
8000bbb0:	40c50633          	sub	a2,a0,a2
8000bbb4:	40e78733          	sub	a4,a5,a4
8000bbb8:	00c537b3          	sltu	a5,a0,a2
8000bbbc:	40f707b3          	sub	a5,a4,a5
8000bbc0:	00060513          	mv	a0,a2
8000bbc4:	00879713          	slli	a4,a5,0x8
8000bbc8:	f00750e3          	bgez	a4,8000bac8 <__adddf3+0x2b4>
8000bbcc:	00800437          	lui	s0,0x800
8000bbd0:	fff40413          	addi	s0,s0,-1 # 7fffff <crtStart-0x7f800001>
8000bbd4:	0087f433          	and	s0,a5,s0
8000bbd8:	00050993          	mv	s3,a0
8000bbdc:	20c0006f          	j	8000bde8 <__adddf3+0x5d4>
8000bbe0:	7ff00693          	li	a3,2047
8000bbe4:	eed482e3          	beq	s1,a3,8000bac8 <__adddf3+0x2b4>
8000bbe8:	008006b7          	lui	a3,0x800
8000bbec:	00d76733          	or	a4,a4,a3
8000bbf0:	00080593          	mv	a1,a6
8000bbf4:	f89ff06f          	j	8000bb7c <__adddf3+0x368>
8000bbf8:	fe058693          	addi	a3,a1,-32
8000bbfc:	02000893          	li	a7,32
8000bc00:	00d756b3          	srl	a3,a4,a3
8000bc04:	00000813          	li	a6,0
8000bc08:	01158863          	beq	a1,a7,8000bc18 <__adddf3+0x404>
8000bc0c:	04000813          	li	a6,64
8000bc10:	40b805b3          	sub	a1,a6,a1
8000bc14:	00b71833          	sll	a6,a4,a1
8000bc18:	00c86633          	or	a2,a6,a2
8000bc1c:	00c03633          	snez	a2,a2
8000bc20:	00c6e633          	or	a2,a3,a2
8000bc24:	00000713          	li	a4,0
8000bc28:	f89ff06f          	j	8000bbb0 <__adddf3+0x39c>
8000bc2c:	00c76633          	or	a2,a4,a2
8000bc30:	00c03633          	snez	a2,a2
8000bc34:	ff1ff06f          	j	8000bc24 <__adddf3+0x410>
8000bc38:	0e080863          	beqz	a6,8000bd28 <__adddf3+0x514>
8000bc3c:	40988833          	sub	a6,a7,s1
8000bc40:	04049263          	bnez	s1,8000bc84 <__adddf3+0x470>
8000bc44:	00a7e5b3          	or	a1,a5,a0
8000bc48:	34058463          	beqz	a1,8000bf90 <__adddf3+0x77c>
8000bc4c:	fff80593          	addi	a1,a6,-1
8000bc50:	00059e63          	bnez	a1,8000bc6c <__adddf3+0x458>
8000bc54:	40a60533          	sub	a0,a2,a0
8000bc58:	40f707b3          	sub	a5,a4,a5
8000bc5c:	00a63633          	sltu	a2,a2,a0
8000bc60:	40c787b3          	sub	a5,a5,a2
8000bc64:	00068913          	mv	s2,a3
8000bc68:	f05ff06f          	j	8000bb6c <__adddf3+0x358>
8000bc6c:	7ff00313          	li	t1,2047
8000bc70:	02681463          	bne	a6,t1,8000bc98 <__adddf3+0x484>
8000bc74:	00070793          	mv	a5,a4
8000bc78:	00060513          	mv	a0,a2
8000bc7c:	7ff00493          	li	s1,2047
8000bc80:	0d00006f          	j	8000bd50 <__adddf3+0x53c>
8000bc84:	7ff00593          	li	a1,2047
8000bc88:	feb886e3          	beq	a7,a1,8000bc74 <__adddf3+0x460>
8000bc8c:	008005b7          	lui	a1,0x800
8000bc90:	00b7e7b3          	or	a5,a5,a1
8000bc94:	00080593          	mv	a1,a6
8000bc98:	03800813          	li	a6,56
8000bc9c:	08b84063          	blt	a6,a1,8000bd1c <__adddf3+0x508>
8000bca0:	01f00813          	li	a6,31
8000bca4:	04b84263          	blt	a6,a1,8000bce8 <__adddf3+0x4d4>
8000bca8:	02000313          	li	t1,32
8000bcac:	40b30333          	sub	t1,t1,a1
8000bcb0:	00b55e33          	srl	t3,a0,a1
8000bcb4:	00679833          	sll	a6,a5,t1
8000bcb8:	00651533          	sll	a0,a0,t1
8000bcbc:	01c86833          	or	a6,a6,t3
8000bcc0:	00a03533          	snez	a0,a0
8000bcc4:	00a86533          	or	a0,a6,a0
8000bcc8:	00b7d5b3          	srl	a1,a5,a1
8000bccc:	40a60533          	sub	a0,a2,a0
8000bcd0:	40b707b3          	sub	a5,a4,a1
8000bcd4:	00a63633          	sltu	a2,a2,a0
8000bcd8:	40c787b3          	sub	a5,a5,a2
8000bcdc:	00088493          	mv	s1,a7
8000bce0:	00068913          	mv	s2,a3
8000bce4:	ee1ff06f          	j	8000bbc4 <__adddf3+0x3b0>
8000bce8:	fe058813          	addi	a6,a1,-32 # 7fffe0 <crtStart-0x7f800020>
8000bcec:	02000e13          	li	t3,32
8000bcf0:	0107d833          	srl	a6,a5,a6
8000bcf4:	00000313          	li	t1,0
8000bcf8:	01c58863          	beq	a1,t3,8000bd08 <__adddf3+0x4f4>
8000bcfc:	04000313          	li	t1,64
8000bd00:	40b305b3          	sub	a1,t1,a1
8000bd04:	00b79333          	sll	t1,a5,a1
8000bd08:	00a36533          	or	a0,t1,a0
8000bd0c:	00a03533          	snez	a0,a0
8000bd10:	00a86533          	or	a0,a6,a0
8000bd14:	00000593          	li	a1,0
8000bd18:	fb5ff06f          	j	8000bccc <__adddf3+0x4b8>
8000bd1c:	00a7e533          	or	a0,a5,a0
8000bd20:	00a03533          	snez	a0,a0
8000bd24:	ff1ff06f          	j	8000bd14 <__adddf3+0x500>
8000bd28:	00148593          	addi	a1,s1,1
8000bd2c:	7fe5f593          	andi	a1,a1,2046
8000bd30:	08059663          	bnez	a1,8000bdbc <__adddf3+0x5a8>
8000bd34:	00a7e833          	or	a6,a5,a0
8000bd38:	00c765b3          	or	a1,a4,a2
8000bd3c:	06049063          	bnez	s1,8000bd9c <__adddf3+0x588>
8000bd40:	00081c63          	bnez	a6,8000bd58 <__adddf3+0x544>
8000bd44:	24058e63          	beqz	a1,8000bfa0 <__adddf3+0x78c>
8000bd48:	00070793          	mv	a5,a4
8000bd4c:	00060513          	mv	a0,a2
8000bd50:	00068913          	mv	s2,a3
8000bd54:	d75ff06f          	j	8000bac8 <__adddf3+0x2b4>
8000bd58:	d60588e3          	beqz	a1,8000bac8 <__adddf3+0x2b4>
8000bd5c:	40c50833          	sub	a6,a0,a2
8000bd60:	010538b3          	sltu	a7,a0,a6
8000bd64:	40e785b3          	sub	a1,a5,a4
8000bd68:	411585b3          	sub	a1,a1,a7
8000bd6c:	00859893          	slli	a7,a1,0x8
8000bd70:	0008dc63          	bgez	a7,8000bd88 <__adddf3+0x574>
8000bd74:	40a60533          	sub	a0,a2,a0
8000bd78:	40f707b3          	sub	a5,a4,a5
8000bd7c:	00a63633          	sltu	a2,a2,a0
8000bd80:	40c787b3          	sub	a5,a5,a2
8000bd84:	fcdff06f          	j	8000bd50 <__adddf3+0x53c>
8000bd88:	00b86533          	or	a0,a6,a1
8000bd8c:	22050263          	beqz	a0,8000bfb0 <__adddf3+0x79c>
8000bd90:	00058793          	mv	a5,a1
8000bd94:	00080513          	mv	a0,a6
8000bd98:	d31ff06f          	j	8000bac8 <__adddf3+0x2b4>
8000bd9c:	00081c63          	bnez	a6,8000bdb4 <__adddf3+0x5a0>
8000bda0:	20058c63          	beqz	a1,8000bfb8 <__adddf3+0x7a4>
8000bda4:	00070793          	mv	a5,a4
8000bda8:	00060513          	mv	a0,a2
8000bdac:	00068913          	mv	s2,a3
8000bdb0:	b09ff06f          	j	8000b8b8 <__adddf3+0xa4>
8000bdb4:	b00582e3          	beqz	a1,8000b8b8 <__adddf3+0xa4>
8000bdb8:	d45ff06f          	j	8000bafc <__adddf3+0x2e8>
8000bdbc:	40c509b3          	sub	s3,a0,a2
8000bdc0:	013535b3          	sltu	a1,a0,s3
8000bdc4:	40e78433          	sub	s0,a5,a4
8000bdc8:	40b40433          	sub	s0,s0,a1
8000bdcc:	00841593          	slli	a1,s0,0x8
8000bdd0:	0805d463          	bgez	a1,8000be58 <__adddf3+0x644>
8000bdd4:	40a609b3          	sub	s3,a2,a0
8000bdd8:	40f707b3          	sub	a5,a4,a5
8000bddc:	01363633          	sltu	a2,a2,s3
8000bde0:	40c78433          	sub	s0,a5,a2
8000bde4:	00068913          	mv	s2,a3
8000bde8:	08040263          	beqz	s0,8000be6c <__adddf3+0x658>
8000bdec:	00040513          	mv	a0,s0
8000bdf0:	48d010ef          	jal	ra,8000da7c <__clzsi2>
8000bdf4:	ff850713          	addi	a4,a0,-8
8000bdf8:	01f00793          	li	a5,31
8000bdfc:	08e7c063          	blt	a5,a4,8000be7c <__adddf3+0x668>
8000be00:	02000793          	li	a5,32
8000be04:	40e787b3          	sub	a5,a5,a4
8000be08:	00e41433          	sll	s0,s0,a4
8000be0c:	00f9d7b3          	srl	a5,s3,a5
8000be10:	0087e433          	or	s0,a5,s0
8000be14:	00e99533          	sll	a0,s3,a4
8000be18:	0a974463          	blt	a4,s1,8000bec0 <__adddf3+0x6ac>
8000be1c:	40970733          	sub	a4,a4,s1
8000be20:	00170793          	addi	a5,a4,1
8000be24:	01f00693          	li	a3,31
8000be28:	06f6c263          	blt	a3,a5,8000be8c <__adddf3+0x678>
8000be2c:	02000713          	li	a4,32
8000be30:	40f70733          	sub	a4,a4,a5
8000be34:	00f55633          	srl	a2,a0,a5
8000be38:	00e416b3          	sll	a3,s0,a4
8000be3c:	00e51533          	sll	a0,a0,a4
8000be40:	00c6e6b3          	or	a3,a3,a2
8000be44:	00a03533          	snez	a0,a0
8000be48:	00a6e533          	or	a0,a3,a0
8000be4c:	00f457b3          	srl	a5,s0,a5
8000be50:	00000493          	li	s1,0
8000be54:	c75ff06f          	j	8000bac8 <__adddf3+0x2b4>
8000be58:	0089e533          	or	a0,s3,s0
8000be5c:	f80516e3          	bnez	a0,8000bde8 <__adddf3+0x5d4>
8000be60:	00000793          	li	a5,0
8000be64:	00000493          	li	s1,0
8000be68:	1400006f          	j	8000bfa8 <__adddf3+0x794>
8000be6c:	00098513          	mv	a0,s3
8000be70:	40d010ef          	jal	ra,8000da7c <__clzsi2>
8000be74:	02050513          	addi	a0,a0,32
8000be78:	f7dff06f          	j	8000bdf4 <__adddf3+0x5e0>
8000be7c:	fd850413          	addi	s0,a0,-40
8000be80:	00899433          	sll	s0,s3,s0
8000be84:	00000513          	li	a0,0
8000be88:	f91ff06f          	j	8000be18 <__adddf3+0x604>
8000be8c:	fe170713          	addi	a4,a4,-31
8000be90:	02000613          	li	a2,32
8000be94:	00e45733          	srl	a4,s0,a4
8000be98:	00000693          	li	a3,0
8000be9c:	00c78863          	beq	a5,a2,8000beac <__adddf3+0x698>
8000bea0:	04000693          	li	a3,64
8000bea4:	40f686b3          	sub	a3,a3,a5
8000bea8:	00d416b3          	sll	a3,s0,a3
8000beac:	00d56533          	or	a0,a0,a3
8000beb0:	00a03533          	snez	a0,a0
8000beb4:	00a76533          	or	a0,a4,a0
8000beb8:	00000793          	li	a5,0
8000bebc:	f95ff06f          	j	8000be50 <__adddf3+0x63c>
8000bec0:	ff8007b7          	lui	a5,0xff800
8000bec4:	fff78793          	addi	a5,a5,-1 # ff7fffff <STACK_TOP+0x7f7dffff>
8000bec8:	40e484b3          	sub	s1,s1,a4
8000becc:	00f477b3          	and	a5,s0,a5
8000bed0:	bf9ff06f          	j	8000bac8 <__adddf3+0x2b4>
8000bed4:	00070793          	mv	a5,a4
8000bed8:	00060513          	mv	a0,a2
8000bedc:	00058493          	mv	s1,a1
8000bee0:	be9ff06f          	j	8000bac8 <__adddf3+0x2b4>
8000bee4:	00070793          	mv	a5,a4
8000bee8:	00060513          	mv	a0,a2
8000beec:	bddff06f          	j	8000bac8 <__adddf3+0x2b4>
8000bef0:	7ff00493          	li	s1,2047
8000bef4:	00000793          	li	a5,0
8000bef8:	00000513          	li	a0,0
8000befc:	00879713          	slli	a4,a5,0x8
8000bf00:	00075e63          	bgez	a4,8000bf1c <__adddf3+0x708>
8000bf04:	00148493          	addi	s1,s1,1
8000bf08:	7ff00713          	li	a4,2047
8000bf0c:	0ae48e63          	beq	s1,a4,8000bfc8 <__adddf3+0x7b4>
8000bf10:	ff800737          	lui	a4,0xff800
8000bf14:	fff70713          	addi	a4,a4,-1 # ff7fffff <STACK_TOP+0x7f7dffff>
8000bf18:	00e7f7b3          	and	a5,a5,a4
8000bf1c:	01d79713          	slli	a4,a5,0x1d
8000bf20:	00355513          	srli	a0,a0,0x3
8000bf24:	00a76533          	or	a0,a4,a0
8000bf28:	7ff00713          	li	a4,2047
8000bf2c:	0037d793          	srli	a5,a5,0x3
8000bf30:	00e49e63          	bne	s1,a4,8000bf4c <__adddf3+0x738>
8000bf34:	00f56533          	or	a0,a0,a5
8000bf38:	00000793          	li	a5,0
8000bf3c:	00050863          	beqz	a0,8000bf4c <__adddf3+0x738>
8000bf40:	000807b7          	lui	a5,0x80
8000bf44:	00000513          	li	a0,0
8000bf48:	00000913          	li	s2,0
8000bf4c:	7ff4f713          	andi	a4,s1,2047
8000bf50:	00c79793          	slli	a5,a5,0xc
8000bf54:	01471713          	slli	a4,a4,0x14
8000bf58:	01c12083          	lw	ra,28(sp)
8000bf5c:	01812403          	lw	s0,24(sp)
8000bf60:	00c7d793          	srli	a5,a5,0xc
8000bf64:	01f91593          	slli	a1,s2,0x1f
8000bf68:	00e7e7b3          	or	a5,a5,a4
8000bf6c:	00b7e733          	or	a4,a5,a1
8000bf70:	01412483          	lw	s1,20(sp)
8000bf74:	01012903          	lw	s2,16(sp)
8000bf78:	00c12983          	lw	s3,12(sp)
8000bf7c:	00070593          	mv	a1,a4
8000bf80:	02010113          	addi	sp,sp,32
8000bf84:	00008067          	ret
8000bf88:	00080493          	mv	s1,a6
8000bf8c:	b3dff06f          	j	8000bac8 <__adddf3+0x2b4>
8000bf90:	00070793          	mv	a5,a4
8000bf94:	00060513          	mv	a0,a2
8000bf98:	00080493          	mv	s1,a6
8000bf9c:	db5ff06f          	j	8000bd50 <__adddf3+0x53c>
8000bfa0:	00000793          	li	a5,0
8000bfa4:	00000513          	li	a0,0
8000bfa8:	00000913          	li	s2,0
8000bfac:	f51ff06f          	j	8000befc <__adddf3+0x6e8>
8000bfb0:	00000793          	li	a5,0
8000bfb4:	ff5ff06f          	j	8000bfa8 <__adddf3+0x794>
8000bfb8:	00000513          	li	a0,0
8000bfbc:	00000913          	li	s2,0
8000bfc0:	004007b7          	lui	a5,0x400
8000bfc4:	b45ff06f          	j	8000bb08 <__adddf3+0x2f4>
8000bfc8:	00000793          	li	a5,0
8000bfcc:	00000513          	li	a0,0
8000bfd0:	f4dff06f          	j	8000bf1c <__adddf3+0x708>

8000bfd4 <__divdf3>:
8000bfd4:	fb010113          	addi	sp,sp,-80
8000bfd8:	03312e23          	sw	s3,60(sp)
8000bfdc:	0145d993          	srli	s3,a1,0x14
8000bfe0:	04912223          	sw	s1,68(sp)
8000bfe4:	05212023          	sw	s2,64(sp)
8000bfe8:	03512a23          	sw	s5,52(sp)
8000bfec:	03612823          	sw	s6,48(sp)
8000bff0:	03712623          	sw	s7,44(sp)
8000bff4:	00c59493          	slli	s1,a1,0xc
8000bff8:	04112623          	sw	ra,76(sp)
8000bffc:	04812423          	sw	s0,72(sp)
8000c000:	03412c23          	sw	s4,56(sp)
8000c004:	03812423          	sw	s8,40(sp)
8000c008:	03912223          	sw	s9,36(sp)
8000c00c:	03a12023          	sw	s10,32(sp)
8000c010:	01b12e23          	sw	s11,28(sp)
8000c014:	7ff9f993          	andi	s3,s3,2047
8000c018:	00050913          	mv	s2,a0
8000c01c:	00060b93          	mv	s7,a2
8000c020:	00068b13          	mv	s6,a3
8000c024:	00c4d493          	srli	s1,s1,0xc
8000c028:	01f5da93          	srli	s5,a1,0x1f
8000c02c:	0a098263          	beqz	s3,8000c0d0 <__divdf3+0xfc>
8000c030:	7ff00793          	li	a5,2047
8000c034:	10f98063          	beq	s3,a5,8000c134 <__divdf3+0x160>
8000c038:	01d55c93          	srli	s9,a0,0x1d
8000c03c:	00349493          	slli	s1,s1,0x3
8000c040:	009ce4b3          	or	s1,s9,s1
8000c044:	00800cb7          	lui	s9,0x800
8000c048:	0194ecb3          	or	s9,s1,s9
8000c04c:	00351413          	slli	s0,a0,0x3
8000c050:	c0198a13          	addi	s4,s3,-1023
8000c054:	00000c13          	li	s8,0
8000c058:	014b5513          	srli	a0,s6,0x14
8000c05c:	00cb1913          	slli	s2,s6,0xc
8000c060:	7ff57993          	andi	s3,a0,2047
8000c064:	00c95913          	srli	s2,s2,0xc
8000c068:	01fb5b13          	srli	s6,s6,0x1f
8000c06c:	10098263          	beqz	s3,8000c170 <__divdf3+0x19c>
8000c070:	7ff00793          	li	a5,2047
8000c074:	16f98263          	beq	s3,a5,8000c1d8 <__divdf3+0x204>
8000c078:	00391513          	slli	a0,s2,0x3
8000c07c:	01dbd793          	srli	a5,s7,0x1d
8000c080:	00a7e533          	or	a0,a5,a0
8000c084:	00800937          	lui	s2,0x800
8000c088:	01256933          	or	s2,a0,s2
8000c08c:	003b9813          	slli	a6,s7,0x3
8000c090:	c0198513          	addi	a0,s3,-1023
8000c094:	00000793          	li	a5,0
8000c098:	002c1713          	slli	a4,s8,0x2
8000c09c:	00f76733          	or	a4,a4,a5
8000c0a0:	fff70713          	addi	a4,a4,-1
8000c0a4:	00e00693          	li	a3,14
8000c0a8:	016ac4b3          	xor	s1,s5,s6
8000c0ac:	40aa09b3          	sub	s3,s4,a0
8000c0b0:	16e6e063          	bltu	a3,a4,8000c210 <__divdf3+0x23c>
8000c0b4:	00003697          	auipc	a3,0x3
8000c0b8:	86468693          	addi	a3,a3,-1948 # 8000e918 <cvt2.1234+0xbc>
8000c0bc:	00271713          	slli	a4,a4,0x2
8000c0c0:	00d70733          	add	a4,a4,a3
8000c0c4:	00072703          	lw	a4,0(a4)
8000c0c8:	00d70733          	add	a4,a4,a3
8000c0cc:	00070067          	jr	a4
8000c0d0:	00a4ecb3          	or	s9,s1,a0
8000c0d4:	060c8e63          	beqz	s9,8000c150 <__divdf3+0x17c>
8000c0d8:	04048063          	beqz	s1,8000c118 <__divdf3+0x144>
8000c0dc:	00048513          	mv	a0,s1
8000c0e0:	19d010ef          	jal	ra,8000da7c <__clzsi2>
8000c0e4:	ff550793          	addi	a5,a0,-11
8000c0e8:	01c00713          	li	a4,28
8000c0ec:	02f74c63          	blt	a4,a5,8000c124 <__divdf3+0x150>
8000c0f0:	01d00c93          	li	s9,29
8000c0f4:	ff850413          	addi	s0,a0,-8
8000c0f8:	40fc8cb3          	sub	s9,s9,a5
8000c0fc:	008494b3          	sll	s1,s1,s0
8000c100:	01995cb3          	srl	s9,s2,s9
8000c104:	009cecb3          	or	s9,s9,s1
8000c108:	00891433          	sll	s0,s2,s0
8000c10c:	c0d00993          	li	s3,-1011
8000c110:	40a98a33          	sub	s4,s3,a0
8000c114:	f41ff06f          	j	8000c054 <__divdf3+0x80>
8000c118:	165010ef          	jal	ra,8000da7c <__clzsi2>
8000c11c:	02050513          	addi	a0,a0,32
8000c120:	fc5ff06f          	j	8000c0e4 <__divdf3+0x110>
8000c124:	fd850493          	addi	s1,a0,-40
8000c128:	00991cb3          	sll	s9,s2,s1
8000c12c:	00000413          	li	s0,0
8000c130:	fddff06f          	j	8000c10c <__divdf3+0x138>
8000c134:	00a4ecb3          	or	s9,s1,a0
8000c138:	020c8463          	beqz	s9,8000c160 <__divdf3+0x18c>
8000c13c:	00050413          	mv	s0,a0
8000c140:	00048c93          	mv	s9,s1
8000c144:	7ff00a13          	li	s4,2047
8000c148:	00300c13          	li	s8,3
8000c14c:	f0dff06f          	j	8000c058 <__divdf3+0x84>
8000c150:	00000413          	li	s0,0
8000c154:	00000a13          	li	s4,0
8000c158:	00100c13          	li	s8,1
8000c15c:	efdff06f          	j	8000c058 <__divdf3+0x84>
8000c160:	00000413          	li	s0,0
8000c164:	7ff00a13          	li	s4,2047
8000c168:	00200c13          	li	s8,2
8000c16c:	eedff06f          	j	8000c058 <__divdf3+0x84>
8000c170:	01796833          	or	a6,s2,s7
8000c174:	06080e63          	beqz	a6,8000c1f0 <__divdf3+0x21c>
8000c178:	04090063          	beqz	s2,8000c1b8 <__divdf3+0x1e4>
8000c17c:	00090513          	mv	a0,s2
8000c180:	0fd010ef          	jal	ra,8000da7c <__clzsi2>
8000c184:	ff550793          	addi	a5,a0,-11
8000c188:	01c00713          	li	a4,28
8000c18c:	02f74e63          	blt	a4,a5,8000c1c8 <__divdf3+0x1f4>
8000c190:	01d00713          	li	a4,29
8000c194:	ff850813          	addi	a6,a0,-8
8000c198:	40f70733          	sub	a4,a4,a5
8000c19c:	01091933          	sll	s2,s2,a6
8000c1a0:	00ebd733          	srl	a4,s7,a4
8000c1a4:	01276933          	or	s2,a4,s2
8000c1a8:	010b9833          	sll	a6,s7,a6
8000c1ac:	c0d00713          	li	a4,-1011
8000c1b0:	40a70533          	sub	a0,a4,a0
8000c1b4:	ee1ff06f          	j	8000c094 <__divdf3+0xc0>
8000c1b8:	000b8513          	mv	a0,s7
8000c1bc:	0c1010ef          	jal	ra,8000da7c <__clzsi2>
8000c1c0:	02050513          	addi	a0,a0,32
8000c1c4:	fc1ff06f          	j	8000c184 <__divdf3+0x1b0>
8000c1c8:	fd850913          	addi	s2,a0,-40
8000c1cc:	012b9933          	sll	s2,s7,s2
8000c1d0:	00000813          	li	a6,0
8000c1d4:	fd9ff06f          	j	8000c1ac <__divdf3+0x1d8>
8000c1d8:	01796833          	or	a6,s2,s7
8000c1dc:	02080263          	beqz	a6,8000c200 <__divdf3+0x22c>
8000c1e0:	000b8813          	mv	a6,s7
8000c1e4:	7ff00513          	li	a0,2047
8000c1e8:	00300793          	li	a5,3
8000c1ec:	eadff06f          	j	8000c098 <__divdf3+0xc4>
8000c1f0:	00000913          	li	s2,0
8000c1f4:	00000513          	li	a0,0
8000c1f8:	00100793          	li	a5,1
8000c1fc:	e9dff06f          	j	8000c098 <__divdf3+0xc4>
8000c200:	00000913          	li	s2,0
8000c204:	7ff00513          	li	a0,2047
8000c208:	00200793          	li	a5,2
8000c20c:	e8dff06f          	j	8000c098 <__divdf3+0xc4>
8000c210:	01996663          	bltu	s2,s9,8000c21c <__divdf3+0x248>
8000c214:	452c9263          	bne	s9,s2,8000c658 <__divdf3+0x684>
8000c218:	45046063          	bltu	s0,a6,8000c658 <__divdf3+0x684>
8000c21c:	01fc9713          	slli	a4,s9,0x1f
8000c220:	00145793          	srli	a5,s0,0x1
8000c224:	01f41d93          	slli	s11,s0,0x1f
8000c228:	001cdc93          	srli	s9,s9,0x1
8000c22c:	00f76433          	or	s0,a4,a5
8000c230:	01885b93          	srli	s7,a6,0x18
8000c234:	00891513          	slli	a0,s2,0x8
8000c238:	00abebb3          	or	s7,s7,a0
8000c23c:	010bda93          	srli	s5,s7,0x10
8000c240:	000a8593          	mv	a1,s5
8000c244:	010b9b13          	slli	s6,s7,0x10
8000c248:	000c8513          	mv	a0,s9
8000c24c:	00881c13          	slli	s8,a6,0x8
8000c250:	010b5b13          	srli	s6,s6,0x10
8000c254:	77c010ef          	jal	ra,8000d9d0 <__udivsi3>
8000c258:	00050593          	mv	a1,a0
8000c25c:	00050d13          	mv	s10,a0
8000c260:	000b0513          	mv	a0,s6
8000c264:	740010ef          	jal	ra,8000d9a4 <__mulsi3>
8000c268:	00050913          	mv	s2,a0
8000c26c:	000a8593          	mv	a1,s5
8000c270:	000c8513          	mv	a0,s9
8000c274:	7a4010ef          	jal	ra,8000da18 <__umodsi3>
8000c278:	01051513          	slli	a0,a0,0x10
8000c27c:	01045793          	srli	a5,s0,0x10
8000c280:	00a7e533          	or	a0,a5,a0
8000c284:	000d0a13          	mv	s4,s10
8000c288:	01257e63          	bgeu	a0,s2,8000c2a4 <__divdf3+0x2d0>
8000c28c:	01750533          	add	a0,a0,s7
8000c290:	fffd0a13          	addi	s4,s10,-1
8000c294:	01756863          	bltu	a0,s7,8000c2a4 <__divdf3+0x2d0>
8000c298:	01257663          	bgeu	a0,s2,8000c2a4 <__divdf3+0x2d0>
8000c29c:	ffed0a13          	addi	s4,s10,-2
8000c2a0:	01750533          	add	a0,a0,s7
8000c2a4:	41250933          	sub	s2,a0,s2
8000c2a8:	000a8593          	mv	a1,s5
8000c2ac:	00090513          	mv	a0,s2
8000c2b0:	720010ef          	jal	ra,8000d9d0 <__udivsi3>
8000c2b4:	00050593          	mv	a1,a0
8000c2b8:	00050d13          	mv	s10,a0
8000c2bc:	000b0513          	mv	a0,s6
8000c2c0:	6e4010ef          	jal	ra,8000d9a4 <__mulsi3>
8000c2c4:	00050c93          	mv	s9,a0
8000c2c8:	000a8593          	mv	a1,s5
8000c2cc:	00090513          	mv	a0,s2
8000c2d0:	748010ef          	jal	ra,8000da18 <__umodsi3>
8000c2d4:	01041413          	slli	s0,s0,0x10
8000c2d8:	01051513          	slli	a0,a0,0x10
8000c2dc:	01045413          	srli	s0,s0,0x10
8000c2e0:	00a46433          	or	s0,s0,a0
8000c2e4:	000d0713          	mv	a4,s10
8000c2e8:	01947e63          	bgeu	s0,s9,8000c304 <__divdf3+0x330>
8000c2ec:	01740433          	add	s0,s0,s7
8000c2f0:	fffd0713          	addi	a4,s10,-1
8000c2f4:	01746863          	bltu	s0,s7,8000c304 <__divdf3+0x330>
8000c2f8:	01947663          	bgeu	s0,s9,8000c304 <__divdf3+0x330>
8000c2fc:	ffed0713          	addi	a4,s10,-2
8000c300:	01740433          	add	s0,s0,s7
8000c304:	010a1793          	slli	a5,s4,0x10
8000c308:	00010e37          	lui	t3,0x10
8000c30c:	00e7e7b3          	or	a5,a5,a4
8000c310:	41940833          	sub	a6,s0,s9
8000c314:	fffe0c93          	addi	s9,t3,-1 # ffff <crtStart-0x7fff0001>
8000c318:	0197f333          	and	t1,a5,s9
8000c31c:	019c7cb3          	and	s9,s8,s9
8000c320:	0107d713          	srli	a4,a5,0x10
8000c324:	010c5d13          	srli	s10,s8,0x10
8000c328:	00030513          	mv	a0,t1
8000c32c:	000c8593          	mv	a1,s9
8000c330:	674010ef          	jal	ra,8000d9a4 <__mulsi3>
8000c334:	00050893          	mv	a7,a0
8000c338:	000d0593          	mv	a1,s10
8000c33c:	00030513          	mv	a0,t1
8000c340:	664010ef          	jal	ra,8000d9a4 <__mulsi3>
8000c344:	00050313          	mv	t1,a0
8000c348:	000c8593          	mv	a1,s9
8000c34c:	00070513          	mv	a0,a4
8000c350:	654010ef          	jal	ra,8000d9a4 <__mulsi3>
8000c354:	00050e93          	mv	t4,a0
8000c358:	000d0593          	mv	a1,s10
8000c35c:	00070513          	mv	a0,a4
8000c360:	644010ef          	jal	ra,8000d9a4 <__mulsi3>
8000c364:	0108d713          	srli	a4,a7,0x10
8000c368:	01d30333          	add	t1,t1,t4
8000c36c:	00670733          	add	a4,a4,t1
8000c370:	01d77463          	bgeu	a4,t4,8000c378 <__divdf3+0x3a4>
8000c374:	01c50533          	add	a0,a0,t3
8000c378:	01075413          	srli	s0,a4,0x10
8000c37c:	00a40433          	add	s0,s0,a0
8000c380:	00010537          	lui	a0,0x10
8000c384:	fff50513          	addi	a0,a0,-1 # ffff <crtStart-0x7fff0001>
8000c388:	00a77a33          	and	s4,a4,a0
8000c38c:	010a1a13          	slli	s4,s4,0x10
8000c390:	00a8f8b3          	and	a7,a7,a0
8000c394:	011a0a33          	add	s4,s4,a7
8000c398:	00886863          	bltu	a6,s0,8000c3a8 <__divdf3+0x3d4>
8000c39c:	00078913          	mv	s2,a5
8000c3a0:	04881463          	bne	a6,s0,8000c3e8 <__divdf3+0x414>
8000c3a4:	054df263          	bgeu	s11,s4,8000c3e8 <__divdf3+0x414>
8000c3a8:	018d8db3          	add	s11,s11,s8
8000c3ac:	018db733          	sltu	a4,s11,s8
8000c3b0:	01770733          	add	a4,a4,s7
8000c3b4:	00e80833          	add	a6,a6,a4
8000c3b8:	fff78913          	addi	s2,a5,-1 # 3fffff <crtStart-0x7fc00001>
8000c3bc:	010be663          	bltu	s7,a6,8000c3c8 <__divdf3+0x3f4>
8000c3c0:	030b9463          	bne	s7,a6,8000c3e8 <__divdf3+0x414>
8000c3c4:	038de263          	bltu	s11,s8,8000c3e8 <__divdf3+0x414>
8000c3c8:	00886663          	bltu	a6,s0,8000c3d4 <__divdf3+0x400>
8000c3cc:	01041e63          	bne	s0,a6,8000c3e8 <__divdf3+0x414>
8000c3d0:	014dfc63          	bgeu	s11,s4,8000c3e8 <__divdf3+0x414>
8000c3d4:	018d8db3          	add	s11,s11,s8
8000c3d8:	ffe78913          	addi	s2,a5,-2
8000c3dc:	018db7b3          	sltu	a5,s11,s8
8000c3e0:	017787b3          	add	a5,a5,s7
8000c3e4:	00f80833          	add	a6,a6,a5
8000c3e8:	414d8a33          	sub	s4,s11,s4
8000c3ec:	40880433          	sub	s0,a6,s0
8000c3f0:	014db7b3          	sltu	a5,s11,s4
8000c3f4:	40f40433          	sub	s0,s0,a5
8000c3f8:	fff00813          	li	a6,-1
8000c3fc:	1a8b8063          	beq	s7,s0,8000c59c <__divdf3+0x5c8>
8000c400:	000a8593          	mv	a1,s5
8000c404:	00040513          	mv	a0,s0
8000c408:	5c8010ef          	jal	ra,8000d9d0 <__udivsi3>
8000c40c:	00050593          	mv	a1,a0
8000c410:	00a12623          	sw	a0,12(sp)
8000c414:	000b0513          	mv	a0,s6
8000c418:	58c010ef          	jal	ra,8000d9a4 <__mulsi3>
8000c41c:	00a12423          	sw	a0,8(sp)
8000c420:	000a8593          	mv	a1,s5
8000c424:	00040513          	mv	a0,s0
8000c428:	5f0010ef          	jal	ra,8000da18 <__umodsi3>
8000c42c:	00c12683          	lw	a3,12(sp)
8000c430:	00812703          	lw	a4,8(sp)
8000c434:	01051513          	slli	a0,a0,0x10
8000c438:	010a5793          	srli	a5,s4,0x10
8000c43c:	00a7e533          	or	a0,a5,a0
8000c440:	00068d93          	mv	s11,a3
8000c444:	00e57e63          	bgeu	a0,a4,8000c460 <__divdf3+0x48c>
8000c448:	01750533          	add	a0,a0,s7
8000c44c:	fff68d93          	addi	s11,a3,-1
8000c450:	01756863          	bltu	a0,s7,8000c460 <__divdf3+0x48c>
8000c454:	00e57663          	bgeu	a0,a4,8000c460 <__divdf3+0x48c>
8000c458:	ffe68d93          	addi	s11,a3,-2
8000c45c:	01750533          	add	a0,a0,s7
8000c460:	40e50433          	sub	s0,a0,a4
8000c464:	000a8593          	mv	a1,s5
8000c468:	00040513          	mv	a0,s0
8000c46c:	564010ef          	jal	ra,8000d9d0 <__udivsi3>
8000c470:	00050593          	mv	a1,a0
8000c474:	00a12423          	sw	a0,8(sp)
8000c478:	000b0513          	mv	a0,s6
8000c47c:	528010ef          	jal	ra,8000d9a4 <__mulsi3>
8000c480:	00050b13          	mv	s6,a0
8000c484:	000a8593          	mv	a1,s5
8000c488:	00040513          	mv	a0,s0
8000c48c:	58c010ef          	jal	ra,8000da18 <__umodsi3>
8000c490:	010a1a13          	slli	s4,s4,0x10
8000c494:	00812703          	lw	a4,8(sp)
8000c498:	01051513          	slli	a0,a0,0x10
8000c49c:	010a5a13          	srli	s4,s4,0x10
8000c4a0:	00aa6533          	or	a0,s4,a0
8000c4a4:	00070793          	mv	a5,a4
8000c4a8:	01657e63          	bgeu	a0,s6,8000c4c4 <__divdf3+0x4f0>
8000c4ac:	01750533          	add	a0,a0,s7
8000c4b0:	fff70793          	addi	a5,a4,-1
8000c4b4:	01756863          	bltu	a0,s7,8000c4c4 <__divdf3+0x4f0>
8000c4b8:	01657663          	bgeu	a0,s6,8000c4c4 <__divdf3+0x4f0>
8000c4bc:	ffe70793          	addi	a5,a4,-2
8000c4c0:	01750533          	add	a0,a0,s7
8000c4c4:	010d9893          	slli	a7,s11,0x10
8000c4c8:	00f8e8b3          	or	a7,a7,a5
8000c4cc:	01089713          	slli	a4,a7,0x10
8000c4d0:	01075713          	srli	a4,a4,0x10
8000c4d4:	41650333          	sub	t1,a0,s6
8000c4d8:	0108d793          	srli	a5,a7,0x10
8000c4dc:	00070513          	mv	a0,a4
8000c4e0:	000c8593          	mv	a1,s9
8000c4e4:	4c0010ef          	jal	ra,8000d9a4 <__mulsi3>
8000c4e8:	00050813          	mv	a6,a0
8000c4ec:	000d0593          	mv	a1,s10
8000c4f0:	00070513          	mv	a0,a4
8000c4f4:	4b0010ef          	jal	ra,8000d9a4 <__mulsi3>
8000c4f8:	00050713          	mv	a4,a0
8000c4fc:	000c8593          	mv	a1,s9
8000c500:	00078513          	mv	a0,a5
8000c504:	4a0010ef          	jal	ra,8000d9a4 <__mulsi3>
8000c508:	00050e13          	mv	t3,a0
8000c50c:	000d0593          	mv	a1,s10
8000c510:	00078513          	mv	a0,a5
8000c514:	490010ef          	jal	ra,8000d9a4 <__mulsi3>
8000c518:	01085793          	srli	a5,a6,0x10
8000c51c:	01c70733          	add	a4,a4,t3
8000c520:	00e787b3          	add	a5,a5,a4
8000c524:	01c7f663          	bgeu	a5,t3,8000c530 <__divdf3+0x55c>
8000c528:	00010737          	lui	a4,0x10
8000c52c:	00e50533          	add	a0,a0,a4
8000c530:	00010637          	lui	a2,0x10
8000c534:	fff60613          	addi	a2,a2,-1 # ffff <crtStart-0x7fff0001>
8000c538:	0107d693          	srli	a3,a5,0x10
8000c53c:	00c7f733          	and	a4,a5,a2
8000c540:	01071713          	slli	a4,a4,0x10
8000c544:	00c87833          	and	a6,a6,a2
8000c548:	00a686b3          	add	a3,a3,a0
8000c54c:	01070733          	add	a4,a4,a6
8000c550:	00d36863          	bltu	t1,a3,8000c560 <__divdf3+0x58c>
8000c554:	24d31463          	bne	t1,a3,8000c79c <__divdf3+0x7c8>
8000c558:	00088813          	mv	a6,a7
8000c55c:	04070063          	beqz	a4,8000c59c <__divdf3+0x5c8>
8000c560:	006b8533          	add	a0,s7,t1
8000c564:	fff88813          	addi	a6,a7,-1
8000c568:	03756463          	bltu	a0,s7,8000c590 <__divdf3+0x5bc>
8000c56c:	00d56663          	bltu	a0,a3,8000c578 <__divdf3+0x5a4>
8000c570:	22d51463          	bne	a0,a3,8000c798 <__divdf3+0x7c4>
8000c574:	02ec7063          	bgeu	s8,a4,8000c594 <__divdf3+0x5c0>
8000c578:	001c1793          	slli	a5,s8,0x1
8000c57c:	0187bc33          	sltu	s8,a5,s8
8000c580:	017c0bb3          	add	s7,s8,s7
8000c584:	ffe88813          	addi	a6,a7,-2
8000c588:	01750533          	add	a0,a0,s7
8000c58c:	00078c13          	mv	s8,a5
8000c590:	00d51463          	bne	a0,a3,8000c598 <__divdf3+0x5c4>
8000c594:	00ec0463          	beq	s8,a4,8000c59c <__divdf3+0x5c8>
8000c598:	00186813          	ori	a6,a6,1
8000c59c:	3ff98713          	addi	a4,s3,1023
8000c5a0:	10e05a63          	blez	a4,8000c6b4 <__divdf3+0x6e0>
8000c5a4:	00787793          	andi	a5,a6,7
8000c5a8:	02078063          	beqz	a5,8000c5c8 <__divdf3+0x5f4>
8000c5ac:	00f87793          	andi	a5,a6,15
8000c5b0:	00400693          	li	a3,4
8000c5b4:	00d78a63          	beq	a5,a3,8000c5c8 <__divdf3+0x5f4>
8000c5b8:	00480693          	addi	a3,a6,4
8000c5bc:	0106b833          	sltu	a6,a3,a6
8000c5c0:	01090933          	add	s2,s2,a6
8000c5c4:	00068813          	mv	a6,a3
8000c5c8:	00791793          	slli	a5,s2,0x7
8000c5cc:	0007da63          	bgez	a5,8000c5e0 <__divdf3+0x60c>
8000c5d0:	ff0007b7          	lui	a5,0xff000
8000c5d4:	fff78793          	addi	a5,a5,-1 # feffffff <STACK_TOP+0x7efdffff>
8000c5d8:	00f97933          	and	s2,s2,a5
8000c5dc:	40098713          	addi	a4,s3,1024
8000c5e0:	7fe00793          	li	a5,2046
8000c5e4:	18e7ca63          	blt	a5,a4,8000c778 <__divdf3+0x7a4>
8000c5e8:	00385813          	srli	a6,a6,0x3
8000c5ec:	01d91793          	slli	a5,s2,0x1d
8000c5f0:	0107e7b3          	or	a5,a5,a6
8000c5f4:	00395513          	srli	a0,s2,0x3
8000c5f8:	00c51513          	slli	a0,a0,0xc
8000c5fc:	7ff77713          	andi	a4,a4,2047
8000c600:	01471713          	slli	a4,a4,0x14
8000c604:	04c12083          	lw	ra,76(sp)
8000c608:	04812403          	lw	s0,72(sp)
8000c60c:	00c55513          	srli	a0,a0,0xc
8000c610:	01f49493          	slli	s1,s1,0x1f
8000c614:	00e56533          	or	a0,a0,a4
8000c618:	00956733          	or	a4,a0,s1
8000c61c:	04012903          	lw	s2,64(sp)
8000c620:	04412483          	lw	s1,68(sp)
8000c624:	03c12983          	lw	s3,60(sp)
8000c628:	03812a03          	lw	s4,56(sp)
8000c62c:	03412a83          	lw	s5,52(sp)
8000c630:	03012b03          	lw	s6,48(sp)
8000c634:	02c12b83          	lw	s7,44(sp)
8000c638:	02812c03          	lw	s8,40(sp)
8000c63c:	02412c83          	lw	s9,36(sp)
8000c640:	02012d03          	lw	s10,32(sp)
8000c644:	01c12d83          	lw	s11,28(sp)
8000c648:	00078513          	mv	a0,a5
8000c64c:	00070593          	mv	a1,a4
8000c650:	05010113          	addi	sp,sp,80
8000c654:	00008067          	ret
8000c658:	fff98993          	addi	s3,s3,-1
8000c65c:	00000d93          	li	s11,0
8000c660:	bd1ff06f          	j	8000c230 <__divdf3+0x25c>
8000c664:	000a8493          	mv	s1,s5
8000c668:	000c8913          	mv	s2,s9
8000c66c:	00040813          	mv	a6,s0
8000c670:	000c0793          	mv	a5,s8
8000c674:	00200713          	li	a4,2
8000c678:	10e78063          	beq	a5,a4,8000c778 <__divdf3+0x7a4>
8000c67c:	00300713          	li	a4,3
8000c680:	0ee78263          	beq	a5,a4,8000c764 <__divdf3+0x790>
8000c684:	00100713          	li	a4,1
8000c688:	f0e79ae3          	bne	a5,a4,8000c59c <__divdf3+0x5c8>
8000c68c:	00000513          	li	a0,0
8000c690:	00000793          	li	a5,0
8000c694:	0940006f          	j	8000c728 <__divdf3+0x754>
8000c698:	000b0493          	mv	s1,s6
8000c69c:	fd9ff06f          	j	8000c674 <__divdf3+0x6a0>
8000c6a0:	00080937          	lui	s2,0x80
8000c6a4:	00000813          	li	a6,0
8000c6a8:	00000493          	li	s1,0
8000c6ac:	00300793          	li	a5,3
8000c6b0:	fc5ff06f          	j	8000c674 <__divdf3+0x6a0>
8000c6b4:	00100513          	li	a0,1
8000c6b8:	40e50533          	sub	a0,a0,a4
8000c6bc:	03800793          	li	a5,56
8000c6c0:	fca7c6e3          	blt	a5,a0,8000c68c <__divdf3+0x6b8>
8000c6c4:	01f00793          	li	a5,31
8000c6c8:	06a7c463          	blt	a5,a0,8000c730 <__divdf3+0x75c>
8000c6cc:	41e98993          	addi	s3,s3,1054
8000c6d0:	013917b3          	sll	a5,s2,s3
8000c6d4:	00a85733          	srl	a4,a6,a0
8000c6d8:	013819b3          	sll	s3,a6,s3
8000c6dc:	00e7e7b3          	or	a5,a5,a4
8000c6e0:	013039b3          	snez	s3,s3
8000c6e4:	0137e7b3          	or	a5,a5,s3
8000c6e8:	00a95533          	srl	a0,s2,a0
8000c6ec:	0077f713          	andi	a4,a5,7
8000c6f0:	02070063          	beqz	a4,8000c710 <__divdf3+0x73c>
8000c6f4:	00f7f713          	andi	a4,a5,15
8000c6f8:	00400693          	li	a3,4
8000c6fc:	00d70a63          	beq	a4,a3,8000c710 <__divdf3+0x73c>
8000c700:	00478713          	addi	a4,a5,4
8000c704:	00f737b3          	sltu	a5,a4,a5
8000c708:	00f50533          	add	a0,a0,a5
8000c70c:	00070793          	mv	a5,a4
8000c710:	00851713          	slli	a4,a0,0x8
8000c714:	06074a63          	bltz	a4,8000c788 <__divdf3+0x7b4>
8000c718:	01d51713          	slli	a4,a0,0x1d
8000c71c:	0037d793          	srli	a5,a5,0x3
8000c720:	00f767b3          	or	a5,a4,a5
8000c724:	00355513          	srli	a0,a0,0x3
8000c728:	00000713          	li	a4,0
8000c72c:	ecdff06f          	j	8000c5f8 <__divdf3+0x624>
8000c730:	fe100793          	li	a5,-31
8000c734:	40e787b3          	sub	a5,a5,a4
8000c738:	02000693          	li	a3,32
8000c73c:	00f957b3          	srl	a5,s2,a5
8000c740:	00000713          	li	a4,0
8000c744:	00d50663          	beq	a0,a3,8000c750 <__divdf3+0x77c>
8000c748:	43e98993          	addi	s3,s3,1086
8000c74c:	01391733          	sll	a4,s2,s3
8000c750:	01076833          	or	a6,a4,a6
8000c754:	01003833          	snez	a6,a6
8000c758:	0107e7b3          	or	a5,a5,a6
8000c75c:	00000513          	li	a0,0
8000c760:	f8dff06f          	j	8000c6ec <__divdf3+0x718>
8000c764:	00080537          	lui	a0,0x80
8000c768:	00000793          	li	a5,0
8000c76c:	7ff00713          	li	a4,2047
8000c770:	00000493          	li	s1,0
8000c774:	e85ff06f          	j	8000c5f8 <__divdf3+0x624>
8000c778:	00000513          	li	a0,0
8000c77c:	00000793          	li	a5,0
8000c780:	7ff00713          	li	a4,2047
8000c784:	e75ff06f          	j	8000c5f8 <__divdf3+0x624>
8000c788:	00000513          	li	a0,0
8000c78c:	00000793          	li	a5,0
8000c790:	00100713          	li	a4,1
8000c794:	e65ff06f          	j	8000c5f8 <__divdf3+0x624>
8000c798:	00080893          	mv	a7,a6
8000c79c:	00088813          	mv	a6,a7
8000c7a0:	df9ff06f          	j	8000c598 <__divdf3+0x5c4>

8000c7a4 <__eqdf2>:
8000c7a4:	0145d713          	srli	a4,a1,0x14
8000c7a8:	001007b7          	lui	a5,0x100
8000c7ac:	fff78793          	addi	a5,a5,-1 # fffff <crtStart-0x7ff00001>
8000c7b0:	0146d813          	srli	a6,a3,0x14
8000c7b4:	00050313          	mv	t1,a0
8000c7b8:	00050e93          	mv	t4,a0
8000c7bc:	7ff77713          	andi	a4,a4,2047
8000c7c0:	7ff00513          	li	a0,2047
8000c7c4:	00b7f8b3          	and	a7,a5,a1
8000c7c8:	00060f13          	mv	t5,a2
8000c7cc:	00d7f7b3          	and	a5,a5,a3
8000c7d0:	01f5d593          	srli	a1,a1,0x1f
8000c7d4:	7ff87813          	andi	a6,a6,2047
8000c7d8:	01f6d693          	srli	a3,a3,0x1f
8000c7dc:	00a71c63          	bne	a4,a0,8000c7f4 <__eqdf2+0x50>
8000c7e0:	0068ee33          	or	t3,a7,t1
8000c7e4:	00100513          	li	a0,1
8000c7e8:	000e1463          	bnez	t3,8000c7f0 <__eqdf2+0x4c>
8000c7ec:	00e80663          	beq	a6,a4,8000c7f8 <__eqdf2+0x54>
8000c7f0:	00008067          	ret
8000c7f4:	00a81863          	bne	a6,a0,8000c804 <__eqdf2+0x60>
8000c7f8:	00c7e633          	or	a2,a5,a2
8000c7fc:	00100513          	li	a0,1
8000c800:	fe0618e3          	bnez	a2,8000c7f0 <__eqdf2+0x4c>
8000c804:	00100513          	li	a0,1
8000c808:	ff0714e3          	bne	a4,a6,8000c7f0 <__eqdf2+0x4c>
8000c80c:	fef892e3          	bne	a7,a5,8000c7f0 <__eqdf2+0x4c>
8000c810:	ffee90e3          	bne	t4,t5,8000c7f0 <__eqdf2+0x4c>
8000c814:	00d58a63          	beq	a1,a3,8000c828 <__eqdf2+0x84>
8000c818:	fc071ce3          	bnez	a4,8000c7f0 <__eqdf2+0x4c>
8000c81c:	0068e533          	or	a0,a7,t1
8000c820:	00a03533          	snez	a0,a0
8000c824:	00008067          	ret
8000c828:	00000513          	li	a0,0
8000c82c:	00008067          	ret

8000c830 <__gedf2>:
8000c830:	0145d813          	srli	a6,a1,0x14
8000c834:	001007b7          	lui	a5,0x100
8000c838:	fff78793          	addi	a5,a5,-1 # fffff <crtStart-0x7ff00001>
8000c83c:	0146d713          	srli	a4,a3,0x14
8000c840:	7ff87813          	andi	a6,a6,2047
8000c844:	7ff00e93          	li	t4,2047
8000c848:	00b7f8b3          	and	a7,a5,a1
8000c84c:	00050313          	mv	t1,a0
8000c850:	00d7f7b3          	and	a5,a5,a3
8000c854:	01f5d593          	srli	a1,a1,0x1f
8000c858:	00060e13          	mv	t3,a2
8000c85c:	7ff77713          	andi	a4,a4,2047
8000c860:	01f6d693          	srli	a3,a3,0x1f
8000c864:	01d81a63          	bne	a6,t4,8000c878 <__gedf2+0x48>
8000c868:	00a8eeb3          	or	t4,a7,a0
8000c86c:	080e8c63          	beqz	t4,8000c904 <__gedf2+0xd4>
8000c870:	ffe00593          	li	a1,-2
8000c874:	0480006f          	j	8000c8bc <__gedf2+0x8c>
8000c878:	01d71663          	bne	a4,t4,8000c884 <__gedf2+0x54>
8000c87c:	00c7eeb3          	or	t4,a5,a2
8000c880:	fe0e98e3          	bnez	t4,8000c870 <__gedf2+0x40>
8000c884:	08081263          	bnez	a6,8000c908 <__gedf2+0xd8>
8000c888:	00a8e533          	or	a0,a7,a0
8000c88c:	00153513          	seqz	a0,a0
8000c890:	00071663          	bnez	a4,8000c89c <__gedf2+0x6c>
8000c894:	00c7e633          	or	a2,a5,a2
8000c898:	04060e63          	beqz	a2,8000c8f4 <__gedf2+0xc4>
8000c89c:	00051a63          	bnez	a0,8000c8b0 <__gedf2+0x80>
8000c8a0:	02d58263          	beq	a1,a3,8000c8c4 <__gedf2+0x94>
8000c8a4:	04058463          	beqz	a1,8000c8ec <__gedf2+0xbc>
8000c8a8:	fff00593          	li	a1,-1
8000c8ac:	0100006f          	j	8000c8bc <__gedf2+0x8c>
8000c8b0:	fff00593          	li	a1,-1
8000c8b4:	00068463          	beqz	a3,8000c8bc <__gedf2+0x8c>
8000c8b8:	00068593          	mv	a1,a3
8000c8bc:	00058513          	mv	a0,a1
8000c8c0:	00008067          	ret
8000c8c4:	ff0740e3          	blt	a4,a6,8000c8a4 <__gedf2+0x74>
8000c8c8:	00e85663          	bge	a6,a4,8000c8d4 <__gedf2+0xa4>
8000c8cc:	fe0598e3          	bnez	a1,8000c8bc <__gedf2+0x8c>
8000c8d0:	fd9ff06f          	j	8000c8a8 <__gedf2+0x78>
8000c8d4:	fd17e8e3          	bltu	a5,a7,8000c8a4 <__gedf2+0x74>
8000c8d8:	02f89263          	bne	a7,a5,8000c8fc <__gedf2+0xcc>
8000c8dc:	fc6e64e3          	bltu	t3,t1,8000c8a4 <__gedf2+0x74>
8000c8e0:	ffc366e3          	bltu	t1,t3,8000c8cc <__gedf2+0x9c>
8000c8e4:	00000593          	li	a1,0
8000c8e8:	fd5ff06f          	j	8000c8bc <__gedf2+0x8c>
8000c8ec:	00100593          	li	a1,1
8000c8f0:	fcdff06f          	j	8000c8bc <__gedf2+0x8c>
8000c8f4:	fe0518e3          	bnez	a0,8000c8e4 <__gedf2+0xb4>
8000c8f8:	fadff06f          	j	8000c8a4 <__gedf2+0x74>
8000c8fc:	fcf8e8e3          	bltu	a7,a5,8000c8cc <__gedf2+0x9c>
8000c900:	fe5ff06f          	j	8000c8e4 <__gedf2+0xb4>
8000c904:	f7070ce3          	beq	a4,a6,8000c87c <__gedf2+0x4c>
8000c908:	f8071ce3          	bnez	a4,8000c8a0 <__gedf2+0x70>
8000c90c:	00000513          	li	a0,0
8000c910:	f85ff06f          	j	8000c894 <__gedf2+0x64>

8000c914 <__ledf2>:
8000c914:	0145d813          	srli	a6,a1,0x14
8000c918:	001007b7          	lui	a5,0x100
8000c91c:	fff78793          	addi	a5,a5,-1 # fffff <crtStart-0x7ff00001>
8000c920:	0146d713          	srli	a4,a3,0x14
8000c924:	7ff87813          	andi	a6,a6,2047
8000c928:	7ff00e93          	li	t4,2047
8000c92c:	00b7f8b3          	and	a7,a5,a1
8000c930:	00050313          	mv	t1,a0
8000c934:	00d7f7b3          	and	a5,a5,a3
8000c938:	01f5d593          	srli	a1,a1,0x1f
8000c93c:	00060e13          	mv	t3,a2
8000c940:	7ff77713          	andi	a4,a4,2047
8000c944:	01f6d693          	srli	a3,a3,0x1f
8000c948:	01d81a63          	bne	a6,t4,8000c95c <__ledf2+0x48>
8000c94c:	00a8eeb3          	or	t4,a7,a0
8000c950:	080e8c63          	beqz	t4,8000c9e8 <__ledf2+0xd4>
8000c954:	00200593          	li	a1,2
8000c958:	0480006f          	j	8000c9a0 <__ledf2+0x8c>
8000c95c:	01d71663          	bne	a4,t4,8000c968 <__ledf2+0x54>
8000c960:	00c7eeb3          	or	t4,a5,a2
8000c964:	fe0e98e3          	bnez	t4,8000c954 <__ledf2+0x40>
8000c968:	08081263          	bnez	a6,8000c9ec <__ledf2+0xd8>
8000c96c:	00a8e533          	or	a0,a7,a0
8000c970:	00153513          	seqz	a0,a0
8000c974:	00071663          	bnez	a4,8000c980 <__ledf2+0x6c>
8000c978:	00c7e633          	or	a2,a5,a2
8000c97c:	04060e63          	beqz	a2,8000c9d8 <__ledf2+0xc4>
8000c980:	00051a63          	bnez	a0,8000c994 <__ledf2+0x80>
8000c984:	02d58263          	beq	a1,a3,8000c9a8 <__ledf2+0x94>
8000c988:	04058463          	beqz	a1,8000c9d0 <__ledf2+0xbc>
8000c98c:	fff00593          	li	a1,-1
8000c990:	0100006f          	j	8000c9a0 <__ledf2+0x8c>
8000c994:	fff00593          	li	a1,-1
8000c998:	00068463          	beqz	a3,8000c9a0 <__ledf2+0x8c>
8000c99c:	00068593          	mv	a1,a3
8000c9a0:	00058513          	mv	a0,a1
8000c9a4:	00008067          	ret
8000c9a8:	ff0740e3          	blt	a4,a6,8000c988 <__ledf2+0x74>
8000c9ac:	00e85663          	bge	a6,a4,8000c9b8 <__ledf2+0xa4>
8000c9b0:	fe0598e3          	bnez	a1,8000c9a0 <__ledf2+0x8c>
8000c9b4:	fd9ff06f          	j	8000c98c <__ledf2+0x78>
8000c9b8:	fd17e8e3          	bltu	a5,a7,8000c988 <__ledf2+0x74>
8000c9bc:	02f89263          	bne	a7,a5,8000c9e0 <__ledf2+0xcc>
8000c9c0:	fc6e64e3          	bltu	t3,t1,8000c988 <__ledf2+0x74>
8000c9c4:	ffc366e3          	bltu	t1,t3,8000c9b0 <__ledf2+0x9c>
8000c9c8:	00000593          	li	a1,0
8000c9cc:	fd5ff06f          	j	8000c9a0 <__ledf2+0x8c>
8000c9d0:	00100593          	li	a1,1
8000c9d4:	fcdff06f          	j	8000c9a0 <__ledf2+0x8c>
8000c9d8:	fe0518e3          	bnez	a0,8000c9c8 <__ledf2+0xb4>
8000c9dc:	fadff06f          	j	8000c988 <__ledf2+0x74>
8000c9e0:	fcf8e8e3          	bltu	a7,a5,8000c9b0 <__ledf2+0x9c>
8000c9e4:	fe5ff06f          	j	8000c9c8 <__ledf2+0xb4>
8000c9e8:	f7070ce3          	beq	a4,a6,8000c960 <__ledf2+0x4c>
8000c9ec:	f8071ce3          	bnez	a4,8000c984 <__ledf2+0x70>
8000c9f0:	00000513          	li	a0,0
8000c9f4:	f85ff06f          	j	8000c978 <__ledf2+0x64>

8000c9f8 <__muldf3>:
8000c9f8:	fd010113          	addi	sp,sp,-48
8000c9fc:	01312e23          	sw	s3,28(sp)
8000ca00:	0145d993          	srli	s3,a1,0x14
8000ca04:	02812423          	sw	s0,40(sp)
8000ca08:	02912223          	sw	s1,36(sp)
8000ca0c:	01412c23          	sw	s4,24(sp)
8000ca10:	01512a23          	sw	s5,20(sp)
8000ca14:	01612823          	sw	s6,16(sp)
8000ca18:	00c59493          	slli	s1,a1,0xc
8000ca1c:	02112623          	sw	ra,44(sp)
8000ca20:	03212023          	sw	s2,32(sp)
8000ca24:	01712623          	sw	s7,12(sp)
8000ca28:	7ff9f993          	andi	s3,s3,2047
8000ca2c:	00050413          	mv	s0,a0
8000ca30:	00060b13          	mv	s6,a2
8000ca34:	00068a93          	mv	s5,a3
8000ca38:	00c4d493          	srli	s1,s1,0xc
8000ca3c:	01f5da13          	srli	s4,a1,0x1f
8000ca40:	0a098463          	beqz	s3,8000cae8 <__muldf3+0xf0>
8000ca44:	7ff00793          	li	a5,2047
8000ca48:	10f98263          	beq	s3,a5,8000cb4c <__muldf3+0x154>
8000ca4c:	01d55793          	srli	a5,a0,0x1d
8000ca50:	00349493          	slli	s1,s1,0x3
8000ca54:	0097e4b3          	or	s1,a5,s1
8000ca58:	008007b7          	lui	a5,0x800
8000ca5c:	00f4e4b3          	or	s1,s1,a5
8000ca60:	00351913          	slli	s2,a0,0x3
8000ca64:	c0198993          	addi	s3,s3,-1023
8000ca68:	00000b93          	li	s7,0
8000ca6c:	014ad513          	srli	a0,s5,0x14
8000ca70:	00ca9413          	slli	s0,s5,0xc
8000ca74:	7ff57513          	andi	a0,a0,2047
8000ca78:	00c45413          	srli	s0,s0,0xc
8000ca7c:	01fada93          	srli	s5,s5,0x1f
8000ca80:	10050263          	beqz	a0,8000cb84 <__muldf3+0x18c>
8000ca84:	7ff00793          	li	a5,2047
8000ca88:	16f50263          	beq	a0,a5,8000cbec <__muldf3+0x1f4>
8000ca8c:	01db5793          	srli	a5,s6,0x1d
8000ca90:	00341413          	slli	s0,s0,0x3
8000ca94:	0087e433          	or	s0,a5,s0
8000ca98:	008007b7          	lui	a5,0x800
8000ca9c:	00f46433          	or	s0,s0,a5
8000caa0:	c0150513          	addi	a0,a0,-1023 # 7fc01 <crtStart-0x7ff803ff>
8000caa4:	003b1793          	slli	a5,s6,0x3
8000caa8:	00000713          	li	a4,0
8000caac:	002b9693          	slli	a3,s7,0x2
8000cab0:	00e6e6b3          	or	a3,a3,a4
8000cab4:	00a989b3          	add	s3,s3,a0
8000cab8:	fff68693          	addi	a3,a3,-1
8000cabc:	00e00613          	li	a2,14
8000cac0:	015a4833          	xor	a6,s4,s5
8000cac4:	00198893          	addi	a7,s3,1
8000cac8:	14d66e63          	bltu	a2,a3,8000cc24 <__muldf3+0x22c>
8000cacc:	00002617          	auipc	a2,0x2
8000cad0:	e8860613          	addi	a2,a2,-376 # 8000e954 <cvt2.1234+0xf8>
8000cad4:	00269693          	slli	a3,a3,0x2
8000cad8:	00c686b3          	add	a3,a3,a2
8000cadc:	0006a683          	lw	a3,0(a3)
8000cae0:	00c686b3          	add	a3,a3,a2
8000cae4:	00068067          	jr	a3
8000cae8:	00a4e933          	or	s2,s1,a0
8000caec:	06090c63          	beqz	s2,8000cb64 <__muldf3+0x16c>
8000caf0:	04048063          	beqz	s1,8000cb30 <__muldf3+0x138>
8000caf4:	00048513          	mv	a0,s1
8000caf8:	785000ef          	jal	ra,8000da7c <__clzsi2>
8000cafc:	ff550713          	addi	a4,a0,-11
8000cb00:	01c00793          	li	a5,28
8000cb04:	02e7cc63          	blt	a5,a4,8000cb3c <__muldf3+0x144>
8000cb08:	01d00793          	li	a5,29
8000cb0c:	ff850913          	addi	s2,a0,-8
8000cb10:	40e787b3          	sub	a5,a5,a4
8000cb14:	012494b3          	sll	s1,s1,s2
8000cb18:	00f457b3          	srl	a5,s0,a5
8000cb1c:	0097e4b3          	or	s1,a5,s1
8000cb20:	01241933          	sll	s2,s0,s2
8000cb24:	c0d00993          	li	s3,-1011
8000cb28:	40a989b3          	sub	s3,s3,a0
8000cb2c:	f3dff06f          	j	8000ca68 <__muldf3+0x70>
8000cb30:	74d000ef          	jal	ra,8000da7c <__clzsi2>
8000cb34:	02050513          	addi	a0,a0,32
8000cb38:	fc5ff06f          	j	8000cafc <__muldf3+0x104>
8000cb3c:	fd850493          	addi	s1,a0,-40
8000cb40:	009414b3          	sll	s1,s0,s1
8000cb44:	00000913          	li	s2,0
8000cb48:	fddff06f          	j	8000cb24 <__muldf3+0x12c>
8000cb4c:	00a4e933          	or	s2,s1,a0
8000cb50:	02090263          	beqz	s2,8000cb74 <__muldf3+0x17c>
8000cb54:	00050913          	mv	s2,a0
8000cb58:	7ff00993          	li	s3,2047
8000cb5c:	00300b93          	li	s7,3
8000cb60:	f0dff06f          	j	8000ca6c <__muldf3+0x74>
8000cb64:	00000493          	li	s1,0
8000cb68:	00000993          	li	s3,0
8000cb6c:	00100b93          	li	s7,1
8000cb70:	efdff06f          	j	8000ca6c <__muldf3+0x74>
8000cb74:	00000493          	li	s1,0
8000cb78:	7ff00993          	li	s3,2047
8000cb7c:	00200b93          	li	s7,2
8000cb80:	eedff06f          	j	8000ca6c <__muldf3+0x74>
8000cb84:	016467b3          	or	a5,s0,s6
8000cb88:	06078e63          	beqz	a5,8000cc04 <__muldf3+0x20c>
8000cb8c:	04040063          	beqz	s0,8000cbcc <__muldf3+0x1d4>
8000cb90:	00040513          	mv	a0,s0
8000cb94:	6e9000ef          	jal	ra,8000da7c <__clzsi2>
8000cb98:	ff550693          	addi	a3,a0,-11
8000cb9c:	01c00793          	li	a5,28
8000cba0:	02d7ce63          	blt	a5,a3,8000cbdc <__muldf3+0x1e4>
8000cba4:	01d00713          	li	a4,29
8000cba8:	ff850793          	addi	a5,a0,-8
8000cbac:	40d70733          	sub	a4,a4,a3
8000cbb0:	00f41433          	sll	s0,s0,a5
8000cbb4:	00eb5733          	srl	a4,s6,a4
8000cbb8:	00876433          	or	s0,a4,s0
8000cbbc:	00fb17b3          	sll	a5,s6,a5
8000cbc0:	c0d00713          	li	a4,-1011
8000cbc4:	40a70533          	sub	a0,a4,a0
8000cbc8:	ee1ff06f          	j	8000caa8 <__muldf3+0xb0>
8000cbcc:	000b0513          	mv	a0,s6
8000cbd0:	6ad000ef          	jal	ra,8000da7c <__clzsi2>
8000cbd4:	02050513          	addi	a0,a0,32
8000cbd8:	fc1ff06f          	j	8000cb98 <__muldf3+0x1a0>
8000cbdc:	fd850413          	addi	s0,a0,-40
8000cbe0:	008b1433          	sll	s0,s6,s0
8000cbe4:	00000793          	li	a5,0
8000cbe8:	fd9ff06f          	j	8000cbc0 <__muldf3+0x1c8>
8000cbec:	016467b3          	or	a5,s0,s6
8000cbf0:	02078263          	beqz	a5,8000cc14 <__muldf3+0x21c>
8000cbf4:	000b0793          	mv	a5,s6
8000cbf8:	7ff00513          	li	a0,2047
8000cbfc:	00300713          	li	a4,3
8000cc00:	eadff06f          	j	8000caac <__muldf3+0xb4>
8000cc04:	00000413          	li	s0,0
8000cc08:	00000513          	li	a0,0
8000cc0c:	00100713          	li	a4,1
8000cc10:	e9dff06f          	j	8000caac <__muldf3+0xb4>
8000cc14:	00000413          	li	s0,0
8000cc18:	7ff00513          	li	a0,2047
8000cc1c:	00200713          	li	a4,2
8000cc20:	e8dff06f          	j	8000caac <__muldf3+0xb4>
8000cc24:	000102b7          	lui	t0,0x10
8000cc28:	fff28313          	addi	t1,t0,-1 # ffff <crtStart-0x7fff0001>
8000cc2c:	01095f13          	srli	t5,s2,0x10
8000cc30:	0107df93          	srli	t6,a5,0x10
8000cc34:	00697933          	and	s2,s2,t1
8000cc38:	0067f7b3          	and	a5,a5,t1
8000cc3c:	00090513          	mv	a0,s2
8000cc40:	00078593          	mv	a1,a5
8000cc44:	561000ef          	jal	ra,8000d9a4 <__mulsi3>
8000cc48:	00050e93          	mv	t4,a0
8000cc4c:	000f8593          	mv	a1,t6
8000cc50:	00090513          	mv	a0,s2
8000cc54:	551000ef          	jal	ra,8000d9a4 <__mulsi3>
8000cc58:	00050e13          	mv	t3,a0
8000cc5c:	00078593          	mv	a1,a5
8000cc60:	000f0513          	mv	a0,t5
8000cc64:	541000ef          	jal	ra,8000d9a4 <__mulsi3>
8000cc68:	00050a13          	mv	s4,a0
8000cc6c:	000f8593          	mv	a1,t6
8000cc70:	000f0513          	mv	a0,t5
8000cc74:	531000ef          	jal	ra,8000d9a4 <__mulsi3>
8000cc78:	010ed713          	srli	a4,t4,0x10
8000cc7c:	014e0e33          	add	t3,t3,s4
8000cc80:	01c70733          	add	a4,a4,t3
8000cc84:	00050393          	mv	t2,a0
8000cc88:	01477463          	bgeu	a4,s4,8000cc90 <__muldf3+0x298>
8000cc8c:	005503b3          	add	t2,a0,t0
8000cc90:	00677e33          	and	t3,a4,t1
8000cc94:	006efeb3          	and	t4,t4,t1
8000cc98:	01045a13          	srli	s4,s0,0x10
8000cc9c:	010e1e13          	slli	t3,t3,0x10
8000cca0:	00647433          	and	s0,s0,t1
8000cca4:	01075293          	srli	t0,a4,0x10
8000cca8:	01de0e33          	add	t3,t3,t4
8000ccac:	00090513          	mv	a0,s2
8000ccb0:	00040593          	mv	a1,s0
8000ccb4:	4f1000ef          	jal	ra,8000d9a4 <__mulsi3>
8000ccb8:	00050e93          	mv	t4,a0
8000ccbc:	000a0593          	mv	a1,s4
8000ccc0:	00090513          	mv	a0,s2
8000ccc4:	4e1000ef          	jal	ra,8000d9a4 <__mulsi3>
8000ccc8:	00050713          	mv	a4,a0
8000cccc:	00040593          	mv	a1,s0
8000ccd0:	000f0513          	mv	a0,t5
8000ccd4:	4d1000ef          	jal	ra,8000d9a4 <__mulsi3>
8000ccd8:	00050313          	mv	t1,a0
8000ccdc:	000a0593          	mv	a1,s4
8000cce0:	000f0513          	mv	a0,t5
8000cce4:	4c1000ef          	jal	ra,8000d9a4 <__mulsi3>
8000cce8:	010ed693          	srli	a3,t4,0x10
8000ccec:	00670733          	add	a4,a4,t1
8000ccf0:	00e686b3          	add	a3,a3,a4
8000ccf4:	0066f663          	bgeu	a3,t1,8000cd00 <__muldf3+0x308>
8000ccf8:	00010737          	lui	a4,0x10
8000ccfc:	00e50533          	add	a0,a0,a4
8000cd00:	00010ab7          	lui	s5,0x10
8000cd04:	fffa8613          	addi	a2,s5,-1 # ffff <crtStart-0x7fff0001>
8000cd08:	0106d713          	srli	a4,a3,0x10
8000cd0c:	00c6f6b3          	and	a3,a3,a2
8000cd10:	01069693          	slli	a3,a3,0x10
8000cd14:	00cefeb3          	and	t4,t4,a2
8000cd18:	00a70f33          	add	t5,a4,a0
8000cd1c:	01d68eb3          	add	t4,a3,t4
8000cd20:	0104d713          	srli	a4,s1,0x10
8000cd24:	00c4f4b3          	and	s1,s1,a2
8000cd28:	01d282b3          	add	t0,t0,t4
8000cd2c:	00048513          	mv	a0,s1
8000cd30:	00078593          	mv	a1,a5
8000cd34:	471000ef          	jal	ra,8000d9a4 <__mulsi3>
8000cd38:	00050913          	mv	s2,a0
8000cd3c:	000f8593          	mv	a1,t6
8000cd40:	00048513          	mv	a0,s1
8000cd44:	461000ef          	jal	ra,8000d9a4 <__mulsi3>
8000cd48:	00050313          	mv	t1,a0
8000cd4c:	00078593          	mv	a1,a5
8000cd50:	00070513          	mv	a0,a4
8000cd54:	451000ef          	jal	ra,8000d9a4 <__mulsi3>
8000cd58:	00050b13          	mv	s6,a0
8000cd5c:	000f8593          	mv	a1,t6
8000cd60:	00070513          	mv	a0,a4
8000cd64:	441000ef          	jal	ra,8000d9a4 <__mulsi3>
8000cd68:	01095793          	srli	a5,s2,0x10
8000cd6c:	01630333          	add	t1,t1,s6
8000cd70:	006787b3          	add	a5,a5,t1
8000cd74:	0167f463          	bgeu	a5,s6,8000cd7c <__muldf3+0x384>
8000cd78:	01550533          	add	a0,a0,s5
8000cd7c:	00010ab7          	lui	s5,0x10
8000cd80:	fffa8693          	addi	a3,s5,-1 # ffff <crtStart-0x7fff0001>
8000cd84:	00d7f333          	and	t1,a5,a3
8000cd88:	0107d613          	srli	a2,a5,0x10
8000cd8c:	00d97933          	and	s2,s2,a3
8000cd90:	01031313          	slli	t1,t1,0x10
8000cd94:	00a60fb3          	add	t6,a2,a0
8000cd98:	01230333          	add	t1,t1,s2
8000cd9c:	00048513          	mv	a0,s1
8000cda0:	00040593          	mv	a1,s0
8000cda4:	401000ef          	jal	ra,8000d9a4 <__mulsi3>
8000cda8:	00050793          	mv	a5,a0
8000cdac:	000a0593          	mv	a1,s4
8000cdb0:	00048513          	mv	a0,s1
8000cdb4:	3f1000ef          	jal	ra,8000d9a4 <__mulsi3>
8000cdb8:	00050493          	mv	s1,a0
8000cdbc:	00040593          	mv	a1,s0
8000cdc0:	00070513          	mv	a0,a4
8000cdc4:	3e1000ef          	jal	ra,8000d9a4 <__mulsi3>
8000cdc8:	00050913          	mv	s2,a0
8000cdcc:	000a0593          	mv	a1,s4
8000cdd0:	00070513          	mv	a0,a4
8000cdd4:	3d1000ef          	jal	ra,8000d9a4 <__mulsi3>
8000cdd8:	0107d693          	srli	a3,a5,0x10
8000cddc:	012484b3          	add	s1,s1,s2
8000cde0:	009686b3          	add	a3,a3,s1
8000cde4:	0126f463          	bgeu	a3,s2,8000cdec <__muldf3+0x3f4>
8000cde8:	01550533          	add	a0,a0,s5
8000cdec:	00010637          	lui	a2,0x10
8000cdf0:	fff60613          	addi	a2,a2,-1 # ffff <crtStart-0x7fff0001>
8000cdf4:	00c6f733          	and	a4,a3,a2
8000cdf8:	00c7f7b3          	and	a5,a5,a2
8000cdfc:	01071713          	slli	a4,a4,0x10
8000ce00:	007282b3          	add	t0,t0,t2
8000ce04:	00f70733          	add	a4,a4,a5
8000ce08:	01d2beb3          	sltu	t4,t0,t4
8000ce0c:	01e70733          	add	a4,a4,t5
8000ce10:	01d70433          	add	s0,a4,t4
8000ce14:	006282b3          	add	t0,t0,t1
8000ce18:	01f40633          	add	a2,s0,t6
8000ce1c:	0062b333          	sltu	t1,t0,t1
8000ce20:	006605b3          	add	a1,a2,t1
8000ce24:	01e73733          	sltu	a4,a4,t5
8000ce28:	01d43433          	sltu	s0,s0,t4
8000ce2c:	00876433          	or	s0,a4,s0
8000ce30:	0106d693          	srli	a3,a3,0x10
8000ce34:	01f63633          	sltu	a2,a2,t6
8000ce38:	0065b333          	sltu	t1,a1,t1
8000ce3c:	00d40433          	add	s0,s0,a3
8000ce40:	00666333          	or	t1,a2,t1
8000ce44:	00640433          	add	s0,s0,t1
8000ce48:	00929793          	slli	a5,t0,0x9
8000ce4c:	00a40433          	add	s0,s0,a0
8000ce50:	01c7e7b3          	or	a5,a5,t3
8000ce54:	00941413          	slli	s0,s0,0x9
8000ce58:	0175d513          	srli	a0,a1,0x17
8000ce5c:	00f037b3          	snez	a5,a5
8000ce60:	0172de13          	srli	t3,t0,0x17
8000ce64:	00959713          	slli	a4,a1,0x9
8000ce68:	00a46433          	or	s0,s0,a0
8000ce6c:	01c7e7b3          	or	a5,a5,t3
8000ce70:	00e7e7b3          	or	a5,a5,a4
8000ce74:	00741713          	slli	a4,s0,0x7
8000ce78:	10075263          	bgez	a4,8000cf7c <__muldf3+0x584>
8000ce7c:	0017d713          	srli	a4,a5,0x1
8000ce80:	0017f793          	andi	a5,a5,1
8000ce84:	00f767b3          	or	a5,a4,a5
8000ce88:	01f41713          	slli	a4,s0,0x1f
8000ce8c:	00e7e7b3          	or	a5,a5,a4
8000ce90:	00145413          	srli	s0,s0,0x1
8000ce94:	3ff88693          	addi	a3,a7,1023
8000ce98:	0ed05663          	blez	a3,8000cf84 <__muldf3+0x58c>
8000ce9c:	0077f713          	andi	a4,a5,7
8000cea0:	02070063          	beqz	a4,8000cec0 <__muldf3+0x4c8>
8000cea4:	00f7f713          	andi	a4,a5,15
8000cea8:	00400613          	li	a2,4
8000ceac:	00c70a63          	beq	a4,a2,8000cec0 <__muldf3+0x4c8>
8000ceb0:	00478713          	addi	a4,a5,4 # 800004 <crtStart-0x7f7ffffc>
8000ceb4:	00f737b3          	sltu	a5,a4,a5
8000ceb8:	00f40433          	add	s0,s0,a5
8000cebc:	00070793          	mv	a5,a4
8000cec0:	00741713          	slli	a4,s0,0x7
8000cec4:	00075a63          	bgez	a4,8000ced8 <__muldf3+0x4e0>
8000cec8:	ff000737          	lui	a4,0xff000
8000cecc:	fff70713          	addi	a4,a4,-1 # feffffff <STACK_TOP+0x7efdffff>
8000ced0:	00e47433          	and	s0,s0,a4
8000ced4:	40088693          	addi	a3,a7,1024
8000ced8:	7fe00713          	li	a4,2046
8000cedc:	16d74663          	blt	a4,a3,8000d048 <__muldf3+0x650>
8000cee0:	0037d713          	srli	a4,a5,0x3
8000cee4:	01d41793          	slli	a5,s0,0x1d
8000cee8:	00e7e7b3          	or	a5,a5,a4
8000ceec:	00345413          	srli	s0,s0,0x3
8000cef0:	00c41413          	slli	s0,s0,0xc
8000cef4:	7ff6f713          	andi	a4,a3,2047
8000cef8:	01471713          	slli	a4,a4,0x14
8000cefc:	00c45413          	srli	s0,s0,0xc
8000cf00:	00e46433          	or	s0,s0,a4
8000cf04:	01f81813          	slli	a6,a6,0x1f
8000cf08:	01046733          	or	a4,s0,a6
8000cf0c:	02c12083          	lw	ra,44(sp)
8000cf10:	02812403          	lw	s0,40(sp)
8000cf14:	02412483          	lw	s1,36(sp)
8000cf18:	02012903          	lw	s2,32(sp)
8000cf1c:	01c12983          	lw	s3,28(sp)
8000cf20:	01812a03          	lw	s4,24(sp)
8000cf24:	01412a83          	lw	s5,20(sp)
8000cf28:	01012b03          	lw	s6,16(sp)
8000cf2c:	00c12b83          	lw	s7,12(sp)
8000cf30:	00078513          	mv	a0,a5
8000cf34:	00070593          	mv	a1,a4
8000cf38:	03010113          	addi	sp,sp,48
8000cf3c:	00008067          	ret
8000cf40:	000a0813          	mv	a6,s4
8000cf44:	00048413          	mv	s0,s1
8000cf48:	00090793          	mv	a5,s2
8000cf4c:	000b8713          	mv	a4,s7
8000cf50:	00200693          	li	a3,2
8000cf54:	0ed70a63          	beq	a4,a3,8000d048 <__muldf3+0x650>
8000cf58:	00300693          	li	a3,3
8000cf5c:	0cd70c63          	beq	a4,a3,8000d034 <__muldf3+0x63c>
8000cf60:	00100693          	li	a3,1
8000cf64:	f2d718e3          	bne	a4,a3,8000ce94 <__muldf3+0x49c>
8000cf68:	00000413          	li	s0,0
8000cf6c:	00000793          	li	a5,0
8000cf70:	0880006f          	j	8000cff8 <__muldf3+0x600>
8000cf74:	000a8813          	mv	a6,s5
8000cf78:	fd9ff06f          	j	8000cf50 <__muldf3+0x558>
8000cf7c:	00098893          	mv	a7,s3
8000cf80:	f15ff06f          	j	8000ce94 <__muldf3+0x49c>
8000cf84:	00100613          	li	a2,1
8000cf88:	40d60633          	sub	a2,a2,a3
8000cf8c:	03800713          	li	a4,56
8000cf90:	fcc74ce3          	blt	a4,a2,8000cf68 <__muldf3+0x570>
8000cf94:	01f00713          	li	a4,31
8000cf98:	06c74463          	blt	a4,a2,8000d000 <__muldf3+0x608>
8000cf9c:	41e88893          	addi	a7,a7,1054
8000cfa0:	01141733          	sll	a4,s0,a7
8000cfa4:	00c7d6b3          	srl	a3,a5,a2
8000cfa8:	011797b3          	sll	a5,a5,a7
8000cfac:	00d76733          	or	a4,a4,a3
8000cfb0:	00f037b3          	snez	a5,a5
8000cfb4:	00f767b3          	or	a5,a4,a5
8000cfb8:	00c45433          	srl	s0,s0,a2
8000cfbc:	0077f713          	andi	a4,a5,7
8000cfc0:	02070063          	beqz	a4,8000cfe0 <__muldf3+0x5e8>
8000cfc4:	00f7f713          	andi	a4,a5,15
8000cfc8:	00400693          	li	a3,4
8000cfcc:	00d70a63          	beq	a4,a3,8000cfe0 <__muldf3+0x5e8>
8000cfd0:	00478713          	addi	a4,a5,4
8000cfd4:	00f737b3          	sltu	a5,a4,a5
8000cfd8:	00f40433          	add	s0,s0,a5
8000cfdc:	00070793          	mv	a5,a4
8000cfe0:	00841713          	slli	a4,s0,0x8
8000cfe4:	06074a63          	bltz	a4,8000d058 <__muldf3+0x660>
8000cfe8:	01d41713          	slli	a4,s0,0x1d
8000cfec:	0037d793          	srli	a5,a5,0x3
8000cff0:	00f767b3          	or	a5,a4,a5
8000cff4:	00345413          	srli	s0,s0,0x3
8000cff8:	00000693          	li	a3,0
8000cffc:	ef5ff06f          	j	8000cef0 <__muldf3+0x4f8>
8000d000:	fe100713          	li	a4,-31
8000d004:	40d70733          	sub	a4,a4,a3
8000d008:	02000593          	li	a1,32
8000d00c:	00e45733          	srl	a4,s0,a4
8000d010:	00000693          	li	a3,0
8000d014:	00b60663          	beq	a2,a1,8000d020 <__muldf3+0x628>
8000d018:	43e88893          	addi	a7,a7,1086
8000d01c:	011416b3          	sll	a3,s0,a7
8000d020:	00f6e7b3          	or	a5,a3,a5
8000d024:	00f037b3          	snez	a5,a5
8000d028:	00f767b3          	or	a5,a4,a5
8000d02c:	00000413          	li	s0,0
8000d030:	f8dff06f          	j	8000cfbc <__muldf3+0x5c4>
8000d034:	00080437          	lui	s0,0x80
8000d038:	00000793          	li	a5,0
8000d03c:	7ff00693          	li	a3,2047
8000d040:	00000813          	li	a6,0
8000d044:	eadff06f          	j	8000cef0 <__muldf3+0x4f8>
8000d048:	00000413          	li	s0,0
8000d04c:	00000793          	li	a5,0
8000d050:	7ff00693          	li	a3,2047
8000d054:	e9dff06f          	j	8000cef0 <__muldf3+0x4f8>
8000d058:	00000413          	li	s0,0
8000d05c:	00000793          	li	a5,0
8000d060:	00100693          	li	a3,1
8000d064:	e8dff06f          	j	8000cef0 <__muldf3+0x4f8>

8000d068 <__subdf3>:
8000d068:	00100837          	lui	a6,0x100
8000d06c:	fff80813          	addi	a6,a6,-1 # fffff <crtStart-0x7ff00001>
8000d070:	00b878b3          	and	a7,a6,a1
8000d074:	00389893          	slli	a7,a7,0x3
8000d078:	01d55793          	srli	a5,a0,0x1d
8000d07c:	fe010113          	addi	sp,sp,-32
8000d080:	0145d713          	srli	a4,a1,0x14
8000d084:	00d87833          	and	a6,a6,a3
8000d088:	0117e7b3          	or	a5,a5,a7
8000d08c:	0146d893          	srli	a7,a3,0x14
8000d090:	00912a23          	sw	s1,20(sp)
8000d094:	01212823          	sw	s2,16(sp)
8000d098:	7ff77493          	andi	s1,a4,2047
8000d09c:	01f5d913          	srli	s2,a1,0x1f
8000d0a0:	01d65713          	srli	a4,a2,0x1d
8000d0a4:	00381813          	slli	a6,a6,0x3
8000d0a8:	00112e23          	sw	ra,28(sp)
8000d0ac:	00812c23          	sw	s0,24(sp)
8000d0b0:	01312623          	sw	s3,12(sp)
8000d0b4:	7ff8f893          	andi	a7,a7,2047
8000d0b8:	7ff00593          	li	a1,2047
8000d0bc:	00351513          	slli	a0,a0,0x3
8000d0c0:	01f6d693          	srli	a3,a3,0x1f
8000d0c4:	01076733          	or	a4,a4,a6
8000d0c8:	00361613          	slli	a2,a2,0x3
8000d0cc:	00b89663          	bne	a7,a1,8000d0d8 <__subdf3+0x70>
8000d0d0:	00c765b3          	or	a1,a4,a2
8000d0d4:	00059463          	bnez	a1,8000d0dc <__subdf3+0x74>
8000d0d8:	0016c693          	xori	a3,a3,1
8000d0dc:	41148833          	sub	a6,s1,a7
8000d0e0:	2d269063          	bne	a3,s2,8000d3a0 <__subdf3+0x338>
8000d0e4:	13005c63          	blez	a6,8000d21c <__subdf3+0x1b4>
8000d0e8:	06089063          	bnez	a7,8000d148 <__subdf3+0xe0>
8000d0ec:	00c766b3          	or	a3,a4,a2
8000d0f0:	02068863          	beqz	a3,8000d120 <__subdf3+0xb8>
8000d0f4:	fff48813          	addi	a6,s1,-1
8000d0f8:	02081063          	bnez	a6,8000d118 <__subdf3+0xb0>
8000d0fc:	00c50633          	add	a2,a0,a2
8000d100:	00a63533          	sltu	a0,a2,a0
8000d104:	00e787b3          	add	a5,a5,a4
8000d108:	00a787b3          	add	a5,a5,a0
8000d10c:	00060513          	mv	a0,a2
8000d110:	00100493          	li	s1,1
8000d114:	08c0006f          	j	8000d1a0 <__subdf3+0x138>
8000d118:	7ff00693          	li	a3,2047
8000d11c:	02d49e63          	bne	s1,a3,8000d158 <__subdf3+0xf0>
8000d120:	00757713          	andi	a4,a0,7
8000d124:	62070c63          	beqz	a4,8000d75c <__subdf3+0x6f4>
8000d128:	00f57713          	andi	a4,a0,15
8000d12c:	00400693          	li	a3,4
8000d130:	62d70663          	beq	a4,a3,8000d75c <__subdf3+0x6f4>
8000d134:	00450693          	addi	a3,a0,4
8000d138:	00a6b533          	sltu	a0,a3,a0
8000d13c:	00a787b3          	add	a5,a5,a0
8000d140:	00068513          	mv	a0,a3
8000d144:	6180006f          	j	8000d75c <__subdf3+0x6f4>
8000d148:	7ff00693          	li	a3,2047
8000d14c:	fcd48ae3          	beq	s1,a3,8000d120 <__subdf3+0xb8>
8000d150:	008006b7          	lui	a3,0x800
8000d154:	00d76733          	or	a4,a4,a3
8000d158:	03800693          	li	a3,56
8000d15c:	0b06ca63          	blt	a3,a6,8000d210 <__subdf3+0x1a8>
8000d160:	01f00693          	li	a3,31
8000d164:	0706cc63          	blt	a3,a6,8000d1dc <__subdf3+0x174>
8000d168:	02000593          	li	a1,32
8000d16c:	410585b3          	sub	a1,a1,a6
8000d170:	00b716b3          	sll	a3,a4,a1
8000d174:	010658b3          	srl	a7,a2,a6
8000d178:	00b61633          	sll	a2,a2,a1
8000d17c:	0116e6b3          	or	a3,a3,a7
8000d180:	00c03633          	snez	a2,a2
8000d184:	00c6e633          	or	a2,a3,a2
8000d188:	01075733          	srl	a4,a4,a6
8000d18c:	00a60633          	add	a2,a2,a0
8000d190:	00f70733          	add	a4,a4,a5
8000d194:	00a637b3          	sltu	a5,a2,a0
8000d198:	00f707b3          	add	a5,a4,a5
8000d19c:	00060513          	mv	a0,a2
8000d1a0:	00879713          	slli	a4,a5,0x8
8000d1a4:	f6075ee3          	bgez	a4,8000d120 <__subdf3+0xb8>
8000d1a8:	00148493          	addi	s1,s1,1
8000d1ac:	7ff00713          	li	a4,2047
8000d1b0:	5ae48263          	beq	s1,a4,8000d754 <__subdf3+0x6ec>
8000d1b4:	ff8006b7          	lui	a3,0xff800
8000d1b8:	fff68693          	addi	a3,a3,-1 # ff7fffff <STACK_TOP+0x7f7dffff>
8000d1bc:	00d7f6b3          	and	a3,a5,a3
8000d1c0:	00155593          	srli	a1,a0,0x1
8000d1c4:	00157513          	andi	a0,a0,1
8000d1c8:	01f69793          	slli	a5,a3,0x1f
8000d1cc:	00a5e533          	or	a0,a1,a0
8000d1d0:	00a7e533          	or	a0,a5,a0
8000d1d4:	0016d793          	srli	a5,a3,0x1
8000d1d8:	f49ff06f          	j	8000d120 <__subdf3+0xb8>
8000d1dc:	fe080693          	addi	a3,a6,-32
8000d1e0:	02000893          	li	a7,32
8000d1e4:	00d756b3          	srl	a3,a4,a3
8000d1e8:	00000593          	li	a1,0
8000d1ec:	01180863          	beq	a6,a7,8000d1fc <__subdf3+0x194>
8000d1f0:	04000593          	li	a1,64
8000d1f4:	41058833          	sub	a6,a1,a6
8000d1f8:	010715b3          	sll	a1,a4,a6
8000d1fc:	00c5e633          	or	a2,a1,a2
8000d200:	00c03633          	snez	a2,a2
8000d204:	00c6e633          	or	a2,a3,a2
8000d208:	00000713          	li	a4,0
8000d20c:	f81ff06f          	j	8000d18c <__subdf3+0x124>
8000d210:	00c76633          	or	a2,a4,a2
8000d214:	00c03633          	snez	a2,a2
8000d218:	ff1ff06f          	j	8000d208 <__subdf3+0x1a0>
8000d21c:	0e080263          	beqz	a6,8000d300 <__subdf3+0x298>
8000d220:	409885b3          	sub	a1,a7,s1
8000d224:	02049e63          	bnez	s1,8000d260 <__subdf3+0x1f8>
8000d228:	00a7e6b3          	or	a3,a5,a0
8000d22c:	50068463          	beqz	a3,8000d734 <__subdf3+0x6cc>
8000d230:	fff58693          	addi	a3,a1,-1
8000d234:	00069c63          	bnez	a3,8000d24c <__subdf3+0x1e4>
8000d238:	00c50533          	add	a0,a0,a2
8000d23c:	00e787b3          	add	a5,a5,a4
8000d240:	00c53633          	sltu	a2,a0,a2
8000d244:	00c787b3          	add	a5,a5,a2
8000d248:	ec9ff06f          	j	8000d110 <__subdf3+0xa8>
8000d24c:	7ff00813          	li	a6,2047
8000d250:	03059263          	bne	a1,a6,8000d274 <__subdf3+0x20c>
8000d254:	00070793          	mv	a5,a4
8000d258:	00060513          	mv	a0,a2
8000d25c:	3b00006f          	j	8000d60c <__subdf3+0x5a4>
8000d260:	7ff00693          	li	a3,2047
8000d264:	fed888e3          	beq	a7,a3,8000d254 <__subdf3+0x1ec>
8000d268:	008006b7          	lui	a3,0x800
8000d26c:	00d7e7b3          	or	a5,a5,a3
8000d270:	00058693          	mv	a3,a1
8000d274:	03800593          	li	a1,56
8000d278:	06d5ce63          	blt	a1,a3,8000d2f4 <__subdf3+0x28c>
8000d27c:	01f00593          	li	a1,31
8000d280:	04d5c063          	blt	a1,a3,8000d2c0 <__subdf3+0x258>
8000d284:	02000813          	li	a6,32
8000d288:	40d80833          	sub	a6,a6,a3
8000d28c:	00d55333          	srl	t1,a0,a3
8000d290:	010795b3          	sll	a1,a5,a6
8000d294:	01051533          	sll	a0,a0,a6
8000d298:	0065e5b3          	or	a1,a1,t1
8000d29c:	00a03533          	snez	a0,a0
8000d2a0:	00a5e533          	or	a0,a1,a0
8000d2a4:	00d7d6b3          	srl	a3,a5,a3
8000d2a8:	00c50533          	add	a0,a0,a2
8000d2ac:	00e687b3          	add	a5,a3,a4
8000d2b0:	00c53633          	sltu	a2,a0,a2
8000d2b4:	00c787b3          	add	a5,a5,a2
8000d2b8:	00088493          	mv	s1,a7
8000d2bc:	ee5ff06f          	j	8000d1a0 <__subdf3+0x138>
8000d2c0:	fe068593          	addi	a1,a3,-32 # 7fffe0 <crtStart-0x7f800020>
8000d2c4:	02000313          	li	t1,32
8000d2c8:	00b7d5b3          	srl	a1,a5,a1
8000d2cc:	00000813          	li	a6,0
8000d2d0:	00668863          	beq	a3,t1,8000d2e0 <__subdf3+0x278>
8000d2d4:	04000813          	li	a6,64
8000d2d8:	40d806b3          	sub	a3,a6,a3
8000d2dc:	00d79833          	sll	a6,a5,a3
8000d2e0:	00a86533          	or	a0,a6,a0
8000d2e4:	00a03533          	snez	a0,a0
8000d2e8:	00a5e533          	or	a0,a1,a0
8000d2ec:	00000693          	li	a3,0
8000d2f0:	fb9ff06f          	j	8000d2a8 <__subdf3+0x240>
8000d2f4:	00a7e533          	or	a0,a5,a0
8000d2f8:	00a03533          	snez	a0,a0
8000d2fc:	ff1ff06f          	j	8000d2ec <__subdf3+0x284>
8000d300:	00148693          	addi	a3,s1,1
8000d304:	7fe6f593          	andi	a1,a3,2046
8000d308:	06059463          	bnez	a1,8000d370 <__subdf3+0x308>
8000d30c:	00a7e6b3          	or	a3,a5,a0
8000d310:	04049063          	bnez	s1,8000d350 <__subdf3+0x2e8>
8000d314:	42068863          	beqz	a3,8000d744 <__subdf3+0x6dc>
8000d318:	00c766b3          	or	a3,a4,a2
8000d31c:	e00682e3          	beqz	a3,8000d120 <__subdf3+0xb8>
8000d320:	00c50633          	add	a2,a0,a2
8000d324:	00e787b3          	add	a5,a5,a4
8000d328:	00a63533          	sltu	a0,a2,a0
8000d32c:	00a787b3          	add	a5,a5,a0
8000d330:	00879713          	slli	a4,a5,0x8
8000d334:	00060513          	mv	a0,a2
8000d338:	de0754e3          	bgez	a4,8000d120 <__subdf3+0xb8>
8000d33c:	ff800737          	lui	a4,0xff800
8000d340:	fff70713          	addi	a4,a4,-1 # ff7fffff <STACK_TOP+0x7f7dffff>
8000d344:	00e7f7b3          	and	a5,a5,a4
8000d348:	00100493          	li	s1,1
8000d34c:	dd5ff06f          	j	8000d120 <__subdf3+0xb8>
8000d350:	f00682e3          	beqz	a3,8000d254 <__subdf3+0x1ec>
8000d354:	00c76633          	or	a2,a4,a2
8000d358:	2a060a63          	beqz	a2,8000d60c <__subdf3+0x5a4>
8000d35c:	00000913          	li	s2,0
8000d360:	004007b7          	lui	a5,0x400
8000d364:	00000513          	li	a0,0
8000d368:	7ff00493          	li	s1,2047
8000d36c:	3f00006f          	j	8000d75c <__subdf3+0x6f4>
8000d370:	7ff00593          	li	a1,2047
8000d374:	3cb68e63          	beq	a3,a1,8000d750 <__subdf3+0x6e8>
8000d378:	00c50633          	add	a2,a0,a2
8000d37c:	00e78733          	add	a4,a5,a4
8000d380:	00a637b3          	sltu	a5,a2,a0
8000d384:	00f70733          	add	a4,a4,a5
8000d388:	01f71513          	slli	a0,a4,0x1f
8000d38c:	00165613          	srli	a2,a2,0x1
8000d390:	00c56533          	or	a0,a0,a2
8000d394:	00175793          	srli	a5,a4,0x1
8000d398:	00068493          	mv	s1,a3
8000d39c:	d85ff06f          	j	8000d120 <__subdf3+0xb8>
8000d3a0:	0f005a63          	blez	a6,8000d494 <__subdf3+0x42c>
8000d3a4:	08089e63          	bnez	a7,8000d440 <__subdf3+0x3d8>
8000d3a8:	00c766b3          	or	a3,a4,a2
8000d3ac:	d6068ae3          	beqz	a3,8000d120 <__subdf3+0xb8>
8000d3b0:	fff48813          	addi	a6,s1,-1
8000d3b4:	02081063          	bnez	a6,8000d3d4 <__subdf3+0x36c>
8000d3b8:	40c50633          	sub	a2,a0,a2
8000d3bc:	00c53533          	sltu	a0,a0,a2
8000d3c0:	40e787b3          	sub	a5,a5,a4
8000d3c4:	40a787b3          	sub	a5,a5,a0
8000d3c8:	00060513          	mv	a0,a2
8000d3cc:	00100493          	li	s1,1
8000d3d0:	0540006f          	j	8000d424 <__subdf3+0x3bc>
8000d3d4:	7ff00693          	li	a3,2047
8000d3d8:	d4d484e3          	beq	s1,a3,8000d120 <__subdf3+0xb8>
8000d3dc:	03800693          	li	a3,56
8000d3e0:	0b06c463          	blt	a3,a6,8000d488 <__subdf3+0x420>
8000d3e4:	01f00693          	li	a3,31
8000d3e8:	0706c663          	blt	a3,a6,8000d454 <__subdf3+0x3ec>
8000d3ec:	02000593          	li	a1,32
8000d3f0:	410585b3          	sub	a1,a1,a6
8000d3f4:	00b716b3          	sll	a3,a4,a1
8000d3f8:	010658b3          	srl	a7,a2,a6
8000d3fc:	00b61633          	sll	a2,a2,a1
8000d400:	0116e6b3          	or	a3,a3,a7
8000d404:	00c03633          	snez	a2,a2
8000d408:	00c6e633          	or	a2,a3,a2
8000d40c:	01075733          	srl	a4,a4,a6
8000d410:	40c50633          	sub	a2,a0,a2
8000d414:	40e78733          	sub	a4,a5,a4
8000d418:	00c537b3          	sltu	a5,a0,a2
8000d41c:	40f707b3          	sub	a5,a4,a5
8000d420:	00060513          	mv	a0,a2
8000d424:	00879713          	slli	a4,a5,0x8
8000d428:	ce075ce3          	bgez	a4,8000d120 <__subdf3+0xb8>
8000d42c:	00800437          	lui	s0,0x800
8000d430:	fff40413          	addi	s0,s0,-1 # 7fffff <crtStart-0x7f800001>
8000d434:	0087f433          	and	s0,a5,s0
8000d438:	00050993          	mv	s3,a0
8000d43c:	20c0006f          	j	8000d648 <__subdf3+0x5e0>
8000d440:	7ff00693          	li	a3,2047
8000d444:	ccd48ee3          	beq	s1,a3,8000d120 <__subdf3+0xb8>
8000d448:	008006b7          	lui	a3,0x800
8000d44c:	00d76733          	or	a4,a4,a3
8000d450:	f8dff06f          	j	8000d3dc <__subdf3+0x374>
8000d454:	fe080693          	addi	a3,a6,-32
8000d458:	02000893          	li	a7,32
8000d45c:	00d756b3          	srl	a3,a4,a3
8000d460:	00000593          	li	a1,0
8000d464:	01180863          	beq	a6,a7,8000d474 <__subdf3+0x40c>
8000d468:	04000593          	li	a1,64
8000d46c:	41058833          	sub	a6,a1,a6
8000d470:	010715b3          	sll	a1,a4,a6
8000d474:	00c5e633          	or	a2,a1,a2
8000d478:	00c03633          	snez	a2,a2
8000d47c:	00c6e633          	or	a2,a3,a2
8000d480:	00000713          	li	a4,0
8000d484:	f8dff06f          	j	8000d410 <__subdf3+0x3a8>
8000d488:	00c76633          	or	a2,a4,a2
8000d48c:	00c03633          	snez	a2,a2
8000d490:	ff1ff06f          	j	8000d480 <__subdf3+0x418>
8000d494:	0e080863          	beqz	a6,8000d584 <__subdf3+0x51c>
8000d498:	40988833          	sub	a6,a7,s1
8000d49c:	04049263          	bnez	s1,8000d4e0 <__subdf3+0x478>
8000d4a0:	00a7e5b3          	or	a1,a5,a0
8000d4a4:	34058263          	beqz	a1,8000d7e8 <__subdf3+0x780>
8000d4a8:	fff80593          	addi	a1,a6,-1
8000d4ac:	00059e63          	bnez	a1,8000d4c8 <__subdf3+0x460>
8000d4b0:	40a60533          	sub	a0,a2,a0
8000d4b4:	40f707b3          	sub	a5,a4,a5
8000d4b8:	00a63633          	sltu	a2,a2,a0
8000d4bc:	40c787b3          	sub	a5,a5,a2
8000d4c0:	00068913          	mv	s2,a3
8000d4c4:	f09ff06f          	j	8000d3cc <__subdf3+0x364>
8000d4c8:	7ff00313          	li	t1,2047
8000d4cc:	02681463          	bne	a6,t1,8000d4f4 <__subdf3+0x48c>
8000d4d0:	00070793          	mv	a5,a4
8000d4d4:	00060513          	mv	a0,a2
8000d4d8:	7ff00493          	li	s1,2047
8000d4dc:	0d00006f          	j	8000d5ac <__subdf3+0x544>
8000d4e0:	7ff00593          	li	a1,2047
8000d4e4:	feb886e3          	beq	a7,a1,8000d4d0 <__subdf3+0x468>
8000d4e8:	008005b7          	lui	a1,0x800
8000d4ec:	00b7e7b3          	or	a5,a5,a1
8000d4f0:	00080593          	mv	a1,a6
8000d4f4:	03800813          	li	a6,56
8000d4f8:	08b84063          	blt	a6,a1,8000d578 <__subdf3+0x510>
8000d4fc:	01f00813          	li	a6,31
8000d500:	04b84263          	blt	a6,a1,8000d544 <__subdf3+0x4dc>
8000d504:	02000313          	li	t1,32
8000d508:	40b30333          	sub	t1,t1,a1
8000d50c:	00b55e33          	srl	t3,a0,a1
8000d510:	00679833          	sll	a6,a5,t1
8000d514:	00651533          	sll	a0,a0,t1
8000d518:	01c86833          	or	a6,a6,t3
8000d51c:	00a03533          	snez	a0,a0
8000d520:	00a86533          	or	a0,a6,a0
8000d524:	00b7d5b3          	srl	a1,a5,a1
8000d528:	40a60533          	sub	a0,a2,a0
8000d52c:	40b707b3          	sub	a5,a4,a1
8000d530:	00a63633          	sltu	a2,a2,a0
8000d534:	40c787b3          	sub	a5,a5,a2
8000d538:	00088493          	mv	s1,a7
8000d53c:	00068913          	mv	s2,a3
8000d540:	ee5ff06f          	j	8000d424 <__subdf3+0x3bc>
8000d544:	fe058813          	addi	a6,a1,-32 # 7fffe0 <crtStart-0x7f800020>
8000d548:	02000e13          	li	t3,32
8000d54c:	0107d833          	srl	a6,a5,a6
8000d550:	00000313          	li	t1,0
8000d554:	01c58863          	beq	a1,t3,8000d564 <__subdf3+0x4fc>
8000d558:	04000313          	li	t1,64
8000d55c:	40b305b3          	sub	a1,t1,a1
8000d560:	00b79333          	sll	t1,a5,a1
8000d564:	00a36533          	or	a0,t1,a0
8000d568:	00a03533          	snez	a0,a0
8000d56c:	00a86533          	or	a0,a6,a0
8000d570:	00000593          	li	a1,0
8000d574:	fb5ff06f          	j	8000d528 <__subdf3+0x4c0>
8000d578:	00a7e533          	or	a0,a5,a0
8000d57c:	00a03533          	snez	a0,a0
8000d580:	ff1ff06f          	j	8000d570 <__subdf3+0x508>
8000d584:	00148593          	addi	a1,s1,1
8000d588:	7fe5f593          	andi	a1,a1,2046
8000d58c:	08059863          	bnez	a1,8000d61c <__subdf3+0x5b4>
8000d590:	00a7e833          	or	a6,a5,a0
8000d594:	00c765b3          	or	a1,a4,a2
8000d598:	06049063          	bnez	s1,8000d5f8 <__subdf3+0x590>
8000d59c:	00081c63          	bnez	a6,8000d5b4 <__subdf3+0x54c>
8000d5a0:	24058c63          	beqz	a1,8000d7f8 <__subdf3+0x790>
8000d5a4:	00070793          	mv	a5,a4
8000d5a8:	00060513          	mv	a0,a2
8000d5ac:	00068913          	mv	s2,a3
8000d5b0:	b71ff06f          	j	8000d120 <__subdf3+0xb8>
8000d5b4:	b60586e3          	beqz	a1,8000d120 <__subdf3+0xb8>
8000d5b8:	40c50833          	sub	a6,a0,a2
8000d5bc:	010538b3          	sltu	a7,a0,a6
8000d5c0:	40e785b3          	sub	a1,a5,a4
8000d5c4:	411585b3          	sub	a1,a1,a7
8000d5c8:	00859893          	slli	a7,a1,0x8
8000d5cc:	0008dc63          	bgez	a7,8000d5e4 <__subdf3+0x57c>
8000d5d0:	40a60533          	sub	a0,a2,a0
8000d5d4:	40f707b3          	sub	a5,a4,a5
8000d5d8:	00a63633          	sltu	a2,a2,a0
8000d5dc:	40c787b3          	sub	a5,a5,a2
8000d5e0:	fcdff06f          	j	8000d5ac <__subdf3+0x544>
8000d5e4:	00b86533          	or	a0,a6,a1
8000d5e8:	22050063          	beqz	a0,8000d808 <__subdf3+0x7a0>
8000d5ec:	00058793          	mv	a5,a1
8000d5f0:	00080513          	mv	a0,a6
8000d5f4:	b2dff06f          	j	8000d120 <__subdf3+0xb8>
8000d5f8:	00081e63          	bnez	a6,8000d614 <__subdf3+0x5ac>
8000d5fc:	20058a63          	beqz	a1,8000d810 <__subdf3+0x7a8>
8000d600:	00070793          	mv	a5,a4
8000d604:	00060513          	mv	a0,a2
8000d608:	00068913          	mv	s2,a3
8000d60c:	7ff00493          	li	s1,2047
8000d610:	b11ff06f          	j	8000d120 <__subdf3+0xb8>
8000d614:	fe058ce3          	beqz	a1,8000d60c <__subdf3+0x5a4>
8000d618:	d45ff06f          	j	8000d35c <__subdf3+0x2f4>
8000d61c:	40c509b3          	sub	s3,a0,a2
8000d620:	013535b3          	sltu	a1,a0,s3
8000d624:	40e78433          	sub	s0,a5,a4
8000d628:	40b40433          	sub	s0,s0,a1
8000d62c:	00841593          	slli	a1,s0,0x8
8000d630:	0805d463          	bgez	a1,8000d6b8 <__subdf3+0x650>
8000d634:	40a609b3          	sub	s3,a2,a0
8000d638:	40f707b3          	sub	a5,a4,a5
8000d63c:	01363633          	sltu	a2,a2,s3
8000d640:	40c78433          	sub	s0,a5,a2
8000d644:	00068913          	mv	s2,a3
8000d648:	08040263          	beqz	s0,8000d6cc <__subdf3+0x664>
8000d64c:	00040513          	mv	a0,s0
8000d650:	42c000ef          	jal	ra,8000da7c <__clzsi2>
8000d654:	ff850713          	addi	a4,a0,-8
8000d658:	01f00793          	li	a5,31
8000d65c:	08e7c063          	blt	a5,a4,8000d6dc <__subdf3+0x674>
8000d660:	02000793          	li	a5,32
8000d664:	40e787b3          	sub	a5,a5,a4
8000d668:	00e41433          	sll	s0,s0,a4
8000d66c:	00f9d7b3          	srl	a5,s3,a5
8000d670:	0087e433          	or	s0,a5,s0
8000d674:	00e99533          	sll	a0,s3,a4
8000d678:	0a974463          	blt	a4,s1,8000d720 <__subdf3+0x6b8>
8000d67c:	40970733          	sub	a4,a4,s1
8000d680:	00170793          	addi	a5,a4,1
8000d684:	01f00693          	li	a3,31
8000d688:	06f6c263          	blt	a3,a5,8000d6ec <__subdf3+0x684>
8000d68c:	02000713          	li	a4,32
8000d690:	40f70733          	sub	a4,a4,a5
8000d694:	00f55633          	srl	a2,a0,a5
8000d698:	00e416b3          	sll	a3,s0,a4
8000d69c:	00e51533          	sll	a0,a0,a4
8000d6a0:	00c6e6b3          	or	a3,a3,a2
8000d6a4:	00a03533          	snez	a0,a0
8000d6a8:	00a6e533          	or	a0,a3,a0
8000d6ac:	00f457b3          	srl	a5,s0,a5
8000d6b0:	00000493          	li	s1,0
8000d6b4:	a6dff06f          	j	8000d120 <__subdf3+0xb8>
8000d6b8:	0089e533          	or	a0,s3,s0
8000d6bc:	f80516e3          	bnez	a0,8000d648 <__subdf3+0x5e0>
8000d6c0:	00000793          	li	a5,0
8000d6c4:	00000493          	li	s1,0
8000d6c8:	1380006f          	j	8000d800 <__subdf3+0x798>
8000d6cc:	00098513          	mv	a0,s3
8000d6d0:	3ac000ef          	jal	ra,8000da7c <__clzsi2>
8000d6d4:	02050513          	addi	a0,a0,32
8000d6d8:	f7dff06f          	j	8000d654 <__subdf3+0x5ec>
8000d6dc:	fd850413          	addi	s0,a0,-40
8000d6e0:	00899433          	sll	s0,s3,s0
8000d6e4:	00000513          	li	a0,0
8000d6e8:	f91ff06f          	j	8000d678 <__subdf3+0x610>
8000d6ec:	fe170713          	addi	a4,a4,-31
8000d6f0:	02000613          	li	a2,32
8000d6f4:	00e45733          	srl	a4,s0,a4
8000d6f8:	00000693          	li	a3,0
8000d6fc:	00c78863          	beq	a5,a2,8000d70c <__subdf3+0x6a4>
8000d700:	04000693          	li	a3,64
8000d704:	40f686b3          	sub	a3,a3,a5
8000d708:	00d416b3          	sll	a3,s0,a3
8000d70c:	00d56533          	or	a0,a0,a3
8000d710:	00a03533          	snez	a0,a0
8000d714:	00a76533          	or	a0,a4,a0
8000d718:	00000793          	li	a5,0
8000d71c:	f95ff06f          	j	8000d6b0 <__subdf3+0x648>
8000d720:	ff8007b7          	lui	a5,0xff800
8000d724:	fff78793          	addi	a5,a5,-1 # ff7fffff <STACK_TOP+0x7f7dffff>
8000d728:	40e484b3          	sub	s1,s1,a4
8000d72c:	00f477b3          	and	a5,s0,a5
8000d730:	9f1ff06f          	j	8000d120 <__subdf3+0xb8>
8000d734:	00070793          	mv	a5,a4
8000d738:	00060513          	mv	a0,a2
8000d73c:	00058493          	mv	s1,a1
8000d740:	9e1ff06f          	j	8000d120 <__subdf3+0xb8>
8000d744:	00070793          	mv	a5,a4
8000d748:	00060513          	mv	a0,a2
8000d74c:	9d5ff06f          	j	8000d120 <__subdf3+0xb8>
8000d750:	7ff00493          	li	s1,2047
8000d754:	00000793          	li	a5,0
8000d758:	00000513          	li	a0,0
8000d75c:	00879713          	slli	a4,a5,0x8
8000d760:	00075e63          	bgez	a4,8000d77c <__subdf3+0x714>
8000d764:	00148493          	addi	s1,s1,1
8000d768:	7ff00713          	li	a4,2047
8000d76c:	0ae48a63          	beq	s1,a4,8000d820 <__subdf3+0x7b8>
8000d770:	ff800737          	lui	a4,0xff800
8000d774:	fff70713          	addi	a4,a4,-1 # ff7fffff <STACK_TOP+0x7f7dffff>
8000d778:	00e7f7b3          	and	a5,a5,a4
8000d77c:	01d79713          	slli	a4,a5,0x1d
8000d780:	00355513          	srli	a0,a0,0x3
8000d784:	00a76533          	or	a0,a4,a0
8000d788:	7ff00713          	li	a4,2047
8000d78c:	0037d793          	srli	a5,a5,0x3
8000d790:	00e49e63          	bne	s1,a4,8000d7ac <__subdf3+0x744>
8000d794:	00f56533          	or	a0,a0,a5
8000d798:	00000793          	li	a5,0
8000d79c:	00050863          	beqz	a0,8000d7ac <__subdf3+0x744>
8000d7a0:	000807b7          	lui	a5,0x80
8000d7a4:	00000513          	li	a0,0
8000d7a8:	00000913          	li	s2,0
8000d7ac:	7ff4f713          	andi	a4,s1,2047
8000d7b0:	00c79793          	slli	a5,a5,0xc
8000d7b4:	01471713          	slli	a4,a4,0x14
8000d7b8:	01c12083          	lw	ra,28(sp)
8000d7bc:	01812403          	lw	s0,24(sp)
8000d7c0:	00c7d793          	srli	a5,a5,0xc
8000d7c4:	01f91593          	slli	a1,s2,0x1f
8000d7c8:	00e7e7b3          	or	a5,a5,a4
8000d7cc:	00b7e733          	or	a4,a5,a1
8000d7d0:	01412483          	lw	s1,20(sp)
8000d7d4:	01012903          	lw	s2,16(sp)
8000d7d8:	00c12983          	lw	s3,12(sp)
8000d7dc:	00070593          	mv	a1,a4
8000d7e0:	02010113          	addi	sp,sp,32
8000d7e4:	00008067          	ret
8000d7e8:	00070793          	mv	a5,a4
8000d7ec:	00060513          	mv	a0,a2
8000d7f0:	00080493          	mv	s1,a6
8000d7f4:	db9ff06f          	j	8000d5ac <__subdf3+0x544>
8000d7f8:	00000793          	li	a5,0
8000d7fc:	00000513          	li	a0,0
8000d800:	00000913          	li	s2,0
8000d804:	f59ff06f          	j	8000d75c <__subdf3+0x6f4>
8000d808:	00000793          	li	a5,0
8000d80c:	ff5ff06f          	j	8000d800 <__subdf3+0x798>
8000d810:	00000513          	li	a0,0
8000d814:	00000913          	li	s2,0
8000d818:	004007b7          	lui	a5,0x400
8000d81c:	b4dff06f          	j	8000d368 <__subdf3+0x300>
8000d820:	00000793          	li	a5,0
8000d824:	00000513          	li	a0,0
8000d828:	f55ff06f          	j	8000d77c <__subdf3+0x714>

8000d82c <__unorddf2>:
8000d82c:	001007b7          	lui	a5,0x100
8000d830:	fff78793          	addi	a5,a5,-1 # fffff <crtStart-0x7ff00001>
8000d834:	00b7f733          	and	a4,a5,a1
8000d838:	0145d593          	srli	a1,a1,0x14
8000d83c:	fff5c593          	not	a1,a1
8000d840:	00d7f7b3          	and	a5,a5,a3
8000d844:	01559813          	slli	a6,a1,0x15
8000d848:	0146d693          	srli	a3,a3,0x14
8000d84c:	7ff6f693          	andi	a3,a3,2047
8000d850:	00081863          	bnez	a6,8000d860 <__unorddf2+0x34>
8000d854:	00a76733          	or	a4,a4,a0
8000d858:	00100513          	li	a0,1
8000d85c:	00071c63          	bnez	a4,8000d874 <__unorddf2+0x48>
8000d860:	7ff00713          	li	a4,2047
8000d864:	00000513          	li	a0,0
8000d868:	00e69663          	bne	a3,a4,8000d874 <__unorddf2+0x48>
8000d86c:	00c7e7b3          	or	a5,a5,a2
8000d870:	00f03533          	snez	a0,a5
8000d874:	00008067          	ret

8000d878 <__fixdfsi>:
8000d878:	0145d713          	srli	a4,a1,0x14
8000d87c:	001006b7          	lui	a3,0x100
8000d880:	fff68793          	addi	a5,a3,-1 # fffff <crtStart-0x7ff00001>
8000d884:	7ff77713          	andi	a4,a4,2047
8000d888:	3fe00613          	li	a2,1022
8000d88c:	00b7f7b3          	and	a5,a5,a1
8000d890:	01f5d593          	srli	a1,a1,0x1f
8000d894:	04e65e63          	bge	a2,a4,8000d8f0 <__fixdfsi+0x78>
8000d898:	41d00613          	li	a2,1053
8000d89c:	00e65a63          	bge	a2,a4,8000d8b0 <__fixdfsi+0x38>
8000d8a0:	80000537          	lui	a0,0x80000
8000d8a4:	fff54513          	not	a0,a0
8000d8a8:	00a58533          	add	a0,a1,a0
8000d8ac:	00008067          	ret
8000d8b0:	00d7e7b3          	or	a5,a5,a3
8000d8b4:	43300693          	li	a3,1075
8000d8b8:	40e686b3          	sub	a3,a3,a4
8000d8bc:	01f00613          	li	a2,31
8000d8c0:	02d64063          	blt	a2,a3,8000d8e0 <__fixdfsi+0x68>
8000d8c4:	bed70713          	addi	a4,a4,-1043
8000d8c8:	00e797b3          	sll	a5,a5,a4
8000d8cc:	00d55533          	srl	a0,a0,a3
8000d8d0:	00a7e533          	or	a0,a5,a0
8000d8d4:	02058063          	beqz	a1,8000d8f4 <__fixdfsi+0x7c>
8000d8d8:	40a00533          	neg	a0,a0
8000d8dc:	00008067          	ret
8000d8e0:	41300513          	li	a0,1043
8000d8e4:	40e50533          	sub	a0,a0,a4
8000d8e8:	00a7d533          	srl	a0,a5,a0
8000d8ec:	fe9ff06f          	j	8000d8d4 <__fixdfsi+0x5c>
8000d8f0:	00000513          	li	a0,0
8000d8f4:	00008067          	ret

8000d8f8 <__floatsidf>:
8000d8f8:	ff010113          	addi	sp,sp,-16
8000d8fc:	00112623          	sw	ra,12(sp)
8000d900:	00812423          	sw	s0,8(sp)
8000d904:	00912223          	sw	s1,4(sp)
8000d908:	08050863          	beqz	a0,8000d998 <__floatsidf+0xa0>
8000d90c:	41f55793          	srai	a5,a0,0x1f
8000d910:	00a7c433          	xor	s0,a5,a0
8000d914:	40f40433          	sub	s0,s0,a5
8000d918:	01f55493          	srli	s1,a0,0x1f
8000d91c:	00040513          	mv	a0,s0
8000d920:	15c000ef          	jal	ra,8000da7c <__clzsi2>
8000d924:	41e00713          	li	a4,1054
8000d928:	00a00793          	li	a5,10
8000d92c:	40a70733          	sub	a4,a4,a0
8000d930:	04a7ca63          	blt	a5,a0,8000d984 <__floatsidf+0x8c>
8000d934:	00b00793          	li	a5,11
8000d938:	40a787b3          	sub	a5,a5,a0
8000d93c:	01550513          	addi	a0,a0,21 # 80000015 <STACK_TOP+0xfffe0015>
8000d940:	00f457b3          	srl	a5,s0,a5
8000d944:	00a41433          	sll	s0,s0,a0
8000d948:	00048513          	mv	a0,s1
8000d94c:	00c79793          	slli	a5,a5,0xc
8000d950:	7ff77713          	andi	a4,a4,2047
8000d954:	01471713          	slli	a4,a4,0x14
8000d958:	00c7d793          	srli	a5,a5,0xc
8000d95c:	01f51513          	slli	a0,a0,0x1f
8000d960:	00e7e7b3          	or	a5,a5,a4
8000d964:	00a7e733          	or	a4,a5,a0
8000d968:	00c12083          	lw	ra,12(sp)
8000d96c:	00040513          	mv	a0,s0
8000d970:	00812403          	lw	s0,8(sp)
8000d974:	00412483          	lw	s1,4(sp)
8000d978:	00070593          	mv	a1,a4
8000d97c:	01010113          	addi	sp,sp,16
8000d980:	00008067          	ret
8000d984:	ff550513          	addi	a0,a0,-11
8000d988:	00a417b3          	sll	a5,s0,a0
8000d98c:	00048513          	mv	a0,s1
8000d990:	00000413          	li	s0,0
8000d994:	fb9ff06f          	j	8000d94c <__floatsidf+0x54>
8000d998:	00000713          	li	a4,0
8000d99c:	00000793          	li	a5,0
8000d9a0:	ff1ff06f          	j	8000d990 <__floatsidf+0x98>

8000d9a4 <__mulsi3>:
8000d9a4:	00050613          	mv	a2,a0
8000d9a8:	00000513          	li	a0,0
8000d9ac:	0015f693          	andi	a3,a1,1
8000d9b0:	00068463          	beqz	a3,8000d9b8 <__mulsi3+0x14>
8000d9b4:	00c50533          	add	a0,a0,a2
8000d9b8:	0015d593          	srli	a1,a1,0x1
8000d9bc:	00161613          	slli	a2,a2,0x1
8000d9c0:	fe0596e3          	bnez	a1,8000d9ac <__mulsi3+0x8>
8000d9c4:	00008067          	ret

8000d9c8 <__divsi3>:
8000d9c8:	06054063          	bltz	a0,8000da28 <__umodsi3+0x10>
8000d9cc:	0605c663          	bltz	a1,8000da38 <__umodsi3+0x20>

8000d9d0 <__udivsi3>:
8000d9d0:	00058613          	mv	a2,a1
8000d9d4:	00050593          	mv	a1,a0
8000d9d8:	fff00513          	li	a0,-1
8000d9dc:	02060c63          	beqz	a2,8000da14 <__udivsi3+0x44>
8000d9e0:	00100693          	li	a3,1
8000d9e4:	00b67a63          	bgeu	a2,a1,8000d9f8 <__udivsi3+0x28>
8000d9e8:	00c05863          	blez	a2,8000d9f8 <__udivsi3+0x28>
8000d9ec:	00161613          	slli	a2,a2,0x1
8000d9f0:	00169693          	slli	a3,a3,0x1
8000d9f4:	feb66ae3          	bltu	a2,a1,8000d9e8 <__udivsi3+0x18>
8000d9f8:	00000513          	li	a0,0
8000d9fc:	00c5e663          	bltu	a1,a2,8000da08 <__udivsi3+0x38>
8000da00:	40c585b3          	sub	a1,a1,a2
8000da04:	00d56533          	or	a0,a0,a3
8000da08:	0016d693          	srli	a3,a3,0x1
8000da0c:	00165613          	srli	a2,a2,0x1
8000da10:	fe0696e3          	bnez	a3,8000d9fc <__udivsi3+0x2c>
8000da14:	00008067          	ret

8000da18 <__umodsi3>:
8000da18:	00008293          	mv	t0,ra
8000da1c:	fb5ff0ef          	jal	ra,8000d9d0 <__udivsi3>
8000da20:	00058513          	mv	a0,a1
8000da24:	00028067          	jr	t0
8000da28:	40a00533          	neg	a0,a0
8000da2c:	0005d863          	bgez	a1,8000da3c <__umodsi3+0x24>
8000da30:	40b005b3          	neg	a1,a1
8000da34:	f9dff06f          	j	8000d9d0 <__udivsi3>
8000da38:	40b005b3          	neg	a1,a1
8000da3c:	00008293          	mv	t0,ra
8000da40:	f91ff0ef          	jal	ra,8000d9d0 <__udivsi3>
8000da44:	40a00533          	neg	a0,a0
8000da48:	00028067          	jr	t0

8000da4c <__modsi3>:
8000da4c:	00008293          	mv	t0,ra
8000da50:	0005ca63          	bltz	a1,8000da64 <__modsi3+0x18>
8000da54:	00054c63          	bltz	a0,8000da6c <__modsi3+0x20>
8000da58:	f79ff0ef          	jal	ra,8000d9d0 <__udivsi3>
8000da5c:	00058513          	mv	a0,a1
8000da60:	00028067          	jr	t0
8000da64:	40b005b3          	neg	a1,a1
8000da68:	fe0558e3          	bgez	a0,8000da58 <__modsi3+0xc>
8000da6c:	40a00533          	neg	a0,a0
8000da70:	f61ff0ef          	jal	ra,8000d9d0 <__udivsi3>
8000da74:	40b00533          	neg	a0,a1
8000da78:	00028067          	jr	t0

8000da7c <__clzsi2>:
8000da7c:	000107b7          	lui	a5,0x10
8000da80:	02f57a63          	bgeu	a0,a5,8000dab4 <__clzsi2+0x38>
8000da84:	0ff00793          	li	a5,255
8000da88:	00a7b7b3          	sltu	a5,a5,a0
8000da8c:	00379793          	slli	a5,a5,0x3
8000da90:	02000713          	li	a4,32
8000da94:	40f70733          	sub	a4,a4,a5
8000da98:	00f557b3          	srl	a5,a0,a5
8000da9c:	00001517          	auipc	a0,0x1
8000daa0:	ef450513          	addi	a0,a0,-268 # 8000e990 <__clz_tab>
8000daa4:	00f507b3          	add	a5,a0,a5
8000daa8:	0007c503          	lbu	a0,0(a5) # 10000 <crtStart-0x7fff0000>
8000daac:	40a70533          	sub	a0,a4,a0
8000dab0:	00008067          	ret
8000dab4:	01000737          	lui	a4,0x1000
8000dab8:	01000793          	li	a5,16
8000dabc:	fce56ae3          	bltu	a0,a4,8000da90 <__clzsi2+0x14>
8000dac0:	01800793          	li	a5,24
8000dac4:	fcdff06f          	j	8000da90 <__clzsi2+0x14>

Disassembly of section .text.startup:

8000dac8 <main>:
int main() {
8000dac8:	fd010113          	addi	sp,sp,-48
    overlay(1);
8000dacc:	00100513          	li	a0,1
int main() {
8000dad0:	02112623          	sw	ra,44(sp)
8000dad4:	02912223          	sw	s1,36(sp)
8000dad8:	03212023          	sw	s2,32(sp)
8000dadc:	01312e23          	sw	s3,28(sp)
8000dae0:	02812423          	sw	s0,40(sp)
8000dae4:	01412c23          	sw	s4,24(sp)
8000dae8:	01512a23          	sw	s5,20(sp)
8000daec:	01612823          	sw	s6,16(sp)
    overlay(1);
8000daf0:	920f40ef          	jal	ra,80001c10 <overlay>
    reg_uart_clkdiv = 138; // 16777216 / 115200;
8000daf4:	020007b7          	lui	a5,0x2000
8000daf8:	08a00713          	li	a4,138
8000dafc:	00e7a823          	sw	a4,16(a5) # 2000010 <crtStart-0x7dfffff0>
    sd_init();
8000db00:	c40f50ef          	jal	ra,80002f40 <sd_init>
    delay(100);
8000db04:	06400513          	li	a0,100
8000db08:	979f40ef          	jal	ra,80002480 <delay>
    while(!mounted) {
8000db0c:	8000e937          	lui	s2,0x8000e
8000db10:	800104b7          	lui	s1,0x80010
8000db14:	8000e9b7          	lui	s3,0x8000e
int main() {
8000db18:	0ff00413          	li	s0,255
8000db1c:	0080006f          	j	8000db24 <main+0x5c>
        for (int attempts = 0; attempts < 255; attempts++) {
8000db20:	10040263          	beqz	s0,8000dc24 <main+0x15c>
            if (f_mount(&fs, "", 0) == FR_OK) {
8000db24:	00000613          	li	a2,0
8000db28:	05890593          	addi	a1,s2,88 # 8000e058 <STACK_TOP+0xfffee058>
8000db2c:	5f448513          	addi	a0,s1,1524 # 800105f4 <STACK_TOP+0xffff05f4>
8000db30:	84df90ef          	jal	ra,8000737c <f_mount>
8000db34:	fff40413          	addi	s0,s0,-1
8000db38:	fe0514e3          	bnez	a0,8000db20 <main+0x58>
    int r = load_option();
8000db3c:	f7cf20ef          	jal	ra,800002b8 <load_option>
    if (r == 2) {	// file corrupt
8000db40:	00200793          	li	a5,2
8000db44:	0ef50863          	beq	a0,a5,8000dc34 <main+0x16c>
8000db48:	8000eb37          	lui	s6,0x8000e
8000db4c:	8000eab7          	lui	s5,0x8000e
8000db50:	8000ea37          	lui	s4,0x8000e
8000db54:	8000e9b7          	lui	s3,0x8000e
8000db58:	8000e937          	lui	s2,0x8000e
8000db5c:	8000f4b7          	lui	s1,0x8000f
            int r = joy_choice(12, 3, &choice, OSD_KEY_CODE);
8000db60:	00100413          	li	s0,1
        clear();
8000db64:	829f40ef          	jal	ra,8000238c <clear>
        cursor(2, 5);
8000db68:	00500593          	li	a1,5
8000db6c:	00200513          	li	a0,2
8000db70:	88cf40ef          	jal	ra,80001bfc <cursor>
        print("### Welcome to VexGBA ###");
8000db74:	1c0b0513          	addi	a0,s6,448 # 8000e1c0 <STACK_TOP+0xfffee1c0>
8000db78:	990f40ef          	jal	ra,80001d08 <print>
        cursor(2, 12);
8000db7c:	00c00593          	li	a1,12
8000db80:	00200513          	li	a0,2
8000db84:	878f40ef          	jal	ra,80001bfc <cursor>
        print("1) Load ROM from SD card\n");
8000db88:	1dca8513          	addi	a0,s5,476 # 8000e1dc <STACK_TOP+0xfffee1dc>
8000db8c:	97cf40ef          	jal	ra,80001d08 <print>
        cursor(2, 14);
8000db90:	00e00593          	li	a1,14
8000db94:	00200513          	li	a0,2
8000db98:	864f40ef          	jal	ra,80001bfc <cursor>
        print("2) Options\n");
8000db9c:	1f8a0513          	addi	a0,s4,504 # 8000e1f8 <STACK_TOP+0xfffee1f8>
8000dba0:	968f40ef          	jal	ra,80001d08 <print>
        cursor(2, 16);
8000dba4:	01000593          	li	a1,16
8000dba8:	00200513          	li	a0,2
8000dbac:	850f40ef          	jal	ra,80001bfc <cursor>
        print("Version: ");
8000dbb0:	20498513          	addi	a0,s3,516 # 8000e204 <STACK_TOP+0xfffee204>
8000dbb4:	954f40ef          	jal	ra,80001d08 <print>
        print(__DATE__);
8000dbb8:	21090513          	addi	a0,s2,528 # 8000e210 <STACK_TOP+0xfffee210>
8000dbbc:	94cf40ef          	jal	ra,80001d08 <print>
        delay(300);
8000dbc0:	12c00513          	li	a0,300
8000dbc4:	8bdf40ef          	jal	ra,80002480 <delay>
        int choice = 0;
8000dbc8:	00012423          	sw	zero,8(sp)
            int r = joy_choice(12, 3, &choice, OSD_KEY_CODE);
8000dbcc:	b704a783          	lw	a5,-1168(s1) # 8000eb70 <STACK_TOP+0xfffeeb70>
8000dbd0:	00810613          	addi	a2,sp,8
8000dbd4:	00300593          	li	a1,3
8000dbd8:	00c00513          	li	a0,12
8000dbdc:	00c00693          	li	a3,12
8000dbe0:	00878463          	beq	a5,s0,8000dbe8 <main+0x120>
8000dbe4:	08400693          	li	a3,132
8000dbe8:	8d5f40ef          	jal	ra,800024bc <joy_choice>
            if (r == 1) break;
8000dbec:	fe8510e3          	bne	a0,s0,8000dbcc <main+0x104>
        if (choice == 0) {
8000dbf0:	00812783          	lw	a5,8(sp)
8000dbf4:	00079c63          	bnez	a5,8000dc0c <main+0x144>
            delay(300);
8000dbf8:	12c00513          	li	a0,300
8000dbfc:	885f40ef          	jal	ra,80002480 <delay>
            menu_loadrom(&rom);
8000dc00:	00c10513          	addi	a0,sp,12
8000dc04:	a41f30ef          	jal	ra,80001644 <menu_loadrom>
8000dc08:	f5dff06f          	j	8000db64 <main+0x9c>
        } else if (choice == 2) {
8000dc0c:	00200713          	li	a4,2
8000dc10:	f4e79ae3          	bne	a5,a4,8000db64 <main+0x9c>
            delay(300);
8000dc14:	12c00513          	li	a0,300
8000dc18:	869f40ef          	jal	ra,80002480 <delay>
            menu_options();
8000dc1c:	f7df20ef          	jal	ra,80000b98 <menu_options>
            continue;
8000dc20:	f45ff06f          	j	8000db64 <main+0x9c>
            message("Insert SD card and press any key", 1);
8000dc24:	00100593          	li	a1,1
8000dc28:	21c98513          	addi	a0,s3,540
8000dc2c:	b05f20ef          	jal	ra,80000730 <message>
8000dc30:	ee9ff06f          	j	8000db18 <main+0x50>
        clear();
8000dc34:	f58f40ef          	jal	ra,8000238c <clear>
        message("Option file corrupt and is not loaded",1);
8000dc38:	8000e537          	lui	a0,0x8000e
8000dc3c:	00100593          	li	a1,1
8000dc40:	19850513          	addi	a0,a0,408 # 8000e198 <STACK_TOP+0xfffee198>
8000dc44:	aedf20ef          	jal	ra,80000730 <message>
8000dc48:	f01ff06f          	j	8000db48 <main+0x80>
