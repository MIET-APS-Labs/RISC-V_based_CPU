`define WORD_LEN 32
`define BYTE_WIDTH 8

`define RESET_ADDR 32'h00000000

`define PC_NEXT_INSTR_INCREASE 4

`define CSR_OP_LEN 3

//////////////////////////////////////////////
//  ALU Defines

`define ALU_OP_WIDTH 5
`define ALU_OP_NUM 16

// ALU op code format flag_sub_opcode
`define ALU_ADD 5'b 00000
`define ALU_SUB 5'b 01000

// comparisons
`define ALU_SLT 5'b 01001
`define ALU_SLTU 5'b 01010

// shifts
`define ALU_SLL 5'b 00001
`define ALU_SRL 5'b 00011
`define ALU_SRA 5'b 00100

// logic

`define ALU_XOR 5'b 00101
`define ALU_OR 5'b 00110
`define ALU_AND 5'b 00111

`define ALU_BEQ 5'b 10000
`define ALU_BNE 5'b 10001
`define ALU_BLT 5'b 11000
`define ALU_BGE 5'b 11001
`define ALU_BLTU 5'b 11010
`define ALU_BGEU 5'b 11011

//  SIMD op codes
`define ALU_SIMD_ADD 5'b 10010	
`define ALU_SIMD_SUB 5'b 11100

/////////////////////////////////////////////



//////////////////////////////////////////////
//  Register File Defines

`define RF_DEPTH 32
//////////////////////////////////////////////



//////////////////////////////////////////////
//  Load-Store Unit Defines

`define LDST_SIZE_TYPES_NUM 5

// load store size types
`define LDST_B 3'b000
`define LDST_H 3'b001
`define LDST_W 3'b010
`define LDST_BU 3'b100
`define LDST_HU 3'b101
//////////////////////////////////////////////


//////////////////////////////////////////////
// MUX Cases
// operand a selection
`define OP_A_RS1 2'b00
`define OP_A_CURR_PC 2'b01
`define OP_A_ZERO 2'b10

// operand b selection
`define OP_B_RS2 3'b000
`define OP_B_IMM_I 3'b001
`define OP_B_IMM_U 3'b010
`define OP_B_IMM_S 3'b011
`define OP_B_INCR 3'b100

// writeback source selection
`define WB_EX_RESULT 1'b0
`define WB_LSU_DATA 1'b1

//////////////////////////////////////////////
// CSR Write options
`define CSR_OP_WRITE_REG_ZERO 2'd0
`define CSR_OP_WRITE_REG_WD 2'd1
`define CSR_OP_WRITE_REG_NOT_WD_AND_RD 2'd2
`define CSR_OP_WRITE_REG_WD_OR_RD 2'd3
//////////////////////////////////////////////


//////////////////////////////////////////////
`define RD_SEL_LEN 1    // log2(2)
// Address decoder read source
`define RDATA_MEM 1'd0
`define RDATA_KEYBOARD 1'd1
//////////////////////////////////////////////


//////////////////////////////////////////////
//  CYBERcobra 3000 Pro 2.0 Instuction format
// B[31] C[30] WS[29:28] ALUop[27:23] RA1[22:18] RA2[17:13] CONST[12:5] WA[4:0]

`define C_COBRA_INSTR_WA 4:0

`define C_COBRA_INSTR_CONST 12:5
`define CONST_LEN 8

`define C_COBRA_INSTR_RA2 17:13
`define C_COBRA_INSTR_RA1 22:18

`define C_COBRA_INSTR_ALUop 27:23

`define C_COBRA_INSTR_WS_2 28
`define C_COBRA_INSTR_WS_1 29
`define C_COBRA_INSTR_WS 29:28

`define C_COBRA_INSTR_C 30
`define C_COBRA_INSTR_B 31


//////////////////////////////////////////////


//////////////////////////////////////////////
// RISC-V Instuction format

`define INSTR_OPCODE 6:2
`define INSTR_RS_1 19:15
`define INSTR_RS_2 24:20
`define INSTR_A3 11:7
`define INSTR_INSTR_LEN 1:0

`define INSTR_LEN_CODE 2'b11


// R-type instruction format
// funct7[31:25] rs2[24:20] rs1[19:15] funct3[14:12] rd[11:7] opcode[6:0]
`define R_TYPE_FUNCT_7 31:25
`define R_TYPE_RS_2 24:20
`define R_TYPE_RS_1 19:15
`define R_TYPE_FUNCT_3 14:12
`define R_TYPE_RD 11:7

// I-type instruction format
// imm[31:20] rs1[19:15] funct3[14:12] rd[11:7] opcode[6:0]
// I*-type funct7[31:25] shamt[24:20] rs1[19:15] funct3[14:12] rd[11:7] opcode[6:0]
`define I_TYPE_IMM_LEN 12
`define I_TYPE_IMM 31:20
`define I_TYPE_RS_1 19:15
`define I_TYPE_FUNCT_3 14:12
`define I_TYPE_ALT_FUNCT_7 31:25
`define I_TYPE_RD 11:7

// S-type instruction format
// imm[11:5]_[31:25] rs2[24:20] rs1[19:15] funct3[14:12] imm[4:0]_[11:7] opcode[6:0]
`define S_TYPE_IMM_11_5_LEN 7
`define S_TYPE_IMM_11_5 31:25
`define S_TYPE_RS_2 24:20
`define S_TYPE_RS_1 19:15
`define S_TYPE_FUNCT_3 14:12
`define S_TYPE_IMM_4_0_LEN 5
`define S_TYPE_IMM_4_0 11:7

