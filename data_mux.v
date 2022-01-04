`timescale 1 ns / 1 ps 

module data_mux (read_data_bus,imm_out,alu_out,imm_en,opcode,regD);

input [15:0] alu_out, read_data_bus, imm_out;
input [3:0] opcode;
input imm_en;

output reg [15:0] regD;

always@(*)
begin
	if (opcode == 4'b0110)
		regD = read_data_bus;
	else if (imm_en == 1'b1) //check for only if 
		regD = imm_out;
	else
		regD = alu_out;
end

endmodule
