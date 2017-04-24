`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:12:26 03/09/2017 
// Design Name: 
// Module Name:    map_state 
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
module map_state(
	// INPUT
	clk, load_new_map,
	btn_up, btn_down, btn_left, btn_right, btn_sel,
	// OUTPUT
	clicked_flat, cursor_X, cursor_Y, num_clicked
	
   );

	input clk;
	input load_new_map;
	input btn_up;
	input btn_down;
	input btn_left;
	input btn_right;
	input btn_sel;

	output [63:0] clicked_flat;
	output [2:0] cursor_X;
	output [2:0] cursor_Y;
	output [5:0] num_clicked;


	// Internal Variables
	// Each bit tells you whether clicked or not.
	reg [7:0] clicked [0:7];
	
	reg [2:0] cursor_pos_X = 0;
	reg [2:0] cursor_pos_Y = 0;
	reg [5:0] number_clicked = 0;

	assign clicked_flat = {clicked[7],clicked[6],clicked[5],clicked[4],clicked[3],clicked[2],clicked[1],clicked[0]};

	assign cursor_X = cursor_pos_X;
	assign cursor_Y = cursor_pos_Y;
	assign num_clicked = number_clicked;

	

	always @ (posedge clk)
		begin
			if (load_new_map) // reset the clicked status of all squares
				begin 
					clicked[0][7:0] <= (8'b00000000);
					clicked[1][7:0] <= (8'b00000000);
					clicked[2][7:0] <= (8'b00000000);
					clicked[3][7:0] <= (8'b00000000);
					clicked[4][7:0] <= (8'b00000000);
					clicked[5][7:0] <= (8'b00000000);
					clicked[6][7:0] <= (8'b00000000);
					clicked[7][7:0] <= (8'b00000000);
					number_clicked <= 0;
				end
			else if (!load_new_map)
				begin // listen for button presses
					if (btn_up)
						begin
							cursor_pos_X <= (cursor_pos_X - 1)%8;
						end
					else if (btn_down)
						begin
							cursor_pos_X <= (cursor_pos_X + 1)%8;
						end
					else if (btn_left)
						begin
							cursor_pos_Y <= (cursor_pos_Y - 1)%8;
						end
					else if (btn_right)
						begin
							cursor_pos_Y <= (cursor_pos_Y + 1)%8;
						end
					else if (btn_sel)
						begin
							if (!clicked[cursor_pos_X][cursor_pos_Y])
								begin
									number_clicked <= number_clicked + 1;
								end
							clicked[cursor_pos_X][cursor_pos_Y] <= 1;
							
						end
				end
		end

endmodule
