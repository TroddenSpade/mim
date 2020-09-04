

module MultiCycleMIPS_tb();
	reg reset, clk;

	MultiCycleMIPS mips(
		.clk(clk),
		.reset(reset)
	);

	initial begin
		clk <= 0;
  		//reset <= 1;
  		//repeat (3) @ (posedge clk);
		//reset <= 0;

	end

	always #50 clk = ~clk;

	
endmodule
