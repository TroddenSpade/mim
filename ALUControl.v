
module ALUControl(    
		    input [2:0] ALUOP,
        input [7:0] func,
      		output reg [2:0] result
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
	   case (ALUOP)
      3'b00: result = 3'b000;
      3'b01: result = 3'b001;
      3'b10: result = 3'b011;
      3'b11: result = 3'b100; 
      3'b111: 
        case (func)  
          8'b00000001: result = 3'b101;
          8'b00000010: result = 3'b000;  
          8'b00000100: result = 3'b010;   
          8'b00001000: result = 3'b011;  
          8'b00010000: result = 3'b100;   
          8'b00100000: result = 3'b110;  
          8'b01000000: result = 3'b111;
          default: result <= 3'b111;
        endcase  
    endcase
	end


endmodule


