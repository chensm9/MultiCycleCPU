`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/14 14:43:09
// Design Name: 
// Module Name: DBDR
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


module DBDR(
    input CLK,DBDataSrc,
    input [31:0] ALUResult, DMOut,
    output reg [31:0] DBOut
    );
    always @(posedge CLK) begin
        DBOut = DBDataSrc == 1 ? DMOut : ALUResult;
    end
endmodule
