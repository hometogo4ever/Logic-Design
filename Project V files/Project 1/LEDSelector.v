`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:12:40 12/14/2023 
// Design Name: 
// Module Name:    LEDSelector 
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
module LEDSelector(
	input [6:0] w,
	input [6:0] iw,
	input calenderon,
	input wset,
	output [5:0] led,
	input pulse
    );
	 wire [5:0] l1;
	 wire [5:0] l2;
	 leddemux lm (w, l1, 0);
	 leddemux lm2 (iw, l2, pulse&wset);
	 
	 assign led = (calenderon) ? l1 : l2;
	 
	 
	 
	 


endmodule
