`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:16:57 12/14/2023 
// Design Name: 
// Module Name:    PMCounter 
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
module PMCounter (
	 input on,
    input clk,
    input rst,
    input up_count,
	 input down_count,
	 input [6:0] max,
    input [6:0] initial_value,
    output [6:0] counter_value
	);

    reg [6:0] count_reg;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count_reg <= initial_value;
        end else if (up_count & on) begin
            count_reg <= (count_reg == max) ? 0 : count_reg + 1;
        end else if (down_count & on) begin
            count_reg <= (count_reg == 0) ? max : count_reg - 1;
        end
    end

    assign counter_value = count_reg;

endmodule
