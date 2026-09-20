module struct_demo;
    typedef struct {
        int instruction_id;
        byte opcode;
        shortint immediate;
        int target_addr;
    } instr_s; // Unpacked struct by default, behaves kinda like an unpacked array.

    instr_s current_instruction;

    initial begin
        // Don't forget the apostrophe.
        current_instruction = '{
            instruction_id: 32'h0000_0001,
            opcode: 8'hA5,
            immediate: 16'h1234,
            target_addr: 32'hFFFF_0000
        };

        $display("Current Instruction: instruction_id: %08X, opcode: %02X, immediate: %016X, target_addr: %032X.", current_instruction.instruction_id,
                current_instruction.opcode, current_instruction.immediate, current_instruction.target_addr);
    end
endmodule