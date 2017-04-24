`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:47:05 02/20/2017
// Design Name:   display
// Module Name:   D:/M152A/ours/Lab3/lab3/display_tb.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: display
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module display_tb;

	// Inputs
	reg fast_clock;
	reg blink_clock;
	reg [3:0] seconds_ones;
	reg [3:0] seconds_tens;
	reg [3:0] minutes_ones;
	reg [3:0] minutes_tens;
	reg select;
	reg adjust;

	// Outputs
	wire [3:0] anode;
	wire [7:0] segment;

	// Instantiate the Unit Under Test (UUT)
	display uut (
		.fast_clock(fast_clock), 
		.blink_clock(blink_clock), 
		.seconds_ones(seconds_ones), 
		.seconds_tens(seconds_tens), 
		.minutes_ones(minutes_ones), 
		.minutes_tens(minutes_tens), 
		.select(select), 
		.adjust(adjust), 
		.anode(anode), 
		.segment(segment)
	);

	initial begin
		// Initialize Inputs
		fast_clock = 0;
		blink_clock = 0;
		seconds_ones = 1;
		seconds_tens = 2;
		minutes_ones = 3;
		minutes_tens = 4;
		select = 1;
		adjust = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
	end
	
	always #1 fast_clock = ~fast_clock;
   always #10 blink_clock = ~blink_clock;
		
endmodule

