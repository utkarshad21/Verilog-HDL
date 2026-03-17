Verilog-HDL

This repository contains a collection of Verilog HDL designs covering fundamental digital circuits, sequential logic, and basic protocol-level implementations. Each module is accompanied by a testbench for functional verification.

* Modules Included

1. Twin 8-bit Register
- Stores two independent 8-bit inputs into two output registers.
- Synchronous operation with clock.
- Includes reset functionality to clear both registers.
- Useful for parallel data storage and pipelining applications.

2. APB Protocol Controller
- Implements Advanced Peripheral Bus (APB) protocol.
- Follows FSM-based design: IDLE - SETUP - ACCESS.
- Supports 32-bit address and data transactions.
- Includes internal memory for read/write operations.
- Demonstrates basic AMBA protocol communication.

3. Clock Divider (Divide by 4)
- Reduces input clock frequency by a factor of 4.
- Implemented using sequential flip-flop stages.
- Useful for clock management in digital systems.

4. Up/Down Counter with Load
- 8-bit counter supporting increment and decrement operations.
- Includes synchronous load feature for initializing count.
- Reset functionality available.
- Commonly used in timers and control logic.

5. Multi-Drop Bus System
- Shared 8-bit data bus connected to multiple registers.
- Controlled using enable signals to select destination register.
- Demonstrates bus-based communication.
- Useful in memory-mapped and processor interfacing systems.

6. RGB Sequence Controller (FSM)
- Implements a traffic light controller using FSM.
- Cycles through Green - Yellow - Red states.
- Demonstrates state transition logic.
- Useful for learning finite state machine design.

7. Universal Shift Register
- 5-bit register supporting multiple operations:
  - Hold
  - Shift Left
  - Shift Right
  - Parallel Load
- Provides both serial and parallel outputs.
- Widely used in communication and data processing systems.

