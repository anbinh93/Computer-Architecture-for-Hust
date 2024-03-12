# Laboratory Exercise 4, Assignment 3
# Author: Nguyễn Bình An - 20225591
.text
	li $s1, -2
	li $s2, 3
	
# d. ble $s1, $s2, label
	slt $t0, $s2, $s1
	beq $t0, $zero, label

label: