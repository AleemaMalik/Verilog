`timescale 1ns / 1ns

module flipflop (input d, clock, reset, output reg q);

	always @ (posedge clock) //at positive edge of clock
	begin
	if (reset == 1'b1) //if reset is on
		q <= 0; //output is 0
	else
		q <= d; //else output is the value at input
	end
	
endmodule

module mux2to1(x, y, s, m);

    input x; //select 0
    input y; //select 1
    input s; //select signal
    output m; //output
  
assign m = (s & y) | (~s & x); //mux formula

endmodule

module subcircuit(input right, left, LoadLeft, D, loadn, clock, reset, output Q);
	wire w1, w2;
	
	mux2to1 m1(right, left, LoadLeft, w1); //second mux
	//chooses between rotating left or right

	mux2to1 m2(D, w1, loadn, w2); //first mux
	//chooses between rotating or storing the given values

	flipflop f1(w2, clock , reset, Q); //flip flop is connected to w2

endmodule

module register(input ParallelLoadn, RotateRight, LSRight, clock, reset, input [7:0] DATA_IN, output [7:0] Q);

	wire w0,w1,w2,w3,w4,w5,w6,w7; // wires to connect all the instantiations of subcircuit
	//eight instantiations of the subcircuit module which are all connected together
	//firdt circuit's left inout is multipled by the inverse of LeftRight to get the provided results

	subcircuit u7(w6, (~LSRight)*w0, RotateRight, DATA_IN[7], ParallelLoadn, clock, reset, w7);
	subcircuit u6(w5, w7, RotateRight, DATA_IN[6], ParallelLoadn, clock, reset, w6);
	subcircuit u5(w4, w6, RotateRight, DATA_IN[5], ParallelLoadn, clock, reset, w5);
	subcircuit u4(w3, w5, RotateRight, DATA_IN[4], ParallelLoadn, clock, reset, w4);
	subcircuit u3(w2, w4, RotateRight, DATA_IN[3], ParallelLoadn, clock, reset, w3);
	subcircuit u2(w1, w3, RotateRight, DATA_IN[2], ParallelLoadn, clock, reset, w2);
	subcircuit u1(w0, w2, RotateRight, DATA_IN[1], ParallelLoadn, clock, reset, w1);
	subcircuit u0(w7, w1, RotateRight, DATA_IN[0], ParallelLoadn, clock, reset, w0);
	assign Q[0] = w0; //all wires are assigned to the corresponding output
	assign Q[1] = w1;
	assign Q[2] = w2;
	assign Q[3] = w3;
	assign Q[4] = w4;
	assign Q[5] = w5;
	assign Q[6] = w6;
	assign Q[7] = w7;
	
endmodule

module lab4part3(SW, KEY, LEDR); //top level module

	input [9:0] SW;
	input [3:0] KEY;
	output [7:0] LEDR;
	register u0(KEY[1], KEY[2], KEY[3], KEY[0], SW[9], SW[7:0], LEDR[7:0]);

endmodule
