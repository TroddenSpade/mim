module RegisterFile_tb();
  reg [1:0] rr1, rr2, wr, wind;
	reg [15:0] data_in;
	wire [15:0] r1, r2;
  reg _regfile_write, clk;
  
	RegisterFile rf(    
 	    rr1, rr2, wr, wind,
	    data_in,
	    r1, r2,
	    _regfile_write, clk
   	); 

	initial begin
	  clk <= 0;
	  
	  _regfile_write <= 0;
	  wind <= 2'b01;
	  rr1 <= 2'b11;
  		rr2 <= 2'b01;
  		repeat (1) @ (posedge clk);
  		
		_regfile_write <= 0;
	  wind <= 2'b10;
	  rr1 <= 2'b00;
  		rr2 <= 2'b11;
  		repeat (1) @ (posedge clk);
  		

		_regfile_write <= 0;
	  wind <= 2'b11;
	  rr1 <= 2'b10;
  		rr2 <= 2'b01;
  		repeat (1) @ (posedge clk);

		_regfile_write <= 1;
	  wind <= 2'b00;
	  rr1 <= 2'b11;
  		rr2 <= 2'b10;
  		wr <= 2'b10;
  		data_in <= 15'b000000000001010;

	end
	always #50 clk = ~clk;

	
endmodule



