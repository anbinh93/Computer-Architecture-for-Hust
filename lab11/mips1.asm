.eqv IN_ADRESS_HEXA_KEYBOARD 0xFFFF0012
.eqv OUT_ADRESS_HEXA_KEYBOARD 0xFFFF0014
.text
main: 
	li $t1, IN_ADRESS_HEXA_KEYBOARD
	li $t2, OUT_ADRESS_HEXA_KEYBOARD
polling: 
	li $t0, 0x01 # check row 1 with key 0x01, 0x02, 0x04, 0x08
	li $t3, 0x10
loop: 
	beq $t0, $t3, print 
	sb $t0, 0($t1) # must reassign expected row	
	lb $a0, 0($t2) # read scan code of key button
	bne $a0, 0, print
	sll $t0, $t0, 1
	j loop
print: 
 	li $v0, 34 # print integer (hexa)
	syscall
	li $v0, 11
	li $a0, 10
 	syscall
sleep: 
 	li $a0, 2000 # sleep 2000ms
 	li $v0, 32
 	syscall 
back_to_polling: 
	j polling # continue polling
