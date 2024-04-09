#assignemt 2: 1_Nhập mảng số nguyên từ bàn phím. In ra số phần tử của mảng nằm trong đoạn (M, N) với M và N là 2 số nguyên nhập từ bàn phím.  
#author: Nguyễn Bình An_20225591
.data
array: .space 400         # Define an array of 100 integers (4 bytes each)
size: .asciiz "Nhap so phan tu cua mang: "
elements: .asciiz "Nhap vao cac phan tu: "
M: .asciiz "Gia tri M: "
N: .asciiz "Gia tri N: "
result: .asciiz "So phan tu nam trong khoang (M, N): "

.text
main:
    # Input the number of elements in the array
    li $v0, 4
    la $a0, size
    syscall
    
    li $v0, 5
    syscall
    move $t0, $v0              # $t0 is the number of elements in the array
    
    # Input the array elements
    li $v0, 4
    la $a0, elements
    syscall
    
    la $t1, array              # $t1 is the base address of the array
    li $t2, 0                  # $t2 is the loop counter
    
input_loop:
    blt $t2, $t0, read_element # Check loop condition
    j process
read_element:
    li $v0, 5
    syscall
    sw $v0, 0($t1)             # Store the input value into the array
    addiu $t1, $t1, 4          # Increment array address
    addiu $t2, $t2, 1          # Increment loop counter
    j input_loop
    
process:
    # Input M and N
    li $v0, 4
    la $a0, M
    syscall
    li $v0, 5
    syscall
    move $t3, $v0              # $t3 is M
    li $v0, 4
    la $a0, N
    syscall
    li $v0, 5
    syscall
    move $t4, $v0              # $t4 is N
    
    # Count elements in the range (M, N)
    li $t5, 0                  # $t5 is the counter
    la $t1, array              # Reset the address of the array
    li $t2, 0                  # Reset the loop counter
    
count_loop:
    bge $t2, $t0, print_result
    lw $t6, 0($t1)
    addiu $t1, $t1, 4
    addiu $t2, $t2, 1
   
    ble $t6, $t3, count_loop  # Check if the element is in the range (M, N)
    bge $t6, $t4, count_loop
    addiu $t5, $t5, 1
    j count_loop
    
print_result:
    li $v0, 4
    la $a0, result
    syscall
    
    li $v0, 1
    move $a0, $t5
    syscall
    
    li $v0, 10
    syscall
