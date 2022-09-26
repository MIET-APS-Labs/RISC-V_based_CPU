`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// ALU based on RISC-V, extended with simple SIMD commands
//////////////////////////////////////////////////////////////////////////////////

module alu #(
    parameter WORD_LEN   = 32,
    parameter ALU_OP_LEN = 5
) (
    input [  `WORD_LEN-1:0] A,
    input [  `WORD_LEN-1:0] B,
    input [`ALU_OP_LEN-1:0] ALUOp,

    output reg Flag,
    output reg [`WORD_LEN-1:0] Result
);

  logic need_sub;

  logic [`WORD_LEN-1:0] adder_res;
  logic adder_carry_out;

  N_bit_full_adder #(`WORD_LEN) adder (
      .num1(A),
      .num2(B),
      .sub (need_sub),

      .carry_out(adder_carry_out),
      .result(adder_res)
  );

  logic [`SIMD_OPERAND_NUM-1:0] SIMD_carry;
  logic [`WORD_LEN-1:0] SIMD_res;

  SIMD_add #(`WORD_LEN, `SIMD_OPERAND_DIGIT, `SIMD_OPERAND_NUM) SIMD_adder (
      .num1(A),
      .num2(B),
      .sub (need_sub),

      .carry_out(SIMD_carry),
      .result(SIMD_res)
  );

  always_ff @(ALUOp) begin
    case (ALUOp)
      `SUB: begin
        need_sub = 1;
      end

      `SLT: begin
        need_sub = 1;
      end

      `BLT: begin
        need_sub = 1;
      end

      `BGE: begin
        need_sub = 1;
      end

      `SIMD_SUB: begin
        need_sub = 1;
      end

      default: begin
        need_sub = 0;
      end
    endcase

  end

  always @* begin
    case (ALUOp)
      `ADD: begin
        Result = adder_res;
        Flag   = adder_carry_out;
      end

      `SUB: begin
        Result = adder_res;
        Flag   = 0;
      end

      `SLL: begin
        Result = (A << B);
        Flag   = 0;
      end

      `SLT: begin
        Result = adder_res[`WORD_LEN-1];
        Flag   = 0;
      end

      `SLTU: begin
        Result = (A < B);
        Flag   = 0;
      end

      `XOR: begin
        Result = (A ^ B);
        Flag   = 0;
      end

      `SRL: begin
        Result = (A >> B);
        Flag   = 0;
      end

      `SRA: begin
        Result = ($signed(A) >>> B);
        Flag   = 0;
      end

      `OR: begin
        Result = (A | B);
        Flag   = 0;
      end

      `AND: begin
        Result = (A & B);
        Flag   = 0;
      end

      `BEQ: begin
        Result = 0;
        Flag   = (A == B);
      end

      `BNE: begin
        Result = 0;
        Flag   = (A != B);
      end

      `BLT: begin
        Result = 0;
        Flag   = $signed(A < B);
      end

      `BGE: begin
        Result = 0;
        Flag   = $signed(A >= B);
      end

      `BLTU: begin
        Result = 0;
        Flag   = (A < B);
      end

      `BGEU: begin
        Result = 0;
        Flag   = (A >= B);
      end

      `SIMD_ADD: begin
        Result = SIMD_res;
        Flag   = 0;
      end

      `SIMD_SUB: begin
        Result = SIMD_res;
        Flag   = 0;
      end

      default: begin
        Result = 0;
        Flag   = 0;
      end
    endcase
  end
endmodule