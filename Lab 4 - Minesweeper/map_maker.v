`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:17:08 03/01/2017 
// Design Name: 
// Module Name:    map_maker 
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
module map_maker(
	// INPUT
	clk, rst,
	// OUTPUT
	ready, map_flat
	);

	input clk;
	input rst;

	output ready;
	output [255:0] map_flat;
	
	
	wire [7:0] number;
	
	rand_8b rand_generator(
		// INPUT
		.clk(clk),
		
		// OUTPUT
		.number(number)
	);
	
	// used for simulation
	//reg [3:0] map [0:7][0:7];
	
	
	// used for implementation
	reg [3:0] map [0:7][0:7] = {{4'h0,4'h0,4'h0,4'h0,4'h0,4'h0,4'h0,4'h0},
										{4'h0,4'h0,4'h0,4'h0,4'h0,4'h0,4'h0,4'h0},
										{4'h0,4'h0,4'h0,4'h0,4'h0,4'h0,4'h0,4'h0},
										{4'h0,4'h0,4'h0,4'h0,4'h0,4'h0,4'h0,4'h0},
										{4'h0,4'h0,4'h0,4'h0,4'h0,4'h0,4'h0,4'h0},
										{4'h0,4'h0,4'h0,4'h0,4'h0,4'h0,4'h0,4'h0},
										{4'h0,4'h0,4'h0,4'h0,4'h0,4'h0,4'h0,4'h0},
										{4'h0,4'h0,4'h0,4'h0,4'h0,4'h0,4'h0,4'h0}};
	
										
	reg [3:0] iterations;
	reg ready_reg = 0;
	
	wire [2:0] div;
	wire [2:0] remainder;
	
	assign ready = ready_reg;
	assign div = number[7:5]; //(number >> 5);
	assign remainder = number[4:2]; //((number >> 3) % 8); ?? did you mean ((number >> 2) % 8;
	
	assign map_flat = {map[7][7],map[7][6],map[7][5],map[7][4],map[7][3],map[7][2],map[7][1],map[7][0],
							map[6][7],map[6][6],map[6][5],map[6][4],map[6][3],map[6][2],map[6][1],map[6][0],
							map[5][7],map[5][6],map[5][5],map[5][4],map[5][3],map[5][2],map[5][1],map[5][0],
							map[4][7],map[4][6],map[4][5],map[4][4],map[4][3],map[4][2],map[4][1],map[4][0],
							map[3][7],map[3][6],map[3][5],map[3][4],map[3][3],map[3][2],map[3][1],map[3][0],
							map[2][7],map[2][6],map[2][5],map[2][4],map[2][3],map[2][2],map[2][1],map[2][0],
							map[1][7],map[1][6],map[1][5],map[1][4],map[1][3],map[1][2],map[1][1],map[1][0],
							map[0][7],map[0][6],map[0][5],map[0][4],map[0][3],map[0][2],map[0][1],map[0][0]};
	
	integer i = 0;
	
	always @ (posedge clk, posedge rst)
		begin
			if (rst)
				begin
					iterations <= 4'b1010;	// request 10 bombs
					ready_reg <= 0;
					
					// reset the map values
					map[0][0] <= 4'h0;
					map[0][1] <= 4'h0;
					map[0][2] <= 4'h0;
					map[0][3] <= 4'h0;
					map[0][4] <= 4'h0;
					map[0][5] <= 4'h0;
					map[0][6] <= 4'h0;
					map[0][7] <= 4'h0;
					
					map[1][0] <= 4'h0;
					map[1][1] <= 4'h0;
					map[1][2] <= 4'h0;
					map[1][3] <= 4'h0;
					map[1][4] <= 4'h0;
					map[1][5] <= 4'h0;
					map[1][6] <= 4'h0;
					map[1][7] <= 4'h0;
					
					map[2][0] <= 4'h0;
					map[2][1] <= 4'h0;
					map[2][2] <= 4'h0;
					map[2][3] <= 4'h0;
					map[2][4] <= 4'h0;
					map[2][5] <= 4'h0;
					map[2][6] <= 4'h0;
					map[2][7] <= 4'h0;
					
					map[3][0] <= 4'h0;
					map[3][1] <= 4'h0;
					map[3][2] <= 4'h0;
					map[3][3] <= 4'h0;
					map[3][4] <= 4'h0;
					map[3][5] <= 4'h0;
					map[3][6] <= 4'h0;
					map[3][7] <= 4'h0;
					
					map[4][0] <= 4'h0;
					map[4][1] <= 4'h0;
					map[4][2] <= 4'h0;
					map[4][3] <= 4'h0;
					map[4][4] <= 4'h0;
					map[4][5] <= 4'h0;
					map[4][6] <= 4'h0;
					map[4][7] <= 4'h0;
					
					map[5][0] <= 4'h0;
					map[5][1] <= 4'h0;
					map[5][2] <= 4'h0;
					map[5][3] <= 4'h0;
					map[5][4] <= 4'h0;
					map[5][5] <= 4'h0;
					map[5][6] <= 4'h0;
					map[5][7] <= 4'h0;
					
					map[6][0] <= 4'h0;
					map[6][1] <= 4'h0;
					map[6][2] <= 4'h0;
					map[6][3] <= 4'h0;
					map[6][4] <= 4'h0;
					map[6][5] <= 4'h0;
					map[6][6] <= 4'h0;
					map[6][7] <= 4'h0;
					
					map[7][0] <= 4'h0;
					map[7][1] <= 4'h0;
					map[7][2] <= 4'h0;
					map[7][3] <= 4'h0;
					map[7][4] <= 4'h0;
					map[7][5] <= 4'h0;
					map[7][6] <= 4'h0;
					map[7][7] <= 4'h0;
					
				end
			else
				begin
					if (iterations > 0 && iterations <= 10 && !ready_reg)
						begin
							ready_reg <= 0;
							
							if (map[div][remainder] < 9) // not a mine
								begin
									iterations <= iterations - 1;
									map[div][remainder] <= 4'h9;
									
									// try this logic? seems simpler
									if (div > 0 && remainder > 0) // top left
										map[div - 1][remainder - 1] <= map[div - 1][remainder - 1] + 1;
										
									if (remainder > 0) // top middle
										map[div][remainder - 1] <= map[div][remainder - 1] + 1;
										
									if (div < 7 && remainder > 0) // top right
										map[div + 1][remainder - 1] <= map[div + 1][remainder - 1] + 1;
										
									if (div > 0) // left middle
										map[div - 1][remainder] <= map[div - 1][remainder] + 1;
									
									if (div < 7) // right middle
										map[div + 1][remainder] <= map[div + 1][remainder] + 1;
									
									if (div > 0 && remainder < 7) // bottom left
										map[div - 1][remainder + 1] <= map[div - 1][remainder + 1] + 1;
										
									if (remainder < 7) // bottom middle
										map[div][remainder + 1] <= map[div][remainder + 1] + 1;
										
									if (div < 7 && remainder < 7) // bottom right
										map[div + 1][remainder + 1] <= map[div + 1][remainder + 1] + 1;
								end
								
						end
					else if (iterations == 0 && !ready_reg) // all bombs placed, set ready to 1
						begin
							ready_reg <= 1;
							iterations <= 15;
						end
					else if (ready_reg) // hold ready only for one cycle iterations == 15 && 
						begin
							ready_reg <= 0;
							
						end
				end
		end

endmodule
	