`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/07 13:50:42
// Design Name: 
// Module Name: Ins_Mem
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


module Ins_Mem(
    input [31:0] pc,
    input InsMemRW,
    output reg [31:0] Ins
    );
    reg [7:0] Mem[0:127];

    initial begin
        $readmemb("C:/Users/admin/Desktop/MultiCycleCPU/instructions.txt", Mem);
        Ins = { Mem[0], Mem[1], Mem[2], Mem[3] };
    end
    always @(pc or InsMemRW) begin
        if (InsMemRW) begin
            Ins = { Mem[pc], Mem[pc+1], Mem[pc+2], Mem[pc+3] };
        end
    end
endmodule
