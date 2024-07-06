`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:54:31 12/15/2023 
// Design Name: 
// Module Name:    h1224adj 
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
module ModeCounter (
	 input on,
    input clk,
    input rst,
	 input set,
    output reg c
	);
	
	initial begin
		c = 0;
	end
    always @(posedge clk or posedge rst) begin
        if (rst) c <= 0;
        else if (set & on) c <= ~c;
    end


endmodule
