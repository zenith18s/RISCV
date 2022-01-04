`timescale 1 ns / 1 ps

module internal_registers (reset,clk,en_reg,rD,rA,rB,regD_wr,regD,regA,regB);

input reset,clk,en_reg,regD_wr;
input [2:0] rD; //provides address for writing
input [2:0] rA,rB; //provide address for reading
input [15:0] regD;

output reg [15:0] regA;
output reg [15:0] regB;

reg [15:0] int_reg [7:0]; 

always @(posedge clk or posedge reset)
begin
	if (reset == 1)
	begin
		int_reg[0] <= 16'b0;
		int_reg[1] <= 16'b0;
		int_reg[2] <= 16'b0;
		int_reg[3] <= 16'b0;
		int_reg[4] <= 16'b0;
		int_reg[5] <= 16'b0;
		int_reg[6] <= 16'b0;
		int_reg[7] <= 16'b0;
		
	end

	else
	begin
		if (regD_wr == 1) //write operation
		begin
			case (rD)
				3'b000 : int_reg[0] <= regD;
				3'b001 : int_reg[1] <= regD;
				3'b010 : int_reg[2] <= regD;
				3'b011 : int_reg[3] <= regD;
				3'b100 : int_reg[4] <= regD;
				3'b101 : int_reg[5] <= regD;
				3'b110 : int_reg[6] <= regD;
				3'b111 : int_reg[7] <= regD;
			endcase
		end
	
		if (en_reg == 1 && regD_wr == 0) //read operation
		begin
			case (rA)
				3'b000 : regA <= int_reg[0]; 
				3'b001 : regA <= int_reg[1];
				3'b010 : regA <= int_reg[2];
				3'b011 : regA <= int_reg[3];
				3'b100 : regA <= int_reg[4];
				3'b101 : regA <= int_reg[5];
				3'b110 : regA <= int_reg[6];
				3'b111 : regA <= int_reg[7];
			endcase
			

			case (rB)
				3'b000 : regB <= int_reg[0]; 
				3'b001 : regB <= int_reg[1];
				3'b010 : regB <= int_reg[2];
				3'b011 : regB <= int_reg[3];
				3'b100 : regB <= int_reg[4];
				3'b101 : regB <= int_reg[5];
				3'b110 : regB <= int_reg[6];
				3'b111 : regB <= int_reg[7];
			endcase
	
			
		end

			

	end
end
endmodule
	
