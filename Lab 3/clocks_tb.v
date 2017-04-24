`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:36:08 02/08/2017
// Design Name:   clocks
// Module Name:   E:/M152A/ours/Lab3/lab3/clocks_tb.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clocks
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module clocks_tb;

	// Inputs
	reg master;
	reg rst;

	// Outputs
	wire t2Hz;
	wire t1Hz;
	wire fast;
	wire adjust;

	// Instantiate the Unit Under Test (UUT)
	clocks uut (
		.master(master), 
		.rst(rst), 
		
		.t2Hz(t2Hz),
		.t1Hz(t1Hz),
		.fast(fast), 
		.adjust(adjust)
	);

	initial begin
		// Initialize Inputs
		master = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#10;
		rst = 0;
        
		// Add stimulus here

	end
	
	always #1 master = ~master;
      
endmodule

