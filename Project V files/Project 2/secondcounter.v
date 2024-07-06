`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:16:32 12/13/2023 
// Design Name: 
// Module Name:    secondcounter 
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
module secondcounter(
    input clk,
    output reg newclk
    );
	 initial begin
		newclk = 0;
	end
	 reg [25:0] counter = 0;
	 parameter N = 25000000;
	 
	 always @(posedge clk) begin
		counter <= counter + 1;
		if (counter == N) begin
			newclk <= !newclk;
			counter <= 0;
		end
	end


endmodule
