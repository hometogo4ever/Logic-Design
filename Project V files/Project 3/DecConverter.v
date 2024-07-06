`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:22:20 12/13/2023 
// Design Name: 
// Module Name:    DecConverter 
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
module DecConverter(
    input [6:0] n,
	 input lz,
    output [6:0] d1,
    output [6:0] d2,
    input pulse
    );
	 wire [3:0] ten;
	 wire [3:0] one;
	 
	 decimal de (n, ten, one, lz);
	 DecConverter1bit dec1 (ten, pulse, d1);
	 DecConverter1bit dec2 (one, pulse, d2);
	 
	 


endmodule
