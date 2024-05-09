.eqv MONITOR_SCREEN 0x10010000
.eqv BROWN 0xA52A2A
.eqv GREEN 0x008000

.text
    li $k0, MONITOR_SCREEN  # Đặt địa chỉ bắt đầu của màn hình vào $k0

    li $t1, 8  # Số hàng của bàn cờ
    li $t5, 0  # Khởi tạo biến $t5 để xác định màu sắc bắt đầu của mỗi hàng

row_loop:
    li $t2, 8  # Số cột của bàn cờ
    move $t3, $t5  # Copy giá trị màu bắt đầu hàng từ $t5 vào $t3

col_loop:
    beq $t3, 0, draw_brown  # Kiểm tra nếu $t3 là 0, vẽ màu nâu
    li $t0, GREEN  # Nếu không, set màu xanh lá
    j draw_color

draw_brown:
    li $t0, BROWN  # Set màu nâu

draw_color:
    sw $t0, 0($k0)  # Ghi màu vào địa chỉ hiện tại trên màn hình
    addi $k0, $k0, 4  # Tăng địa chỉ màn hình lên để vẽ pixel tiếp theo
    not $t3, $t3  # Đảo bit của $t3 để thay đổi màu cho lần sau

    addi $t2, $t2, -1
    bnez $t2, col_loop  # Tiếp tục vòng lặp cột nếu chưa vẽ đủ 8 cột

    not $t5, $t5  # Đảo màu bắt đầu hàng cho hàng tiếp theo
    addi $t1, $t1, -1
    bnez $t1, row_loop  # Tiếp tục vòng lặp hàng nếu chưa vẽ đủ 8 hàng

    li $v0, 10  # Kết thúc chương trình
    syscall
