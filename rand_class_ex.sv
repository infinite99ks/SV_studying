class Stim;
    const bit [31: 0] CONGEST_ADDR = 42;
    typedef enum {READ, WRITE, CONTROL} stim_e;
    randc stim_e kind;
    rand bit [31: 0] len, src, dst;
    randc bit congestion_bit;

    constraint c_stim{
        len < 1000;
        len > 0;
        if(congestion_bit) {
            dst inside {[CONGEST_ADDR+50:CONGEST_ADDR+100]};
            src == CONGEST_ADDR; // You can't do assignment via = in here, you must use ==.
        } else {
            src inside {0, [2:10], [100:107]};
        }
    }
endclass

program test;
    Stim s;
    initial begin
        s = new();
        for(int i = 1; i<=5; i++) begin
            assert(s.randomize())
            else $fatal("Problem");
          $display("%p", s);
        end
    end
endprogram