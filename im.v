module im(
 input[31:0] pc,
 output[31:0] instruction
);

 reg [32 - 1:0] mem [32 - 1:0];
 wire [3 : 0] rom_addr = pc[4 : 1];

 assign instruction =  mem[rom_addr]; 

endmodule
