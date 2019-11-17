module lab3part1 (SW, LEDR); //top-level module
	input [9:0]SW;
	output[9:0]LEDR;
	
	mux7to1 u1(.SW(SW[6:0]),
				  .MuxSelect(SW[9:7]),
				  .Out(LEDR[0]))	;
endmodule

module mux7to1 (SW, MuxSelect,Out);
	
	input[6:0]SW;
	input[2:0]MuxSelect;
	output reg Out;
	
	always @(*)
	begin
		case(MuxSelect)
		3'b000: Out = SW[0];	// MuxSelect = 3'b000, output depends on SW[0]
		3'b001: Out = SW[1];
		3'b010: Out = SW[2];
 		3'b011: Out = SW[3];
		3'b100: Out = SW[4];
		3'b101: Out = SW[5];
		3'b110: Out = SW[6];
		default: Out = 3'b000; //default case

		endcase

	end

endmodule
