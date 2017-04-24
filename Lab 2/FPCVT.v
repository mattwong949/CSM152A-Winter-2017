`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:08:50 02/01/2017 
// Design Name: 
// Module Name:    FPCVT 
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
module FPCVT(
	//Input
	D,
	//Output
	S, E, F
    );
	 
	input [11:0] D;
	
	output S;
	output [2:0] E;
	output [3:0] F;
	
	reg S_reg;
	reg [2:0] E_reg;
	reg [3:0] F_reg;
	
	// connect conversion block to counting blcok
	wire [10:0] c_m;
	
	// connect counting block to rouding block
	wire [2:0] r_exp;
	wire [3:0] r_sig;
	wire r_fifth;
	

	convert2toSM convert(.d(D), .s(S), .m(c_m));
	
	count_leading_zeros count(.d_i(c_m), .e(r_exp), .sig(r_sig), .f(r_fifth));

	rouding round(.exp(r_exp), .sig(r_sig), .fifth(r_fifth), .E(E), .F(F));
		
endmodule
