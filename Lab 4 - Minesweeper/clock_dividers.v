`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:03:36 03/01/2017 
// Design Name: 
// Module Name:    clock_dividers 
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
module clock_dividers(
	// INPUT
	master, rst,
	// OUTPUT
	t25MHz, cursor_blink
    );
	 
	// 100 MHz
	input master;
	input rst;
	
	output t25MHz; // 25 MHz - pixel clock
	output cursor_blink; // 4 Hz
	
	reg [1:0] t25MHz_counter = 0; // 25 MHz;
	reg [24:0] cursor_blink_counter = 0; // 4 Hz
	
	reg t25MHz_reg;
	reg cursor_blink_reg;
	
	assign t25MHz = t25MHz_reg;
	assign cursor_blink = cursor_blink_reg;
	
	
	// 25 MHz clock divider
	always @(posedge master)
		begin
			if (rst == 1)
				begin
					t25MHz_counter <= 0;
					t25MHz_reg <= 0;
				end
			else if (t25MHz_counter == 4 - 1)
				begin
					t25MHz_counter <= 0;
					t25MHz_reg <= 1;
				end
			else
				begin
					t25MHz_counter <= t25MHz_counter + 1;
					t25MHz_reg <= 0;
				end
		end
		
	// cursor blinking clock divider - 4 Hz
	always @(posedge master)
		begin
			if (rst == 1)
				begin
					cursor_blink_counter <= 0;
					cursor_blink_reg <= 0;
				end
			else if (cursor_blink_counter == 25000000 - 1)
				begin
					cursor_blink_counter <= 0;
					cursor_blink_reg <= 1;
				end
			else
				begin
					cursor_blink_counter <= cursor_blink_counter + 1;
					cursor_blink_reg <= 0;
				end
		end
	

endmodule
