interface mem_int (input clk);
logic read, enable;
logic[7: 0] addr, data;

clocking cb @(posedge clk);
    default input #10ns output #2ns;
    output read, enable, addr;
    input data;
endclocking

modport dut(input read, enable, addr, output data);
modport tb(clocking cb);
endinterface

module mem(mem_int.dut memory);
    logic[7: 0] mem_elements [0:255];

    // Initializing the memory so that each mem[i] = 2*i
    initial begin
        foreach(mem_elements[i]) begin
            mem_elements[i] = i << 1; // Shift left by 1 bit.
        end
    end

    always@(memory.enable, memory.read) begin
        if(memory.enable && memory.read) begin
            memory.data = mem_elements[memory.addr];
        end
    end
endmodule

module testbench (mem_int.tb intf);
    logic[7: 0] received_data;
    initial begin
        intf.cb.read <= 1;
        intf.cb.enable <= 1;
        intf.cb.addr <= 70;
        #30 intf.cb.addr <= 150;
        #40 intf.cb.addr <= 67;
        #40 intf.cb.addr <= 5;
    end
    always@(intf.cb) begin
        received_data = intf.cb.data;
    end
endmodule

module top;
    bit clk;
    always #20 clk = ~clk;
    mem_int intf(clk);
    mem dut(intf.dut);
    testbench tb(intf.tb);

    initial begin
        $dumpfile("uvm.vcd");
        $dumpvars;
        #200 $finish;
    end
endmodule