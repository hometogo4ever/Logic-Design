`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:19:08 12/13/2023 
// Design Name: 
// Module Name:    decimal 
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
module decimal(
	input [6:0] n,
	output reg [3:0] ten,
	output reg [3:0] one,
	input lz
    );
	 
	 always @(*) begin
		if (lz & n==0) begin
			ten = 10;
			one = 10;
		end
		else if (n == 127) begin
			ten = 15;
			one = 15;
		end
		else begin
			if (n >= 90) ten = 9;
			else if (n >= 90) ten = 9;
			else if (n >= 80) ten = 8;
			else if (n >= 70) ten = 7;
			else if (n >= 60) ten = 6;
			else if (n >= 50) ten = 5;
			else if (n >= 40) ten = 4;
			else if (n >= 30) ten = 3;
			else if (n >= 20) ten = 2;
			else if (n >= 10) ten = 1;
			else ten = (lz)?10:0;
			one = (ten==10)?n:(n - (ten*10));
		end
	end

endmodule
