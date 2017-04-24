`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:52:24 02/20/2017 
// Design Name: 
// Module Name:    select_clock 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module select_clock(
	// INPUT
	clk_1Hz, clk_2Hz, adjust,
	
	// OUTPUT
	clock
    );
	 
	 input clk_1Hz;
	 input clk_2Hz;
	 input adjust;
	 
	 output clock;
	 
	 reg clk_reg;
	 
	 assign clock = clk_reg;
	 
	 always @(*)
	 begin
	 
		if (adjust == 0)
			clk_reg = clk_1Hz;
		else
			clk_reg = clk_2Hz;
			
	 end

endmodule
