`default_nettype none

bit running = 1;
typedef enum {INIT, DECODE, IDLE} fsmstate_e;

interface fsmifc(input bit clk);
    bit pi;
    bit po;
    bit reset;
    fsmstate_e state;

    modport tb(output pi, reset , clk, input po, state);
    modport dut(input pi, reset, clk, output po, state);
endinterface

module fsm(fsmifc.dut abc);
    fsmstate_e pstate, nstate;

    always@(abc.reset) begin
        if(abc.reset) nstate = IDLE;
    end

    always@(posedge abc.clk) begin
        case(pstate)
            IDLE: if(abc.pi == 1) begin
                nstate = INIT; abc.po = 0;
            end
            else begin
                nstate = IDLE; abc.po = 0;
            end

            INIT: if(abc.pi == 1) begin
                nstate = DECODE; abc.po = 1;
            end
            else begin
                nstate = IDLE; abc.po = 0;
            end

            DECODE: if(abc.pi == 1) begin
                nstate = IDLE; abc.po = 1;
            end
            else begin
                nstate = DECODE; abc.po = 1;
            end
        endcase
        pstate = nstate;
        abc.state = pstate;
    end
endmodule

module test(fsmifc.tb ifc);
  class Transaction;
    rand bit x;
  endclass
  
  covergroup cg_fsm;
    CP1: coverpoint ifc.state
    {
      bins t1 = {IDLE => INIT};
      bins t2 = {IDLE => IDLE};
      bins t3 = {INIT => DECODE};
      bins t4 = {INIT => IDLE};
      bins t5 = {DECODE => DECODE};
      bins t6 = {DECODE => IDLE};
    }
  endgroup
  
  initial begin
	Transaction tr;
    cg_fsm xyz;
    xyz = new();
    tr = new();
    
    ifc.reset = 1;
    #12 ifc.reset = 0;
    repeat(10) begin
      assert(tr.randomize());
      #2 ifc.pi <= tr.x;
      xyz.sample();
      @(posedge ifc.clk);
    end
  end
endmodule

module top;
    bit clk;
    initial begin
        clk = 0;
        while(running == 1) #5 clk = ~clk;
    end
    fsmifc u1(clk);
    fsm u2(u1.dut);
    test u3(u1.tb);

    initial begin
        $dumpfile("fsm.vcd");
      $dumpvars(clk, u1);
    end
endmodule