// B-type instruction format
// imm[12|10:5]_[31:25] rs2[24:20] rs1[19:15] funct3[14:12] imm[4:1|11]_[11:7] opcode[6:0]
`define B_TYPE_IMM_LEN 13
`define B_TYPE_IMM_12 31
`define B_TYPE_IMM_10_5 30:25
`define B_TYPE_RS_2 24:20
`define B_TYPE_RS_1 19:15
`define B_TYPE_FUNCT_3 14:12
`define B_TYPE_IMM_4_1 11:8
`define B_TYPE_IMM_11 7

// U-type instruction format
// imm[31:12]_[31:12] rd[11:7] opcode[6:0]
`define U_TYPE_IMM_31_12_LEN 20
`define U_TYPE_IMM_31_12 31:12
`define U_TYPE_RD 11:7

// J-type instruction format
// imm[20|10:1|11|19:12]_[31:12] rd[11:7] opcode[6:0]
`define J_TYPE_IMM_LEN 21
`define J_TYPE_IMM_20 31
`define J_TYPE_IMM_10_1 30:21
`define J_TYPE_IMM_11 20
`define J_TYPE_IMM_19_12 19:12
`define J_TYPE_RD 11:7


//////////////////////////////////////////////
// Main decoder defines

`define JALR_LEN 2
`define JALR_MUX_PC_INC 2'b0
`define JALR_MUX_PC_RD1_IMM 2'b1
`define JALR_MUX_PC_MEPC 2'b10
`define JALR_MUX_PC_MTVEC 2'b11

`define NOP_INSTR 8'h13

// opcodes

`define OP_OPCODE 5'b01_100

`define OP_FUNCT_3_ADD_SUB 3'h0
`define OP_FUNCT_3_XOR 3'h4
`define OP_FUNCT_3_OR 3'h6
`define OP_FUNCT_3_AND 3'h7
`define OP_FUNCT_3_SLL 3'h1
`define OP_FUNCT_3_SRL_SRA 3'h5
`define OP_FUNCT_3_SLT 3'h2
`define OP_FUNCT_3_SLTU 3'h3

`define OP_FUNCT_7_ADD 7'h00
`define OP_FUNCT_7_SUB 7'h20
`define OP_FUNCT_7_XOR 7'h00
`define OP_FUNCT_7_OR 7'h00
`define OP_FUNCT_7_AND 7'h00
`define OP_FUNCT_7_SLL 7'h00
`define OP_FUNCT_7_SRL 7'h00
`define OP_FUNCT_7_SRA 7'h20
`define OP_FUNCT_7_SLT 7'h00
`define OP_FUNCT_7_SLTU 7'h00


`define OP_IMM_OPCODE 5'b00_100

`define OP_IMM_FUNCT_3_ADDI 3'h0
`define OP_IMM_FUNCT_3_XORI 3'h4
`define OP_IMM_FUNCT_3_ORI 3'h6
`define OP_IMM_FUNCT_3_ANDI 3'h7
`define OP_IMM_FUNCT_3_SLLI 3'h1
`define OP_IMM_FUNCT_3_SRLI 3'h5
`define OP_IMM_FUNCT_3_SRAI 3'h5
`define OP_IMM_FUNCT_3_SLTI 3'h2
`define OP_IMM_FUNCT_3_SLTIU 3'h3

`define OP_IMM_FUNCT_7_SLLI 7'h00
`define OP_IMM_FUNCT_7_SRLI 7'h00
`define OP_IMM_FUNCT_7_SRAI 7'h20


`define LUI_OPCODE 5'b01_101


`define LOAD_OPCODE 5'b00_000

`define LOAD_FUNCT_3_LB 3'h0
`define LOAD_FUNCT_3_LH 3'h1
`define LOAD_FUNCT_3_LW 3'h2
`define LOAD_FUNCT_3_LBU 3'h4
`define LOAD_FUNCT_3_LHU 3'h5


`define STORE_OPCODE 5'b01_000

`define STORE_FUNCT_3_SB 3'h0
`define STORE_FUNCT_3_SH 3'h1
`define STORE_FUNCT_3_SW 3'h2


`define BRANCH_OPCODE 5'b11_000

`define BRANCH_FUNCT_3_BEQ 3'h0
`define BRANCH_FUNCT_3_BNE 3'h1
`define BRANCH_FUNCT_3_BLT 3'h4
`define BRANCH_FUNCT_3_BGE 3'h5
`define BRANCH_FUNCT_3_BLTU 3'h6
`define BRANCH_FUNCT_3_BGEU 3'h7


`define JAL_OPCODE 5'b11_011


`define JALR_OPCODE 5'b11_001
`define JALR_FUNCT_3_SLTU 3'h0


`define AUIPC_OPCODE 5'b00_101


`define MISC_MEM_OPCODE 5'b00_011


`define SYSTEM_OPCODE 5'b11_100
`define SYSTEM_FUNCT_3_MRET 3'h0
`define SYSTEM_FUNCT_3_CSR_RW 3'h1
`define SYSTEM_FUNCT_3_CSR_RS 3'h2
`define SYSTEM_FUNCT_3_CSR_RC 3'h3

