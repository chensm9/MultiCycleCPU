`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/07 20:30:47
// Design Name: 
// Module Name: CPU_SIM
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


module CPU_SIM;
//    reg CLK, RST;
//    wire [4:0] rs, rd, rt;
//    wire [2:0] ALUOp, state;
//    wire [1:0] PCSrc, RegDst;
//    wire [5:0] opCode, sa;
//    wire zero, PCWre,sign ,ALUSrcA, ALUSrcB, DBDataSrc, RegWre, InsMemRW, mRD, mWR, ExtSel, IRWre, WrRegDSrc;
//    wire [15:0] Immediate;
//    wire [25:0] j_addr;
//    wire [31:0] ReadData1, ReadData2, currentPC, nextPC, ALUResult, DBOut, ImExt, Ins;
    reg CLK, RST;
    wire PCWre;
    wire [2:0] state;
    wire [4:0] rs, rt;
    wire [5:0] opCode;
    wire [31:0] ReadData1, ReadData2, currentPC, nextPC, ALUResult, DBOut;

    MutiCycleCPU cpu(
        CLK, RST, PCWre,
        state,
        rs, rt,
        opCode,
        ReadData1, ReadData2, currentPC, nextPC, ALUResult, DBOut
    );
    initial begin
        CLK = 0;
        RST = 0;
        #50; // �տ�ʼ����pcΪ0
            CLK = !CLK;
        #50;
            RST = 1;
        forever #50 begin // ����ʱ���ź�
            CLK = !CLK;
        end
    end
    // initial begin
    //   CLK = 0;
    //   RST = 0;
    //   #100;
    //     RST = 1;
    //   forever #50 begin // ����ʱ���ź�
    //       CLK = !CLK;
    //   end
    // end

endmodule
