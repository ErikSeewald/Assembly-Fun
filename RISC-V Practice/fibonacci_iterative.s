MAIN:
	addi sp, sp, 0x400			# init stack pointer at 0x400

	addi a1, zero, 0xC			# set first function parameter
	jal ra, FIB					# a0 = fib(a1) (jump to FIB function)
	jal x0, DONE				# exit


FIB:
	# BASE CASES
	beq a1, zero, FIB_ZERO		# if a1 == 0 then goto FIB_ZERO
	addi t1, zero, 0x1			# t1 = 0 + 1
	beq a1, t1, FIB_ONE			# if a1 == t1 then goto FIB_ONE

	# NON BASE CASES
	add t1, zero, zero			# t1 = 0 + 0 (num1)
	addi t2, zero, 0x1			# t2 = 0 + 1 (num2)
	addi t4, zero, 0x1			# t4 = 0 + 1 (iteration counter)
	
	jal x0, FIB_STEP			# goto FIB_STEP

FIB_ZERO:
	addi a0, zero, 0x0			# a0 = 0 + 0
	jalr x0, ra, 0x0			# return

FIB_ONE:
	addi a0, zero, 0x1			# a0 = 0 + 1
	jalr x0, ra, 0x0			# return

FIB_STEP:
	add t3, t1, t2				# t3 = t1 + t2 (num3)
	add t1, t2, zero			# t1 = t2 + 0
	add t2, t3, zero			# t2 = t3 + 0

	addi t4, t4, 0x1			# t4 = t4 + 1
	blt t4, a1, FIB_STEP		# if t4 < a1 goto FIB_STEP

	add a0, t3, zero			# a0 = t3 + 0
	jalr x0, ra, 0x0			# return

DONE: