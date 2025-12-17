`timescale 1ns / 1ps
// Ternary operator: (condition) ? true_value : false_value
module mux2to1 #(
    parameter WIDTH = 8  
) (
    input  logic [WIDTH-1:0] in0,   // Input 0
    input  logic [WIDTH-1:0] in1,   // Input 1
    input  logic             sel,   // Select signal
    output logic [WIDTH-1:0] out    // Output
);

    // Ternary operator: if sel==1, choose in1, else choose in0
    assign out = sel ? in1 : in0;
    
    // Alternative syntax (explicit if-else):
    // always_comb begin
    //     if (sel)
    //         out = in1;
    //     else
    //         out = in0;
    // end

endmodule