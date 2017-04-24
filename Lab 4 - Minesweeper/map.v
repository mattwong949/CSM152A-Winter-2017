`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:56:57 03/01/2017 
// Design Name: 
// Module Name:    map 
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
module map(
    );




	reg [3:0] squares[0:7][0:7]; // values for the squares: 0 - 8 for numbers, 9 is mine
	
	// 0 for unclicked, 1 for clicked
	reg [3:0] clicked[0:7][0:7] = '{'{0,0,0,0},'{0,0,0,0}};; 

endmodule
