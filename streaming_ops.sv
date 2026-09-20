// The basic roles, >> Left-to-right streaming.
// << Right-to-left streaming, useful for reversal.
module streaming_ops;
    byte a, b, c, d;
    int val, re_val, bit_val;

    initial begin
        a = 8'hA1;
        b= 8'hB1;
        c= 8'hC1;
        d= 8'hD1;

        val = { >> {a, b, c, d}};
        re_val = { << 4 {a, b, c, d} };
        bit_val = {<< {a, b, c, d}};

        $display("Value: %b. Re_Val: %b. Bit_Val: %4b", val, re_val, bit_val);
    end
endmodule