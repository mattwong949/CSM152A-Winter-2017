`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:49:23 03/13/2017
// Design Name:   game_state
// Module Name:   D:/M152A/ours/minesweeper/game_state_tb.v
// Project Name:  minesweeper
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: game_state
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module game_state_tb;

	// Inputs
	reg clk;
	reg rst;
	reg [255:0] map_flat;
	reg [63:0] clicked_flat;
	reg [5:0] num_clicked;

	// Outputs
	wire dead;
	wire won;

	// Instantiate the Unit Under Test (UUT)
	game_state uut (
		.clk(clk), 
		.rst(rst), 
		.map_flat(map_flat), 
		.clicked_flat(clicked_flat), 
		.num_clicked(num_clicked), 
		.dead(dead), 
		.won(won)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		map_flat = 0;
		clicked_flat = 0;
		num_clicked = 54;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		rst = 1;
		num_clicked = 0;
		#10
		
		rst = 0;
		
		#10
		map_flat = 9;
		clicked_flat = 64'b1111111111111111111111111111111111111111111111111111111111111111;
		
		#10
		num_clicked = 54;
	end
	
	always #5 clk = ~clk;
      
endmodule

