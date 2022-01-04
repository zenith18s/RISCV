`timescale 1 ns / 1 ps

module memory(ADDR,RDBUS, WDBUS,RD,WR,CLK,RST,RESULT);
input [15:0] ADDR;
input [15:0] WDBUS;
input RD,WR,CLK,RST;
output [15:0] RDBUS;
output [15:0] RESULT;

reg [15:0] MEM [65536:0];

integer ii;
reg [15:0] DBUS_TMP;

//wire [15:0] dato;

always @ (posedge CLK) begin
	if(!RST)begin
			
 
		DBUS_TMP <= ADDR;
		 ii=0;
		MEM[16'h05AA] <= 16'b0000_1011_1111_0000;
		MEM[ii] <= 16'b0000_000_0_000_000_00; ii=ii+1;//nothing
		
		MEM[ii] <= 16'b1000_000_0_00010000; ii=ii+1;//load l: loads 0x10
		MEM[ii] <= 16'b1000_001_1_00101001; ii=ii+1;//load h: loads 0x29
		
		MEM[ii] <= 16'b0010_010_0_000_001_00; ii=ii+1;//or operation to generate 0x2910 and store it in internal register 2 - (a)

		MEM[ii] <= 16'b1000_101_0_10101010; ii=ii+1;//load l: loads AA
		MEM[ii] <= 16'b1000_110_1_00000101; ii=ii+1;//load h: loads 05 

		MEM[ii] <= 16'b0010_111_0_101_110_00; ii=ii+1;//or operation to generate 0x05AA and store it in internal register 7 - (b)
		
		MEM[ii] <= 16'b0110_011_0_111_11111; ii=ii+1; //read from external memory location

		MEM[ii] <= 16'b0000_100_0_010_011_00; ii=ii+1;//add operation between (a) and (b) and stored in internal regster 4

		MEM[ii] <= 16'b0111_111_0_111_100_11; ii=ii+1;//write from reg 4 to mem[0x05AA]

		MEM[ii] <= 16'b1101_000_0_000_000_00; ii=ii+1;//jump instruction
		
		
		
	end 
	
end

always @(WR) begin
	if(!RST) begin
		if(WR) MEM[ADDR]<= WDBUS;
	end
end


assign RDBUS = (RD)? MEM[ADDR] : MEM[DBUS_TMP];
assign RESULT = MEM[16'h05AA]; //Is only used to view the result in waveform

endmodule
