module Mux21(out, in,  sel);
   // declare ports & internal wires
   input [1:0] in;
   input       sel;
   output      out;
   wire	       w1, w2, w3;

   // instantiate logic gates
   not not1(w1, sel); // w1 = sel'
   and and1(w2, in[0], w1); // w2 = (in[0])*sel'
   and and2(w3, in[1], sel); // w3 = (in[1])*sel
   or or1(out, w2, w3); // out = (in[1]*sel) + (in[0]*sel')

endmodule
