	.file	"adpcm.c"
	.option nopic
	.comm	tqmf,96,4
	.globl	h
	.section	.rodata
	.align	2
	.type	h, @object
	.size	h, 96
h:
	.word	12
	.word	-44
	.word	-44
	.word	212
	.word	48
	.word	-624
	.word	128
	.word	1448
	.word	-840
	.word	-3220
	.word	3804
	.word	15504
	.word	15504
	.word	3804
	.word	-3220
	.word	-840
	.word	1448
	.word	128
	.word	-624
	.word	48
	.word	212
	.word	-44
	.word	-44
	.word	12
	.comm	xl,4,4
	.comm	xh,4,4
	.comm	accumc,44,4
	.comm	accumd,44,4
	.comm	xout1,4,4
	.comm	xout2,4,4
	.comm	xs,4,4
	.comm	xd,4,4
	.comm	il,4,4
	.comm	szl,4,4
	.comm	spl,4,4
	.comm	sl,4,4
	.comm	el,4,4
	.globl	qq4_code4_table
	.align	2
	.type	qq4_code4_table, @object
	.size	qq4_code4_table, 64
qq4_code4_table:
	.word	0
	.word	-20456
	.word	-12896
	.word	-8968
	.word	-6288
	.word	-4240
	.word	-2584
	.word	-1200
	.word	20456
	.word	12896
	.word	8968
	.word	6288
	.word	4240
	.word	2584
	.word	1200
	.word	0
	.globl	qq6_code6_table
	.align	2
	.type	qq6_code6_table, @object
	.size	qq6_code6_table, 256
qq6_code6_table:
	.word	-136
	.word	-136
	.word	-136
	.word	-136
	.word	-24808
	.word	-21904
	.word	-19008
	.word	-16704
	.word	-14984
	.word	-13512
	.word	-12280
	.word	-11192
	.word	-10232
	.word	-9360
	.word	-8576
	.word	-7856
	.word	-7192
	.word	-6576
	.word	-6000
	.word	-5456
	.word	-4944
	.word	-4464
	.word	-4008
	.word	-3576
	.word	-3168
	.word	-2776
	.word	-2400
	.word	-2032
	.word	-1688
	.word	-1360
	.word	-1040
	.word	-728
	.word	24808
	.word	21904
	.word	19008
	.word	16704
	.word	14984
	.word	13512
	.word	12280
	.word	11192
	.word	10232
	.word	9360
	.word	8576
	.word	7856
	.word	7192
	.word	6576
	.word	6000
	.word	5456
	.word	4944
	.word	4464
	.word	4008
	.word	3576
	.word	3168
	.word	2776
	.word	2400
	.word	2032
	.word	1688
	.word	1360
	.word	1040
	.word	728
	.word	432
	.word	136
	.word	-432
	.word	-136
	.comm	delay_bpl,24,4
	.comm	delay_dltx,24,4
	.globl	wl_code_table
	.align	2
	.type	wl_code_table, @object
	.size	wl_code_table, 64
wl_code_table:
	.word	-60
	.word	3042
	.word	1198
	.word	538
	.word	334
	.word	172
	.word	58
	.word	-30
	.word	3042
	.word	1198
	.word	538
	.word	334
	.word	172
	.word	58
	.word	-30
	.word	-60
	.globl	ilb_table
	.align	2
	.type	ilb_table, @object
	.size	ilb_table, 128
ilb_table:
	.word	2048
	.word	2093
	.word	2139
	.word	2186
	.word	2233
	.word	2282
	.word	2332
	.word	2383
	.word	2435
	.word	2489
	.word	2543
	.word	2599
	.word	2656
	.word	2714
	.word	2774
	.word	2834
	.word	2896
	.word	2960
	.word	3025
	.word	3091
	.word	3158
	.word	3228
	.word	3298
	.word	3371
	.word	3444
	.word	3520
	.word	3597
	.word	3676
	.word	3756
	.word	3838
	.word	3922
	.word	4008
	.comm	nbl,4,4
	.comm	al1,4,4
	.comm	al2,4,4
	.comm	plt,4,4
	.comm	plt1,4,4
	.comm	plt2,4,4
	.comm	dlt,4,4
	.comm	rlt,4,4
	.comm	rlt1,4,4
	.comm	rlt2,4,4
	.globl	decis_levl
	.align	2
	.type	decis_levl, @object
	.size	decis_levl, 120
decis_levl:
	.word	280
	.word	576
	.word	880
	.word	1200
	.word	1520
	.word	1864
	.word	2208
	.word	2584
	.word	2960
	.word	3376
	.word	3784
	.word	4240
	.word	4696
	.word	5200
	.word	5712
	.word	6288
	.word	6864
	.word	7520
	.word	8184
	.word	8968
	.word	9752
	.word	10712
	.word	11664
	.word	12896
	.word	14120
	.word	15840
	.word	17560
	.word	20456
	.word	23352
	.word	32767
	.comm	detl,4,4
	.globl	quant26bt_pos
	.align	2
	.type	quant26bt_pos, @object
	.size	quant26bt_pos, 124
quant26bt_pos:
	.word	61
	.word	60
	.word	59
	.word	58
	.word	57
	.word	56
	.word	55
	.word	54
	.word	53
	.word	52
	.word	51
	.word	50
	.word	49
	.word	48
	.word	47
	.word	46
	.word	45
	.word	44
	.word	43
	.word	42
	.word	41
	.word	40
	.word	39
	.word	38
	.word	37
	.word	36
	.word	35
	.word	34
	.word	33
	.word	32
	.word	32
	.globl	quant26bt_neg
	.align	2
	.type	quant26bt_neg, @object
	.size	quant26bt_neg, 124
quant26bt_neg:
	.word	63
	.word	62
	.word	31
	.word	30
	.word	29
	.word	28
	.word	27
	.word	26
	.word	25
	.word	24
	.word	23
	.word	22
	.word	21
	.word	20
	.word	19
	.word	18
	.word	17
	.word	16
	.word	15
	.word	14
	.word	13
	.word	12
	.word	11
	.word	10
	.word	9
	.word	8
	.word	7
	.word	6
	.word	5
	.word	4
	.word	4
	.comm	deth,4,4
	.comm	sh,4,4
	.comm	eh,4,4
	.globl	qq2_code2_table
	.align	2
	.type	qq2_code2_table, @object
	.size	qq2_code2_table, 16
qq2_code2_table:
	.word	-7408
	.word	-1616
	.word	7408
	.word	1616
	.globl	wh_code_table
	.align	2
	.type	wh_code_table, @object
	.size	wh_code_table, 16
wh_code_table:
	.word	798
	.word	-214
	.word	798
	.word	-214
	.comm	dh,4,4
	.comm	ih,4,4
	.comm	nbh,4,4
	.comm	szh,4,4
	.comm	sph,4,4
	.comm	ph,4,4
	.comm	yh,4,4
	.comm	rh,4,4
	.comm	delay_dhx,24,4
	.comm	delay_bph,24,4
	.comm	ah1,4,4
	.comm	ah2,4,4
	.comm	ph1,4,4
	.comm	ph2,4,4
	.comm	rh1,4,4
	.comm	rh2,4,4
	.comm	ilr,4,4
	.comm	rl,4,4
	.comm	dec_deth,4,4
	.comm	dec_detl,4,4
	.comm	dec_dlt,4,4
	.comm	dec_del_bpl,24,4
	.comm	dec_del_dltx,24,4
	.comm	dec_plt,4,4
	.comm	dec_plt1,4,4
	.comm	dec_plt2,4,4
	.comm	dec_szl,4,4
	.comm	dec_spl,4,4
	.comm	dec_sl,4,4
	.comm	dec_rlt1,4,4
	.comm	dec_rlt2,4,4
	.comm	dec_rlt,4,4
	.comm	dec_al1,4,4
	.comm	dec_al2,4,4
	.comm	dl,4,4
	.comm	dec_nbl,4,4
	.comm	dec_dh,4,4
	.comm	dec_nbh,4,4
	.comm	dec_del_bph,24,4
	.comm	dec_del_dhx,24,4
	.comm	dec_szh,4,4
	.comm	dec_rh1,4,4
	.comm	dec_rh2,4,4
	.comm	dec_ah1,4,4
	.comm	dec_ah2,4,4
	.comm	dec_ph,4,4
	.comm	dec_sph,4,4
	.comm	dec_sh,4,4
	.comm	dec_ph1,4,4
	.comm	dec_ph2,4,4
	.text
	.align	2
	.globl	abs
	.type	abs, @function
