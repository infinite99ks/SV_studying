module array_ops;
// Comparing and copying arrays...
int arr_1[3] = '{1,2,3};
int arr_2[3];
bit [31: 0] bits [5] = '{5{32'd5}}; // 5 rows of 5 decimal in 32 bits.

initial begin
     $display("Trying assignment.");
    arr_2 = arr_1;
    if(arr_1 == arr_2) begin
        $display("Assignment succesful");
    end

    // Altering one element.
    arr_1[0] = 0;
    
    // Doing a slice comparison.
    if(arr_1[1: 2] == arr_2[1: 2]) begin
        $display("gowdaym");
    end

    $displayb("Full word: ", bits[0]);
    $displayb("The LSB: ", bits[0][0]);
    $displayb("Bits 2:1", bits[0][2:1]);
end


endmodule