`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:57:15 02/01/2017 
// Design Name: 
// Module Name:    count_leading_zeros 
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
module count_leading_zeros(
	//Input
	d_i,
	//Output
	e, sig, f
    );

	input [10:0] d_i;
	
	reg [10:0] d;
	
	output reg [2:0] e;
	output reg [3:0] sig;
	output reg f;
	
	always @(*)
		begin
		
			d = d_i;

			if (d[10] == 1)
				begin
					e = 7;
					sig = d[10:7];
					f = d[6];
				end
			else if (d[9] == 1)
				begin
					e = 6;
					sig = d[9:6];
					f = d[5];
				end
			else if (d[8] == 1)
				begin
					e = 5;
					sig = d[8:5];
					f = d[4];
				end
			else if (d[7] == 1)
				begin
					e = 4;
					sig = d[7:4];
					f = d[3];
				end
			else if (d[6] == 1)
				begin
					e = 3;
					sig = d[6:3];
					f = d[2];
				end
			else if (d[5] == 1)
				begin
					e = 2;
					sig = d[5:2];
					f = d[1];
				end
			else if (d[4] == 1)
				begin
					e = 1;
					sig = d[4:1];
					f = d[0];
				end
			else
				begin
					e = 0;
					sig = d[3:0];
					f = 0;
				end
			
		end

endmodule
