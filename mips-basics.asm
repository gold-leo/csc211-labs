# MIPS Procedures
# CSC 211
# Original main (and stubs) and macros written by Jerod Weinman

# Because MARS does not heed the .ent directive to specify the entry point,
# we must put the "main" routine first. Otherwise, we'd include main in the
# .globl symbols below and uncomment the following line:
#.ent main

# Ensure the following procedure labels are globally visible
.globl swap, byteflip, extremes, product

.data                             # Global values stored in memory

ramanujan: .word 1729
simerka:   .word  561

.text                             # Start generating instructions

        
# main
# Run the assignment procedure(s).
# (main is not a special name in MARS, but we label it anyway for familiarity.)
# You may edit anything within main for testing, as it will not be autograded
main:
  
  # Problem 3 (Extremes)
  li   $a0, 1                    # Load arguments into registers
  li   $a1, 4               
  li   $a2, 2121
  li   $a3, 1
  jal  extremes                   # Call the procedure
  move $s2, $v0                   # Copy results into saved registers
  move $s3, $v1
        
  # Exit/Terminate       
  li   $v0, 10                    # Load SYSCALL service number for exit
  syscall                         # Make system call (terminating program)
# END MAIN


# Problem 1
# Swaps two values in memory.
swap:
  lw   $t0, 0($a0)                # Load $a0 into $t0
  lw   $t1, 0($a1)                # Load $a1 into $t1
  sw   $t1, 0($a0)                # Store $a1 into $a0
  sw   $t0, 0($a1)                # Store $a0 into $a1
  jr   $ra                        # Return to caller
#END swap


# Problem 2
# Reverses a word byte-by-byte.
byteflip:
  andi $t1, $a0, 0xFF            # Bitmask the ls byte
  sll  $t1, $t1, 24              # Shift to ms position
  andi $t2, $a0, 0xFF00          # Bitmask second ls byte
  sll  $t2, $t2, 8               # Shift to second ms position
  add  $t1, $t1, $t2             # Combine the two
  li   $t0, 0xFF0000             # Load a bitmask for the second ms byte
  and  $t3, $a0, $t0             # Bitmask the second ms byte
  srl  $t3, $t3, 8               # Shift into the second ls position
  sll  $t0, $t0, 8               # Load a bitmask for the ms byte
  and  $t4, $a0, $t0             # Bitmask the ms byte
  srl  $t4, $t4, 24              # Shift to the ls position
  add  $t2, $t4, $t3             # Combine the two
  add  $v0, $t1, $t2             # Combine the two parts into the final piece
  
  jr   $ra                        # Return to caller
#END byteflip


# Problem 3
# Given four values, find the largest and smallest.
extremes:
  add  $v0, $zero, $a0            # Set $a0 to largest
  add  $v1, $zero, $a0            # Set $a0 to smallest
  slt  $t0, $a1, $v0              # $a1 < smallest ($v0) into $t0
  beqz $t0, skip1                 # If $t0 is false, jump to skip1
  add $v0, $zero, $a1             # Replace the smallest ($v0) with $a1
  skip1:
  slt  $t0, $v1, $a1              # $a1 > largest ($v1) into $t0
  beqz $t0, skip2                 # If $t0 is false, jump to skip2
  add  $v1, $zero, $a1            # Replace the largest ($v1) with $a1
  skip2:
  slt  $t0, $a2, $v0              # $a2 < smallest ($v0) into $t0
  beqz $t0, skip3                 # If $t0 is false, jump to skip3
  add $v0, $zero, $a2             # Replace the smallest ($v0) with $a2
  skip3:
  slt  $t0, $v1, $a2              # $a2 > largest ($v1) into $t0
  beqz $t0, skip4                 # If $t0 is false, jump to skip4
  add  $v1, $zero, $a2            # Replace the largest ($v1) with $a2
  skip4:
  slt  $t0, $a3, $v0              # $a3 < smallest ($v0) into $t0
  beqz $t0, skip5                 # If $t0 is false, jump to skip5
  add  $v0, $zero, $a3            # Replace the smallest ($v0) with $a3
  skip5:
  slt  $t0, $v1, $a3              # $a3 > largest ($v1) into $t0
  beqz $t0, skip6                 # If $t0 is false, jump to skip6
  add  $v1, $zero, $a3           # Replace the largest ($v1) with $a3
  skip6:
  jr   $ra                        # Return to caller
#END extremes

        
# Problem 4
# Determine the product of two values.
product:
  add  $v0, $zero, $zero         # Set $v0 to 0
  loop:
  beqz $a1, endloop              # If $a1 is zero, end the loop
  add  $v0, $v0, $a0             # Add $a0 and $v0 into $v0 (addition iteration)
  addi $a1, $a1, -1              # Decrement $a1
  j loop                         # Loop again
  endloop:
  jr   $ra                       # Return to caller
#END product
