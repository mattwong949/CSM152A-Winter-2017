`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:33:58 02/08/2017 
// Design Name: 
// Module Name:    mod60counter 
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

module mod60counter(
	//INPUT
	clk_1Hz, clk_2Hz, select, adjust, pause, rst,

	//OUTPUT
	seconds_ones, seconds_tens, minutes_ones, minutes_tens
    );
	
	input clk_1Hz;
	input clk_2Hz;
	
	input select;
	input adjust;
	
	input pause;
	
	input rst;
	
	output [3:0] seconds_ones;
	output [3:0] seconds_tens;
	output [3:0] minutes_ones;
	output [3:0] minutes_tens;
	
	
	reg [3:0] sec_ones = 4'b0000;
	reg [3:0] sec_tens = 4'b0000;
	reg [3:0] min_ones = 4'b0000;
	reg [3:0] min_tens = 4'b0000;
	
	reg paused = 0;
	
	wire clock;
	
	assign seconds_ones = sec_ones;
	assign seconds_tens = sec_tens;
	assign minutes_ones = min_ones;
	assign minutes_tens = min_tens;
	
	// select which clock to use based on adjust signal
	select_clock sel_clk(
		// INPUT
		.clk_1Hz(clk_1Hz), 
		.clk_2Hz(clk_2Hz), 
		.adjust(adjust),
		
		// OUTPUT
		.clock(clock)
    );
	
	
	always @(posedge pause or posedge clk_2Hz)
		begin
			// if pause button hit, flip the paused register
			if (pause)
				paused <= ~paused;
			// otherwise maintain the paused/unpaused state
			else
				paused <= paused;
		end
	
	always @(posedge clock or posedge rst)
		begin
			// if rst is high, reset the counter
			if (rst)
				begin
					sec_ones <= 0;
					sec_tens <= 0;
					min_ones <= 0;
					min_tens <= 0;
				end
			
			// normal counting (not adjusting, not paused, clock is 1 Hz)
			else if (adjust == 0 && ~paused) //&& clock == 1)
				begin
					if (sec_ones == 9 && sec_tens == 5)
						begin
							// seconds tens overflow
							sec_ones <= 0;
							sec_tens <= 0;
							
							// increment minutes
							if (min_ones == 9 && min_tens == 5)
								begin
									min_ones <= 0;
									min_tens <= 0;
								end
							else if (min_ones == 9)
								begin
									min_ones <= 0;
									min_tens <= min_tens + 1;
								end
							else
								min_ones <= min_ones + 1;
						
						end
					else if (sec_ones == 9)
						begin
							// seconds ones overflow
							sec_ones <= 0;
							sec_tens <= sec_tens + 1;
						end
					else
						// normal increment
						sec_ones <= sec_ones + 1;
					
				end
			
			// adjusted counting (adjusted, not paused, clock should be 2Hz)
			
			// adjust seconds
			else if (adjust == 1 && ~paused && ~select) //&& clock == 1)
				begin
					if (sec_ones == 9 && sec_tens == 5)
						begin
							// seconds tens overflow
							sec_ones <= 0;
							sec_tens <= 0;
						end
					else if (sec_ones == 9)
						begin
							// seconds ones overflow
							sec_ones <= 0;
							sec_tens <= sec_tens + 1;
						end
					else
						// normal increment
						sec_ones <= sec_ones + 1;
				end
			
			// adjust the minutes
			else if (adjust == 1 && ~paused && select)
				begin
					if (min_ones == 9 && min_tens == 5)
						begin
							// seconds tens overflow
							min_ones <= 0;
							min_tens <= 0;
						end
					else if (min_ones == 9)
						begin
							// seconds ones overflow
							min_ones <= 0;
							min_tens <= min_tens + 1;
						end
					else
						// normal increment
						min_ones <= min_ones + 1;
				end
		end

endmodule
