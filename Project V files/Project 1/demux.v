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
	input h1224,
	input clk,
    input set,
    input reset,
	 input mode,
    output reg clockon,
	 output reg calenderon,
	 output reg hset,
    output reg mset,
	 output reg cset,
	 output reg yset,
    output reg monset,
    output reg dset,
	 output reg wset,
	 output reg calset,
	 output reg sel,
	 output reg sel2,
	 output reg displaymode
    );
	 
	
	 reg [3:0] next;
	 parameter s0 = 4'b0000;
	 parameter s1 = 4'b0001;
	 parameter s2 = 4'b0010;
	 parameter s4 = 4'b0100;
	 parameter s5 = 4'b0101;
	 parameter s6 = 4'b0110;
	 parameter s7 = 4'b0111;
	 parameter s8 = 4'b1000;
	 parameter s9 = 4'b1001;
	 
	 reg [3:0] state=s0;
	 
	 always @(posedge clk or posedge reset) begin
		if (reset) state <= s0;
		else if (mode) begin
			if (state == s0 || state == s1 || state == s2) state <= s4;
			if (state == s4 || state == s5 || state == s6 || state == s7 || state == s8) state <= s9;
			if (state == s9) state <= s0;
		end
		else if(set) state <= next;
	end
	
	always @(*) begin
		case (state)
			s0 :
				begin
				calset = 0;
				next = s1;
				cset = 0;
				end
			s1 : next = s2;
			s2 :
				begin
					cset = 1;
					calset= 1;
					next = s0;
				end
			s4 :
				begin
				next = s5;
				calset = 0;
				cset = 0;
				end
			s5 : next = s6;
			s6 : next = s7;
			s7 : next = s8;
			s8 :
				begin
				calset = 1;
				cset = 1;
				next = s4;
				end
			s9 : next = s9;
		endcase
	end
		
	always @(*) begin
		case (state)
			s0 :
				begin
				clockon = 1;
				hset = 0;
				mset = 0;
				calenderon = 1;
				yset = 0;
				monset = 0;
				dset = 0;
				wset = 0;
				displaymode = 0;
				end
			s1 :
				begin
				clockon = 0;
				hset = 1;
				mset = 0;
				end
			s2 :
				begin
				clockon = 0;
				hset = 0;
				mset = 1;
				end
			s4 :
				begin
				calenderon = 1;
				yset = 0;
				monset = 0;
				dset = 0;
				clockon = 1;
				hset = 0;
				mset = 0;
				wset = 0;
				displaymode = 0;
				end
			s5 :
				begin
				calenderon = 0;
				yset = 1;
				monset = 0;
				dset = 0;
				wset = 0;
				end
			s6 :
				begin
				calenderon = 0;
				yset = 0;
				monset = 1;
				dset = 0;
				wset = 0;
				end
			s7 :
				begin
				calenderon = 0;
				yset = 0;
				monset = 0;
				dset = 1;
				wset = 0;
				end
			s8 : 
				begin
				calenderon = 0;
				yset = 0;
				monset = 0;
				dset = 0;
				wset = 1;
				end
			s9 :
				begin
				calenderon = 1;
				yset = 0;
				monset = 0;
				dset = 0;
				clockon = 1;
				hset = 0;
				mset = 0;
				wset = 0;
				displaymode = 1;
				end
		endcase
	end
	
	always @(*) begin
		case (state) 
			s0,s1,s2 : 
				begin
				sel =1;
				sel2 = 0;
				end
			s4,s5,s6,s7,s8 : 
				begin
				sel = 0;
				sel2 = 0;
				end
			s9 : sel2 = 1;
		endcase
		
	end


endmodule
