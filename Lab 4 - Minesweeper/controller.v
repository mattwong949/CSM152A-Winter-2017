`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:17:10 03/01/2017 
// Design Name: 
// Module Name:    controller 
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
module controller(
	// INPUT
	clk, btnU, btnD, btnL, btnR, btnS, sw,
	// OUTPUT
	up_valid, down_valid, left_valid, right_valid, center_valid
    );
	 
	input clk;
	input btnU; // up button
	input btnD; // down button
	input btnL; // left button
	input btnR; // right button
	input btnS; // center button
	input sw; // switch (reset toggle)
	
	output up_valid;
	output down_valid;
	output left_valid;
	output right_valid;
	output center_valid;	
	
	
	btn_debouncer up_btn(
		// INPUT
		.clk(clk), 
		.button(btnU), 
		.rst(sw),
		
		// OUTPUT
		.btn_posedge(up_valid)
   );
	
	btn_debouncer down_btn(
		// INPUT
		.clk(clk), 
		.button(btnD), 
		.rst(sw),
		
		// OUTPUT
		.btn_posedge(down_valid)
   );
	
	btn_debouncer left_btn(
		// INPUT
		.clk(clk), 
		.button(btnL), 
		.rst(sw),
		
		// OUTPUT
		.btn_posedge(left_valid)
   );
	
	btn_debouncer right_btn(
		// INPUT
		.clk(clk), 
		.button(btnR), 
		.rst(sw),
		
		// OUTPUT
		.btn_posedge(right_valid)
   );
	
	btn_debouncer center_btn(
		// INPUT
		.clk(clk), 
		.button(btnS), 
		.rst(sw),
		
		// OUTPUT
		.btn_posedge(center_valid)
   );




endmodule
