`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:50:58 12/14/2023 
// Design Name: 
// Module Name:    Converter1224 
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
module Converter1224(
    input [6:0]  n,
    output reg [6:0] nh,
    input mode
    );
	 
	 always @(*) begin
		 if (mode) begin
			if (n == 0) nh = 12; 
			else if (n >12) nh = n-12;
			else nh = n;
		end
		else nh = n;
	end


endmodule
