class buss_op;
    typedef enum {BYTE, WORD, LWORD} length_e;
    rand length_e len;

    bit[31: 0] w_byte = 1, w_word = 3, w_lword = 5;

    constraint c_len{
        len dist { BYTE := w_byte,
        WORD := w_word,
        LWORD := w_lword
        };
    }
endclass

module test_op;
    buss_op op;

    initial begin
        op = new();
        for(int i = 1; i<= 10; i++) begin
            $display(" ");
            for(int j = 1; j <= 10; j++) begin
                assert(op.randomize());
                $write(op.len.name,", ");
            end
        end
    end
endmodule