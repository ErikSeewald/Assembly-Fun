MAIN:
	addi a1, zero, 0x8			# set first function parameter
	addi a2, zero, 0x9			# set second function parameter
	jal ra, MUL					# a0 = a1 * a2 (jump to MUL function)
	jal x0, DONE		# exit

MUL:							# base function of multiplication, handles optimization
	addi a0, zero, 0x0			# set return register to 0

	bge a1, a2, MUL_STEP		# if a1 >= a2 then goto MUL_STEP

	# else then swap the two to optimize
	add	t1, a1, zero			# t1 = a1 + 0
	add a1, a2, zero			# a1 = a2 + 0
	add a2, t1, zero			# a2 = t1 + 0
	jal x0, MUL_STEP			# goto MUL_STEP

MUL_STEP:
	add a0, a0, a1				# a0 = a0 + a1
	addi a2, a2, 0xFFF			# a2 = a2 - 1
	blt zero, a2, MUL_STEP		# if 0 < a1 then goto MUL_STEP
	jalr x0, ra, 0x0				# return

DONE: