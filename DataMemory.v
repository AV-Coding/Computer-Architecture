`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - data_memory.v
// Description - 32-Bit wide data memory.
//
// INPUTS:-
// Address: 32-Bit address input port.
// WriteData: 32-Bit input port.
// Clk: 1-Bit Input clock signal.
// MemWrite: 1-Bit control signal for memory write.
// MemRead: 1-Bit control signal for memory read.
//
// OUTPUTS:-
// ReadData: 32-Bit registered output port.
//
// FUNCTIONALITY:-
// Design the above memory similar to the 'RegisterFile' model in the previous 
// assignment.  Create a 1K memory, for which we need 10 bits.  In order to 
// implement byte addressing, we will use bits Address[11:2] to index the 
// memory location. The 'WriteData' value is written into the address 
// corresponding to Address[11:2] in the positive clock edge if 'MemWrite' 
// signal is 1. 'ReadData' is the value of memory location Address[11:2] if 
// 'MemRead' is 1, otherwise, it is 0x00000000. The reading of memory is not 
// clocked.
//
// you need to declare a 2d array. in this case we need an array of 1024 (1K)  
// 32-bit elements for the memory.   
// for example,  to declare an array of 256 32-bit elements, declaration is: reg[31:0] memory[0:255]
// if i continue with the same declaration, we need 8 bits to index to one of 256 elements. 
// however , address port for the data memory is 32 bits. from those 32 bits, least significant 2 
// bits help us index to one of the 4 bytes within a single word. therefore we only need bits [9-2] 
// of the "Address" input to index any of the 256 words. 
////////////////////////////////////////////////////////////////////////////////

module DataMemory(Address, WriteData, Clk, MemWrite, MemRead, ReadData); 

    input [31:0] Address; 	// Input Address 
    input [31:0] WriteData; // Data that needs to be written into the address 
    input Clk;
    input MemWrite; 		// Control signal for memory write 
    input MemRead; 			// Control signal for memory read 

    output reg[31:0] ReadData; // Contents of memory location at Address
    //MemRead should be sensitive to when Address||WriteData||ReadData changes
   //Later on, we will probably want to make it sensitive to the clock but not now.
    reg[31:0] memory [0:1023];
    
    initial begin
            $readmemh("private_data_memory.txt",memory);
            // Walk through the memory array and initialize each entry to i * 3. (Arbitrary for now)
//            memory[0] <= 32'h64;
//            memory[1] <= 32'hc8;
//            memory[2] <= 32'h12c;
//            memory[3] <= 32'h190;
//            memory[4] <= 32'h1f4;
//            memory[5] <= 32'h258;
//            memory[6] <= 32'h2bc;
//            memory[7] <= 32'h320;
//            memory[8] <= 32'h384;
//            memory[9] <= 32'h3e8;
//            memory[10] <= 32'h44c;
//            memory[11] <= 32'h4b0;

    
    //ReadData[31:0]<=0;//would this setup ReadData to have its 24 most significant bits to 0?? 
    // would this then allow us to to set the 8 least significant bits to the address... 
    //as seen under our MemRead if statement??        
            
        end
    
    always @(posedge Clk) begin
    case(MemWrite)
    2'b01://will need to change the wire for MemWrite from 1 bit, to 2 bits, will need to handle multiple instructions.
    begin
    memory[Address[11:2]] <= WriteData;//storeword
    end
    
    2'b10:
    begin
    memory[Address[11:2]] <= {memory[Address[11:2]][31:16],WriteData[15:0]}; 
    end
       
    2'b11:
    begin
    memory[Address[11:2]] <= {memory[Address[11:2]][31:8],WriteData[7:0]}; //storebyte
    end        
    
    endcase
    
    end
    
    
   

    
    always @(negedge Clk) 
    begin
    case (MemRead)
    2'b01:
    begin
    ReadData <= memory[Address[11:2]];//loadword
    // then it will read the 32 bits that is at the memory location
    end
    
    2'b10:
    begin  
    ReadData <= {{16{memory[Address[11:2]][15]}}, memory[Address[11:2]][15:0]};//loadhalf
    end
    
    2'b11:
    begin  
    ReadData <= {{24{memory[Address[11:2]][7]}}, memory[Address[11:2]][7:0]};//loadbyte
    end 

    endcase
    end
    
endmodule
