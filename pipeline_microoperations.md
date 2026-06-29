
# INSTRUCTION CYCLE
## structure of latches-
- between every statge of the cycle, we will have a latch labled stage1_stage2<br> 
for example, EX_MEM
- each latch will be one clock cycle ahead of the latch in front of it 
- every latch will have temporary registers stored in it<br>
for example, EX_MEM_IR: instruction reg stored in EX_MEM latch
## 1) IF: instrction fetch <br>
if (EX_MEM_IR[opcode]==branch & EX_MEM_cond)<br>
IF_ID_NPC, PC <- EX_MEM_ALUOut + 1<br>
IF_ID_IR <- Mem[EX_MEM_ALUOut];<br>
else<br>
IF_ID_NPC, PC = PC + 1;
## 2)ID: instrction decode, register fetch<br>
ID_EX_A <- Reg[IF_ID_IR[25:21]]<br>
ID_EX_B <- Reg[IF_ID_IR[20:16]]<br>
ID_EX_NPC <- IF_ID_NPC<br>
ID_EX_IR <- IF_ID_IR<br>
ID_EX_Imm <- SignExtend(IF_ID_IR[15:0])<br>
## 3)EX: execution/address calc
EX_MEM_IR <- ID_EX_IR<br>
- Load/Store: <br>
EX_MEM_ALUOut <- ID_EX_A + ID_EX_Imm<br>
EX_MEM_B <- ID_EX_B<br>
- Reg-Reg: <br>
EX_MEM_ALUOut <- ID_EX_A func ID_EX_B<br>
- Reg-Imm: <br>
EX_MEM_ALUOut <- ID_EX_A func ID_EX_Imm<br>
- Branch: <br>
EX_MEM_ALUOut <- ID_EX_NPC + ID_EX_Imm<br>
EX_MEM_cond <- (ID_EX_A == 0)<br>
## 4) MEM: memory access/branch completion
MEM_WB_IR <- EX_MEM_IR
- Load: <br>
MEM_WB_LMD <- Mem[EX_MEM_ALUOut];
- Store: <br>
Mem[EX_MEM_ALUOut] <- EX_MEM_B;
- ALU:<br>
MEM_WB_ALUOut <- EX_MEM_ALUOut;
## 5) WB: writeback
- reg-reg instruction<br>
Reg[MEM_WB_IR[15:11]] <- MEM_WB_ALUOut
- reg-imm instruction <br>
Reg[MEM_WB_IR[20:16]] <- MEM_WB_ALUOut
- load instr<br>
Reg[MEM_WB_IR[20:16]] <- MEM_WB_LMD
