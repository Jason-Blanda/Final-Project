module alu_control(cnt, op, opcode);
 output reg[2:0] cnt;
 input [1:0] op;
 input [3:0] opcode;
 wire [5:0] ctrlin;
 assign cntrlin = {op,opcode};
 always @(cntrlin)
 casex (cntrlin)
   6'b10xxxx: cnt=3'b000;
   6'b01xxxx: cnt=3'b001;
   6'b000010: cnt=3'b000;
   6'b000011: cnt=3'b001;
   6'b000100: cnt=3'b010;
   6'b000101: cnt=3'b011;
   6'b000110: cnt=3'b100;
   6'b000111: cnt=3'b101;
   6'b001000: cnt=3'b110;
   6'b001001: cnt=3'b111;
  default: cnt=3'b000;
  endcase
endmodule
