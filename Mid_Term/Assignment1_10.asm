#assignemt 1: 10_Nhập số nguyên dương N từ bàn phím, in ra tổng các chữ số trong biểu diễn nhị phân của N. 
#author: Nguyễn Bình An_20225591

.data
    INPUT: .asciiz "Nhap vào so nguyen N "
    result: .asciiz "Tong so bit: "

.text
main:
    # Prompt for input
    li $v0, 4
    la $a0, INPUT
    syscall

    # Read integer input
    li $v0, 5
    syscall
    move $a1, $v0        # Move read integer to $a1

    jal decimalToBinary  # Call the function to process the number

    # Print the total '1' bits counted
    li $v0, 4
    la $a0, result
    syscall
    li $v0, 1
    move $a0, $s0
    syscall

    # Exit the program
    li $v0, 10
    syscall

decimalToBinary:
    # Initialize registers
    move $t2, $a1         # Move input number into $t2 for processing
    move $s0, $zero       # Initialize $s0 to count the number of '1' bits

    # Loop to process each bit of the input number
    li $t0, 32            # Prepare to process 32 bits
loop1:
    andi $t3, $t2, 1      # Isolate the last bit of $t2
    beq $t3, $zero, skip_increment  # Skip incrementing $s0 if the bit is '0'
    addi $s0, $s0, 1      # Increment the result variable if bit is '1'
skip_increment:
    srl $t2, $t2, 1       # Shift right $t2 to get the next bit
    addi $t0, $t0, -1     # Decrement the bit index
    bgtz $t0, loop1       # Continue if there are more bits to process

    jr $ra                # Return from the function
