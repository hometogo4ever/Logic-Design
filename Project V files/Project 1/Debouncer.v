`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:05:52 12/13/2023 
// Design Name: 
// Module Name:    Debouncer 
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
module Debouncer(
    input clk,
    input data_in,
    output reg data_out
    );
	 
	 reg [19:0] counter = 19'b0;
	 
	 parameter N =500000;
	 always @(posedge clk) begin
		if (!data_in) begin
			counter <= 0;
		end
		else if (counter < N) begin
			counter <= counter + 1;
		end
		
		data_out = (counter >= N);
	end


endmodule
