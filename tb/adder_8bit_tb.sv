module adder_8bit_tb;

    logic [7:0] a, b, sum;
    logic carry_in, carry_out;
    
    
    logic [8:0] expected;  // 9 bits to include carry

    // Instantiate DUT
    adder_8bit dut (
        .a(a),
        .b(b),
        .carry_in(carry_in),
        .sum(sum),
        .carry_out(carry_out)
    );

    task test_addition(input [7:0] val_a, val_b, input c_in);
        begin
            a = val_a;
            b = val_b;
            carry_in = c_in;
            #10;  
            
            // Calculate expected result
            expected = val_a + val_b + 9'(c_in);            
            // Check if actual matches expected
            if ({carry_out, sum} !== expected) begin
                $display("ERROR at time %0t:", $time);
                $display("  %d + %d + %d = %d (expected %d)", 
                         val_a, val_b, c_in, {carry_out, sum}, expected);
            end else begin
                $display("PASS: %d + %d + %d = %d", 
                         val_a, val_b, c_in, {carry_out, sum});
            end
        end
    endtask

    initial begin
        $display("8-bit Adder Test");
        $display("================\n");
        
        // Test cases
        test_addition(8'd0, 8'd0, 1'b0);        // 0 + 0
        test_addition(8'd5, 8'd3, 1'b0);        // 5 + 3
        test_addition(8'd255, 8'd1, 1'b0);      // Overflow: 255 + 1
        test_addition(8'd128, 8'd128, 1'b0);    // Overflow: 128 + 128
        test_addition(8'd100, 8'd50, 1'b1);     // With carry_in
        
        $display("\nAll tests complete!");
        $finish;
    end

    // Waveform 
    initial begin
        $dumpfile("sim/adder_8bit.vcd");
        $dumpvars(0, adder_8bit_tb);
    end

endmodule