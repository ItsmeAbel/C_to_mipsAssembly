.data
antal: .word 10
vek: .word 4,5,2,2,1,6,7,9,5,10
newline: .asciiz "\n"







.text
.globl main
main:


skriv:
#förbreda parametrarna
#s0 till v[], s1 till size
addi $t0, $zero, 0 #i

addi $v0, $zero, 4
move $a0, newline
syscall


for:
   bge $t0, $s1, endfor
   addi $t0, $t0, 1
   sll $t2, $t0, 2
   
   lw $t1, 0($t)
   
   addi $v0, $zero, 4
   move $a0, newline

j for
endfor: 

partition:



quicksort:

