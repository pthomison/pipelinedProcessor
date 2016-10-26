ORI $29, $0, 0xFFFC

#First number in $10, second in $11, final answer in $12

ORI $3, $0, 0x02
ORI $4, $0, 0x02
PUSH $3
PUSH $4
JAL mult
HALT

mult:
POP $10
POP $11

loopp:
	ADD  $12, $12, $10	#add $10 to sum $11 times
	ADDI $11, $11, -1	
	BNE  $11, $0, loopp
	PUSH $12
	JR $31
