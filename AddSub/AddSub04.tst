load AddSub.asm,
output-file AddSub04.out,
compare-to AddSub04.cmp,
output-list RAM[0]%D2.6.2 RAM[1]%D2.6.2 RAM[2]%D2.6.2 RAM[3]%D2.6.2;

set PC 0,
set RAM[0] 0,  // Set R0
set RAM[1] -32768,  // Set R1
set RAM[2] 1,  // Set R2
set RAM[3] 2;  // Set R3
repeat 100 {
  ticktock;    // Run for 100 clock cycles
}
set RAM[1] -32768,  // Restore arguments in case program used them
set RAM[2] 1,
set RAM[3] 2,
output;        // Output to file