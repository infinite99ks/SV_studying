module dynamic_arrs;
    int arr_1[];
    int arr_2[];

    initial begin
        arr_1 = new [5];
        // Filling the array using a for-each loop.
        foreach(arr_1[i]) arr_1[i] = i;

        arr_2 = arr_1; // Allocates separate memory, then copies the contents of arr_1 into it.
        arr_2[0] = 2; // To further prove that, changing the index 0 in arr_2 shouldn't affect arr_1.
        $display("arr_1: %p", arr_1);
        $display("arr_2: %p", arr_2);

        arr_1 = new[20](arr_1); // Making a new 20-element array, and via the constructor we copy our existing elements.
        $display("arr_1 size: ", arr_1.size());

        // You can also re-allocate memory without copying over any elements, simply drop the parenthesis.
        // Now to delete our array simply use .delete().
        arr_1.delete();
        $display("arr_1's size after deletion: %p", arr_1.size());
    end
endmodule