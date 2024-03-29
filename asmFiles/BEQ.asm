#Mergesort for benchmarking
#Optimized for 512 bit I$ 1024 bit D$
#Author Adam Hendrickson ahendri@purdue.edu

org 0x0000
  ori   $1, $zero, 0x1
  ori   $2, $zero, 0x1
  ori   $3, $zero, 0x2
  ori   $4, $zero, 0x2
  ori   $21, $zero, 0x0008

	BEQ $1, $2, here
	ADD $5, $1, $1 #wont hit

	here:
	BEQ $1, $3, here
	ADD $6, $1, $1 #will hit

	BEQ $1, $2, here2
	ADD $7, $1, $1 #wont hit

	here2:
	BEQ $1, $2, here3
	ADD $8, $1, $1 #wont hit
	

	here3:
	ADD $9, $1, $1 #will hit
	sw $1, 0($21)
	halt
