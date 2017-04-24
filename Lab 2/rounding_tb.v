`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:36:05 02/01/2017
// Design Name:   rouding
// Module Name:   E:/M152A/ours/Lab2/rounding_tb.v
// Project Name:  Lab2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: rouding
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module rounding_tb;
	
	// clock
	//reg clk;


	// Inputs
	reg	[2:0] exp;
	reg	[3:0] sig;
	reg	fifth;
	
	// Outputs
	wire	[2:0] E;
	wire	[3:0] F;

	// Instantiate the Unit Under Test (UUT)
	rouding uut (
		.exp(exp), .sig(sig), .fifth(fifth), .E(E), .F(F)
	);

	initial begin
		// Initialize Inputs
		
		//clk = 0;
		
		exp = 3'b101;
		sig = 4'b1010;
		fifth = 0;
		#10;
		exp = 3'b101;
		sig = 4'b1010;
		fifth = 1;
		#10;
		exp = 3'b101;
		sig = 4'b1111;
		fifth = 1;
		#10;
		exp = 3'b111;
		sig = 4'b1111;
		fifth = 1;

		// Wait 100 ns for global reset to finish
		#100;
      
		// Add stimulus here


	end
	
	//always #5 clk = ~clk;
      
endmodule

