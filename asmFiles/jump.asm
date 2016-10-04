#Mergesort for benchmarking
#Optimized for 512 bit I$ 1024 bit D$
#Author Adam Hendrickson ahendri@purdue.edu

org 0x0000
  ori   $1, $zero, 0x1
  ori   $21, $zero, 0x0008

  jal   here

  add   $2, $1, $1

  jal   here2


  j done
  add   $5, $1, $1 #wont happen
  sw $6, 0($21)#wont happen

here:


  add   $3, $1, $1
  sw $7, 0($21)#will happen
  LW $8, 0($22)#will happen

  jr $31
  LW $5, 0($21)#wont happen
  add   $4, $1, $1 #wont happen
  sw $5, 0($21)#wont happen

here2:


  add   $3, $1, $1
  sw $7, 0($21)#will happen
  LW $8, 0($22)#will happen

  jr $31
  LW $5, 0($21)#wont happen
  add   $4, $1, $1 #wont happen
  sw $5, 0($21)#wont happen
  
done:
	sw $1, 0($21) #will happen

  	add   $6, $1, $1
	halt
