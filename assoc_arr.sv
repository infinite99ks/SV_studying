module associative_arr;
  int arr[string];
  initial begin
    // Works kinda like dictionaries in python, really intuitive.
    arr["mario_odyssey_metacritic"] = 97; // You're goddamn right.
    $display("Super Mario Odyssey's Metacritic score landed at a %0d.", arr["mario_odyssey_metacritic"]);
  end
endmodule