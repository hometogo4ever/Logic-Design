`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:03:41 12/15/2023 
// Design Name: 
// Module Name:    AlarmDisplay 
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
module AlarmControl(
	input CLK,
	input alarmon,
    input reset,
	 input clear,
    input set,
    input [6:0] data_in,
	 output Isset,
	 output [6:0] times
    );
	 reg [6:0] tm = 0;
	 reg isset = 0;
		
		wire rst;
		wire st;
		assign rst = reset | (clear & alarmon);
		always @(posedge CLK or posedge rst or posedge set) begin
			if (rst) begin
				tm <= 0;
				isset <= 0;
			end
			else if (set) begin
				tm <= data_in;
				isset <= 1;
			end
		end
		
		assign times = tm;
		assign Isset = isset;


endmodule
