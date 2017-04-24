`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:02:43 02/20/2017 
// Design Name: 
// Module Name:    debouncer 
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
module debouncer(
	// INPUT
	clk, button, rst,
	// OUTPUT
	btn_posedge
    );
	 
	 input clk;
	 input button;
	 input rst;
	 
	 output btn_posedge;
	 
   wire [17:0] clk_dv_inc;

   reg [16:0]  clk_dv = 0;
   reg         clk_en = 0;
   reg         clk_en_d = 0;
      
   reg         inst_vld = 0;
   reg [2:0]   step_d = 0;

	assign btn_posedge = inst_vld;
	   

   // ===========================================================================
   // 763Hz timing signal for clock enable
   // ===========================================================================

   assign clk_dv_inc = clk_dv + 1;
   
   always @ (posedge clk)
     if (rst)
       begin
          clk_dv   <= 0;
          clk_en   <= 1'b0;
          clk_en_d <= 1'b0;
       end
     else
       begin
          clk_dv   <= clk_dv_inc[16:0];
          clk_en   <= clk_dv_inc[17];
          clk_en_d <= clk_en;
       end
   
   // ===========================================================================
   // Instruction Stepping Control
   // ===========================================================================

   always @ (posedge clk)
     if (rst)
       begin
          step_d[2:0]  <= 0;
       end
     else if (clk_en)
       begin
          step_d[2:0]  <= {button, step_d[2:1]};
       end

   always @ (posedge clk)
     if (rst)
       inst_vld <= 1'b0;
     else
       inst_vld <= ~step_d[0] & step_d[1] & clk_en_d;

		
endmodule
