// Sorts the array of length R2 whose first element is at RAM[R1] in ascending order in place. Sets R0 to True (-1) when complete.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.
(RESET)
    @count
    M=1
    @R1
    D=M
    @previndex
    M=D
    @index
    M=D+1
(LOOP)
    @R2
    D=M
    @count
    D=D-M
    @STOP
    D;JEQ

    @previndex
    A=M
    D=M
    @POS
    D;JGT
(NEG)
    @index
    A=M
    D=M
    @NEGNEG
    D;JLT
    @INC
    0;JMP
(POS)
    @index
    A=M
    D=M
    @SWAP
    D;JLT
(NEGNEG)
    @previndex
    A=M
    D=M
    @index
    A=M
    D=D-M
    @SWAP
    D;JGT
    @INC
    0;JMP

(SWAP)
    @previndex
    A=M
    D=M
    @R0
    M=D
    @index
    A=M
    D=M
    @previndex
    A=M
    M=D
    @R0
    D=M
    @index
    A=M
    M=D
    @RESET
    0;JMP
    
(INC)
    @index
    M=M+1
    @previndex
    M=M+1
    @count
    M=M+1
    @LOOP
    0;JMP

(STOP)
    @R0
    M=-1

(END)
    @END
    0;JMP