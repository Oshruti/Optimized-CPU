module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
   input [63:0] CurrentPC, SignExtImm64; 
   input 	Branch, ALUZero, Uncondbranch; 
   output reg [63:0] NextPC; 

   always @(*)
     begin
	// Check branch conditions; if branch not taken, PC += 4
	     if (Uncondbranch) // unconditional branch taken
	       NextPC = CurrentPC + (SignExtImm64 << 2);
	     else  if (Branch && ALUZero) // conditional branch taken
	       NextPC = CurrentPC + (SignExtImm64 << 2);
	     else // neither path taken, PC += 4
	       NextPC = CurrentPC + 64'b100;
     end // always @ (*)


endmodule
