`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/12 06:56:10
// Design Name: 
// Module Name: Main
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
module Main(
    input CPU_CLK, SYS_CLK, RST,
    output PCWre,
    input [1:0] SW_in,
    output [2:0] state,
    output [3:0] ctrlBits,
    output [7:0] dispcode
    );

    wire [3:0] num;
    wire [1:0] counter;
    wire SYS_CLK_DIV, DE_CPU_CLK;
    wire [5:0] opCode;
    wire [31:0] rsData, rtData, currentPC, ALUresult, DBdata, nextPC;
    wire [4:0] rs, rt;
    
    MutiCycleCPU cpu(.CLK(DE_CPU_CLK), .RST(RST), .PCWre(PCWre), .state(state), .opCode(opCode), .ReadData1(rsData),
                     .ReadData2(rtData), .currentPC(currentPC), .nextPC(nextPC), 
                     .ALUResult(ALUresult), .DMOut(DBdata), .rs(rs), .rt(rt));
    CLK_DIV clk_div(SYS_CLK, SYS_CLK_DIV);
    Data_Selector ds(currentPC, nextPC, rsData, rtData, ALUresult, DBdata, rs, rt, SW_in, counter, num, ctrlBits);
    Debounce de(SYS_CLK ,CPU_CLK, DE_CPU_CLK);
    Seg7_LED seg7(num, dispcode);
    Gen_Counter gc(SYS_CLK_DIV, counter);
endmodule
