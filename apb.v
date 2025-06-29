`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Utkarsha
// 
// Create Date: 14.02.2025 13:05:43
// Design Name: apb.v 
// Module Name: apb
// Project Name: APB protocol
// 
// Description: 
// This Verilog project implements a controller for the Advanced Peripheral Bus (APB) — a simple and low-power interface used in AMBA systems. 
// The design follows the standard 3-phase APB protocol: IDLE → SETUP → ACCESS. 
// The module supports 32-bit wide address and data transactions and can perform both read and write operations using internal memory simulation.
// Key Features:
// 32-bit address and data width
// Fully synchronous FSM for APB phase control
// Internal memory array for read/write simulation
// Outputs ready signal based on internal busy flag
// The included testbench (apb_tb) stimulates the APB controller with various input sequences to verify read/write behavior and proper state transitions.
// 
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module apb( clk,rst,paddr,pwrite,pwdata,pen,psel,pready, prdata);
  parameter idle=2'b00,
            setup=2'b01,
            access=2'b10;
  parameter datawidth=32;
  parameter addwidth=32;
  input clk,rst,pen,psel,pwrite;
  output pready;
  reg[1:0] apb_st,nxt_st;
  input [datawidth-1:0] pwdata;
  output reg[datawidth-1:0] prdata;
  input [addwidth-1:0] paddr;
  reg busy=0;
  
  reg[datawidth-1:0]mem[addwidth-1:0];
  
  always@(posedge clk or negedge rst)begin
    if(!rst) apb_st<=idle;
    else apb_st<=nxt_st;
      end
  
  always@(psel,pen,apb_st)begin
    case(apb_st)
        idle:begin
          if(psel==1 && pen==0)
            nxt_st=setup;
          else nxt_st=idle;
        end
      
      setup: begin 
        if(psel==1 && pen==1)
               nxt_st=access;
        else if(psel==1 && pen==0)
          nxt_st=setup;
        else nxt_st=idle;
      end
     
       
        access: begin
          if(psel==1 && pen==1)
            nxt_st=access;
          else if(psel==1 && pen==0)
            nxt_st=setup;
          else nxt_st=idle;
        end
      endcase
    
  end
  
  always@(*)begin
    if(apb_st==access)begin
      if(pwrite==1 && psel==1 && pready==1)
        mem[paddr]=pwdata;
      else if(pwrite==0 && psel==1 && pready==1)
        prdata=mem[paddr];
    end
  end
  assign pready=(busy==0) ? 1: 0;
  
endmodule
  
// Testbench

module apb_tb;
reg PCLK,PRESETn;
wire [31:0]PADDR,PWDATA;
reg [31:0]PRDATA;
wire PWRITE,PENABLE,PSELx;
reg PREADY;

reg [1:0]DWREQ;

apb uut (
  .clk(PCLK),
  .rst(PRESETn),
  .paddr(PADDR),
  .pwdata(PWDATA),
  .prdata(PRDATA),
  .pwrite(PWRITE),
  .pen(PENABLE),
  .psel(PSELx),
  .pready(PREADY),
  .DWREQ(DWREQ)
);
  
initial 
begin
PCLK = 0;
PRESETn = 0;
DWREQ = 2'b00;
PREADY = 0;
end
always #5 PCLK = ~PCLK;

initial
begin
#5 PRESETn = 1;
#10 DWREQ = 2'b01;PRDATA = 32'd16;
#10 DWREQ=2'b00; 
#10 PREADY = 1;
#10 PREADY = 0;PRDATA = 32'd0;
#10;
#10 DWREQ =2'b11;
#10 DWREQ = 2'b00;
#10 PREADY = 1;
#10 PREADY = 0;
#20 PRESETn = 0;
$finish;

end
endmodule
