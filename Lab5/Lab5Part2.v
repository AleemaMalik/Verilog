`timescale 1s / 1s

module mux4to1(input [1:0] s, output reg [25:0] m);

	always @ (*)
		begin
			case (s[1:0])
				2'b00: m = 1;
				2'b01: m = 12500000;
				2'b10: m = 25000000;
				2'b11: m = 50000000;
				default: m = 50000000;
			endcase
		end
endmodule


module rateDivider (d, q, clock, clear_b, Enable);

	input clock,clear_b, Enable;
	output reg [25:0] q; // declare q
	input [25:0] d; // declare d
	
	always @(posedge clock) // triggered every time clock rises
		begin
			if (clear_b == 1'b0) // when Clear b is 0
				q <= 0; // q is set to 0
			else if (q == 0) // when q is the maximum value for the counter
				q <= d; // q reset to d
			else if (Enable == 1'b1) // increment q only when Enable is 1
				q <= q - 1; // increment q
		end
endmodule


module enablePulse(input [25:0] in, output reg out);
	always @ *
		begin
			if (in == 1)
				out = 1;
		else 
				out = 0;
		end
endmodule

module eightBitCounter(q,clock,Enable,clear_b);

	input clock,clear_b, Enable;
	output reg [3:0] q; // declare q
	
	always @ (posedge clock) // triggered every time clock rises
		begin
			if (clear_b == 1'b0) // when Clear b is 0
				q <= 0; // q is set to 0
			else if (q == 5'b10000) // when q is the maximum value for the counter
				q <= 0; // q reset to 0
			else if (Enable == 1'b1) // increment q only when Enable is 1
				q <= q + 1; // increment q
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


module lab5part2(input CLOCK_50, input [2:0] SW, output [6:0] HEX0);

	wire [25:0] d;
	wire [25:0] q;
	wire [3:0] q1;
	wire q2;
	
	mux4to1 u1(SW[1:0], d);
	
	rateDivider u2(d, q, CLOCK_50, SW[2], 1'b1);
	
	enablePulse u3(q, q2);
	
	eightBitCounter u4(q1 ,CLOCK_50, q2, SW[2]);
	
	bcdDecoder u5(q1, HEX0);
	
endmodule