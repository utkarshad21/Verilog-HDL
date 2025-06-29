`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Engineer: Utkarsha
// Create Date: 14.01.2024 12:28:16
// Design Name: clk_divby4.v
// Module Name: clk_divby4
// Project Name: clock frequency (divide by 4)
//
// Description: 
// This Verilog project implements a clock divider that reduces the input clock frequency by a factor of 4. 
// The clk_divby4 module uses two flip-flops to sequentially divide the clock signal. 
// A testbench (clk_divby4_tb) is provided to simulate the functionality with clock generation and reset control.

// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clk_divby4(clk_out, clk_in, rst);
input clk_in, rst;
output reg clk_out;
reg clk_div2;
always@ (posedge clk_in)
begin
if (rst)
clk_div2<=0;
else 
clk_div2<=~clk_div2;
end
always@ (posedge clk_div2)
begin
if (rst)
clk_out<=0;
else
clk_out<=~clk_out;
end
endmodule

module clk_divby4_tb();
reg clk_in, rst;
wire clk_out;
clk_divby4 vu1(clk_out, clk_in, rst);
initial begin
clk_in = 0;
forever #20 clk_in = ~clk_in;
end
initial begin
rst = 0;
#100;
rst = 1;
#100;
rst = 0;
end
endmodule
