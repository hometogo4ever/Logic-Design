`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:48:33 12/15/2023 
// Design Name: 
// Module Name:    LightCounter 
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
module LightCounter (
	 input on,
    input clk,
    input rst,
    input up_count,
	 input down_count,
    output [2:0] counter_value
	);

    reg [2:0] count_reg = 2;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count_reg <= 2;
        end else if (up_count & on) begin
            count_reg <= (count_reg == 4) ? count_reg : count_reg + 1;
        end else if (down_count & on) begin
            count_reg <= (count_reg == 0) ? count_reg : count_reg - 1;
        end
    end

    assign counter_value = count_reg;

endmodule
