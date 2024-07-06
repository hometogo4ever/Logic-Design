`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:15:23 12/14/2023 
// Design Name: 
// Module Name:    leddemux 
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
module leddemux(
    input [6:0] n,
    output reg [5:0] l,
    input pulse
    );
	 
	 always @(*) begin
		if (~pulse) begin
			case (n)
				0 : l = 6'b100000;
				1 : l = 6'b010000;
				2 : l = 6'b001000;
				3 : l = 6'b000100;
				4 : l = 6'b000010;
				5 : l = 6'b000001;
				6 : l = 6'b111111;
				default : l = 6'b000000;
			endcase
		end
		else l = 6'b000000;
	end


endmodule
