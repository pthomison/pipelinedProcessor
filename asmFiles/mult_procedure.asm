
ORI $29, $0, 0xFFFC


#First number in $10, second in $11, final answer in $12
#ORI $10, $0, 0x02
#ORI $11, $0, 0x04


ORI $20, $0, 0x02
PUSH $20
ORI $21, $0, 0x03
PUSH $21
ORI $22, $0, 0x04
PUSH $22
ORI $23, $0, 0x05
PUSH $23

ORI $2, $0, 0x03 #There are 4 things on the stack, save 3

floopp:
	JAL mult
	ADDI $2, $2, -1	
	BNE  $2, $0, floopp

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
	
