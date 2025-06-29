`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer: Utkarsha
// Create Date: 11.06.2024 18:01:49
// Design Name: rgb_seq.v
// Module Name: rgb_seq
// Project Name: Red, Green, Blue Sequence 
// 
// Description: 
// This project implements a basic RGB traffic light controller using a 3-state finite state machine (FSM) in Verilog. 
// The rgb_seq module cycles through Green - Yellow - Red outputs on each rising edge of the clock. 
// A synchronous reset initializes the FSM to the Green state. T
// his design can be used in digital system simulations for traffic signal control, LED sequencing, or educational purposes demonstrating FSM logic.
// The light output is a 3-bit signal representing the active color. 
// A corresponding testbench (rgb_seq_tb) simulates clock toggling and reset behavior to observe light transitions.
// Key Features: 3-bit output to represent Red, Green, Yellow lights, Parameterized states and color codes, Clock-driven state transitions.
//
// Revision 0.01 - File Created
// Additional Comments:
//////////////////////////////////////////////////////////////////////////////////


module rgb_seq (input clk, input rst, output reg [0:2] light);

  parameter s0 = 0, s1 = 1, s2 = 2;
  parameter red = 3'b100, green = 3'b010, yellow = 3'b001;

  reg [0:1] state;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      state <= s0; 
      light <= green;
    end else begin
      case (state)
        s0: begin 
          light <= green; 
          state <= s1;
        end
        s1: begin
          light <= yellow;
          state <= s2;
        end
        s2: begin
          light <= red;
          state <= s0;
        end
        default: begin 
          light <= red;
          state <= s0;
        end
      endcase
    end
  end
endmodule

// Testbench
module rgb_seq_tb;
  reg clk, rst;
  wire [0:2] light;

  rgb_seq uut (
    .clk(clk),
    .rst(rst),
    .light(light)
  );

  initial begin
    clk = 0;
    forever #10 clk = ~clk;
  end

  initial begin
    $display("Time | Light");
    $monitor("%4t | %b", $time, light);
    rst = 1;
    #15 rst = 0;  
    #100;
    $finish;
  end
endmodule


