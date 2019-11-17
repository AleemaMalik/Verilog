DESIGN

Part 1: Designed a 7-to-1 mux that outputs the logic value of an input from SW[6:0]

Part 2: Designed a 4-bit ripple carry adder.

Part 3: Designed a 6-to-1 mux that performed different logic operations on 2 4-bit inputs.

FUNCTIONALITY

Functionality the code provides is as follows:

A + B using the adder from Part 2 of this Lab

A + B using the Verilog ‘+’ operator

A NAND B in the lower four bits of ALUout and A NOR B in the upper four bits

Output 8’b11000000 if at least 1 of the 8 bits in the two inputs is 1 (use a single OR operation)

Output 8’b00111111 if exactly 2 bits of the A switches are 1, and exactly 3 bits of the B switches are 1

Display the B switches in the most significant four bits of ALU out and the complement of the A switches in the least-significant four bits without complementing the bits individually 6: A XNOR B in the lower four bits and A XOR B in the upper four bits

TESTING

To ensure the code works, multiple tests were done using ModelSim
