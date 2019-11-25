# Computer-Architecture

# 10/26/19 - Saturday

# Goals
	- [x] Fix Pipeline Registers
		- Removie temp register in the pipelines
	- [x] Remove delayed components
		- [x] Removed delayed wires
		- [x] Remove modules that delay wires
	- [x] Connected almost all wires to top for datapath to work in labs 15-18
		- [x] Pipeline are being implemented correctly
	- [x] Add `AND` module for branch to execute correctly.
	- [ ] Implement `jump` instructions
		- [ ] Create another `ADDER` in Execution stage for `jump` instrucitons.
		
# Issues
	- May need to change bit width for ALUOp that goes from `Control` to `ALU`
		- switch from 5 bits to 6 bits.

# Notes
	- Added *MemWrite, MemRead, MemToReg and Branch* to Pipeline registers
	- Initialized `DataMemory` , but still have to add `Address` port.
	- Final mux that `MemToReg` connects to, to send the final result.
	
# 10/30/19 - Wednesday

# Goals
	
# Issues
	Ask him about flushing
		- is it neccessary for this lab
	Ask Sahil about jumping isntructions
		- ask if he can explain again about jr

# Notes
	- Will need to flush pipeline registers when jumping
		- Flush signal should be coming from branch(AND module)
	- jal is 2 instructions
		- jump to address
		- store return address in memory
	- jr
		- should be stored in the 32nd register

	**Project Phase 1**
	
# 11/06/19 - Wednesday
	- Reset the clock after jr is executed in jal jr test case.
		- This is when there is a jal instruction, the following instruction is a jr instruction
	- Move `branch` module to `execute` stage to avoid errors MFHI/MFLO instructions
** Will ask in demo**
	- the little endian system and how it affects the Address
		- least significant bits go to least significant address.
		
# 11/18/19 - Monday
	Hazard Unit:
		- If a load word, then an addi there will need to be a delay.
	Forwarding Unit:
		- The forwarding unit has been initialized
			- 2 3-input Muxe's have been created. 1 for input A, the other for input B
			- If statements have Mem stage as priority, so if there are 2 dependencies on rs for example, the code should be able to handle it.
			- 6 `if statments`, 1 `else statement`
			- first 3 if statements check:
				- rs dependent in mem stage && rt dependent on write statge
				- rs dependent in mem stage && rt not dependent on write statge
				- rs not dependent in mem stage && rt dependent on write statge
			- next 3 if statements check:
				- rt dependent in mem stage && rs dependent on write statge
				- rt dependent in mem stage && rs not dependent on write statge
				- rt not dependent in mem stage && rs dependent on write statge
			- else statement:
				- if none of the previous statements are true
				
# 11/19/19 - Tuesday
	Hazard Unit:
		- If a load word, then an addi there will need to be a delay.
	Forwarding Unit:
		- The forwarding unit @ 610 ns is not working, 
		- addi instruction isn't working, rt field is matching the WB register destination.
		
# 11/20/19 - Wednesday

## Issue
	add *$s0*, $s1, $s2
	sub $t1, $t2, $t3
	mult $s1, $t2, $t3
	add $s1, *$s0*, $s2
	
	In this situation there is a dependency on $s0
	Because the value will be sent from WB, and the current add is in decode stage,<br>
	the value will not be forwarded in time to be read from the register file

## Labs 15-18 Demo
	jal is jumping correctly, but not storing the return address correctly.
		-	Because of this, jr isn't working properly,
	
	Store byte isn't working
	Load byte isn't working
	
	Store half isn't working
	Load half isn't working
	
	Need to create better logic for both halve and byte instructions
	
	**Example written by Sahil**
	if(2_LSB's of address == 00 or 01)
	
## Solution
	Hazard detection unit checks rs and rt in decode and compare to rd in WB (This will stall one clock cycle)
	- or -
	Create muxes to properly forward the updated value from WB to (execute or decode stage) unsure