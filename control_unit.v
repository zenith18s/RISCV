`timescale 1 ns / 1 ps

module control_unit (clk,reset,flag,opcode,inst_wr,pc_op,en_reg,regD_wr,imm_en,adrs_ctrl,mem_rd,mem_wr);

input clk,reset,flag;
input [3:0] opcode;
output reg inst_wr,regD_wr,imm_en,adrs_ctrl,mem_rd,mem_wr,en_reg;
output reg [1:0] pc_op;

reg [1:0] state;
reg [1:0] next_state;

parameter [1:0] Fetch = 2'b00;
parameter [1:0] Decode = 2'b01;
parameter [1:0] Execute = 2'b10;
parameter [1:0] Write_back = 2'b11;

always @(posedge clk or posedge reset)
begin
	if (reset == 1)
	begin
		/*inst_wr <= 0;
		en_reg <= 0;
		mem_rd <= 1;
		mem_wr <= 0;
		imm_en <= 0;
		adrs_ctrl <= 1;
		regD_wr <= 0;
		pc_op <= 2'b00;
		state <= 2'b00;*/
		state <= 2'b00;

		//Fetch = 2'b00;
		//Decode = 2'b01;
		//Execute = 2'b10;
		//Write_back = 2'b11;

	end
	
	else 
	begin
		state <= next_state;
	end
end

always @(state or flag or opcode)
begin
	case(state)
	
	Fetch:
		begin
			
			inst_wr <= 1'b1;		

			en_reg <= 1'b0;

			regD_wr <= 1'b0;

			imm_en <= 1'b0;

			adrs_ctrl <= 1'b1;

			mem_rd <= 1'b1;

			mem_wr <= 1'b0;
			
			if (reset == 1)
			begin
				pc_op <= 2'b00;
				next_state <= Fetch;
			end
		
			else
			begin
				pc_op <= 2'b11;				
				next_state <= Decode;
			end
		
		end
	
	Decode: 
		begin
			if (opcode == 4'b0110 || opcode == 4'b0111)
			begin

			inst_wr <= 1'b0;

			pc_op <= 2'b11;

			en_reg <= 1'b1;

			regD_wr <= 1'b0;
	
			imm_en <= 1'b1;

			adrs_ctrl <= 1'b0;

			mem_rd <= 1'b0;

			mem_wr <= 1'b0;

			next_state <= Execute;
		end

		else 
		begin
			inst_wr <= 1'b0;

			pc_op <= 2'b11;

			en_reg <= 1'b1;

			regD_wr <= 1'b0;
	
			imm_en <= 1'b0;

			adrs_ctrl <= 1'b1;

			mem_rd <= 1'b0;

			mem_wr <= 1'b0;

			next_state <= Execute;
		end
		end
			

	Execute: 
		begin
		
			imm_en <= 1'b0;

			en_reg <= 1'b0;

			adrs_ctrl <= 1'b0;

			inst_wr <= 1'b0;

			

			regD_wr <= 1'b0;

			mem_wr <= 1'b0;
			
			mem_rd <= 1'b0;
			
			pc_op <= 2'b11;

			if (opcode == 4'b0000 || opcode == 4'b0010 || opcode == 4'b0011 || opcode == 4'b0100 || opcode == 4'b0101 || opcode == 4'b1001 || opcode == 4'b1010 || opcode == 4'b1011 || opcode == 4'b1100 || opcode == 4'b0001)
			begin
				en_reg <= 1'b1;

				regD_wr <= 1'b0;

				adrs_ctrl <= 1'b1;

				mem_rd <= 1'b1;
			end

			else if (opcode == 4'b1000)
			begin
				en_reg <= 1'b0;
			
				imm_en <= 1'b1;
			end

			else if (opcode == 4'b0110)
			begin
				mem_rd <= 1'b1;
		
				adrs_ctrl <= 1'b0;

				imm_en <= 1'b1;
			end

			else if (opcode == 4'b1101)
			begin
				pc_op <= 2'b01;

					if (flag == 0)
					begin
						imm_en <= 1'b1;
					end
				
					else 
					begin
						en_reg <= 1'b1;
		
						regD_wr <= 1'b0;

						adrs_ctrl <= 1'b1;

						mem_rd <= 1'b1;
					end
			end

			else if (opcode == 4'b1110)
			begin
				adrs_ctrl <= 1'b0;
			end

			next_state <= Write_back;

		end				

	Write_back:
		begin
	
			inst_wr <= 1'b0;

			en_reg <= 1'b1;

			imm_en <= 1'b0; 

			adrs_ctrl <= 1'b0;

			mem_rd <= 1'b0;

			if (opcode == 4'b0111)
			begin

				mem_wr <= 1'b1;

				regD_wr <= 1'b0;

				imm_en <= 1'b1;

				adrs_ctrl <= 1'b0;
			end

			else if (opcode == 4'b1000)
			begin
				imm_en <= 1'b1;
	
				mem_wr <= 1'b0;
		
				regD_wr <= 1'b1;

				adrs_ctrl <= 1'b1;
			end

		else if (opcode == 4'b0110)
		begin
			mem_rd <= 1'b1;
		
			imm_en <= 1'b0;

			mem_wr <= 1'b0;

			regD_wr <= 1'b1;

			adrs_ctrl <= 1'b0;
		end

		else if (opcode == 4'b0000 || opcode == 4'b0001 || opcode == 4'b0010 || opcode == 4'b0011 || opcode == 4'b0100 || opcode == 4'b0101 || opcode == 4'b1001 || opcode == 4'b1010 || opcode == 4'b1011 || opcode == 4'b1100)
		begin
			mem_wr <= 1'b0;

			regD_wr <= 1'b1;

			adrs_ctrl <= 1'b1;
		end

		pc_op <= (opcode == 4'b1101) ? 2'b11 : 2'b10;

		next_state <= Fetch;
			
		end
		
		default : next_state <= Fetch;
	
	endcase

end

endmodule
		
		
			
			

		
