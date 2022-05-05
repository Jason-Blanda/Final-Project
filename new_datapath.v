module new_datapath(
 input clk,
 input jump,beq,read,write,alu_src,reg_dst,mem_to_reg,reg_write,bne,
 input[1:0] alu_op,
 output[3:0] opcode
);
 reg  [15:0] pc_current;
 wire [15:0] pc_next,pc2;
 wire [15:0] instr;
 wire [2:0] reg_write_dest;
 wire [15:0] reg_write_data;
 wire [2:0] reg_read_addr_1;
 wire [15:0] reg_read_data_1;
 wire [2:0] reg_read_addr_2;
 wire [15:0] reg_read_data_2;
 wire [15:0] ext_im,read_data2;
 wire [2:0] ALU_Control;
 wire [15:0] ALU_out;
 wire zero_flag;
 wire [15:0] PC_j, PC_beq, PC_2beq,PC_2bne,PC_bne;
 wire beq_control;
 wire [12:0] jump_shift;
 wire [15:0] read_data;
 // PC 
 initial begin
  pc_current <= 32'd0;
 end
 always @(posedge clk)
 begin 
   pc_current <= pc_next;
 end
 assign pc2 = pc_current + 32'd2;

 im instr_mem(.pc(pc_current),.instruction(instr));

 assign jump_shift = {instr[11:0],1'b0};
 
 assign reg_write_dest = (reg_dst==1'b1) ? instr[5:3] :instr[8:6];

 assign reg_read_addr_1 = instr[11:9];
 assign reg_read_addr_2 = instr[8:6];


 register_file reg_file
 (
  .clk(clk),
  .write_en(write),
  .write_dest(write_dest),
  .write_data(write_data),
  .read_addr_1(read_addr_1),
  .read_data_1(read_data_1),
  .read_addr_2(read_addr_2),
  .read_data_2(read_data_2)
 );

 assign ext_im = {{10{instr[5]}},instr[5:0]};  

 alu_control ALU_Control_unit(.op(op),.opcode(instr[15:12]),.cnt(ctrl));

 assign read_data2 = (alu_src==1'b1) ? ext_im : reg_read_data_2;

 alu alu_control(.a(reg_read_data_1),.b(read_data2),.control(control),.result(ALU_out),.zero(zero_flag));

 assign PC_beq = pc2 + {ext_im[14:0],1'b0};
 assign PC_bne = pc2 + {ext_im[14:0],1'b0};

 assign beq_control = beq & zero_flag;
 assign bne_control = bne & (~zero_flag);

 assign PC_2beq = (beq_control==1'b1) ? PC_beq : pc2;

 assign PC_2bne = (bne_control==1'b1) ? PC_bne : PC_2beq;

 assign PC_j = {pc2[15:13],jump_shift};

 assign pc_next = (jump == 1'b1) ? PC_j :  PC_2bne;


  data d
   (
    .clk(clk),
    .access_addr(ALU_out),
    .write_data(reg_read_data_2),
    .write_en(write),
    .read(read),
    .read_data(read_data)
   );
 

 assign reg_write_data = (mem_to_reg == 1'b1)?  read_data: ALU_out;

 assign opcode = instr[15:12];
endmodule
