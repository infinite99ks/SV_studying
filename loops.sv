// Playing around with loops cause why not :)
module testing_loops;
  
  bit [31: 0] src[5];
  bit [31: 0] dst[5];
  
  initial begin
    // A simple for-loop.
    for(int i = 0; i < 5; i++) begin
      src[i] = i;
    end
    $display("Using a simple for-loop: %p", src);
    
    // Using a for each loop.
    foreach(dst[i]) begin
      dst[i] = src[i] << 1; // Multiplying by 2.
    end
    $display("Using foreach loops in SV. SRC: %p DST:%p", src, dst);
    
    // displaying all.
    foreach(src[i]) begin
      $display("Element %0d: %0d", i, src[i]);
    end
    $finish;
  end
 
endmodule