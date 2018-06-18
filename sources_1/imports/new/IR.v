`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/07 19:17:47
// Design Name: 
// Module Name: IR
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


module IR(
    input CLK, IRWre,
    input [31:0] Ins,
    output reg [5:0] opCode,   
    output reg [4:0] rs, rt, rd,  
    output reg [15:0] Immediate,
    output reg [25:0] j_addr,
    output reg [5:0] sa
    );
    always @ (posedge CLK) begin
        if (IRWre == 1) begin
            opCode = Ins[31:26];
            rs = Ins[25:21];
            rt = Ins[20:16];
            rd = Ins[15:11];
            Immediate = Ins[15:0];
            j_addr = Ins[25:0];
            sa = Ins[10:6];
        end
    end
endmodule
