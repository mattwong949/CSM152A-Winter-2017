`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:16:19 02/01/2017
// Design Name:   count_leading_zeros
// Module Name:   E:/M152A/ours/Lab2/count_leading_zeros_tb.v
// Project Name:  Lab2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: count_leading_zeros
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module count_leading_zeros_tb;

	// Inputs
	reg	[10:0] D;
	
	// Outputs
	wire	[2:0] exp;
	wire	[3:0] sig;
	wire	f;

	// Instantiate the Unit Under Test (UUT)
	count_leading_zeros uut (
		.d_i(D), .e(exp), .sig(sig), .f(f)
	);

	initial begin
		// Initialize Inputs

		D = 11'b10100110101;
		#10;
		D = 11'b01100110101;
		#10;
		D = 11'b00100110101;
		#10;
		D = 11'b00010110101;
		#10;
		D = 11'b00001010101;
		#10;
		D = 11'b00000110101;
		#10;
		D = 11'b00000010101;
		#10;
		D = 11'b00000001101;


		// Wait 100 ns for global reset to finish
		#100;
		
		
        
		// Add stimulus here

	end
      
endmodule

