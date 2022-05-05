module register_file(
 input clk,

 input write_en,
 input [2:0] write_dest,
 input [31:0] write_data,
 input [2:0] read_addr_1,
 output [31:0] read_data_1,
 input [2:0] read_addr_2,
 output [31:0] read_data_2
);
 reg [31:0] array [16:0];
 integer i;

 initial begin
  for(i=0;i<16;i=i+1)
   array[i] <= 32'd0;
 end
 
 always @ (posedge clk ) begin
   if(write_en) begin
    array[write_dest] <= write_data;
   end
 end
 

 assign read_data_1 = array[read_addr_1];
 assign read_data_2 = array[read_addr_2];


endmodule
