org   0x0000
ori   $1, $zero, 0x0001
ori   $2, $zero, 0x0002

ADD $3, $1, $2
SUB $4, $2, $1
ADDI $5, $1, 0x0005
SLL $6, $2, 0x0002
SRL $7, $2, 0x0001

#lw    $3, 0($1)
#sw    $3, 0($2)

halt

org   0x00F0
cfw   0x7337
