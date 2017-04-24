`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:46:26 03/10/2017 
// Design Name: 
// Module Name:    game_state 
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
module game_state(
	// INPUT
	clk, rst,
	map_flat, clicked_flat,
	num_clicked,
	// OUTPUT
	dead, won
   );
	
	input clk;
	input rst;
	input [255:0] map_flat;
	input [63:0] clicked_flat;
	input [5:0] num_clicked;
	
	output dead;
	output won;

	// Each square holds a 4-bit value: 0-8 for the number of mines surrounding it.
	wire [3:0] map [0:7][0:7];
	// Each square tells you which ones are clicked.
	wire [7:0] clicked [0:7];
	
	assign {map[7][7],map[7][6],map[7][5],map[7][4],map[7][3],map[7][2],map[7][1],map[7][0],
				map[6][7],map[6][6],map[6][5],map[6][4],map[6][3],map[6][2],map[6][1],map[6][0],
				map[5][7],map[5][6],map[5][5],map[5][4],map[5][3],map[5][2],map[5][1],map[5][0],
				map[4][7],map[4][6],map[4][5],map[4][4],map[4][3],map[4][2],map[4][1],map[4][0],
				map[3][7],map[3][6],map[3][5],map[3][4],map[3][3],map[3][2],map[3][1],map[3][0],
				map[2][7],map[2][6],map[2][5],map[2][4],map[2][3],map[2][2],map[2][1],map[2][0],
				map[1][7],map[1][6],map[1][5],map[1][4],map[1][3],map[1][2],map[1][1],map[1][0],
				map[0][7],map[0][6],map[0][5],map[0][4],map[0][3],map[0][2],map[0][1],map[0][0]} = map_flat;
				
	assign {clicked[7],clicked[6],clicked[5],clicked[4],clicked[3],clicked[2],clicked[1],clicked[0]} = clicked_flat;
	

	reg [3:0] counter; // counter for number of unclicked

	reg dead_reg = 0;
	reg won_reg = 0;
	assign dead = dead_reg;
	assign won = (num_clicked == 54) && !dead_reg; // clicked 54 squares and not dead
	
	integer i = 0;
	
	always @(posedge clk)
	begin
		if (rst == 1)
			begin
				won_reg <= 0;
				dead_reg <= 0;
			end
		else
			for ( i = 0; i < 8; i = i + 1)
				begin
					if (  ( (clicked[i][0] == 1) && (map[i][0] >= 9) ) ||
							( (clicked[i][1] == 1) && (map[i][1] >= 9) ) ||
							( (clicked[i][2] == 1) && (map[i][2] >= 9) ) ||
							( (clicked[i][3] == 1) && (map[i][3] >= 9) ) ||
							( (clicked[i][4] == 1) && (map[i][4] >= 9) ) ||
							( (clicked[i][5] == 1) && (map[i][5] >= 9) ) ||
							( (clicked[i][6] == 1) && (map[i][6] >= 9) ) ||
							( (clicked[i][7] == 1) && (map[i][7] >= 9) ) )
						begin
							dead_reg <= 1;
						end
				end
	end
	

endmodule
