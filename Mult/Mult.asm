// This file is based on part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: Mult.asm

// Multiplies R1 and R2 and stores the result in R0.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.
@R0
M=0

// Initialize the sign of the result to positive
@Sign
M=1

// Load the first number (R1) into D
@R1
D=M
// Check the sign of the first number
D;JLT
@NEGATIVE1
0;JMP
(POSITIVE1)
@POSITIVE2
0;JMP
(NEGATIVE1)
@NEGATIVE2
M=-1
0;JMP
(POSITIVE2)
// Load the absolute value of the first number into R1
@R1
D=M
@R1
M=D

// Load the second number (R2) into D
@R2
D=M
// Check the sign of the second number
D;JLT
@NEGATIVE3
0;JMP
(POSITIVE3)
@POSITIVE4
0;JMP
(NEGATIVE3)
@NEGATIVE4
M=-1
0;JMP
(POSITIVE4)
// Load the absolute value of the second number into R2
@R2
D=M
@R2
M=D

// Initialize the counter to the first number (R1)
@R1
D=M
@Counter
M=D

// Loop to multiply
(LOOP)
  // Check if counter is zero
  @Counter
  D=M
  @END
  D;JEQ

  // Add the second number (R2) to the product (R0)
  @R2
  D=M
  @R0
  M=M+D
  // Check for overflow
  @R0
  D=M
  @OVERFLOW
  D;JGT

  // Decrement the counter
  @Counter
  M=M-1

  // Jump back to the loop
  @LOOP
  0;JMP

// Overflow handling
(OVERFLOW)
  @Sign
  D=M
  @R0
  M=0
  @END

// End of multiplication
(END)