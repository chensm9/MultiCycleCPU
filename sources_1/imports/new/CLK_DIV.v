`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/12 06:52:34
// Design Name: 
// Module Name: CLK_DIV
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module CLK_DIV(
    input CLK_in,
    output reg CLK_out
    );
    reg[20:0] counter;
    initial begin
        counter <= 0;
        CLK_out <= 0;
    end
    always@(posedge CLK_in) begin
        counter <= counter+1;
        if(counter == 50000) begin
            CLK_out <= ~CLK_out;
            counter <= 0;
        end
    end
endmodule
