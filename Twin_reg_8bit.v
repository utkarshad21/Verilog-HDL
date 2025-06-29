`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: Utkarsha
// Create Date: 16.12.2023 13:58:33
// Design Name: Twin_reg_8bit.v
// Module Name: Twin_reg_8bit
// Project Name: Twin 8-bit Register
// 
// Description: 
// This Verilog project implements a Twin 8-bit Register module (Twin_reg_8bit) that stores two separate 8-bit data inputs (d1 and d2) into two output registers (q1 and q2) on the rising edge of the clock. 
// The module also includes a synchronous reset which clears both registers when active.
// The accompanying testbench (Twin_reg_8bit_tb) simulates various combinations of data inputs and reset conditions to verify correct behavior. 
// This design is useful for applications requiring parallel data storage or pipelined data buffering in digital systems.
// 
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Twin_reg_8bit(q1, q2, clk, rst, d1, d2);
input clk, rst;
input [7:0] d1, d2;
output reg [7:0] q1, q2;
always@(posedge clk)
if (rst) begin 
q1<=0;
q2<=0;
end
else begin
q1<=d1;
q2<=d2;
end
endmodule

module Twin_reg_8bit_tb;
reg clk, rst;
reg [7:0] d1, d2;
wire [7:0] q1, q2;
Twin_reg_8bit b1(q1, q2, clk, rst, d1, d2);
initial 
begin
clk = 0;
forever #20 clk = ~clk;
end
initial
begin
{rst, d1, d2} = 3'b011;
#40;
{rst, d1, d2} = 3'b010;
#40;
{rst, d1, d2} = 3'b001;
#40;
{rst, d1, d2} = 3'b000;
#40;
{rst, d1, d2} = 3'b100;
#40;
{rst, d1, d2} = 3'b101;
#40;
{rst, d1, d2} = 3'b110;
#40;
{rst, d1, d2} = 3'b111;
#40;
{rst, d1, d2} = 3'b001;
#40;
end
endmodule
