`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/07 13:50:42
// Design Name: 
// Module Name: Data_Mem
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


module Data_Mem(
    input mRD,
    input mWR,
    input [31:0] address,
    input [31:0] DataIn, // [31:24], [23:16], [15:8], [7:0]
    output reg [31:0] DMOut
    );
    reg [7:0] ram [0:63];
    integer i;  
    initial begin  
        for (i = 0; i < 64; i = i+1) ram[i] <= 0;  
    end  
    // ��
    always @ (mRD) begin
        if (mRD == 1) 
            DMOut = { ram[address], ram[address+1], ram[address+2], ram[address+3] };
        else
            DMOut = 32'bz;
    end
    // д
    always@( mWR ) begin
        if( mWR==1 ) begin
            ram[address] <= DataIn[31:24];
            ram[address+1] <= DataIn[23:16];
            ram[address+2] <= DataIn[15:8];
            ram[address+3] <= DataIn[7:0];
        end
    end
    
endmodule
