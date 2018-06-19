`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/07 13:50:42
// Design Name: 
// Module Name: Reg_File
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


module Reg_File(
    input CLK, RST, RegWre, WrRegDSrc,
    input [1:0] RegDst,
    input [4:0] rs, rt, rd,
    input [31:0] DBOut, pc,
    output [31:0] ReadData1, ReadData2
    );
    reg [4:0] WriteReg;
    wire [31:0] WriteData;
    reg [31:0] regFile[1:31];
    integer i;
    initial begin  
        for (i = 1; i < 32; i = i+1)   
            regFile[i] <= 0;
    end 
    
    assign WriteData =  WrRegDSrc == 1 ? DBOut : (pc+4);
   
    assign ReadData1 = (rs == 0) ? 0 : regFile[rs];
    assign ReadData2 = (rt == 0) ? 0 : regFile[rt];
   
    always @ (negedge CLK or negedge RST) begin
        if (RST == 0) begin
            for (i = 1; i < 32; i = i+1)   
                regFile[i] <= 0;
        end
        else begin
            case(RegDst)
                2'b00: WriteReg = 31;
                2'b01: WriteReg = rt;
                2'b10: WriteReg = rd;
            endcase
            if(RegWre == 1 && WriteReg != 0)
                regFile[WriteReg] = WriteData;
        end
    end
endmodule
