module SignExtender(BusImm, Inst, Ctrl);
   // declare i/o ports 
   output reg [63:0] BusImm; 
   input [25:0]  Inst; 
   input [1:0]	 Ctrl;

   // For I-type: Ctrl = [0, 0]
   // For D-type: Ctrl = [0, 1]
   // For B-type: Ctrl = [1, 0]
   // For CB-type: Ctrl = [1, 1]

   // switch over all possibilities of Ctrl
    always @(*)
      begin

       case (Ctrl)
         2'b00:  BusImm = {{52{1'b0}}, Inst[21:10]}; //zero extending 12 bit immediate stored in I[21:10] since this is R-type
         2'b01:  BusImm = {{55{Inst[20]}}, Inst[20:12]}; //sign extending 9 bit immediate stored in I[20:12] since this is D-type (memory access)
         2'b10:  BusImm = {{38{Inst[25]}}, Inst[25:0]}; //sign extending 26 bit immediate stored in I[25:0] since this is B-type (unconditional branch)
         2'b11:  BusImm = {{52{Inst[23]}}, Inst[23:5]}; //sign extending 19 bit immediate stored in I[23:5] since this is CB-type (conditional branch)
	 default: BusImm = 0;
       endcase

      end
   
   
endmodule
