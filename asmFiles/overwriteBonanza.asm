org 0x0000

ori $1, $0, 0x0500
ori $2, $0, 0x0564
ori $3, $0, 0x0099
ori $4, $0, 0x0088
ori $5, $0, 0x0077
ori $6, $0, 0x0066

sw $3, 0($1)
sw $4, 8($1)
sw $5, 0($2)
sw $6, 8($2)

halt

org 0x00000500
cfw 0x25
cfw 0x30
cfw 0x35
cfw 0x40

org 0x00000564
cfw 0x45
cfw 0x50
cfw 0x55
cfw 0x60
