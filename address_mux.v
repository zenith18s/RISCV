`timescale 1 ns / 1 ps

module address_mux (pc_out,regA,adrs_ctrl,adrs_bus);

input [15:0] pc_out, regA;
input adrs_ctrl;

output reg [15:0] adrs_bus;

always@(*)
begin
	//adrs_bus = ((adrs_ctrl) ? pc_out : regA);
	if (adrs_ctrl)
	begin
		adrs_bus = pc_out;
	end
	else
	begin
		
		adrs_bus = regA;
			
	end
end

endmodule
