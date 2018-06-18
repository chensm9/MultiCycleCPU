`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/07 13:50:42
// Design Name: 
// Module Name: CU
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

module CU(
  input CLK, RST, zero, sign,
  input [5:0] opCode,
  output reg [1:0] RegDst, PCSrc,
  output reg [2:0] ALUOp, state,
  output reg ALUSrcA, ALUSrcB, mRD ,mWR, InsMemRW, ExtSel, PCWre, RegWre, DBDataSrc, WrRegDSrc, IRWre
  );

  parameter [2:0] sIF = 3'b000, sID = 3'b001, sEXE = 3'b010,
                  sWB = 3'b011, sMEM = 3'b100;
  parameter [5:0] Add = 6'b000000, Sub = 6'b000001, Addi = 6'b000010, Or = 6'b010000,
                  And = 6'b010001, Ori = 6'b010010, Sll = 6'b011000, Slt = 6'b100110,
                  Sltiu = 6'b100111, Sw = 6'b110000, Lw = 6'b110001, Beq = 6'b110100,
                  Bltz = 6'b1110110, J = 6'b111000, Jr = 6'b111001, Jal = 6'b111010,
                  Halt = 6'b111111;
  reg [2:0] next_state; 
  integer i;

  initial begin
    i = 0;
  end

  always @(posedge CLK or negedge RST) begin
    if (RST == 0) begin
      state = sIF;
      IRWre = 0;
      i = 0;
    end
    else if (i == 0) begin
      state = sIF;
      IRWre = 1;
      i = 1;
    end
    else begin
      state = next_state; 
      IRWre = (state == sIF) ? 1:0;
    end
  end  

  always @(state or opCode) begin
      case(state)
          sIF: next_state = sID;
          sID: begin
                  if (opCode == J || opCode == Jr || opCode == Jal || opCode == Halt)
                    next_state = sIF;
                  else
                    next_state = sEXE;
                end
          sEXE:begin
                  if (opCode == Beq || opCode == Bltz)
                    next_state = sIF;
                  else if (opCode == Sw || opCode == Lw)
                    next_state = sMEM;
                  else
                    next_state = sWB;
                end
          sWB: next_state = sIF; 
          sMEM:begin
                  if (opCode == Sw)
                    next_state = sIF;
                  else
                    next_state = sWB;
                end
      endcase
  end

  always @ (state or opCode or zero or sign) begin
    PCWre = (next_state == sIF && opCode !== Halt) ? 1:0;
    DBDataSrc = (state == sMEM && opCode == Lw) ? 1:0;
    InsMemRW = 1;
//    IRWre = (next_state == sID) ? 1:0;
    WrRegDSrc = (state == sWB) ? 1:0;
    mRD = (state == sMEM && opCode == Lw) ? 1:0;
    mWR = (state == sMEM && opCode == Sw) ? 1:0;
    ExtSel = (opCode == Ori || opCode == Sltiu) ? 0:1;
    ALUSrcA = (opCode == Sll) ? 1:0;
    ALUSrcB = (opCode == Addi || opCode == Ori || opCode == Sltiu || opCode == Lw || opCode == Sw) ? 1:0;
    if (opCode == Jal && next_state == sIF && state == sID)
      RegWre = 1;
    else
      RegWre = ( state != sWB || opCode == Beq || opCode == Bltz 
                || opCode == J || opCode == Sw || opCode == Jr || opCode == Halt) ? 0:1;
      
    if ((opCode == Beq&&zero == 1) || (opCode == Bltz&&(zero == 0||sign == 1)))
      PCSrc = 2'b01;
    else if (opCode == Jr)
      PCSrc = 2'b10;
    else if (opCode == J || opCode == Jal)
      PCSrc = 2'b11;
    else
      PCSrc = 2'b00;
        
    if (opCode == Jal)
      RegDst = 2'b00;
    else if (opCode == Addi || opCode == Ori || opCode == Sltiu || opCode == Lw)
      RegDst = 2'b01;
    else
      RegDst = 2'b10;
  
    if (opCode == Add || opCode == Addi || opCode == Sw || opCode == Lw)
      ALUOp = 3'b000;
    else if (opCode == Sub || opCode == Beq || opCode == Bltz)
      ALUOp = 3'b001;
    else if (opCode == Sltiu)
      ALUOp = 3'b010;
    else if (opCode == Slt)
      ALUOp = 3'b011;
    else if (opCode == Sll)
      ALUOp = 3'b100;
    else if (opCode == Or || opCode == Ori)
      ALUOp = 3'b101;
    else if (opCode == And )
      ALUOp = 3'b110;
    else
      ALUOp = 3'b000;
    
    if (state == sIF) begin  
      RegWre = 0;  
      mWR = 0;  
    end  
  end
endmodule
