`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/12 06:53:34
// Design Name: 
// Module Name: Data_Selector
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


module Data_Selector(
    input [31:0] curPC, nextPC, rsData, rtData, ALUresult, DBdata,
    input [4:0] rs, rt,
    input [1:0] SW_in, counter,
    output reg [3:0] num,
    output reg [3:0] ctrlBits
    );
    
    reg [15:0] displayData;
    
    always@(SW_in or curPC or nextPC or rsData or rtData or ALUresult or DBdata or rs or rt) begin
        case(SW_in)
            2'b00: displayData = { curPC[7:0], nextPC[7:0] };
            2'b01: displayData = { 3'b000, rs, rsData[7:0] };
            2'b10: displayData = { 3'b000, rt, rtData[7:0] };
            2'b11: displayData = { ALUresult[7:0], DBdata[7:0] };
        endcase
    end
    always@(counter) begin
        case(counter)
            2'b00: begin
                ctrlBits = 4'b1110;
                num = displayData[3:0];
            end
            2'b01: begin
                ctrlBits = 4'b1101;
                num = displayData[7:4];
            end
            2'b10: begin
                ctrlBits = 4'b1011;
                num = displayData[11:8];
            end
            2'b11: begin
                ctrlBits = 4'b0111;
                num = displayData[15:12];
            end
        endcase
    end
endmodule
