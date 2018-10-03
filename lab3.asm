############################################################################
#                       Lab 3
#                       EC413
#
#    		Assembly Language Lab -- Programming with Loops.
#
############################################################################
#  DATA
############################################################################
        .data           # Data segment
Hello:  .asciiz " \n Hello World! \n "  # declare a zero terminated string
Hello_len: .word 16
AnInt:	.word	12		# a word initialized to 12
space:	.asciiz	" "	# declare a zero terminate string
WordAvg:   .word 0		#use this variable for part 4
ValidInt:  .word 0		#
ValidInt2: .word 0		#
lf:     .byte	10, 0	# string with carriage return and line feed
InLenW:	.word   4       # initialize to number of words in input1 and input2
InLenB:	.word   16      # initialize to number of bytes in input1 and input2
        .align  4
Input1:	.word	0x01020304,0x05060708
	    .word	0x090A0B0C,0x0D0E0F10
        .align  4
Input2: .word   0x01221117,0x090b1d1f   # input
        .word   0x0e1c2a08,0x06040210
        .align  4
Copy:  	.space  0x80    # space to copy input word by word
        .align  4
 
Enter: .asciiz "\n"
Comma: .asciiz ","

Q2:  .asciiz " \n Code for Q2: "  # Formating --
Q3:  .asciiz " \n Code for Q3: "  # 
Q4:  .asciiz " \n Code for Q4: "  # 
Q5:  .asciiz " \n Code for Q5: "  # 
Q6a:  .asciiz " \n Q6 MIN: "  # 
Q6b:  .asciiz " \n Q6 MAX: "  # 
Q6c:  .asciiz " \n Q6 AVERAGE: "  # 
Q7:  .asciiz " \n Code for Q7: "  # 
Q8:	 .asciiz " \n Extra Credit: "
############################################################################
#  CODE
############################################################################
        .text                   # code segment
#
# print out greeting
#
main:	
        la	$a0,Hello	# address of string to print
        li	$v0,4		# system call code for print_str
        syscall                 # print the string

	
#Code for Item 2
#Count number of occurences of letter "l" in Hello string
	
#1. Iterate through "Hello", which is stored in a0 and compare each letter to "l". 
#2. If equal, do increment a counter
#3. Print counter

	li	$s0, 0					#counter = 0
	li  $s1, 'l'				#load 'l' into $t1


Loop1:
	lb	$t9, 0($a0)				#Load the first byte from address in $a0
	

	add	$a0, $a0, 1				#increment the address
	beq $t9, $zero, exit1		#Break loop if we reach the end
	beq $t9, $s1, EQUAL1		#If equal to 'l' jump to EQUAL1

	j Loop1						#Not Equal, Loop back

EQUAL1:
	addi $s0, $s0, 1			#counter++
	j Loop1						#Equal, Loop back

exit1:
	#sw	$s0, Enter
	


		#FORMATING
		la	$a0,Q2	# address of string to print
        li	$v0,4		# system call code for print_str
        syscall                 # print the string








################################################################################
       # la	$a0,Enter	# address of string to print
	   move	$a0,$s0
        li	$v0,1		# system call code for print_str, 1 is the service code for print integer
        syscall                 # print the string

		#New Line
		addi $a0, $0, 0xA #ascii code for LF, if you have any trouble try 0xD for CR.
        addi $v0, $0, 0xB #syscall 11 prints the lower 8 bits of $a0 as an ascii character.
        syscall
################################################################################

#
# Code for Item 3 -- 
# Print the integer value of numbers from 0 and less than AnInt
#

#Print 0 and increment until equal to AnInt

		#FORMATING
		la	$a0,Q3	# address of string to print
        li	$v0,4		# system call code for print_str
        syscall                 # print the string

	lw	$t1, AnInt			#Load 12 -> $t1
	li	$t0, 0				#Load $t0 with 0

Loop2:
	beq	$t0,$t1,end2		#exit if equal to 12
	blt	$t0, $t1, printer	#if t0 < t1, print

j Loop2

printer:
	move $a0, $t0
	li	$v0,1		# system call code for print_str, 1 is the service code for print integer
	syscall

	li $a0, 32	# print space, 32 is ASCII code for space
	li $v0, 11  # syscall number for printing character
	syscall

	add $t0, $t0, 1		    #increment t0 to get to next number

j Loop2
	
end2:







###################################################################################
      #  la	$a0,Enter	# address of string to print
      #  li	$v0,4		# system call code for print_str
      #  syscall         # print the string

	    #New Line
		addi $a0, $0, 0xA #ascii code for LF, if you have any trouble try 0xD for CR.
        addi $v0, $0, 0xB #syscall 11 prints the lower 8 bits of $a0 as an ascii character.
        syscall
		
###################################################################################
#
# Code for Item 4 -- 
# Print the integer values of each byte in the array Input1 (with spaces)
#

		#FORMATING
		la	$a0,Q4	# address of string to print
        li	$v0,4		# system call code for print_str
        syscall                 # print the string

		la	$t9, Input1		#Load address of Input1 into $t9
		li	$t1, 0			#Counter = 0
		lw	$t2, InLenB		#Stop at 16 iterations

