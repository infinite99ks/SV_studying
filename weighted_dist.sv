class weighted;
    rand int src, dst;
    constraint c_dist{
        src dist {0 := 40, [1:3] := 60};
        // 0 should appear 40/(40+60+60+60) of the time.
        // values from 1 to 3, each should appear 60/(60+60+60+40) of the time.

        dst dist {0:/40, [1:3]:/60};
        // dst 0, weight 40/100.
        // dst 1, weight 20/100.
        // dst 2, weight 20/100.
        // dst 2, weight 20/100.
    }
endclass

program test;
    weighted s;
    initial begin
        s = new();
        for(int i = 0; i<=10; i++) begin
            assert(s.randomize()) else
            $fatal(0, "problem");
            $display("%p", s);
        end
    end
endprogram