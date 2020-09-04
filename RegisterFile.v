module RegisterFile(
	input [1:0] rr1, rr2, wr, wind,
	input [15:0] data_in,
	output reg [15:0] r1, r2,
	input _regfile_write , clk
	);


	reg [15:0] register[7:0];

	initial
	begin
		register[0] <= 16'b0000000000000000;
		register[1] <= 16'b0000000000000001;
		register[2] <= 16'b0000000000000010;
		register[3] <= 16'b0000000000000011;
		register[4] <= 16'b0000000000000100;
		register[5] <= 16'b0000000000000101;
		register[6] <= 16'b0000000000000110;
		register[7] <= 16'b0000000000000111;
	end

  always @ ( posedge clk )
  begin
    if(_regfile_write) begin
	    register[(2 * wind + wr) % 8] = data_in;
	  end  
  end

	always @ ( * )
	begin
		r1 = register[(2 * wind + rr1) % 8];
		r2 = register[(2 * wind + rr2) % 8];
	end

endmodule
