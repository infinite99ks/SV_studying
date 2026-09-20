module associative_arr;
  bit [31: 0] playin [int];
  int index;
  initial begin
    index = 1;
    repeat(20) begin
      playin[index] = index*3;
      index = index << 1; // Multiplying by 2 each time.
    end
    
    foreach(playin[i]) begin
      $display("Index: %0d, Value: %0d.", i, playin[i]);
    end
    
  end
endmodule