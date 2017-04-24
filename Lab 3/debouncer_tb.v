`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:15:08 02/20/2017
// Design Name:   debouncer
// Module Name:   D:/M152A/ours/Lab3/lab3/debouncer_tb.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: debouncer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module debouncer_tb;

	// Inputs
	reg clock;
	reg button;
	reg reset;

	// Outputs
	wire btn_posedge;

	// Instantiate the Unit Under Test (UUT)
	debouncer uut (
		.clk(clock), 
		.button(button), 
		.rst(reset), 
		.btn_posedge(btn_posedge)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		button = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		
		// simulate button press
		button = 1;
		#1 button = 0;
		
		#4 button = 1;
		#2 button = 0;
		
		#2 button = 1;
		#5 button = 0;
		
		#2 button = 1;
		#30 button = 0;
        
		// Add stimulus here

	end
	
	always #1 clock = ~clock;
      
endmodule

