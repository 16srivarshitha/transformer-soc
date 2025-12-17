`timescale 1ns/1ps
module dff (
    input  logic clk,      // Clock signal
    input  logic rst_n,    // Active-low reset (n = negative/low)
    input  logic d,        // Data input
    output logic q         // Data output (registered)
);

    // Sequential logic block
    // Triggers on positive edge of clk OR negative edge of rst_n
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= 1'b0;  // Async reset: immediately set output to 0
        else
            q <= d;     // On clock edge: capture input
    end

endmodule