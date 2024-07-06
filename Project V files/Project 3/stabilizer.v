`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:12:23 12/13/2023 
// Design Name: 
// Module Name:    stabilizer 
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
module stabilizer(
    input clk,
    input data_in,
    output data_out
    );
	 wire w;
	Debouncer d1 (clk, data_in, w);
	PulseGenerator p1 (clk, w, data_out);
	

endmodule
