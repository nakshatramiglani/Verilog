# MIPS32 INFO

## REGISTERS
- 32, 32-bit general purpose registers R0 to R31
- R0 contains a constant 0 (cannot be overwritten)
- special purpose 32 bit program counter, points to next instruction
- only load and store instructions can access memory
- assume word size is 32 bit, memory is word addressible

## INSTRUCTIONS

### R-Type
- ADD R1, R2, R3
  	//R1 = R2 + R3
- ADD R1, R2, R0
    //R1 = R2 + 0
    //copies
- SUB R12, R10, R8
    //R12 = R10 - R8
- SLT R5, R11, R12
    //set less than
    //if R11<R12, R5=1 else R5=0
- AND, OR and MUL do the operations and, or and multiply respectively<br>
- HLT
    //halt

### I-Type
- LW R2, 124(R8)
    //load word 
    //R2 = Mem[R8+128]
- SW R5, -10(R25)
    //store word
    //Mem[R25-10] = R5
- ADDI R1, R2, 25
    //R1 = R2 + R3, add immidiate
- SUBI R12, R10, 18
    //R12 = R10 - R8
- SLTI R5, R11, 22
    //set less than
    //if R11<R12, R5=1 else R5=0
  <br>
- BEQZ R1, loop
    //branch to loop if R1=0
- BNEQZ R5, Label
    //Branch to Label if R5!=0


## INSTRUCTION ENCODING  

### R-type encoding 
#### Bit no: Function
- 31-26 : opcode
- 25-21 : source register 1
- 20-16 : source register 2
- 15-11 : destination register 
- 10-6  : shift amount (NOT USED, take 0)
- 5-0   : opcode extension (NOT USED, take 0)

#### OPCODES- 
- Add- 000000
- Sub- 000001
- And- 000010
- Or - 000011
- Slt- 000100
- Mul- 000101
- Hlt- 111111

### I-type encoding 
##### Bit no: Function
- 31-26 : opcode
- 25-21 : source register 1
- 20-16 : source register 2
- 15-0  : immidiate data/offset
- //for BEQZ and BNEQZ, offset value is added to program counter for address of next instruction

#### OPCODES-
- LW   - 001000
- SW   - 001001
- ADDI - 001010
- SUBI - 001011
- SLTI - 001100
- BNEQZ- 001101
- BEQZ - 001110

## ADDRESSING MODES
- Register addressing (ADD) 
- Immidiate addressing (ADDI)
- Base addressing (LW, SW) //content of register added to "base" value
- PC Relative addressing (BEQZ, BNEQZ) //offset value

