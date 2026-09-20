// Playing with multidimensional loops.
module multi_loop;
    int vars[5] [10]; // A default value of 0, zero-indexed.
    
    initial begin
        
        // Filling our matrix.
        foreach(vars[i, j]) begin
            $display("Current i:%0d, Current j: %0d", i, j);
            vars[i] [j] = (10*i) + j;
        end


        // Displaying elements inside our matrix.
        foreach(vars[i]) begin
            $display("Current Row: %0d", i);
            foreach(vars[,j]) begin // Looping inside our second index.
                $display("vars[%0d][%0d] = %0d", i, j, vars[i][j]);
            end
        end
    end

endmodule