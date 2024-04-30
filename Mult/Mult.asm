// This file is based on part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: Mult.asm

// Multiplies R1 and R2 and stores the result in R0.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.
 @sum
    M=0
    @R2
    D=M
    @SET2
    D;JEQ
    @R1
    D=M
    @SET2
    D;JEQ
    @ABS
    D;JLT
    @count
    M=D
    @LOOP
    0;JMP
(ABS)
    @count
    M=-D
(LOOP)
    @count
    D=M
    @SET
    D;JLE
    @R2
    D=M
    @sum
    M=D+M
(INC)
    @count
    M=M-1
    @LOOP
    0;JMP
(SET)
    @R1
    D=M
    @FLIP
    D;JLT
(SET2)
    @sum
    D=M
    @R0
    M=D
    @END
    0;JMP
(FLIP)
    @sum
    D=M
    @R0
    M=-D
(END)
    @END
    0;JMP