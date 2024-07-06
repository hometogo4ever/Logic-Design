`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:58:11 12/15/2023 
// Design Name: 
// Module Name:    AlarmChecker 
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
module AlarmChecker(
	input CLK,
	input reset,
	input up,
	input sel,
	input clockon,
	input alarmon,
    input [6:0] h,
    input [6:0] alarmh,
    input [6:0] m,
    input [6:0] alarmm,
    input isalarm,
    output reg r=0
    );
	 
	 wire matched;
	 reg ext=1;
	 reg [6:0] temp=0; 
	 assign matched = (h == alarmh) & (m == alarmm) & isalarm & alarmon & ext;
	 
	always @(posedge CLK or posedge reset) begin
		if (reset) r = 0;
		else if (matched) begin
			r = 1;
		end
		else if (up & clockon & sel) begin
			r = 0;
			ext = 0;
			temp = m;
		end
		else if (m > temp) begin
			ext = 1;
			temp = m;
		end
	end
		
	 


endmodule
