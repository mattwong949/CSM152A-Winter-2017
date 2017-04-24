`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:54:53 02/20/2017
// Design Name:   select_clock
// Module Name:   D:/M152A/ours/Lab3/lab3/select_clock_tb.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: select_clock
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module select_clock_tb;

	// Inputs
	reg clk_1Hz;
	reg clk_2Hz;
	reg adjust;

	// Outputs
	wire clock;

	// Instantiate the Unit Under Test (UUT)
	select_clock uut (
		.clk_1Hz(clk_1Hz), 
		.clk_2Hz(clk_2Hz), 
		.adjust(adjust), 
		.clock(clock)
	);

	initial begin
		// Initialize Inputs
		clk_1Hz = 0;
		clk_2Hz = 0;
		adjust = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always #4 clk_1Hz = ~clk_1Hz;
	always #2 clk_2Hz = ~clk_2Hz;
      
endmodule

