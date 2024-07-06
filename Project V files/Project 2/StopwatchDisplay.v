`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:32:59 12/15/2023 
// Design Name: 
// Module Name:    StopwatchDisplay 
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
module StopwatchDisplay(
    input [6:0] sms,
    input [6:0] s,
    input [6:0] m,
    output [6:0] d1,
    output [6:0] d2,
    output [6:0] d3,
    output [6:0] d4,
    output [6:0] d5,
    output [6:0] d6
    );
	 
	 DecConverter dc1 (m,1, d1, d2, 0);
	 DecConverter dc2 (s,1, d3, d4, 0);
	 DecConverter dc3 (sms,0, d5, d6, 0);
	 
	 
	 
	 


endmodule
