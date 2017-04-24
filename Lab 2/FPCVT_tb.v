`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:18:23 02/01/2017
// Design Name:   FPCVT
// Module Name:   E:/M152A/ours/Lab2/FPCVT_tb.v
// Project Name:  Lab2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FPCVT
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module FPCVT_tb;

	// Inputs
	reg [11:0] D;

	// Outputs
	wire S;
	wire [2:0] E;
	wire [3:0] F;

	// Instantiate the Unit Under Test (UUT)
	FPCVT uut (
		//Input
		.D(D),
		//Output
		.S(S), .E(E), .F(F)
	);

	initial begin
		// Initialize Inputs

		D = 12'b001000110010;
		#10;
		D = 12'b111001100000;
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

