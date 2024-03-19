.data
    Message1: .asciiz "Chuoi da nhap la: "
    Message2: .asciiz "Chuoi dao nguoc la: "
    Message3: .asciiz "\n"
    string: .space "hust"

.text
main:
    # Nhập chuỗi từ người dùng
    li $v0, 8              # syscall code for read_string
    la $a0, string         # địa chỉ của bộ nhớ để lưu trữ chuỗi nhập vào
    li $a1, 21             # kích thước tối đa của chuỗi
    syscall

    # In chuỗi vừa nhập
    la $a0, Message1
    li $v0, 4
    syscall
    la $a0, string
    li $v0, 4
    syscall
    la $a0, Message3
    li $v0, 4
    syscall

    # Đo độ dài chuỗi
    la $a0, string          # a0 = Address(string[0])
    li $v0, 0               # v0 = length = 0
loop_length:
    lb $t1, 0($a0)          # t1 = string[i]
    beqz $t1, end_loop_length # Kết thúc nếu t1 == '\0'
    addiu $a0, $a0, 1       # Tăng chỉ số của chuỗi
    addiu $v0, $v0, 1       # Tăng độ dài
    j loop_length
end_loop_length:
    subiu $v0, $v0, 1       # Trừ đi 1 để loại bỏ ký tự null

    # Đảo ngược chuỗi
    la $a0, string          # Đặt lại $a0 để trỏ đến đầu chuỗi
    li $t0, 0               # i = 0
    move $t1, $v0           # j = length - 1
reverse_loop:
    slt $t2, $t0, $t1       # Kiểm tra nếu i < j
    beqz $t2, end_reverse   # Nếu i >= j, thoát vòng lặp
    add $t3, $a0, $t0       # Địa chỉ của string[i]
    add $t4, $a0, $t1       # Địa chỉ của string[j]
    lb $t5, 0($t3)          # t5 = string[i]
    lb $t6, 0($t4)          # t6 = string[j]
    sb $t6, 0($t3)          # string[i] = string[j]
    sb $t5, 0($t4)          # string[j] = string[i]
    addiu $t0, $t0, 1       # i++
    subiu $t1, $t1, 1       # j--
    j reverse_loop
end_reverse:

    # In chuỗi đảo ngược
    la $a0, Message2
    li $v0, 4
    syscall
    la $a0, string
    li $v0, 4
    syscall

    # Kết thúc chương trình
    li $v0, 10             # syscall code for exit
    syscall
