load ArrSort.asm,
output-file ArrSort03.out,
compare-to ArrSort03.cmp,
output-list RAM[0]%D2.6.2 RAM[1]%D2.6.2 RAM[2]%D2.6.2 RAM[20]%D2.6.2 RAM[21]%D2.6.2 RAM[22]%D2.6.2 RAM[23]%D2.6.2 RAM[24]%D2.6.2 RAM[25]%D2.6.2;

set PC 0,
set RAM[0]  0,  // Set R0
set RAM[1]  20, // Set R1
set RAM[2]  6,  // Set R2
set RAM[20] 129,  // Set Arr[0]
set RAM[21] 33,  // Set Arr[1]
set RAM[22] -3333,  // Set Arr[2]
set RAM[23] 28,  // Set Arr[3]
set RAM[24] -89,
set RAM[25] -99;
repeat 1400 {
  ticktock;    // Run for 1400 clock cycles
}
set RAM[1] 20,  // Restore arguments in case program used them
set RAM[2] 6,
output;        // Output to file