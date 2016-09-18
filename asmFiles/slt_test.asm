org 0x0000

ori $1, $0, 0x7FFF
ori $2, $0, 0x7FFF

ori $10, $0, 0x0080
ori $11, $0, 0x0120
ori $12, $0, 0x0160
ori $13, $0, 0x0200


slt $3, $1, $2
sw $3, 0($10)

slt $3, $2, $1
sw $3, 0($11)

sltu $3, $1, $2
sw $3, 0($12)

sltu $3, $2, $1
sw $4, 0($13)

halt
