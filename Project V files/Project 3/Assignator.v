`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:42:09 12/15/2023 
// Design Name: 
// Module Name:    Assignator 
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
module Assignator(
	input stopwatchon,
    input [6:0] m,
    input [6:0] s,
    input [6:0] sms,
    output reg [20:0] dat1,
    output reg [20:0] dat2,
    output reg [20:0] dat3,
    output reg [20:0] dat4,
    output reg [20:0] dat5,
    output o1,
    output o2,
    output o3,
    output o4,
    output o5,
    input what,
	 input reset,
	 input clear
    );
	 reg on1 = 1;
	 reg on2 = 1;
	 reg on3 = 1;
	 reg on4 = 1;
	 reg on5 = 1;
	 wire rst;
	 assign rst = reset | (clear & stopwatchon);
		
	always @(posedge what or posedge rst) begin
		if (rst) begin
			dat1 = 0;
			dat2 = 0;
			dat3 = 0;
			dat4 = 0;
			dat5 = 0;
			on1 = 1;
			on2 = 1;
			on3 = 1;
			on4 = 1;
			on5 = 1;
		end
		else if (on1) begin
			dat1 = {m, s, sms};
			on1 = 0;
		end
		else if (on2) begin
			dat2 = {m, s, sms};
			on2 = 0;
		end
		else if (on3) begin
			dat3 = {m, s, sms};
			on3 = 0;
		end
		else if (on4) begin
			dat4 = {m, s, sms};
			on4 = 0;
		end
		else if (on5) begin
			dat5 = {m, s, sms};
			on5 = 0;
		end
	end
	assign o1 = on1;
	assign o2 = on2;
	assign o3 = on3;
	assign o4 = on4;
	assign o5 = on5;
	
endmodule
