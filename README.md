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
	- [ ] Add `AND` module for branch to execute correctly.
	- [ ] Implement `jump` instructions
		- [ ] Create another `ADDER` in Execution stage for `jump` instrucitons.
		
# Issues
	- May need to change bit width for ALUOp that goes from `Control` to `ALU`
		- switch from 5 bits to 6 bits.
# Notes
	- Added *MemWrite, MemRead, MemToReg and Branch* to Pipeline registers
	- Initialized `DataMemory` , but still have to add `Address` port.
	- Final mux that `MemToReg` connects to, to send the final result.