
module ControlUnit(
	input [3:0] opcode,
	input clk, reset,
	output reg _iord, _pc_write,
	 _mem_read, _mem_write, 
	 _ir_write, _mem_to_reg,
	 _reg_write, _pc_write_cond, _wind_cond,
	input [5:0] upper_func, 
	output reg [1:0]  _a_src, _b_src, _pc_src,
	output reg [2:0] ALUOP
	);

	reg [3:0] state , n_state;

	initial
	begin
		state <= 4'b000;
		n_state <= 4'b001;
	end
	
	always @ ( posedge clk )
	begin
	  if(reset)
		begin
			n_state <= 4'b000;
		end
		state <= n_state;
	end
	

	always @ ( state )
	begin
		case(state)
		4'b000 : n_state = 4'b001;
		4'b001 : 
		  case(opcode)
		    4'b1000: 
		      case(upper_func)
		        6'b100000: n_state = 4'b1010;
		        default: n_state = 4'b010;
		      endcase
		    
		    4'b1100: n_state = 4'b100;
		    4'b1101: n_state = 4'b100;
		    4'b1110: n_state = 4'b100;
		    4'b1111: n_state = 4'b100;
		    
		    4'b0100: n_state = 4'b101;
		    
		    4'b0010: n_state = 4'b110;
		    
		    4'b0000: n_state = 4'b111;
		    
		    4'b0001: n_state = 4'b1001;
		  endcase
		  
		4'b1010: n_state = 4'b000;
		// R type
		4'b010 : n_state = 4'b011;
		4'b011 : n_state = 4'b000;
		//I type
		4'b100 : n_state = 4'b011;
		//B type
		4'b101 : n_state = 4'b000;
		// A Jump
		4'b110 : n_state = 4'b000;
		//A Load
		4'b111 : n_state = 4'b1000;
		4'b1000 : n_state = 4'b000;
		//A Store
		4'b1001: n_state = 4'b0000;
		endcase
	end
	

	always @ ( state )
	begin
		case(state)
		4'b000 : 
		begin
		  _iord = 0;
		  _reg_write = 0;
			_pc_write = 1;
			_mem_read = 1;
			_mem_write = 0;
			_ir_write = 1;
			_a_src = 2'b00;
			_b_src = 2'b00;
			_pc_src = 2'b10;
			_pc_write_cond = 0;
			_wind_cond = 0;
			ALUOP = 3'b0;
		end

		4'b001 : 
		begin
			_pc_write = 0;
			_mem_read = 0;
			_mem_write = 0;
			_ir_write = 0;
		end
		
		//window
		4'b1010:
		begin
		  _wind_cond = 1;
		end
		/// R type
		4'b010 : 
		begin
		  _a_src = 2'b01;
			_b_src = 2'b01;
			ALUOP = 3'b111;
		end
		
		4'b011 : 
		begin
			_mem_to_reg = 0;
			_reg_write = 1;
		end

		
		/// I type
		4'b100 : 
		begin
		  _a_src = 2'b01;
			_b_src = 2'b10;
			ALUOP = { 1'b0, opcode[1:0] };
		end
		
		
		/// B
		4'b101 :
		begin
			_a_src = 2'b01;
			_b_src = 2'b01;
			ALUOP = 3'b001;
			_pc_src = 2'b01;
		  _pc_write_cond = 1;
		end
		
		//A Jump
		4'b110:
		begin
		  _pc_src = 2'b00;
		  _pc_write = 1;
		end
		
		//A Load
		4'b111:
		begin
		  _iord = 1;
		  _mem_read = 1;
		end
		4'b1000:
		begin
		  _iord = 0;
		  _mem_to_reg = 1;
		  _reg_write = 1;
		end
		
		//A Store
		4'b1001:
		begin
		  _iord = 1;
		  _mem_write = 1;
		end
		
		
		endcase
	end

endmodule
