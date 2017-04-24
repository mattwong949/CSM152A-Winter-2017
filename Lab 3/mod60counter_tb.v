`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:45:27 02/08/2017
// Design Name:   mod60counter
// Module Name:   E:/M152A/ours/Lab3/lab3/mod60counter_tb.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mod60counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mod60counter_tb;

	// inputs
	reg clk_1Hz;
	reg clk_2Hz;
	reg select;
	reg adjust;
	reg pause;
	reg rst;
	
	// outputs
	wire [3:0] seconds_ones;
	wire [3:0] seconds_tens;
	wire [3:0] minutes_ones;
	wire [3:0] minutes_tens;


	// Instantiate the Unit Under Test (UUT)
	mod60counter uut (
		//INPUT
		.clk_1Hz(clk_1Hz), 
		.clk_2Hz(clk_2Hz), 
		.select(select), 
		.adjust(adjust), 
		.pause(pause), 
		.rst(rst),

		//OUTPUT
		.seconds_ones(seconds_ones), 
		.seconds_tens(seconds_tens), 
		.minutes_ones(minutes_ones), 
		.minutes_tens(minutes_tens)
	);

	initial begin
		// Initialize Inputs
		
		clk_1Hz = 0;
		clk_2Hz = 0;
		select = 1; // 0 for seconds, 1 for minutes
		adjust = 0; // 0 for normal counting (1Hz), 1 for adjusting (2Hz)
		pause = 0;
		rst = 1;
		
		// Wait 100 ns for global reset to finish
		#100;
		rst = 0;
		
		#100
		adjust = 1;
		
		#100
		select = 0;
		
		#100
		adjust = 0;
		
		#600
		pause = 1; // hit the pause button to pause
		#1
		pause = 0;
		
		#400
		pause = 1; // hit the pause button to unpause
		#1
		pause = 0;
        
		// Add stimulus here
		
		
	end
	
	always #2 clk_1Hz = ~clk_1Hz;
	always #1 clk_2Hz = ~clk_2Hz;
      
endmodule

