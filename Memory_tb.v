module Memory_tb();
  reg [15:0] address;
	reg [15:0] write_data; 
	wire [15:0] out;
	reg _mem_read, _mem_write;
	reg clk;
	
	Memory mem(    
 	     address, 
	     write_data, 
	     out,
	    _mem_read, _mem_write
   	); 

	initial begin
	  clk <= 0;
	  
	  _mem_read = 1;
	  _mem_write = 0;
	  address <= 16'b0000000000000001;
  		repeat (1) @ (posedge clk);
  		
  		_mem_read = 0;
	  _mem_write = 1;
	  address <= 16'b000000010000011;
  		write_data <= 16'b1100000000000011;
  		repeat (1) @ (posedge clk);
  		
		_mem_read = 1;
	  _mem_write = 0;
	  address <= 16'b0000000000000010;
  		repeat (1) @ (posedge clk);

		_mem_read = 1;
	  _mem_write = 0;
	  address <= 16'b0000000010000011;


	end
	always #50 clk = ~clk;

	
endmodule