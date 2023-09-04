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

la $a0, vek
lw $s0, antal
addi $a1, $s0, -1
li $a2, 0 
jal quicksort


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
   	#skriver ut elementet
	li $v0, 1
	lw $a0, 0($t4)
	syscall
   
   #skriver ut mellanslag
   	li $v0, 4
   	la $a0, space
   	syscall
   	
   #går till nästa adress i arrayen
   addi $t4, $t4, 4
   addi $t0, $t0, 1 #ökar i med 1
   
j for
endfor: 
	#skriver ut new line
	addi $v0, $zero, 4
   	la $a0, newline
   	syscall
   	jr $ra
partition:



	move $v0, $t0 #returnera upper
	jr $ra
quicksort:

	#Förbreder stacken
	subu $sp, $sp, 24 #går ner i stacken
	sw $ra, 16($sp) #retur adress för att kunna hoppa tillbaka till Main
	sw $s0, 12($sp) # k
	sw $a0, 8($sp) #vek
	sw $a2, 4($sp) #b  ,b = antal - 1, som är 9 i början
	sw $a1, 0($sp) #a  ,a = 0 i början
	
	
	bge $t1,$t2, endif
	lw $a0, 8($sp)
	lw $a1, 0($sp)
	lw $a2, 4($sp)
	jal partition
	
	move $s0, $v0
	addi $s0, $s0, -1
	lw $a0, 8($sp)
	lw $a1, 0($sp)
	move $a2, $s0
	jal quicksort
	
	
	addi $s0, $s0, 1
	lw $a0, 8($sp)
	move $a1, $s0
	lw $a2, 4($sp)
	jal quicksort
	
	
endif: 
	lw $ra, 16($sp) #hämtar retur addressen från stacken
	addu $sp, $sp, 24  #går upp i stacken
	jr $ra