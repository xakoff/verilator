// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed under the Creative Commons Public Domain, for
// any use, without warranty, 2024 by Yutetsu TAKATSUKASA.
// SPDX-License-Identifier: CC0-1.0

module t (/*AUTOARG*/
   // Outputs
   hit,
   // Inputs
   clk
   );

   input clk;
   output logic       hit;

   logic [31:0] addr;
   logic [11:0] match_item0, match_item1;
   int          cyc;

   initial addr = 32'h380;

   always @ (posedge clk) begin
      cyc <= cyc + 1;
      addr <= 32'h380 + cyc;
      match_item0 = 12'h 380 + cyc[11:0];
      match_item1 = 12'h 390 - cyc[11:0];
      if (cyc == 9) begin
         $write("*-* All Finished *-*\n");
         $finish;
      end
   end

   always_comb begin
      hit = 1;
      unique case (addr[11:0])
        match_item0: $display("match_item0");
        match_item1: $display("match_item1");
        default: hit = 0;
      endcase
   end

endmodule
