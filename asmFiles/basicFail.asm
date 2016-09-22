org   0x0000
ori   $1, $zero, 0x0001
ori   $2, $zero, 0x0002
ori   $30, $zero, 0x0800

ADD $3, $1, $2
ADD $4, $3, $2
ADD $5, $1, $4
ADD $6, $5, $4
ADD $7, $6, $6

SW $7, 0($30)

ADD $8, $7, $4
ADD $9, $1, $8

halt

org   0x00F0
cfw   0x7337
