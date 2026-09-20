module assoc_methods;
  bit[32: 0] bits[int];
  int idx;
  
  initial begin
    bits[10] = 20;
    bits[500] = 1000;
    bits[1000] = 2000;
    
    if(bits.first(idx)) begin
      do begin
        $display("Found key %0d -> value %0d", idx, bits[idx]);
      end while (bits.next(idx));
    end
    
    if(bits.first(idx)) begin
      bits.delete(idx);
      bits.next(idx);
    end
    $display("Entries remaining after delete: %0d", bits.num());
    $finish;
  end
endmodule