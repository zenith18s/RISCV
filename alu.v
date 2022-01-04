`timescale 1 ns / 1 ps

module alu (flag,regA,regB,opcode,alu_out,eq_flag);

input flag;
input [15:0] regA,regB;
input [3:0] opcode;

output reg [15:0] alu_out;
output reg eq_flag;


always@(*)
begin

	eq_flag = (alu_out == 16'b0) ? 1'b1 : 1'b0;
	

	case (opcode)
		4'b0000 : alu_out = (flag ? ($signed(regA) + $signed(regB)) : ($unsigned(regA) + $unsigned(regB))); //add.s and add.u
	
		4'b0001 : alu_out = (flag ? ($signed(regA) - $signed(regB)) : ($unsigned(regA) - $unsigned(regB))); //sub.s and sub.u

		4'b0010 : alu_out = regA | regB; //bitwise OR

		4'b0011 : alu_out = regA ^ regB; //bitwise XOR

		4'b0100 : alu_out = regA & regB; //bitwise AND 

		4'b0101 : alu_out = ~ regA; //bitwise NOT

		4'b1001 : alu_out = flag ? ($signed(regA) == $signed(regB) ? 16'b1 : 16'b0) : ($unsigned(regA) == $unsigned(regB) ? 16'b1 : 16'b0); //equality

		4'b1010 : alu_out =  flag ? ($signed(regA) != $signed(regB) ? 16'b1 : 16'b0) : ($unsigned(regA) != $unsigned(regB) ? 16'b1 : 16'b0); //inequality

		4'b1011 : alu_out = flag ? ($signed(regA) < $signed(regB) ? 16'b1 : 16'b0) : ($unsigned(regA) < $unsigned(regB) ? 16'b1 : 16'b0); //less than

		4'b1100 : alu_out = flag ? ($signed(regA) >= $signed(regB) ? 16'b1 : 16'b0) : ($unsigned(regA) >= $unsigned(regB) ? 16'b1 : 16'b0); //greater or equal

		default : alu_out = 16'b0;

	endcase
end
endmodule
		
		

		

