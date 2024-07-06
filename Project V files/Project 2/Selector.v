`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:28:23 12/13/2023 
// Design Name: 
// Module Name:    Selector 
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
module Selector(
	input mode,
    input [6:0] ih,
    input [6:0] im,
    input [6:0] is,
    input [6:0] h,
    input [6:0] m,
    input [6:0] s,
    input pulse,
    input clockon,
    input hset,
    input mset,
    input sset,
	 input iscal,
    output [6:0] d1,
    output [6:0] d2,
    output [6:0] d3,
    output [6:0] d4,
    output [6:0] d5,
    output [6:0] d6
    );
	 
	 wire [6:0] o11;
	 wire [6:0] o12;
	 wire [6:0] o13;
	 wire [6:0] o14;
	 wire [6:0] o15;
	 wire [6:0] o16;
	 
	 wire [6:0] o21;
	 wire [6:0] o22;
	 wire [6:0] o23;
	 wire [6:0] o24;
	 wire [6:0] o25;
	 wire [6:0] o26;
	 wire [6:0] nh;
	 wire [6:0] nih;
	 wire [6:0] o16p;
	 wire [6:0] o26p;
	 
	 Converter1224 c1 (h, nh, mode);
	 Converter1224 c2 (ih, nih, mode);
			
	 
	 DecConverter dh (nh, 0,o11, o12, 0);
	 DecConverter dm (m+iscal,0, o13, o14, 0);
	 DecConverter ds (s+iscal,0, o15, o16, 0);
	 
	 DecConverter dih (nih,0, o21, o22, pulse&hset);
	 DecConverter dim (im+iscal,0, o23, o24, pulse&mset);
	 DecConverter dis (is+iscal,0, o25, o26, pulse&sset);
	 
	 assign o16p = (h > 11) ? 7'b1100111 : 7'b1110111;
	 assign o26p = (ih > 11) ? 7'b1100111 : 7'b1110111;
	 
	 assign d1 = clockon ? o11 : o21;
	 assign d2 = clockon ? o12 : o22;
	 assign d3 = clockon ? o13 : o23;
	 assign d4 = clockon ? o14 : o24;
	 assign d5 = clockon ? (mode?7'b0000000:o15) : (mode?7'b0000000:o25);
	 assign d6 = clockon ? (mode?o16p:o16) : (mode?o26p:o26);
	 
	 

endmodule
