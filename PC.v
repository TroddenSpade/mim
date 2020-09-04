module PC(
	input [9:0] in,
	output reg [9:0] out,
	input _reg_write,
	input clk
	);

	initial
	begin
		out <= 10'b0;
	end

	always @ (posedge clk)
	begin
		if (_reg_write)
		  out <= in;
	end
endmodule
