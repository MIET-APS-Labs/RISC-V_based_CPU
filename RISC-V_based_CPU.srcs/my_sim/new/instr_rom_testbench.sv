`timescale 1ns / 1ps

`define WORD_LEN 32
`define BYTE_WIDTH 8

`define INSTR_DEPTH 512

module instr_rom_testbench ();

  logic CLK;
  parameter PERIOD = 20;
  always begin
    CLK = 1'b0;
    #(PERIOD / 2) CLK = 1'b1;
    #(PERIOD / 2);
  end

  logic [`WORD_LEN-1:0] instruction_init;
  instr_rom #(`WORD_LEN, `INSTR_DEPTH, "prog.txt") dut_init (
      .adr(clk_cntr),
      .rd (instruction_init)
  );

  logic [`WORD_LEN-1:0] instruction_nullifyed;
  instr_rom #(`WORD_LEN, `INSTR_DEPTH) dut_nullifyed (
      .adr(clk_cntr),
      .rd (instruction_nullifyed)
  );

  parameter COUNTER_WIDTH = $clog2(`INSTR_DEPTH);
  bit [COUNTER_WIDTH-1:0] clk_cntr;
  initial begin
    $display("\nCheck nullifyed Instr ROM\n");
    clk_cntr <= 0;
    for (int i = 0; i < `INSTR_DEPTH; i += 4) begin
      @(posedge CLK);
      #5;
      $display("%d) Instruction = %b", clk_cntr, instruction_nullifyed);
      clk_cntr <= clk_cntr + (`WORD_LEN / `BYTE_WIDTH);
    end
    
    $display("\nCheck Instr ROM initialized with mem init file\n");
    for (int i = 0; i < `INSTR_DEPTH; i += 4) begin
      @(posedge CLK);
      #5;
      $display("%d) Instruction = %b", clk_cntr, instruction_init);
      clk_cntr <= clk_cntr + (`WORD_LEN / `BYTE_WIDTH);
    end
    $finish;
  end

endmodule