repeat4:
		lb	$a0, ($t9)		#Load first value into $a0 and print
		li $v0, 1			#print int syscall
		syscall

		li $a0, 32	# print space, 32 is ASCII code for space
		li $v0, 11  # syscall number for printing character
		syscall

		addi	$t9, $t9, 1		#Go to next byte
		addi	$t1, $t1, 1		#Increase Counter

		beq	$t1, $t2, exit3		#Exit if iterations increase

		j repeat4
exit3:

		#New Line
		addi $a0, $0, 0xA #ascii code for LF, if you have any trouble try 0xD for CR.
        addi $v0, $0, 0xB #syscall 11 prints the lower 8 bits of $a0 as an ascii character.
        syscall






###################################################################################
#
# Code for Item 5 -- 
# Write code to copy the contents of Input2 to Copy
#

		#FORMATING
		la	$a0,Q5	# address of string to print
        li	$v0,4		# system call code for print_str
        syscall                 # print the string

		li	$t1, 0		#Counter = 0
		lw	$t2, InLenW		#Stop at 4 iterations

		la	$t9, Input2		#Load address of Input2 into $t9
		la	$t8, Copy		#Load address of Copy into $t8


repeat:
		
		lw	$t0, ($t9)		#Load first word of Input2 into t0
		sw	$t0, ($t8)		#Store value of t0 into $t8

		lw	$a0, ($t8)		#First value of $t8 -> $a0
		li $v0, 1
		syscall

		li $a0, 32	# print space, 32 is ASCII code for space
		li $v0, 11  # syscall number for printing character
		syscall

		addi	$t9, $t9, 4		#Go to next word
		addi	$t8, $t8, 4		#Go to next word
		addi	$t1, $t1, 1		#Increase Counter

		beq	$t1, $t2, exit5		#if equal, exit

		j repeat
exit5:		


		#New Line
		addi $a0, $0, 0xA #ascii code for LF, if you have any trouble try 0xD for CR.
        addi $v0, $0, 0xB #syscall 11 prints the lower 8 bits of $a0 as an ascii character.
        syscall








#################################################################################
      #  la	$a0,Enter	# address of string to print
      #  li	$v0,4		# system call code for print_str
       # syscall                 # print the string
###################################################################################
#
# Code for Item 6 -- 
# Print the integer average of the contents of array Input2
#

		#FORMATING
		la	$a0,Q6a	# address of string to print
        li	$v0,4		# system call code for print_str
        syscall                 # print the string

		la	$t9, Input2		#Load address of Input2 into $t9

		li		$t1, 0		#Counter = 0
		lw		$t2, InLenW		#Stop at 3 iterations
		addi	$t2,$t2,-1

		#Calculate Min
		lw		$t3,0($t9)		#first number (n) of array stored in $t3

repeat6:
		lw		$t4,4($t9)	#number (n+1) stored in $t4
		blt		$t3,$t4, min	#compare n and n+1

		move	$s0,$t4		#store minimum number into s0
		addi	$t9,$t9,4		#Iterate to next number
		move	$t3,$t4			#Store min in $t3
		addi	$t1,$t1,1		#Increase Counter
		beq		$t1, $t2, exit6		#if equal, exit
		j repeat6

min:
		move	$s0,$t3			#store minimum number into s0
		addi	$t9,$t9,4	#Iterate to next number
		addi	$t1,$t1,1	#Increase Counter
		beq		$t1, $t2, exit6		#if equal, exit
		j repeat6

exit6:
		move	$a0,$s0	#Print Min
		li		$v0, 1
		syscall

###############################################################


		#FORMATING
		la	$a0,Q6b	# address of string to print
        li	$v0,4		# system call code for print_str
        syscall                 # print the string


		la	$t9, Input2		#Load address of Input2 into $t9

		li		$t1, 0		#Counter = 0
		lw		$t2, InLenW		#Stop at 3 iterations
		addi	$t2,$t2,-1

		#Calculate Max
		lw		$t3,0($t9)		#first number (n) of array stored in $t3

repeat66:
		lw		$t4,4($t9)	#number (n+1) stored in $t4
		bgt		$t3,$t4, max	#compare n and n+1

		move	$s1,$t4		#store maximum number into s1
		addi	$t9,$t9,4		#Iterate to next number
		move	$t3,$t4			#Store max in $t3
		addi	$t1,$t1,1		#Increase Counter
		beq		$t1, $t2, exit66		#if equal, exit
		j repeat66

max:
		move	$s1,$t3			#store maximum number into s1
		addi	$t9,$t9,4	#Iterate to next number
		addi	$t1,$t1,1	#Increase Counter
		beq		$t1, $t2, exit66		#if equal, exit
		j repeat66

exit66:
		move	$a0,$s1	#Print Max
		li		$v0, 1
		syscall

