load Abs.asm,
output-file Abs04.out,
compare-to Abs04.cmp,
output-list RAM[0]%D2.6.2 RAM[1]%D2.6.2;

set PC 0,
set RAM[0] 0,  // Set R0
set RAM[1] -32767;  // Set R1
repeat 100 {
  ticktock;    // Run for 100 clock cycles
}
set RAM[1] -32767,  // Restore arguments in case program used them
output;        // Output to file