`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:50:47 12/15/2023 
// Design Name: 
// Module Name:    pausedisplay 
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
module pausedisplay(
	 input [2:0] num,
    input [6:0] m,
    input [6:0] s,
    input [6:0] sms,
    input [20:0] dat1,
    input [20:0] dat2,
    input [20:0] dat3,
    input [20:0] dat4,
    input [20:0] dat5,
	 input pulse,
    input o1,
    input o2,
    input o3,
    input o4,
    input o5,
	 output [6:0] d1,
	 output [6:0] d2,
	 output [6:0] d3,
	 output [6:0] d4,
	 output [6:0] d5,
	 output [6:0] d6,
	 output reg [5:0] led
	 );
	 reg [2:0] cnt = 0;
	 reg [20:0] select = 0;
	 wire [6:0] w1;
	 wire [6:0] w2;
	 wire [6:0] w3;
	 reg lz;
	 wire [20:0] def;
	 assign def = 21'b111111111111111111111;
	 always @(*) begin
		case (num)
			0 : 
				begin
				led = {pulse, !o1, !o2, !o3, !o4, !o5};
				select = {m, s, sms};
				lz = 1;
				end
			1 : 
				
				begin
				led = 6'b010000;
				select = o1?def:dat1;
				lz = 0;
				end
			2 : 
				begin
				led = 6'b001000;
				select = o2?def:dat2;
				lz = 0;
				end
			3 : 
				begin
				led = 6'b000100;
				select = o3?def:dat3;
				lz = 0;
				end
			4 : 
				begin
				led = 6'b000010;
				select = o4?def:dat4;
				lz = 0;
				end
			5 : 
				begin
				led = 6'b000001;
				select = o5?def:dat5;
				lz = 0;
				end
		endcase
	end
	assign w1 = select[20:14];
	assign w2 = select[13:7];
	assign w3 = select[6:0];
	wire lzw;
	assign lzw = lz;
	StopwatchDisplay swd (w3, w2, w1, d1, d2, d3, d4, d5, d6, lzw);
	
	
	 
	 


endmodule
