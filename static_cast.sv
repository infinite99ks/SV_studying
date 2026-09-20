module static_cast;
  int value;
  initial begin
    value = int'(10.4-9);
    $display("Value = %0d", value);
  end
endmodule