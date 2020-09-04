
module SE (input [9:0] in, output reg [15:0] out);
  always @( * ) begin
    out[15:0] <= { {8{in[7]}}, in[7:0] };
  end
  
endmodule
