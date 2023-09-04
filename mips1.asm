.data
antal: .word 10
vek: .word 4,5,2,2,1,6,7,9,5,10
newline: .asciiz "\n"
space: .asciiz ", "

.text
.globl main
main:
	la $a1, vek
	lw $a0, antal
	jal skriv

	la $a0, vek
	lw $s0, antal
	addi $a1, $s0, -1
	li $a2, 0 
	jal quicksort

	la $a1, vek
	lw $a0, antal
	jal skriv

	li $v0, 10
	syscall

skriv:
#f�rbreda parametrarna
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
   	
   #g�r till n�sta adress i arrayen
   addi $t4, $t4, 4
   addi $t0, $t0, 1 #�kar i med 1
   
j for

endfor: 
	#skriver ut new line
	addi $v0, $zero, 4
   	la $a0, newline
   	syscall
   	jr $ra
partition:

	li $s1, 0 #pivot
	li $s2, 0 #lower
	li $s3, 0 #upper
	li $s4, 0 #temp
	
	sll $t0, $a1, 2
	add $t0, $a0, $t0
	lw $s1, 0($t0) #pivot = v[a]
	addi $s2, $a1, 1 #lower = a + 1;
	move $s3, $a2 #upper = b;
	
do: 
	
while1:
	sll $t2, $s2, 2
        add $t0, $a0, $t2 #v + lower
        lw $t3, 0($t0) #v[lower]
	bgt $t3, $s1, endwhile1 #v[lower] > pivot
	bgt $s2, $s3, endwhile1 #lower > upper
	 addi $s2, $s2, 1 #lower = lower + 1
	j while1

endwhile1:
while2:
	sll $t2, $s3, 2
	add $t1, $a0, $t2 #v[upper]
	lw $t3, 0($t1)
	ble $t3, $s1, endwhile2 #v[upper] <= pivot
	bgt $s2, $s3, endwhile2 #lower <= upper
	  addi $s3, $s3, -1
	j while2
endwhile2:

	bgt $s2, $s3, endif0
	
	sll $t1, $s2, 2
	add $t0, $a0, $t1 #v[lower]
	lw $s4, 0($t0)
	
	sll $t1, $s3, 2
	add $t2, $a0, $t1 #v[upper]
	sw $t2, 0($t0)
	sw $s4, 0($t2)
	
	addi $s2, $s2, 1 #lower = lower + 1
	addi $s3, $s3, -1 #upper = upper - 1
endif0:

	ble $s2, $s3, do	
	
	sll $t0, $s3, 2
        add $t1, $a0, $t0 #adressen till v[upper]
        lw $s4, 0($t1)#temp = v[upper]
       
        sll $t0, $a1, 2 
	add $t2, $a0, $t0 #adressen till v[a]
	lw $t3, 0($t2)#t3 = v[a]
	sw $t3, 0($t1)#v[upper] = v[a];
	sw $s4, 0($t2) #v[a] = temp;
	
	move $v0, $s3 #returnera upper
	jr $ra
	
quicksort:

	#F�rbreder stacken
	subu $sp, $sp, 24 #g�r ner i stacken
	sw $ra, 16($sp) #retur adress f�r att kunna hoppa tillbaka till Main
	sw $s0, 12($sp) # k
	sw $a0, 8($sp) #vek
	sw $a2, 4($sp) #b  ,b = antal - 1, som �r 9 i b�rjan
	sw $a1, 0($sp) #a  ,a = 0 i b�rjan
	
	move $t1, $a1
	move $t2, $a2
	bge $t1,$t2, endif
	lw $a0, 8($sp) #v[]
	lw $a1, 0($sp) #a
	lw $a2, 4($sp) #b
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
	lw $ra, 16($sp) #h�mtar retur addressen fr�n stacken
	lw $s0, 12($sp)
	addu $sp, $sp, 24  #g�r upp i stacken
	jr $ra