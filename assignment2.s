#############################################
# Calculates the greatest common divisor	#
# int gcd(int number1, int number2) {		#
#	int remainder = number1 % number2;		#
#	if (remainder == 0) {					#
#		return number2;						#
#	} else {								#
#		return gcd(number2, remainder);		#
#	}										#
# }											#
#											#
# Calculates the least common multiple		#
#											#
#	int lcm(int number1, int number2) {		#############
#		return number1*number2/gcd(number1, number2);	#
#	}													#
#														#
#	int main() {										#
# 		int n1, n2;										#
# 		printf("Enter first integer n1: ");				#
# 		scanf("%d", &n1);								#
# 		printf("Enter second integer n2: ");			#############################
# 		scanf("%d", &n2);															#
# 		printf("The greatest common divisor of n1 and n2 is %d\n", gcd(n1, n2));	#
# 		printf("The least common multiple of n1 and n2 is %d\n", lcm(n1, n2));		#
# 		return 0;																	#
#	}												#################################
#													#
#####################################################

#############
# constants

SYS_PRINT_STRING 	= 4
SYS_PRINT_INT		= 1
SYS_READ_INT		= 5

#############
# variables

	.data
first_text:		.asciiz "Enter first integer n1: "
second_text:	.asciiz "Enter second integer n2: "
gcd_text:		.asciiz "The greatest common divisor of n1 and n2 is "
lcm_text:		.asciiz "The least common multiple of n1 and n2 is "
enter:			.asciiz "\n"

##########
# text

	.text
main:
	li $v0, SYS_PRINT_STRING
	la $a0, first_text
	syscall

	li $v0, SYS_READ_INT
	syscall # reads it to $v0

	move $t0, $v0 # moves it to $v0 register

	li $v0, SYS_PRINT_STRING
	la $a0, second_text
	syscall

	li $v0, SYS_READ_INT
	syscall # reads it to $v0

	move $t1, $v0 # moves it to $t1 register

	# so far:
	# 	n1 = $t0
	# 	n2 = $t1

	##################
	# create temp variables for gcd

	move $t2, $t0
	move $t3, $t1
	
	# so,
	#	number1 = $t2
	#	number2 = $t3
	#	remainder = $t4
	##################

	li $v0, SYS_PRINT_STRING
	la $a0, enter
	syscall

	j gcd

gcd:
	divu $t2, $t3 	# number1 % number2
	mfhi $t4 		# this is the remainder
	
	beq $t4, $zero, end_gcd

	# number1 gets number2
	move $t2, $t3

	# number2 gets remainder
	move $t3, $t4

	j gcd

end_gcd:
	li $v0, SYS_PRINT_STRING
	la $a0, gcd_text
	syscall

	li $v0, SYS_PRINT_INT
	move $a0, $t3
	syscall

	li $v0, SYS_PRINT_STRING
	la $a0, enter
	syscall

	j lcm

#################
# as a refresher,
#		n1 = $t0
#		n2 = $t1
#		gcd = $t3
#
#		$t2 and $t4 have unimportant values

lcm:
	multu $t0, $t1
	mflo $t2

	divu $t2, $t3
	mflo $t4

	li $v0, SYS_PRINT_STRING
	la $a0, lcm_text
	syscall

	li $v0, SYS_PRINT_INT
	move $a0, $t4
	syscall

	li $v0, SYS_PRINT_STRING
	la $a0, enter
	syscall

	j exit

# ~~~~~~~~~~~~~~~
# exit the system

exit:	li	$v0, 10		# system call code for exit = 10
		syscall