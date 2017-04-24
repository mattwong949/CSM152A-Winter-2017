`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:27:04 02/13/2017 
// Design Name: 
// Module Name:    stopwatch 
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
module stopwatch(
	//INPUT
	clk, sw, btnS, btnR,
	
	//OUTPUT
	seg, an
   );
	 
	input clk;		// 100 MHz

   // Nexus3 Input/Output
	
   input  [1:0] sw; // select which is T9 sw[1], adjust which is T10 sw[0]
	input  btnS; // pause
   input  btnR; // reset
	
   output [7:0] seg;
	output [3:0] an;
	

	 /* clock wires */
	 wire t2Hz_clk_wire;
	 wire t1Hz_clk_wire;
	 wire fast_clk_wire;
	 wire adjust_clk_wire;
	 
	 /* time values */
	 wire [3:0] seconds_tens;
	 wire [3:0] seconds_ones;
	 wire [3:0] minutes_tens;
	 wire [3:0] minutes_ones;
	 
	 /* debouncer posedge wires */
	 wire pause_button_posedge;
	 
	display led_display(
		// INPUT
		.fast_clock(fast_clk_wire),
		.blink_clock(adjust_clk_wire), 
		.seconds_ones(seconds_ones), 
		.seconds_tens(seconds_tens), 
		.minutes_ones(minutes_ones), 
		.minutes_tens(minutes_tens), 
		.select(sw[1]), 
		.adjust(sw[0]),

		// OUTPUT
		.anode(an), 
		.segment(seg)
    );
		 
	clocks clocks_stopwatch(
		//INPUT
		.master(clk), 
		.rst(btnR),
		
		//OUTPUT
		.t2Hz(t2Hz_clk_wire), 
		.t1Hz(t1Hz_clk_wire), 
		.fast(fast_clk_wire), 
		.adjust(adjust_clk_wire)
	);
			 
	mod60counter counter(
		//INPUT
		.clk_1Hz(t1Hz_clk_wire), 
		.clk_2Hz(t2Hz_clk_wire), 
		.select(sw[1]), 
		.adjust(sw[0]), 
		.pause(pause_button_posedge), 
		.rst(btnR),

		//OUTPUT
		.seconds_ones(seconds_ones), 
		.seconds_tens(seconds_tens), 
		.minutes_ones(minutes_ones), 
		.minutes_tens(minutes_tens)
   );
	
	debouncer pause_button(
		// INPUT
		.clk(clk), 
		.button(btnS), 
		.rst(btnR), 
		
		// OUTPUT
		.btn_posedge(pause_button_posedge)
   );

endmodule
