`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:25:44 03/09/2017
// Design Name:   map_state
// Module Name:   D:/M152A/ours/minesweeper/map_state_tb.v
// Project Name:  minesweeper
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: map_state
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module map_state_tb;

	// Inputs
	reg clk;
	reg load_new_map;
	reg btn_up;
	reg btn_down;
	reg btn_left;
	reg btn_right;
	reg btn_sel;

	// Outputs
	wire [63:0] clicked_flat;
	wire [2:0] cursor_X;
	wire [2:0] cursor_Y;
	wire [5:0] num_clicked;

	// Instantiate the Unit Under Test (UUT)
	map_state uut (
		.clk(clk),
		.load_new_map(load_new_map), 
		.btn_up(btn_up), 
		.btn_down(btn_down), 
		.btn_left(btn_left), 
		.btn_right(btn_right), 
		.btn_sel(btn_sel), 
		
		.clicked_flat(clicked_flat), 
		.cursor_X(cursor_X), 
		.cursor_Y(cursor_Y),
		.num_clicked(num_clicked)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		load_new_map = 0;
		
		btn_up = 0;
		btn_down = 0;
		btn_left = 0;
		btn_right = 0;
		btn_sel = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		load_new_map = 1;
		#20
		load_new_map = 0;
		#30
		
		btn_sel = 1;
		#10
		btn_sel = 0;
		#10
		
		btn_down = 1;
		btn_left = 1;
		#10
		btn_left = 0;
		btn_down = 0;
		#10
		
		btn_sel = 1;
		#10
		btn_sel = 0;
		#10
		;
	end
	
	always #5 clk = ~clk;
	
endmodule

