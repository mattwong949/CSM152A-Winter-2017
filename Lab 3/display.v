`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:10:37 02/17/2017 
// Design Name: 
// Module Name:    display 
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
module display(
	// INPUT
	fast_clock, blink_clock, seconds_ones, seconds_tens, minutes_ones, minutes_tens, select, adjust,

	// OUTPUT
	anode, segment
    );

	input fast_clock;
	input blink_clock;
	
	input [3:0] seconds_ones;
	input [3:0] seconds_tens;
	input [3:0] minutes_ones;
	input [3:0] minutes_tens;
	
	input select; // 0 for seconds, 1 for minutes
	input adjust; // 0 for normal mode, 1 for adjust mode
	
	output reg [3:0] anode = 4'b1110;
	output reg [7:0] segment = 8'b11000000;
	
	reg blink_flag = 0;
	
	integer counter = 0;
	
	
	always @(posedge blink_clock)
		begin
			blink_flag <= ~blink_flag;
		end
	

	always @(posedge fast_clock)
		begin
			// normal mode
			if (adjust == 0)
				begin
					if (counter == 0)
						begin
							anode <= 4'b1110;
							printDigit(seconds_ones);
						
							counter <= 1;
						end
						
					else if (counter == 1)
						begin
							anode <= 4'b1101;
							printDigit(seconds_tens);
						
							counter <= 2;
						end
						
					else if (counter == 2)
						begin
							anode <= 4'b1011;
							printDigit(minutes_ones);
						
							counter <= 3;
						end
						
					else if (counter == 3)
						begin
							anode <= 4'b0111;
							printDigit(minutes_tens);
						
							counter <= 0;
						end
				end
				
			// adjust mode - seconds
			else if (adjust == 1 && ~select)
				begin
					if (counter == 0)
						begin
							anode <= 4'b1110;
							
							if (blink_flag)
								printDigit(seconds_ones);
							else
								printDigit(4'b1111);
						
							counter <= 1;
						end
						
					else if (counter == 1)
						begin
							anode <= 4'b1101;
							
							if (blink_flag)
								printDigit(seconds_tens);
							else
								printDigit(4'b1111);
						
							counter <= 2;
						end
						
					else if (counter == 2)
						begin
							anode <= 4'b1011;
							printDigit(minutes_ones);
						
							counter <= 3;
						end
						
					else if (counter == 3)
						begin
							anode <= 4'b0111;
							printDigit(minutes_tens);
						
							counter <= 0;
						end
				end
						
			// adjust mode - minutes
			else if (adjust == 1 && select)
				begin
					if (counter == 0)
						begin
							anode <= 4'b1110;
							printDigit(seconds_ones);
						
							counter <= 1;
						end
						
					else if (counter == 1)
						begin
							anode <= 4'b1101;
							printDigit(seconds_tens);
						
							counter <= 2;
						end
						
					else if (counter == 2)
						begin
							anode <= 4'b1011;
							if (blink_flag)
								printDigit(minutes_ones);
							else
								printDigit(4'b1111);
							
							counter <= 3;
						end
						
					else if (counter == 3)
						begin
							anode <= 4'b0111;
							if (blink_flag)
								printDigit(minutes_tens);
							else
								printDigit(4'b1111);
						
							counter <= 0;
						end
				end
		end

task printDigit;
	input [3:0] digit;
begin
	case (digit)
		4'h0: segment <= 8'b11000000;
		4'h1: segment <= 8'b11111001;
		4'h2: segment <= 8'b10100100;
		4'h3: segment <= 8'b10110000;
		4'h4: segment <= 8'b10011001;
		4'h5: segment <= 8'b10010010;
		4'h6: segment <= 8'b10000010;
		4'h7: segment <= 8'b11111000;
		4'h8: segment <= 8'b10000000;
		4'h9: segment <= 8'b10010000;
		default: segment <= 8'b11111111;
	endcase
end
endtask

endmodule
