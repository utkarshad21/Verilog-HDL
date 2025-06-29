`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: Utkarsha
// 
// Create Date: 05.01.2024 11:12:01
// Design Name: universal_shift.v
// Module Name: universal_shift
// Project Name: 5-bit Universal Shift Register
// 
// Description: This Verilog project implements a 5-bit Universal Shift Register capable of performing four operations based on a 2-bit select input: no change, shift left, shift right, and parallel load. 
// The universal_shift module takes a parallel input (PI), serial input (SI), and outputs both parallel (PO) and serial output (SO) based on the operation selected. 
// It supports synchronous operation with clock and reset control.
// The provided testbench (universal_shift_tb) simulates various scenarios to validate functionality, including edge cases for shifting and loading. 
// This module is useful in digital systems that require flexible data manipulation and is a common building block in processors and communication systems.
// 
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module universal_shift(PO, PI, SI, SO, sel, clk, rst);
input [1:0] sel;
input [4:0] PI;
input SI, rst, clk;
output reg [4:0]PO;
output SO;

always @(posedge clk)
if(rst)
PO<=0;
else
case(sel)
2'b00 : PO<=PO;
2'b01 : PO<={PO[3:0], SI};
2'b10 : PO<={SI, PO[4:1]};
2'b11 : PO<=PI;
default : PO<=0;
endcase
assign SO = (sel == 2'b01)?PO[4]:PO[0];
endmodule


module universal_shift_tb;
reg sel,PI,SI,rst,clk;
wire PO,SO;
universal_shift b1(PO, PI, SI, SO, sel, clk, rst);
initial
begin
clk = 0;
forever #20 clk = ~clk;
end
initial
begin
sel = 00;
PI = 01101;
SI = 1;
rst = 0;
#40;
sel = 01;
PI = 01001;
SI = 1;
rst = 0;
#40;
sel = 10;
PI = 01001;
SI = 0;
rst = 0;
#40;
sel = 11;
PI = 01001;
SI = 1;
rst = 0;
#40;
sel = 01;
PI = 01001;
SI = 1;
rst = 1;
#40;
sel = 01;
PI = 01001;
SI = 0;
rst = 0;
#40;
$finish;
end
endmodule
