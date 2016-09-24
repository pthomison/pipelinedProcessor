org   0x0000
ori   $1, $zero, 0x00F0
ori   $2, $zero, 0x00F0
ori   $3, $zero, 0x0080
ori   $4, $zero, 0x0080

add $8, $2, $1
add $8, $2, $1
add $8, $2, $1
add $8, $2, $1
add $8, $2, $1


beq $1, $2, jumpLabel


add $8, $2, $1
add $8, $2, $1
add $8, $2, $1
add $8, $2, $1
add $8, $2, $1
add $8, $2, $1
SW $4, 16($1)

halt

jumpLabel:

SW $4, 16($1)

bne $1, $2, jumpLabel

halt

org   0x00F0
cfw   0x7337

