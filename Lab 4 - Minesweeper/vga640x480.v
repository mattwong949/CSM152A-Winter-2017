`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:27:05 03/01/2017 
// Design Name: 
// Module Name:    vga640x480 
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
module vga640x480(
	// INPUT
	dclk,			//pixel clock: 25MHz
	cclk,
	clr,			//asynchronous reset
	
	map_flat,
	clicked_flat,
	cursorX,
	cursorY,
	dead,
	won,
	
	// OUTPUT
	hsync,		//horizontal sync out
	vsync,		//vertical sync out
	red,	//red vga output
	green, //green vga output
	blue	//blue vga output
	);
	
	// INPUT
	input dclk;
	input cclk;
	input clr;
	input [255:0] map_flat;
	input [63:0] clicked_flat;
	input [2:0] cursorX;
	input [2:0] cursorY;
	input dead;
	input won;
	
	// OUTPUT
	output hsync;
	output vsync;
	output reg [2:0] red = 3'b111;
	output reg [2:0] green = 3'b111;
	output reg [1:0] blue = 2'b11;

	// video structure constants
	parameter hpixels = 800;// horizontal pixels per line
	parameter vlines = 521; // vertical lines per frame
	parameter hpulse = 96; 	// hsync pulse length
	parameter vpulse = 2; 	// vsync pulse length
	parameter hbp = 144; 	// end of horizontal back porch
	parameter hfp = 784; 	// beginning of horizontal front porch
	parameter vbp = 31; 		// end of vertical back porch
	parameter vfp = 511; 	// beginning of vertical front porch
	// active horizontal video is therefore: 784 - 144 = 640
	// active vertical video is therefore: 511 - 31 = 480

	// registers for storing the horizontal & vertical counters
	reg [9:0] hc;
	reg [9:0] vc;

	// multidimensional arrays for the map and clicked squares
	wire [3:0] map [0:7][0:7];
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


	reg blink_flag = 0;
	
	// Create effect of cursor blinking
	always @(posedge cclk)
		begin
			blink_flag <= ~blink_flag;
		end
		

	// Cycle through every pixel
	always @(posedge dclk or posedge clr)
		begin
			// reset condition
			if (clr == 1)
				begin
					hc <= 0;
					vc <= 0;
				end
			else
				begin
					// keep counting until the end of the line
					if (hc < hpixels - 1)
						hc <= hc + 1;
					else
						// When we hit the end of the line, reset the horizontal
						// counter and increment the vertical counter.
						// If vertical counter is at the end of the frame, then
						// reset that one too.
						begin
							hc <= 0;
							if (vc < vlines - 1)
								vc <= vc + 1;
							else
								vc <= 0;
						end
					
				end
		end
		
	assign hsync = (hc < hpulse) ? 0:1;
	assign vsync = (vc < vpulse) ? 0:1;

	always @(*)
		begin
			// row 1
			if (vc >= vbp && vc < (vbp+60) )
				begin
					if (hc >= hbp && hc < (hbp+80))
						begin
							showColorValue(0, 0, cursorX, cursorY, blink_flag, clicked[0][0], map[0][0], dead, won);
						end
					else if (hc >= (hbp+80) && hc < (hbp+160))
						begin
							showColorValue(0, 1, cursorX, cursorY, blink_flag, clicked[0][1], map[0][1], dead, won);
						end
					else if (hc >= (hbp+160) && hc < (hbp+240))
						begin
							showColorValue(0, 2, cursorX, cursorY, blink_flag, clicked[0][2], map[0][2], dead, won);
						end
					else if (hc >= (hbp+240) && hc < (hbp+320))
						begin
							showColorValue(0, 3, cursorX, cursorY, blink_flag, clicked[0][3], map[0][3], dead, won);
						end
					else if (hc >= (hbp+320) && hc < (hbp+400))
						begin
							showColorValue(0, 4, cursorX, cursorY, blink_flag, clicked[0][4], map[0][4], dead, won);
						end
					else if (hc >= (hbp+400) && hc < (hbp+480))
						begin
							showColorValue(0, 5, cursorX, cursorY, blink_flag, clicked[0][5], map[0][5], dead, won);
						end
					else if (hc >= (hbp+480) && hc < (hbp+560))
						begin
							showColorValue(0, 6, cursorX, cursorY, blink_flag, clicked[0][6], map[0][6], dead, won);
						end
					else if (hc >= (hbp+560) && hc < (hbp+640))
						begin
							showColorValue(0, 7, cursorX, cursorY, blink_flag, clicked[0][7], map[0][7], dead, won);
						end
					// we're outside active horizontal range so display black
					else
						begin
							showColorValue(0, 0, 0, 0, 1, 0, 9, 0, 0); // force show black
						end
				end
			// row 2
			else if (vc >= (vbp+60) && vc < (vbp+120))
				begin
					if (hc >= hbp && hc < (hbp+80))
						begin
							showColorValue(1, 0, cursorX, cursorY, blink_flag, clicked[1][0], map[1][0], dead, won);
						end
					else if (hc >= (hbp+80) && hc < (hbp+160))
						begin
							showColorValue(1, 1, cursorX, cursorY, blink_flag, clicked[1][1], map[1][1], dead, won);
						end
					else if (hc >= (hbp+160) && hc < (hbp+240))
						begin
							showColorValue(1, 2, cursorX, cursorY, blink_flag, clicked[1][2], map[1][2], dead, won);
						end
					else if (hc >= (hbp+240) && hc < (hbp+320))
						begin
							showColorValue(1, 3, cursorX, cursorY, blink_flag, clicked[1][3], map[1][3], dead, won);
						end
					else if (hc >= (hbp+320) && hc < (hbp+400))
						begin
							showColorValue(1, 4, cursorX, cursorY, blink_flag, clicked[1][4], map[1][4], dead, won);
						end
					else if (hc >= (hbp+400) && hc < (hbp+480))
						begin
							showColorValue(1, 5, cursorX, cursorY, blink_flag, clicked[1][5], map[1][5], dead, won);
						end
					else if (hc >= (hbp+480) && hc < (hbp+560))
						begin
							showColorValue(1, 6, cursorX, cursorY, blink_flag, clicked[1][6], map[1][6], dead, won);
						end
					else if (hc >= (hbp+560) && hc < (hbp+640))
						begin
							showColorValue(1, 7, cursorX, cursorY, blink_flag, clicked[1][7], map[1][7], dead, won);
						end
					// we're outside active horizontal range so display black
					else
						begin
							showColorValue(0, 0, 0, 0, 1, 0, 9, 0, 0);
						end
				end
			// row 3
			else if (vc >= (vbp+120) && vc < (vbp+180))
				begin
					if (hc >= hbp && hc < (hbp+80))
						begin
							showColorValue(2, 0, cursorX, cursorY, blink_flag, clicked[2][0], map[2][0], dead, won);
						end
					else if (hc >= (hbp+80) && hc < (hbp+160))
						begin
							showColorValue(2, 1, cursorX, cursorY, blink_flag, clicked[2][1], map[2][1], dead, won);
						end
					else if (hc >= (hbp+160) && hc < (hbp+240))
						begin
							showColorValue(2, 2, cursorX, cursorY, blink_flag, clicked[2][2], map[2][2], dead, won);
						end
					else if (hc >= (hbp+240) && hc < (hbp+320))
						begin
							showColorValue(2, 3, cursorX, cursorY, blink_flag, clicked[2][3], map[2][3], dead, won);
						end
					else if (hc >= (hbp+320) && hc < (hbp+400))
						begin
							showColorValue(2, 4, cursorX, cursorY, blink_flag, clicked[2][4], map[2][4], dead, won);
						end
					else if (hc >= (hbp+400) && hc < (hbp+480))
						begin
							showColorValue(2, 5, cursorX, cursorY, blink_flag, clicked[2][5], map[2][5], dead, won);
						end
					else if (hc >= (hbp+480) && hc < (hbp+560))
						begin
							showColorValue(2, 6, cursorX, cursorY, blink_flag, clicked[2][6], map[2][6], dead, won);
						end
					else if (hc >= (hbp+560) && hc < (hbp+640))
						begin
							showColorValue(2, 7, cursorX, cursorY, blink_flag, clicked[2][7], map[2][7], dead, won);
						end
					// we're outside active horizontal range so display black
					else
						begin
							showColorValue(0, 0, 0, 0, 1, 0, 9, 0, 0);
						end
				end
			//row 4
			else if (vc >= (vbp+180) && vc < (vbp+240))
				begin
					if (hc >= hbp && hc < (hbp+80))
						begin
							showColorValue(3, 0, cursorX, cursorY, blink_flag, clicked[3][0], map[3][0], dead, won);
						end
					else if (hc >= (hbp+80) && hc < (hbp+160))
						begin
							showColorValue(3, 1, cursorX, cursorY, blink_flag, clicked[3][1], map[3][1], dead, won);
						end
					else if (hc >= (hbp+160) && hc < (hbp+240))
						begin
							showColorValue(3, 2, cursorX, cursorY, blink_flag, clicked[3][2], map[3][2], dead, won);
						end
					else if (hc >= (hbp+240) && hc < (hbp+320))
						begin
							showColorValue(3, 3, cursorX, cursorY, blink_flag, clicked[3][3], map[3][3], dead, won);
						end
					else if (hc >= (hbp+320) && hc < (hbp+400))
						begin
							showColorValue(3, 4, cursorX, cursorY, blink_flag, clicked[3][4], map[3][4], dead, won);
						end
					else if (hc >= (hbp+400) && hc < (hbp+480))
						begin
							showColorValue(3, 5, cursorX, cursorY, blink_flag, clicked[3][5], map[3][5], dead, won);
						end
					else if (hc >= (hbp+480) && hc < (hbp+560))
						begin
							showColorValue(3, 6, cursorX, cursorY, blink_flag, clicked[3][6], map[3][6], dead, won);
						end
					else if (hc >= (hbp+560) && hc < (hbp+640))
						begin
							showColorValue(3, 7, cursorX, cursorY, blink_flag, clicked[3][7], map[3][7], dead, won);
						end
					// we're outside active horizontal range so display black
					else
						begin
							showColorValue(0, 0, 0, 0, 1, 0, 9, 0, 0);
						end
				end
			//row 5
			else if (vc >= (vbp+240) && vc < (vbp+300))
				begin
					if (hc >= hbp && hc < (hbp+80))
						begin
							showColorValue(4, 0, cursorX, cursorY, blink_flag, clicked[4][0], map[4][0], dead, won);
						end
					else if (hc >= (hbp+80) && hc < (hbp+160))
						begin
							showColorValue(4, 1, cursorX, cursorY, blink_flag, clicked[4][1], map[4][1], dead, won);
						end
					else if (hc >= (hbp+160) && hc < (hbp+240))
						begin
							showColorValue(4, 2, cursorX, cursorY, blink_flag, clicked[4][2], map[4][2], dead, won);
						end
					else if (hc >= (hbp+240) && hc < (hbp+320))
						begin
							showColorValue(4, 3, cursorX, cursorY, blink_flag, clicked[4][3], map[4][3], dead, won);
						end
					else if (hc >= (hbp+320) && hc < (hbp+400))
						begin
							showColorValue(4, 4, cursorX, cursorY, blink_flag, clicked[4][4], map[4][4], dead, won);
						end
					else if (hc >= (hbp+400) && hc < (hbp+480))
						begin
							showColorValue(4, 5, cursorX, cursorY, blink_flag, clicked[4][5], map[4][5], dead, won);
						end
					else if (hc >= (hbp+480) && hc < (hbp+560))
						begin
							showColorValue(4, 6, cursorX, cursorY, blink_flag, clicked[4][6], map[4][6], dead, won);
						end
					else if (hc >= (hbp+560) && hc < (hbp+640))
						begin
							showColorValue(4, 7, cursorX, cursorY, blink_flag, clicked[4][7], map[4][7], dead, won);
						end
					// we're outside active horizontal range so display black
					else
						begin
							showColorValue(0, 0, 0, 0, 1, 0, 9, 0, 0);
						end
				end
			//row 6
			else if (vc >= (vbp+300) && vc < (vbp+360))
				begin
					if (hc >= hbp && hc < (hbp+80))
						begin
							showColorValue(5, 0, cursorX, cursorY, blink_flag, clicked[5][0], map[5][0], dead, won);
						end
					else if (hc >= (hbp+80) && hc < (hbp+160))
						begin
							showColorValue(5, 1, cursorX, cursorY, blink_flag, clicked[5][1], map[5][1], dead, won);
						end
					else if (hc >= (hbp+160) && hc < (hbp+240))
						begin
							showColorValue(5, 2, cursorX, cursorY, blink_flag, clicked[5][2], map[5][2], dead, won);
						end
					else if (hc >= (hbp+240) && hc < (hbp+320))
						begin
							showColorValue(5, 3, cursorX, cursorY, blink_flag, clicked[5][3], map[5][3], dead, won);
						end
					else if (hc >= (hbp+320) && hc < (hbp+400))
						begin
							showColorValue(5, 4, cursorX, cursorY, blink_flag, clicked[5][4], map[5][4], dead, won);
						end
					else if (hc >= (hbp+400) && hc < (hbp+480))
						begin
							showColorValue(5, 5, cursorX, cursorY, blink_flag, clicked[5][5], map[5][5], dead, won);
						end
					else if (hc >= (hbp+480) && hc < (hbp+560))
						begin
							showColorValue(5, 6, cursorX, cursorY, blink_flag, clicked[5][6], map[5][6], dead, won);
						end
					else if (hc >= (hbp+560) && hc < (hbp+640))
						begin
							showColorValue(5, 7, cursorX, cursorY, blink_flag, clicked[5][7], map[5][7], dead, won);
						end
					// we're outside active horizontal range so display black
					else
						begin
							showColorValue(0, 0, 0, 0, 1, 0, 9, 0, 0);
						end
				end
			//row 7
			else if (vc >= (vbp+360) && vc < (vbp+420))
				begin
					if (hc >= hbp && hc < (hbp+80))
						begin
							showColorValue(6, 0, cursorX, cursorY, blink_flag, clicked[6][0], map[6][0], dead, won);
						end
					else if (hc >= (hbp+80) && hc < (hbp+160))
						begin
							showColorValue(6, 1, cursorX, cursorY, blink_flag, clicked[6][1], map[6][1], dead, won);
						end
					else if (hc >= (hbp+160) && hc < (hbp+240))
						begin
							showColorValue(6, 2, cursorX, cursorY, blink_flag, clicked[6][2], map[6][2], dead, won);
						end
					else if (hc >= (hbp+240) && hc < (hbp+320))
						begin
							showColorValue(6, 3, cursorX, cursorY, blink_flag, clicked[6][3], map[6][3], dead, won);
						end
					else if (hc >= (hbp+320) && hc < (hbp+400))
						begin
							showColorValue(6, 4, cursorX, cursorY, blink_flag, clicked[6][4], map[6][4], dead, won);
						end
					else if (hc >= (hbp+400) && hc < (hbp+480))
						begin
							showColorValue(6, 5, cursorX, cursorY, blink_flag, clicked[6][5], map[6][5], dead, won);
						end
					else if (hc >= (hbp+480) && hc < (hbp+560))
						begin
							showColorValue(6, 6, cursorX, cursorY, blink_flag, clicked[6][6], map[6][6], dead, won);
						end
					else if (hc >= (hbp+560) && hc < (hbp+640))
						begin
							showColorValue(6, 7, cursorX, cursorY, blink_flag, clicked[6][7], map[6][7], dead, won);
						end
					// we're outside active horizontal range so display black
					else
						begin
							showColorValue(0, 0, 0, 0, 1, 0, 9, 0, 0);
						end
				end
			// row 8
			else if (vc >= (vbp+420) && vc < (vbp+480))
				begin
					if (hc >= hbp && hc < (hbp+80))
						begin
							showColorValue(7, 0, cursorX, cursorY, blink_flag, clicked[7][0], map[7][0], dead, won);
						end
					else if (hc >= (hbp+80) && hc < (hbp+160))
						begin
							showColorValue(7, 1, cursorX, cursorY, blink_flag, clicked[7][1], map[7][1], dead, won);
						end
					else if (hc >= (hbp+160) && hc < (hbp+240))
						begin
							showColorValue(7, 2, cursorX, cursorY, blink_flag, clicked[7][2], map[7][2], dead, won);
						end
					else if (hc >= (hbp+240) && hc < (hbp+320))
						begin
							showColorValue(7, 3, cursorX, cursorY, blink_flag, clicked[7][3], map[7][3], dead, won);
						end
					else if (hc >= (hbp+320) && hc < (hbp+400))
						begin
							showColorValue(7, 4, cursorX, cursorY, blink_flag, clicked[7][4], map[7][4], dead, won);
						end
					else if (hc >= (hbp+400) && hc < (hbp+480))
						begin
							showColorValue(7, 5, cursorX, cursorY, blink_flag, clicked[7][5], map[7][5], dead, won);
						end
					else if (hc >= (hbp+480) && hc < (hbp+560))
						begin
							showColorValue(7, 6, cursorX, cursorY, blink_flag, clicked[7][6], map[7][6], dead, won);
						end
					else if (hc >= (hbp+560) && hc < (hbp+640))
						begin
							showColorValue(7, 7, cursorX, cursorY, blink_flag, clicked[7][7], map[7][7], dead, won);
						end
					// we're outside active horizontal range so display black
					else
						begin
							showColorValue(0, 0, 0, 0, 1, 0, 9, 0, 0);
						end
				end
					
			// we're outside active vertical range so display black
			else
				begin
					showColorValue(0, 0, 0, 0, 1, 0, 9, 0, 0);
				end
		end




	task showColorValue;
		input [2:0] xpos;
		input [2:0] ypos;
		input [2:0] c_x;
		input [2:0] c_y;
		input blink;
		input clicked;
		input [3:0] value;
		input dead;
		input won;
	begin

		// cursor not on clicked square, or cursor on clicked square and not blinking
		if (( !(xpos == c_x && ypos == c_y) || 
				(xpos == c_x && ypos == c_y && !blink)) && clicked && !dead && !won) 
			begin
				case (value)
					4'h0:	begin // 0 white
								red = 3'b111;
								green = 3'b111;
								blue =  2'b11;
							end
					4'h1:	begin // 1 red
								red = 3'b111;
								green = 3'b000;
								blue =  2'b00;
							end
					4'h2:	begin // 2 orange
								red = 3'b111;
								green = 3'b011;
								blue =  2'b00;
							end
					4'h3:	begin // 3 yellow
								red = 3'b111;
								green = 3'b111;
								blue =  2'b00;
							end
					4'h4:	begin // 4 green
								red = 3'b000;
								green = 3'b111;
								blue =  2'b00;
							end
					4'h5:	begin // 5 cyan
								red = 3'b000;
								green = 3'b111;
								blue =  2'b11;
							end
					4'h6:	begin // 6 blue
								red = 3'b000;
								green = 3'b000;
								blue =  2'b11;
							end
					4'h7:	begin // 7 magenta
								red = 3'b111;
								green = 3'b000;
								blue =  2'b11;
							end
					4'h8:	begin // 8 purple
								red = 3'b011;
								green = 3'b000;
								blue =  2'b11;
							end
					4'h9:	begin // mine - black
								red = 3'b000;
								green = 3'b000;
								blue =  2'b00;
							end

					default:	begin // any other value - show black bc probably mine
								red = 3'b000;
								green = 3'b000;
								blue =  2'b00;
							end
				endcase
			end
			
		// cursor not on hidden square, or cursor on hidden square and not blinking
		else if (( !(xpos == c_x && ypos == c_y) || 
				(xpos == c_x && ypos == c_y && !blink)) && !clicked && !dead && !won) 
			begin // show gray
				red = 3'b110;
				green = 3'b110;
				blue =  2'b11;
			end

		// cursor on this square, and we are blinking
		else if ( xpos == c_x && ypos == c_y && blink && !dead && !won)
			begin // show black
				red = 3'b000;
				green = 3'b000;
				blue =  2'b00;
			end
		else if (dead)
			begin // red screen of death
				red = 3'b111;
				green = 3'b000;
				blue = 2'b00;
			end
		else if (!dead && won)
			begin // green screen of winners
				red = 3'b000;
				green = 3'b111;
				blue = 2'b00;
			end
	end
	endtask

endmodule
