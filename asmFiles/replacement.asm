org 0x0000

#A, B and C
ori $1, $0, 0xA000
ori $2, $0, 0xB000
ori $3, $0, 0xC000
ori $14, $0, 0xD000

#Numbers
ori $10, $0, 22 #16
ori $11, $0, 33 #21
ori $12, $0, 44 #2C
ori $13, $0, 55 #37

lw $4, 0($1) #read miss A, cache1
lw $5, 0($2) #read miss B, cache2

sw  $10, 0($1) #write hit, cache1 dirty
sw  $11, 0($2) #write hit, cache2 dirty

#replacement here
sw $11, 0($3) #write miss C, cache1
sw $12, 0($3) #write hit, cache1 dirty

lw $7, 0($14) #read miss D, cache2
sw  $13, 0($14) #write hit, cache2 dirty

HALT


org 0x0000A000
cfw 1
cfw 2

org 0x0000B000
cfw 3
cfw 4

org 0x0000C000
cfw 5
cfw 6

org 0x0000D000
cfw 7
cfw 8
