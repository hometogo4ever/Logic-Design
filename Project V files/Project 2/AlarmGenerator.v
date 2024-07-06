`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:18:20 12/15/2023 
// Design Name: 
// Module Name:    AlarmGenerator 
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
module AlarmSelector(
    input isset,
    input [6:0] ih,
    input [6:0] im,
    input [6:0] h,
    input [6:0] m,
    input pulse,
    input clockon,
    input ahset,
    input amset,
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
	 
	 Converter1224 c1 (h, nh, 1);
	 Converter1224 c2 (ih, nih, 1);
			
	 
	 DecConverter dh (nh,0, o11, o12, 0);
	 DecConverter dm (m,0, o13, o14, 0);
	 
	 DecConverter dih (nih,0, o21, o22, pulse&ahset);
	 DecConverter dim (im,0, o23, o24, pulse&amset);
	 
	 assign o16 = (h > 11) ? 7'b1100111 : 7'b1110111;
	 assign o26 = (ih > 11) ? 7'b1100111 : 7'b1110111;
	 
	 wire [6:0] def = 7'b0000001;
	 
	 assign d1 = clockon?(!isset?def:o11):o21;
	 assign d2 = clockon?(!isset?def:o12):o22;
	 assign d3 = clockon?(!isset?def:o13):o23;
	 assign d4 = clockon?(!isset?def:o14):o24;
	 assign d5 = clockon?(!isset?def:7'b0000000):(7'b0000000);
	 assign d6 = clockon?(!isset?def:o16):o26;
	 
	 

endmodule
