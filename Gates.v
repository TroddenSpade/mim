
module AND (input a,b , output reg out);
  always @( * ) begin
    out <= a & b;
  end
  
endmodule

module OR (input a,b , output reg out);
  always @( * ) begin
    out <= a | b;
  end
  
endmodule
