module adder_8bit #(
    parameter WIDTH = 8  
) (
    input  logic [WIDTH-1:0] a,        
    input  logic [WIDTH-1:0] b,        
    input  logic             carry_in, 
    output logic [WIDTH-1:0] sum,      
    output logic             carry_out 
);

    // carry[0] is carry_in, carry[WIDTH] is carry_out
    logic [WIDTH:0] carry;
    
    // Connect input carry to first stage
    assign carry[0] = carry_in;
    
    // Generate loop: creates WIDTH full adders
    genvar i;
    generate
        for (i = 0; i < WIDTH; i++) begin : adder_stage
            
            full_adder fa (
                .a(a[i]),           
                .b(b[i]),           
                .carry_in(carry[i]), 
                .sum(sum[i]),       
                .carry_out(carry[i+1]) 
            );
        end
    endgenerate
    
    // Final carry out
    assign carry_out = carry[WIDTH];

endmodule