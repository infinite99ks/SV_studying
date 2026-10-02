interface int_f(input clk);
    logic[7: 0] addr, data_in, data_out;
    logic en, rst_n, wr_en;

    clocking cb @(posedge clk);
        default input #1step output #2ns;
        output en, rst_n, wr_en, addr;
        input data_out;
        output data_in;
    endclocking
    modport dut(input clk, addr, data_in, en, rst_n, wr_en, output data_out);
    modport tb(clocking cb);
endinterface

module mem(int_f.dut dut);
    logic[7: 0] elements [0:255];
    always@(posedge dut.clk) begin
        if(!dut.rst_n) elements <= '{default: 'b0};
        else if (dut.en && dut.wr_en)
            elements[dut.addr] <= dut.data_in;
        else if (dut.en)
            dut.data_out <= elements[dut.addr];
        else
            dut.data_out <= 'b0;
    end
endmodule

module simple_tb(int_f.tb testbench);
    initial begin
        testbench.cb.rst_n <= 0; // LOW to reset.
      @(testbench.cb);
        testbench.cb.rst_n <= 1; // Now high to stop resetting.

        // Attempting to write.
        testbench.cb.addr <= 150;
        testbench.cb.en <= 1;
        testbench.cb.wr_en <= 1;
        testbench.cb.data_in <= 100; // Data should be written right now.
		
      @(testbench.cb);
        // Writing is now de-asserted, perfect time for us to check on the data_out val.
        testbench.cb.wr_en <= 0;
      
      repeat(2) @(testbench.cb); // Waiting for two cycles.
        assertion1: assert(testbench.cb.data_out == 100)
          $display("Assert succesful %t", $time);
        else
          $error("Assert failed %t", $time);
      $finish;
    end
endmodule

module top;
    bit clk = 0;
    always #5 clk = ~clk; // 10ns cycle time.

    int_f memory_interface(clk);
    mem DUT(memory_interface.dut);
    simple_tb tb(memory_interface.tb);

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
    end
endmodule