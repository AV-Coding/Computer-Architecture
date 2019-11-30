module DataHazard(PCSrc, IF_Instruction, ID_Instruction, EX_Instruction, MEM_Rd, WB_Rd, WB_RegWrite, MEM_RegWrite,IF_ID_Signal, ID_EX_Signal, EX_MEM_Signal, MEM_WB_Signal, PC_Write);

	input PCSrc;
	input [31:0] IF_Instruction;
	input [31:0] EX_Instruction;
	input [31:0] ID_Instruction;
	input [31:0] MEM_Rd;
	input [31:0] WB_Rd;
	input WB_RegWrite, MEM_RegWrite;
	output reg IF_ID_Signal;
	output reg ID_EX_Signal;
	output reg EX_MEM_Signal;
	output reg MEM_WB_Signal;
	output reg PC_Write;
	reg [5:0]EX_Opcode;
	reg [5:0]ID_Opcode;
	reg [5:0]IF_Opcode;
	reg [5:0]IF_Rt;
	reg [5:0]IF_Rs;
	reg [31:0]ID_Rt; // Bits 20-16
    reg [31:0]ID_Rs; // Bits 25-21
	
	
	always @(*)begin
	EX_Opcode = EX_Instruction[31:26];
	ID_Opcode = ID_Instruction[31:26];
	IF_Opcode = IF_Instruction[31:26];
	ID_Rs = ID_Instruction[25:21];
	ID_Rt = ID_Instruction[20:16];
	IF_Rs = IF_Instruction[25:21];
	IF_Rt = IF_Instruction[20:16];
	
	/*Branching & jumping*/
	if(PCSrc==1)begin //no addi lw occrurring
        IF_ID_Signal = 1;
        ID_EX_Signal = 1;
        EX_MEM_Signal = 0;
        MEM_WB_Signal = 0;
        PC_Write = 0;
	end
	/*else if((PCSrc==1)&&(ID_Opcode=='b001000)&&(EX_Opcode=='b100011))begin //addi lw occrurring
		ID_EX_Signal=1;
		IF_ID_Signal=1;
		MEM_WB_Signal=1;
		// push a nop
	end*/
	
	/*Data hazards with flushing*/
	/*else if((PCSrc==0)&&(ID_Opcode=='b001000)&&(EX_Opcode=='b100011))begin //no addi lw occrurring
		ID_EX_Signal=0;
		IF_ID_Signal=1;
		MEM_WB_Signal=0;
	end
	else if((PCSrc==0)&&(ID_Opcode=='b001000)&&(EX_Opcode=='b100011))begin //addi lw occrurring
	end*/
	else if((IF_Rs == MEM_Rd)&&(MEM_RegWrite ==1))begin
        IF_ID_Signal = 1;
        ID_EX_Signal = 0;
        EX_MEM_Signal = 0;
        MEM_WB_Signal = 0;
        PC_Write = 1;
	end
	else if((ID_Rs == WB_Rd) && (WB_RegWrite == 1))begin
	   IF_ID_Signal = 1;
	   ID_EX_Signal = 1;
	   EX_MEM_Signal = 0;
	   MEM_WB_Signal = 0;
	   PC_Write = 1;
	end
	else if((IF_Rt == MEM_Rd) && (IF_Opcode=='b101011 || IF_Opcode=='b101000 || IF_Opcode=='b101001))begin// sw, sh, sb
        IF_ID_Signal = 1;
        ID_EX_Signal = 0;
        EX_MEM_Signal = 0;
        MEM_WB_Signal = 0;
        PC_Write = 1;
	end
	else if((IF_Rt == MEM_Rd)&&(IF_Opcode=='b000000 || IF_Opcode=='b011100 || IF_Opcode=='b011111))begin //arithmetic
	    IF_ID_Signal = 1;
        ID_EX_Signal = 0;
        EX_MEM_Signal = 0;
        MEM_WB_Signal = 0;
        PC_Write = 1;
	end
	else begin
	IF_ID_Signal=0;
	ID_EX_Signal=0;
	EX_MEM_Signal=0;
    MEM_WB_Signal=0;
    PC_Write = 0;
	end
    end

endmodule
	
