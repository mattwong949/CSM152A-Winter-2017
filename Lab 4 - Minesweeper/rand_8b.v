`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:13:31 03/01/2017 
// Design Name: 
// Module Name:    rand_8b 
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
module rand_8b(
	// INPUT
	clk,
	// OUTPUT
	number
	);

	input clk;
	
	output [7:0] number;
	
	reg [7:0] num_reg = 8'b11000101; // seed can change
	assign number = num_reg;
	
	wire [7:0] next_num;
	wire feedback;
	
	assign feedback = ~(num_reg[7] ^ num_reg[5] ^ num_reg[4] ^ num_reg[3]); // generate random bit
	assign next_num = { num_reg[6:0], feedback }; // shift in the new random bit

	always @ (posedge clk)
		begin
			num_reg <= next_num;
		end

endmodule
