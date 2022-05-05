module processor_tb;

 reg clk;
 wire jump,bne,beq,mem_read,mem_write,alu_src,reg_dst,mem_to_reg,reg_write;
 wire[1:0] op;
 wire [3:0] opcode;

 processor uut (
  .clk(clk)
 );

 initial 
  begin
   clk <=0;
  #300;
   $finish;
  end

 always 
  begin
   #5 clk = ~clk;
  end

endmodule
