`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:30:09 02/01/2017 
// Design Name: 
// Module Name:    rouding 
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
module rouding(
	//Input
	exp, sig, fifth,
	//Output
	E, F
    );

	input [2:0] exp;
	input [3:0] sig;
	input fifth;
	
	output reg [2:0] E;
	output reg [3:0] F;
	
	always @(*)
		begin
		
			if (exp == 3'b111 && sig == 4'b1111 && fifth == 1)
				begin
					E = exp;
					F = sig;
				end
			else
				begin
					if (fifth == 1)
						begin					
							if (sig == 4'b1111)
								begin
									F = 4'b1000;
									E = exp[2:0] + 1'b1;
								end
							else
								begin
									F = sig[3:0] + 1'b1;
									E = exp[2:0];
								end
						end
					else
						begin
							E = exp[2:0];
							F = sig[3:0];
						end
				end
		
		end

endmodule
