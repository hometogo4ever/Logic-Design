`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:30:06 12/15/2023 
// Design Name: 
// Module Name:    MiliSecondCount 
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
module MiliSecondCount(
    input clk,
    output reg newclk
    );
	 initial begin
		newclk = 0;
	end
	 reg [17:0] counter = 0;
	 parameter N = 250000;
	 
	 always @(posedge clk) begin
		counter <= counter + 1;
		if (counter == N) begin
			newclk <= !newclk;
			counter <= 0;
		end
	end


endmodule
