`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/07 19:04:23
// Design Name: 
// Module Name: DataLate
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


module DataLate(
    input CLK,
    input [31:0] DataIn,
    output reg [31:0] DataOut
    );
    always @(posedge CLK) begin
        DataOut = DataIn;
    end
endmodule
