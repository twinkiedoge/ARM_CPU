
CPU Final Project Write-Up 
ES 4 Final Project 
Alex Bobroff, Angelica Cheng, Seo-Yun Chon, and Caitlin Goldberg
5/11/2021

How to Run Code: 
We were unable to complete the entire project so there is no way of running our code. The top module including all components should synthesize without errors, however, there are significant warnings that indicate major problems in the code. 

Current Status: 
To drive many of the signals between the modules, the main decoder, ALU decoder, and conditional logic modules were created to form the control unit. The details of this unit are described in the design section, but this is the driving force for the processor as it sends out signals that determine which actions should be executed or not.
The program counter holds the memory address for the current instruction, incrementing by four every rising clock edge unless the PCSrc signal from the control unit is high, then the counter reads in another address. This address is determined by the control unit as well, as it could be the read data from the RAM if loading or storing, or the result from the ALU if for a branch or data-processing instruction. The counter is then passed into the add8 module to be incremented by eight and passed through to R15 of the register. 
The ROM is able to get and store the instructions that the processor will execute. Within this module there is also the ability to read in a series of instructions from assembly code that has been converted to hexadecimal bits. The program counter passes in the address for the next instruction to be executed, and the ROM outputs said instruction. 
The register file outputs data associated with the address of the first register (data-processing) or R15 (branch) for the first address port, and for the second address port either the destination register, or another register with an optional rotation. Both of these are decided by the control unit as well. On the rising clock edge, if the write enable is high, the data at the write data port is written to the address of the destination register at the third address port.
The immediate extension module described in more detail below, takes the last 24 bits of the instruction, and outputs the bits needed for the instruction that is to be executed.
The ALU computes the ARM instructions, ADD, SUB, RSB, AND, ORR, and MOV, and updates the relevant NZCV flags. Its first source is read from the first data output of the register, and the second source comes either from the immediate extension module, or the second data output of the register, depending on the ALUSrc signal from the control unit. 
The RAM module takes in an address and outputs the corresponding data. If the write enable is high the write data is written into memory on the rising edge. 
In our program, each component was tested separately and is able to work successfully on its own. However, we ran into several bugs during the implementation process that prevented our project from fully compiling. The main issues occurred when we were connecting all of the components in a single top module. 

Description of Design Decisions: 
In terms of CPU microarchitecture, we exactly followed the block diagram provided in the textbook (Digital Design and Computer Architecture ARM Edition, Harris, page 398, figure 7.13)

The textbook had two major differences between its block diagram and the project description on the ES4 site. The first major difference was that we decided to omit the module titled “decoder”. The purpose of this module was to break up the 32 bit instruction coming out of the instruction memory into smaller pieces to be used by other modules in the architecture. Instead of creating an actual module to perform this process, in the top file, the signal titled “Instr” was broken up and connected to the other necessary signal/ports outside of the clock process statement. The decoder module was still written during part 2 and is in the github repository, however, during actual assembly of the CPU, it should not be included. 
The second major design difference between the textbook and project spec was the expansion of the immediate extension module. The immediate extension module chooses its outputs depending on the signal from the main decoder about which type of instruction is being executed. For a data-processing instruction, the immediate extension module would output a 8-bit unsigned immediate, a 12-bit unsigned immediate for LDR and STR, and a 24-bit signed immediate multiplied by four for a branch instruction.
This major design difference also ties into the execution of the branch logic. We directly copied the textbook which seemed to integrate much of the branch logic directly into the microarchitecture instead of creating a separate module to handle the branch functions. We directly copied all of the muxes, control signals, and adders, specified in the above image. We had trouble understanding the exact behavior described in the textbook related to the branch logic. It may have been a better design decision to write an actual branch logic component instead of trying to implement it directly into the microarchitecture like the textbook. After finishing part 2, there was a lot of general confusion because team members knew how the individual modules they wrote worked, but had trouble understanding how it integrated into the greater circuit. 
Besides the two aforementioned design differences, all part 2 modules closely followed the project descriptions. 
For the control unit shown in the textbook (page 398-399, it was broken into three components, the main decoder, ALU decoder, and the conditional logic. The main decoder sent signals to the other modules that change their behaviors depending on which type of instruction is being executed. The ALU Decoder created the command to the ALU, and signal determining which flags should be updated. The conditional logic portion determines if the instruction should be executed, by comparing its result to the NZCV flags which were set in a prior instruction, if the condition is met, it executes.




FPGA Test Results: 
As aforementioned, we were sadly unable to run any tests on our CPU. We were able to synthesize the top module, however significant warnings still occurred which indicated major problems with our code. A lot of the confusion revolved around the branch logic. 

Team Contributions: 
Alex Bobroff wrote the ALU component and testbench. He also wrote the top file and helped other team members with integration of all files. 
	Seoyun Chon wrote the program ROM, PC+8, and RAM module. 
	Caitlin Goldberg wrote the program counter, register file, control unit, and helped other team members with the integration of all the modules.
	Angelica Cheng wrote the decoder, immediate extension module.
