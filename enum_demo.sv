module enum_demo;
    typedef enum { INIT, DECODE, IDLE } fsmstate_e;

    fsmstate_e pstate, nstate;
    initial begin
        $display("Initial state num: %0d, Initial state name: %s", pstate, pstate.name);
        case(pstate)
            INIT: nstate = DECODE;
            IDLE: nstate = INIT;
            default: nstate = IDLE;
        endcase
        $display("Next state num: %0d, Next state name: %s", nstate, nstate.name);
    end
endmodule