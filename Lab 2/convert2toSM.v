`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:10:55 01/30/2017 
// Design Name: 
// Module Name:    convert2toSM 
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
module convert2toSM(
	// Input
    d,
	// Output
    s, m
    );

	input 	[11:0] 	d;
	output reg			s;
	output reg [10:0]	m;

	always @(*)
		begin
			s = d[11];
			if (d[11:0] == 12'b100000000000)
				begin
					m = 11'b11111111111;
				end
			else if (d[11] == 1'b0)
				begin
					m = d[10:0];
				end
			else
				begin
					m = ~d[10:0] + 1;
				end
				
		end
		
endmodule
