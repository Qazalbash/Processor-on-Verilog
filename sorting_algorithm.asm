li x31, 10		# for len(a)

Loop_1:
li x30, 0	# x30 = j = 0 , x29 = i
addi x30, x29, 1 	# j = i+1
lw x9, 0(x10)		# Array[off_set i]  , x10 = offset i

addi x11, x10, 4	# x11 = offset j = offset i + 4
add x16, x0, x10 	# min_idx = x10 
lw x14, 0(x16)		# Array[min_idx]

Loop_2:
lw x17, 0(x11)		# Array[off_set j]
blt x14, x17, if	
add x16, x11, x0    # min_idx = off_set j 
lw x14, 0(x16)

if: 
addi x30, x30, 1
addi x11, x11, 4
blt x30, x31, Loop_2

sw x14, 0(x10)
sw x9, 0(x16)

addi x29, x29, 1
addi x10, x10, 4
blt x29, x31, Loop_1
