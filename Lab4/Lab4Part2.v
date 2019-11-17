module fullAdder(input a, b, cin, output s, cout);

	assign s = a ^ b ^ cin; //XOR relationship
	assign cout = (a & b) | (a & cin) | (b & cin); //cout based on sum of products

endmodule

module adder (A, B, S, Cin, Cout);

	input [3:0]A,B; 
	input Cin;
	output [3:0]S;
	output Cout;
	wire w1, w2, w3; //to connect cin and cout between two instances of fullAdder module
	
	fullAdder u1(.a(A[0]), .b(B[0]), .cin(Cin), .s(S[0]), .cout(w1)); //instantiates fullAdder 4 times
	fullAdder u2(.a(A[1]), .b(B[1]), .cin(w1), .s(S[1]), .cout(w2));
	fullAdder u3(.a(A[2]), .b(B[2]), .cin(w2), .s(S[2]), .cout(w3));
	fullAdder u4(.a(A[3]), .b(B[3]), .cin(w3), .s(S[3]), .cout(Cout));

endmodule

module ALU(input [3:0]A, input [7:0]B, input [2:0] opSelect, output reg [7:0] ALUout);

	wire [4:0] adderOut; //output of adder is assigned to this 4 bit wire and then used in the always block
	
	adder u1(.A(A), .B(B), .S(adderOut[3:0]), .Cin(1'b0), .Cout(adderOut[4]));

	always @(*)
	begin
		case(opSelect[2:0])
 
		//case 0
		3'b111: ALUout = adderOut;
		3'b111: ALUout[7:5] = 0;
		//case 1
		3'b110: ALUout = A + B[3:0];
		3'b110: ALUout[7:5] = 0;
		//case 2
		3'b101: ALUout = {{~(A | B[3:0])}, {~(A & B[3:0])}};
		//case 3
		3'b100: ALUout = {(A > 0) | (B[3:0] > 0)} ? (8'b11000000):(8'b00000000);
		//case 4
		3'b011: 
		if (( A[0] + A[1] + A[2] + A[3] == 2) & (B[0] + B[1] + B[2] + B[3] == 3)) 
		begin
			ALUout= 8'b00111111;
		end
		else 
		begin
			ALUout= 8'b00000000;
		end
		// case 5
		3'b010: ALUout = {{B[3:0]}, {~A}}; 
		//case 6
		3'b001: ALUout = {{A^B[3:0]}, {~(A^B[3:0])}};
		//case 7
		3'b000: ALUout = {B};
		default: ALUout = 8'b00000000; //default case
		
		endcase 		
	end
endmodule


module bcdDecoder (input [3:0] C, output [6:0] HEX); // bcdDecoder

	// maxterms
	assign HEX[0] = !((C[3]|C[2]|C[1]|!C[0]) & (C[3]|!C[2]|C[1]|C[0]) & 
	(!C[3]|C[2]|!C[1]|!C[0]) & (!C[3]|!C[2]|C[1]|!C[0]));
	assign HEX[1] = !((C[3]|!C[2]|C[1]|!C[0]) & (C[3]|!C[2]|!C[1]|C[0]) & 
	(!C[3]|C[2]|!C[1]|!C[0]) & (!C[3]|!C[2]|C[1]|C[0]) & 
	(!C[3]|!C[2]|!C[1]|C[0]) & (!C[3]|!C[2]|!C[1]|!C[0]));
	assign HEX[2] = !((C[3]|C[2]|!C[1]|C[0]) & (!C[3]|!C[2]|C[1]|C[0]) & 
	(!C[3]|!C[2]|!C[1]|C[0]) & (!C[3]|!C[2]|!C[1]|!C[0]));
	assign HEX[3] = !((C[3]|C[2]|C[1]|!C[0]) & (C[3]|!C[2]|C[1]|C[0]) & 
	(C[3]|!C[2]|!C[1]|!C[0]) & (!C[3]|C[2]|C[1]|!C[0]) & 
	(!C[3]|C[2]|!C[1]|C[0]) & (!C[3]|!C[2]|!C[1]|!C[0]));
	assign HEX[4] = !((C[3]|C[2]|C[1]|!C[0]) & (C[3]|C[2]|!C[1]|!C[0]) & 
	(C[3]|!C[2]|C[1]|C[0]) & (C[3]|!C[2]|C[1]|C[0]) &
	(C[3]|!C[2]|C[1]|!C[0]) & (C[3]|!C[2]|!C[1]|!C[0]) &
	(!C[3]|C[2]|C[1]|!C[0]));
	assign HEX[5] = !((C[3]|C[2]|C[1]|!C[0]) & (C[3]|C[2]|!C[1]|C[0]) & 
	(C[3]|C[2]|!C[1]|!C[0]) & (C[3]|!C[2]|!C[1]|!C[0]) & 
	(!C[3]|!C[2]|C[1]|!C[0]));
	assign HEX[6] = !((C[3]|C[2]|C[1]|C[0]) & (C[3]|C[2]|C[1]|!C[0]) & 
	(C[3]|!C[2]|!C[1]|!C[0]) & (!C[3]|!C[2]|C[1]|C[0]));

endmodule

module Register(D, Reset_n, Clk, Q);

	input [7:0] D;
	input Clk, Reset_n;
	output reg [7:0] Q;
	always @ (posedge Clk)
	begin
		if (Reset_n == 1'b0)
		Q <= 8'b00000000;
		else
		Q <= D;
	end
	
endmodule

module lab4part2 (input [9:0] SW, input [3:0] KEY, output [7:0] LEDR, output [6:0] HEX0, HEX4, HEX5);
	
	wire [7:0] ALUout, regOut; 
	
	bcdDecoder inputDisp1 (.C(SW[3:0]), .HEX(HEX0)); //input display
	
	ALU u1(.A(SW[3:0]), .B(regOut[7:0]), .opSelect(KEY[3:1]), .ALUout(ALUout)); //instantiates ALU
	Register u2(ALUout, SW[9], KEY[0], regOut);
	assign LEDR = regOut; //LEDR depends on ALUout
	
	bcdDecoder outputDisp1 (.C(regOut[3:0]), .HEX(HEX4)); //output display
	bcdDecoder outputDisp2 (.C(regOut[7:4]), .HEX(HEX5)); //output display

endmodule
