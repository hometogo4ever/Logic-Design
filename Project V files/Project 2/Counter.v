`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:43:44 12/13/2023 
// Design Name: 
// Module Name:    Counter 
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
module Counter(
	input on,
    input clk,
    input [6:0] max,
    input reset,
    input set,
    input [6:0] data_in,
    output [6:0] data_out,
    output reg rco
    );
	 reg [6:0] cnt=0;
		
		always @(posedge clk or posedge reset or posedge set) begin
			if (reset) begin
				rco <= 0;
				cnt <= 0;
			end
			else if (set) begin
				cnt <= data_in;
			end
			else begin
				if (on) begin
					rco <= 0;
					cnt <= cnt + 1;
					if (cnt == max) begin
						rco <= 1;
						cnt <= 0;
					end
				end
			end
		end
		assign data_out = cnt;
			

endmodule
