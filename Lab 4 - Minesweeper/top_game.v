`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:33:37 03/01/2017 
// Design Name: 
// Module Name:    top_game 
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
module top_game(
	// INPUT
	clk, btnU, btnD, btnL, btnR, btnS, sw,
	// OUTPUT
	red, green, blue, hsync, vsync
    );
	
	// board inputs
	input clk; // 100 MHz
	input btnU; // up button
	input btnD; // down button
	input btnL; // left button
	input btnR; // right button
	input btnS; // center - action button
	input sw; // switch for reset
	
	// vga outputs
	output [2:0] red;
	output [2:0] green;
	output [1:0] blue;
	output hsync;
	output vsync;
	
	// wires for clock signals
	wire t25MHz;
	wire cursor_blink;
	
	// wires for valid button presses
	wire up_press;
	wire down_press;
	wire left_press;
	wire right_press;
	wire center_press;
	
	// wires for game state
	wire mines_ready;
	//wire full_map_ready;
	wire [255:0] mines_flat;
	//wire [255:0] full_map_flat;
	wire [63:0] clicked_flat;
	wire [2:0] cursorX;
	wire [2:0] cursorY;
	
	wire [5:0] num_clicked;
	
	wire alive;
	wire won;
	
	// TEST FOR VGA
	/*
	//wire [255:0] full_map_flat;
	reg [3:0] map [0:7][0:7] =   {{4'h0,4'h1,4'h2,4'h3,4'h4,4'h5,4'h6,4'h7},
											{4'h1,4'h2,4'h3,4'h4,4'h5,4'h6,4'h7,4'h0},
											{4'h2,4'h3,4'h4,4'h5,4'h6,4'h7,4'h0,4'h1},
											{4'h3,4'h4,4'h5,4'h6,4'h7,4'h0,4'h1,4'h2},
											{4'h4,4'h5,4'h6,4'h7,4'h0,4'h1,4'h2,4'h3},
											{4'h5,4'h6,4'h7,4'h0,4'h1,4'h2,4'h3,4'h4},
											{4'h6,4'h7,4'h0,4'h1,4'h2,4'h3,4'h4,4'h5},
											{4'h7,4'h0,4'h1,4'h2,4'h3,4'h4,4'h5,4'h6}};
	
	assign full_map_flat = {map[7][7],map[7][6],map[7][5],map[7][4],map[7][3],map[7][2],map[7][1],map[7][0],
							map[6][7],map[6][6],map[6][5],map[6][4],map[6][3],map[6][2],map[6][1],map[6][0],
							map[5][7],map[5][6],map[5][5],map[5][4],map[5][3],map[5][2],map[5][1],map[5][0],
							map[4][7],map[4][6],map[4][5],map[4][4],map[4][3],map[4][2],map[4][1],map[4][0],
							map[3][7],map[3][6],map[3][5],map[3][4],map[3][3],map[3][2],map[3][1],map[3][0],
							map[2][7],map[2][6],map[2][5],map[2][4],map[2][3],map[2][2],map[2][1],map[2][0],
							map[1][7],map[1][6],map[1][5],map[1][4],map[1][3],map[1][2],map[1][1],map[1][0],
							map[0][7],map[0][6],map[0][5],map[0][4],map[0][3],map[0][2],map[0][1],map[0][0]};
	
	reg [7:0] clicked [0:7] = {8'b10000000,
										8'b01000000,
										8'b00100000,
										8'b00010000,
										8'b00001000,
										8'b11100100,
										8'b11100010,
										8'b11100001};
	//wire [63:0] clicked_flat;
	assign clicked_flat = {clicked[7],clicked[6],clicked[5],clicked[4],clicked[3],clicked[2],clicked[1],clicked[0]};
	*/
	//reg [2:0] cursor_X_reg = 3;
	//reg [2:0] cursor_Y_reg = 4;
	//wire [2:0] cursorX;
	//wire [2:0] cursorY;
	//assign cursorX = cursor_X_reg;
	//assign cursorY = cursor_Y_reg;
	
	
	map_maker mine_generator(
		// INPUT
		.clk(clk), 
		.rst(sw),
		
		// OUTPUT
		.ready(mines_ready), 
		.map_flat(mines_flat)
	);

	map_state map_state(
		// INPUT
		.clk(clk),
		.load_new_map(mines_ready), 
		.btn_up(up_press), 
		.btn_down(down_press), 
		.btn_left(left_press), 
		.btn_right(right_press), 
		.btn_sel(center_press),
		
		// OUTPUT
		.clicked_flat(clicked_flat), 
		.cursor_X(cursorX), 
		.cursor_Y(cursorY),
		.num_clicked(num_clicked)
   );
	
	game_state game_state(
		// INPUT
		.clk(clk), 
		.rst(sw),
		.map_flat(mines_flat), 
		.clicked_flat(clicked_flat),
		.num_clicked(num_clicked),
		
		// OUTPUT
		.dead(dead), 
		.won(won)
   );
	
	controller board_controller(
		// INPUT
		.clk(clk), 
		.btnU(btnU), 
		.btnD(btnD), 
		.btnL(btnL), 
		.btnR(btnR), 
		.btnS(btnS), 
		.sw(sw),
		
		// OUTPUT
		.up_valid(up_press), 
		.down_valid(down_press), 
		.left_valid(left_press), 
		.right_valid(right_press), 
		.center_valid(center_press)
   );
	
	clock_dividers clock_signals(
		// INPUT
		.master(clk), 
		.rst(sw),
		
		// OUTPUT
		.t25MHz(t25MHz),
		.cursor_blink(cursor_blink)
   );
	
	vga640x480 vga_display(
		// INPUT
		.dclk(t25MHz),			//pixel clock: 25MHz
		.cclk(cursor_blink), // cursor blinking clock: 4 Hz
		.clr(sw),			//asynchronous reset
		
		//.map_flat(full_map_flat),
		.map_flat(mines_flat),
		.clicked_flat(clicked_flat),
		
		.cursorX(cursorX),
		.cursorY(cursorY),
		.dead(dead),
		.won(won),
		
		// OUTPUT
		.hsync(hsync),		//horizontal sync out
		.vsync(vsync),		//vertical sync out
		.red(red),	//red vga output
		.green(green), //green vga output
		.blue(blue)	//blue vga output
	);


endmodule