###############################################################
		#FORMATING
		la	$a0,Q6c	# address of string to print
        li	$v0,4		# system call code for print_str
        syscall                 # print the string

		li		$t1, 0		#Counter = 0
		lw		$t2, InLenW	#Stop at 4 iterations
		li		$t0, 0		#initalize to 0, running sum

		la	$t9, Input2		#Load address of Input2 into $t9
Sum:
		lw	$t3, ($t9)		#First element of $t9 -> $t3
		add $t0, $t0,$t3	#Running Sum
		addi	$t9, $t9, 4		#$t9 incremented
		addi $t1, $t1, 1		#Counter++
		beq		$t1, $t2, exit666		#if equal, exit
		j Sum

		#t0 holds running sum
exit666:
		#divide
		li $t5, 4
		div $t6, $t0, $t5	#store answer in $t6

		#print
		move	$a0, $t6
		li		$v0, 1
		syscall

		
		


#################################################################################
        la	$a0,Enter	# address of string to print
        li	$v0,4		# system call code for print_str
        syscall                 # print the string
##################################################################################
#
# Code for Item 7 -- 
# Display the first 25 integers that are divisible by either 7 and 13 (with comma)
#
#Start at 0, and increment
#Divide each integer by 7 and 13 and if there is no remainder, then the number is divisible and should be printed (with comma)
#Everytime we do that, increase a counter
#When counter = 25, exit

		#FORMATING
		la	$a0,Q7	# address of string to print
        li	$v0,4		# system call code for print_str
        syscall                 # print the string

######Div example
 # div $a0, $a1
 # mfhi $a2 # reminder to $a2
 # mflo $v0 # quotient to $v0

li	$t1, 1			#Start at 1
li	$t2, 7			#initalize $t2 = 7
li	$t3, 13			#initalize $t3 = 13
li	$t4, 25			#exit comparasion

divis:
div $t1,$t2			#divide by 7
mfhi $t0			#remainder

beq	$t0, $zero, skip	#if remainder is zero, it is divisble

div $t1,$t3			#divide by 13
mfhi $t0			#remainder

beq	$t0, $zero, skip	#if remainder is zero, it is divisble

		
		addi	$t1, $t1, 1		#increase count
		beq	$t1, $t4, exit7
		j divis


skip:
		#Printing Number
		move $a0, $t1	
        li	$v0,1		
        syscall   

		li $a0, 32	# print space, 32 is ASCII code for space
		li $v0, 11  # syscall number for printing character
		syscall

	addi	$t1, $t1, 1		#increase count
	beq	$t1, $t4, exit7
	j divis

exit7:

#
# Code for Item 8 -- 
# Repeat step 7 but display the integers in 5 lines with 5 integers with spaces per line
# This must be implemented using a nested loop.
#

		#New Line
		addi $a0, $0, 0xA #ascii code for LF, if you have any trouble try 0xD for CR.
        addi $v0, $0, 0xB #syscall 11 prints the lower 8 bits of $a0 as an ascii character.
        syscall

		#FORMATING
		la	$a0,Q8	# address of string to print
        li	$v0,4		# system call code for print_str
        syscall                 # print the string

		#New Line
		addi $a0, $0, 0xA #ascii code for LF, if you have any trouble try 0xD for CR.
        addi $v0, $0, 0xB #syscall 11 prints the lower 8 bits of $a0 as an ascii character.
        syscall

		li	$t1, 1			#Start at 1
		li	$t2, 7			#initalize $t2 = 7
		li	$t3, 13			#initalize $t3 = 13

		li	$t4, 0			#counter for 25 numbers
		li	$t9, 25			#exit loop
		li	$t8, 5			#counter2 for new line
		
divis8:
		div $t1,$t2			#divide by 7
		mfhi $t0			#remainder

		beq	$t0, $zero, skip8	#if remainder is zero, it is divisble

		div $t1,$t3			#divide by 13
		mfhi $t0			#remainder

		beq	$t0, $zero, skip8	#if remainder is zero, it is divisble

		
		addi	$t1, $t1, 1		#increase count
		beq	$t9, $t4, exit8
		j divis8


skip8:
	
		#Printing Number
		move $a0, $t1	
        li	$v0,1		
        syscall   

		li $a0, 32	# print space, 32 is ASCII code for space
		li $v0, 11  # syscall number for printing character
		syscall

		addi	$t4, $t4, 1			#counter++
		#if count is divisible by 5, print new line
		div	$t4, $t8
		mfhi $t0					#remainder
		addi	$t1, $t1, 1		#increase count
		beq	$t0, $zero, newline8	#if remainder is zero, it is divisble
		beq	$t9, $t4, exit8
		j divis8

newline8: 

		#New Line
		addi $a0, $0, 0xA #ascii code for LF, if you have any trouble try 0xD for CR.
        addi $v0, $0, 0xB #syscall 11 prints the lower 8 bits of $a0 as an ascii character.
        syscall
		beq	$t9, $t4, exit8
		j divis8

exit8:

		




Exit:
	jr $ra
