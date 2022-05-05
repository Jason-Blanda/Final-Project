module processor(
 input clk
);
 wire jump,bne,beq,read,write,alu_src,reg_dst,mem_to_reg,reg_write;
 wire[1:0] op;
 wire [3:0] opcode;

 new_datapath d
 (
  .clk(clk),
  .jump(jump),
  .beq(beq),
  .read(mem_read),
  .write(mem_write),
  .alu_src(alu_src),
  .reg_dst(reg_dst),
  .mem_to_reg(mem_to_reg),
  .reg_write(reg_write),
  .bne(bne),
  .alu_op(alu_op),
  .opcode(opcode)
 );

 ctrl_unit cu
 (
  .opcode(opcode),
  .reg_dst(reg_dst),
  .mem_to_reg(mem_to_reg),
  .alu_op(alu_op),
  .jump(jump),
  .bne(bne),
  .beq(beq),
  .read(mem_read),
  .write(mem_write),
  .alu_src(alu_src),
  .reg_write(reg_write)
 );

endmodule
