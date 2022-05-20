# Processors-on-Verilog
## Description
To build a 5-stage pipelined processor capable of executing any one array sorting algorithm other than the bubble sort. Basically, you will be converting your single cycle processor to a pipelined one. Normally the instructions you have already implemented should enable you to execute a sorting algorithm program with small additions i.e., you might need to implement the bgt or blt instruction, or something similar, so that you know when you’d need to sdap two values. This would require small modifications to the circuit.
## Routes
- `Single Cycle Processor` contains the modules for single cycle implementation of the RISC-V processor.
- `Pipelined Processor` contains the modules for pipelined 5-stages implementation of the RISC-V processor.
- `Hazard Controlled Pipelined Processor` contains the modules for pipelined 5-stages with forwarding and stall logic implementation of the RISC-V processor.
- `sorting_algorithm`contains the selection sort algorithm converted to Assembly language for RISC-V architectrue and machine language code for the instruction memory of the processor.
