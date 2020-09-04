module ALU_tb();
  reg clk;
	reg [15:0] a;
	reg [15:0] b;
	wire [15:0] result;
	wire zero;
	reg [1:0] ALUOP;
  reg [7:0] func;
  
	ALU alu(    
      		a,
      		b,
      		result,
      		zero,
      		ALUOP,
        func
   	); 

	initial begin
	  clk <= 0;
	  
	  a <= 16'b0000000000000011;
  		b <= 16'b0000000000000010;
  		ALUOP <= 2'b00;
    func <= 8'b00001000;
  		
  		repeat (1) @ (posedge clk);
		a <= 16'b0000000000000011;
  		b <= 16'b0000000000000010;
  		ALUOP <= 2'b01;
    func <= 8'b00100000;
  		
  		repeat (1) @ (posedge clk);
		a <= 16'b0000000000000011;
  		b <= 16'b0000000000000010;
  		ALUOP <= 2'b11;
    func <= 8'b00010000;
    
  		repeat (1) @ (posedge clk);
		a <= 16'b0000000000000011;
  		b <= 16'b0000000000000010;
  		ALUOP <= 2'b11;
    func <= 8'b00100000;

	end
	always #50 clk = ~clk;

	
endmodule

