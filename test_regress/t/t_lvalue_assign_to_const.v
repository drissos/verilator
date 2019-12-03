// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2019 by Driss Hafdi.

module t (/*AUTOARG*/
   // Inputs
   clk,
   rst
);
  input clk;
  input rst;

  localparam width = 8;

  logic [7:0] ctrl_inc_single;
  logic [7:0] ctrl_inc_double;

  logic [7:0] cnt_single;
  always_ff @(posedge clk) begin
      if (rst) begin
          cnt_single <= '0;
      end
      else if (ctrl_inc_single != '0 && cnt_single != '1) begin
          cnt_single <= cnt_single + 1'd1;
      end
  end

  logic [7:0] cnt_double;
  always_ff @(posedge clk) begin
      if (rst) begin
          cnt_double <= '0;
      end
      else if (ctrl_inc_double != '0 && cnt_double != '1) begin
          cnt_double <= cnt_double + 1'd1;
      end
  end

  always_comb ctrl_inc_single = '0;
  always_comb ctrl_inc_double = '0;

  testMod #(.width(width)) test_i (.data_i(cnt_single));
  testMod #(.width(width)) test_j (.data_i(cnt_double));

  initial begin
      $write("*-* All Finished *-*\n");
      $finish;
  end

endmodule

module testMod #(
    parameter int width = 8
)
(
    input wire [width-1:0] data_i
);

  typedef logic [63:0] time_t;
  time_t [width-1:0] last_transition;
  genvar b;
  generate
      for (b = 0; b < width; b++) begin : gen_trans
          always_ff @(posedge data_i[b] or negedge data_i[b]) begin
              last_transition[b] <= $time;
          end
      end
  endgenerate

endmodule
