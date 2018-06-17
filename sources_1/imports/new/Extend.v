`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/07 13:50:42
// Design Name: 
// Module Name: Extend
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


module Extend(
    input [15:0] Immediate,
    input ExtSel,
    output [31:0] ImExt
    );
    assign ImExt = (ExtSel == 1 && Immediate[15] == 1) ? 
                   {16'hFFFF, Immediate} : {16'h0000, Immediate};
endmodule
