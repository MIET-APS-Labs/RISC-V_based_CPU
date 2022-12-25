`timescale 1ns / 1ps

//***********************************
// Address space
//  Using 2 WORDS
//  0x80003000 - keyboard key code
//  0x80003004 - valid data
//  0x80003008 - reset

// Bytes addressing in words
//  _ _ _ _ | _ _ _ _
//  0 1 2 3   4 5 6 7

`define ADDR_LEN 4 // $clog2(`8) + 1

`define C_KEY_CODE_REG 4'h0
`define C_VALID_REG 4'h4
`define C_RST_REG 4'h8

module ps2_keyboard_control (
    input clk_200_i,

    input [`WORD_LEN-1:0] wdata_i,
    input [`ADDR_LEN-1:0] addr_i,  // byte addressable
    input we_i,

    input ps2_clk_i,
    input ps2_data_i,
    output logic [`WORD_LEN-1:0] data_o
);

  logic valid_data;
  logic [7:0] keyboard_data;

  ps2_keyboard my_keyboard (
      .a_rst_i(rst_reg[0]),
      .clk_50_i(clk_50),
      .ps2_clk_i(ps2_clk_i),
      .ps2_data_i(ps2_data_i),
      .valid_data_o(valid_data),
      .data_o(keyboard_data)
  );

  // CLK divider 200 MHz -> 50 MHz
  logic clk_50;
  logic [2:0] clk_cntr_4;
  parameter DIVISOR = 3'd4;
  assign clk_50 = clk_cntr_4[2];
  always_ff @(posedge clk_200_i) begin
    if (rst_reg[0]) begin
      clk_cntr_4 <= 2'b0;
    end else begin
      if (clk_cntr_4 >= DIVISOR) begin
        clk_cntr_4 <= 2'b1;
      end else begin
        clk_cntr_4 <= clk_cntr_4 + 1;
      end
    end

  end

  logic [`WORD_LEN-1:0] rst_reg;

  // enum {
  //   C_KEY_CODE_REG = `ADDR_LEN'h0,
  //   C_VALID_REG = `ADDR_LEN'h04,
  //   C_RST_REG = `ADDR_LEN'h08
  // } C_ADDR;

  // Reset control
  always_ff @(posedge clk_200_i) begin
    if (we_i) begin
      if (addr_i == `C_RST_REG) begin
        rst_reg <= wdata_i;
      end
    end
  end


  always_comb begin
    if (!rst_reg[0]) begin
      case (addr_i)
        `C_KEY_CODE_REG: begin
          data_o <= {{(`WORD_LEN - `BYTE_WIDTH) {1'b0}}, keyboard_data};
        end
        `C_VALID_REG: begin
          data_o <= {{(`WORD_LEN - `BYTE_WIDTH) {1'b0}}, {`BYTE_WIDTH{valid_data}}};
        end
        default: begin
        end
      endcase
    end
  end

endmodule