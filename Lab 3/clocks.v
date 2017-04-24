`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:12:13 02/08/2017 
// Design Name: 
// Module Name:    clocks 
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
module clocks(
	//INPUT
	master, rst,
	//OUTPUT
	t2Hz, t1Hz, fast, adjust
    );
	 
	 // 100 MHz
	input master;
	input rst;
	
	output t2Hz;
	output t1Hz;
	output fast;
	output adjust;
	
	reg [25:0] t2Hz_counter = 0; // 2 Hz
	reg [26:0] t1Hz_counter = 0; // 1 Hz
	reg [18:0] fast_counter = 0; // 200 Hz
	reg [24:0] adjust_counter = 0; // 5 Hz
	
	reg t2Hz_reg = 0;
	reg t1Hz_reg = 0;
	reg fast_reg = 0;
	reg adjust_reg = 0;
	
	// actual runtime values
	assign t2Hz = t2Hz_reg;
	assign t1Hz = t1Hz_reg;
	assign fast = fast_reg;
	assign adjust = adjust_reg;
	
	
	// 2 Hz clock divider
	always @(posedge master)
		begin
			if (rst == 1)
				begin
					t2Hz_counter <= 0;
					t2Hz_reg <= 0;
				end
			else if (t2Hz_counter == 50000000 - 1)
				begin
					t2Hz_counter <= 0;
					t2Hz_reg <= 1;
				end
			else
				begin
					t2Hz_counter <= t2Hz_counter + 1;
					t2Hz_reg <= 0;
				end
		end
	
	// 1 Hz clock divider
	always @(posedge master)
		begin
			if (rst == 1)
				begin
					t1Hz_counter <= 0;
					t1Hz_reg <= 0;
				end
			else if (t1Hz_counter == 100000000 - 1)
				begin
					t1Hz_counter <= 0;
					t1Hz_reg <= 1;
				end
			else
				begin
					t1Hz_counter <= t1Hz_counter + 1;
					t1Hz_reg <= 0;
				end
		end
	
	// fast cycling clock divider 200Hz
	always @(posedge master)
		begin
			if (rst == 1)
				begin
					fast_counter <= 0;
					fast_reg <= 0;
				end
			else if (fast_counter == 500000 - 1)
				begin
					fast_counter <= 0;
					fast_reg <= 1;
				end
			else
				begin
					fast_counter <= fast_counter + 1;
					fast_reg <= 0;
				end
		end
	
	// blinking clock divider 5Hz
	always @(posedge master)
		begin
			if (rst == 1)
				begin
					adjust_counter <= 0;
					adjust_reg <= 0;
				end
			else if (adjust_counter == 20000000 - 1)
				begin
					adjust_counter <= 0;
					adjust_reg <= 1;
				end
			else
				begin
					adjust_counter <= adjust_counter + 1;
					adjust_reg <= 0;
				end
		end
		

endmodule