abs:
	addi	sp,sp,-48
	sw	s0,44(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	lw	a5,-36(s0)
	bltz	a5,.L2
	lw	a5,-36(s0)
	sw	a5,-20(s0)
	j	.L3
.L2:
	lw	a5,-36(s0)
	sub	a5,zero,a5
	sw	a5,-20(s0)
.L3:
	lw	a5,-20(s0)
	mv	a0,a5
	lw	s0,44(sp)
	addi	sp,sp,48
	jr	ra
	.size	abs, .-abs
	.globl	__mulsi3
	.align	2
	.globl	encode
	.type	encode, @function
encode:
	addi	sp,sp,-64
	sw	ra,60(sp)
	sw	s0,56(sp)
	addi	s0,sp,64
	sw	a0,-52(s0)
	sw	a1,-56(s0)
	lui	a5,%hi(h)
	addi	a5,a5,%lo(h)
	sw	a5,-24(s0)
	lui	a5,%hi(tqmf)
	addi	a5,a5,%lo(tqmf)
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	addi	a4,a5,4
	sw	a4,-28(s0)
	lw	a3,0(a5)
	lw	a5,-24(s0)
	addi	a4,a5,4
	sw	a4,-24(s0)
	lw	a5,0(a5)
	mv	a1,a5
	mv	a0,a3
	call	__mulsi3
	mv	a5,a0
	sw	a5,-36(s0)
	lw	a5,-28(s0)
	addi	a4,a5,4
	sw	a4,-28(s0)
	lw	a3,0(a5)
	lw	a5,-24(s0)
	addi	a4,a5,4
	sw	a4,-24(s0)
	lw	a5,0(a5)
	mv	a1,a5
	mv	a0,a3
	call	__mulsi3
	mv	a5,a0
	sw	a5,-40(s0)
	sw	zero,-20(s0)
	j	.L6
.L7:
	lw	a5,-28(s0)
	addi	a4,a5,4
	sw	a4,-28(s0)
	lw	a3,0(a5)
	lw	a5,-24(s0)
	addi	a4,a5,4
	sw	a4,-24(s0)
	lw	a5,0(a5)
	mv	a1,a5
	mv	a0,a3
	call	__mulsi3
	mv	a5,a0
	mv	a4,a5
	lw	a5,-36(s0)
	add	a5,a5,a4
	sw	a5,-36(s0)
	lw	a5,-28(s0)
	addi	a4,a5,4
	sw	a4,-28(s0)
	lw	a3,0(a5)
	lw	a5,-24(s0)
	addi	a4,a5,4
	sw	a4,-24(s0)
	lw	a5,0(a5)
	mv	a1,a5
	mv	a0,a3
	call	__mulsi3
	mv	a5,a0
	mv	a4,a5
	lw	a5,-40(s0)
	add	a5,a5,a4
	sw	a5,-40(s0)
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L6:
	lw	a4,-20(s0)
	li	a5,9
	ble	a4,a5,.L7
	lw	a5,-28(s0)
	addi	a4,a5,4
	sw	a4,-28(s0)
	lw	a3,0(a5)
	lw	a5,-24(s0)
	addi	a4,a5,4
	sw	a4,-24(s0)
	lw	a5,0(a5)
	mv	a1,a5
	mv	a0,a3
	call	__mulsi3
	mv	a5,a0
	mv	a4,a5
	lw	a5,-36(s0)
	add	a5,a5,a4
	sw	a5,-36(s0)
	lw	a5,-28(s0)
	lw	a3,0(a5)
	lw	a5,-24(s0)
	addi	a4,a5,4
	sw	a4,-24(s0)
	lw	a5,0(a5)
	mv	a1,a5
	mv	a0,a3
	call	__mulsi3
	mv	a5,a0
	mv	a4,a5
	lw	a5,-40(s0)
	add	a5,a5,a4
	sw	a5,-40(s0)
	lw	a5,-28(s0)
	addi	a5,a5,-8
	sw	a5,-32(s0)
	sw	zero,-20(s0)
	j	.L8
.L9:
	lw	a4,-32(s0)
	addi	a5,a4,-4
	sw	a5,-32(s0)
	lw	a5,-28(s0)
	addi	a3,a5,-4
	sw	a3,-28(s0)
	lw	a4,0(a4)
	sw	a4,0(a5)
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L8:
	lw	a4,-20(s0)
	li	a5,21
	ble	a4,a5,.L9
	lw	a5,-28(s0)
	addi	a4,a5,-4
	sw	a4,-28(s0)
	lw	a4,-52(s0)
	sw	a4,0(a5)
	lw	a5,-28(s0)
	lw	a4,-56(s0)
	sw	a4,0(a5)
	lw	a4,-36(s0)
	lw	a5,-40(s0)
	add	a5,a4,a5
	srai	a4,a5,15
	lui	a5,%hi(xl)
	sw	a4,%lo(xl)(a5)
	lw	a4,-36(s0)
	lw	a5,-40(s0)
	sub	a5,a4,a5
	srai	a4,a5,15
	lui	a5,%hi(xh)
	sw	a4,%lo(xh)(a5)
	lui	a5,%hi(delay_dltx)
	addi	a1,a5,%lo(delay_dltx)
	lui	a5,%hi(delay_bpl)
	addi	a0,a5,%lo(delay_bpl)
	call	filtez
	mv	a4,a0
	lui	a5,%hi(szl)
	sw	a4,%lo(szl)(a5)
	lui	a5,%hi(rlt1)
	lw	a4,%lo(rlt1)(a5)
	lui	a5,%hi(al1)
	lw	a1,%lo(al1)(a5)
	lui	a5,%hi(rlt2)
	lw	a2,%lo(rlt2)(a5)
	lui	a5,%hi(al2)
	lw	a5,%lo(al2)(a5)
	mv	a3,a5
	mv	a0,a4
	call	filtep
	mv	a4,a0
	lui	a5,%hi(spl)
	sw	a4,%lo(spl)(a5)
	lui	a5,%hi(szl)
	lw	a4,%lo(szl)(a5)
	lui	a5,%hi(spl)
	lw	a5,%lo(spl)(a5)
	add	a4,a4,a5
	lui	a5,%hi(sl)
	sw	a4,%lo(sl)(a5)
	lui	a5,%hi(xl)
	lw	a4,%lo(xl)(a5)
	lui	a5,%hi(sl)
	lw	a5,%lo(sl)(a5)
	sub	a4,a4,a5
	lui	a5,%hi(el)
	sw	a4,%lo(el)(a5)
	lui	a5,%hi(el)
	lw	a4,%lo(el)(a5)
	lui	a5,%hi(detl)
	lw	a5,%lo(detl)(a5)
	mv	a1,a5
	mv	a0,a4
	call	quantl
	mv	a4,a0
	lui	a5,%hi(il)
	sw	a4,%lo(il)(a5)
	lui	a5,%hi(il)
	lw	a5,%lo(il)(a5)
	srai	a4,a5,2
	lui	a5,%hi(qq4_code4_table)
	slli	a4,a4,2
	addi	a5,a5,%lo(qq4_code4_table)
	add	a5,a4,a5
	lw	a4,0(a5)
	lui	a5,%hi(detl)
	lw	a5,%lo(detl)(a5)
	mv	a1,a5
	mv	a0,a4
	call	__mulsi3
	mv	a5,a0
	srai	a4,a5,15
	lui	a5,%hi(dlt)
	sw	a4,%lo(dlt)(a5)
	lui	a5,%hi(il)
	lw	a4,%lo(il)(a5)
	lui	a5,%hi(nbl)
	lw	a5,%lo(nbl)(a5)
	mv	a1,a5
	mv	a0,a4
	call	logscl
	mv	a4,a0
	lui	a5,%hi(nbl)
	sw	a4,%lo(nbl)(a5)
	lui	a5,%hi(nbl)
	lw	a5,%lo(nbl)(a5)
	li	a1,8
	mv	a0,a5
	call	scalel
	mv	a4,a0
	lui	a5,%hi(detl)
	sw	a4,%lo(detl)(a5)
	lui	a5,%hi(dlt)
	lw	a4,%lo(dlt)(a5)
	lui	a5,%hi(szl)
	lw	a5,%lo(szl)(a5)
	add	a4,a4,a5
	lui	a5,%hi(plt)
	sw	a4,%lo(plt)(a5)
	lui	a5,%hi(dlt)
	lw	a4,%lo(dlt)(a5)
	lui	a5,%hi(delay_bpl)
	addi	a2,a5,%lo(delay_bpl)
	lui	a5,%hi(delay_dltx)
	addi	a1,a5,%lo(delay_dltx)
	mv	a0,a4
	call	upzero
	lui	a5,%hi(al1)
	lw	a0,%lo(al1)(a5)
	lui	a5,%hi(al2)
	lw	a1,%lo(al2)(a5)
	lui	a5,%hi(plt)
	lw	a2,%lo(plt)(a5)
	lui	a5,%hi(plt1)
	lw	a3,%lo(plt1)(a5)
	lui	a5,%hi(plt2)
	lw	a5,%lo(plt2)(a5)
	mv	a4,a5
	call	uppol2
	mv	a4,a0
	lui	a5,%hi(al2)
	sw	a4,%lo(al2)(a5)
	lui	a5,%hi(al1)
	lw	a4,%lo(al1)(a5)
	lui	a5,%hi(al2)
	lw	a1,%lo(al2)(a5)
	lui	a5,%hi(plt)
	lw	a2,%lo(plt)(a5)
	lui	a5,%hi(plt1)
	lw	a5,%lo(plt1)(a5)
	mv	a3,a5
	mv	a0,a4
	call	uppol1
	mv	a4,a0
	lui	a5,%hi(al1)
	sw	a4,%lo(al1)(a5)
	lui	a5,%hi(sl)
	lw	a4,%lo(sl)(a5)
	lui	a5,%hi(dlt)
	lw	a5,%lo(dlt)(a5)
	add	a4,a4,a5
	lui	a5,%hi(rlt)
	sw	a4,%lo(rlt)(a5)
	lui	a5,%hi(rlt1)
	lw	a4,%lo(rlt1)(a5)
	lui	a5,%hi(rlt2)
	sw	a4,%lo(rlt2)(a5)
	lui	a5,%hi(rlt)
	lw	a4,%lo(rlt)(a5)
	lui	a5,%hi(rlt1)
	sw	a4,%lo(rlt1)(a5)
	lui	a5,%hi(plt1)
	lw	a4,%lo(plt1)(a5)
	lui	a5,%hi(plt2)
	sw	a4,%lo(plt2)(a5)
	lui	a5,%hi(plt)
	lw	a4,%lo(plt)(a5)
	lui	a5,%hi(plt1)
	sw	a4,%lo(plt1)(a5)
	lui	a5,%hi(delay_dhx)
	addi	a1,a5,%lo(delay_dhx)
	lui	a5,%hi(delay_bph)
	addi	a0,a5,%lo(delay_bph)
	call	filtez
	mv	a4,a0
	lui	a5,%hi(szh)
	sw	a4,%lo(szh)(a5)
	lui	a5,%hi(rh1)
	lw	a4,%lo(rh1)(a5)
	lui	a5,%hi(ah1)
	lw	a1,%lo(ah1)(a5)
	lui	a5,%hi(rh2)
	lw	a2,%lo(rh2)(a5)
	lui	a5,%hi(ah2)
	lw	a5,%lo(ah2)(a5)
	mv	a3,a5
	mv	a0,a4
	call	filtep
	mv	a4,a0
	lui	a5,%hi(sph)
	sw	a4,%lo(sph)(a5)
	lui	a5,%hi(sph)
	lw	a4,%lo(sph)(a5)
	lui	a5,%hi(szh)
	lw	a5,%lo(szh)(a5)
	add	a4,a4,a5
	lui	a5,%hi(sh)
	sw	a4,%lo(sh)(a5)
	lui	a5,%hi(xh)
	lw	a4,%lo(xh)(a5)
	lui	a5,%hi(sh)
	lw	a5,%lo(sh)(a5)
	sub	a4,a4,a5
	lui	a5,%hi(eh)
	sw	a4,%lo(eh)(a5)
	lui	a5,%hi(eh)
	lw	a5,%lo(eh)(a5)
	bltz	a5,.L10
	lui	a5,%hi(ih)
	li	a4,3
	sw	a4,%lo(ih)(a5)
	j	.L11
.L10:
	lui	a5,%hi(ih)
	li	a4,1
	sw	a4,%lo(ih)(a5)
.L11:
	lui	a5,%hi(deth)
	lw	a5,%lo(deth)(a5)
	li	a1,564
	mv	a0,a5
	call	__mulsi3
	mv	a5,a0
	srai	a5,a5,12
	sw	a5,-44(s0)
	lui	a5,%hi(eh)
	lw	a5,%lo(eh)(a5)
	srai	a4,a5,31
	xor	a5,a4,a5
	sub	a5,a5,a4
	lw	a4,-44(s0)
	bge	a4,a5,.L12
	lui	a5,%hi(ih)
	lw	a5,%lo(ih)(a5)
	addi	a4,a5,-1
	lui	a5,%hi(ih)
	sw	a4,%lo(ih)(a5)
.L12:
	lui	a5,%hi(ih)
	lw	a4,%lo(ih)(a5)
	lui	a5,%hi(qq2_code2_table)
	slli	a4,a4,2
	addi	a5,a5,%lo(qq2_code2_table)
	add	a5,a4,a5
	lw	a4,0(a5)
	lui	a5,%hi(deth)
	lw	a5,%lo(deth)(a5)
	mv	a1,a5
	mv	a0,a4
	call	__mulsi3
	mv	a5,a0
	srai	a4,a5,15
	lui	a5,%hi(dh)
	sw	a4,%lo(dh)(a5)
	lui	a5,%hi(ih)
	lw	a4,%lo(ih)(a5)
	lui	a5,%hi(nbh)
	lw	a5,%lo(nbh)(a5)
	mv	a1,a5
	mv	a0,a4
	call	logsch
	mv	a4,a0
	lui	a5,%hi(nbh)
	sw	a4,%lo(nbh)(a5)
	lui	a5,%hi(nbh)
	lw	a5,%lo(nbh)(a5)
	li	a1,10
	mv	a0,a5
	call	scalel
	mv	a4,a0
	lui	a5,%hi(deth)
	sw	a4,%lo(deth)(a5)
	lui	a5,%hi(dh)
	lw	a4,%lo(dh)(a5)
	lui	a5,%hi(szh)
	lw	a5,%lo(szh)(a5)
	add	a4,a4,a5
	lui	a5,%hi(ph)
	sw	a4,%lo(ph)(a5)
	lui	a5,%hi(dh)
	lw	a4,%lo(dh)(a5)
	lui	a5,%hi(delay_bph)
	addi	a2,a5,%lo(delay_bph)
	lui	a5,%hi(delay_dhx)
	addi	a1,a5,%lo(delay_dhx)
	mv	a0,a4
	call	upzero
	lui	a5,%hi(ah1)
	lw	a0,%lo(ah1)(a5)
	lui	a5,%hi(ah2)
	lw	a1,%lo(ah2)(a5)
	lui	a5,%hi(ph)
	lw	a2,%lo(ph)(a5)
	lui	a5,%hi(ph1)
	lw	a3,%lo(ph1)(a5)
	lui	a5,%hi(ph2)
	lw	a5,%lo(ph2)(a5)
	mv	a4,a5
	call	uppol2
	mv	a4,a0
	lui	a5,%hi(ah2)
	sw	a4,%lo(ah2)(a5)
	lui	a5,%hi(ah1)
	lw	a4,%lo(ah1)(a5)
	lui	a5,%hi(ah2)
	lw	a1,%lo(ah2)(a5)
	lui	a5,%hi(ph)
	lw	a2,%lo(ph)(a5)
	lui	a5,%hi(ph1)
	lw	a5,%lo(ph1)(a5)
	mv	a3,a5
	mv	a0,a4
	call	uppol1
	mv	a4,a0
	lui	a5,%hi(ah1)
	sw	a4,%lo(ah1)(a5)
	lui	a5,%hi(sh)
	lw	a4,%lo(sh)(a5)
	lui	a5,%hi(dh)
	lw	a5,%lo(dh)(a5)
	add	a4,a4,a5
	lui	a5,%hi(yh)
	sw	a4,%lo(yh)(a5)
	lui	a5,%hi(rh1)
	lw	a4,%lo(rh1)(a5)
	lui	a5,%hi(rh2)
	sw	a4,%lo(rh2)(a5)
	lui	a5,%hi(yh)
	lw	a4,%lo(yh)(a5)
	lui	a5,%hi(rh1)
	sw	a4,%lo(rh1)(a5)
	lui	a5,%hi(ph1)
	lw	a4,%lo(ph1)(a5)
	lui	a5,%hi(ph2)
	sw	a4,%lo(ph2)(a5)
	lui	a5,%hi(ph)
	lw	a4,%lo(ph)(a5)
	lui	a5,%hi(ph1)
	sw	a4,%lo(ph1)(a5)
	lui	a5,%hi(ih)
	lw	a5,%lo(ih)(a5)
	slli	a4,a5,6
	lui	a5,%hi(il)
	lw	a5,%lo(il)(a5)
	or	a5,a4,a5
	mv	a0,a5
	lw	ra,60(sp)
	lw	s0,56(sp)
	addi	sp,sp,64
	jr	ra
	.size	encode, .-encode
	.align	2
	.globl	decode
	.type	decode, @function
decode:
	addi	sp,sp,-64
	sw	ra,60(sp)
	sw	s0,56(sp)
	addi	s0,sp,64
	sw	a0,-52(s0)
	lw	a5,-52(s0)
	andi	a4,a5,63
	lui	a5,%hi(ilr)
	sw	a4,%lo(ilr)(a5)
	lw	a5,-52(s0)
	srai	a4,a5,6
	lui	a5,%hi(ih)
	sw	a4,%lo(ih)(a5)
	lui	a5,%hi(dec_del_dltx)
	addi	a1,a5,%lo(dec_del_dltx)
	lui	a5,%hi(dec_del_bpl)
	addi	a0,a5,%lo(dec_del_bpl)
	call	filtez
	mv	a4,a0
	lui	a5,%hi(dec_szl)
	sw	a4,%lo(dec_szl)(a5)
	lui	a5,%hi(dec_rlt1)
	lw	a4,%lo(dec_rlt1)(a5)
	lui	a5,%hi(dec_al1)
	lw	a1,%lo(dec_al1)(a5)
	lui	a5,%hi(dec_rlt2)
	lw	a2,%lo(dec_rlt2)(a5)
	lui	a5,%hi(dec_al2)
	lw	a5,%lo(dec_al2)(a5)
	mv	a3,a5
	mv	a0,a4
	call	filtep
	mv	a4,a0
	lui	a5,%hi(dec_spl)
	sw	a4,%lo(dec_spl)(a5)
	lui	a5,%hi(dec_spl)
	lw	a4,%lo(dec_spl)(a5)
	lui	a5,%hi(dec_szl)
	lw	a5,%lo(dec_szl)(a5)
	add	a4,a4,a5
	lui	a5,%hi(dec_sl)
	sw	a4,%lo(dec_sl)(a5)
	lui	a5,%hi(ilr)
	lw	a5,%lo(ilr)(a5)
	srai	a4,a5,2
	lui	a5,%hi(qq4_code4_table)
	slli	a4,a4,2
	addi	a5,a5,%lo(qq4_code4_table)
	add	a5,a4,a5
	lw	a4,0(a5)
	lui	a5,%hi(dec_detl)
	lw	a5,%lo(dec_detl)(a5)
	mv	a1,a5
	mv	a0,a4
	call	__mulsi3
	mv	a5,a0
	srai	a4,a5,15
	lui	a5,%hi(dec_dlt)
	sw	a4,%lo(dec_dlt)(a5)
	lui	a5,%hi(il)
	lw	a4,%lo(il)(a5)
	lui	a5,%hi(qq6_code6_table)
	slli	a4,a4,2
	addi	a5,a5,%lo(qq6_code6_table)
	add	a5,a4,a5
	lw	a4,0(a5)
	lui	a5,%hi(dec_detl)
	lw	a5,%lo(dec_detl)(a5)
	mv	a1,a5
	mv	a0,a4
	call	__mulsi3
	mv	a5,a0
	srai	a4,a5,15
	lui	a5,%hi(dl)
	sw	a4,%lo(dl)(a5)
	lui	a5,%hi(dl)
	lw	a4,%lo(dl)(a5)
	lui	a5,%hi(dec_sl)
	lw	a5,%lo(dec_sl)(a5)
	add	a4,a4,a5
	lui	a5,%hi(rl)
	sw	a4,%lo(rl)(a5)
	lui	a5,%hi(ilr)
	lw	a4,%lo(ilr)(a5)
	lui	a5,%hi(dec_nbl)
	lw	a5,%lo(dec_nbl)(a5)
	mv	a1,a5
	mv	a0,a4
	call	logscl
	mv	a4,a0
	lui	a5,%hi(dec_nbl)
	sw	a4,%lo(dec_nbl)(a5)
	lui	a5,%hi(dec_nbl)
	lw	a5,%lo(dec_nbl)(a5)
	li	a1,8
	mv	a0,a5
	call	scalel
	mv	a4,a0
	lui	a5,%hi(dec_detl)
	sw	a4,%lo(dec_detl)(a5)
	lui	a5,%hi(dec_dlt)
	lw	a4,%lo(dec_dlt)(a5)
	lui	a5,%hi(dec_szl)
	lw	a5,%lo(dec_szl)(a5)
	add	a4,a4,a5
	lui	a5,%hi(dec_plt)
	sw	a4,%lo(dec_plt)(a5)
	lui	a5,%hi(dec_dlt)
	lw	a4,%lo(dec_dlt)(a5)
	lui	a5,%hi(dec_del_bpl)
	addi	a2,a5,%lo(dec_del_bpl)
	lui	a5,%hi(dec_del_dltx)
	addi	a1,a5,%lo(dec_del_dltx)
	mv	a0,a4
	call	upzero
	lui	a5,%hi(dec_al1)
	lw	a0,%lo(dec_al1)(a5)
	lui	a5,%hi(dec_al2)
	lw	a1,%lo(dec_al2)(a5)
	lui	a5,%hi(dec_plt)
	lw	a2,%lo(dec_plt)(a5)
	lui	a5,%hi(dec_plt1)
	lw	a3,%lo(dec_plt1)(a5)
	lui	a5,%hi(dec_plt2)
	lw	a5,%lo(dec_plt2)(a5)
	mv	a4,a5
	call	uppol2
	mv	a4,a0
	lui	a5,%hi(dec_al2)
	sw	a4,%lo(dec_al2)(a5)
	lui	a5,%hi(dec_al1)
	lw	a4,%lo(dec_al1)(a5)
	lui	a5,%hi(dec_al2)
	lw	a1,%lo(dec_al2)(a5)
	lui	a5,%hi(dec_plt)
	lw	a2,%lo(dec_plt)(a5)
	lui	a5,%hi(dec_plt1)
	lw	a5,%lo(dec_plt1)(a5)
	mv	a3,a5
	mv	a0,a4
	call	uppol1
	mv	a4,a0
	lui	a5,%hi(dec_al1)
	sw	a4,%lo(dec_al1)(a5)
	lui	a5,%hi(dec_sl)
	lw	a4,%lo(dec_sl)(a5)
	lui	a5,%hi(dec_dlt)
	lw	a5,%lo(dec_dlt)(a5)
	add	a4,a4,a5
	lui	a5,%hi(dec_rlt)
	sw	a4,%lo(dec_rlt)(a5)
	lui	a5,%hi(dec_rlt1)
	lw	a4,%lo(dec_rlt1)(a5)
	lui	a5,%hi(dec_rlt2)
	sw	a4,%lo(dec_rlt2)(a5)
	lui	a5,%hi(dec_rlt)
	lw	a4,%lo(dec_rlt)(a5)
	lui	a5,%hi(dec_rlt1)
	sw	a4,%lo(dec_rlt1)(a5)
	lui	a5,%hi(dec_plt1)
	lw	a4,%lo(dec_plt1)(a5)
	lui	a5,%hi(dec_plt2)
	sw	a4,%lo(dec_plt2)(a5)
	lui	a5,%hi(dec_plt)
	lw	a4,%lo(dec_plt)(a5)
	lui	a5,%hi(dec_plt1)
	sw	a4,%lo(dec_plt1)(a5)
	lui	a5,%hi(dec_del_dhx)
	addi	a1,a5,%lo(dec_del_dhx)
	lui	a5,%hi(dec_del_bph)
	addi	a0,a5,%lo(dec_del_bph)
	call	filtez
	mv	a4,a0
	lui	a5,%hi(dec_szh)
	sw	a4,%lo(dec_szh)(a5)
	lui	a5,%hi(dec_rh1)
	lw	a4,%lo(dec_rh1)(a5)
	lui	a5,%hi(dec_ah1)
	lw	a1,%lo(dec_ah1)(a5)
	lui	a5,%hi(dec_rh2)
	lw	a2,%lo(dec_rh2)(a5)
	lui	a5,%hi(dec_ah2)
	lw	a5,%lo(dec_ah2)(a5)
	mv	a3,a5
	mv	a0,a4
	call	filtep
	mv	a4,a0
	lui	a5,%hi(dec_sph)
	sw	a4,%lo(dec_sph)(a5)
	lui	a5,%hi(dec_sph)
	lw	a4,%lo(dec_sph)(a5)
	lui	a5,%hi(dec_szh)
	lw	a5,%lo(dec_szh)(a5)
	add	a4,a4,a5
	lui	a5,%hi(dec_sh)
	sw	a4,%lo(dec_sh)(a5)
	lui	a5,%hi(ih)
	lw	a4,%lo(ih)(a5)
	lui	a5,%hi(qq2_code2_table)
	slli	a4,a4,2
	addi	a5,a5,%lo(qq2_code2_table)
	add	a5,a4,a5
	lw	a4,0(a5)
	lui	a5,%hi(dec_deth)
	lw	a5,%lo(dec_deth)(a5)
	mv	a1,a5
	mv	a0,a4
	call	__mulsi3
	mv	a5,a0
	srai	a4,a5,15
	lui	a5,%hi(dec_dh)
	sw	a4,%lo(dec_dh)(a5)
	lui	a5,%hi(ih)
	lw	a4,%lo(ih)(a5)
	lui	a5,%hi(dec_nbh)
	lw	a5,%lo(dec_nbh)(a5)
	mv	a1,a5
	mv	a0,a4
	call	logsch
	mv	a4,a0
	lui	a5,%hi(dec_nbh)
	sw	a4,%lo(dec_nbh)(a5)
	lui	a5,%hi(dec_nbh)
	lw	a5,%lo(dec_nbh)(a5)
	li	a1,10
	mv	a0,a5
	call	scalel
	mv	a4,a0
	lui	a5,%hi(dec_deth)
	sw	a4,%lo(dec_deth)(a5)
	lui	a5,%hi(dec_dh)
	lw	a4,%lo(dec_dh)(a5)
	lui	a5,%hi(dec_szh)
	lw	a5,%lo(dec_szh)(a5)
	add	a4,a4,a5
	lui	a5,%hi(dec_ph)
	sw	a4,%lo(dec_ph)(a5)
	lui	a5,%hi(dec_dh)
	lw	a4,%lo(dec_dh)(a5)
	lui	a5,%hi(dec_del_bph)
	addi	a2,a5,%lo(dec_del_bph)
	lui	a5,%hi(dec_del_dhx)
	addi	a1,a5,%lo(dec_del_dhx)
	mv	a0,a4
	call	upzero
	lui	a5,%hi(dec_ah1)
	lw	a0,%lo(dec_ah1)(a5)
	lui	a5,%hi(dec_ah2)
	lw	a1,%lo(dec_ah2)(a5)
	lui	a5,%hi(dec_ph)
	lw	a2,%lo(dec_ph)(a5)
	lui	a5,%hi(dec_ph1)
	lw	a3,%lo(dec_ph1)(a5)
	lui	a5,%hi(dec_ph2)
	lw	a5,%lo(dec_ph2)(a5)
	mv	a4,a5
	call	uppol2
	mv	a4,a0
	lui	a5,%hi(dec_ah2)
	sw	a4,%lo(dec_ah2)(a5)
	lui	a5,%hi(dec_ah1)
	lw	a4,%lo(dec_ah1)(a5)
	lui	a5,%hi(dec_ah2)
	lw	a1,%lo(dec_ah2)(a5)
	lui	a5,%hi(dec_ph)
	lw	a2,%lo(dec_ph)(a5)
	lui	a5,%hi(dec_ph1)
	lw	a5,%lo(dec_ph1)(a5)
	mv	a3,a5
	mv	a0,a4
	call	uppol1
	mv	a4,a0
	lui	a5,%hi(dec_ah1)
	sw	a4,%lo(dec_ah1)(a5)
	lui	a5,%hi(dec_sh)
	lw	a4,%lo(dec_sh)(a5)
	lui	a5,%hi(dec_dh)
	lw	a5,%lo(dec_dh)(a5)
	add	a4,a4,a5
	lui	a5,%hi(rh)
	sw	a4,%lo(rh)(a5)
	lui	a5,%hi(dec_rh1)
	lw	a4,%lo(dec_rh1)(a5)
	lui	a5,%hi(dec_rh2)
	sw	a4,%lo(dec_rh2)(a5)
	lui	a5,%hi(rh)
	lw	a4,%lo(rh)(a5)
	lui	a5,%hi(dec_rh1)
	sw	a4,%lo(dec_rh1)(a5)
	lui	a5,%hi(dec_ph1)
	lw	a4,%lo(dec_ph1)(a5)
	lui	a5,%hi(dec_ph2)
	sw	a4,%lo(dec_ph2)(a5)
	lui	a5,%hi(dec_ph)
	lw	a4,%lo(dec_ph)(a5)
	lui	a5,%hi(dec_ph1)
	sw	a4,%lo(dec_ph1)(a5)
	lui	a5,%hi(rl)
	lw	a4,%lo(rl)(a5)
	lui	a5,%hi(rh)
	lw	a5,%lo(rh)(a5)
	sub	a4,a4,a5
	lui	a5,%hi(xd)
	sw	a4,%lo(xd)(a5)
	lui	a5,%hi(rl)
	lw	a4,%lo(rl)(a5)
	lui	a5,%hi(rh)
	lw	a5,%lo(rh)(a5)
	add	a4,a4,a5
	lui	a5,%hi(xs)
	sw	a4,%lo(xs)(a5)
	lui	a5,%hi(h)
	addi	a5,a5,%lo(h)
	sw	a5,-32(s0)
	lui	a5,%hi(accumc)
	addi	a5,a5,%lo(accumc)
	sw	a5,-36(s0)
	lui	a5,%hi(accumd)
	addi	a5,a5,%lo(accumd)
	sw	a5,-44(s0)
	lw	a5,-32(s0)
	addi	a4,a5,4
	sw	a4,-32(s0)
	lw	a4,0(a5)
	lui	a5,%hi(xd)
	lw	a5,%lo(xd)(a5)
	mv	a1,a5
	mv	a0,a4
	call	__mulsi3
	mv	a5,a0
	sw	a5,-24(s0)
	lw	a5,-32(s0)
	addi	a4,a5,4
	sw	a4,-32(s0)
	lw	a4,0(a5)
	lui	a5,%hi(xs)
	lw	a5,%lo(xs)(a5)
	mv	a1,a5
	mv	a0,a4
	call	__mulsi3
	mv	a5,a0
	sw	a5,-28(s0)
	sw	zero,-20(s0)
	j	.L15
.L16:
	lw	a5,-36(s0)
	addi	a4,a5,4
	sw	a4,-36(s0)
	lw	a3,0(a5)
	lw	a5,-32(s0)
	addi	a4,a5,4
	sw	a4,-32(s0)
	lw	a5,0(a5)
	mv	a1,a5
	mv	a0,a3
	call	__mulsi3
	mv	a5,a0
	mv	a4,a5
	lw	a5,-24(s0)
	add	a5,a5,a4
	sw	a5,-24(s0)
	lw	a5,-44(s0)
	addi	a4,a5,4
	sw	a4,-44(s0)
	lw	a3,0(a5)
	lw	a5,-32(s0)
	addi	a4,a5,4
	sw	a4,-32(s0)
	lw	a5,0(a5)
	mv	a1,a5
	mv	a0,a3
	call	__mulsi3
	mv	a5,a0
	mv	a4,a5
	lw	a5,-28(s0)
	add	a5,a5,a4
	sw	a5,-28(s0)
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L15:
	lw	a4,-20(s0)
	li	a5,9
	ble	a4,a5,.L16
	lw	a5,-36(s0)
	lw	a3,0(a5)
	lw	a5,-32(s0)
	addi	a4,a5,4
	sw	a4,-32(s0)
	lw	a5,0(a5)
	mv	a1,a5
	mv	a0,a3
	call	__mulsi3
	mv	a5,a0
	mv	a4,a5
	lw	a5,-24(s0)
	add	a5,a5,a4
	sw	a5,-24(s0)
	lw	a5,-44(s0)
	lw	a3,0(a5)
	lw	a5,-32(s0)
	addi	a4,a5,4
	sw	a4,-32(s0)
	lw	a5,0(a5)
	mv	a1,a5
	mv	a0,a3
	call	__mulsi3
	mv	a5,a0
	mv	a4,a5
	lw	a5,-28(s0)
	add	a5,a5,a4
	sw	a5,-28(s0)
	lw	a5,-24(s0)
	srai	a4,a5,14
	lui	a5,%hi(xout1)
	sw	a4,%lo(xout1)(a5)
	lw	a5,-28(s0)
	srai	a4,a5,14
	lui	a5,%hi(xout2)
	sw	a4,%lo(xout2)(a5)
	lw	a5,-36(s0)
	addi	a5,a5,-4
	sw	a5,-40(s0)
	lw	a5,-44(s0)
	addi	a5,a5,-4
	sw	a5,-48(s0)
	sw	zero,-20(s0)
	j	.L17
.L18:
	lw	a4,-40(s0)
	addi	a5,a4,-4
	sw	a5,-40(s0)
	lw	a5,-36(s0)
	addi	a3,a5,-4
	sw	a3,-36(s0)
	lw	a4,0(a4)
	sw	a4,0(a5)
	lw	a4,-48(s0)
	addi	a5,a4,-4
	sw	a5,-48(s0)
	lw	a5,-44(s0)
	addi	a3,a5,-4
	sw	a3,-44(s0)
	lw	a4,0(a4)
	sw	a4,0(a5)
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L17:
	lw	a4,-20(s0)
	li	a5,9
	ble	a4,a5,.L18
	lui	a5,%hi(xd)
	lw	a4,%lo(xd)(a5)
	lw	a5,-36(s0)
	sw	a4,0(a5)
	lui	a5,%hi(xs)
	lw	a4,%lo(xs)(a5)
	lw	a5,-44(s0)
	sw	a4,0(a5)
	nop
	lw	ra,60(sp)
	lw	s0,56(sp)
	addi	sp,sp,64
	jr	ra
	.size	decode, .-decode
	.align	2
	.globl	reset
	.type	reset, @function
reset:
	addi	sp,sp,-32
	sw	s0,28(sp)
	addi	s0,sp,32
	lui	a5,%hi(dec_detl)
	li	a4,32
	sw	a4,%lo(dec_detl)(a5)
	lui	a5,%hi(dec_detl)
	lw	a4,%lo(dec_detl)(a5)
	lui	a5,%hi(detl)
	sw	a4,%lo(detl)(a5)
	lui	a5,%hi(dec_deth)
	li	a4,8
	sw	a4,%lo(dec_deth)(a5)
	lui	a5,%hi(dec_deth)
	lw	a4,%lo(dec_deth)(a5)
	lui	a5,%hi(deth)
	sw	a4,%lo(deth)(a5)
	lui	a5,%hi(rlt2)
	sw	zero,%lo(rlt2)(a5)
	lui	a5,%hi(rlt2)
	lw	a4,%lo(rlt2)(a5)
	lui	a5,%hi(rlt1)
	sw	a4,%lo(rlt1)(a5)
	lui	a5,%hi(rlt1)
	lw	a4,%lo(rlt1)(a5)
	lui	a5,%hi(plt2)
	sw	a4,%lo(plt2)(a5)
	lui	a5,%hi(plt2)
	lw	a4,%lo(plt2)(a5)
	lui	a5,%hi(plt1)
	sw	a4,%lo(plt1)(a5)
	lui	a5,%hi(plt1)
	lw	a4,%lo(plt1)(a5)
	lui	a5,%hi(al2)
	sw	a4,%lo(al2)(a5)
	lui	a5,%hi(al2)
	lw	a4,%lo(al2)(a5)
	lui	a5,%hi(al1)
	sw	a4,%lo(al1)(a5)
	lui	a5,%hi(al1)
	lw	a4,%lo(al1)(a5)
	lui	a5,%hi(nbl)
	sw	a4,%lo(nbl)(a5)
	lui	a5,%hi(rh2)
	sw	zero,%lo(rh2)(a5)
	lui	a5,%hi(rh2)
	lw	a4,%lo(rh2)(a5)
	lui	a5,%hi(rh1)
	sw	a4,%lo(rh1)(a5)
	lui	a5,%hi(rh1)
	lw	a4,%lo(rh1)(a5)
	lui	a5,%hi(ph2)
	sw	a4,%lo(ph2)(a5)
	lui	a5,%hi(ph2)
	lw	a4,%lo(ph2)(a5)
	lui	a5,%hi(ph1)
	sw	a4,%lo(ph1)(a5)
	lui	a5,%hi(ph1)
	lw	a4,%lo(ph1)(a5)
	lui	a5,%hi(ah2)
	sw	a4,%lo(ah2)(a5)
	lui	a5,%hi(ah2)
	lw	a4,%lo(ah2)(a5)
	lui	a5,%hi(ah1)
	sw	a4,%lo(ah1)(a5)
	lui	a5,%hi(ah1)
	lw	a4,%lo(ah1)(a5)
	lui	a5,%hi(nbh)
	sw	a4,%lo(nbh)(a5)
	lui	a5,%hi(dec_rlt2)
	sw	zero,%lo(dec_rlt2)(a5)
	lui	a5,%hi(dec_rlt2)
	lw	a4,%lo(dec_rlt2)(a5)
	lui	a5,%hi(dec_rlt1)
	sw	a4,%lo(dec_rlt1)(a5)
	lui	a5,%hi(dec_rlt1)
	lw	a4,%lo(dec_rlt1)(a5)
	lui	a5,%hi(dec_plt2)
	sw	a4,%lo(dec_plt2)(a5)
	lui	a5,%hi(dec_plt2)
	lw	a4,%lo(dec_plt2)(a5)
	lui	a5,%hi(dec_plt1)
	sw	a4,%lo(dec_plt1)(a5)
	lui	a5,%hi(dec_plt1)
	lw	a4,%lo(dec_plt1)(a5)
	lui	a5,%hi(dec_al2)
	sw	a4,%lo(dec_al2)(a5)
	lui	a5,%hi(dec_al2)
	lw	a4,%lo(dec_al2)(a5)
	lui	a5,%hi(dec_al1)
	sw	a4,%lo(dec_al1)(a5)
	lui	a5,%hi(dec_al1)
	lw	a4,%lo(dec_al1)(a5)
	lui	a5,%hi(dec_nbl)
	sw	a4,%lo(dec_nbl)(a5)
	lui	a5,%hi(dec_rh2)
	sw	zero,%lo(dec_rh2)(a5)
	lui	a5,%hi(dec_rh2)
	lw	a4,%lo(dec_rh2)(a5)
	lui	a5,%hi(dec_rh1)
	sw	a4,%lo(dec_rh1)(a5)
	lui	a5,%hi(dec_rh1)
	lw	a4,%lo(dec_rh1)(a5)
	lui	a5,%hi(dec_ph2)
	sw	a4,%lo(dec_ph2)(a5)
	lui	a5,%hi(dec_ph2)
	lw	a4,%lo(dec_ph2)(a5)
	lui	a5,%hi(dec_ph1)
	sw	a4,%lo(dec_ph1)(a5)
	lui	a5,%hi(dec_ph1)
	lw	a4,%lo(dec_ph1)(a5)
	lui	a5,%hi(dec_ah2)
	sw	a4,%lo(dec_ah2)(a5)
	lui	a5,%hi(dec_ah2)
	lw	a4,%lo(dec_ah2)(a5)
	lui	a5,%hi(dec_ah1)
	sw	a4,%lo(dec_ah1)(a5)
	lui	a5,%hi(dec_ah1)
	lw	a4,%lo(dec_ah1)(a5)
	lui	a5,%hi(dec_nbh)
	sw	a4,%lo(dec_nbh)(a5)
	sw	zero,-20(s0)
	j	.L20
.L21:
	lui	a5,%hi(delay_dltx)
	lw	a4,-20(s0)
	slli	a4,a4,2
	addi	a5,a5,%lo(delay_dltx)
	add	a5,a4,a5
	sw	zero,0(a5)
	lui	a5,%hi(delay_dhx)
	lw	a4,-20(s0)
	slli	a4,a4,2
	addi	a5,a5,%lo(delay_dhx)
	add	a5,a4,a5
	sw	zero,0(a5)
	lui	a5,%hi(dec_del_dltx)
	lw	a4,-20(s0)
	slli	a4,a4,2
	addi	a5,a5,%lo(dec_del_dltx)
	add	a5,a4,a5
	sw	zero,0(a5)
	lui	a5,%hi(dec_del_dhx)
	lw	a4,-20(s0)
	slli	a4,a4,2
	addi	a5,a5,%lo(dec_del_dhx)
	add	a5,a4,a5
	sw	zero,0(a5)
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L20:
	lw	a4,-20(s0)
	li	a5,5
	ble	a4,a5,.L21
	sw	zero,-20(s0)
	j	.L22
.L23:
	lui	a5,%hi(delay_bpl)
	lw	a4,-20(s0)
	slli	a4,a4,2
	addi	a5,a5,%lo(delay_bpl)
	add	a5,a4,a5
	sw	zero,0(a5)
	lui	a5,%hi(delay_bph)
	lw	a4,-20(s0)
	slli	a4,a4,2
	addi	a5,a5,%lo(delay_bph)
	add	a5,a4,a5
	sw	zero,0(a5)
	lui	a5,%hi(dec_del_bpl)
	lw	a4,-20(s0)
	slli	a4,a4,2
	addi	a5,a5,%lo(dec_del_bpl)
	add	a5,a4,a5
	sw	zero,0(a5)
	lui	a5,%hi(dec_del_bph)
	lw	a4,-20(s0)
	slli	a4,a4,2
	addi	a5,a5,%lo(dec_del_bph)
	add	a5,a4,a5
	sw	zero,0(a5)
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L22:
	lw	a4,-20(s0)
	li	a5,5
	ble	a4,a5,.L23
	sw	zero,-20(s0)
	j	.L24
.L25:
	lui	a5,%hi(tqmf)
	lw	a4,-20(s0)
	slli	a4,a4,2
	addi	a5,a5,%lo(tqmf)
	add	a5,a4,a5
	sw	zero,0(a5)
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L24:
	lw	a4,-20(s0)
	li	a5,23
	ble	a4,a5,.L25
	sw	zero,-20(s0)
	j	.L26
.L27:
	lui	a5,%hi(accumc)
	lw	a4,-20(s0)
	slli	a4,a4,2
	addi	a5,a5,%lo(accumc)
	add	a5,a4,a5
	sw	zero,0(a5)
	lui	a5,%hi(accumd)
	lw	a4,-20(s0)
	slli	a4,a4,2
	addi	a5,a5,%lo(accumd)
	add	a5,a4,a5
	sw	zero,0(a5)
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L26:
	lw	a4,-20(s0)
	li	a5,10
	ble	a4,a5,.L27
	nop
	lw	s0,28(sp)
	addi	sp,sp,32
	jr	ra
	.size	reset, .-reset
	.align	2
	.globl	filtez
	.type	filtez, @function
filtez:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	lw	a5,-36(s0)
	addi	a4,a5,4
	sw	a4,-36(s0)
	lw	a3,0(a5)
	lw	a5,-40(s0)
	addi	a4,a5,4
	sw	a4,-40(s0)
	lw	a5,0(a5)
	mv	a1,a5
	mv	a0,a3
	call	__mulsi3
	mv	a5,a0
	sw	a5,-24(s0)
	li	a5,1
	sw	a5,-20(s0)
	j	.L29
.L30:
	lw	a5,-36(s0)
	addi	a4,a5,4
	sw	a4,-36(s0)
	lw	a3,0(a5)
	lw	a5,-40(s0)
	addi	a4,a5,4
	sw	a4,-40(s0)
	lw	a5,0(a5)
	mv	a1,a5
	mv	a0,a3
	call	__mulsi3
	mv	a5,a0
	mv	a4,a5
	lw	a5,-24(s0)
	add	a5,a5,a4
	sw	a5,-24(s0)
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L29:
	lw	a4,-20(s0)
	li	a5,5
	ble	a4,a5,.L30
	lw	a5,-24(s0)
	srai	a5,a5,14
	mv	a0,a5
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	filtez, .-filtez
	.align	2
	.globl	filtep
	.type	filtep, @function
filtep:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	sw	a2,-44(s0)
	sw	a3,-48(s0)
	lw	a5,-36(s0)
	slli	a5,a5,1
	sw	a5,-20(s0)
	lw	a1,-40(s0)
	lw	a0,-20(s0)
	call	__mulsi3
	mv	a5,a0
	sw	a5,-20(s0)
	lw	a5,-44(s0)
	slli	a5,a5,1
	sw	a5,-24(s0)
	lw	a1,-24(s0)
	lw	a0,-48(s0)
	call	__mulsi3
	mv	a5,a0
	mv	a4,a5
	lw	a5,-20(s0)
	add	a5,a5,a4
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	srai	a5,a5,15
	mv	a0,a5
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	filtep, .-filtep
	.align	2
	.globl	quantl
	.type	quantl, @function
quantl:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	lw	a5,-36(s0)
	srai	a5,a5,31
	lw	a4,-36(s0)
	xor	a4,a5,a4
	sub	a5,a4,a5
	sw	a5,-28(s0)
	sw	zero,-24(s0)
	j	.L35
.L38:
	lui	a5,%hi(decis_levl)
	lw	a4,-24(s0)
	slli	a4,a4,2
	addi	a5,a5,%lo(decis_levl)
	add	a5,a4,a5
	lw	a5,0(a5)
	lw	a1,-40(s0)
	mv	a0,a5
	call	__mulsi3
	mv	a5,a0
	srai	a5,a5,15
	sw	a5,-32(s0)
	lw	a4,-28(s0)
	lw	a5,-32(s0)
	ble	a4,a5,.L42
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
.L35:
	lw	a4,-24(s0)
	li	a5,29
	ble	a4,a5,.L38
	j	.L37
.L42:
	nop
.L37:
	lw	a5,-36(s0)
	bltz	a5,.L39
	lui	a5,%hi(quant26bt_pos)
	lw	a4,-24(s0)
	slli	a4,a4,2
	addi	a5,a5,%lo(quant26bt_pos)
	add	a5,a4,a5
	lw	a5,0(a5)
	sw	a5,-20(s0)
	j	.L40
.L39:
	lui	a5,%hi(quant26bt_neg)
	lw	a4,-24(s0)
	slli	a4,a4,2
	addi	a5,a5,%lo(quant26bt_neg)
	add	a5,a4,a5
	lw	a5,0(a5)
	sw	a5,-20(s0)
.L40:
	lw	a5,-20(s0)
	mv	a0,a5
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	quantl, .-quantl
	.align	2
	.globl	logscl
	.type	logscl, @function
logscl:
	addi	sp,sp,-48
	sw	s0,44(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	lw	a4,-40(s0)
	mv	a5,a4
	slli	a5,a5,7
	sub	a5,a5,a4
	srai	a5,a5,7
	sw	a5,-20(s0)
	lw	a5,-36(s0)
	srai	a4,a5,2
	lui	a5,%hi(wl_code_table)
	slli	a4,a4,2
	addi	a5,a5,%lo(wl_code_table)
	add	a5,a4,a5
	lw	a5,0(a5)
	lw	a4,-20(s0)
	add	a5,a4,a5
	sw	a5,-40(s0)
	lw	a5,-40(s0)
	bgez	a5,.L44
	sw	zero,-40(s0)
.L44:
	lw	a4,-40(s0)
	li	a5,20480
	addi	a5,a5,-2048
	ble	a4,a5,.L45
	li	a5,20480
	addi	a5,a5,-2048
	sw	a5,-40(s0)
.L45:
	lw	a5,-40(s0)
	mv	a0,a5
	lw	s0,44(sp)
	addi	sp,sp,48
	jr	ra
	.size	logscl, .-logscl
	.align	2
	.globl	scalel
	.type	scalel, @function
scalel:
	addi	sp,sp,-48
	sw	s0,44(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	lw	a5,-36(s0)
	srai	a5,a5,6
	andi	a5,a5,31
	sw	a5,-20(s0)
	lw	a5,-36(s0)
	srai	a5,a5,11
	sw	a5,-24(s0)
	lui	a5,%hi(ilb_table)
	lw	a4,-20(s0)
	slli	a4,a4,2
	addi	a5,a5,%lo(ilb_table)
	add	a5,a4,a5
	lw	a4,0(a5)
	lw	a5,-40(s0)
	addi	a3,a5,1
	lw	a5,-24(s0)
	sub	a5,a3,a5
	sra	a5,a4,a5
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	slli	a5,a5,3
	mv	a0,a5
	lw	s0,44(sp)
	addi	sp,sp,48
	jr	ra
	.size	scalel, .-scalel
	.align	2
	.globl	upzero
	.type	upzero, @function
upzero:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	sw	a2,-44(s0)
	lw	a5,-36(s0)
	bnez	a5,.L50
	sw	zero,-20(s0)
	j	.L51
.L52:
	lw	a5,-20(s0)
	slli	a5,a5,2
	lw	a4,-44(s0)
	add	a5,a4,a5
	lw	a4,0(a5)
	mv	a5,a4
	slli	a5,a5,8
	sub	a4,a5,a4
	lw	a5,-20(s0)
	slli	a5,a5,2
	lw	a3,-44(s0)
	add	a5,a3,a5
	srai	a4,a4,8
	sw	a4,0(a5)
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L51:
	lw	a4,-20(s0)
	li	a5,5
	ble	a4,a5,.L52
	j	.L53
.L50:
	sw	zero,-20(s0)
	j	.L54
.L57:
	lw	a5,-20(s0)
	slli	a5,a5,2
	lw	a4,-40(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	lw	a1,-36(s0)
	mv	a0,a5
	call	__mulsi3
	mv	a5,a0
	bltz	a5,.L55
	li	a5,128
	sw	a5,-24(s0)
	j	.L56
.L55:
	li	a5,-128
	sw	a5,-24(s0)
.L56:
	lw	a5,-20(s0)
	slli	a5,a5,2
	lw	a4,-44(s0)
	add	a5,a4,a5
	lw	a4,0(a5)
	mv	a5,a4
	slli	a5,a5,8
	sub	a5,a5,a4
	srai	a5,a5,8
	sw	a5,-28(s0)
	lw	a5,-20(s0)
	slli	a5,a5,2
	lw	a4,-44(s0)
	add	a5,a4,a5
	lw	a3,-24(s0)
	lw	a4,-28(s0)
	add	a4,a3,a4
	sw	a4,0(a5)
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L54:
	lw	a4,-20(s0)
	li	a5,5
	ble	a4,a5,.L57
.L53:
	lw	a5,-40(s0)
	addi	a5,a5,20
	lw	a4,-40(s0)
	lw	a4,16(a4)
	sw	a4,0(a5)
	lw	a5,-40(s0)
	addi	a5,a5,16
	lw	a4,-40(s0)
	lw	a4,12(a4)
	sw	a4,0(a5)
	lw	a5,-40(s0)
	addi	a5,a5,12
	lw	a4,-40(s0)
	lw	a4,8(a4)
	sw	a4,0(a5)
	lw	a5,-40(s0)
	addi	a5,a5,8
	lw	a4,-40(s0)
	lw	a4,4(a4)
	sw	a4,0(a5)
	lw	a5,-40(s0)
	addi	a5,a5,4
	lw	a4,-40(s0)
	lw	a4,0(a4)
	sw	a4,0(a5)
	lw	a5,-40(s0)
	lw	a4,-36(s0)
	sw	a4,0(a5)
	nop
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	upzero, .-upzero
	.align	2
	.globl	uppol2
	.type	uppol2, @function
uppol2:
	addi	sp,sp,-64
	sw	ra,60(sp)
	sw	s0,56(sp)
	addi	s0,sp,64
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	sw	a2,-44(s0)
	sw	a3,-48(s0)
	sw	a4,-52(s0)
	lw	a5,-36(s0)
	slli	a5,a5,2
	sw	a5,-20(s0)
	lw	a1,-48(s0)
	lw	a0,-44(s0)
	call	__mulsi3
	mv	a5,a0
	bltz	a5,.L59
	lw	a5,-20(s0)
	sub	a5,zero,a5
	sw	a5,-20(s0)
.L59:
	lw	a5,-20(s0)
	srai	a5,a5,7
	sw	a5,-20(s0)
	lw	a1,-52(s0)
	lw	a0,-44(s0)
	call	__mulsi3
	mv	a5,a0
	bltz	a5,.L60
	lw	a5,-20(s0)
	addi	a5,a5,128
	sw	a5,-24(s0)
	j	.L61
.L60:
	lw	a5,-20(s0)
	addi	a5,a5,-128
	sw	a5,-24(s0)
.L61:
	lw	a4,-40(s0)
	mv	a5,a4
	slli	a5,a5,7
	sub	a5,a5,a4
	srai	a5,a5,7
	lw	a4,-24(s0)
	add	a5,a4,a5
	sw	a5,-28(s0)
	lw	a4,-28(s0)
	li	a5,12288
	ble	a4,a5,.L62
	li	a5,12288
	sw	a5,-28(s0)
.L62:
	lw	a4,-28(s0)
	li	a5,-12288
	bge	a4,a5,.L63
	li	a5,-12288
	sw	a5,-28(s0)
.L63:
	lw	a5,-28(s0)
	mv	a0,a5
	lw	ra,60(sp)
	lw	s0,56(sp)
	addi	sp,sp,64
	jr	ra
	.size	uppol2, .-uppol2
	.align	2
	.globl	uppol1
	.type	uppol1, @function
uppol1:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	sw	a2,-44(s0)
	sw	a3,-48(s0)
	lw	a4,-36(s0)
	mv	a5,a4
	slli	a5,a5,8
	sub	a5,a5,a4
	srai	a5,a5,8
	sw	a5,-24(s0)
	lw	a1,-48(s0)
	lw	a0,-44(s0)
	call	__mulsi3
	mv	a5,a0
	bltz	a5,.L66
	lw	a5,-24(s0)
	addi	a5,a5,192
	sw	a5,-20(s0)
	j	.L67
.L66:
	lw	a5,-24(s0)
	addi	a5,a5,-192
	sw	a5,-20(s0)
.L67:
	li	a5,16384
	addi	a4,a5,-1024
	lw	a5,-40(s0)
	sub	a5,a4,a5
	sw	a5,-28(s0)
	lw	a4,-20(s0)
	lw	a5,-28(s0)
	ble	a4,a5,.L68
	lw	a5,-28(s0)
	sw	a5,-20(s0)
.L68:
	lw	a5,-28(s0)
	sub	a5,zero,a5
	lw	a4,-20(s0)
	bge	a4,a5,.L69
	lw	a5,-28(s0)
	sub	a5,zero,a5
	sw	a5,-20(s0)
.L69:
	lw	a5,-20(s0)
	mv	a0,a5
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	uppol1, .-uppol1
	.align	2
	.globl	logsch
	.type	logsch, @function
logsch:
	addi	sp,sp,-48
	sw	s0,44(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	lw	a4,-40(s0)
	mv	a5,a4
	slli	a5,a5,7
	sub	a5,a5,a4
	srai	a5,a5,7
	sw	a5,-20(s0)
	lui	a5,%hi(wh_code_table)
	lw	a4,-36(s0)
	slli	a4,a4,2
	addi	a5,a5,%lo(wh_code_table)
	add	a5,a4,a5
	lw	a5,0(a5)
	lw	a4,-20(s0)
	add	a5,a4,a5
	sw	a5,-40(s0)
	lw	a5,-40(s0)
	bgez	a5,.L72
	sw	zero,-40(s0)
.L72:
	lw	a4,-40(s0)
	li	a5,24576
	addi	a5,a5,-2048
	ble	a4,a5,.L73
	li	a5,24576
	addi	a5,a5,-2048
	sw	a5,-40(s0)
.L73:
	lw	a5,-40(s0)
	mv	a0,a5
	lw	s0,44(sp)
	addi	sp,sp,48
	jr	ra
	.size	logsch, .-logsch
	.globl	test_data
	.section	.rodata
	.align	2
	.type	test_data, @object
	.size	test_data, 400
test_data:
	.word	68
	.word	68
	.word	68
	.word	68
	.word	68
	.word	68
	.word	68
	.word	68
	.word	68
	.word	68
	.word	68
	.word	68
	.word	68
	.word	68
	.word	68
	.word	68
	.word	68
	.word	67
	.word	67
	.word	67
	.word	67
	.word	67
	.word	67
	.word	67
	.word	66
	.word	66
	.word	66
	.word	66
	.word	66
	.word	66
	.word	65
	.word	65
	.word	65
	.word	65
	.word	65
	.word	64
	.word	64
	.word	64
	.word	64
	.word	64
	.word	64
	.word	64
	.word	64
	.word	63
	.word	63
	.word	63
	.word	63
	.word	63
	.word	62
	.word	62
	.word	62
	.word	62
	.word	62
	.word	62
	.word	61
	.word	61
	.word	61
	.word	61
	.word	61
	.word	61
	.word	60
	.word	60
	.word	60
	.word	60
	.word	60
	.word	60
	.word	60
	.word	60
	.word	60
	.word	59
	.word	59
	.word	59
	.word	59
	.word	59
	.word	59
	.word	59
	.word	59
	.word	59
	.word	59
	.word	59
	.word	59
	.word	59
	.word	59
	.word	59
	.word	59
	.word	59
	.word	59
	.word	59
	.word	59
	.word	59
	.word	59
	.word	59
	.word	60
	.word	60
	.word	60
	.word	60
	.word	60
	.word	60
	.word	60
	.word	60
	.comm	compressed,400,4
	.comm	result,400,4
	.globl	test_compressed
	.align	2
	.type	test_compressed, @object
	.size	test_compressed, 400
test_compressed:
	.word	253
	.word	222
	.word	119
	.word	186
	.word	242
	.word	144
	.word	32
	.word	160
	.word	236
	.word	237
	.word	239
	.word	241
	.word	243
	.word	244
	.word	245
	.word	245
	.word	245
	.word	245
	.word	246
	.word	246
	.word	246
	.word	247
	.word	248
	.word	247
	.word	248
	.word	247
	.word	249
	.word	248
	.word	247
	.word	249
	.word	248
	.word	248
	.word	246
	.word	248
	.word	248
	.word	247
	.word	249
	.word	249
	.word	249
	.word	248
	.word	247
	.word	250
	.word	248
	.word	248
	.word	247
	.word	251
	.word	250
	.word	249
	.word	248
	.word	248
	.zero	200
	.globl	test_result
	.align	2
	.type	test_result, @object
	.size	test_result, 400
test_result:
	.word	0
	.word	-1
	.word	-1
	.word	0
	.word	0
	.word	-1
	.word	0
	.word	0
	.word	-1
	.word	-1
	.word	0
	.word	0
	.word	1
	.word	1
	.word	0
	.word	-2
	.word	-1
	.word	-2
	.word	0
	.word	-4
	.word	1
	.word	1
	.word	1
	.word	-5
	.word	2
	.word	2
	.word	3
	.word	11
	.word	20
	.word	20
	.word	22
	.word	24
	.word	32
	.word	33
	.word	38
	.word	39
	.word	46
	.word	47
	.word	51
	.word	50
	.word	53
	.word	51
	.word	54
	.word	52
	.word	55
	.word	52
	.word	55
	.word	53
	.word	56
	.word	54
	.word	57
	.word	56
	.word	59
	.word	58
	.word	63
	.word	63
	.word	64
	.word	58
	.word	61
	.word	62
	.word	65
	.word	60
	.word	62
	.word	63
	.word	66
	.word	62
	.word	59
	.word	55
	.word	59
	.word	62
	.word	65
	.word	59
	.word	59
	.word	58
	.word	59
	.word	54
	.word	57
	.word	59
	.word	63
	.word	60
	.word	59
	.word	55
	.word	59
	.word	61
	.word	65
	.word	61
	.word	62
	.word	60
	.word	62
	.word	59
	.word	58
	.word	55
	.word	59
	.word	62
	.word	65
	.word	60
	.word	59
	.word	57
	.word	58
	.word	54
	.text
	.align	2
	.globl	adpcm_main
	.type	adpcm_main, @function
adpcm_main:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	sw	s1,20(sp)
	addi	s0,sp,32
	call	reset
	li	a5,10
	sw	a5,-24(s0)
	sw	zero,-20(s0)
	j	.L76
.L77:
	lui	a5,%hi(test_data)
	lw	a4,-20(s0)
	slli	a4,a4,2
	addi	a5,a5,%lo(test_data)
	add	a5,a4,a5
	lw	a3,0(a5)
	lw	a5,-20(s0)
	addi	a4,a5,1
	lui	a5,%hi(test_data)
	slli	a4,a4,2
	addi	a5,a5,%lo(test_data)
	add	a5,a4,a5
	lw	a2,0(a5)
	lw	a5,-20(s0)
	srli	a4,a5,31
	add	a5,a4,a5
	srai	a5,a5,1
	mv	s1,a5
	mv	a1,a2
	mv	a0,a3
	call	encode
	mv	a3,a0
	lui	a5,%hi(compressed)
	slli	a4,s1,2
	addi	a5,a5,%lo(compressed)
	add	a5,a4,a5
	sw	a3,0(a5)
	lw	a5,-20(s0)
	addi	a5,a5,2
	sw	a5,-20(s0)
.L76:
	lw	a4,-20(s0)
	li	a5,99
	ble	a4,a5,.L77
	sw	zero,-20(s0)
	j	.L78
.L79:
	lw	a5,-20(s0)
	srli	a4,a5,31
	add	a5,a4,a5
	srai	a5,a5,1
	mv	a4,a5
	lui	a5,%hi(compressed)
	slli	a4,a4,2
	addi	a5,a5,%lo(compressed)
	add	a5,a4,a5
	lw	a5,0(a5)
	mv	a0,a5
	call	decode
	lui	a5,%hi(xout1)
	lw	a4,%lo(xout1)(a5)
	lui	a5,%hi(result)
	lw	a3,-20(s0)
	slli	a3,a3,2
	addi	a5,a5,%lo(result)
	add	a5,a3,a5
	sw	a4,0(a5)
	lw	a5,-20(s0)
	addi	a3,a5,1
	lui	a5,%hi(xout2)
	lw	a4,%lo(xout2)(a5)
	lui	a5,%hi(result)
	slli	a3,a3,2
	addi	a5,a5,%lo(result)
	add	a5,a3,a5
	sw	a4,0(a5)
	lw	a5,-20(s0)
	addi	a5,a5,2
	sw	a5,-20(s0)
.L78:
	lw	a4,-20(s0)
	li	a5,99
	ble	a4,a5,.L79
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	lw	s1,20(sp)
	addi	sp,sp,32
	jr	ra
	.size	adpcm_main, .-adpcm_main
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	sw	zero,-24(s0)
	call	adpcm_main
	sw	zero,-20(s0)
	j	.L81
.L83:
	lui	a5,%hi(compressed)
	lw	a4,-20(s0)
	slli	a4,a4,2
	addi	a5,a5,%lo(compressed)
	add	a5,a4,a5
	lw	a4,0(a5)
	lui	a5,%hi(test_compressed)
	lw	a3,-20(s0)
	slli	a3,a3,2
	addi	a5,a5,%lo(test_compressed)
	add	a5,a3,a5
	lw	a5,0(a5)
	beq	a4,a5,.L82
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
.L82:
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L81:
	lw	a4,-20(s0)
	li	a5,49
	ble	a4,a5,.L83
	sw	zero,-20(s0)
	j	.L84
.L86:
	lui	a5,%hi(result)
	lw	a4,-20(s0)
	slli	a4,a4,2
	addi	a5,a5,%lo(result)
	add	a5,a4,a5
	lw	a4,0(a5)
	lui	a5,%hi(test_result)
	lw	a3,-20(s0)
	slli	a3,a3,2
	addi	a5,a5,%lo(test_result)
	add	a5,a3,a5
	lw	a5,0(a5)
	beq	a4,a5,.L85
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
.L85:
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L84:
	lw	a4,-20(s0)
	li	a5,99
	ble	a4,a5,.L86
	lw	a5,-24(s0)
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (GNU) 7.2.0"