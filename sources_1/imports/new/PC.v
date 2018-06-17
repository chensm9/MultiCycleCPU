`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/07 13:50:42
// Design Name: 
// Module Name: PC
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

module PC(
    input CLK, RST, PCWre,
    input [1:0] PCSrc,
    input [31:0] ImExt,
    input [25:0] j_addr,
    input [31:0] ReadData1,
    output reg [31:0] currentPC, nextPC
    );
    initial begin
        currentPC = 0;
        nextPC = 4;
    end
    
    always @(negedge CLK or negedge RST) begin
        if (RST == 0) 
            currentPC = 0;
        else if (PCWre == 1)
            currentPC = nextPC;
    end
    
    always @(PCSrc or ImExt or j_addr) begin
        if (PCSrc == 2'b00) 
            nextPC = currentPC + 4;
        else if (PCSrc == 2'b01)
            nextPC = currentPC + 4 + (ImExt << 2);
        else if (PCSrc == 2'b10) begin
            nextPC = ReadData1;
        end
        else if (PCSrc == 2'b11) begin
            nextPC = currentPC + 4;
            nextPC[27:2] = j_addr;
            nextPC[1:0] = 2'b00;
        end
    end
    
endmodule
