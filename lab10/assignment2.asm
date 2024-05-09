.data
prompt: .asciiz "input: "
sevenseg_left: .word 0xFFFF0011 # Địa chỉ cho LED 7 đoạn bên trái
sevenseg_right: .word 0xFFFF0010 # Địa chỉ cho LED 7 đoạn bên phải

# Mẫu bit cho các chữ số 0-9 trên LED 7 đoạn bên trái
digit_patterns_left: .word 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x67

# Mẫu bit cho các chữ số 0-9 trên LED 7 đoạn bên phải (mẫu chuẩn)
digit_patterns_right: .word 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F

.text
.globl main

main:
    # In thông báo nhắc nhập
    li $v0, 4       # 4 = in chuỗi
    la $a0, prompt  # tải địa chỉ của chuỗi thông báo
    syscall         # in thông báo

    # Đọc số nguyên nhập vào
    li $v0, 5       # 5 = đọc số nguyên
    syscall         # đọc số nguyên từ người dùng
    move $t0, $v0   # lưu số nhập vào trong $t0

    # Trích xuất hai chữ số cuối
    li $t1, 100     # tải 100 vào $t1
    div $t0, $t1    # chia $t0 cho 100
    mfhi $t2        # số dư nằm trong $t2 (hai chữ số cuối)

    # Hiển thị chữ số hàng chục trên LED 7 đoạn bên trái
    li $t3, 10      # tải 10 vào $t3 (để làm phép modulo)
    div $t2, $t3    # chia hai chữ số cuối cho 10
    mflo $t4        # thương nằm trong $t4 (chữ số hàng chục)
    sll $t4, $t4, 2 # nhân chữ số hàng chục cho 4 (kích thước từ)
    lw $a0, digit_patterns_left($t4) # tải mẫu bit cho chữ số hàng chục
    jal SHOW_7SEG_LEFT # hiển thị chữ số hàng chục trên LED 7 đoạn bên trái

    # Hiển thị chữ số hàng đơn vị trên LED 7 đoạn bên phải
    mfhi $t4        # số dư nằm trong $t4 (chữ số hàng đơn vị)
    sll $t4, $t4, 2 # nhân chữ số hàng đơn vị cho 4 (kích thước từ)
    lw $a0, digit_patterns_right($t4) # tải mẫu bit cho chữ số hàng đơn vị
    jal SHOW_7SEG_RIGHT # hiển thị chữ số hàng đơn vị trên LED 7 đoạn bên phải

    li $v0, 10      
    syscall         # thoát

SHOW_7SEG_LEFT:
    lw $t0, sevenseg_left # tải địa chỉ của LED 7 đoạn bên trái
    sb $a0, 0($t0) # lưu mẫu bit tại địa chỉ của LED 7 đoạn bên trái
    nop
    jr $ra
    nop

SHOW_7SEG_RIGHT:
    lw $t0, sevenseg_right # tải địa chỉ của LED 7 đoạn bên phải
    sb $a0, 0($t0) # lưu mẫu bit tại địa chỉ của LED 7 đoạn bên phải
    nop
    jr $ra
    nop
