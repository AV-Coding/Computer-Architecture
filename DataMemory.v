module DataMemory(Address, WriteData, Clk, MemWrite, MemRead, ReadData); 

    input [31:0] Address; 	// Input Address 
    input [31:0] WriteData; // Data that needs to be written into the address 
    input Clk;
    input [1:0]MemWrite; 		// Control signal for memory write 
    input [1:0]MemRead; 			// Control signal for memory read 

    integer i;
    output reg[31:0] ReadData; // Contents of memory location at Address
   //MemRead should be sensitive to when Address||WriteData||ReadData changes
   //Later on, we will probably want to make it sensitive to the clock but not now.
    reg[31:0] memory [0:1023];
    
    initial begin
            // Walk through the memory array and initialize each entry to i * 3. (Arbitrary for now)
            for (i = 0; i < 1024; i = i + 1) 
                begin
                    if( i == 0 )
                        begin
                            memory[i] = 20;
                        end
                    else
                        begin
                            memory[i] = i*3;//Needs to be i*3 for this work.
                        end
                end  
    
    // ReadData[31:0]<=0;//would this setup ReadData to have its 24 most significant bits to 0?? 
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
    memory[Address[11:2]] <= {memory[Address[11:2]][31:16],WriteData[15:0]}; // store half word
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