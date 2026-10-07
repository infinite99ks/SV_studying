program test; // Playing around with classes and random vars.
// Randomizing values alone may not cover ever single aspect of our design,
// thus we are randomizing the transaction itself.
// And speaking of transactions, let's make a packet class.
// Classes in of themselves are pretty easy to make, just wrap your class in
// class name and endclass and you're good to go.
// Within these constraints (foreshadowing) you can type in your vars AND (behold) constraints.
    class packet;
        rand bit[31: 0] src, dst, data[8]; // Random variables.
        randc bit [7:0] kind;

        // Limit the values for src.
        constraint c {src > 10;
                    src < 15;}
    endclass

    packet pac;
    initial begin
        pac = new(); // Created a new packet.
        assert(pac.randomize())
        else $fatal(0, "Packet::Randomize failed");
        $display(pac);
    end

endprogram