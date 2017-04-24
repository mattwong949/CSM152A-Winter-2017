`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:16:35 02/13/2017
// Design Name:   stopwatch
// Module Name:   E:/M152A/ours/Lab3/lab3/stopwatch_tb.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: stopwatch
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module stopwatch_tb;

	// Inputs
	reg clk;
	reg [1:0] sw;
	reg btnS;
	reg btnR;

	// Outputs
	wire [7:0] seg;
	wire [3:0] an;

	// Instantiate the Unit Under Test (UUT)
	stopwatch uut (
		.clk(clk), 
		.sw(sw),
		.btnS(btnS), 
		.btnR(btnR), 
		.seg(seg), 
		.an(an)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		btnS = 0;
		btnR = 1;
		sw[1] = 0; // select
		sw[0] = 0; // adjust
		

		// Wait 100 ns for global reset to finish
		#100; btnR = 0;
		        
		// Add stimulus here


	end
	
	always #5 clk = ~clk;
	
      
endmodule

