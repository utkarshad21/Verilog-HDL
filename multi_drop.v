`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Utkarsha
// 
// Create Date: 16.12.2023 22:28:17
// Design Name: multi_drop.v
// Module Name: multi_drop
// Project Name: Multi drop bus
//
// Description: 
// This Verilog project implements a Multi Drop Bus system where a shared 8-bit data bus can drive data into one of three registers (qa, qb, or qc) based on 3 enable signals. 
// The multi_drop module captures data from the bus into the selected register on the rising edge of the clock, with support for asynchronous reset. 
// Only one register is enabled at a time using a 3-bit select (ena, enb, enc).
// The testbench (multi_drop_tb) simulates various enable combinations, data values, and reset behavior to validate correct functionality. 
// This design demonstrates how multiple modules can share a bus interface with controlled access—useful in memory-mapped systems and processor interfaces.
// 
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////

module multi_drop(qa, qb, qc, bus, ena, enb, enc, clk, rst);
output reg [7:0]qa, qb, qc;
input [7:0] bus;
input ena, enb, enc, clk;
input rst;
always@(posedge clk or posedge rst)
begin
if (rst) begin
qa <= 8'd0;
qb <= 8'd0;
qc <= 8'd0;
end
else
case ({ena, enb, enc})
3'b100: qa<=bus;
3'b010: qb<=bus;
3'b001: qc<=bus;
default: {qa, qb, qc}<=3'b000;
endcase
end
endmodule

module multi_drop_tb;
wire [7:0]qa, qb, qc;
reg [7:0] bus;
reg ena, enb, enc, clk;
reg rst;
multi_drop uv2(qa, qb, qc, bus, ena, enb, enc, clk, rst);
initial 
begin
clk = 0;
forever #20 clk = ~clk;
end
initial 
begin
rst = 1'b0;
bus = 8'b00110110;
{ena, enb, enc} = 3'b100;
#40;
rst = 1'b0;
bus = 8'b01001111;
{ena, enb, enc} = 3'b010;
#40;
rst = 1'b0;
bus = 8'b11110110;
{ena, enb, enc} = 3'b001;
#40;
rst = 1'b1;
bus = 8'b00110110;
{ena, enb, enc} = 3'b010;
#40;
$finish;
end
endmodule
