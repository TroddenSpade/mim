module Window(
	input [1:0] in,
	output reg [1:0] out,
	input _reg_write,
	input clk
	);

	initial
	begin
		out <= 2'b0;
	end

	always @ (posedge clk)
	begin
		if (_reg_write)
		  out <= in;
	end
endmodule

