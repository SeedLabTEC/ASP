	.file	"mips.c"
	.option nopic
	.comm	main_result,4,4
	.globl	imem
	.section	.rodata
	.align	2
	.type	imem, @object
	.size	imem, 176
imem:
	.word	-1885077504
	.word	665124868
	.word	614858756
	.word	266368
	.word	12726305
	.word	202375190
	.word	0
	.word	872546314
	.word	12
	.word	1006702593
	.word	875036672
	.word	280704
	.word	17385505
	.word	-1926627328
	.word	350336
	.word	17520673
	.word	-1922301952
	.word	25847850
	.word	295698435
	.word	-1389625344
	.word	-1385562112
	.word	65011720
	.word	666763252
	.word	-1346437112
	.word	-1347354620
	.word	-1347420160
	.word	605028352
	.word	705167368
	.word	285212683
	.word	638648321
	.word	707264520
	.word	285212678
	.word	637796352
	.word	639959040
	.word	202375177
	.word	640745473
	.word	135266334
	.word	638582785
	.word	135266331
	.word	-1883308024
	.word	-1884225532
	.word	-1884291072
	.word	666697740
	.word	65011720
	.globl	A
	.align	2
	.type	A, @object
	.size	A, 32
A:
	.word	22
	.word	5
	.word	-9
	.word	3
	.word	-17
	.word	38
	.word	0
	.word	11
	.globl	outData
	.align	2
	.type	outData, @object
	.size	outData, 32
outData:
	.word	-17
	.word	-9
	.word	0
	.word	3
	.word	5
	.word	11
	.word	22
	.word	38
	.globl	__muldi3
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-528
	sw	ra,524(sp)
	sw	s0,520(sp)
	sw	s2,516(sp)
	sw	s3,512(sp)
	sw	s4,508(sp)
	sw	s5,504(sp)
	sw	s6,500(sp)
	sw	s7,496(sp)
	sw	s8,492(sp)
	sw	s9,488(sp)
	sw	s10,484(sp)
	sw	s11,480(sp)
	addi	s0,sp,528
	sw	zero,-52(s0)
	sw	zero,-56(s0)
	sw	zero,-60(s0)
	sw	zero,-72(s0)
	lui	a5,%hi(main_result)
	sw	zero,%lo(main_result)(a5)
	sw	zero,-68(s0)
	j	.L2
