`timescale 1ns/1ps
module register_8bit #(
    parameter WIDTH = 8
) (
    input  logic             clk,
    input  logic             rst_n,
    input  logic             en,        // Enable signal (load control)
    input  logic [WIDTH-1:0] d,
    output logic [WIDTH-1:0] q
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= '0;  // '0 = all bits zero (shorthand for {WIDTH{1'b0}})
        else if (en)
            q <= d;   // Only load when enabled
        // else: q holds previous value 
    end

endmodule