
module Mux4to1( input [15:0] a,
            input [15:0] b,
            input [15:0] c,
            input [15:0] d,
            input [1:0] selector,
            output reg [15:0] out
   );

   always @ (a or b or c or d or selector) 
   begin
      case (selector)
         2'b00 : out <= a;
         2'b01 : out <= b;
         2'b10 : out <= c;
         2'b11 : out <= d;
      endcase
   end
   
endmodule