.L3:
	lw	a5,-68(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	sw	zero,-196(a5)
	lw	a5,-68(s0)
	addi	a5,a5,1
	sw	a5,-68(s0)
.L2:
	lw	a4,-68(s0)
	li	a5,31
	ble	a4,a5,.L3
	li	a5,2147479552
	addi	a5,a5,-4
	sw	a5,-128(s0)
	sw	zero,-68(s0)
	j	.L4
.L5:
	lui	a5,%hi(A)
	lw	a4,-68(s0)
	slli	a4,a4,2
	addi	a5,a5,%lo(A)
	add	a5,a4,a5
	lw	a4,0(a5)
	lw	a5,-68(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	sw	a4,-452(a5)
	lw	a5,-68(s0)
	addi	a5,a5,1
	sw	a5,-68(s0)
.L4:
	lw	a4,-68(s0)
	li	a5,63
	ble	a4,a5,.L5
	li	a5,4194304
	sw	a5,-60(s0)
.L48:
	lw	a5,-60(s0)
	srai	a5,a5,2
	andi	a4,a5,63
	lui	a5,%hi(imem)
	slli	a4,a4,2
	addi	a5,a5,%lo(imem)
	add	a5,a4,a5
	lw	a5,0(a5)
	sw	a5,-76(s0)
	lw	a5,-60(s0)
	addi	a5,a5,4
	sw	a5,-60(s0)
	lw	a5,-76(s0)
	srli	a5,a5,26
	sw	a5,-80(s0)
	lw	a5,-80(s0)
	li	a4,2
	beq	a5,a4,.L7
	li	a4,3
	beq	a5,a4,.L8
	bnez	a5,.L52
	lw	a5,-76(s0)
	andi	a5,a5,63
	sw	a5,-88(s0)
	lw	a5,-76(s0)
	srli	a5,a5,6
	andi	a5,a5,31
	sw	a5,-92(s0)
	lw	a5,-76(s0)
	srli	a5,a5,11
	andi	a5,a5,31
	sw	a5,-96(s0)
	lw	a5,-76(s0)
	srli	a5,a5,16
	andi	a5,a5,31
	sw	a5,-100(s0)
	lw	a5,-76(s0)
	srli	a5,a5,21
	andi	a5,a5,31
	sw	a5,-104(s0)
	lw	a4,-88(s0)
	li	a5,43
	bgtu	a4,a5,.L10
	lw	a5,-88(s0)
	slli	a4,a5,2
	lui	a5,%hi(.L12)
	addi	a5,a5,%lo(.L12)
	add	a5,a4,a5
	lw	a5,0(a5)
	jr	a5
	.section	.rodata
	.align	2
	.align	2
.L12:
	.word	.L11
	.word	.L10
	.word	.L13
	.word	.L10
	.word	.L14
	.word	.L10
	.word	.L15
	.word	.L10
	.word	.L16
	.word	.L10
	.word	.L10
	.word	.L10
	.word	.L10
	.word	.L10
	.word	.L10
	.word	.L10
	.word	.L17
	.word	.L10
	.word	.L18
	.word	.L10
	.word	.L10
	.word	.L10
	.word	.L10
	.word	.L10
	.word	.L19
	.word	.L20
	.word	.L10
	.word	.L10
	.word	.L10
	.word	.L10
	.word	.L10
	.word	.L10
	.word	.L10
	.word	.L21
	.word	.L10
	.word	.L22
	.word	.L23
	.word	.L24
	.word	.L25
	.word	.L10
	.word	.L10
	.word	.L10
	.word	.L26
	.word	.L27
	.text
.L21:
	lw	a5,-104(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a4,-196(a5)
	lw	a5,-100(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	lw	a5,-196(a5)
	add	a4,a4,a5
	lw	a5,-96(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	sw	a4,-196(a5)
	j	.L28
.L22:
	lw	a5,-104(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a4,-196(a5)
	lw	a5,-100(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	lw	a5,-196(a5)
	sub	a4,a4,a5
	lw	a5,-96(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	sw	a4,-196(a5)
	j	.L28
.L19:
	lw	a5,-104(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a5,-196(a5)
	mv	s6,a5
	srai	a5,a5,31
	mv	s7,a5
	lw	a5,-100(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a5,-196(a5)
	mv	s8,a5
	srai	a5,a5,31
	mv	s9,a5
	mv	a2,s8
	mv	a3,s9
	mv	a0,s6
	mv	a1,s7
	call	__muldi3
	mv	a5,a0
	mv	a6,a1
	sw	a5,-112(s0)
	sw	a6,-108(s0)
	lw	a5,-112(s0)
	sw	a5,-56(s0)
	lw	a5,-108(s0)
	srai	s2,a5,0
	lw	a5,-108(s0)
	srai	s3,a5,31
	sw	s2,-52(s0)
	j	.L28
.L20:
	lw	a5,-104(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a5,-196(a5)
	mv	s10,a5
	li	s11,0
	lw	a5,-100(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a5,-196(a5)
	sw	a5,-520(s0)
	sw	zero,-516(s0)
	lw	a2,-520(s0)
	lw	a3,-516(s0)
	mv	a0,s10
	mv	a1,s11
	call	__muldi3
	mv	a5,a0
	mv	a6,a1
	sw	a5,-112(s0)
	sw	a6,-108(s0)
	lw	a5,-112(s0)
	sw	a5,-56(s0)
	lw	a5,-108(s0)
	srai	s4,a5,0
	lw	a5,-108(s0)
	srai	s5,a5,31
	sw	s4,-52(s0)
	j	.L28
.L17:
	lw	a5,-96(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a4,-52(s0)
	sw	a4,-196(a5)
	j	.L28
.L18:
	lw	a5,-96(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a4,-56(s0)
	sw	a4,-196(a5)
	j	.L28
.L23:
	lw	a5,-104(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a4,-196(a5)
	lw	a5,-100(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	lw	a5,-196(a5)
	and	a4,a4,a5
	lw	a5,-96(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	sw	a4,-196(a5)
	j	.L28
.L24:
	lw	a5,-104(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a4,-196(a5)
	lw	a5,-100(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	lw	a5,-196(a5)
	or	a4,a4,a5
	lw	a5,-96(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	sw	a4,-196(a5)
	j	.L28
.L25:
	lw	a5,-104(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a4,-196(a5)
	lw	a5,-100(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	lw	a5,-196(a5)
	xor	a4,a4,a5
	lw	a5,-96(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	sw	a4,-196(a5)
	j	.L28
.L11:
	lw	a5,-100(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a4,-196(a5)
	lw	a5,-92(s0)
	sll	a4,a4,a5
	lw	a5,-96(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	sw	a4,-196(a5)
	j	.L28
.L13:
	lw	a5,-100(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a4,-196(a5)
	lw	a5,-92(s0)
	sra	a4,a4,a5
	lw	a5,-96(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	sw	a4,-196(a5)
	j	.L28
.L14:
	lw	a5,-100(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a4,-196(a5)
	lw	a5,-104(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	lw	a5,-196(a5)
	sll	a4,a4,a5
	lw	a5,-96(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	sw	a4,-196(a5)
	j	.L28
.L15:
	lw	a5,-100(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a4,-196(a5)
	lw	a5,-104(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	lw	a5,-196(a5)
	sra	a4,a4,a5
	lw	a5,-96(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	sw	a4,-196(a5)
	j	.L28
.L26:
	lw	a5,-104(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a4,-196(a5)
	lw	a5,-100(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	lw	a5,-196(a5)
	slt	a5,a4,a5
	andi	a5,a5,0xff
	mv	a4,a5
	lw	a5,-96(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	sw	a4,-196(a5)
	j	.L28
.L27:
	lw	a5,-104(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a5,-196(a5)
	mv	a4,a5
	lw	a5,-100(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	lw	a5,-196(a5)
	sltu	a5,a4,a5
	andi	a5,a5,0xff
	mv	a4,a5
	lw	a5,-96(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	sw	a4,-196(a5)
	j	.L28
.L16:
	lw	a5,-104(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a5,-196(a5)
	sw	a5,-60(s0)
	j	.L28
.L10:
	sw	zero,-60(s0)
	nop
.L28:
	j	.L29
.L7:
	lw	a4,-76(s0)
	li	a5,67108864
	addi	a5,a5,-1
	and	a5,a4,a5
	sw	a5,-84(s0)
	lw	a5,-84(s0)
	slli	a5,a5,2
	sw	a5,-60(s0)
	j	.L29
.L8:
	lw	a4,-76(s0)
	li	a5,67108864
	addi	a5,a5,-1
	and	a5,a4,a5
	sw	a5,-84(s0)
	lw	a5,-60(s0)
	sw	a5,-120(s0)
	lw	a5,-84(s0)
	slli	a5,a5,2
	sw	a5,-60(s0)
	j	.L29
.L52:
	lw	a5,-76(s0)
	sh	a5,-114(s0)
	lw	a5,-76(s0)
	srli	a5,a5,16
	andi	a5,a5,31
	sw	a5,-100(s0)
	lw	a5,-76(s0)
	srli	a5,a5,21
	andi	a5,a5,31
	sw	a5,-104(s0)
	lw	a4,-80(s0)
	li	a5,43
	bgtu	a4,a5,.L30
	lw	a5,-80(s0)
	slli	a4,a5,2
	lui	a5,%hi(.L32)
	addi	a5,a5,%lo(.L32)
	add	a5,a4,a5
	lw	a5,0(a5)
	jr	a5
	.section	.rodata
	.align	2
	.align	2
.L32:
	.word	.L30
	.word	.L31
	.word	.L30
	.word	.L30
	.word	.L33
	.word	.L34
	.word	.L30
	.word	.L30
	.word	.L30
	.word	.L35
	.word	.L36
	.word	.L37
	.word	.L38
	.word	.L39
	.word	.L40
	.word	.L41
	.word	.L30
	.word	.L30
	.word	.L30
	.word	.L30
	.word	.L30
	.word	.L30
	.word	.L30
	.word	.L30
	.word	.L30
	.word	.L30
	.word	.L30
	.word	.L30
	.word	.L30
	.word	.L30
	.word	.L30
	.word	.L30
	.word	.L30
	.word	.L30
	.word	.L30
	.word	.L42
	.word	.L30
	.word	.L30
	.word	.L30
	.word	.L30
	.word	.L30
	.word	.L30
	.word	.L30
	.word	.L43
	.text
.L35:
	lw	a5,-104(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a4,-196(a5)
	lh	a5,-114(s0)
	add	a4,a4,a5
	lw	a5,-100(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	sw	a4,-196(a5)
	j	.L44
.L38:
	lw	a5,-104(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a5,-196(a5)
	lhu	a4,-114(s0)
	and	a4,a5,a4
	lw	a5,-100(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	sw	a4,-196(a5)
	j	.L44
.L39:
	lw	a5,-104(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a5,-196(a5)
	lhu	a4,-114(s0)
	or	a4,a5,a4
	lw	a5,-100(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	sw	a4,-196(a5)
	j	.L44
.L40:
	lw	a5,-104(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a5,-196(a5)
	lhu	a4,-114(s0)
	xor	a4,a5,a4
	lw	a5,-100(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	sw	a4,-196(a5)
	j	.L44
.L42:
	lw	a5,-104(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a4,-196(a5)
	lh	a5,-114(s0)
	add	a5,a4,a5
	srai	a5,a5,2
	andi	a5,a5,63
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a4,-452(a5)
	lw	a5,-100(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	sw	a4,-196(a5)
	j	.L44
.L43:
	lw	a5,-104(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a4,-196(a5)
	lh	a5,-114(s0)
	add	a5,a4,a5
	srai	a5,a5,2
	andi	a3,a5,63
	lw	a5,-100(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a4,-196(a5)
	slli	a5,a3,2
	addi	a3,s0,-48
	add	a5,a3,a5
	sw	a4,-452(a5)
	j	.L44
.L41:
	lh	a5,-114(s0)
	slli	a4,a5,16
	lw	a5,-100(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	sw	a4,-196(a5)
	j	.L44
.L33:
	lw	a5,-104(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a4,-196(a5)
	lw	a5,-100(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	lw	a5,-196(a5)
	bne	a4,a5,.L53
	lw	a5,-60(s0)
	addi	a4,a5,-4
	lh	a5,-114(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	sw	a5,-60(s0)
	j	.L53
.L34:
	lw	a5,-104(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a4,-196(a5)
	lw	a5,-100(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	lw	a5,-196(a5)
	beq	a4,a5,.L54
	lw	a5,-60(s0)
	addi	a4,a5,-4
	lh	a5,-114(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	sw	a5,-60(s0)
	j	.L54
.L31:
	lw	a5,-104(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a5,-196(a5)
	bltz	a5,.L55
	lw	a5,-60(s0)
	addi	a4,a5,-4
	lh	a5,-114(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	sw	a5,-60(s0)
	j	.L55
.L36:
	lw	a5,-104(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a4,-196(a5)
	lh	a5,-114(s0)
	slt	a5,a4,a5
	andi	a5,a5,0xff
	mv	a4,a5
	lw	a5,-100(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	sw	a4,-196(a5)
	j	.L44
.L37:
	lw	a5,-104(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a5,-196(a5)
	mv	a4,a5
	lhu	a5,-114(s0)
	sltu	a5,a4,a5
	andi	a5,a5,0xff
	mv	a4,a5
	lw	a5,-100(s0)
	slli	a5,a5,2
	addi	a3,s0,-48
	add	a5,a3,a5
	sw	a4,-196(a5)
	j	.L44
.L30:
	sw	zero,-60(s0)
	j	.L44
.L53:
	nop
	j	.L56
.L54:
	nop
	j	.L56
.L55:
	nop
.L44:
.L56:
	nop
.L29:
	sw	zero,-244(s0)
	lw	a5,-72(s0)
	addi	a5,a5,1
	sw	a5,-72(s0)
	lw	a5,-60(s0)
	bnez	a5,.L48
	lw	a5,-72(s0)
	addi	a5,a5,-611
	snez	a5,a5
	andi	a5,a5,0xff
	mv	a4,a5
	lui	a5,%hi(main_result)
	lw	a5,%lo(main_result)(a5)
	add	a4,a4,a5
	lui	a5,%hi(main_result)
	sw	a4,%lo(main_result)(a5)
	sw	zero,-64(s0)
	j	.L49
.L50:
	lw	a5,-64(s0)
	slli	a5,a5,2
	addi	a4,s0,-48
	add	a5,a4,a5
	lw	a4,-452(a5)
	lui	a5,%hi(outData)
	lw	a3,-64(s0)
	slli	a3,a3,2
	addi	a5,a5,%lo(outData)
	add	a5,a3,a5
	lw	a5,0(a5)
	sub	a5,a4,a5
	snez	a5,a5
	andi	a5,a5,0xff
	mv	a4,a5
	lui	a5,%hi(main_result)
	lw	a5,%lo(main_result)(a5)
	add	a4,a4,a5
	lui	a5,%hi(main_result)
	sw	a4,%lo(main_result)(a5)
	lw	a5,-64(s0)
	addi	a5,a5,1
	sw	a5,-64(s0)
.L49:
	lw	a4,-64(s0)
	li	a5,7
	ble	a4,a5,.L50
	lui	a5,%hi(main_result)
	lw	a5,%lo(main_result)(a5)
	mv	a0,a5
	lw	ra,524(sp)
	lw	s0,520(sp)
	lw	s2,516(sp)
	lw	s3,512(sp)
	lw	s4,508(sp)
	lw	s5,504(sp)
	lw	s6,500(sp)
	lw	s7,496(sp)
	lw	s8,492(sp)
	lw	s9,488(sp)
	lw	s10,484(sp)
	lw	s11,480(sp)
	addi	sp,sp,528
	jr	ra
	.size	main, .-main
	.ident	"GCC: (GNU) 7.2.0"