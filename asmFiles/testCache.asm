ori $1, $0, 0x100
lw  $2, 0($1)
nop
nop
nop
nop
nop
nop
nop
nop
nop
sw  $2, 4($1)
halt

org 0x00000100
cfw 0x25
