module Mux_tb();
  reg [15:0] a;
  reg [15:0] b;
  reg [15:0] c;
  reg [15:0] d;
  reg [1:0] selector;
  wire [15:0] out;
  reg clk;
  
	Mux mux(    
 	    a,b,c,d,
 	    selector,
 	    out
   	); 

	initial begin
	  clk <= 0;
	  
	  selector <= 2'b01;
	  a <= 16'b01;
  		b <= 16'b11;
  		c <= 16'b00;
  		d <= 16'b10;
  		repeat (1) @ (posedge clk);
  		
		selector <= 2'b11;
	  a <= 16'b01;
  		b <= 16'b11;
  		c <= 16'b00;
  		d <= 16'b10;
  		

	end
	always #50 clk = ~clk;

	
endmodule




