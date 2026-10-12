bit running = 1;
interface busifc(input bit clk);
  bit [31: 0] data;
  bit [2:0] port;
  bit [3:0] kind;
  
  modport tb(output data, port, kind,
            input clk);
  modport dut(input clk, port, kind);
endinterface

module bus (busifc.dut abc);
  // TODO
endmodule

module test(busifc.tb ifc);
  class Transaction;
    typedef enum {INIT, DECODE, IDLE} fsmstate_e;
    rand fsmstate_e pstate, nstate;
  endclass
  
  Transaction tr;
  covergroup CovPort;
    CP1: coverpoint tr.pstate;
  endgroup
  
  initial begin
    CovPort xyz;
    xyz = new();
    tr = new();
    
    repeat (70) begin
      assert(tr.randomize());
      xyz.sample();
      @ifc.clk;
    end
    running = 0;
    $display("Coverage = %.2f%%", xyz.get_coverage());
  end
endmodule

module top;
  bit clk;
  initial begin
    clk = 0;
    while (running)
      #5 clk = ~clk;
  end
  busifc u1(clk);
  bus u2(u1.dut);
  test u3(u1.tb);
endmodule