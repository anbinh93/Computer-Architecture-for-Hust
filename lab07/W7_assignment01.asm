# Laboratory Exercise 7, Assignment 1
# Author: Nguyễn Bình An - 20225591
.data 
	Message: .asciiz "Result: "
.text
main: 
	li $a0,-99 #load input parameter
	jal abs #jump and link to abs procedure
	nop
	add $a1, $zero, $v0 #$a1 = abs($a0)
	
	li $v0, 56
	la $a0, Message
	syscall
	
	li $v0,10 #terminate
	syscall
endmain:
abs:
	sub $v0,$zero,$a0 #put -(a0) in v0; in case (a0)<0
	bltz $a0,done #if (a0)<0 then done
	nop
	add $v0,$a0,$zero #else put (a0) in v0
done:
	jr $ra
