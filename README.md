# RISCV

The functioning of the various modules used for integration in the main module (uProcessor) is as follows:
(1) ALU : It performs different Arithmetic and Logical operations. The ALU takes two inputs (regA, regB) in 16 bits integer format and generates
a 16 bit output aluout in integer format. A 1 bit flag eq_flag has to be set to high whenever all the bits in regD are zero.
(2) Program Counter : Program counter is a register containing the location of the currently executing instruction. Based on the opcode provided by the Control unit, the current state of the program counter is determined.
(3) Instruction Decoder : It takes the instruction from the READ_DATA_BUS and decodes this instruction and provides select lines for Internal Registers, Immediate value for Immediate Operation, Flag for Control Unit and ALU and opcode for ALU as well as Control Unit.
(4) Internal Registers : This module consists of maximum 8 internal registers each 16 bit long. These internal registers are used to store the value of regD and provide values to regA and regB.
(5) Control Unit : This module resembles a finite state machine which has 4 states namely, Fetch, Decode, Execute and Write Back. Based on the opcodes provided by the Instruction Decoder and the current state of the Control Unit, control signals are provided to different modules.
(6) Immediate Operation : It provides 16 bit Immediate value to the Program Counter Preset after getting 8 bit Immediate value from Decoder.
(7) Program Counter Preset : It provides a 16 bit immediate value pc_in to the program counter when the program counter is in PRESET state.
(8) Address Data Mux : It provides the address of the memory location to the address bus.
(9) Data Mux : It acts as a multiplexer to select either the output from ALU or an immediate output or value from READ_DATA_BUS and provide it to Internal Registers.
All the above mentioned modules are integrated into the main module named uProcessor. All the instructions throughout the modules are carried out during positive edge of the clock and negative edge of asynchronous reset. Initially, the reset is kept high in order to initialize the values of nets. To check the functionality of the Processor, a testbench
named uProcessor_tb is created in which the microprocessor module is instantiated. Along with this a separate module named ’memory’ which contained the instructions to test the functionality of the Processor and is instantiated in the testbench uProcessor_tb.
