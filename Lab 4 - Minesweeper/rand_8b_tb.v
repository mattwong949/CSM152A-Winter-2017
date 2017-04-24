`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:34:04 03/09/2017
// Design Name:   rand_8b
// Module Name:   D:/M152A/ours/minesweeper/rand_8b_tb.v
// Project Name:  minesweeper
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: rand_8b
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module rand_8b_tb;

	// Inputs
	reg clk;

	// Outputs
	wire [7:0] number;

	// Instantiate the Unit Under Test (UUT)
	rand_8b uut (
		.clk(clk), 
		.number(number)
	);

	initial begin
		// Initialize Inputs
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always #5 clk = ~clk;
      
endmodule

