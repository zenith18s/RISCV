`include "../SRC/alu.v"
`include "../SRC/instr_decoder.v"
`include "../SRC/pc.v"
`include "../SRC/internal_registers.v"
`include "../SRC/control_unit.v"
`include "../SRC/immediate_operation.v"
`include "../SRC/program_counter_preset.v"
`include "../SRC/data_mux.v"
`include "../SRC/address_mux.v"
`timescale 1 ns / 1 ps

module uProcessor (MAIN_CLK, MAIN_RST, WRITE_DATA_BUS, READ_DATA_BUS, ADDR_BUS, MEM_WR, MEM_RD);

input MAIN_CLK, MAIN_RST;
input [15:0] READ_DATA_BUS;

output [15:0] WRITE_DATA_BUS, ADDR_BUS;
output MEM_WR;
output MEM_RD;

wire flag;
wire [3:0] opcode;
wire inst_wr;
wire [1:0] pc_op;
wire en_reg;
wire regD_wr;
wire imm_en;
wire adrs_ctrl;
wire [2:0] rD,rA,rB;
wire [7:0] imm;
wire [15:0] regA,regB;
wire [15:0] alu_out;
wire eq_flag;
wire [15:0] regD;
wire [15:0] pc_in;
wire [15:0] pc_out; 
wire [15:0] imm_out;


/////////////////////////////////////////////////////////////////////////////////////

alu l1 (.flag(flag),.regA(regA),.regB(regB),.opcode(opcode),.alu_out(alu_out),.eq_flag(eq_flag));

instr_decoder l2 (.reset(MAIN_RST),.clk(MAIN_CLK),.inst_wr(inst_wr),.inst(READ_DATA_BUS),.opcode(opcode),.rD(rD),.rA(rA),.rB(rB),.imm(imm),.flag(flag));

pc l3 (.reset(MAIN_RST),.clk(MAIN_CLK),.pc_op(pc_op),.pc_in(pc_in),.pc_out(pc_out));

internal_registers l4 (.reset(MAIN_RST),.clk(MAIN_CLK),.en_reg(en_reg),.rD(rD),.rA(rA),.rB(rB),.regD_wr(regD_wr),.regD(regD),.regA(regA),.regB(regB));

control_unit l5 (.clk(MAIN_CLK),.reset(MAIN_RST),.flag(flag),.opcode(opcode),.inst_wr(inst_wr),.pc_op(pc_op),.en_reg(en_reg),.regD_wr(regD_wr),.imm_en(imm_en),.adrs_ctrl(adrs_ctrl),.mem_rd(MEM_RD),.mem_wr(MEM_WR));

immediate_operation l6 (.clk(MAIN_CLK),.imm_en(imm_en),.imm(imm),.flag(flag),.imm_out(imm_out));

program_counter_preset l7 (.imm_out(imm_out),.regA(regA),.flag(flag),.pc_in(pc_in));

data_mux l8 (.read_data_bus(READ_DATA_BUS),.imm_out(imm_out),.alu_out(alu_out),.imm_en(imm_en),.opcode(opcode),.regD(regD));

address_mux l9 (.pc_out(pc_out),.regA(regA),.adrs_ctrl(adrs_ctrl),.adrs_bus(ADDR_BUS));

//////////////////////////////////////////////////////////////////////////////////////////////////////////

assign WRITE_DATA_BUS = regB;

endmodule		






