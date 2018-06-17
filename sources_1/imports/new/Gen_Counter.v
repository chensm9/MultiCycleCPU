`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/12 06:55:31
// Design Name: 
// Module Name: Gen_Counter
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

module Gen_Counter(
    input CLK,
    output reg [1:0] counter
    );
    initial begin
        counter <= 0;
    end
    always@(posedge CLK) begin
        counter <= counter + 1;
    end
endmodule
