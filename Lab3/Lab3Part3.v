module lab3part3 (input [7:0] SW, input [2:0] KEY, output [7:0] LEDR,
						output [6:0] HEX0, HEX2, HEX4, HEX5);
						
	wire [7:0] ALUout; 
	
	bcdDecoder inputDisp1 (.C(SW[7:4]), .HEX(HEX0)); //input display
	bcdDecoder inputDisp2 (.C(SW[3:0]), .HEX(HEX2)); //input display
	
	ALU u1(.A(SW[7:4]), .B(SW[3:0]), .opSelect(KEY[2:0]), .ALUout(ALUout)); //instantiates ALU
	
	assign LEDR = ALUout; //LEDR depends on ALUout
	
	bcdDecoder outputDisp1 (.C(ALUout[3:0]), .HEX(HEX4)); //output display
	bcdDecoder outputDisp2 (.C(ALUout[7:4]), .HEX(HEX5)); //output display

endmodule

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

module ALU(input [3:0]A, B, input [2:0] opSelect, output reg [7:0] ALUout);
	
	wire [4:0] adderOut; //output of adder is assigned to this 4 bit wire and then used in the always block
	
	adder u1(.A(A), .B(B), .S(adderOut[3:0]), .Cin(1'b0), .Cout(adderOut[4]));
	
	always @(*)
		begin
		case(opSelect[2:0])
	 
			//case 0
			3'b111: ALUout = adderOut;
			3'b111: ALUout[7:5] = 0;
			
			//case 1
			3'b110: ALUout = A + B;
			3'b110: ALUout[7:5] = 0;
			
			//case2
			3'b101: ALUout = {{~(A | B)}, {~(A & B)}};
			
			//case 3
			3'b100: ALUout = {(A > 0) | (B > 0)} ? (8'b11000000):(8'b00000000);
			
			//case 4
			3'b011: 
				if (( A[0] + A[1] + A[2] + A[3] == 2) & (B[0] + B[1] + B[2] + B[3] == 3)) 
				begin
				ALUout= 8'b00111111;
				end
				
				else begin
				ALUout= 8'b00000000;
				end
				
			// case 5
			3'b010: ALUout = {{B}, {~A}}; 
			
			//case 6
			3'b001: ALUout = {{A^B}, {~(A^B)}};
			
			default: ALUout = 8'b00000000; //default case
		
	  endcase 
	end
	
endmodule

module bcdDecoder (input [3:0] C, output [6:0] HEX); // bcdDecoder

				// maxterms
				assign HEX[0] = ((C[3]|C[2]|C[1]|!C[0]) & (C[3]|!C[2]|C[1]|C[0]) & 
								(!C[3]|C[2]|!C[1]|!C[0]) & (!C[3]|!C[2]|C[1]|!C[0]));
								
				assign HEX[1] = ((C[3]|!C[2]|C[1]|!C[0]) & (C[3]|!C[2]|!C[1]|C[0]) & 
								(!C[3]|C[2]|!C[1]|!C[0]) & (!C[3]|!C[2]|C[1]|C[0]) & 
								(!C[3]|!C[2]|!C[1]|C[0]) & (!C[3]|!C[2]|!C[1]|!C[0]));
								
				assign HEX[2] = ((C[3]|C[2]|!C[1]|C[0]) & (!C[3]|!C[2]|C[1]|C[0]) & 
								(!C[3]|!C[2]|!C[1]|C[0]) & (!C[3]|!C[2]|!C[1]|!C[0]));
								
				assign HEX[3] = ((C[3]|C[2]|C[1]|!C[0]) & (C[3]|!C[2]|C[1]|C[0]) & 
								(C[3]|!C[2]|!C[1]|!C[0]) & (!C[3]|C[2]|C[1]|!C[0]) & 
								(!C[3]|C[2]|!C[1]|C[0]) & (!C[3]|!C[2]|!C[1]|!C[0]));
								
				assign HEX[4] = ((C[3]|C[2]|C[1]|!C[0]) & (C[3]|C[2]|!C[1]|!C[0]) & 
								(C[3]|!C[2]|C[1]|C[0]) & (C[3]|!C[2]|C[1]|C[0]) &
								(C[3]|!C[2]|C[1]|!C[0]) & (C[3]|!C[2]|!C[1]|!C[0]) &
								(!C[3]|C[2]|C[1]|!C[0]));
								
				assign HEX[5] = ((C[3]|C[2]|C[1]|!C[0]) & (C[3]|C[2]|!C[1]|C[0]) & 
								(C[3]|C[2]|!C[1]|!C[0]) & (C[3]|!C[2]|!C[1]|!C[0]) & 
								(!C[3]|!C[2]|C[1]|!C[0]));
								
				assign HEX[6] = ((C[3]|C[2]|C[1]|C[0]) & (C[3]|C[2]|C[1]|!C[0]) & 
								(C[3]|!C[2]|!C[1]|!C[0]) & (!C[3]|!C[2]|C[1]|C[0]));

endmodule
