module typedef_demo;
    // Typedef's are really handy as they allow us to devise 'new' data types using existing ones.
    typedef logic[7: 0] byte_t;
    typedef bit[31: 0] uint32_t;
    typedef int fixed_5_t[5]; // Array of 5 integers.

    byte_t bus;
    uint32_t transaction_count;
    fixed_5_t scores;

    initial begin
        $display("data_bus (4-states): %b", bus);
        $display("transaction count (2-states): %b", transaction_count);
        foreach(scores[i]) scores[i] = i*2;
        $display("Scores: %p", scores);
    end

endmodule