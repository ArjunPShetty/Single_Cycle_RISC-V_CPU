# Single-Cycle-RISC-V-CPU
In this project, a 32-bit single-cycle RISC-V processor is designed and implemented using Verilog HDL. The processor is based on the RV32I instruction set and executes each instruction in a single clock cycle. The main aim of the project is to understand how a basic CPU works internally, including instruction fetch, decoding, execution, memory access, and write-back.

The processor consists of essential components such as the Program Counter, Instruction Memory, Register File, ALU, Control Unit, Sign Extension Unit, Data Memory, and multiplexers. Each module is designed separately and then integrated to form the complete datapath. The control unit generates all required control signals based on the instruction opcode and function fields.

The register file supports two read ports and one write port, with register x0 permanently set to zero as per the RISC-V specification. The ALU performs arithmetic and logical operations, while load and store instructions interact with data memory. Immediate values are generated using a sign-extension unit depending on the instruction type.

The processor is simulated using Vivado, and its functionality is verified by observing waveforms for different instructions. The correct operation of the program counter, control signals, ALU results, and register updates confirms the successful implementation of the processor.

This project helped in gaining a clear understanding of computer architecture concepts, RTL design, and Verilog-based hardware modeling, and it serves as a base for future improvements such as pipelining and performance optimization.

waveform:
.
<img width="1575" height="867" alt="single cycle RISC-V CPU" src="https://github.com/user-attachments/assets/97fd4480-c1bc-4848-8808-a0a2987458fc" />
