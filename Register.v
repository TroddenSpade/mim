module Register(
	input [15:0] in,
	output reg [15:0] out,
	input clk
	);

	initial
	begin
		out <= 16'b0;
	end

	always @ (posedge clk)
	begin
		out <= in;
	end
endmodule