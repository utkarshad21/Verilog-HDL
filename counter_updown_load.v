`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Utkarsha 
// 
// Create Date: 10.01.2024 15:55:09
// Design Name: counter_updown_load.v
// Module Name: counter_updown_load
// Project Name: Updown Counter 
//
// Description: This project implements an 8-bit up/down counter with load functionality in Verilog. 
// The counter_updown_load module supports reset, synchronous data loading, and counting in both directions based on control inputs. 
// A corresponding testbench (counter_updown_load_tb) is included to simulate various scenarios such as reset, load, increment, and decrement operations using a clock signal.
//
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module counter_updown_load(count, up, clk, rst, load, data);
input [7:0] data;
input clk, rst, up, load;
output [7:0] count;

reg [7:0] count_temp;
always@ (posedge clk)
if (!rst)
count_temp <= 0;
else if (load)
count_temp <= data;
else if (up)
count_temp <= count_temp + 1;
else 
count_temp <= count_temp - 1;
assign count = count_temp;
endmodule

module counter_updown_load_tb;
reg [7:0] data;
reg clk, rst, up, load;
wire [7:0] count;
counter_updown_load c1 (count, up, clk, rst, load, data);
initial begin
clk = 0;
forever #20 clk = ~clk;
end
initial begin
rst = 1;
up = 1;
load = 0;
data = 8'b10011101;
#200
rst = 1;
up = 1;
load = 1;
data = 8'b11011101;
#200
rst = 1;
up = 1;
load = 0;
data = 8'b01111001;
#200
rst = 1;
up = 0;
load = 0;
data = 8'b10000101;
#200
rst = 1;
up = 1;
load = 0;
data = 8'b01110101;
#200
rst = 1;
up = 0;
load = 0;
data = 8'b01111001;
#200

$finish;
end
endmodule
