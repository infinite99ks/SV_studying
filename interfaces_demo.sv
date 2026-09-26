// Decade Counter (input clk, MR, load, input[3: 0] P, input en, output [3: 0] Q);
interface dcd_int(input bit CLK);
    logic [3: 0] Q, P;
    logic MR, load, en;
endinterface

module dcd_counter(dcd_int inst);
    always@(posedge inst.CLK or negedge inst.MR) begin
        if(!inst.MR) begin
            inst.Q <= 'b0;
        end else begin
            if(inst.load) begin
                inst.Q <= inst.P;
            end
            else if(inst.en) begin
                inst.Q <= (inst.Q+1) % 10;
            end
        end
    end
endmodule

// A random ass testbench, don't give it much attention, not representative of my skills either lmao.
module dcd_test(dcd_int inst);
    initial begin
        inst.MR <= 0;
        @(negedge inst.CLK);
        inst.MR <= 1'b1;
        inst.load <= 1'b1;
        inst.P <= 4'b0111;
        @(negedge inst.CLK);
        inst.MR <= 'b0;
        @(negedge inst.CLK);
        inst.MR <= 1'b1;
        inst.load <= 'b0;
        inst.en <= 1'b1;
        @(negedge inst.CLK);
        @(negedge inst.CLK);
        @(negedge inst.CLK);
        inst.en <= 'b0;
        $finish;
    end
endmodule

module top;
    bit clk; // Default value of zero.
    always #5 clk = ~clk;
    
    dcd_int inter(clk);
    dcd_counter counter(.inst(inter));
    dcd_test test(.inst(inter));

    initial begin
        $dumpfile("counter.vcd");
        $dumpvars;
    end
endmodule