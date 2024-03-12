# Laboratory Exercise 4, Assignment 5
# Author: Nguyễn Bình An - 20225591
.text	
	li $s1, 8
	li $s2, 8
	li $s3, 0 # ans=$s1*$s2
	li $t0, 1 # tmp = 1 - 10 - 100 - 1000
	li $t1, 0 # count
loop:
	and $t2, $t0, $s2 # $t2 = $t0 and $s2
	bne $t2, $zero, multiple #if $t2 !=0 => multiple
	j next #if $t2 ==0 => next
multiple:
	sllv $t3, $s1, $t1 # $t3 = $s1*2^($t1)
	add $s3, $s3, $t3  # $s3 = $s3 + $t3
next:
	sll $t0, $t0, 1    # shift $t0 to the left 1 bit
	addi $t1, $t1, 1   # count++
	slt $t4, $s2, $t0   #if $s2 < $t0 
	beq $t4, $zero, loop # if $s2 >= $t0 then next loop 
	j exit		    #if not then exit	
exit:


