module Register_with_write(
	input [15:0] in,
	output reg [15:0] out,
	input _reg_write,
	input clk
	);

	initial
	begin
		out <= 16'b0;
	end

	always @ (posedge clk)
	begin
		if (_reg_write)
		  out <= in;
	end
endmodule