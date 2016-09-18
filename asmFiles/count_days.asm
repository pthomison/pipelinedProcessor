
ORI $29, $0, 0xFFFC

#$2 Current Year 2016 = 7E0, 2003 = 7D3
#$3 Current Month
#$4 Current Day 31 = 1F
#$5  365 = 16D
#$6  30 = 1E
#$7  Temp Reg
#$8  Temp Reg
#$9  2000 = 7D0


ORI $2, $0, 0x7D3
ORI $3, $0, 0x03
ORI $4, $0, 0x03
ORI $5, $0, 0x16D
ORI $6, $0, 0x1E
ORI $9, $0, 0x7D0
ORI $21, $0, 0x008

SUB $2, $2, $9
PUSH $2
PUSH $5
JAL mult
POP $7

ADDI $3, $3, -1
PUSH $3
PUSH $6
JAL mult
POP $8

ADD $7, $7, $8
ADD $7, $7, $4

#$7 is final answer
	sw $2, 0($21)
HALT

mult:
POP $10
POP $11

ORI $12, $0, 0x00

loopp:
	ADD  $12, $12, $10	#add $10 to sum $11 times
	ADDI $11, $11, -1	
	BNE  $11, $0, loopp
	PUSH $12
	JR $31
	
