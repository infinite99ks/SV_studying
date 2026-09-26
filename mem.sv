module memory(
    input clk,
    input rst_n,
    input en,
    input [31: 0] data_in,
    input [3: 0] addr,
    input wr_en,    // No read-enable as writing is the destructive process and should take precedence.
    output reg [31: 0] data_out,
    output reg valid_out
    );
    
    reg[31: 0] mem [0:15]; // Our "memory" modeled as an array of regs.
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            data_out <= 'b0;
            valid_out <= 'b0;
        end
        else if(en) begin
            if(wr_en) begin
                mem[addr] <= data_in;
                valid_out <= 'b0;
            end else begin
                data_out <= mem[addr];
                valid_out <= 1'b1;
            end
        end   
        else begin
            data_out <= 'b0;
            valid_out <= 'b0;
        end 
    end
endmodule