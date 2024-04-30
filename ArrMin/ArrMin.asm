// Finds the smallest element in the array of length R2 whose first element is at RAM[R1] and stores the result in R0.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.
@count
M=1
@R1
A=M
D=M
@R0
M=D
@R1
M=M+1
(LOOP)
@R2
D=M
@count
D=D-M 
@END
D;JEQ

@R0
D=M
@NEG
D;JLT
(POS)
@R1
A=M
D=M
@POSNEG
D;JLT
@R0
D=M
@R1
A=M
D=D-M
@NEW
D;JGT
@INC
0;JMP
(POSNEG)
@R1
A=M
D=M
@R0
M=D
@INC
0;JMP
(NEG)
@R1
A=M
D=M
@INC
D;JGT
@R0
D=M
@R1
A=M
D=M-D
@NEW
D;JLT
@INC
0;JMP


(NEW)
@R1
A=M
D=M
@R0
M=D
(INC)
@R1
M=M+1
@count
M=M+1
@LOOP
0;JMP

(END)
@END
0;JMP