`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:12:26 12/15/2023 
// Design Name: 
// Module Name:    Maximum 
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
module Maximum(
    input [6:0] y,
    input [3:0] mon,
    output reg [4:0] max
    );
	 reg ext;
	 always @(*) begin
		if (y !=0 & !y[0] & !y[1]) ext = 1;
		else ext = 0;
		case (mon)
			0, 2, 4, 6, 7, 9, 11 : max = 30;
			3, 5, 8, 10 : max = 29;
			1 : max = 27 + ext;
		endcase
	end


endmodule
