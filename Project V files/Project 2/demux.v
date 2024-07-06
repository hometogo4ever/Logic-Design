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
	 output reg alarmon,
	 output reg hset,
    output reg mset,
	 output reg cset,
	 output reg alset,
	 output reg ahset,
	 output reg amset,
	 output reg sel1,
	 output reg sel2,
	 output reg displaymode
    );
	 
	
	 reg [3:0] next;
	 parameter s0 = 4'b0000;
	 parameter s1 = 4'b0001;
	 parameter s2 = 4'b0010;
	 parameter s9 = 4'b1001;
	 parameter s10 =4'b1010;
	 parameter s11 =4'b1011;
	 parameter s3 = 4'b0011;
	 parameter s4 = 4'b0100;
	 
	 reg [3:0] state=s0;
	 
	 always @(posedge clk or posedge reset) begin
		if (reset) state <= s0;
		else if (mode) begin
			if (state == s0 || state == s1 || state == s2) state <= s9;
			if (state == s9 || state == s10 || state == s11) state <= s4;
			if (state == s4) state <= s3;
			if (state == s3) state <= s0;
		end
		else if (set) state <= next;

	end
	
	always @(*) begin
		case (state)
			s0 :
				begin
				next = s1;
				cset = 0;
				end
			s1 : next = s2;
			s2 :
				begin
					cset = 1;
					next = s0;
				end
			s3 : next = s3;
			s4 : next = s4;
			s9 :
				begin
				next = s10;
				alset = 0;
				end
			s10 : next = s11;
			s11 : 
				begin
				alset = 1;
				next = s9;
				end
				
		endcase
	end
		
	always @(*) begin
		case (state)
			s0 :
				begin
				clockon = 1;
				hset = 0;
				mset = 0;
				displaymode = 0;
				alarmon = 1;
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
			s3 :
				displaymode = 1;
			s4 : 
				begin
				hset = 0;
				mset = 0;
				clockon = 1;
				amset = 0;
				ahset = 0;
				alarmon = 1;
				end
			s9 :
				begin
				clockon = 1;
				hset = 0;
				mset = 0;
				alarmon = 1;
				ahset = 0;
				amset = 0;
				displaymode = 0;
				end
			s10 : 
				begin
				alarmon = 0;
				ahset = 1;
				amset = 0;
				end
			s11 :
				begin
				alarmon = 0;
				ahset = 0;
				amset = 1;
				end
		endcase
	end
	
	always @(*) begin
		case (state) 
			s0,s1,s2 : 
				begin
				sel1 =1;
				sel2 = 0;
				end
			s3 :
				begin
				sel2 = 1;
				sel1 = 0;
				end
			s4 : 
				begin
				sel2 = 1;
				sel1 = 1;
				end
			s9,s10,s11 : 
				begin
				sel1 = 0;
				sel2 = 0;
				end
		endcase
	end


endmodule

