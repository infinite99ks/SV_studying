module pass_by_ref;
    typedef int dyn_arr[]; 

    // Don't forget to use word automatic or the thing is gonna throw a tantarum.
    function automatic void initialize(ref int arr[]);
        for(int i = 0; i < arr.size(); i++) begin
            arr[i] = i;
        end
    endfunction

        dyn_arr mario = new [5];
    initial begin
        $display("Array: %p", mario);
        initialize(mario);
        $display("Array: %p", mario);
    end
endmodule