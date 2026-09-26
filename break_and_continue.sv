module break_and_continue;
    initial begin
        bit [127: 0] inst;
        int file, c;
        file = $fopen("b_a_c.txt", "r");
        while(!$feof(file)) begin
            $fscanf(file, "%s", inst);
            case(inst)
                "": continue;
                "done": break;
            endcase
            $display("%s", inst);
        end
        $fclose(file);
    end
endmodule