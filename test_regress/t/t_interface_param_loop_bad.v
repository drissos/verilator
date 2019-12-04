// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2017 by Johan Bjork.

module t ();
   simple_bus #(.width(simple.get_width()))  sb_intf();
   simple_bus #(.width(sb_intf.get_width())) simple();

   initial begin
      $write("*-* All Finished *-*\n");
      $finish;
   end
endmodule

interface simple_bus #(parameter int width = 8);
   logic [width-1:0] data;

   function automatic int get_width();
       return width;
   endfunction
endinterface
