`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:50:26 12/13/2023 
// Design Name: 
// Module Name:    clockFSM 
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
module clockFSM(
	input clk,
    input set,
    input reset,
	 input mode,
	 input down,
	 output reg [2:0] num,
	 output reg sel1
    );
	 
	
	 reg [3:0] next;
	 parameter s0 = 4'b0000;
	 parameter s1 = 4'b0001;
	 parameter s2 = 4'b0010;
	 parameter s3 = 4'b0011;
	 parameter s4 = 4'b1000;
	 parameter s5 = 4'b1001;

	 
	 reg [3:0] state=s0;
	 
	 always @(posedge clk or posedge reset) begin
		if (reset) state <= s0;
		else if (mode) begin
			if (state == s0 || state == s1 || state == s2 ||state == s3 || state == s4) state <= s0;
		end
		else if (down) state <= next;

	end
	
	always @(*) begin
		case (state)
			s0 : next = s1;
			s1 : next = s2;
			s2 : next = s3;
			s3 : next = s4;
			s4 : next = s5;
			s5 : next = s0;
		endcase
	end
	always @(*) begin
		case (state)
			s0 : num = 3'b000;
			s1 : num = 3'b001;
			s2 : num = 3'b010;
			s3 : num = 3'b011;
			s4 : num = 3'b100;
			s5 : num = 3'b101;
		endcase
	end
	
	
	
	always @(*) begin
		case (state) 
			s0,s1,s2,s3,s4,s5 : sel1 = 1;
		endcase
	end
	

endmodule

