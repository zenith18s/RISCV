`timescale 1 ns / 1 ps

module program_counter_preset (imm_out,regA,flag,pc_in);

input [15:0] imm_out, regA;
input flag;

output reg [15:0] pc_in;

always @(*)
begin
	//pc_in <= (flag ? regA : imm_out);
	if (flag)
	begin
		pc_in = regA;
	end
	else
	begin
		pc_in = imm_out;	
	end
end

endmodule
