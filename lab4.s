.text
.globl main
.ent main

main:
  # Problem 1
  li   $s0, 48
  srl  $s0, s0, 4
  and  $s1, $s0, 0x1

  # Problem 2
  addi $s2, $zero, 25
  nor  $s3, $zero, $s2

  # Problem 3
  li   $s4, 4800000
  andi $s5, $s4, 0xFFFF

  # Problem 4
  li   $s6, 0xFFF00FFF
  li   $s7, 0xFFFFFFFF
  srl  $t0, $s6, 8
  andi $t0, $t0, 0xFF0
  li   $t1, 0xFFFFF00F
  and  $s7, $s7, $t0
  or   $s7, $s7, $t1

