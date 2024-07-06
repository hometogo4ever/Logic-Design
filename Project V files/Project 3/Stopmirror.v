`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:24:57 12/15/2023 
// Design Name: 
// Module Name:    Stopmirror 
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
module Stopmirror(
    input i,
    output o,
	 input sms,
	 input s,
	 input m
    );
	 reg og = 1;
	 reg oy = 1;
	 always @(posedge i) begin
		og <= ~og;
	end
	always @(*) begin
		if (sms == 99 & s == 59 & m == 59) oy = 0;
	end
	assign o = og & oy;

endmodule
