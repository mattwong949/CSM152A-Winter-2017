`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:24:09 01/30/2017
// Design Name:   convert2toSM
// Module Name:   E:/M152A/ours/Lab2/convert2toSM_tb.v
// Project Name:  Lab2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: convert2toSM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module convert2toSM_tb;

	// Inputs
	reg	[11:0] D;
	
	wire	S;
	wire	[10:0] M;

	// Instantiate the Unit Under Test (UUT)
	convert2toSM uut (
		.d(D), .s(S), .m(M)
	);

	initial begin
		// Initialize Inputs
		D = 12'b001000110010;
		#10;
		D = 12'b100001100000;
		#10;
		D = 12'b111111111111;
		#10;
		D = 12'b000000000000;
		#10;
		D = 12'b011111111111;
		#10;
		D = 12'b100000000000;

		// Wait 100 ns for global reset to finish
		#100;
		
		
		
		
        
		// Add stimulus here

	end
      
endmodule

