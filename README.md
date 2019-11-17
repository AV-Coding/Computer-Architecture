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
	