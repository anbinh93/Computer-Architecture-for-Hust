.eqv SEVENSEG_LEFT 0xFFFF0011 # Dia chi cua den led 7 doan trai.
# Bit 0 = doan a;
# Bit 1 = doan b; ...
# Bit 7 = dau .
.eqv SEVENSEG_RIGHT 0xFFFF0010 # Dia chi cua den led 7 doan phai
.text
main:
    li $a0, 0xE7 # set value for left segments to display "9"
    jal SHOW_7SEG_LEFT # show "9" on left 7-segment display
    nop
    li $a0, 0x06 # set value for right segments to display "1"
    jal SHOW_7SEG_RIGHT # show "1" on right 7-segment display
    nop 
    exit: 
    li $v0, 10
    syscall
endmain:

SHOW_7SEG_LEFT: 
    li $t0, SEVENSEG_LEFT # assign port's address
    sb $a0, 0($t0) # assign new value to display "9"
    nop    
    jr $ra
    nop

SHOW_7SEG_RIGHT: 
    li $t0, SEVENSEG_RIGHT # assign port's address
    sb $a0, 0($t0) # assign new value to display "1"
    nop    
    jr $ra
    nop
