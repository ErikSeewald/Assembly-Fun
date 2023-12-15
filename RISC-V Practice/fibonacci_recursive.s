MAIN:
	addi sp, sp, 0x400			# init stack pointer at 0x400

	addi a1, zero, 0xC			# set first function parameter
	jal ra, FIB					# a0 = fib(a1) (jump to FIB function)
	jal x0, DONE				# exit


FIB:
	# STACK PUSH RA
	addi sp, sp, 0xFFC			# sp = sp - 4 (move stack pointer to make room for 4*8bit/32bit number)
	sw ra, 0x0(sp)				# save return address

	# BASE CASES
	beq a1, zero, FIB_ZERO		# if a1 == 0 then goto FIB_ZERO
	addi t1, zero, 0x1			# t1 = 0 + 1
	beq a1, t1, FIB_ONE			# if a1 == t1 then goto FIB_ONE

	# STACK PUSH A1
	addi sp, sp, 0xFFC			# sp = sp - 4 (move stack pointer to make room for 4*8bit/32bit number)
	sw a1, 0x0(sp)				# save a1 on stack

	# FIB(A1-1)
	addi a1, a1, 0xFFF			# a1 = a1 - 1
	jal ra, FIB					# a0 = fib(a1) (goto FIB)

	# STACK POP A1
	lw a1, 0x0(sp)				# pop a1 off stack
	addi sp, sp, 0x4			# sp = sp + 4

	# STACK PUSH A0
	addi sp, sp, 0xFFC			# sp = sp - 4 (move stack pointer to make room for 4*8bit/32bit number)
	sw a0, 0x0(sp)				# save a0 on stack

	# FIB(A1-2)
	addi a1, a1, 0xFFE			# a1 = a1 - 2
	jal ra, FIB					# a0 = fib(a1) (goto FIB)

	# STACK POP A0
	lw t1, 0x0(sp)				# pop a0 off stack into t1
	addi sp, sp, 0x4			# sp = sp + 4
	add a0, a0, t1				# a0 = a0 + t1  => a0 = fib(a1 - 1) + fib(a1-2)

	jal x0, FIB_RETURN			# goto FIB_RETURN


FIB_ZERO:
	addi a0, zero, 0x0			# a0 = 0 + 0
	jal x0, FIB_RETURN			# goto FIB_RETURN

FIB_ONE:
	addi a0, zero, 0x1			# a0 = 0 + 1
	jal x0, FIB_RETURN			# goto FIB_RETURN

FIB_RETURN:
	# STACK POP RA
	lw ra, 0x0(sp)				# pop return address off stack
	addi sp, sp, 0x4			# sp = sp + 4

	jalr x0, ra, 0x0			# return

DONE: