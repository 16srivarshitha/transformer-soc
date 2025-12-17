`timescale 1ns/1ps
module mux4to1 #(
    parameter WIDTH = 8
) (
    input  logic [WIDTH-1:0] in0, in1, in2, in3,
    input  logic [1:0]       sel,  // 2-bit selector (00, 01, 10, 11)
    output logic [WIDTH-1:0] out
);

    // always_comb: combinational logic block
    always_comb begin
        case (sel)
            2'b00:   out = in0;  // When sel==0, output in0
            2'b01:   out = in1;
            2'b10:   out = in2;
            2'b11:   out = in3;
            default: out = {WIDTH{1'bx}};  // X for invalid (catches bugs)
        endcase
    end

endmodule