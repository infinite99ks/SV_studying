module ops_reduce;
  // We got special methods for arrays alongside reductions methods.
  // The catch with those reduction methods is that they return the same width expresson,
  // Meaning that they would need type casting in order to function properly.
  // Let's start with a simple example.
  bit [1: 0] on[10];
  int sum;
  initial begin
    foreach(on[i]) begin
      on[i] = i;
    end
    
    $display("Improper sum: %0d.", on.sum());
    $display("Proper sum: %0d", on.sum() with (int'(item))); // Casting every element onto an int.
    
  end
endmodule