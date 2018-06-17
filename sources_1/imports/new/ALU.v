`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/07 13:50:42
// Design Name: 
// Module Name: ALU
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

module ALU( 
    input ALUSrcA, ALUSrcB,
    input [4:0] sa,
    input [2:0] ALUOp,
    input [31:0] ReadData1, ReadData2, ImExt,
    output reg [31:0] result, 
    output reg zero, sign
    );
    wire [31:0] A, B;
    assign A = (ALUSrcA == 0) ? ReadData1 : {24'h000000, 3'b000, sa};
    assign B = (ALUSrcB == 0) ? ReadData2 : ImExt;
    always @( ALUOp or A or B ) begin
        case (ALUOp)
            3'b000 : result = A + B;
            3'b001 : result = A - B;
            3'b010 : result = (A < B) ? 1 : 0;
            3'b011 : begin 
                        if(A < B && (A[31] == B[31])) result = 1;
                        else if (A[31] == 1 && B[31] == 0) result = 1;
                        else result = 0;
                     end
            3'b100 : result = B << A;
            3'b101 : result = A | B;
            3'b110 : result = A & B;
            3'b111 : result = A ^ B;
            default : result = 32'h00000000;
        endcase
        zero = (result == 0) ? 1 : 0;
        sign = result[31];
    end
endmodule
