.eqv MONITOR_SCREEN 0x10010000
.eqv RED 0x00FF0000
.eqv GREEN 0x0000FF00

.data
prompt_x1:     .asciiz "Enter x1: "
prompt_y1:     .asciiz "Enter y1: "
prompt_x2:     .asciiz "Enter x2: "
prompt_y2:     .asciiz "Enter y2: "
error_x2:      .asciiz "Error: x2 must be different from x1. Please re-enter.\n"
error_y2:      .asciiz "Error: y2 must be different from y1. Please re-enter.\n"

.text
.globl main

main:
    # Get x1 coordinate
    la $a0, prompt_x1
    jal prompt_and_read
    move $s0, $v0

    # Get y1 coordinate
    la $a0, prompt_y1
    jal prompt_and_read
    move $s1, $v0

read_x2:
    # Get x2 coordinate
    la $a0, prompt_x2
    jal prompt_and_read
    move $s2, $v0

    # Check if x2 is different from x1
    beq $s2, $s0, error_x2_handler
    j read_y2

error_x2_handler:
    la $a0, error_x2
    jal print_string
    j read_x2

read_y2:
    # Get y2 coordinate
    la $a0, prompt_y2
    jal prompt_and_read
    move $s3, $v0

    # Check if y2 is different from y1
    beq $s3, $s1, error_y2_handler
    j draw_rectangle

error_y2_handler:
    la $a0, error_y2
    jal print_string
    j read_y2

draw_rectangle:
    # Determine the starting and ending points
    slt $t0, $s0, $s2
    slt $t1, $s1, $s3
    move $t2, $s0   # x_start
    move $t3, $s1   # y_start
    beq $t0, $zero, swap_x
    move $t4, $s2   # x_end
    j swap_y
swap_x:
    move $t4, $s0   # x_end
    move $t2, $s2   # x_start
swap_y:
    beq $t1, $zero, draw_loop
    move $t5, $s3   # y_end
    j draw_loop
    move $t5, $s1   # y_end

draw_loop:
    move $t6, $t2   # x = x_start
outer_loop:
    move $t7, $t3   # y = y_start
inner_loop:
    # Draw pixel at (x, y)
    jal draw_pixel

    addi $t7, $t7, 1   # y++
    bne $t7, $t5, inner_loop   # Loop until y == y_end

    addi $t6, $t6, 1   # x++
    bne $t6, $t4, outer_loop   # Loop until x == x_end

    # Exit program
    li $v0, 10
    syscall

# Subroutines
prompt_and_read:
    # Print prompt
    li $v0, 4
    syscall

    # Read integer
    li $v0, 5
    syscall

    jr $ra

print_string:
    # Print string
    li $v0, 4
    syscall

    jr $ra

draw_pixel:
    # Calculate pixel address
    sll $t8, $t7, 6     # y * 64
    add $t8, $t8, $t6   # y * 64 + x
    sll $t8, $t8, 2     # (y * 64 + x) * 4
    add $t8, $t8, $k0   # Add the base address of the bitmap display memory

    # Check if pixel is on the border
    beq $t7, $t3, border   # Top border
    beq $t7, $t5, border   # Bottom border
    beq $t6, $t2, border   # Left border
    beq $t6, $t4, border   # Right border
    j interior

border:
    lw $t9, RED($gp)   # Load RED color
    sw $t9, ($t8)      # Store color at pixel address
    jr $ra

interior:
    lw $t9, GREEN($gp)   # Load GREEN color
    sw $t9, ($t8)        # Store color at pixel address
    jr $ra