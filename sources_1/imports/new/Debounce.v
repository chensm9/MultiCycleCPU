`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/12 06:54:27
// Design Name: 
// Module Name: Debounce
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


module Debounce(clk, key_in, key_out);
    input clk;
    input key_in;
    output reg key_out;

    reg [21:0] count;
    reg last_key_in;;
    parameter SAMPLE_TIME = 20'hf_ffff;
    
    always @(posedge clk) begin
        if(key_in == last_key_in)
            count <= count + 1;
        else begin
            last_key_in = key_in;
            count <= 0;
        end
    end
 
    always @(posedge clk) begin
        if(count == SAMPLE_TIME)
            key_out <= key_in;
    end
endmodule 
