module packed_structs;
// Instead of each element occupying a 32-bit word owing to tool optimzations, each element contains the number of bits it's supposed to.
// Allowing us to do proper slicing.
    typedef struct packed {
        bit[7: 0] red;
        bit[7: 0] green;
        bit[7: 0] blue;
    } example;

    example exm, exm_2;
    initial begin
        exm = 32'hA0F232;
        exm_2 = '{
            red: 8'hA0,
            green: 8'h11,
            blue: 8'h12
        };
        $display("Red: %02X, Green: %02X, Blue: %02X", exm.red, exm.green, exm.blue);
        $display("Red: %02X, Green: %02X, Blue: %02X", exm_2.red, exm_2.green, exm_2.blue);
    end
endmodule