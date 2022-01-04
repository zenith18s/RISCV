`timescale 1 ns / 1 ps

module pc(reset,clk,pc_op,pc_in,pc_out);

input reset,clk;
input [1:0] pc_op;
input [15:0] pc_in;

output reg [15:0] pc_out;
reg [15:0] temp_val;

always@ (posedge clk or posedge reset)
begin
	if (reset == 1)
	begin
		pc_out <= 16'd0;
		temp_val <= 16'd0;
	end
	
	else
	begin
		case (pc_op)
			2'd0 : pc_out <= 16'd0; //reset
			2'd1 : begin
				pc_out <= pc_in; //preset 
				temp_val <= pc_in;
				end
			2'd2 : begin
				pc_out <= pc_out + 16'd1; //incr
				temp_val <= pc_out + 16'd1;
				end
			2'd3 : pc_out <= temp_val; //halt
			default : pc_out <= pc_in;
		endcase
	end
end

endmodule
