`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/07 13:50:42
// Design Name: 
// Module Name: MutiCycleCPU
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


//module MutiCycleCPU(
//    input CLK, RST,
//    output [4:0] rs, rd, rt,
//    output [2:0] ALUOp, state,
//    output [1:0] PCSrc, RegDst,
//    output [5:0] opCode, sa, 
//    output zero, PCWre,sign ,ALUSrcA, ALUSrcB, DBDataSrc, RegWre, InsMemRW, mRD, mWR, ExtSel, IRWre, WrRegDSrc,
//    output [15:0] Immediate,
//    output [25:0] j_addr,
//    output [31:0] ReadData1, ReadData2, currentPC, nextPC, ALUResult, DBOut, ImExt, Ins
//    );
//    wire [31:0] LateReadData1, LateReadData2, LateALUResult, LateDBOut;
    
module MutiCycleCPU(
    input CLK, RST,
    output PCWre,
    output [2:0] state,
    output [4:0] rs, rt,
    output [5:0] opCode,
    output [31:0] ReadData1, ReadData2, currentPC, nextPC, ALUResult, DMOut
    );
    wire [31:0] LateReadData1, LateReadData2, LateALUResult, LateDBOut, ImExt, Ins;
    wire [4:0] rd;
    wire [2:0] ALUOp;
    wire [1:0] PCSrc, RegDst;
    wire [5:0] opCode, sa;
    wire zero, sign ,ALUSrcA, ALUSrcB, DBDataSrc, RegWre, InsMemRW, mRD, mWR, ExtSel, IRWre, WrRegDSrc;
    wire [15:0] Immediate;
    wire [25:0] j_addr;
    
    PC pc (.CLK(CLK), .RST(RST), .PCWre(PCWre), .PCSrc(PCSrc), .ImExt(ImExt), 
           .j_addr(j_addr), .ReadData1(ReadData1), .currentPC(currentPC), .nextPC(nextPC));
    Ins_Mem im (.pc(currentPC), .InsMemRW(InsMemRW), .Ins(Ins));
    IR ir (.CLK(CLK), .IRWre(IRWre), .Ins(Ins), .opCode(opCode), 
           .rs(rs), .rt(rt), .rd(rd), .Immediate(Immediate), .j_addr(j_addr), .sa(sa));
    Reg_File rf (.CLK(CLK), .RST(RST), .RegWre(RegWre), .WrRegDSrc(WrRegDSrc), .RegDst(RegDst), 
                 .rs(rs), .rt(rt), .rd(rd), .DBOut(LateDBOut), .pc(currentPC), 
                 .ReadData1(ReadData1), .ReadData2(ReadData2));
    CU cu (.CLK(CLK), .RST(RST), .zero(zero), .sign(sign), .opCode(opCode), 
           .RegDst(RegDst), .PCSrc(PCSrc), .ALUOp(ALUOp), .state(state),
           .ALUSrcA(ALUSrcA), .ALUSrcB(ALUSrcB), .mRD(mRD), .mWR(mWR), .InsMemRW(InsMemRW), .ExtSel(ExtSel), 
           .PCWre(PCWre), .RegWre(RegWre), .DBDataSrc(DBDataSrc), .WrRegDSrc(WrRegDSrc), .IRWre(IRWre));
    DataLate ADR (.CLK(CLK), .DataIn(ReadData1), .DataOut(LateReadData1));
    DataLate BDR (.CLK(CLK), .DataIn(ReadData2), .DataOut(LateReadData2));
    ALU alu(.ALUSrcA (ALUSrcA), .ALUSrcB(ALUSrcB), .sa(sa), .ALUOp(ALUOp), 
            .ReadData1(LateReadData1), .ReadData2(LateReadData2), .ImExt(ImExt), 
            .result(ALUResult), .zero(zero), .sign(sign) );
    DataLate ALUoutDR (.CLK(CLK), .DataIn(ALUResult), .DataOut(LateALUResult));
    Data_Mem dm (.mRD(mRD), .mWR(mWR),.address(LateALUResult), 
                 .DataIn(LateReadData2),  .DMOut(DMOut));
    DBDR DBDr (.CLK(CLK),.DBDataSrc(DBDataSrc), .ALUResult(ALUResult), 
                .DMOut(DMOut),.DBOut(LateDBOut));
    Extend ext (.Immediate(Immediate), .ExtSel(ExtSel), .ImExt(ImExt));
endmodule
