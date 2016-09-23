org   0x0000
ori   $1, $zero, 0x00F0
ori   $2, $zero, 0x0080

add $8, $2, $1
add $8, $2, $1
add $8, $2, $1
add $8, $2, $1
add $8, $2, $1


jal   jumpLabel
add $8, $2, $1
add $8, $2, $1
add $8, $2, $1
add $8, $2, $1
add $8, $2, $1
add $8, $2, $1
SW $4, 16($1)

halt

jumpLabel:
sub $8, $1, $2
lw $3, 0($1)
add $4, $2, $3
jr $ra


halt

org   0x00F0
cfw   0x7337

