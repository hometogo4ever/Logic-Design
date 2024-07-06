`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:35:42 12/15/2023 
// Design Name: 
// Module Name:    ClockAdjust 
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
module ClockAdjust(
    input CLK,
	 input [2:0] level,
    output reg CLKOUT
    );
	 reg [5:0] cnt = 0;
	 always @(posedge CLK) begin
		if (!CLKOUT) begin
			cnt = cnt + 1;
			if (cnt == 30) begin
				CLKOUT = 1;
				cnt = 0;
			end
		end
		else if (CLKOUT) begin
			cnt = cnt + 1;
			if (cnt == (level+1)*11) begin
				cnt = 0;
				CLKOUT = 0;
			end
		end
	end


endmodule
