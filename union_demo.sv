//A struct groups fields together, and its total size is the sum of all its elements.
// A union, by contrast, overlays all its members onto the exact same memory location,
// Its total size is simply the size of its single largest member.


// In this example, f is 64-bits, while i is 32-bits, since both share the same memory, i's 32-bits lie in the lower 32-bits of f's 64 bits.
module unions;
    typedef union {int i; real f;} number;

    number num;
    initial begin
        num.f = 3.14;
        $display("i: %0d ,f: %f", num.i, num.f);
    end
endmodule