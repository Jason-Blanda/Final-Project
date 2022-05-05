module data(
 input clk,
 input [31:0] access_addr,
 input [31:0] write_data,
 input write_en,
 input read,
 output [31:0] read_data
);

reg [32 - 1:0] memory [32 - 1:0];
integer f;
wire [2:0] ram_addr = access_addr[2:0];
 
always @(posedge clk) begin
  if (write_en)
   memory[ram_addr] <= write_data;
 end
 assign read_data = (read==1'b1) ? memory[ram_addr]: 16'd0; 

endmodule
