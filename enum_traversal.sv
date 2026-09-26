module enum_traversal;
    typedef enum {RED = 1, GREEN = 2, BLUE = 3} colors;

    colors p_color;
    initial begin
        p_color = p_color.first();
        do begin
            $display("Current Color Num: %d, Current Color Name: %s", p_color, p_color.name);
            p_color = p_color.next();
        end
        while (p_color != RED);
    end
endmodule