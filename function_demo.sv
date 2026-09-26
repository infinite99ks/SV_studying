module function_demo;
    // In here we are making a function that would display the checksum of array elements.
    function automatic void checksum (const ref bit[31: 0] a[]);
        // A dynamic array so we can get the size right away.
        bit [31: 0] checksum = 'b0;

        for(int i = 0; i < a.size(); i++) begin
            checksum ^= a[i];
        end
        $display("The checksum equals: %b", checksum);
    endfunction

    initial begin
                            // 011, 01010, 01100.
        bit[31: 0] array[]  = '{3, 10 , 12};
        checksum(array);
    end
endmodule