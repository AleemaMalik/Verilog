`timescale 1ns / 1ns // `timescale time_unit/time_precision


//SW[9] select signals

//LEDR[0] output display

module mux(LEDR, SW);

   input [9:0] SW;
   output [9:0] LEDR;
 
	wire w1, w2, w3; //wires that connect

	v7404 i0(
				.pin1(SW[9]),.pin2(w1)); //uses NOT chip
   v7408 i1(
				.pin1(SW[0]),
				.pin2(w1),
				.pin3(w2),
				.pin4(SW[1]),
				.pin5(SW[9]),
				.pin6(w3)
	); //uses AND chip
	v7432 i2(
				.pin1(w2),
				.pin2(w3),
				.pin3(LEDR[0])
	); //uses OR chip
	
endmodule

module v7404 (input pin1, pin3, pin5, pin9, pin11, pin13, output pin2, pin4, pin6, pin8, pin10, pin12); //NOT CHIP

	assign pin2 = !pin1;
	assign pin4 = !pin3;
	assign pin6 = !pin5;
	assign pin8 = !pin9;
	assign pin10 = !pin11;
	assign pin12 = !pin13;

endmodule

module v7408 (input pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13, output pin3, pin6, pin8, pin11); //AND CHIP
	
	assign pin3 = pin1 & pin2;
	assign pin6 = pin4 & pin5;
	assign pin8 = pin9 & pin10;
	assign pin11 = pin12 & pin13;

endmodule

module v7432 (input pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13, output pin3, pin6, pin8, pin11); //OR CHIP

	assign pin3 = pin1 | pin2;
	assign pin6 = pin4 | pin5;
	assign pin8 = pin9 | pin10;
	assign pin11 = pin12 | pin13;

endmodule