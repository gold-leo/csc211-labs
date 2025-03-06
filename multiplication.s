# My Multiplication Routine
# CSC 211 02 (5 March 25)
.set noreorder
.text
.globl main
.ent main

main:
  li   $a0, 12             # Set first argument 
  li   $a1,  4             # Set second argument
  jal  mymult              # Call mymult(12,4)
  #[delay slot]

mymult:
  bnez $a0, recur
  #[delay slot]
  # base case
  move $v0, $zero         # return 0
  jr   $ra                # Return to caller
  #[delay slot]
recur:
  # test whether a is odd by testing whether LSB is a 1
  andi $t0, $a0, 0x1
  beqz  $t0, a_is_even
  #[delay slot]
  # is odd
  move $v0, $a1           # prod = b
  j    rest               # skip the alternative
  #[delay slot]
  # else
a_is_even:
  move $v0, $zero         # prod = 0
rest:  
  # make the recursive call ...
  # save stuff to the stack, like ra, 
  # $a0 [nope, don't need a after call]
  addi $sp, $sp, -8       # make space on the stack for two items
  sw   $ra, 4($sp)        # push $ra
  # make the recursive call
  # get a/2 
  sra  $a0, $a0, 1        # a>>=1 is a/=2 
  jal  mymult             # call mymult( a/2, b) 
  #[delay slot]
# FIX: initialize prod into s0, but only after saving s0 onto the stack.