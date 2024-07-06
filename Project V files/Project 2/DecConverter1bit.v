`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:14:20 12/13/2023 
// Design Name: 
// Module Name:    DecConverter1bit 
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
module DecConverter1bit(
    input [3:0] n,
    input on,
    output reg [6:0] d
    );
	 
	always @(*) begin
		if (~on) begin
			case (n)
				0 : d = 7'b1111110;
				1 : d = 7'b0110000;
				2 : d = 7'b1101101;
				3 : d = 7'b1111001;
				4 : d = 7'b0110011;
				5 : d = 7'b1011011;
				6 : d = 7'b1011111;
				7 : d = 7'b1110010;
				8 : d = 7'b1111111;
				9 : d = 7'b1111011;
				default : d = 7'b0000000;
			endcase
		end
		else d = 7'b0000000;
	end


endmodule
