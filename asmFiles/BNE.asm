#Mergesort for benchmarking
#Optimized for 512 bit I$ 1024 bit D$
#Author Adam Hendrickson ahendri@purdue.edu

org 0x0000
  ori   $1, $zero, 0x1
  ori   $2, $zero, 0x1
  ori   $3, $zero, 0x2
  ori   $4, $zero, 0x2
  ori   $21, $zero, 0x0008

	BNE $1, $3, here
	ADD $5, $1, $1 #wont hit
	sw $13, 0($21) #wont
  	LW $14, 0($21)#wont happen

	here:
	BNE $1, $2, here
	ADD $6, $1, $1 #will hit
	sw $12, 0($21) #will
  	LW $15, 0($21)#will happen

	BNE $1, $3, here2
	ADD $7, $1, $1 #wont hit
	sw $11, 0($21) #wont

	here2:
	BNE $1, $3, here3
	ADD $8, $1, $1 #wont hit
	sw $10, 0($21) #wont

	here3:
	ADD $9, $1, $1 #will hit
	sw $1, 0($21) #will
	halt
