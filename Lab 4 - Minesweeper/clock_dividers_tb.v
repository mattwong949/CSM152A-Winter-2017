`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:14:23 03/14/2017
// Design Name:   clock_dividers
// Module Name:   D:/M152A/ours/minesweeper/clock_dividers_tb.v
// Project Name:  minesweeper
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clock_dividers
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module clock_dividers_tb;

	// Inputs
	reg master;
	reg rst;

	// Outputs
	wire t25MHz;
	wire cursor_blink;

	// Instantiate the Unit Under Test (UUT)
	clock_dividers uut (
		.master(master), 
		.rst(rst), 
		.t25MHz(t25MHz), 
		.cursor_blink(cursor_blink)
	);

	initial begin
		// Initialize Inputs
		master = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		rst = 0;
	end
	
	always #4 master = ~master;
      
endmodule

