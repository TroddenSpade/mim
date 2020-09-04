
module ALU(    
      		input [15:0] a,
      		input [15:0] b,
      		input [2:0] ALUCTRL,
      		output reg [15:0] result,
      		output reg zero
   	); 
   	
   	//000: a + b
   	//001: a - b
 	  //010: b - a
   	//011: a & b
   	//100: a | b
   	//101: a
   	//110: ~a
   	//111: b
   	
	always @ (*) 
	begin
	   case (ALUCTRL)
      3'b000: result = a + b;
      3'b001: result = a - b;
      3'b010: result = b - a;
      3'b011: result = a & b;
      3'b100: result = a | b;
      3'b101: result = a;
      3'b110: result = ~a;
      3'b111: result = b;
    endcase
    if(result == 0)
      zero = 1;
    else
      zero = 0;
	end


endmodule

