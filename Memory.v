module Memory(
	input [9:0] address, 
	input [15:0] write_data, 
	output reg [15:0] out,
	input _mem_read, _mem_write, clk
	);

	reg [15:0] mem[1023:0];

	initial
	begin
	  mem[0] = 16'b0001_11_1111100111;  // Store [999] <- R3
	  mem[1] = 16'b1101_11_01_00000011; // Subi R3 <- R1 - 2
		mem[2] = 16'b1000_11_00_01000000; // NOP
		mem[3] = 16'b1000_00_00_10000001; // wind 01
		mem[4] = 16'b1000_01_00_00001000; // And R3 ,R2
		mem[5] = 16'b1111_10_11_00000100; // Ori R4 <= R5 | 4
		mem[6] = 16'b0100_01_00_00001010; // BranchZ  R3,R2 [10]
		// ...
    mem[10] = 16'b1111_01_10_00000100; // Ori R3 <= R4 | 4
    mem[11] = 16'b1000_00_00_10000010; // wind 10
    mem[12] = 16'b0100_00_01_00010111; // BranchZ  R4,R5 [23]
    //...
    mem[23] = 16'b0000_11_1111100111;  // Load R7 <- [999]
    mem[24] = 16'b1000_00_10_00000010; // Add R4, R6
    mem[25] = 16'b1000_00_11_00000100; // Sub R4, R7
    mem[26] = 16'b1000_00_00_10000000; // wind 00
    mem[27] = 16'b0010_00_0000000000;  // Jump addr [0]
    
	end

 always @ ( posedge clk )
  begin
    		if(_mem_write)
			mem[address] = write_data;
  end

	always @ ( * )
	begin
		if(_mem_read)
		  	out = mem[address];
	end
	
endmodule
