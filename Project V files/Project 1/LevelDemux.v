`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:13:07 12/15/2023 
// Design Name: 
// Module Name:    LevelDemux 
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
module LevelDemux(
    input [2:0] level,
    output reg [6:0] d
    );
	 
	 always @(*) begin
		case (level)
			0 : d = 7'b0110000;
			1 : d = 7'b1101101;
			2 : d = 7'b1111001;
			3 : d = 7'b0110011;
			4 : d = 7'b1011011;
		endcase
	end


endmodule
