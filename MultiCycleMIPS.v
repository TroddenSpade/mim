
module MultiCycleMIPS( input clk, reset ); 

	wire [9:0] pc, pc_in;
	wire [15:0] pc_e = { 6'b000000, pc[9:0] };
	wire [9:0] address;
	wire [15:0] data_mem, mem_out;
	wire [15:0] ir;
	wire [15:0] mdr;
	wire [15:0] r1, r2, data_reg;
	wire [15:0] a, b;
	wire [15:0] alu_src_1, alu_src_2, alu_res;
	wire zero, pc_cond, pc_write_final;
  wire [15:0] alu_out;
  wire [9:0] alu_res_pc = alu_res[9:0];
	
	wire [1:0] rr1 = ir[9:8]; // Rj
	wire [1:0] rr2 = ir[11:10]; // Ri
	wire [3:0] opcode = ir[15:12];
	wire [7:0] func = ir[7:0]; 
	wire [15:0] imd_se;
	wire [9:0] adr_e = { pc[9:8] , ir[7:0] };
  wire [9:0] addr = ir[9:0];

	wire _iord, _pc_write,
	 _mem_read, _mem_write, 
	 _ir_write, _mem_to_reg,
	 _reg_write, _pc_write_cond, _wind_cond;
	wire [1:0] _a_src, _b_src, _pc_src, wind;

	wire [2:0] _ALUOP, ALUCTRL ;
	
	wire [15:0] one = 1;
	wire [15:0] empty = 16'b0;

	ControlUnit cu(
	 opcode,
	 clk, reset,
	 _iord, _pc_write,
	 _mem_read, _mem_write, 
	 _ir_write, _mem_to_reg,
	 _reg_write, _pc_write_cond, _wind_cond, 
	 func[7:2],
	 _a_src, _b_src, _pc_src,
	 _ALUOP
	);
	
	AND pc_cond_and(zero, _pc_write_cond, pc_cond);
	OR pc_cond_or(_pc_write, pc_cond, pc_write_final);

	PC pc_reg(pc_in, pc, pc_write_final, clk);
	
	Mux2to1 iord(pc, addr, _iord, address);

	Memory mem(
 	     address,
	     r2,
	     mem_out,
	    _mem_read, _mem_write, clk
   	); 

	Register_with_write ir_reg(mem_out, ir, _ir_write, clk);
	
	Register mdr_reg(mem_out, mdr, clk);
	
  Mux2to1 mem_to_reg(alu_out, mdr, _mem_to_reg, data_reg);	
  
  Window win_reg(func[1:0], wind, _wind_cond, clk);
	
  RegisterFile rf(
 	    rr1, rr2, rr2, wind,
	    data_reg,
	    r1, r2,
	    _reg_write, clk
 	); 
	
  Register a_reg(r1, a, clk);
	Register b_reg(r2, b, clk);
	
	Mux2to1 src_1 (pc_e, a, _a_src, alu_src_1);
	SE se(func, imd_se);
  Mux4to1 src_2 (one, b, imd_se, empty, _b_src, alu_src_2);
  
  ALUControl aluc(    
		    _ALUOP,
        func,
      		ALUCTRL
   	);

	ALU alu(
      		alu_src_1,
      		alu_src_2,
      		ALUCTRL,
      		alu_res,
      		zero
   	);
   	
 	Mux4to1 pc_src (adr, adr_e, alu_res_pc, empty, _pc_src, pc_in);
   	
 	Register aluout(alu_res, alu_out, clk);
	
endmodule
