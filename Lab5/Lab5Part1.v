`timescale 1ns / 1ns

module tFlipFlop (T, Clock, Clear_b, Q);

	input T, Clock, Clear_b;
	output reg Q;
	
	always @ (posedge Clock, negedge Clear_b) //asynchronous Clear_b
	
		begin
		if (Clear_b == 0) //active low clear
			Q <= 0;
		else if (T == 0) //if toggle off doesnt toggle
			Q <= Q;
		else if (T == 1) //if toggle one, toggles
			Q <= !Q;
		end
		
endmodule
			
module counter (input Enable, Clock, Clear_b, output [7:0] Q);

	wire [7:0] w;
	
	tFlipFlop u1(Enable, Clock, Clear_b, w[7]); //t flip flop instantiated 8 times
	tFlipFlop u2(Enable*w[7], Clock, Clear_b, w[6]);
	tFlipFlop u3(Enable*w[7]*w[6], Clock, Clear_b, w[5]);
	tFlipFlop u4(Enable*w[7]*w[6]*w[5], Clock, Clear_b, w[4]);
	tFlipFlop u5(Enable*w[7]*w[6]*w[5]*w[4], Clock, Clear_b, w[3]);
	tFlipFlop u6(Enable*w[7]*w[6]*w[5]*w[4]*w[3], Clock, Clear_b, w[2]);
	tFlipFlop u7(Enable*w[7]*w[6]*w[5]*w[4]*w[3]*w[2], Clock, Clear_b, w[1]);
	tFlipFlop u8(Enable*w[7]*w[6]*w[5]*w[4]*w[3]*w[2]*w[1], Clock, Clear_b, w[0]);
	
	assign Q[0] = w[7];
	assign Q[1] = w[6];
	assign Q[2] = w[5];
	assign Q[3] = w[4];
	assign Q[4] = w[3];
	assign Q[5] = w[2];
	assign Q[6] = w[1];
	assign Q[7] = w[0];
	
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

module lab5part1 (input [1:0] SW, input [3:0] KEY, output [6:0] HEX0, HEX1);

	wire [7:0] counterOut;
	
	counter u1(SW[1], KEY[0], SW[0], counterOut);
	
	bcdDecoder outputDisplay1 (counterOut[7:4], HEX1);
	bcdDecoder outputDisplay2 (counterOut[3:0], HEX0);
	
endmodule