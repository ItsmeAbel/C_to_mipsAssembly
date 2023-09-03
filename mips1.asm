.data
antal: .word 10
vek: .word 4,5,2,2,1,6,7,9,5,10
newline: .asciiz "\n"
space: .asciiz ", "







.text
.globl main
main:

lw $a0, antal
la $a1, vek
jal skriv

li $v0, 10
syscall

skriv:
#förbreda parametrarna
#a0 till antal, a1 till v[]
addi $t0, $zero, 0 #i
move $t3, $a0	#flyttar Antal till t3 registern
move $t4, $a1	#flyttar Vek till t4 registern


addi $v0, $zero, 4
la $a0, newline
syscall
for:
   bge $t0, $t3, endfor
	li $v0, 1
	lw $a0, ($t4)
	syscall
   
   	li $v0, 4
   	la $a0, space
   	syscall
   	
   
   addi $t4, $t4, 4
   addi $t0, $t0, 1
   


j for
endfor: 
	
	addi $v0, $zero, 4
   	la $a0, newline
   	syscall
   	jr $ra
partition:



quicksort:

