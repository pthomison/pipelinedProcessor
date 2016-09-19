org 0x0000

ori $1, $0, 0x7FFF
ori $2, $0, 0x0001

ori $10, $0, 0x0800
ori $11, $0, 0x1200
ori $12, $0, 0x1600
ori $13, $0, 0x2000
ori $14, $0, 0x2400
ori $15, $0, 0x2800
ori $16, $0, 0x3200
ori $17, $0, 0x3600


slt $3, $1, $2
sw $3, 0($10)

slt $3, $2, $1
sw $3, 0($11)

sltu $3, $1, $2
sw $3, 0($12)

sltu $3, $2, $1
sw $4, 0($13)

#pos and zero
ori $1, $0, 0x7FFF
ori $2, $0, 0x0001

slti $4, $1, 0x0000
sw $4, 0($14)

slti $4, $2, 0x0000
sw $4, 0($15)

sltiu $4, $1, 0x0000
sw $4, 0($16)

sltiu $4, $2, 0x0000
sw $4, 0($17)


#neg and zero
ori $1, $0, 0xFFFF
ori $2, $0, 0x8001

slti $4, $1, 0x0000
sw $4, 0($14)

slti $4, $2, 0x0000
sw $4, 0($15)

sltiu $4, $1, 0x0000
sw $4, 0($16)

sltiu $4, $2, 0x0000
sw $4, 0($17)


#pos and large pos
ori $1, $0, 0x7FFF
ori $2, $0, 0x0001

slti $4, $1, 0x7FFF
sw $4, 0($14)

slti $4, $2, 0x7FFF
sw $4, 0($15)

sltiu $4, $1, 0x7FFF
sw $4, 0($16)

sltiu $4, $2, 0x7FFF
sw $4, 0($17)


#pos and small pos
ori $1, $0, 0x7FFF
ori $2, $0, 0x0001

slti $4, $1, 0x0005
sw $4, 0($14)

slti $4, $2, 0x0005
sw $4, 0($15)

sltiu $4, $1, 0x0005
sw $4, 0($16)

sltiu $4, $2, 0x0005
sw $4, 0($17)



#pos and large neg
ori $1, $0, 0x7FFF
ori $2, $0, 0x0001

slti $4, $1, 0x8000
sw $4, 0($14)

slti $4, $2, 0x8000
sw $4, 0($15)

sltiu $4, $1, 0x8000
sw $4, 0($16)

sltiu $4, $2, 0x8000
sw $4, 0($17)

add $0, $0, $0

#pos and small neg
ori $1, $0, 0x7FFF
ori $2, $0, 0x0001

slti $5, $1, 0xFFFF
sw $5, 0($15)

slti $4, $2, 0xFFFF
sw $4, 0($15)

sltiu $4, $1, 0xFFFF
sw $4, 0($16)

sltiu $4, $2, 0xFFFF
sw $4, 0($17)


halt
