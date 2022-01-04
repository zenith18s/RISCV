`timescale 1 ns / 1 ps

module immediate_operation (clk,imm_en,imm,flag,imm_out,reset);

input clk,imm_en,flag,reset;
input [7:0] imm;

output reg [15:0] imm_out;

always @(posedge clk or posedge reset)
begin
	if (reset == 1)
	begin
		imm_out <= 16'd0;
	end
	
	else if (imm_en == 1)
	begin
		if (flag == 1)
			imm_out <= {imm[7:0],8'd0};
		else
			imm_out <= {8'd0,imm[7:0]};
	end

	else
		imm_out <= 16'b0;
end
endmodule
