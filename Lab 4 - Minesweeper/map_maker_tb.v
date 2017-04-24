`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:03:02 03/09/2017
// Design Name:   map_maker
// Module Name:   D:/M152A/ours/minesweeper/map_maker_tb.v
// Project Name:  minesweeper
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: map_maker
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module map_maker_tb;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire ready;
	wire [255:0] map_flat;

	// Instantiate the Unit Under Test (UUT)
	map_maker uut (
		.clk(clk), 
		.rst(rst), 
		.ready(ready), 
		.map_flat(map_flat)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#100;
		rst = 0;
		
        
		// Add stimulus here
		#200
		rst = 1;
		#100
		rst = 0;
		
		#200
		rst = 1;
		#100
		rst = 0;
	end
	
	always #4 clk = ~clk;
      
endmodule

