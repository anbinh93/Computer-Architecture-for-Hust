# Laboratory Exercise 3, Assignment 6
# Author: Nguyễn Bình An - 20225591
.data
	A: .word 3,4,-6,7,-2,-8,1,8,9,10 # length(arr)=n= 10
.text
	addi $s1, $zero, 0 # i = 0
	addi $s2, $zero, 1 # step = 1
	addi $s3, $zero, 10# n = 10
	addi $s4, $zero, 0 # max = 0
	la $a0, A	# Load address A[0] to $a0
	lw $s4, 0($a0)	    # Load value of A[0] in $s4=max
	slt $t4,$s4,$zero  # $t4 = $s4 < 0 ? 1 : 0
	bne $t4,$zero,_abs1# if A[i]<0 max= 0-max
	j 	loop		   # goto loop	
	_abs1: sub $s4, $zero, $s4 #max = 0-max

loop:
	slt $t0, $s1, $s3 # i < n
	beq $t0, $zero, endloop
	add $s1,$s1,$s2 #i=i+step
	add $t1,$s1,$s1 #t1=2*s1
	add $t1,$t1,$t1 #t1=4*s1
	add $t1,$t1,$a0 #t1 store the address of A[i]
	lw  $t2,0($t1)  #load value of A[i] in $t2
	slt $t4, $t2, $zero #A[i]<0
	bne $t4, $zero, _abs#if A[i]<0 then A[i]=0-(A[i])
	j continue
	_abs: 
		sub $t2, $zero, $t2	# A[i]=0-A[i]
	continue:
		sgt $t3,$t2,$s4 	#A[i] > max
		bne $t3,$zero,update#if A[i]>max, goto update max=A[i]
		j   loop			#goto loop	
	update: 
		add $s4, $t2, $zero#update max=A[i]
		j	loop		   #goto loop	
endloop: