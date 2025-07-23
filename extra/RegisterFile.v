`timescale 1ns/1ps
module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
output [63:0] BusA; //64 bit wide buses
output [63:0] BusB;
input [63:0] BusW;
input [4:0] RA; //5-bit wide register indexes
input [4:0] RB;
input [4:0] RW;
input RegWr; //write enable
input Clk;


reg [63:0] registers [31:0]; //internal register file

//initial begin
//   registers[31] = 64'b0; //set register 31 to be 0
//end

assign #2  BusA = (RA == 5'b11111) ? 64'b0 : registers[RA]; //assigning BusA with contents in RegisterA after 2 sec delay
assign #2  BusB = (RB == 5'b11111) ? 64'b0 : registers[RB]; //assigning BusB with contents in RegisterB after 2 sec delay


always@(negedge Clk) begin //writing to a register on falling clock edge
	if (RegWr && !(RW == 5'b11111)) //checking if Write is enabled (do not allow writing to register 31)
	  registers[RW] <= #3 BusW; //writing BusW contents to register
	
end


endmodule
