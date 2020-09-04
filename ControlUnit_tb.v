
module ControlUnit_tb();
  reg [3:0] opcode;
	reg clk, reset;
	wire _iord, _pc_write,
	 _mem_read, _mem_write, 
	 _ir_write, 
	 _a_src, _b_src, 
	 _pc_src, _mem_to_reg,
	 _reg_read, _reg_write;
	wire [2:0] ALUOP;
  
  ControlUnit cu(
	 opcode,
	 clk, reset,
	 _iord, _pc_write,
	 _mem_read, _mem_write, 
	 _ir_write, 
	 _a_src, _b_src, 
	 _pc_src, _mem_to_reg,
	 _reg_read, _reg_write,
	 ALUOP
	);
	
	initial begin
	  clk <= 0;
	  reset <= 0;
		
	end
	always #50 clk = ~clk;

	
endmodule



