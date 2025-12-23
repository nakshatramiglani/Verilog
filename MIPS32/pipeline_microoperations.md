
# INSTRUCTION CYCLE
## structure of latches-
- between every statge of the cycle, we will have a latch labled stage1_stage2<br> 
for example, EX_MEM
- each latch will be one clock cycle ahead of the latch in front of it 
- every latch will have temporary registers stored in it<br>
for example, EX_MEM_IR: instruction reg stored in EX_MEM latch
## 1) IF: instrction fetch <br>
IF_ID_IR <- Mem[PC];<br>
if (EX_MEM_IR[opcode]==branch & EX_MEM_cond)<br><t>
IF_ID_NPC, PC <- EX_MEM_ALUOut<br>
else<br><t>
IF_ID_NPC = PC + 1;
![Pipeline Diagram](images/instruction_fetch.png)
## 2)ID: instrction decode, register fetch<br>
A <- Reg[IR[25:21]]<br>
B <- Reg[IR[20:16]]<br>
Imm <- sign extended IR[15:0] (extend the value to 32 bits by replicating the MSB and placing it on the left)<br>
## 3)EX: execution/address calc
- ALUOut <- A + Imm //LW R3, 100(A) <br>
- ALUOut <- A func B //SUB R2, A, B<br>
- ALUOut <- A func Imm //SUBI R2, A, Imm<br>
- ALUOut <- NPC + Imm // BEQZ R2, Label<br>
cond <- A op 0 //== or !=
## 4) MEM: memory access/branch completion
- Load: <br>
PC <- NPC;<br>
LMD <- Mem[ALUOut];
- Store: <br>
PC <- NPC;<br>
Mem[ALUOut] <- B;
- branch<br>
if (cond) PC <- ALUOut<br>
else <t> Pc <- NPC
- other instructions<br>
Pc <- NPC
## 5) WB: writeback
- reg-reg instruction<br>
Reg[IR[15:11]] <- ALUOut
- reg-imm instruction <br>
Reg[IR[20:16]] <- ALUOut
- load instr<br>
Reg[IR[20:16]] <- LMD
