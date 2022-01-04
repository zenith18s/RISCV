`timescale 1 ns / 1 ps

module instr_decoder (reset,clk,inst_wr,inst,opcode,rD,rA,rB,imm,flag);

input reset, clk,inst_wr;
input [15:0] inst;
output reg [3:0] opcode;
output reg [2:0] rD, rA, rB;
output reg [7:0] imm;
output reg flag;

always @(posedge clk or posedge reset)
begin
	if (reset == 1)  
	begin
		opcode <= 4'b0;
		rD <= 3'b0;
		rA <= 3'b0;
		rB <= 3'b0;
		imm <= 8'b0;
		flag <= 1'b0;
	end

	else
	begin
		if (inst_wr == 1)  
		begin
			opcode <= inst[15:12];
			rD <= inst[11:9];
			flag <= inst[8];
			rA <= inst[7:5];
			rB <= inst[4:2];
			imm <= inst[7:0]; //imm goes to immediate operation not ALU 
		end
	end
end
endmodule
			

