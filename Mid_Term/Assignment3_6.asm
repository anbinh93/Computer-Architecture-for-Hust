#assignemt 3: 6_Nhập vào xâu ký tự và ký tự C. In ra số lần xuất hiện ký tự C trong xâu (không phân biệt chữ hoa hay chữ thường)
#author: Nguyễn Bình An_20225591
.data
input_msg:  .asciiz "Enter a string: "
char_msg:   .asciiz "Enter a character to count: "
result_msg: .asciiz "\nNumber of occurrences: "
buffer:     .space 256    # Memory space for the input string

.text
.globl main

main:
    # Prompt and read the string
    li $v0, 4
    la $a0, input_msg
    syscall

    # Read string from keyboard
    li $v0, 8
    la $a0, buffer
    li $a1, 256
    syscall
    li $v0, 4
    la $a0, char_msg
    syscall

    # Read character from keyboard
    li $v0, 12
    syscall
    move $a1, $v0  # Store the character to count in $a1

    # Convert character to lowercase if it is uppercase
    li $t4, 'A'
    li $t5, 'Z'
    blt $a1, $t4, skip_convert_char
    bgt $a1, $t5, skip_convert_char
    addi $a1, $a1, 32  # Convert to lowercase

skip_convert_char:
    # Initialize occurrence count to 0
    li $t0, 0

    # Count occurrences of the character in the string
    la $t1, buffer  # Pointer to the start of the buffer
count_loop:
    lbu $t2, 0($t1)  # Load byte (unsigned) from the string
    beqz $t2, count_end  # If byte is zero (end of string), exit loop

    # Convert to lowercase if uppercase
    li $t3, 'A'
    li $t4, 'Z'
    blt $t2, $t3, check_char
    bgt $t2, $t4, check_char
    addi $t2, $t2, 32

check_char:
    beq $t2, $a1, increment  # If the character matches, increment count

    addi $t1, $t1, 1  # Move pointer to the next character
    j count_loop

increment:
    addi $t0, $t0, 1  # Increment the count
    addi $t1, $t1, 1  # Move pointer to the next character
    j count_loop

count_end:
    li $v0, 4         #Print the result message
    la $a0, result_msg
    syscall

    move $a0, $t0     # Print the number of occurrences
    li $v0, 1
    syscall

  
    li $v0, 10	       # Exit the program
    syscall
