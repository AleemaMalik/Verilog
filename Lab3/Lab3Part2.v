module fullAdder (input a, b, cin, output s, cout);

	assign s = a ^ b ^ cin;
	assign cout = (a&b) | (a&cin) | (b&cin);
	
endmodule

module adder (A, B, S, Cin, Cout);

	input [3:0]A,B;
	input Cin;
	output [3:0]S;
	output Cout;
	wire w1, w2, w3;
	
	fullAdder u1(.a(A[0]), .b(B[0]), .cin(Cin),.s(S[0]), .cout(w1));
	fullAdder u2(.a(A[1]), .b(B[1]), .cin(w1), .s(S[1]), .cout(w2));
	fullAdder u3(.a(A[2]), .b(B[2]), .cin(w2), .s(S[2]), .cout(w3));
	fullAdder u4(.a(A[3]), .b(B[3]), .cin(w3), .s(S[3]), .cout(Cout));

endmodule

module RippleCarryAdder (SW, LEDR); //Top-level module

		input [9:0]SW;
		output [9:0]LEDR;
		
		adder u1(.A(SW[7:4]), .B(SW[3:0]), .Cin(SW[8]), .Cout(LEDR[9]), .S(LEDR[3:0]));//instantiates ladder

endmodule

